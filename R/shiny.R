
#' @importFrom htmltools htmlDependency
purrple_dependencies <- function(){
  src     <- system.file( "htmlwidgets", "lib", "purrpleCat", package = "purrple")
  version <- packageDescription("purrple")$Version
  name    <- "purrple"
  target <- sprintf( "%s-%s", name, version )
  dep <- htmlDependency(
    name = name, version = version ,
    src = src,
    script = "purrpleCat.js",
    head = sprintf('
      <link rel="shortcut icon" href="%s/favicon.ico" type="image/x-icon">
      <link rel="icon" href="%s/favicon.ico" type="image/x-icon">
    ', target, target),
    attachment = c( sound = "purr.mp3", image = "purrple.png"),
    all_files = TRUE
  )
  dep
}

#' Tune a shiny page to add purrple branding (logo, ...)
#'
#' @param fun shiny page function (e.g. \code{\link[shiny]{fluidPage}}, ...)
#' @return a modified version of the shiny page with additional html dependencies
#'
#' @export
purrplePage <- function(fun){
  function(...){
    p <- fun(...)
    dep <- append( attr(p, "html_dependencies"), list( purrple_dependencies() ) )
    attr(p, "html_dependencies") <- dep
    p
  }
}
