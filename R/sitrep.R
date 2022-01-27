#' Output an environment status situsation report
#' @param path path to the envstat config file
#' @return returns TRUE or FALSE invisibly, depending on whether all checks pass or fail
#' @export
sitrep <- function(path = "~/.envstat"){
  cli::cli_h1("envstat situation report")
  envstatconf <- read_config(path = path)

  output_files    <- check_files(envstatconf)
  output_dirs     <- check_dirs(envstatconf)
  output_env_vars <- check_env_vars(envstatconf)
  output_rspm     <- check_rspm(envstatconf)
  output_rsc      <- check_rsc(envstatconf)
  output_repos    <- check_repos_available(envstatconf)

  all_outputs <- c(output_files, output_dirs, output_env_vars, output_rspm, output_rsc, output_repos)

  cli::cli_h2("Final result")
  if ( FALSE %in% all_outputs){
    cli::cli_alert_danger("Some checks failed, please review the output above")
    invisible(FALSE)
  } else {
    cli::cli_alert_success("All checks passed!")
    invisible(TRUE)
  }
}
