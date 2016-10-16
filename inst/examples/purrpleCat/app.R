library(shiny)
library(purrpleWidgets)

ui = shinyUI(fluidPage(

  purrpleLogo()

))

server = function(input, output, session) {

}

shinyApp(ui = ui, server = server)
