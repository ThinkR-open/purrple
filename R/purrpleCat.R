
#' Simple widget that adds the purrple logo at the right bottom corner
#'
#' @param outputId output variable to read from
#' @param session shiny session
#'
#' @name purrpleCat-shiny
#'
#' @importFrom htmlwidgets shinyWidgetOutput
#' @export
purrpleCatOutput <- function(outputId){
  shinyWidgetOutput(outputId, 'purrpleCat', "50px", "50px", package = 'purrpleWidgets')
}

#' @rdname purrpleCat-shiny
#' @importFrom htmlwidgets shinyRenderWidget createWidget
#' @export
renderPurrpleCat <- function(session) {
  get_file <- function(file){
    get_server_file(system.file("htmlwidgets", "lib", "purrpleCat", file, package = "purrpleWidgets"), session=session)
  }
  expression <- substitute({
    mp3 <- get_file("purr.mp3")
    img <- get_file("purrple.png")
    createWidget( name = "purrpleCat", x = list(mp3=mp3, img=img), package = "purrpleWidgets")
  })
  shinyRenderWidget( expression, purrpleCatOutput, environment(), quoted = TRUE )
}
