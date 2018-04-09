#' Fetches documents from paperpile gdrive folder and copies to folder (delete files if there are any in there).
#'
#' @param from The directory of the paperpile folder.
#' @param to The folder to which you would like to copy the files.
#' @param citations The dataframe that contains the citations, collected through the Web of Knowledge.
#' @return Makes copies of relevant PDFs and stores them in "to" folder. Be careful, if the folder exists already it deletes it.


fetch_docs <- function(from, to, citations) {



  # Create documents folder in respective study folder (or empty present one)
  if(dir.exists(paste(to, sep = ""))==TRUE){
    unlink(paste(to, sep = ""), recursive = T)} # delete files in folder

  if(dir.exists(paste(to, sep = ""))==FALSE){ # create folder if it does not exist
    dir.create(paste(to, sep = ""))}





  x.default <- dir(from, recursive = T)


  # Loop to put PDF files in one folder
  # Finds PDF files in paperpile folder
  # Copies them to a new folder

  for (i in 1:nrow(citations)){
    if(stringr::str_detect(as.character(i), "[0-9]*0")){cat(i, ".. ", sep="")}
    AU <- stringr::str_replace(stringr::str_extract(citations$AU[i], "[:alpha:]*,"), ",", "")
    PY <- citations$PY[i]
    TIT <- stringr::str_extract(citations$TI[i], "[:word:]*\\s[:word:]*\\s[:word:]*\\s[:word:]*\\s[:word:]*\\s[:word:]*")




    x <- x.default
    # x <- x[stringr::str_detect(x, stringr::coll(AU, TRUE))]
    # x <- x[stringr::str_detect(x, stringr::coll(PY, TRUE))]
    # x <- x[stringr::str_detect(x, stringr::coll(TIT, TRUE))]
    x <- x[stringr::str_detect(x, regex(TIT, ignore_case = T))] # ignore CAPS

    if(length(x)>=10){ # only author and year
      str <- c(AU, PY)
      x <- x[apply(sapply(str, grepl, x), 1, all)] # ig
      }


    file.path.half <- x



    if(length(file.path.half)!=0){
    # paperpile folder where file is
    from2 <- paste(from, "/", file.path.half, sep="")

    to2 <- paste(to, "/",
                stringr::str_replace(file.path.half, "All Papers/[A-Z]/", ""), sep="")
    file.copy(from2, to2, overwrite = T, recursive = FALSE,
              copy.mode = TRUE)
    }


  }
  # cat("\n Wow.. copying took only ", as.numeric(time[3]), " second(s) for ", to, ". Amazing!", sep = "")
  }


