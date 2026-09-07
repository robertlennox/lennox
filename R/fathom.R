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
#' @param x Path containing Fathom csv files.
#' @param n Number of header rows to skip when reading files.
#' @export
#'


fathom <- function (x, n = 12)
{
  require(data.table)
  m <- gsheet::gsheet2tbl("https://docs.google.com/spreadsheets/d/1l8XHcmFLQvQJExbapCyESCTvF-1U7OqrWFQvYsfQSB8/edit?gid=1085301212#gid=1085301212") %>%
    dplyr::select(Responsible, oid=ANIMAL_ID, id = TAG_ID_CODE, code = TAG_CODE_SPACE,
                  spp = COMMON_NAME_E, dmy = UTC_RELEASE_DATE_TIME,
                  tag=TAG_MODEL,
                  death = HARVEST_DATE, start = TAG_ACTIVATION_DATE,
                  end = EST_TAG_LIFE,
                  nids=NUMBER_OF_IDS,
                  reused=REUSED_TAG) %>%
    dplyr::mutate(start = lubridate::ymd(start),
                  end = start + lubridate::days(end)) %>% dplyr::select(-start) %>%
    dplyr::mutate(dmy = lubridate::parse_date_time(dmy, orders = c("ymd_HMS",
                                                                   "ymd", "ymd_HM"))) %>%
    tidyr::separate(code, c("a",
                            "code")) %>%
    dplyr::select(-a) %>%
    ungroup

  m<-m %>%
    mutate(oid=case_when(is.na(oid) ~ id, T~oid)) %>%
    group_by(oid) %>%
    mutate(oid=first(id)) %>%
    group_by(code, oid) %>%
    slice(1)

  m<-m %>%
    dplyr::select(tag, id, nids) %>%
    dplyr::mutate(nids = nids - 1) %>%
    dplyr::mutate(id2=case_when(nids==0 ~ NA_real_, nids>0 ~ as.numeric(id)+1)) %>%
    dplyr::mutate(id3 = case_when(nids >= 2 ~ as.numeric(id) + 2, T~NA_real_)) %>%
    ungroup %>%
    gather(key, value,-code, -oid, -tag, -nids) %>%
    arrange(oid) %>%
    dplyr::filter(!is.na(value)) %>%
    mutate(sensor=case_when(
      grepl("JSAT", tag) ~ "ID",
      grepl("1303", code) ~ "ID",
      grepl("TP", tag) & key=="id" ~ "temp",
      grepl("TP", tag) & key=="id2" ~ "depth",
      grepl("AP", tag) & key=="id" ~ "accel",
      grepl("AP", tag) & key=="id2" ~ "depth",
      grepl("DT-LP", tag) & key=="id" ~ "depth",
      grepl("DT-LP", tag) & key=="id2" ~ "temp",
      grepl("V6DT", tag) & key=="id" ~ "eaten",
      grepl("V6DT", tag) & key=="id2" ~ "temp",
      nids==0 & grepl("T", tag) ~ "temp",
      nids==0 & grepl("P", tag) ~ "depth",
      nids==0 & grepl("A", tag) ~ "accel",
      T~"ID")) %>%
    dplyr::select(-nids, -key) %>%
    dplyr::rename(id=value) %>%
    right_join(m %>%
                 dplyr::select(-id), by=c("code", "oid", "tag")) %>%
    dplyr::select(Responsible, oid, code, id, spp, sensor, tag, dmy, death, end, reused)

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
          select = c(2, 7, 10, 11, 12)
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

  m<-m %>%
    group_by(id, code) %>%
    slice(1)

  fathom <- merge(fathom, m, by = c("id", "code"))
  return(fathom)
}





