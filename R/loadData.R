#' A Load Defect Data function
#'
#' This function allows you to load defect data in software engineering research
#'
#' @param system_name system_name name
#' @export
#' @return an object of data
#' 
#' @examples
#' data <- loadData("jdt")
#' data$dep
#' data$indep
#' data$data
#' 
loadData <- function(system_name){
    
    library(foreign)
    library(e1071) 
    library(base)
    
    repo <- names(listData())[grep(system_name, listData())]

    read.mccabe <- function(system_name){
        filename <- system.file("extdata/terapromise/mccabe",paste0(system_name,".arff"), package = "DefectData")
        data <- read.arff(filename)
        dep <- "Defective"
        switch(system_name, 
               JM1={    dep <- "label" },
               ar1={    dep <- "defects" },
               ar3={    dep <- "defects" },
               ar4={    dep <- "defects" },
               ar5={    dep <- "defects" },
               ar6={    dep <- "defects" },
               kc2={    dep <- "problems" },
                   { dep <- "Defective"}
                )  
        data[,dep] <- ifelse(data[,dep] %in% c("Y","true","yes") , T, F)
        indep <- colnames(data)[!colnames(data) %in% dep]
        return(list(data = data[,c(indep,dep)], dep = dep, indep = indep))
    }
    
    read.ck <- function(system_name){
        filename <- system.file("extdata/terapromise/ck",paste0(system_name,".csv"), package = "DefectData")
        data <- read.csv(filename)
        dep <- "bug" 
        data[,dep] <- ifelse(data[,dep] > 0, T, F)
        indep <- c("wmc","dit","noc","cbo","rfc","lcom","ca","ce","npm","lcom3","loc","dam","moa","mfa","cam","ic","cbm","amc","max_cc","avg_cc")
        return(list(data = data[,c(indep,dep)], dep = dep, indep = indep))
    }
    
    read.eclipse <- function(system_name){
        filename <- system.file("extdata/zimmermann/",paste0(system_name,".csv"), package = "DefectData")
        data <- read.csv(filename, sep=";")
        dep <- "post"
        indep <- c("pre","ACD","FOUT_avg","FOUT_max","FOUT_sum","MLOC_avg","MLOC_max","MLOC_sum","NBD_avg","NBD_max","NBD_sum","NOF_avg","NOF_max","NOF_sum","NOI","NOM_avg","NOM_max","NOM_sum","NOT","NSF_avg","NSF_max","NSF_sum","NSM_avg","NSM_max","NSM_sum","PAR_avg","PAR_max","PAR_sum","TLOC","VG_avg","VG_max","VG_sum")
        data[,indep] <- lapply(data[,indep], function(x) as.numeric(as.character(x)))
        data[,dep] <- ifelse(data[,dep] > 0, T, F)
        return(list(data = data[,c(indep,dep)], dep = dep, indep = indep))
    }
    
    read.kim <- function(system_name){
        filename <- system.file("extdata/kim",paste0(system_name,".arff"), package = "DefectData")
        data <- read.arff(filename)
        dep <- "isDefective"
        indep <- colnames(data)[!colnames(data) %in% c(dep,"defect_num")]
        data[,dep] <- ifelse(data[,dep] %in% c("buggy","TRUE") , T, F)
        return(list(data = data[,c(indep,dep)], dep = dep, indep = indep))
    }
    
    
    read.ambros <- function(system_name){
        filename <- system.file("extdata/ambros/",paste0(system_name,".csv"), package = "DefectData")
        data <- read.csv(filename, sep=";")
        dep <- "bugs"
        indep <- colnames(data)[c(2:16)]
        data[,dep] <- ifelse(data[,dep] > 0, T, F)
        return(list(data = data[,c(indep,dep)], dep = dep, indep = indep))
    }
    pool <- NULL
    switch(repo, 
           mccabe={    pool <- read.mccabe(system_name) },
           ck={     pool <- read.ck(system_name) },
           eclipse={    pool <- read.eclipse(system_name) },
           kim={    pool <- read.kim(system_name) },
           ambros={    pool <- read.ambros(system_name) }
    )  
    pool
}


