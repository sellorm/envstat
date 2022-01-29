check_env_vars <- function(config, silent = FALSE) {
  cli_silencer(
    silent,
    "cli_h2",
    "Checking environment variables"
  )

  if (is.null(config$env_vars)) {
    cli_silencer(
      silent,
      "cli_alert_warning",
      "No env vars specified - skipping"
    )
  } else {
    output <- c()
    for (env_var in config$env_vars) {
      env_var_output <- Sys.getenv(x = env_var, unset = NA)
      if (is.na(env_var_output)) {
        cli_silencer(
          silent,
          "cli_alert_danger",
          paste0("Env var not set: ", env_var)
        )
        output <- append(output, FALSE)
      } else {
        cli_silencer(
          silent,
          "cli_alert_success",
          paste0("Env var set: ", env_var)
        )
        output <- append(output, TRUE)
      }
    }
    output
  }
}
