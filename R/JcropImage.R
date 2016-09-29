
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

# to help check
globalVariables( "func" )

#' Shiny renderer for JcropImageOutput
#'
#' Shiny renderer for JcropImageOutput
#'
#' @param expr expression that evaluates to a file name on the server. typically a temporary file.
#' @param background background color to use when the selection is active
#' @param opacity opacity of the background
#' @param aspect_ratio aspect ratio (width / height) of the selection. If \code{NULL} the selection is free.
#' @param env environment in which to evaluate \code{expr}
#' @param quoted is the expression quoted
#'
#' @importFrom htmlwidgets shinyRenderWidget createWidget
#' @importFrom htmltools resolveDependencies
#' @importFrom shiny installExprFunction createWebDependency markRenderFunction
#' @export
renderJcropImage <- function(expr, background = "white", opacity = .3, aspect_ratio = 1, env = parent.frame(), quoted = FALSE) {
  installExprFunction(expr, "func", env, quoted)
  renderFunc <- function(shinysession, name, ...) {
    image <- func()

    x <- if( !is.null(image) ){
      imageinfo <- .image_file_info(image)
      list(
        data = shinysession$fileUrl(name, file = imageinfo$src, contentType = imageinfo$contentType),
        background = background,
        opacity = opacity,
        aspect_ratio = aspect_ratio
      )
    }

    instance <- createWidget( name = 'JcropImage', x, package = 'purrpleWidgets')
    deps <- .subset2(instance, "dependencies")
    deps <- lapply(resolveDependencies(deps), createWebDependency)
    payload <- c(.createPayload(instance), list(deps = deps))
    .toJSON(payload)
  }
  markRenderFunction(JcropImageOutput, renderFunc)
}
