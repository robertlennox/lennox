## code to prepare `DATASET` dataset goes here

setwd("C:/Users/rb501745/OneDrive - Dalhousie University/lennox/data-raw")
margaree<-readRDS("margaree.RDS")
stewi<-readRDS("stewi.RDS")
wallace<-readRDS("wallace.RDS")
rivers<-readRDS("rivers.RDS")
ns<-readRDS("ns.RDS")
scotian<-readRDS("scotian.RDS")
mil<-sf::st_read("mil.kml")



usethis::use_data(margaree, overwrite = TRUE)
usethis::use_data(stewi, overwrite = TRUE)
usethis::use_data(wallace, overwrite = TRUE)
usethis::use_data(ns, overwrite = TRUE)
usethis::use_data(rivers, overwrite = TRUE)
usethis::use_data(scotian, overwrite = TRUE)
usethis::use_data(mil, overwrite = TRUE)




