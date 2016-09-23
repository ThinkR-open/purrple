library(shiny)
library(purrpleWidgets)

ui = shinyUI(fluidPage(
  JcropImageOutput("image")
))

server = function(input, output, session) {
  output$image <- renderJcropImage({
      data <- list(
        src = system.file( "examples", "preview", "www", "cat.jpg", package = "purrpleWidgets" ) ,
        contentType = "image/jpeg",
        alt = "test"
      )
      JcropImage(data)
    }
  )

}

shinyApp(ui = ui, server = server)
