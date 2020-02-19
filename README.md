# measuring-language-complexity
Kolmogorov complexity, language complexity, compression

### Description

This repository contains all necessary R scripts to implement the compression technique developed and described in 

* Ehret, Katharina (2017).  "[An information-theoretic approach to language complexity: variation in naturalistic corpora](https://freidok.uni-freiburg.de/data/12243)". FreiDok plus, Universität Freiburg. DOI: 10.6094/UNIFR/12243.

This research was sparked by the typological-sociolinguistic complexity debate. Originally concerned with the question of whether or not all languages are equally complex, the focus of the debate has recently moved to developing and comparing metrics of language complexity. 

Against this backdrop, Ehret (2017) explores the use and applicability of Kolmogorov complexity as a complexity metric in naturalistic corpora. Kolmogorov complexity can be conveniently approximated with compression algorithms and measures the information content, or complexity of texts in terms of the predictability of new text passages on the basis of previously seen text passages. Basically, texts which can be compressed more efficiently are linguistically less complex. In combination with various distortion techniques, the measure can be used to assess complexity at the morphological and syntactic level. 

### Overview of the files

This repository comprises the following items:

#### distcomp_functions.r

An R script containing all functions necessary for the morphological and syntactic manipulation (distortion) of text files, and their subsequent compression. It also contains several other functions for implementing the compression technique. Morphological manipulation is achieved through the deletion of 10% of all alphabetically transcribed characters in a text file. Syntactic manipulation is achieved through the deletion of 10% of all alphabetically transcribed word tokens in a text file. For more details on how text manipulation works and how morphological and syntactic complexity need to be defined in this context see Ehret (2018, 2017).
  
#### distcomp_loop.r
 
An R script which applies the functions for morphological and syntactic manipulation to an entire corpus (collection of text files) and repeats this process a specified number of times. In this process, random samples of the text files are drawn.

#### sample_data.zip
  
A zip archive containing a folder called "data" which comprises 4 text files of the Gospel of Mark. The text files have been lowercased, all numbers and other non-alphabetical characters have been removed. All end-of sentence markers (punctuation including semi-colons) were replaced with a single fullstop.

* English_ESV_21c.formatted.txt
* Finnish_20c.formatted.txt
* French_20c.formatted.txt
* German_20c.formatted.txt

### Getting started

#### 1. Software requirements

Before getting started you need to install R (available from:https://www.r-project.org/) and gzip (available from: http://www.gzip.org/).

#### 2. Folder structure

Save all R scripts in the same directory of your choice. Make sure you include the proper path to the scripts when calling them in R. 

Create a directory containing two folders with the names "data" and "temp". Unzip the sample data and move the text files to the folder named "data".

#### 3. Input data

The distortion and compression loop takes plain text files (file extension
.txt) as input. It is designed to work on multiple-file datasets, i.e. you need
to provide at least two text files.

All end-of-sentence markers need to be replaced with a single fullstop so that the script can create samples of random sentences.

Further non-mandatory text processing: To obtain reliable results it is further recommended to convert your text files to lowercase and remove all non-alphabetical characters (i.e. XML or corpus mark-up, quotation marks, numbers, commas, hyphens, or special symbols like @,#,$ as well as invisible UTF8-characters, etc.). 

#### 4. How to use the scripts

Open R. Load the distortion and compression loop with 

        source("pathtoscript/distcomp_loop.r")

Start the loop and save your results with the measure.complexity() function.
This function takes two arguments:
1. The name of the directory where the data and temp folders are located.
2. The number of repetitions you wish to apply. The customary number of repetitions applied with the compression technique is N = 1000.

        result = measure.complexity("yourdirectory/", repetitions)

This returns a dataframe with...

Note that the software has been developed and tested on Debian GNU/Linux 9.4. It has not been tested on Windows.


### Related publications

Ehret, Katharina & Benedikt Szmrecsanyi (2019). "Compressing learner language: an information-theoretic measure of complexity in SLA".  *Second Language Research*. 35(1), 23-45. DOI: [10.1177/0267658316669559](https://journals.sagepub.com/doi/abs/10.1177/0267658316669559)

Ehret, Katharina (2018a). "An information-theoretic view on language complexity and register variation: Compressing naturalistic corpus data".  *Corpus Linguistics and Linguistic Theory*.  DOI: https://doi.org/10.1515/cllt-2018-0033. (Ahead of Print)

Ehret, Katharina (2018b). "[Kolmogorov complexity as a universal measure of language complexity](http://www.christianbentz.de/MLC2018/Ehret.pdf)". In: Aleksandrs Berdicevskis & Christian Bentz  (eds.), *Proceedings of the First Shared Task on Measuring Language Complexity*, 8-14. Workshop on "Measuring Language Complexity", EvoLang XII, Torun, Poland.

Ehret, Katharina (2017).  "[An information-theoretic approach to language complexity: variation in naturalistic corpora](https://freidok.uni-freiburg.de/data/12243)". FreiDok plus, Universität Freiburg. DOI: 10.6094/UNIFR/12243.

Ehret, Katharina & Benedikt Szmrecsanyi (2016b). "An information-theoretic approach to assess linguistic complexity". In: Raffaela Baechler & Guido Seiler (eds.), *Complexity, Isolation, and Variation*, 71-94. Berlin: de Gruyter. 
