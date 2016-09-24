library(shiny)
library(purrpleWidgets)

ui = shinyUI(fluidPage(
  fluidImageOutput("image", height = 600)
))

server = function(input, output, session) {

  output$image <- renderFluidImage(
    system.file( "cats", "cat1.jpg", package = "purrpleWidgets" )
  )

}

shinyApp(ui = ui, server = server)
