
library(tidyverse)


data <- read_csv(here::here("data",
                            "monthly-metro-housing-data.csv"))



rent_vs_homeprice <- function(df,
                              city_name) {
  
  
  p <- df %>% 
    ungroup() %>% 
    filter(RegionName == city_name) %>% 
    select(month, rent_index, zhvi_index) %>% 
    gather(key = "housing_type", value = "index", -month) %>% 
    ggplot(aes(x = month, y = index,
               group = housing_type, color = housing_type)) +
    geom_line() +
    geom_vline(xintercept = ymd("2020-02-01")) +
    scale_color_discrete(labels = c("Rent",
                                    "Home prices")) +
    theme_minimal() +
    theme(legend.position = "top") +
    labs(x = NULL, y = NULL, color = NULL,
         title = city_name)
  
  ggsave(here::here("figures",
                    str_glue("rent_home_price_{city_name}.png")),
         width = 3.5,
         height = 3)

  print(p)
}

data %>% 
  rent_vs_homeprice(city_name = "New York, NY")

data %>% 
  rent_vs_homeprice(city_name = "Washington, DC")

data %>% 
  rent_vs_homeprice(city_name = "Albany, NY")
