<!-- README.md is generated from README.Rmd. Please edit that file -->
codesBR
=======

`codesBR` is a package for adding Brazilian municipal identifiers to a
table. Specifically, the package provides simple functions to add IBGE,
TSE, and SIAFI identifiers to tables that contain only one of these
identifiers – making it easy to match the main codes used by public
agencies in Brazil to identify each one of the country’s 5,570
municipalities.

How does it work?
-----------------

This is a basic example which shows you how to solve a common problem:

``` r
## basic example code
```

The package also contains two convenience functions to add the two most
widely used identifiers in Brazil, from IBGE and TSE. In case one have a
variable with IBGE municipal identifiers, to get the correspondent TSE
ones use the `tse_from_ibge` function:

``` r
# Add TSE identifiers to a table
```

Conversely, to get TSE municipal identifiers from IBGE ones, use the
`ibge_from_tse` function as follows:

``` r
# Add IBGE identifiers to a table
```

Installation
------------

To install the package from CRAN, use:

``` r
install.packages("codesBR")
```

To install the development version from GitHub, use:

``` r
devtools::install_github("meirelesff/codesBR")
```

Disclaimer
----------

Author
------
