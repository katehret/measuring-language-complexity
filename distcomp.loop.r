#distortion & compression loop
source("distcomp.functions.r")


#set up directories
getDataDir <- function(basedir){
file.path(basedir, "data")
}

getTempDir <- function(basedir){
file.path(basedir, "temp")
}

setupTempDir <- function(basedir){

dirname <- getTempDir(basedir)
  
dir.create(file.path(dirname, "corpus/"))
dir.create(file.path(dirname, "corpus.compressed/"))
dir.create(file.path(dirname, "morphdistort/"))
dir.create(file.path(dirname, "morphdistort.compressed/"))
dir.create(file.path(dirname, "syndistort/"))
dir.create(file.path(dirname, "syndistort.compressed/"))           
}

cleanTempDir <- function(basedir) {
  lapply(list.files(getTempDir(basedir), full.names=TRUE), unlink, recursive=TRUE)
}

#distortion and compression function
measure.complexity = function(basedir, repetitions) {
  lapply(1:repetitions, function(x) {

    ##RANDOMSAMPLING: sample random number of sentences  #valid for e.g. AliceResampling, use fullstops data

    randomSubset <-  getRandomSample(getDataDir(basedir))
    
      
    ##name files and writeout whole corpus
    setupTempDir(basedir)
    
    lapply(names(randomSubset), function(x) {
      cleanname = gsub(".txt", "", basename(x))
      newname = file.path(getTempDir(basedir), "corpus",
        paste(cleanname, "_random.txt", sep=""))
      writeout(paste(randomSubset[[x]], collapse = ""), newname)
    })

    ##distort
    morphdistort(file.path(getTempDir(basedir), "corpus/"),
                 file.path(getTempDir(basedir), "morphdistort/"))
    
    syndistort(file.path(getTempDir(basedir), "corpus/"),
                 file.path(getTempDir(basedir), "syndistort/"))

    ##compress
    compress(file.path(getTempDir(basedir), "corpus/"),
             file.path(getTempDir(basedir), "corpus.compressed/"))

    compress(file.path(getTempDir(basedir), "morphdistort/"),
             file.path(getTempDir(basedir), "morphdistort.compressed/"))

    compress(file.path(getTempDir(basedir), "syndistort/"),
             file.path(getTempDir(basedir), "syndistort.compressed/"))


    ##create dataframe
    df = data.frame(orig.uncomp = filesizes(
      file.path(getTempDir(basedir), "corpus/")))
    ##take file sizes and stick in df
    df$orig.comp = filesizes(
      file.path(getTempDir(basedir), "corpus.compressed/"))
    df$morphdist.uncomp =  filesizes(
      file.path(getTempDir(basedir), "morphdistort/"))
    df$morphdist.comp = filesizes(
      file.path(getTempDir(basedir), "morphdistort.compressed/"))
    df$syndist.uncomp = filesizes(
      file.path(getTempDir(basedir), "syndistort/"))
    df$syndist.comp = filesizes(
      file.path(getTempDir(basedir), "syndistort.compressed/"))

    rownames(df) <- gsub("_.*", "", basename(rownames(df)))
    
    ##add ratios to df
    df$morphratio <- df$morphdist.comp / df$orig.comp * -1
    df$synratio <- df$syndist.comp / df$orig.comp
    
    
    cleanTempDir(basedir)
    return(df)
    
  })}


#call to start distortion and compression loop
#result <- measure.complexity("yourdirectory/", 1000)
