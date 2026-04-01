# app.R
library(shiny)
library(httr2)

ui <- fluidPage(
  titlePanel("My First API-Powered App"),
  textInput("user_name", "Enter your name:", "Developer"),
  actionButton("go", "Call API"),
  hr(),
  textOutput("api_response")
)

server <- function(input, output) {
  # We will update the URL after we deploy the API!
  observeEvent(input$go, {
    output$api_response <- renderText({
      paste0("Waiting for API...")
      # For now, this is a placeholder until you deploy the API
    })
  })
}

shinyApp(ui, server)