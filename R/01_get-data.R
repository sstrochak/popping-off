
library(tidyverse)
# library(tigris)
library(lubridate)



# RENTS -------------------------------------------------------------------

rent <- read_csv("https://files.zillowstatic.com/research/public_v2/zori/Metro_ZORI_AllHomesPlusMultifamily_SSA.csv?t=1622125901")

rent <- rent %>% 
  select(-RegionID) %>% 
  gather(key = "month", value = "rent", -RegionName, -SizeRank) %>% 
  arrange(RegionName, month) %>% 
  group_by(RegionName) %>% 
  mutate(rent = as.numeric(rent),
         month = ymd(paste0(str_sub(month, 1, 7), "-01")),
         rent_yoy = (rent - lag(rent, 12)) / lag(rent, 12),
         rent_index = rent / rent[month == "2020-02-01"] * 100) %>% 
  filter(month >= "2018-01-01")

# ZHVI --------------------------------------------------------------------

zhvi <- read_csv("https://files.zillowstatic.com/research/public_csvs/zhvi/Metro_zhvi_uc_sfrcondo_tier_0.33_0.67_sm_sa_month.csv?t=1632497751")

zhvi <- zhvi %>% 
  select(-RegionID, -SizeRank, -RegionType, -StateName) %>% 
  gather(key = "month", value = "zhvi", -RegionName) %>% 
  arrange(RegionName, month) %>% 
  group_by(RegionName) %>% 
  mutate(zhvi = as.numeric(zhvi),
         month = ymd(paste0(str_sub(month, 1, 7), "-01")),
         zhvi_yoy = (zhvi - lag(zhvi, 12)) / lag(zhvi, 12),
         zhvi_index = zhvi / zhvi[month == "2020-02-01"] * 100) %>% 
  filter(month >= "2018-01-01")


# DAYS TO PENDING ---------------------------------------------------------

days <- read_csv("https://files.zillowstatic.com/research/public_csvs/med_doz_pending/Metro_med_doz_pending_uc_sfrcondo_month.csv?t=1632497751")

days <- days %>% 
  select(-RegionID, -SizeRank, -RegionType, -StateName) %>% 
  gather(key = "month", value = "days_to_pending", -RegionName) %>% 
  arrange(RegionName, month) %>% 
  mutate(month = ymd(paste0(str_sub(month, 1, 7), "-01")))


# LIST to SALES -----------------------------------------------------------

list <- read_csv("https://files.zillowstatic.com/research/public_v2/mlp/Metro_mlp_uc_sfrcondo_smoothed_month.csv?t=1622125901")

list <- list %>% 
  select(-RegionID, -SizeRank, -RegionType, -StateName) %>% 
  gather(key = "month", value = "median_list_price", -RegionName) %>% 
  arrange(RegionName, month) %>% 
  mutate(month = ymd(paste0(str_sub(month, 1, 7), "-01")))

sale <- read_csv("https://files.zillowstatic.com/research/public_v2/median_sale_price/Metro_median_sale_price_uc_SFRCondo_sm_sa_month.csv?t=1622125901")

sale <- sale %>% 
  select(-RegionID, -SizeRank, -RegionType, -StateName) %>% 
  gather(key = "month", value = "median_sale_price", -RegionName) %>% 
  arrange(RegionName, month) %>% 
  mutate(month = ymd(paste0(str_sub(month, 1, 7), "-01")))


# Combine -----------------------------------------------------------------

data <- rent %>% 
  tidylog::left_join(zhvi, by = c("RegionName", "month")) %>% 
  tidylog::left_join(days, by = c("RegionName", "month"))
  #tidylog::left_join(list, by = c("RegionName", "month")) %>% 
  # tidylog::left_join(sale, by = c("RegionName", "month")) %>% 
  #mutate(list_sale_difference = median_sale_price - median_list_price,
  #        list_sale_difference_ratio = list_sale_difference / median_list_price)


write_csv(data, here::here("data",
                           "monthly-metro-housing-data.csv"))
