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
  "Introduction",
  h1("Welcome to our project"),
  fluidPage(
      h1("Introduction"),
p("For our interactive dataset research project our group decided to research mental health statistics
due to COVID-19. Given the unprecedented times we are living in there has been an increase in mental health awareness.
This dataset has provided us unique questions that allow us to see how people are reacting to the Covid pandemic during their daily life. 
Questions that measure the amount of time people communicate with their family/friends, rating one’s mental health from excellent to poor, and using 
their gender as a means of comparison this data gives us an insight on how COVID-19 has impacted our mental health before the pandemic and during.
Now more than ever are we more aware of taking care of one's mental health and we can use this data to better understand Covid’s affect on individuals."),
img(src = "https://media.giphy.com/media/FDZdbl2FjfoULzLH12/giphy.gif"),
p(strong("By: Toby Theodros, Nicole Nobbay and Jimena Talamantes"))
    )
    )


page_two <- tabPanel(
  "Barchart",
  sidebarLayout(
    sidebarPanel(
      questions_covid,
      colors_var
    ),
    mainPanel(
      plotOutput("Barchart"),
      p(strong("KEY")),
      p("In this chart we are comparing people’s responses on how often 
        they talked to their neighbors before and during COVID-19"),
      p("Question 1 asked the question “How often did you talk to your neighbors?"),
      p("Question 2 asks “How often did you talk to your neighbors during COVID-19?"),
      p("Question 3 asks “How often did you stay in touch with your family and friends during quarantine?"),
      p("Question 4 asks “How often did you stay in touch with your family and friends BEFORE COVID-19?"),
    )
  )
)

page_three <- tabPanel(
  "Histogram",
  sidebarLayout(
    sidebarPanel(
      genders,
      colors_var2
    ),
    mainPanel(
      plotOutput("Histogram"),
    p("When you select Male look at the chart where it says 1"),
    p("When you select Female look at the chart where it says 1"),
    p("Depending on which table you want to look at on the other side you 
    will see the comparision versus the other gender")
    )
  ))

page_four <- tabPanel(
  "Scatterplot",
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      plotOutput("Scatterplot"),
      p(strong("KEY")),
      p("1 = Excellent"),
      p("2 = Very good"),
      p("3 = Good"),
      p("4 = Fair"),
      p("5 = Poor"),
      p("6 = Do not know"),
    )
  )
)

sum_page <- tabPanel(
  "Summary Takeaways",
   fluidPage(
    h1("Summary"),
    p("For our barchart we thought it was important to include this data because it demonstrates how more people reached out to their friends and family 
when the pandemic started compared to when life was “normal”. 
An interesting observation we made was that the number of people who talked to their family and friends “Basically every day” increased greatly once Covid began, and
people who only talked to their family and friends “A few times a week” decreased. 
We think there was a decrease because those people who used to be in the “A few times a week” category likely began communicating with friends and family more consistently."),
p("In our histogram, we wanted to showcase the similarities between each gender and their personal ratings for their mental health. 
This histogram is organized and clear in a manner that reflects a pattern of a high number of “Very Good” and “Good” ratings across both males and females. 
The purpose of this chart is to break down the data set from one question to gather insight about how males and females have viewed their level of mental health.
Some notable observations and insights from the chart include the evidence of how most males and females rated their level of mental health as “Very Good”."),
p("In our scatterplot we wanted to answer the question how does the size of a household affect how people rate their mental health. 
This chart is important because it shows how much having another person in your household affects the way you are feeling mentally.
The scatterplot shows that the bigger the bubble is the more people that are in the category.
The column that shows us the most clear evidence of covid’s impact on people who live by themselves is the people who feel “poor” column.
As the number of people in a household increases the less people say that they feel “poor”.
")
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

