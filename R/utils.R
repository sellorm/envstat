# Silences output from the cli package
cli_silencer <- function(silent, func, message) {
  cli_func <- get(func, asNamespace("cli"))
  if (isFALSE(silent)) {
    do.call(cli_func, list(message))
  }
}

# Suppress R CMD Check complaints about not using the Import cli
dummy <- function() cli::cli
