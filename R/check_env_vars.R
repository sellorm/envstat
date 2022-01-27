check_env_vars <- function(config, silent = FALSE) {
  if (isFALSE(silent)){
    cli::cli_h2("Checking environment variables")
  }
  if (is.null(config$env_vars)) {
    if (isFALSE(silent)){
      cli::cli_alert_warning("No env vars specified - skipping")
    }
  } else {
    output <- c()
    for (env_var in config$env_vars) {
      env_var_output <- Sys.getenv(x = env_var, unset = NA)
      if (is.na(env_var_output)) {
        if (isFALSE(silent)){
          cli::cli_alert_danger(paste0("Env var not set: ", env_var))
        }
        output <- append(output, FALSE)
      } else {
        if (isFALSE(silent)){
          cli::cli_alert_success(paste0("Env var set: ", env_var))
        }
        output <- append(output, TRUE)
      }
    }
    output
  }
}
