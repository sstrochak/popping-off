

library(tidyverse)


data <- read_csv(here::here("data",
                            "monthly-county-combined-dataset.csv"))




# time to pending ---------------------------------------------------------


days <- data %>% 
  group_by(RegionName) %>% 
  mutate(missing_days = sum(is.na(days_to_pending))) %>% 
  filter(missing_days == 0)

highlight <- days %>% 
  filter(RegionName %in% c("Harrisburg, PA",
                           "Philadelphia, PA",
                           "Pittsburgh, PA",
                           "Allentown, PA"))

days %>% 
  ggplot(aes(x = month, y = days_to_pending,
             group = RegionName)) +
  geom_line(color = "lightgrey") +
  geom_line(data = highlight,
            aes(color = RegionName)) +
  geom_vline(xintercept = ymd("2020-02-01")) +
  theme_minimal() +
  labs(x = NULL, y = NULL, color = NULL,
       title = 'Median days between home being listed on Zillow and moving to "pending" status')

ggsave(here::here("figures",
                  "days-to-pending.png"),
       width = 7,
       height = 4)

summary_stats <- days %>% 
  group_by(month) %>% 
  summarize(avg_days = mean(days_to_pending),
            sd = sd(days_to_pending))


summary_stats %>% 
  gather(key = "statistic", value = "value", -month) %>%  
  ggplot(aes(x = month, y = value,
             group = statistic, color = statistic)) +
  geom_line() +
  scale_color_discrete(labels = c("Average",
                                  "Standard deviation")) +
  geom_vline(xintercept = ymd("2020-02-01")) +
  theme_minimal() +
  theme(legend.position = "top") +
  labs(title = "Average + SD of days to pending across MSAs",
       y = NULL, x = NULL,
       color = NULL)
ggsave(here::here("figures",
                  "summary-days-to-pending.png"),
       width = 7,
       height = 4)


summary_stats %>% 
  ggplot(aes(x = month, y = avg_days)) +
  geom_line() +
  theme_minimal() +
  labs(title = "Standard deviation of days to pending across MSAs",
       y = NULL, x = NULL)
ggsave(here::here("figures",
                  "sd-days-to-pending.png"))

# sales to list price ratio -----------------------------------------------


