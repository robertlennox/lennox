#'
#' function to quickly format files from OTN data extracts
#'
#' @name otnr
#' @import magrittr
#' @import dplyr
#' @import gsheet
#' @import readr
#' @import lubridate
#' @import tidyr
#' @import purrr
#' @param parquet
#' @export otnr
#'


otnr<-function(parquet){
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

otnr<-parquet %>%
  dplyr::select(dt=dateCollectedUTC, x=decimalLongitude, y=decimalLatitude,
                id=tagName, Data=sensorValue) %>%
  mutate(id=case_when(grepl("R", id) ~ gsub("R64K", "A69-1303", id),
                      T~id)) %>%
  separate(id, c("a", "code", "id")) %>%
  dplyr::select(-a) %>%
  left_join(m, by=c("id", "code")) %>%
  mutate(frac=as.numeric(dt-floor_date(dt))) %>%
  ungroup %>%
  dplyr::filter(date(dt)>=dmy | is.na(dmy))}
