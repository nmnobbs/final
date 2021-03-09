## UI File
# Load the libraries------------------------------------------------------------

library(shiny)
library(tidyverse)

# Read in the data set----------------------------------------------------------

source("app_server.R")

# Define Widgets----------------------------------------------------------------

colors_var <- selectInput(
  inputId = "color_var", label = "Choose Color",
  choices = c(
    "Red", "Blue", "Green", "Purple", "Pink",
    "Brown"
  )
)

colors_var2 <- selectInput(
  inputId = "colors_var2", label = "Choose Color",
  choices = c(
    "Dark2", "Accent", "Greens", "Set3", "Pastel1",
    "Spectral"
  )
)

questions_covid <- selectInput(
  inputId = "questions", label = "Choose Question",
  choices = c(
    "1", "2", "3", "4")
)

genders <- selectInput(
  inputId = "gender_var", label = "Choose Gender",
  choices = c(
    "Male", "Female")
)
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
    sidebarPanel(
      questions_covid,
      colors_var
    ),
    mainPanel(
      plotOutput("Barchart")
    )
  )
)

page_three <- tabPanel(
  "Third Tab",
  sidebarLayout(
    sidebarPanel(
      genders,
      colors_var2
    ),
    mainPanel(
      plotOutput("Histogram")
    )
  )
)

page_four <- tabPanel(
  "Fourth Tab",
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      plotOutput("Scatterplot")
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
