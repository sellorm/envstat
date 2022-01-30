#' Create a new skeleton configuration file
#'
#' @param path path to the config file
#' @param source customise the source of the example config file
#' @return TRUE/FALSE invisibly to indicate success/failure
#' @export
use_envstat <- function(path = "~/.envstat", source = NULL) {
  if (file.exists(path)) {
    stop("The envstat config file, `~/.envstat`, already exists!")
  }

  if (is.null(source)) {
    conf_source = paste0(path.package("envstat"), "/example.envstat")
  } else {
    conf_source = source
  }

  if (!file.exists(conf_source)) {
    stop(paste0("The source config file does not exist: ", conf_source))
  }

  invisible(
    file.copy(
      from = conf_source,
      to = path
    )
  )
}
