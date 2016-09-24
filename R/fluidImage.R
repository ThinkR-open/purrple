
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
#' @param env environment
#' @param quoted whether the expression is quoted
#'
#' @importFrom htmlwidgets shinyRenderWidget createWidget
#' @importFrom htmltools resolveDependencies
#' @importFrom shiny installExprFunction createWebDependency markRenderFunction
#' @export
renderFluidImage <- function(expr, env = parent.frame(), quoted = FALSE) {
  installExprFunction(expr, "func", env, quoted)
  renderFunc <- function(shinysession, name, ...) {
    imageinfo <- .image_file_info(func())

    x <- list(
      data = shinysession$fileUrl(name, file = imageinfo$src, contentType = imageinfo$contentType),
      width = imageinfo$width,
      height = imageinfo$height
    )

    instance <- createWidget( name = 'fluidImage', x, package = 'purrpleWidgets')
    deps <- .subset2(instance, "dependencies")
    deps <- lapply(resolveDependencies(deps), createWebDependency)
    payload <- c(.createPayload(instance), list(deps = deps))
    .toJSON(payload)
  }
  markRenderFunction(fluidImageOutput, renderFunc)
}
