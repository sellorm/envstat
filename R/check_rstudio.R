check_ping_endpoint <- function(url) {
  ping_url <- paste0(url, "/__ping__")
  request <- httr2::request(ping_url)
  result <- tryCatch(
    httr2::req_perform(request),
    error = function(e) {list(message = "Request failure", status_code = 0)}
    )
  result_body <- tryCatch(
    httr2::resp_body_json(result, check_type = FALSE),
    error = function(e) {list(message = "Problem with result", status_code = 0)}
  )
  if ((result$status_code == 200) & (is.list(result_body))) {
    TRUE
  } else {
    FALSE
  }
}

check_rspm <- function(config, silent = FALSE) {
  cli_silencer(
    silent, "cli_h2",
    "Checking RStudio Package Manager instances"
  )
  if (is.null(config$RSPM)) {
    cli_silencer(
      silent, "cli_alert_warning",
      "No RSPM instances specified - skipping"
    )
  } else {
    output <- c()
    for (rspm_instance in config$RSPM) {
      instance_up <- check_ping_endpoint(rspm_instance)
      if (isTRUE(instance_up)) {
        cli_silencer(
          silent, "cli_alert_success",
          paste0("RSPM instance available: ", rspm_instance)
        )
        output <- append(output, TRUE)
      } else {
        cli_silencer(
          silent, "cli_alert_danger",
          paste0("Error contacting RSPM instance: ", rspm_instance)
        )
        output <- append(output, FALSE)
      }
    }
    output
  }
}

check_rsc <- function(config, silent = FALSE) {
  cli_silencer(
    silent, "cli_h2",
    "Checking RStudio Connect instances"
  )
  if (is.null(config$RSConnect)) {
    cli_silencer(
      silent, "cli_alert_warning",
      "No RStudio Connect instances specified - skipping"
    )
  } else {
    output <- c()
    for (rsc_instance in config$RSConnect) {
      instance_up <- check_ping_endpoint(rsc_instance)
      if (isTRUE(instance_up)) {
        cli_silencer(
          silent, "cli_alert_success",
          paste0("RSConnect instance available: ", rsc_instance)
        )
        output <- append(output, TRUE)
      } else {
        cli_silencer(
          silent, "cli_alert_danger",
          paste0(
            "Error contacting RSConnect instance: ",
            rsc_instance
          )
        )
        output <- append(output, FALSE)
      }
    }
    output
  }
}
