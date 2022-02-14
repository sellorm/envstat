# Silences output from the cli package
cli_silencer <- function(silent, func, message) {
  cli_func <- get(func, asNamespace("cli"))
  if (isFALSE(silent)) {
    do.call(cli_func, list(message))
  }
}


# Suppress R CMD Check complaints about not using the Import cli
# Required because of the unusual way we're using the cli package
dummy <- function() cli::cli


# obtain consent from the user
user_consent <- function(provided = FALSE, path = "~/.envstat") {
  # Is consent explicity provided?
  if (isTRUE(provided)) {
    return(TRUE)
  }

    # If the user has specified their own path we can assume they consent
  if (!path == "~/.envstat") {
    return(TRUE)
  }

  # Check if override env var is set
  if (!is.na(Sys.getenv("ENVSTAT", unset = NA))) {
    return(TRUE)
  }

  # Finally, ask for consent
  if (isTRUE(interactive())) {
    if (isTRUE(utils::askYesNo("Do you consent to the writing of the config file: `~/.envstat`"))) {
      TRUE
    } else {
      FALSE
    }
  } else {
    message("Can't obtain user consent in non-interactive sessions.")
    FALSE
  }
}
