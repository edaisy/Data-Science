# this code reproduces the histogram panel only from the electric skateboards app
library(shiny)
library(tidyverse)
library(fivethirtyeight)

###############
# import data #
###############
skateboards <- read_csv("electric_skateboards.txt")
data(candy_rankings)

###################################################
# define choice values and labels for user inputs #
###################################################
# define vectors for choice values and labels 
# can then refer to them in server as well (not just in defining widgets)
# for selectInput, 'choices' object should be a NAMED LIST
hist_choice_values <- c("sugarpercent","pricepercent","winpercent")
hist_choice_names <- c("Sugar Percentile","Price Percentile","Win Percentile")
names(hist_choice_values) <- hist_choice_names

# for checkboxGroupInput
type_choices <-  select(candy_rankings, c(chocolate, fruity, caramel, 
                   peanutyalmondy, nougat, crispedricewafer, 
                   hard, bar, pluribus))

############
#    ui    #
############
ui <- navbarPage(
  
  title="Candy Stats",
  
  tabPanel(
    title = "Histogram",
    sidebarLayout(
      sidebarPanel(
        selectInput(inputId = "histvar"
                    , label = "Choose a variable of interest to plot:"
                    , choices = hist_choice_values
                    , selected = "price"),
        checkboxGroupInput(inputId = "type"
                           , label = "Include candy types:"
                           , choices = type_choices
                           , selected = type_choices
                           , inline = TRUE)
      ),
      mainPanel(
        plotOutput(outputId = "hist")
      )
    )
  )
)
glimpse(candy_rankings)

############
# server   #
############
server <- function(input,output){
  
  # TAB 1: HISTOGRAM
  data_for_hist <- reactive({
    data <- filter(candy_rankings, input$type == TRUE)
  })
  
  output$hist <- renderPlot({
    ggplot(data = data_for_hist(), aes_string(x = input$histvar)) +
      geom_histogram(color = "#2c7fb8", fill = "#7fcdbb", alpha = 0.7) +
      labs(x = hist_choice_names[hist_choice_values == input$histvar]
           , y = "Number of Candies")
  })
}

####################
# call to shinyApp #
####################
shinyApp(ui = ui, server = server)