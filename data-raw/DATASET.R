## data-raw/DATASET.R
##
## Script to prepare package datasets

library(sf)
library(usethis)
library(here)

# Load datasets -----------------------------------------------------------

margaree <- readRDS(here("data-raw", "margaree.RDS"))
stewi <- readRDS(here("data-raw", "stewi.RDS"))
wallace <- readRDS(here("data-raw", "wallace.RDS"))
rivers <- readRDS(here("data-raw", "rivers.RDS"))
ns <- readRDS(here("data-raw", "ns.RDS"))
scotian <- readRDS(here("data-raw", "scotian.RDS"))
lab <- readRDS(here("data-raw", "labsea.RDS"))
nshires <- readRDS(here("data-raw", "nshires.RDS"))

inverness <- readRDS(
  here("data-raw", "inverness_harbour.rds")
)

cheticamp <- readRDS(here("data-raw", "cheticamp_harbour.rds"))
