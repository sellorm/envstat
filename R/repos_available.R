check_cran_mirror <- function(url){
  version_url <- paste0(url, "/src/base/VERSION-INFO.dcf")
  request <- httr2::request(version_url)
  result <- httr2::req_perform(request)
  result_body <- tryCatch(
    httr2::resp_body_json(result, check_type = FALSE),
    error = function(e) NULL
  )
  if (result$status_code == 200){
    TRUE
  } else {
    FALSE
  }
}


check_repos_available <- function(config, silent = FALSE) {
  if (isFALSE(silent)){
    cli::cli_h2("Checking configured repos are available")
  }
  if ((is.null(config$repos_available)) || (isFALSE(config$repos_available))) {
    if (isFALSE(silent)){
      cli::cli_alert_warning("Not enabled - skipping")
    }
  } else {
    output <- c()
    for (repo in options("repos")) {
      repo_up <- check_cran_mirror(repo)
      if (isTRUE(repo_up)) {
        if (isFALSE(silent)){
          cli::cli_alert_success(paste0("CRAN repo availabe: ", repo))
        }
        output <- append(output, TRUE)
      } else {
        if (isFALSE(silent)){
          cli::cli_alert_danger(paste0("Error contacting CRAN repo: ", repo))
        }
        output <- append(output, FALSE)
      }
    }
    output
  }
}
