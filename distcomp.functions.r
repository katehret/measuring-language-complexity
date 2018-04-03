#distortion and compression all functions

#compress with GZIP
compress <- function(original.dir, target.dir) {

  lapply(list.files(original.dir), function(x) {
    filename <- paste(original.dir, x, sep="")
    new.filename <- paste(target.dir, x, sep="")
    file.copy(filename, new.filename)
    system(paste("gzip", new.filename, sep=" "))    #"gzip"
  })

}

#sample random number of sentences
getRandomSample <- function(datadir) {

  randomSubset = sapply(list.files(datadir, full.names=TRUE), function (x) readLines(x, n = -1L, encoding = "UTF-8"), simplify = FALSE)


   ##split into sentences

  sentences <- sapply(randomSubset, strsplit, "\\.")

  ##unlist files, get smallest number of sentences
   min.sent <- min(sapply(sentences, function(x) length(unlist(x))))

   sample.size = min.sent*0.1 #keep percentage of data 

  ##list of files containing the same percentage of random sentences
  randomSubset <- lapply(sentences, function(x) {
    
    corp <- unlist(x)
    sample.corp <- sample.int(length(corp), size = sample.size, replace=F)
    paste(corp[sample.corp], collapse=" ")
  
  })

  return(randomSubset)

}

###############################
#morphological distortion
#delete characters function
drop.chars <- function(wordlist, proportion.keep=0.9) {       #proportion.keep=0.9 deletes 10%

  splitvec <- unlist(mapply(function(x, y) rep(x, y),
                     1:length(wordlist), nchar(wordlist)))
  characters <- unlist(sapply(wordlist, strsplit, ""))
  drop <- sample.int(length(characters), floor(length(characters) *
(1-proportion.keep)))
  characters[drop] <- "|"
  new.words <- sapply(split(characters, splitvec), paste, collapse="")
  result <- sapply(new.words, gsub, pattern="|", replace="", fixed=TRUE)

  names(result) <-  NULL
  return(result)

}

#function to apply drop.chars to whole directory and print to target directory
morphdistort <- function(original.dir, target.dir) {

  lapply(list.files(original.dir, full.names = TRUE), function(x){

      old.filename <- paste(x, sep="")
      from <- original.dir
      new.filename <- paste(target.dir, gsub(pattern = from, "", old.filename), sep="")  #D:/test/dutch.txt"

      corpusfile <- readLines(x, n = -1L, encoding = "UTF-8")
      wordcorpfile <- strsplit(corpusfile, " ")
      distcorpfile <- paste(drop.chars(unlist(wordcorpfile)), collapse = " ")

      write <- function (distcorp, filename = "text.txt") {
                 output = paste(sapply(distcorp, paste, collapse="\n"), collapse="\n\n")
                 writeLines(output, con = filename, sep = "\n", useBytes = TRUE)
      }


      write(distcorpfile, new.filename)

  })

}

#######################
#syntactic distortion
#syntactic distortion function

drop.words = function (cont) {

  cont2 <- unlist(strsplit(cont, " "))     #split into words
  N <-  length(cont2)
  sample.vec <- sample.int(N, floor(0.9*N), replace=FALSE)     #sample.int(N, floor(0.9*N) deletes 10%
  sample.vec <- sample.vec[order(sample.vec)]
  paste(cont2[sample.vec], collapse=" ")

}

#function to apply drop.words to whole directory and print to target directory
syndistort <- function(original.dir, target.dir) {

  lapply(list.files(original.dir, full.names = TRUE), function(x){

      old.filename <- paste(x, sep="")
      from <- original.dir
      new.filename <- paste(target.dir, gsub(pattern = from, "", old.filename), sep="")

      corpusfile <- readLines(x, n = -1L, encoding = "UTF-8")
      distcorpfile <- paste(drop.words(unlist(corpusfile)), collapse = " ")


    write <- function (distcorp, filename = "text.txt") {
              output = paste(sapply(distcorp, paste, collapse="\n"), collapse="\n\n")
              writeLines(output, con = filename, sep = "\n", useBytes = TRUE)
    }

      write(distcorpfile, new.filename)

  })

}

###############
#writeout
writeout <- function (cont3, filename = "text.txt") {

  output <- paste(sapply(cont3, paste, collapse="\n"), collapse="\n\n")
  writeLines(output, con = filename, sep = "\n", useBytes = TRUE)

}


###################
#get filesizes
filesizes <- function(directory) {
  sapply(list.files(directory, full.names=T),
         function(x) file.info(x)$size)
}
