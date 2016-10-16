library(shiny)
library(purrpleWidgets)

ui = shinyUI(fluidPage(
  textOutput("change"), textOutput("select"), JcropImageOutput("image"),
  purrple_logo()
))

server = function(input, output, session) {

  output$image <- renderJcropImage(
    system.file( "cats", "cat2.jpg", package = "purrpleWidgets" ),
    opacity = .3
  )

  selection <- function(data){
    if( is.null(data) ) {
      "no selection"
    } else {
      paste( names(data), " : ", data , sep = "", collapse = ", ")
    }
  }

  output$change <- renderText( selection(input$image_change))
  output$select <- renderText( selection(input$image_select))

}

shinyApp(ui = ui, server = server)
