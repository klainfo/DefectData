source("R/loadData.R")

indexing <- function(){
    library(reshape)
    
    getSystemName <- function(data) {sapply(strsplit(basename(data),"\\."), function(x) paste(x[1:(length(x)-1)], collapse="."))}
    
    index <- list(
        "mccabe" = getSystemName(list.files("inst/extdata/terapromise/mccabe")),
        "ck" = getSystemName(list.files("inst/extdata/terapromise/ck")),
        "eclipse" = getSystemName(list.files("inst/extdata/zimmermann")),
        "kim" = getSystemName(list.files("inst/extdata/kim")) ,
        "ambros" = getSystemName(list.files("inst/extdata/ambros"))
    )
    
    index <- melt(index)
    colnames(index) <- c("system","corpus")
    properties <- NULL
    for(system in index$system){
        print(system)
        pool <- loadData(system=system,corpus=index[index$system==system,]$corpus)
        data <- pool[["data"]]
        dep <- pool[["dep"]]
        indep <- pool[["indep"]]
        ratio <- as.numeric(table(data[,dep])[2]/length(data[,dep])*100)
        obs <- as.numeric(dim(data)[1])
        properties <- rbind(properties, c("DefectiveRatio"=ratio, 
                                          "Modules"=obs, 
                                          "Defective"=table(data[,dep])[2], 
                                          "Predictors"=length(indep), 
                                          "EPV"=table(data[,dep])[2]/length(indep)
        ))
    }
    return(cbind(index,data.frame(properties)))
}

listData <- indexing()
colnames(listData) <- c("system","corpus","DefectiveRatio","Modules","Defective","Predictors","EPV")
save(listData,file="data/listData.rda")
