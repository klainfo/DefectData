#' A list defect data function
#'
#' This function allows you to list all defect datasets that are available in this R package
#' 
#' @export
#' @examples
#' listData()
#' 
#' 
listData <- function(){
    return(list(
        "mccabe" = getSystemName(list.files("inst/extdata/terapromise/mccabe")),
        "ck" = getSystemName(list.files("inst/extdata/terapromise/ck")),
        "eclipse" = getSystemName(list.files("inst/extdata/zimmermann")),
        "kim" = getSystemName(list.files("inst/extdata/kim")) ,
        "ambros" = getSystemName(list.files("inst/extdata/ambros"))
    ))
}