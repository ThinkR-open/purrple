library(shiny)
library(purrpleWidgets)

ui = shinyUI(fluidPage(
  fluidRow(
    column(6, fluidImageOutput("cat1", height = 400) ),
    column(6, fluidImageOutput("cat2", height = 400) )
  ),
  fluidRow(
    column(6, fluidImageOutput("cat3", height = 400) ),
    column(6, fluidImageOutput("cat4", height = 400) )
  )
))

server = function(input, output, session) {

  get_cat <- function(i){
    system.file( "cats", sprintf("cat%d.jpg", i ), package = "purrpleWidgets" )
  }
  output$cat1 <- renderFluidImage( get_cat(1) )
  output$cat2 <- renderFluidImage( get_cat(2) )
  output$cat3 <- renderFluidImage( get_cat(3) )
  output$cat4 <- renderFluidImage( get_cat(4) )

}

shinyApp(ui = ui, server = server)
