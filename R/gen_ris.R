#' Generate .ris for all folders/studies in working directory and save in respective folders called ris.
#'
#' @param singlefile If TRUE it generates a single file, if FALSE generate a file for each DOI.
#' @return Creates a new folder called 'ris-files' and generates and stores *.ris files in it. Those can be imported into Paperpile.
# setwd("C:/Users/pbauer/Desktop/ris files/scraped citations/Fearon 2003")
# file <- "Fearon 2003_citations-1001-1235.csv"
# gen_ris(file)

gen_ris <- function(dois, singlefile=TRUE){

    dois <- dois

    if(singlefile==TRUE){

    length.dois <- length(dois)

    fileConn <- file("./records.ris")
    writeLines(c(rbind(

      rep("TY  - JOUR", length.dois), # Journal article
      paste("DO  - ", dois, sep=""), # DOI
      rep("ER  -", length.dois)

      )) # Separator
    , fileConn)
    close(fileConn)

    }else{

    dir.create("./ris-files/")
    length.dois <- length(dois)
    for (i in 1:length(dois)){ #
      fileConn <- file(paste("./ris-files/", i, " - ", stringr::str_replace_all(dois[i], "[;\\<\\>:/]", ""), ".ris", sep=""))
      writeLines(c("TY  - JOUR",                    # Journal article
                   paste("DO  - ", dois[i], sep="") # DOI
      ), fileConn)
      close(fileConn)
    }

    }

}





