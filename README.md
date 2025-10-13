# terraExtra

<!-- badges: start -->

[![License: GPL
v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
![GitHub last
commit](https://img.shields.io/github/last-commit/cug-xyx/terraExtra)

<!-- badges: end -->

`terraExtra` is an extension package based on the `terra` package.

## Installation

You can install the development version of `terraExtra` from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes") or using `devtools`
remotes::install_github("cug-xyx/terraExtra")
```

## Functions

| Function name               | Description                                        | Status |
| --------------------------- | -------------------------------------------------- | ------ |
| `aggregate_8day_to_yearly`  | aggregate 8-day `SpatRaster` to **yearly scale**   | ✅     |
| `aggregate_8day_to_monthly` | aggregate 8-day `SpatRaster` to **monthly scale**  | ✅     |
| `significance`              | add significance plot using `SpatRaster`           | ✅     |
| `filter_date`               | filter `SpatRaster` layers with date range         | ✅     |
| `cor.test`                  | function `stats::cor.test` for `SpatRaster` object | ✅     |

## TODO

- [ ] Create example data
