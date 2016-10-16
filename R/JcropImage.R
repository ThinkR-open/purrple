
#' shiny image output widget with crop capabilities
#'
#' shiny image output widget with crop capabilities powered by \code{Jcrop}.
#' As opposed to the usual \code{\link[shiny]{imageOutput}} component, this will
#' scale the image to fit the available space.
#'
#' This emits these input events (for \code{outputId="image"}):
#' \itemize{
#'  \item{\code{image_change}}{
#'    When the selection changes. The event object contains coordinates.
#'
#'    This is also triggered when the image changes or when the cropper is released. In that case, the event
#'    object contains \code{NULL}
#'  }
#'  \item{\code{image_select}}{
#'    Same as \code{image_change}, but is triggered less often, only when the selection is fixed.
#'  }
#' }
#'
#' @param outputId name of the output
#' @param width desired width of the image output
#' @param height desired height of the image output
#'
#' @importFrom htmlwidgets shinyWidgetOutput
#' @export
JcropImageOutput <- function(outputId, width = "100%", height = "400px" ){
  shinyWidgetOutput(outputId, 'JcropImage', width = width, height= height , package = 'purrpleWidgets')
}

get_server_file <- function(src, session){
  if(!is.null(src)) session$fileUrl( file = src, contentType = guess_type(src) )
}

#' Shiny renderer for JcropImageOutput
#'
#' Shiny renderer for JcropImageOutput
#'
#' @param expr expression that evaluates to a file name on the server. typically a temporary file.
#' @param background background color to use when the selection is active
#' @param opacity opacity of the background
#' @param aspect_ratio aspect ratio (width / height) of the selection. If \code{NULL} the selection is free.
#' @param session shiny session object
#'
#' @importFrom htmlwidgets shinyRenderWidget createWidget
#' @export
renderJcropImage <- function(expr, background = "white", opacity = .3, aspect_ratio = 1, session = get("session", parent.frame())) {
  env <- parent.frame()
  session <- force(session)
  func <- exprToFunction(expr, env, quoted = FALSE)

  expression <- substitute({
    src <- func()
    data <- get_server_file(src, session=session)
    x <- list( data = data, background = background, opacity = opacity, aspect_ratio = aspect_ratio )
    createWidget( name = "JcropImage", x, package = "purrpleWidgets")
  })
  shinyRenderWidget( expression, JcropImageOutput, environment(), quoted = TRUE )
}
