
fxn <- function(file) {
  read.csv(file, stringsAsFactors = F) %>% 
    filter(COUNTY_PRE == 6083) %>% 
    mutate(date = file) %>% 
    select(date, exp_la = X06037)
}

files <- paste0("lex_data/", list.files("lex_data", pattern = "county_lex"))

plan(multiprocess)

data <-  furrr::future_map_dfr(files, fxn)

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
