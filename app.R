
# load your libraries
library(shiny)

# read in your files (make sure to double check path)
source("app_ui.R")
source("app_server.R")

# Run the application 
shinyApp(ui = ui, server = server)
