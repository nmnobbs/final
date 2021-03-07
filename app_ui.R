## UI File
# Load the libraries------------------------------------------------------------

library(shiny)
library(tidyverse)

# Read in the data set----------------------------------------------------------

source("app_server.R")

# Define Widgets----------------------------------------------------------------

# Define structure of tabs------------------------------------------------------

intro_page <- tabPanel(
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

page_four <- tabPanel(
  "Fourth Tab",
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
    )
  )
)

sum_page <- tabPanel(
  "Summary Takeaways",
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
    )
  )
)

# Define the UI-----------------------------------------------------------------

ui <- navbarPage(
  "Final Project",
  intro_page,
  page_two,
  page_three,
  page_four,
  sum_page
)