
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
  shinyWidgetOutput(outputId, 'fluidImage', width, height, package = 'purrple')
}

#' renderer for fluid image output
#'
#' @param expr expression that evaluates to a file name on the server.
#' @param session shiny session
#'
#' @importFrom mime guess_type
#' @importFrom htmlwidgets shinyRenderWidget createWidget
#' @importFrom shiny exprToFunction
#' @export
renderFluidImage <- function(expr, session = get("session", parent.frame())) {
  env <- parent.frame()
  session <- force(session)
  func <- exprToFunction(expr, env, quoted = FALSE)
  expression <- substitute({
    src <- func()
    data <- if( !is.null(src) ) session$fileUrl( file = src, contentType = guess_type(src) )
    createWidget( name = "fluidImage", list( data = data ), package = "purrple")
  })
  shinyRenderWidget( expression, fluidImageOutput, environment(), quoted = TRUE )
}
