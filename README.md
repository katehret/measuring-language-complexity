## measuring-language-complexity
Kolmogorov complexity, language complexity, compression

### Description

This repository contains all necessary R scripts to implement the compression technique developed and described in 

* Ehret, Katharina (2017).  "An information-theoretic approach to language complexity: variation in naturalistic corpora". FreiDok plus, Universität Freiburg. DOI: 10.6094/UNIFR/12243.

This research was sparked by the typological-sociolinguistic complexity debate. Originally concerned with the question of whether or not all languages are equally complex, the focus of the debate has recently moved to developing and comparing metrics of language complexity. 

Against this backdrop, Ehret (2017) explores the use and applicability of Kolmogorov complexity as a complexity metric in naturalistic corpora. Kolmogorov complexity can be conveniently approximated with compression algorithms and measures the information content, or complexity of texts in terms of the predictability of new text passages on the basis of previously seen text passages. Basically, texts which can be compressed more efficiently are linguistically less complex. In combination with various distortion techniques, the measure can be used to assess complexity at the morphological and syntactic level. 

This repository comprises the following items:

* distcomp_functions.r
  An R script with functions for morphological and syntactic manipulation of texts. 
  
* distcomp_loop.r
  An R script which applies the functions for morphological and syntactic manipulation of texts to an entire corpus and repeats this process a specified number of times.

* sample_data.zip
  


### Getting started

1. Software requirements

Before getting started you need to install R (available from:https://www.r-project.org/) and gzip (available from: http://www.gzip.org/).

2. Folder structure

Save all R scripts in the same directory of your choice. Make sure you include the proper path to the scripts when calling them in R. 

Create a directory containing two folders with the names "data" and "temp". Unzip the sample data and move the text files to the folder named "data".


3. Input data

The distortion and compression loop takes plain text files (file extension
.txt) as input. It is designed to work on multiple-file datasets, i.e. you need
to provide at least two text files.

All end-of-sentence markers need to be replaced with a single fullstop so that the script can create samples of random sentences.

Further non-mandatory text processing: To obtain reliable results it is further recommended to convert your text files to lowercase, remove all non-alphabetical characters (i.e. XML or corpus mark-up, quotation marks, numbers, commas, hyphens, or special symbols like @,#,$ as well as invisible UTF-characters, etc.). 


4. Calling the loop

Open R. Load the distortion and compression loop with 

  source("pathtoscript/distcomp_loop.r")

Start the loop and save your results with the measure.complexity() function.
This function takes two arguments:
1. The name of the directory where the data and temp folders are located.
2. The number of repetitions you wish to apply. The customary number of repetitions applied with the compression technique is n = 1000 (cf. Ehret 2017; Ehret and
Szmrecsanyi 2016).

  result <- measure.complexity("yourdirectory/", repetitions)


Note that the software has been developed and tested on Debian GNU/Linux 9.4. It has not been tested on Windows.



References

Ehret, Katharina (2017).  “An information-theoretic approach to language complexity: variation in naturalistic corpora”. FreiDok plus, Universität Freiburg. DOI: 10.6094/UNIFR/12243. 

Ehret, Katharina & Benedikt Szmrecsanyi (2016). “An information-theoretic approach to assess linguistic complexity”. In: Raffaela Baechler & Guido Seiler (eds.), Complexity, Isolation, and Variation, 71-94. Berlin: de Gruyter. 
