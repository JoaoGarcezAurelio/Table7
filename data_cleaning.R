# Key packages for the app

#  install.packages("shiny") # For the shiny app
#  install.packages("bslib") # For certain shiny app traits
#  install.packages("readr") # For loading csv
#  install.packages("shinythemes") # For shiny themes
#  install.packages("thematic") # For consistence between layout and plots
#  install.packages("reactable") # For table
#  install.packages("reactablefmtr") # For table
#  install.packages("here") # For file management
#  install.packages("shinylive") # For github optimisation
#  install.packages("htmltools") # For the DOI links
#  install.packages("magrittr") # For the pipe (avoided tidyverse in case it makes it more difficult for shinyserver)
#  install.packages("dplyr") # For the mutate functions 

# Loading the packages

library(shiny) 
library(bslib)
library(readr)
library(shinythemes)
library(thematic)
library(reactable)
library(reactablefmtr)
library(here)
library(shinylive)
library(htmltools)
library(magrittr)
library(dplyr)


# Uploading the table

Table7 <- 
  read_csv(here("Data",
                "Processed Data",
                "Table7.csv"))

# Now I create the colour code I want the classification variable to have:

Table7 <- Table7 %>%
  mutate(
    Classification_colours = case_when(Classification == "High" ~ "darkgreen",
                                       Classification == "Low" ~ "red",
                                       TRUE ~ "orange")
  )

# Creating a tooltip option that will be used in the headers.

with_tooltip <- function(value, tooltip) {
  tags$abbr(style = "text-decoration: underline; text-decoration-style: dotted; cursor: help",
            title = tooltip, value)
}


# I will need a different DOI table for Table 6:

DOITable7 <- data.frame(
  Study_ID = c("13", "16", "10", "12", "17", "23", "29", "4", "10", "10", "29",
               "16", "8", "10", "17", "29","13","16","4","8","10","12","17","29",
               "13", "4", "11", "29"),
  DOI = c("Not available",
          "https://doi.org/10.1002/ajcp.12092",
          "https://doi.org/10.1080/02796015.2007.12087949",
          "https://doi.org/10.1007/s11121-017-0802-4",
          "https://doi.org/10.1007/s11121-018-0948-8",
          "https://doi.org/10.1080/02796015.2012.12087377",
          "https://doi.org/10.3310/phr06100",
          "https://doi.org/10.1037//0022-006x.67.5.648",
          "https://doi.org/10.1080/02796015.2007.12087949",
          "https://doi.org/10.1080/02796015.2007.12087949",
          "https://doi.org/10.3310/phr06100",
          "https://doi.org/10.1002/ajcp.12092",
          "http://dx.doi.org/10.1016/j.jsp.2014.07.001",
          "https://doi.org/10.1080/02796015.2007.12087949",
          "https://doi.org/10.1007/s11121-018-0948-8",
          "https://doi.org/10.3310/phr06100",
          "Not available",
          "https://doi.org/10.1002/ajcp.12092",
          "https://doi.org/10.1037//0022-006x.67.5.648",
          "http://dx.doi.org/10.1016/j.jsp.2014.07.001",
          "https://doi.org/10.1080/02796015.2007.12087949",
          "https://doi.org/10.1007/s11121-017-0802-4",
          "https://doi.org/10.1007/s11121-018-0948-8",
          "https://doi.org/10.3310/phr06100",
          "Not available",
          "https://doi.org/10.1037//0022-006x.67.5.648",
          "https://doi.org/10.1186/isrctn85087674",
          "https://doi.org/10.3310/phr06100"))
