
#' @importFrom htmltools htmlDependency
purrple_logo_dependency <- function(){
  src     <- system.file( "htmlwidgets", "lib", "purrpleCat", package = "purrple")
  version <- packageDescription("purrple")$Version
  name    <- "purrple"
  target <- sprintf( "%s-%s", name, version )
  htmlDependency(
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
}

purrple_page <- function(page){
  function(...){
    p <- page(...)
    dep <- append( attr(p, "html_dependencies"), list( purrple_logo_dependency() ) )
    attr(p, "html_dependencies") <- dep
    p
  }
}

#' Modified version of shiny pages with purrple branding
#'
#' @param \dots see \link[shiny]{basicPage}
#' @rdname shiny
#' @export
basicPage <- purrple_page(shiny::basicPage)

#' @export
#' @rdname shiny
bootstrapPage <- purrple_page(shiny::bootstrapPage)

#' @export
#' @rdname shiny
fillPage <- purrple_page(shiny::fillPage)

#' @export
#' @rdname shiny
fixedPage <- purrple_page(shiny::fixedPage)

#' @export
#' @rdname shiny
navbarPage <- purrple_page(shiny::navbarPage)

#' @export
#' @rdname shiny
fluidPage <- purrple_page(shiny::fluidPage)
