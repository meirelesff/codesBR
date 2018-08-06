#' Add IBGE identifiers to a table
#'
#' The \code{ibge_from_tse} is a convinience function that takes a table and a variable with TSE municipal identifiers as inputs and adds a new variable to the original table containing the correspondent IBGE municipal identifiers.
#'
#' @param data A \code{data.frame} or \code{tbl_df} object contaning a \code{character} variable with TSE municipal identifiers.
#' @param tse_code A (\code{character}) variable containing TSE municipal identifiers.
#'
#' @note The number of municipalities in Brazil increased markedly from 1980 to 2000. The data used in this package only covers the more recent composition of municipalities in the country.
#'
#' @return The original table with IBGE municipality identifiers (as \code{character} variable). Multiple observations with the same identifier in the original data are preserved (using dplyr's left_join function).
#'
#' @examples
#' \dontrun{
#' # Using a table 'df' with the variable 'var_id' containing municipality identifiers
#'  df <- ibge_from_tse(df, var_id)
#' }
#'
#' @importFrom rlang .data
#' @export

ibge_from_tse <- function(data, tse_code){


  # Inputs
  if(!is.data.frame(codigos)) stop("'data' must be a data.frame or tbl_df.")

  # Internal data
  cods <- dplyr::select(.data = codigos, .data$cod_tse, .data$cod_ibge)

  # Join codes
  tse_code <- rlang::enquo(tse_code)
  by <- rlang::set_names("cod_tse", rlang::quo_name(tse_code))
  dplyr::left_join(data, cods, by = by)
}
