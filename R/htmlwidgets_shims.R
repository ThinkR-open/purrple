#' @importFrom utils packageDescription
.checkShinyVersion <- function (error = TRUE){
  x <- packageDescription("htmlwidgets", fields = "Enhances")
  r <- "^.*?shiny \\(>= ([0-9.]+)\\).*$"
  if (is.na(x) || length(grep(r, x)) == 0 || system.file(package = "shiny") == "")
    return()
  v <- gsub(r, "\\1", x)
  f <- if (error)
    stop
  else packageStartupMessage
  if (packageVersion("shiny") < v)
    f("Please upgrade the 'shiny' package to (at least) version ", v)
}


#' @importFrom mime guess_type
.getContentType <- function (file, defaultType = "application/octet-stream"){
  subtype <- ifelse(grepl("[.]html?$", file), "charset=UTF-8", "")
  guess_type(file, unknown = defaultType, subtype = subtype)
}

`%OR%` <- function (x, y) {
  if (is.null(x) || isTRUE(is.na(x)))
    y
  else x
}

.shouldEval <- function (options) {
  if (is.list(options)) {
    if ((n <- length(options)) == 0)
      return(FALSE)
    if (is.null(names(options)))
      names(options) <- seq_len(n) - 1L
    names(options) <- gsub("([\\.])", "\\\\\\1", names(options))
    nms <- names(options)
    if (length(nms) != n || any(nms == ""))
      stop("'options' must be a fully named list, or have no names (NULL)")
    lapply(options, .shouldEval)
  }
  else {
    is.character(options) && inherits(options, "JS_EVAL")
  }
}

.JSEvals <- function (list) {
  evals <- names(which(unlist(.shouldEval(list))))
  I(evals)
}

.createPayload <- function(instance) {
  if (!is.null(instance$preRenderHook)) {
    instance <- instance$preRenderHook(instance)
    instance$preRenderHook <- NULL
  }
  x <- .subset2(instance, "x")
  list(x = x, evals = .JSEvals(x), jsHooks = instance$jsHooks)
}

#' @importFrom jsonlite toJSON
.toJSON2 <- function (x, ..., dataframe = "columns", null = "null", na = "null",
          auto_unbox = TRUE, digits = getOption("shiny.json.digits",
                                                16), use_signif = TRUE, force = TRUE, POSIXt = "ISO8601",
          UTC = TRUE, rownames = FALSE, keep_vec_names = TRUE)
{
  toJSON(I(x), dataframe = dataframe, null = null,
                   na = na, auto_unbox = auto_unbox, digits = digits, use_signif = use_signif,
                   force = force, POSIXt = POSIXt, UTC = UTC, rownames = rownames,
                   keep_vec_names = keep_vec_names, json_verbatim = TRUE,
                   ...)
}

.toJSON <- function (x) {
  if (!is.list(x) || !("x" %in% names(x)))
    return(.toJSON2(x))
  func <- attr(x$x, "TOJSON_FUNC", exact = TRUE)
  args <- attr(x$x, "TOJSON_ARGS", exact = TRUE)
  if (length(args) == 0)
    args <- getOption("htmlwidgets.TOJSON_ARGS")
  if (!is.function(func))
    func <- .toJSON2
  res <- if (length(args) == 0)
    func(x)
  else do.call(func, c(list(x = x), args))
  structure(res, class = "json")
}
