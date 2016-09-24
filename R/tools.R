
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
