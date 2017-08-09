#' Generate .ris for all folders/studies in working directory and save in respective folders called ris.
#'
#' @return Creates a new folder called 'ris-files' and generates and stores *.ris files in it. Those can be imported into Paperpile.

# setwd("C:/Users/pbauer/Desktop/ris files/scraped citations/Fearon 2003")
# file <- "Fearon 2003_citations-1001-1235.csv"
# gen_ris(file)

gen_ris <- function(dois){

    dois <- dois
    # citations <- read.table(file, header=TRUE, stringsAsFactors = F)


    dir.create("./ris-files/")
    for (i in 1:length(dois)){ #
      fileConn <- file(paste("./ris-files/", i, " - ", stringr::str_replace_all(dois[i], "[;\\<\\>:/]", ""), ".ris", sep=""))
      writeLines(c("TY  - JOUR",                    # Journal article
                   paste("DO  - ", dois[i], sep="") # DOI
      ), fileConn)
      close(fileConn)
    }

    # for (i in 1:nrow(citations)){ #
    #   fileConn <- file(paste(i, " - ", stringr::str_replace_all(citations$doi[i], "[;\\<\\>:/]", ""), ".ris", sep=""))
    #   writeLines(c("TY  - JOUR",
    #                #paste("AU  - ", citations$author[i], sep=""),
    #                # paste("PY  - ", citations$year[i], sep=""),
    #                #paste("JO  - ", citations$journal[i], sep=""),
    #                paste("DO  - ", citations$doi[i], sep="")#,
    #                #paste("TI  - ", citations$title[i], sep="")
    #                ), fileConn)
    #   close(fileConn)
    # }

}





