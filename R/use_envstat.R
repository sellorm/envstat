#' Create a new skeleton configuration file
#'
#' @param filepath path to the config file
#' @param source customise the source of the example config file
#' @return TRUE/FALSE invisibly to indicate success/failure
#' @export
use_envstat <- function(filepath = "~/.envstat", source = NULL) {
  if (file.exists(filepath)) {
    stop("The file, '", filepath, "', already exists!")
  }

  if (is.null(source)) {
    conf_source = file.path(find.package("envstat"), "example.envstat")
  } else {
    conf_source = source
  }

  if (!file.exists(conf_source)) {
    stop(paste0("The source config file does not exist: ", conf_source))
  }

  invisible(
    file.copy(
      from = conf_source,
      to = filepath
    )
  )
}
