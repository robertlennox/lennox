#'
#' function to quickly format files from Innovasea fathom offloads
#'
#' @name fathom
#' @import magrittr
#' @import dplyr
#' @import gsheet
#' @import data.table
#' @import readr
#' @import lubridate
#' @import tidyr
#' @import purrr
#' @param x
#' @export fathom
#'


fathom <- function (x, n = 12)
{
  m <- gsheet::gsheet2tbl("https://docs.google.com/spreadsheets/d/1l8XHcmFLQvQJExbapCyESCTvF-1U7OqrWFQvYsfQSB8/edit?gid=1085301212#gid=1085301212") %>%
    dplyr::select(Responsible, id = TAG_ID_CODE, code = TAG_CODE_SPACE,
                  spp = COMMON_NAME_E, dmy = UTC_RELEASE_DATE_TIME,
                  death = HARVEST_DATE, start = TAG_ACTIVATION_DATE,
                  end = EST_TAG_LIFE) %>% dplyr::mutate(start = lubridate::ymd(start),
                                                        end = start + lubridate::days(end)) %>% dplyr::select(-start) %>%
    dplyr::mutate(dmy = lubridate::parse_date_time(dmy, orders = c("ymd_HMS",
                                                                   "ymd", "ymd_HM"))) %>%
    tidyr::separate(code, c("a",
                            "code")) %>%
    dplyr::select(-a)

  m<-m %>%
    group_by(code, id) %>%
    slice(1)

  files <- list.files(pattern = "\\.csv$", full.names = TRUE)

  fathom <- data.table::rbindlist(
    lapply(files, function(f) {
      tryCatch(
        data.table::fread(
          f,
          skip = n,
          header = FALSE,
          colClasses = "character",
          showProgress = FALSE,
          select = c(2, 7, 10, 11, 13)
        ),
        error = function(e) NULL
      )
    }),
    use.names = FALSE
  )

  data.table::setnames(
    fathom,
    c("dt", "serial", "code", "id", "Data")
  )

  fathom[, `:=`(
    dt = as.POSIXct(dt, tz = "UTC"),
    Data = as.numeric(Data)
  )]

  fathom[, c("a", "code", "b") := tstrsplit(code, split = "-")]
  fathom[, c("a", "b") := NULL]


  fathom <- data.table::merge(
    fathom,
    m,
    by = c("id", "code"),
    all.x = TRUE
  )
  return(fathom)
}




