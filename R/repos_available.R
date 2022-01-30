check_cran_mirror <- function(url) {
  version_url <- paste0(url, "/src/base/VERSION-INFO.dcf")

  request <- httr2::request(version_url)

  result <- tryCatch(
    httr2::req_perform(request),
    error = function(e) NULL
  )
  result_body <- tryCatch(
    httr2::resp_body_json(result, check_type = FALSE),
    error = function(e) NULL
  )

  if (result$status_code == 200) {
    TRUE
  } else {
    FALSE
  }
}


check_repos_available <- function(config, silent = FALSE) {
  cli_silencer(
    silent, "cli_h2",
    "Checking configured repos are available"
  )
  output <- c()
  if ((is.null(config$repos_available)) || (isFALSE(config$repos_available))) {
    cli_silencer(
      silent, "cli_alert_warning",
      "Not enabled - skipping"
    )
    output <- append(output, TRUE)
  } else {
    for (repo in options("repos")) {
      if (repo == "@CRAN@") {
        cli_silencer(
          silent, "cli_alert_danger",
          "No explicitly configured CRAN repo (@CRAN@)"
        )
        output <- append(output, FALSE)
      } else {
        repo_up <- check_cran_mirror(repo)
        if (isTRUE(repo_up)) {
          cli_silencer(
            silent, "cli_alert_success",
            paste0("CRAN repo availabe: ", repo)
          )
          output <- append(output, TRUE)
        } else {
          cli_silencer(
            silent, "cli_alert_danger",
            paste0("Error contacting CRAN repo: ", repo)
          )
          output <- append(output, FALSE)
        }
      }
    }
    output
  }
}
