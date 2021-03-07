## UI File
# Load the libraries------------------------------------------------------------

library(shiny)
library(tidyverse)

# Read in the data set----------------------------------------------------------

source("app_server.R")

# Define Widgets----------------------------------------------------------------

# Define structure of tabs------------------------------------------------------

page_one <- tabPanel(
  "Data Investigation",
  h1("First Page"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      h1("Introduction")
    )
  )
)

page_two <- tabPanel(
  "Second Tab",
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
    )
  )
)

page_three <- tabPanel(
  "Third Tab",
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
    )
  )
)

# Define the UI-----------------------------------------------------------------

ui <- navbarPage(
  "Final Project",
  page_one,
  page_two,
  page_three
)