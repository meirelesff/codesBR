#' Add IBGE, TSE, SIAFI, and other Brazilian municipal identifiers to a table
#'
#' The \code{join_codes} takes a table and a variable with IBGE, TSE or SIAFI municipality identifiers as inputs and adds new variables to the original table, such as state, region, and municipal identifiers provided by IBGE, TSE, and SIAFI.
#'
#' @param data A \code{data.frame} or \code{tbl_df} object contaning a \code{character} variable with IBGE or TSE municipality identifiers.
#' @param code_var A (\code{character}) variable containing the IBGE, TSE, or SIAFI identifiers.
#' @param by_code A (\code{character}) variable denoting the type of identifier passed to the function call. Possible values are: \code{'ibge'}, to use IBGE municipality identifiers; \code{'tse'}; and \code{'siafi'}.
#' @param states Should state information be added to the existing data? Defaults to \code{FALSE}. If set to \code{TRUE}, states' names, acronyims, and their respective IBGE identifiers are added to the original data.
#' @param regions Should mesorregion and microrregion information be added to the existing data? Defaults to \code{FALSE}. If set to \code{TRUE}, information on the mesorregion and microrregion to, acronyims, their respective IBGE identifiers are added to the original data.
#' @param muni_names Should municipalities' full names be added to the existing data? Defaults to \code{FALSE}.
#' @param latlon Should latitude and longitute information be added to the existing data? Defaults to \code{FALSE}.
#' @param ascii Convert results from 'latin1' to 'ascii'? Defaults to \code{FALSE}.
#'
#' @section Data sources: The \code{codesBR} use data from official sources, such as IBGE (<https://concla.ibge.gov.br/classificacoes/por-tema/codigo-de-areas>), TSE (<http://www.tse.jus.br/arquivos/tse-lista-de-municipios-do-cadastro-da-justica-eleitoral/view>), Interlegis (<http://www.interlegis.leg.br/produtos_servicos/informacao/censo>), and SIAFI (<www.tesouro.fazenda.gov.br/>), to join Brazilian municipality codes to a previous table. The internal data contains 5,570 observations, covering all Brazilian municipalities (including Brazil's Fernando de Noronha e Brasilia).
#'
#' @note The number of municipalities in Brazil increased markedly from 1980 to 2000. The data used in this package covers the recent composition of municipalities in the country.
#'
#' @return The \code{join_codes} returns the original table with additional municipality identifiers (as \code{character} variables). Multiple observations with the same identifier in the original data are preserved (using dplyr's left_join function).
#'
#' @examples
#' \dontrun{
#' # Using a table 'df' with the variable 'var_id' containing municipality identifiers
#'  df <- join_codes(df, var_id, "ibge")
#'
#' # Get state identifiers
#' df <- join_codes(df, var_id, "ibge", states = TRUE)
#'
#' # Get region identifiers
#' df <- join_codes(df, var_id, "ibge", regions = TRUE)
#'
#' # Get the full name of the municipalities
#' df <- join_codes(df, var_id, "ibge", muni_names = TRUE)
#'
#' #' # Get the lat and lon information
#' df <- join_codes(df, var_id, "ibge", latlon = TRUE)
#'
#' # Get results in ASCII
#' df <- join_codes(df, var_id, "ibge", ascii = TRUE)
#' }
#'
#' @importFrom rlang .data
#' @export

join_codes <- function(data, code_var, by_code = c("ibge", "tse", "siafi"), states = FALSE,
                       regions = FALSE, muni_names = FALSE, latlon = FALSE, ascii = FALSE){


  # Inputs
  stopifnot(
    by_code %in% c("ibge", "tse", "siafi"),
    is.data.frame(data),
    is.logical(muni_names),
    is.logical(regions),
    is.logical(states),
    is.logical(latlon)
  )

  # Change by_code names
  by_code <- dplyr::case_when(by_code == "ibge" ~ "cod_ibge",
                              by_code == "tse" ~ "cod_tse",
                              by_code == "siafi" ~ "cod_siafi")

  # Internal data
  if(ascii) cods <- to_ascii(codigos)
  else cods <- codigos

  if(!muni_names) cods <- dplyr::select(.data = cods, -.data$nome_municipio)
  if(!regions) cods <- dplyr::select(.data = cods, -.data$mesorregiao, -.data$cod_mesorregiao, -.data$microrregiao, -.data$cod_microrregiao)
  if(!states) cods <- dplyr::select(.data = cods, -.data$uf, -.data$sigla_uf, -.data$cod_uf)
  if(!latlon) cods <- dplyr::select(.data = cods, -.data$lat, -.data$lon)

  # Join codes
  code_var <- rlang::enquo(code_var)
  by <- rlang::set_names(rlang::quo_name(by_code), rlang::quo_name(code_var))
  dplyr::left_join(data, cods, by = by)
}
