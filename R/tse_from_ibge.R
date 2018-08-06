#' Add TSE identifiers to a table
#'
#' The \code{tse_from_ibge} is a convinience function that takes a table and a variable with IBGE municipal identifiers as inputs and adds a new variable to the original table containing the correspondent TSE municipal identifiers.
#'
#' @param data A \code{data.frame} or \code{tbl_df} object contaning a \code{character} variable with IBGE municipal identifiers.
#' @param ibge_code A (\code{character}) variable containing IBGE municipal identifiers.
#'
#' @note The number of municipalities in Brazil increased markedly from 1980 to 2000. The data used in this package only covers the more recent composition of municipalities in the country.
#'
#' @return The original table with TSE municipality identifiers (as \code{character} variable). Multiple observations with the same identifier in the original data are preserved (using dplyr's left_join function).
#'
#' @examples
#' \dontrun{
#' # Using a table 'df' with the variable 'var_id' containing municipality identifiers
#'  df <- tse_from_ibge(df, var_id)
#' }
#'
#' @importFrom rlang .data
#' @export

tse_from_ibge <- function(data, ibge_code){


  # Inputs
  if(!is.data.frame(data)) stop("'data' must be a data.frame or tbl_df.")

  # Internal data
  cods <- dplyr::select(.data = codigos, .data$cod_tse, .data$cod_ibge)

  # Join codes
  ibge_code <- rlang::enquo(ibge_code)
  by <- rlang::set_names("cod_ibge", rlang::quo_name(ibge_code))
  dplyr::left_join(data, cods, by = by)
}
