# plumber.R
library(plumber)

#* @get /greet
#* @param name The name to greet
function(name = "World") {
  list(message = paste0("Hello, ", name, "! This message came from your API."))
}