


cmd <- paste0("gunzip lex_data/", list.files("lex_data", pattern = ".csv.gz"))

purrr::walk(cmd, system)

file.remove(file.path("lex_data", list.files("lex_data", pattern = ".csv.gz")))

file.remove(file.path("lex_data", list.files("lex_data", pattern = "state")))


