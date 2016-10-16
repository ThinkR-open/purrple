
#' Adds the purrple logo at the bottom right
#'
#' Adds the purrple logo at the bottom right of the application
#' The cat purrs when you mouse hover it
#'
#' @importFrom htmltools htmlDependency
#' @export
purrple_logo <- function(){
  version <- packageDescription("purrpleWidgets")$Version
  dep <- htmlDependency(
    name = "purrpleCat", version = version,
    src = system.file( "htmlwidgets", "lib", "purrpleCat", package = "purrpleWidgets"),
    script = "purrpleCat.js",
    attachment = c( sound = "purr.mp3", image = "purrple.png")
  )
  res <- structure(
    div( id = "purrple_cat_logo"),
    html_dependencies = list(dep)
  )
  res
}

