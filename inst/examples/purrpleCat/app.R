library(shiny)
library(purrpleWidgets)

ui = shinyUI(fluidPage(

  purrpleCatOutput("meow")

))

server = function(input, output, session) {
  output$meow <- renderPurrpleCat(session)
}

shinyApp(ui = ui, server = server)
