# Startup message
.onAttach <- function(libname, pkgname){
    packageStartupMessage("\nTo cite codesBR in publications, use: citation('codesBR')")
}


# Internal function to convert data latin1 to ascii
to_ascii <- function(data){

  dplyr::mutate_all(data, iconv, from = "latin1", to = "ASCII//TRANSLIT")
}
