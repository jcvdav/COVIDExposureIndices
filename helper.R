
# Delete state data
file.remove(file.path("lex_data", list.files("lex_data", pattern = "state")))

# Identify gz files
cmd <- paste0("gunzip lex_data/", list.files("lex_data", pattern = ".csv.gz"))

# Extract gz files
purrr::walk(cmd, system)

# Delete remaining gz files
file.remove(file.path("lex_data", list.files("lex_data", pattern = ".csv.gz")))


