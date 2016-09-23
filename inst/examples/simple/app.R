library(shiny)
library(purrpleWidgets)

ui = shinyUI(fluidPage(
  textOutput("coords"),
  fluidRow(
    JcropImageOutput("image")
    )

))

server = function(input, output, session) {

  output$image <- renderJcropImage(
    system.file( "cats", "cat2.jpg", package = "purrpleWidgets" ),
    opacity = .3
  )
  output$coords <- renderText( {
    data <- input$image_change
    if( is.null(data) ) {
      "no selection"
    } else {
      paste( names(data), " : ", data , sep = "", collapse = ", ")
    }
  })

}

shinyApp(ui = ui, server = server)
