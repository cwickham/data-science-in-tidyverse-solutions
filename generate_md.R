# Generate all github versions of solutions
library(purrr)
library(here)

sol_files <- dir(here(), pattern = "solutions.Rmd")
walk(sol_files, rmarkdown::render, output_format = "github_document")
