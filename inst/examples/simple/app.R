library(shiny)
library(purrpleWidgets)
library(magick)

ui = shinyUI(fluidPage(

  actionButton("reset", label = "new cat"),

  fluidRow(
    column(6, JcropImageOutput("image", height = 600 )),
    column(6, JcropImagePreviewOutput("preview", width = 400, height = 400))
  )

))

server = function(input, output, session) {
  image <- reactive({
    input$reset
    file <- sample( list.files( system.file("cats", package = "purrpleWidgets"), full.names = TRUE), 1 )
    im <- image_read(file)[[1]]
    width  <- dim(im)[2]
    height <- dim(im)[3]

    list(
      src = file ,
      alt = "test",
      width = width,
      height = height
    )
  })

  output$image <- renderJcropImage( image() , opacity = .3 )

  output$preview <- renderJcropImagePreview( JcropImagePreview("image", input$image_change) )

}

shinyApp(ui = ui, server = server)
