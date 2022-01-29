#' Create a new skeleton configuration file
#'
#' @return TRUE/FALSE invisibly to indicate success/failure
#' @export
use_envstat <- function() {
  if (file.exists("~/.envstat")) {
    stop("The envstat config file, `~/.envstat`, already exists!")
  }

  invisible(file.copy(
    paste0(from = path.package("envstat"), "/example.envstat"),
           to = "~/.envstat"
  ))
}
