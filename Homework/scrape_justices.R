
justice_url <- "https://en.wikipedia.org/wiki/List_of_justices_of_the_Supreme_Court_of_the_United_States"
justice_table <- (justice_url %>%
                    read_html() %>%
                    html_nodes("table")) [[2]] %>%
  html_table(fill = TRUE)
write_csv(justice_table, "/Users/evandaisy/Applications/Git/Data-Science/Homework/justice.csv")

