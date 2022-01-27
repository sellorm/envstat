#' Output an environment status situsation report
#' @param silent boolean disables printed output
#' @param path path to the envstat config file
#' @return returns TRUE or FALSE invisibly, depending on whether all checks pass or fail
#' @export
sitrep <- function(silent = FALSE, path = "~/.envstat"){
  if (isFALSE(silent)){
    cli::cli_h1("envstat situation report")
  }
  envstatconf <- read_config(path = path)

  output_files    <- check_files(envstatconf, silent = silent)
  output_dirs     <- check_dirs(envstatconf, silent = silent)
  output_env_vars <- check_env_vars(envstatconf, silent = silent)
  output_rspm     <- check_rspm(envstatconf, silent = silent)
  output_rsc      <- check_rsc(envstatconf, silent = silent)
  output_repos    <- check_repos_available(envstatconf, silent = silent)

  all_outputs <- c(output_files, output_dirs, output_env_vars, output_rspm, output_rsc, output_repos)
  if (isFALSE(silent)){
    cli::cli_h2("Final result")
  }
  if ( FALSE %in% all_outputs){
    if (isFALSE(silent)){
      cli::cli_alert_danger("Some checks failed, please review the output above")
    }
    invisible(FALSE)
  } else {
    if (isFALSE(silent)){
      cli::cli_alert_success("All checks passed!")
    }
    invisible(TRUE)
  }
}
