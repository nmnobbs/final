# Load the libraries-----------------------------------------------------------

library(shiny)
library(tidyverse)

## Charts-----------------------------------------------------------------------

# Scatterplot

dataset2 <- dataset %>%  select(`how much do you trust your neighborhood`:
                `how would you rate your health`, gender , race, RACE_R2 ,
                EDUCATION, `household size`, P_GEO)
chart3 <- dataset2 %>% 
  filter(`how would you rate your health` !=  "(98) SKIPPED ON WEB") %>% 
  filter(`household size` != "(99) REFUSED") %>% 
  filter(`household size` != "(98) SKIPPED ON WEB")

Scatterplot <- ggplot(data = chart3) +
  geom_count(mapping = aes(x= `how would you rate your health`, y =
                             `household size`))

# Code for Barchart

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
  select( `talk with neighbor in month` :
            `how often did you stay in touch with family/friend before covid`,
          gender) %>%
  filter(gender != "(98) SKIPPED ON WEB") %>%
  filter(`talk with neighbor in month` != "(98) SKIPPED ON WEB")

dataset3$`talk with neighbor in month` <- as.character(dataset3$`talk with neighbor in month`)
dataset3[dataset3 == "(1) Basically every day"] <- "Basically every day"
dataset3[dataset3 == "(2) A few times a week"] <- "A few times a week"
dataset3[dataset3 == "(3) A few times a month"] <- "A few times a month"
dataset3[dataset3 == "(4) Once a month"] <- "Once a month"
dataset3[dataset3 == "(5) Not at all"] <- "Not at all"
dataset3[dataset3 == "(98) SKIPPED ON WEB"] <- "Skipped on web"
dataset3[dataset3 == "(77) Not sure"] <- "Not sure"
dataset3[dataset3 == "(1) Male"] <- "Male"
dataset3[dataset3 == "(2) Female"] <- "Female"
dataset3$`talk with neighbor in month` <-
  as.factor(dataset3$`talk with neighbor in month`)

names(dataset3)[names(dataset3) == "talk with neighbor in month"] <- "1"
names(dataset3)[names(dataset3) ==
                  "talk with neighbor in month before covid"] <- "2"
names(dataset3)[names(dataset3) ==
                  "how often did you stay in touch with family/friends"] <- "3"
names(dataset3)[names(dataset3) ==
      "how often did you stay in touch with family/friend before covid"] <- "4"

# Code for Histogram

dataset_3 <- dataset2 %>%
  select(`how would you rate your health`, gender) %>%
  filter(`how would you rate your health` != "(98) SKIPPED ON WEB") %>%
  filter(gender != "(98) SKIPPED ON WEB") %>%
  filter(`how would you rate your health` != "(77) DON'T KNOW")

dataset_3$`how would you rate your health` <-
  as.character(dataset_3$`how would you rate your health`)
dataset_3[dataset_3 == "(1) Excellent"] <- "Excellent"
dataset_3[dataset_3 == "(2) Very good"] <- "Very Good"
dataset_3[dataset_3 == "(3) Good"] <- "Good"
dataset_3[dataset_3 == "(4) Fair"] <- "Fair"
dataset_3[dataset_3 == "(5) Poor"] <- "Poor"
dataset_3$`how would you rate your health` <-
  as.factor(dataset_3$`how would you rate your health`)

names(dataset_3)[names(dataset_3) == "how would you rate your health"] <-
  "Mental Health Rating"

Histogram <- ggplot(data = dataset_3, mapping = aes(x = `Mental Health Rating`,
                                    fill = `Mental Health Rating`)) + 
  geom_histogram(binwidth = 1, stat = "count") +
  labs(x = "Level of Mental Health", y = "Amount of Responses") +
  facet_wrap(~gender, labeller = "label_both") 

# Define the server-------------------------------------------------------------

