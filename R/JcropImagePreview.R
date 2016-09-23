#' @export
JcropImagePreview <- function(image, event, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    image = image,
    event = event
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'JcropImagePreview',
    x,
    width = width,
    height = height,
    package = 'purrpleWidgets',
    elementId = elementId
  )
}

#' @export
JcropImagePreviewOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'JcropImagePreview', width, height, package = 'purrpleWidgets')
}

#' @export
renderJcropImagePreview <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, JcropImagePreviewOutput, env, quoted = TRUE)
}
