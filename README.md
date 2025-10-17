
<!-- README.md is generated from README.Rmd. Please edit that file -->

# safecaR: Access NHTSA Vehicle Safety Data from R

## Overview

The `safecaR` R package provides a tidy interface to **NHTSA APIs**,
including crash ratings, recalls, and complaints.

⚠️ **Note:** This package requires an internet connection to fetch data
from public NHTSA APIs. If you’re offline, functions will not return
results.

## Installation

You can install the latest release of `safecaR` on Github with the
following:

``` r
# install.packages("remotes") if you don't have it
remotes::install_github("c-a-s-t-l-e/safecaR")
```

## Basic Use

**Option \#1:** Access vehicle crash ratings for a single vehicle

``` r
# uses the NHTSA vehicle ID for 2022 Acura RDX
ratings <- get_ratings(7520)
head(ratings)
```

**Option \#2:** Access vehicle crash ratings for all model variants

``` r
ratings_all <- get_ratings_by_model(2022, "ACURA", "RDX")
head(ratings_all)
```

**Option \#3:** Access vehicle recalls

``` r
recalls <- get_recalls(2022, "ACURA", "RDX")
head(recalls)
```

**Option \#4:** Access vehicle complaints

``` r
complaints <- get_complaints(2022, "ACURA", "RDX")
head(complaints)
```

More information can be found at [safecaR’s
website](https://c-a-s-t-l-e.github.io/safecaR/).
