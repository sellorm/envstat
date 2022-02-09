#' Create a new skeleton configuration file
#'
#' @param filepath path to the config file
#' @param source customise the source of the example config file
#' @return TRUE/FALSE invisibly to indicate success/failure
#' @export
#' @examples
#' \dontrun{
#' # By default envstat uses a config file in your home directory
#' envstat::use_envstat()
#'
#' # But you can tell it to use a different config file if you prefer
#' envstat::use_envstat(filepath = "/tmp/config.yml")
#'
#' # During normal operation use_envstat uses a default config file that ships
#' # with the package, but you can specify your own if you have one. This can
#' # be useful in settings such as multi-user server deployments of R, as many
#' # users could use the same base configuration file and personalise it for
#' # their own specific use case.
#' envstat::use_envstat(source = "/shared/corp_envstat_conf.yml")
#' }
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


#' Edit an envstat configuration file
#'
#' Opens an `envstat` config file in your in your editor.
#' Supports either the RStudio IDE, or the R default editor from
#' `getOption("editor")`
#'
#' @param filepath path to the config file
#' @return the path to the config file invisibly
#' @export
#' @examples
#' \dontrun{
#' # By default envstat uses a config file in your home directory
#' envstat::edit_envstat()
#'
#' # But you can tell it to use a different config file if you prefer
#' envstat::edit_envstat(filepath = "/tmp/config.yml")
#' }
edit_envstat <- function(filepath = "~/.envstat"){
  if (!interactive()){
    stop("The current session is not interactive.\n",
         "You can only use this function from an interactive R session.")
  }

  if (!file.exists(filepath)){
    stop("Can't find file: ", filepath, "\n",
         "Please check the supplied path and try again.")
  }

  if (rstudioapi::isAvailable()){
    rstudioapi::navigateToFile(filepath)
  } else {
    utils::file.edit(filepath)
  }

  invisible(filepath)
}
