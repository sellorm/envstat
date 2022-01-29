.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    "The `envstat` package was not designed to be attached\n",
    "Please use `envstat::sitrep()` instead."
  )
}