server <- function(input, output) {

output$Barchart <- renderPlot({
    chart_data <- dataset3
    colnames(chart_data) <- c(
      "1", "2", "3", "4", "gender"
    )
    
    bar <- ggplot(chart_data) +
      geom_bar(aes(x = dataset3[[input$questions]]), fill = input$color_var
      ) + facet_wrap(~gender, labeller = "label_both") +
      labs(x = "Answer to Question Asked", y = "Amount of Responses")
    
    bar
  })

output$Histogram <- renderPlot({

    third_c <- dataset_3 
    data.frame(gender = sample(c("Female", "Male"), 7494, replace = TRUE))
    third_c$Female = ifelse(third_c$gender == "(2) Female", 1, 0)
    third_c$Male = ifelse(third_c$gender == "(1) Male", 1, 0)
    
    histogram <- third_c %>%
      filter(Female != "0") %>%
      filter(Male != "0") %>%
       ggplot(data = third_c, mapping = aes(
      x =
        `Mental Health Rating`, fill = `Mental Health Rating`)) +
      geom_histogram(binwidth = 1, stat = "count") +
      labs(x = "Level of Mental Health", y = "Amount of Responses") +
      facet_wrap(third_c[[input$gender_var]], labeller = "label_value") +
      scale_fill_brewer(palette= input$colors_var2)
    
    histogram
    })
  
output$Scatterplot <- renderPlot({
  
  dataset2 <- dataset %>%  select(`how much do you trust your neighborhood`:
                  `how would you rate your health`, gender , race, RACE_R2 ,
                  EDUCATION, `household size`, P_GEO)
  chart3 <- dataset2 %>% 
    filter(`how would you rate your health` !=  "(98) SKIPPED ON WEB") %>%
    filter(`how would you rate your health` != "(77) DON'T KNOW") %>%
    filter(`household size` != "(99) REFUSED") %>% 
    filter(`household size` != "(98) SKIPPED ON WEB") %>%
    filter(`race` != "(98) SKIPPED ON WEB") %>%
    filter(`race` != "(99) REFUSED") %>%
    filter(`race` != "(88) Removed for disclosure risk") %>%
    filter(gender != "(98) SKIPPED ON WEB")
  
  chart3$gender <-
    as.character(chart3$gender)
  chart3[chart3 == "(1) Male"] <- "Male"
  chart3[chart3 == "(2) Female"] <- "Female"
  chart3$gender <-
    as.factor(chart3$gender)
  
  chart3$race <-
    as.character(chart3$race)
  chart3[chart3 == "(3) Hispanic"] <- "Hispanic"
  chart3[chart3 == "(1) White, non-Hispanic"] <- "White, non-Hispanic"
  chart3[chart3 == "(2) Black, non-Hispanic"] <- "Black, non-Hispanic"
  chart3[chart3 == "(4) Other, non-Hispanic"] <- "Other, non-Hispanic"
  chart3$race <-
    as.factor(chart3$race)
  
  chart3$`how would you rate your health` <-
    as.character(chart3$`how would you rate your health`)
  chart3[chart3 == "(1) Excellent"] <- "Excellent"
  chart3[chart3 == "(2) Very good"] <- "Very Good"
  chart3[chart3 == "(3) Good"] <- "Good"
  chart3[chart3 == "(4) Fair"] <- "Fair"
  chart3[chart3 == "(5) Poor"] <- "Poor"
  chart3$`how would you rate your health` <-
    as.factor(chart3$`how would you rate your health`)
  
  chart3$`household size` <-
    as.character(chart3$`household size`)
  chart3[chart3 == "(1) One person, I live by myself"] <-
    "1"
  chart3[chart3 == "(2) Two persons"] <- "2"
  chart3[chart3 == "(3) Three persons"] <- "3"
  chart3[chart3 == "(4) Four persons"] <- "4"
  chart3[chart3 == "(5) Five persons"] <- "5"
  chart3[chart3 == "(6) Six or more persons"] <- "6+"
  chart3$`household size` <-
    as.factor(chart3$`household size`)
  
  Scatterplot <- ggplot(data = chart3) +
    geom_count(mapping = aes(x= `how would you rate your health`,
                             y = `household size`, color = ..n..)) +
    scale_color_gradient(low = input$low_color, high = input$high_color) +
    facet_wrap(input$category, labeller = "label_both") +
    labs(x = "Rating of Mental Health", y =
           "Household Size by Number of People")
  
  Scatterplot
  })
 
}  
