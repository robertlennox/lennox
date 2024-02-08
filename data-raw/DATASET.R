## code to prepare `DATASET` dataset goes here

setwd("C:/Users/rb501745/OneDrive - Dalhousie University/lennox/data-raw")
cb_rivers<-readRDS("cb_rivers.RDS")
margaree<-readRDS("margaree.RDS")
stewi<-readRDS("stewi.RDS")
wallace<-readRDS("wallace.RDS")

usethis::use_data(cb_rivers, overwrite = TRUE)
usethis::use_data(margaree, overwrite = TRUE)
usethis::use_data(stewi, overwrite = TRUE)
usethis::use_data(wallace, overwrite = TRUE)


