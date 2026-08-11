#' Cape Breton Rivers 
#'
#' A `sf` object that contains all the rivers in Cape Breton, Nova Scoatia.
#' The CRS is `WGS84(DD)`
#' @format A `sf` object with 8 fields and 2268 features.
#'  \describe{
#'    \item{feat_code}{The feature code}
#'    \item{feat_desc}{The feature description}
#'    \item{rivname_1}{The first river name}
#'    \item{rivname_2}{The second river name}
#'    \item{zvalue}{The z value - (depth? in m)}
#'    \item{shape_len}{The length of the shape in km}
#'    \item{shape_fid}{The shape feature ID}
#'    \item{geometry}{The geometry of the shape}
#' }
#'
"cb_rivers"

#' Cheticamp 
#'
#' A `sf` object that contains the Cheticamp habour and the associated lakes and rivers 
#' in the area.
#' The CRS is `NAD83(CSRS) / UTM zone 20N + CGVD28 height`
#' @format A `sf` object with 0 fields and 1 features.
#'  \describe{
#'    \item{geometry}{The geometry of the shape}
#' }
#'
"cheticamp"

#' Eastern Canada 
#'
#' A `sf` object that contains eastern Canada including Quebec, New Brunswick, Nova Scotia, 
#' Prince Edward Island, and Newfoundland and Labrador. 
#' The CRS is `PCS_Lambert_Conformal_Conic`
#' @format A `sf` object with 0 fields and 1 features.
#'  \describe{
#'    \item{pruid}{The shape feature ID}
#'    \item{prname}{The province names both English and French} 
#'    \item{prename}{The province names in Enlgish}
#'    \item{prfname}{The province names in French}
#'    \item{preabbr}{The province abbrivations in Enlgish}
#'    \item{prfabbr}{The province abbrivations in French}
#'    \item{geometry}{The geometry of the shape}
#' }
#'
"eastern_canada"

#' Inverness
#'
#' A `sf` object that contains the Inverness harbour. 
#' The CRS is `NAD83(CSRS) / UTM zone 20N + CGVD28 height`
#' @format A `sf` object with 0 fields and 1 features.
#'  \describe{
#'    \item{geometry}{The geometry of the shape}
#' }
#'
"inverness"

#' Lab
#'
#' A `RasterLayer` object that contains ????
#' The CRS is `+proj=longlat +datum=WGS84 +no_defs`
#' @format A `RasterLayer`
#'
"lab"

#' Margaree
#'
#' A `sf` object that contains all the Margaree River in Cape Breton, Nova Scotia.
#' The CRS is `WGS84(DD)`
#' @format A `sf` object with 7 fields and 844 features.
#'  \describe{
#'    \item{feat_code}{The feature code}
#'    \item{feat_desc}{The feature description}
#'    \item{rivname_1}{The first river name}
#'    \item{rivname_2}{The second river name}
#'    \item{zvalue}{The z value - (depth? in m)}
#'    \item{shape_len}{The length of the shape in km}
#'    \item{shape_fid}{The shape feature ID}
#'    \item{geometry}{The geometry of the shape}
#' }
#'
#'
"margaree"

#' Milipsigate Lake 
#'
#' A `sf` object that contains the Milipsigate Lake, Nova Scotia. 
#' 
#' The CRS is `WGS 84`
#' @format A `sf` object with 0 fields and 1 features.
#'  \describe{
#'    \item{Name}{The feature name}
#'    \item{Description}{The feature description}
#'    \item{geometry}{The geometry of the shape}
#' }
#'
"mil"

#' Nova Scotia - Broad
#'
#' A `sf` object that contains Nova Scotia in broad detail. 
#' 
#' The CRS is `WGS 84`
#' @format A `sf` object with 0 fields and 1 features.
#'  \describe{
#'    \item{geometry}{The geometry of the shape}
#' }
#'
"nshires"

#' Study Rivers of Interest
#'
#' A `sf` object that contains Nova Scotia study rivers of interest. 
#' 
#' The CRS is `NAD83(CSRS) / UTM zone 20N`
#' @format A `sf` object with 1 fields and 764 features.
#'  \describe{
#'    \item{river}{The name of the river}
#'    \item{geometry}{The geometry of the shape}
#' }
#'
"rivers"

#' Scotian
#'
#' A `RasterLayer` object that contains ????
#' The CRS is `+proj=longlat +datum=WGS84 +no_defs`
#' @format A `RasterLayer`
#'
"scotian"

#' Wallace River
#'
#' A `sf` object that contains all the Wallace River, Nova Scotia.
#' The CRS is `WGS84(DD)`
#' @format A `sf` object with 7 fields and 600 features.
#'  \describe{
#'    \item{feat_code}{The feature code}
#'    \item{feat_desc}{The feature description}
#'    \item{rivname_1}{The first river name}
#'    \item{rivname_2}{The second river name}
#'    \item{zvalue}{The z value - (depth? in m)}
#'    \item{shape_len}{The length of the shape in km}
#'    \item{shape_fid}{The shape feature ID}
#'    \item{geometry}{The geometry of the shape}
#' }
#'
#'
"wallace"