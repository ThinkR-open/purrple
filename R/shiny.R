
purrple_page <- function(page){
  function(...){
    page(purrple_logo(), ...)
  }
}

#' Modified version of shiny pages with purrple branding
#'
#' @param \dots see \link[shiny]{basicPage}
#' @importFrom shiny basicPage
#' @rdname shiny
#' @export
basicPage <- purrple_page(shiny::basicPage)

#' @importFrom shiny basicPage
#' @export
#' @rdname shiny
bootstrapPage <- purrple_page(shiny::bootstrapPage)

#' @importFrom shiny fillPage
#' @export
#' @rdname shiny
fillPage <- purrple_page(shiny::fillPage)

#' @importFrom shiny fillPage
#' @export
#' @rdname shiny
fixedPage <- purrple_page(shiny::fixedPage)

#' @importFrom shiny navbarPage
#' @export
#' @rdname shiny
navbarPage <- purrple_page(shiny::navbarPage)
