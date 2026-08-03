#'
#' function to quickly format files from Innovasea fathom offloads
#'
#' @name fathom
#' @import magrittr
#' @import dplyr
#' @import gsheet
#' @import readr
#' @import lubridate
#' @import tidyr
#' @import purrr
#' @param x
#' @export fathom
#'


fathom <- function(x, n=12) {

m <- gsheet::gsheet2tbl(
  "https://docs.google.com/spreadsheets/d/1l8XHcmFLQvQJExbapCyESCTvF-1U7OqrWFQvYsfQSB8/edit?gid=1085301212#gid=1085301212"
) %>%
  dplyr::select(
    Responsible,
    id = TAG_ID_CODE,
    code = TAG_CODE_SPACE,
    spp = COMMON_NAME_E,
    dmy = UTC_RELEASE_DATE_TIME,
    death = HARVEST_DATE,
    start = TAG_ACTIVATION_DATE,
    end = EST_TAG_LIFE
  ) %>%
  dplyr::mutate(
    start = lubridate::ymd(start),
    end = start + lubridate::days(end)
  ) %>%
  dplyr::select(-start) %>%
  dplyr::mutate(
    dmy = lubridate::parse_date_time(
      dmy,
      orders = c("ymd_HMS", "ymd", "ymd_HM")
    )
  ) %>%
  tidyr::separate(code, c("a", "code")) %>%
  dplyr::select(-a)

fr <- list.files(pattern = "\\.csv$", full.names = TRUE) %>%
  purrr::map_dfr(~ readr::read_csv(.x, skip = n, col_names = FALSE)) %>%
  dplyr::select(
    dt = 2,
    serial = 7,
    id = 11,
    code = 10
  ) %>%
  dplyr::mutate(id = as.character(id)) %>%
  dplyr::filter(grepl("1303", code)) %>%
  tidyr::separate(code, c("a", "code", "b")) %>%
  dplyr::select(-a, -b) %>%
  dplyr::left_join(m, by = c("id", "code"))

return(fathom)
}




