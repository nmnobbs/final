# Load the libraries
library(shiny)

# read in your files
source("app_ui.R")
source("app_server.R")

# Run the application 
shinyApp(ui = ui, server = server)