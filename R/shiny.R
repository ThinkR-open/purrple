
purrple_page <- function(page){
  function(...){
    page(..., purrple_logo())
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
