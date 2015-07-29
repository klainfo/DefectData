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
    getSystemName <- function(data) {sapply(strsplit(basename(data),"\\."), function(x) paste(x[1:(length(x)-1)], collapse="."))}
    
    return(list(
        "mccabe" = getSystemName(list.files(system.file("extdata/terapromise/mccabe", package = "DefectData"))),
        "ck" = getSystemName(list.files(system.file("extdata/terapromise/ck", package = "DefectData"))),
        "eclipse" = getSystemName(list.files(system.file("extdata/zimmermann", package = "DefectData"))),
        "kim" = getSystemName(list.files(system.file("extdata/kim", package = "DefectData"))) ,
        "ambros" = getSystemName(list.files(system.file("extdata/ambros", package = "DefectData")))
    ))
}

