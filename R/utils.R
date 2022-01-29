cli_silencer <- function(silent, func, message) {
  cli_func <- get(func, asNamespace("cli"))
  if (isFALSE(silent)) {
    do.call(cli_func, list(message))
  }
}
