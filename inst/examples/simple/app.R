library(shiny)
library(purrple)

ui = shinyUI(fluidPage(
  textOutput("change"),
  textOutput("select"),
  JcropImageOutput("image")
))

server = function(input, output, session) {

  output$image <- renderJcropImage(
    system.file( "cats", "cat2.jpg", package = "purrple" ),
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
