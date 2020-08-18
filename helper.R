

file.remove(file.path("lex_data", list.files("lex_data", pattern = ".csv.gz")))

cmd <- paste0("gunzip lex_data/", list.files("lex_data", pattern = "county_lex"))

purrr::walk(cmd, system)
