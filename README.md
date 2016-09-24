# purrpleWidgets

## JcropImage widgets

The `JcropImage` widget embeds cropping capabilities powered 
by the [Jcrop](http://deepliquid.com/content/Jcrop_Manual.html) javascript 
library. 

It is intended to be used in a shiny application. Here is a minimal example that displays
the coordinates on `change` and `select` events related to the `JcropImage` widget called `image` 

```r
library(shiny)
library(purrpleWidgets)

ui = shinyUI(fluidPage(
  textOutput("change"), textOutput("select"), JcropImageOutput("image")
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
```

[![Demo](gifs/JcropImage1.gif)]()

