
#' @importFrom htmlwidgets shinyWidgetOutput
#' @export
JcropImageOutput <- function(outputId, width = "100%", height = "400px" ){
  shinyWidgetOutput(outputId, 'JcropImage', width = width, height= height , package = 'purrpleWidgets')
}

#' @importFrom htmlwidgets shinyRenderWidget createWidget
#' @importFrom htmltools resolveDependencies
#' @importFrom shiny installExprFunction createWebDependency
#' @export
renderJcropImage <- function(expr, env = parent.frame(), quoted = FALSE, background = "white", opacity = 1, aspect_ratio = 1 ) {
  installExprFunction(expr, "func", env, quoted)
  renderFunc <- function(shinysession, name, ...) {
    imageinfo <- func()
    contentType <- imageinfo$contentType %OR% .getContentType(imageinfo$src)
    extra_attr <- imageinfo[!names(imageinfo) %in% c("src", "contentType")]
    data <- c(src = shinysession$fileUrl(name, file = imageinfo$src, contentType = contentType), extra_attr)

    x <- list(
      data = data,
      background = background,
      opacity = opacity,
      aspect_ratio = aspect_ratio
    )

    instance <- createWidget( name = 'JcropImage', x, package = 'purrpleWidgets')
    deps <- .subset2(instance, "dependencies")
    deps <- lapply(resolveDependencies(deps), createWebDependency)
    payload <- c(.createPayload(instance), list(deps = deps))
    .toJSON(payload)
  }
  markRenderFunction(JcropImageOutput, renderFunc)
}
