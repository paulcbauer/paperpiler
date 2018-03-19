#' Fetches documents from paperpile gdrive folder and copies to folder.
#'
#' @param paperpile_dir The directory of the paperpile folder.
#' @param folder folder...
#' @param file file...
#' @return Makes copies of relevant PDFs and stores them in folder.


fetch_docs <- function(paperpile_dir, folder, file) {



  # Create documents folder in respective study folder (or empty present one)
  if(dir.exists(paste("./", folder, sep = ""))==TRUE){
    unlink(paste("./", folder, sep = ""), recursive = T)} # delte folder

  if(dir.exists(paste("./", folder, sep = ""))==FALSE){
    dir.create(paste("./", folder, sep = ""))}





  x.default <- dir(paperpile_dir, recursive = T)

  citations <- read.table(paste("./", file, sep=""), header=TRUE, stringsAsFactors = F)
  # Loop to put PDF files in one folder
  # Finds PDF files in paperpile folder
  # Copies them to a new folder

  for (i in 1:nrow(citations)){
    if(stringr::str_detect(as.character(i), "[0-9]*0")){cat(i, ".. ", sep="")}
    AU <- stringr::str_replace(stringr::str_extract(citations$author[i], "[:alpha:]*,"), ",", "")
    PY <- citations$year[i]
    TIT <- stringr::str_extract(citations$title[i], "[:word:]*\\s[:word:]*\\s[:word:]*\\s[:word:]*\\s[:word:]*\\s[:word:]*")



    # TEST
      # x.default <- c("Trashed Papers/Rothgeb 1990 - INVESTMENT DEPENDENCE AND POLITICAL-CONFLICT IN THIRD-WORLD COUNTRIES.pdf",
      #                "All Papers/Y/Young 2009 - State Capacity, Democracy, and the Violation of Personal Integrity Rights.pdf")
      # AU <- "Rothgeb"
      # PY <- "1990"
      # TIT <- "Investment dependence"

    # identify articles - only by year and first three words of title
    x <- x.default
    # x <- x[stringr::str_detect(x, stringr::coll(AU, TRUE))]
    # x <- x[stringr::str_detect(x, stringr::coll(PY, TRUE))]
    x <- x[stringr::str_detect(x, stringr::coll(TIT, TRUE))]
    file.path.half <- x



    if(length(file.path.half)!=0){
    # paperpile folder where file is
    from <- paste(paperpile_dir, file.path.half, sep="")

    to <- paste("./", folder, "/",
                stringr::str_replace(file.path.half, "All Papers/[A-Z]/", ""), sep="")
    file.copy(from, to, overwrite = T, recursive = FALSE,
              copy.mode = TRUE)
    }


  }
  # cat("\n Wow.. copying took only ", as.numeric(time[3]), " second(s) for ", folder, ". Amazing!", sep = "")
  }


