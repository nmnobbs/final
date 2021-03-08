# Load the libraries-----------------------------------------------------------

library(shiny)
library(tidyverse)

# read in the data set----------------------------------------------------------


# 5 summary value information---------------------------------------------------


# Paragraphs of Text------------------------------------------------------------



# Charts------------------------------------------------------------------------


# Define the server-------------------------------------------------------------

server <- function(input, output) {
output$Barchart <- renderPlot({Barchart})
output$Histogram <- renderPlot({Histogram})
output$Scatterplot <- renderPlot({Scatterplot})
}

