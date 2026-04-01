library(shiny)
library(httr2)

ui <- fluidPage(
  titlePanel("My First API-Powered App"),
  textInput("user_name", "Enter your name:", "Developer"),
  actionButton("go", "Call API"),
  hr(),
  # Use a verbatimTextOutput to see the raw data clearly
  verbatimTextOutput("api_response")
)

server <- function(input, output) {
  
  # 1. Get the API URL from the Posit Connect 'Vars' tab
  # If testing locally, you can use: Sys.setenv(MY_API_URL = "http://127.0.0.1:8000")
  api_base_url <- Sys.getenv("MY_API_URL")
  # api_base_url <- Sys.setenv(MY_API_URL = "http://127.0.0.1:5957")
  observeEvent(input$go, {
    output$api_response <- renderPrint({
      
      # 2. Safety check: Did we set the URL?
      if (api_base_url == "") {
        return("Error: MY_API_URL not found in Environment Variables.")
      }
      
      # 3. Build the request to your Plumber endpoint (/greet)
      req <- request(api_base_url) %>%
        req_url_path("/greet") %>%
        req_url_query(name = input$user_name) %>%
        req_retry(max_tries = 3) # Good practice for network stability
      
      # 4. Perform the call and handle the response
      resp <- req_perform(req)
      
      # 5. Extract the JSON message from the API
      result <- resp_body_json(resp)
      
      # Return the message to the UI
      return(result$message)
    })
  })
}

shinyApp(ui, server)