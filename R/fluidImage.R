
#' Fluid image
#'
#' similar to \code{\link[shiny]{imageOutput}} but automtically scales to fit when resized.
#'
#' @param outputId id
#' @param width desired width
#' @param height desired height
#'
#' @importFrom htmlwidgets shinyWidgetOutput
#' @export
fluidImageOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'fluidImage', width, height, package = 'purrpleWidgets')
}

#' renderer for fluid image output
#'
#' @param expr expression that evaluates to a file name on the server.
#' @param session shiny session
#'
#' @importFrom mime guess_type
#' @importFrom htmlwidgets shinyRenderWidget createWidget
#' @export
renderFluidImage <- function(expr, session = get("session", parent.frame())) {
  env <- parent.frame()
  expression <- substitute({
    src <- eval( expr, envir = env)
    x <- if( !is.null(src) ) session$fileUrl( src, contentType = guess_type(src) )
    createWidget( name = "fluidImage", list( data = x ), package = "purrpleWidgets")
  })
  shinyRenderWidget( expression, fluidImageOutput, environment(), quoted = TRUE )
}
