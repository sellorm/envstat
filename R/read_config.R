read_config <- function(path = "~/.envstat") {
  envstat <- yaml::read_yaml(path)
  envstat
}
