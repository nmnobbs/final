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


#Code for Barchart

data_items <- dataset3 %>% 
  select(`1`:`4`) %>%
  na.omit 

Barchart <- data_items %>%  
  gather(key = Questions, value = Responses) %>% 
  mutate(Responses = factor(Responses)) %>% 
  ggplot(aes(x = Questions)) + 
  geom_bar(aes(fill = Responses), position = "fill") -> interactions
interactions + scale_fill_brewer(palette = "Spectral")


dataset3 <- dataset2 %>% 
  select( `talk with neighbor in month` : `how often did you stay in touch with family/friend before covid`)
dataset3$`talk with neighbor in month` <- as.character(dataset3$`talk with neighbor in month`)
dataset3[dataset3 == "(1) Basically every day"] <- "Basically every day"
dataset3[dataset3 == "(2) A few times a week"] <- "A few times a week"
dataset3[dataset3 == "(3) A few times a month"] <- "A few times a month"
dataset3[dataset3 == "(4) Once a month"] <- "Once a month"
dataset3[dataset3 == "(5) Not at all"] <- "Not at all"
dataset3[dataset3 == "(98) SKIPPED ON WEB"] <- "Skipped on web"
dataset3[dataset3 == "(77) Not sure"] <- "Not sure"
dataset3$`talk with neighbor in month` <- as.factor(dataset3$`talk with neighbor in month`)

names(dataset3)[names(dataset3) == "talk with neighbor in month"] <- "1"
names(dataset3)[names(dataset3) == "talk with neighbor in month before covid"] <- "2"
names(dataset3)[names(dataset3) == "how often did you stay in touch with family/friends"] <- "3"
names(dataset3)[names(dataset3) == "how often did you stay in touch with family/friend before covid"] <- "4"
      
#Code for Histogram
dataset_3 <- dataset2 %>%
  select(`how would you rate your health`, gender) %>%
  filter(`how would you rate your health` != "(98) SKIPPED ON WEB") %>%
  filter(gender != "(98) SKIPPED ON WEB") %>%
  filter(`how would you rate your health` != "(77) DON'T KNOW")

dataset_3$`how would you rate your health` <- as.character(dataset_3$`how would you rate your health`)
dataset_3[dataset_3 == "(1) Excellent"] <- "Excellent"
dataset_3[dataset_3 == "(2) Very good"] <- "Very Good"
dataset_3[dataset_3 == "(3) Good"] <- "Good"
dataset_3[dataset_3 == "(4) Fair"] <- "Fair"
dataset_3[dataset_3 == "(5) Poor"] <- "Poor"
dataset_3$`how would you rate your health` <- as.factor(dataset_3$`how would you rate your health`)

names(dataset_3)[names(dataset_3) == "how would you rate your health"] <- "Mental Health Rating"

Histogram <- ggplot(data = dataset_3, mapping = aes(x = `Mental Health Rating`, fill = `Mental Health Rating`)) + 
  geom_histogram(binwidth = 1, stat = "count") +
  labs(x = "Level of Mental Health", y = "Amount of Responses") +
  facet_wrap(~gender, labeller = "label_both") 

# Code For Scatterplot

dataset2 <- dataset %>%  select(`how much do you trust your neighborhood`:`how would you rate your health`, gender , race, RACE_R2 , EDUCATION, `household size`, P_GEO)
chart3 <- dataset2 %>% 
  filter(`how would you rate your health` !=  "(98) SKIPPED ON WEB") %>% 
  filter(`household size` != "(99) REFUSED") %>% 
  filter(`household size` != "(98) SKIPPED ON WEB")

Scatterplot <- ggplot(data = chart3) +
  geom_count(mapping = aes(x= `how would you rate your health`, y = `household size`))

