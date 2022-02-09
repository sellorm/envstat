#' Output an environment status situation report
#'
#' Reports on the availability of certain features of your compute
#' infrastructure, for example, environment variables, or a specific RStudio
#' Package Manager instance. Configure the tests with the `use_envstat` and
#' `edit_envstat` functions.
#'
#' @param silent boolean disables printed output
#' @param path path to the envstat config file
#' @return TRUE/FALSE invisibly, to indicate all checks pass/fail
#' @export
#' @examples
#' \dontrun{
#' # By default envstat uses a config file in your home directory
#' envstat::sitrep()
#'
#' # But you can tell it to use a different config file if you prefer
#' envstat::sitrep(path = "/tmp/config.yml")
#'
#' # sitrep can also run silently, so that it can be used programatically
#' envstat::sitrep(silent = TRUE)
#' }
sitrep <- function(silent = FALSE, path = "~/.envstat") {
  cli_silencer(
    silent, "cli_h1",
    "envstat situation report"
  )

  envstatconf     <- read_config(path = path)

  output_files    <- check_files(envstatconf, silent = silent)
  output_dirs     <- check_dirs(envstatconf, silent = silent)
  output_env_vars <- check_env_vars(envstatconf, silent = silent)
  output_rspm     <- check_rspm(envstatconf, silent = silent)
  output_rsc      <- check_rsc(envstatconf, silent = silent)
  output_repos    <- check_repos_available(envstatconf, silent = silent)

  all_outputs <- c(
    output_files,
    output_dirs,
    output_env_vars,
    output_rspm,
    output_rsc,
    output_repos
  )

  cli_silencer(silent, "cli_h2", "Final result")
  if (FALSE %in% all_outputs) {
    cli_silencer(
      silent, "cli_alert_danger",
      "Some checks failed, please review the output above"
    )
    invisible(FALSE)
  } else {
    cli_silencer(
      silent, "cli_alert_success",
      "All checks passed!"
    )
    invisible(TRUE)
  }
}
