
# envstat

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/sellorm/envstat/workflows/R-CMD-check/badge.svg)](https://github.com/sellorm/envstat/actions)
[![Codecov test coverage](https://codecov.io/gh/sellorm/envstat/branch/main/graph/badge.svg)](https://app.codecov.io/gh/sellorm/envstat?branch=main)
<!-- badges: end -->

Checks your compute **environment status**.

If you need to know about your R session, you use `sessionInfo()`.
But what if you need information on your external environment?
Things like whether files or directories that you expect exist,
or that specific environment variables are set. 
The `envstat` package provides a way to report on your external
compute environment, or environment status, outside of R.

Using a simple YAML configuration file,
`envstat` can report on the availability of the following:

* Files
* Directories
* Environment variables
* RStudio Package Manager Instances
* RStudio Connect Instances
* CRAN repo availability

## Uses

In today's multi-location working environments, users need to know that
the things they require to get their work done are available.

Imagine if you often work from home as well as the office and need a VPN to
in order to use RStudio Connect and Package Manager. The `envstat` 
package can tell you whether you have access to the things you need to 
be productive.

Maybe it's a shared directory, or an environment variable.
`envstat` can help by providing a simple, single-function report that
tells you what you need to know.

## Installation

You can install the development version of envstat like so:

``` r
remotes::install_github("sellorm/envstat")
```

## Example

Once installed you can use `envstat::sitrep()` to produce a pretty
situation report:

```
── envstat situation report ───────────────────────────────────────────

── Checking files ──

✓ Found file: ~/tmp/delete_me

── Checking directories ──

✓ Found directory: ~/tmp

── Checking environment variables ──

✓ Env var set: CONNECT_API_KEY

── Checking RStudio Package Manager instances ──

✓ RSPM instance available: https://rstudio.example.com/rspm

── Checking RStudio Connect instances ──

✓ RSConnect instance available: https://rstudio.example.com/rsc
✓ RSConnect instance available: https://connect.megacorp.com

── Checking configured repos are available ──

✓ CRAN repo availabe: https://cran.rstudio.com/

── Final result ──

✓ All checks passed!
```

## config file format

The config file needs to live in the root of your home directory
and should be called `.envstat`.

Here is an example that covers all of the currently supported options;

You can create a example config file in the correct location with
`envstat::use_envstat()`.
Naturally, this example config file will result in errors if you run
`sitrep()` with it as-is, but it's a good example of what's possible.

In the RStudio IDE, you can edit your envstat config file with 
`envstat::edit_envstat()`.

Feel free to omit any sections you don't need.

```
file_exists:
  - /path/to/myfile
  - /path/to/a/different/file
dir_exists:
  - /path/to/mydir
repos_available: TRUE
RSPM:
  - https://rstudio.example.com/rspm
RSConnect:
  - https://rstudio.example.com/rsc
  - https://connect.megacorp.com
env_vars:
  - CONNECT_API_KEY
  - http_proxy
```

## Config file options

### file_exists

Takes a list of file paths.

Tests whether the specified file exists. This can be useful for
checking that you have access to a specific filesystem (for example
a Windows share) by checking for a specific file on it. Alternatively, you could
use it to check for a specific config file that you use regularly.

### dir_exists

Takes a list of directory paths.

The same as `file_exists`, but for directories.

### repos_available

Boolean (true/false)

If this option is set to `true`, envstat will loop through all of the
repositories you have configured in `options("repos")` and check if
they're available.

### RSPM

List of RStudio Package Manager URLs. Use the base URL of the Package
Manager instance

Checks to see if we can connect to the specified RSPM instances.

### RSConnect

List of RStudio Connect URLs. Use the base URL of the Connect instance.

Checks to see if we can connect to the specified Connect instances.

### env_vars

List of environment variables to check.

Use this section to list any environment variables that you need
to have set. When run, `envstat::sitrep()` will check if the 
environment variables are set and let you know if they're not.
