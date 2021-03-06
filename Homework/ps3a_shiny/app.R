library(shiny)

ui <- fluidPage(
  sliderInput(inputId = "num", 
              label = "Choose a number", 
              value = 25, min = 1, max = 100),
  textInput(inputId = "title", 
            label = "Name me",
            value = "Histogram of Random Normal Values"),
  navlistPanel(
    tabPanel(title = "Histogram",
             plotOutput("hist"),
    ),
    tabPanel(title = "Stats",
            verbatimTextOutput("stats"),
    )
  )
)

server <- function(input, output) {
  output$hist <- renderPlot({
    hist(rnorm(input$num), main = input$title)
  })
  output$stats <- renderPrint({
    summary(rnorm(input$num))
  })
}

shinyApp(ui = ui, server = server)