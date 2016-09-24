#' Image preview widget
#'
#' Image preview widget that displays the selection from the \code{JcropImage} widget
#'
#' @param image id of the associated \code{JcropImage} component
#' @param event input event. typically \code{image_change} or \code{image_select} if the
#'        \code{JcropImage} output is called \code{image}
#' @param width width of the widget
#' @param height height of the widget
#' @param elementId unused
#'
#' @importFrom htmlwidgets createWidget
#' @export
JcropImagePreview <- function(image, event, width = NULL, height = NULL, elementId = NULL) {

  x = list(
    image = image,
    event = event
  )

  createWidget(
    name = 'JcropImagePreview',
    x,
    width = width,
    height = height,
    package = 'purrpleWidgets',
    elementId = elementId
  )
}

#' Image preview output shiny component
#'
#' Image preview output shiny component, suitable for a shiny ui.
#' @param outputId name of the component
#' @param width width of component
#' @param height height of component
#'
#' @importFrom htmlwidgets shinyWidgetOutput
#' @export
JcropImagePreviewOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'JcropImagePreview', width, height, package = 'purrpleWidgets')
}

#' Renderer for Image Preview component
#'
#' @param expr expression to evaluate, should end with a call to \code{\link{JcropImagePreview}}
#' @param env environment where to evaluate \code{expr}
#' @param quoted Is the expression already quoted
#' @export
renderJcropImagePreview <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, JcropImagePreviewOutput, env, quoted = TRUE)
}
