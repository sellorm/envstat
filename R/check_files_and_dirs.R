check_files <- function(config) {
  cli::cli_h2("Checking files")
  if (is.null(config$file_exists)) {
    cli::cli_alert_warning("No files specified - skipping")
  } else {
    output <- c()
    for (file in config$file_exists) {
      if (file.exists(file)) {
        cli::cli_alert_success(paste0("Found file: ", file))
        output <- append(output, TRUE)
      } else {
        cli::cli_alert_danger(paste0("File not found: ", file))
        output <- append(output, FALSE)
      }
    }
    output
  }
}

check_dirs <- function(config) {
  cli::cli_h2("Checking directories")
  if (is.null(config$dir_exists)) {
    cli::cli_alert_warning("No directories specified - skipping")
  } else {
    output <- c()
    for (dir in config$dir_exists) {
      if (dir.exists(dir)) {
        cli::cli_alert_success(paste0("Found directory: ", dir))
        output <- append(output, TRUE)
      } else {
        cli::cli_alert_danger(paste0("Directory not found: ", dir))
        output <- append(output, FALSE)
      }
    }
    output
  }
}
