
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
    imageinfo <- .image_file_info(func())

    x <- list(
      data = shinysession$fileUrl(name, file = imageinfo$src, contentType = imageinfo$contentType),
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

#' @importFrom magrittr %>%
#' @importFrom mime guess_type
#' @importFrom magick image_read image_info
.image_file_info <- function(file){
  type <- guess_type(file)
  info <- image_read(file) %>% image_info()

  list(
    src = file,
    contentType = type,
    width = info$width,
    height = info$height
  )
}
