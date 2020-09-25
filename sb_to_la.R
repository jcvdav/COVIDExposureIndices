
fxn <- function(file, from, to) {
  read.csv(file, stringsAsFactors = F) %>% 
    filter(COUNTY_PRE == from) %>% 
    mutate(date = file) %>% 
    select(date, exp_la = to)
}

files <- paste0("lex_data/", list.files("lex_data", pattern = "county_lex"))

plan(multiprocess)

data <- furrr::future_map_dfr(files, fxn, from = 6083, to = "X06037")

holidays <- c("2020-05-23", "2020-06-12","2020-07-03") %>% 
  lubridate::ymd()

data %>% 
  mutate(date = str_remove_all(date, "lex_data/county_lex_|.csv"),
         date = lubridate::ymd(date)) %>% 
  ggplot(aes(x = date, y = exp_la)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept = holidays) +
  labs(x = "Date", y = "County-level location exposure index (LEX)",
       title = "Exposure of SB county to LA county",
       subtitle = "Data are from: https://github.com/COVIDExposureIndices/COVIDExposureIndices",
       caption = "Among smartphones that pinged in SB on a given date, what share of those devices\npinged in LA county at least once during the previous 14 days?") +
  theme_bw()

tahoe_la_data <- furrr::future_map_dfr(files, fxn, from = 6017, to = "X06037")

tahoe_la_data %>% 
  mutate(date = str_remove_all(date, "lex_data/county_lex_|.csv"),
         date = lubridate::ymd(date)) %>% 
  ggplot(aes(x = date, y = exp_la)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept = holidays) +
  labs(x = "Date", y = "County-level location exposure index (LEX)",
       title = "Exposure of Tahoe county to LA county",
       subtitle = "Data are from: https://github.com/COVIDExposureIndices/COVIDExposureIndices",
       caption = "Among smartphones that pinged in SB on a given date, what share of those devices\npinged in LA county at least once during the previous 14 days?") +
  theme_bw()

tahoe_df_data <- furrr::future_map_dfr(files, fxn, from = 6017, to = "X06075")

tahoe_df_data %>% 
  mutate(date = str_remove_all(date, "lex_data/county_lex_|.csv"),
         date = lubridate::ymd(date)) %>% 
  ggplot(aes(x = date, y = exp_la)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept = lubridate::ymd("2020-08-14")) +
  labs(x = "Date", y = "County-level location exposure index (LEX)",
       title = "Exposure of Tahoe (El Dorado) county to SF county",
       subtitle = "Data are from: https://github.com/COVIDExposureIndices/COVIDExposureIndices",
       caption = "Among smartphones that pinged in SB on a given date, what share of those devices\npinged in LA county at least once during the previous 14 days?") +
  theme_bw()
