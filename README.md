# measuring-language-complexity

Scripts and sample data for the compression technique (Ehret 2017, 2018) (version 1.0)

### DOI

[![DOI](https://zenodo.org/badge/127963705.svg)](https://zenodo.org/badge/latestdoi/127963705)

https://zenodo.org/badge/latestdoi/127963705


### Description

This repository contains all necessary R scripts to implement the compression technique developed and described in 

* Ehret, Katharina (2017).  "[An information-theoretic approach to language complexity: variation in naturalistic corpora](https://freidok.uni-freiburg.de/data/12243)". FreiDok plus, Universität Freiburg. DOI: 10.6094/UNIFR/12243.

This research was sparked by the typological-sociolinguistic complexity debate. Originally concerned with the question of whether or not all languages are equally complex, the focus of the debate has recently moved to developing and comparing metrics of language complexity. 

Against this backdrop, Ehret (2017) explores the use and applicability of Kolmogorov complexity as a complexity metric in naturalistic corpora. Kolmogorov complexity can be conveniently approximated with compression algorithms and measures the information content, or complexity of texts in terms of the predictability of new text passages on the basis of previously seen text passages. Basically, texts which can be compressed more efficiently are linguistically less complex. In combination with various distortion techniques, the measure can be used to assess complexity at the morphological and syntactic level. 

### Overview of the files

This repository comprises the following items (in alphabetical order):

#### complexity_analysis.r

A file with R commands to calculate complexity scores for overall, morphological and syntactic complexity as described in Ehret (2017).

#### distcomp_functions.r

An R script containing all functions necessary for the morphological and syntactic manipulation (distortion) of text files, and their subsequent compression. It also contains several other functions for implementing the compression technique. Morphological manipulation is achieved through the deletion of 10% of all alphabetically transcribed characters in a text file. Syntactic manipulation is achieved through the deletion of 10% of all alphabetically transcribed word tokens in a text file. For more details on how text manipulation works and how morphological and syntactic complexity need to be defined in this context see Ehret (2018, 2017).
  
#### distcomp_loop.r
 
An R script which applies the functions for morphological and syntactic manipulation to random samples of all files in a corpus (collection of text files) for a specified number of repetitions.

#### sample_data.zip
  
A zip archive containing a folder called "data" which comprises 4 text files of the Gospel of Mark. The text files have been lowercased, all numbers and other non-alphabetical characters have been removed. All end-of sentence markers (punctuation including semi-colons, colons, question marks and exclamation marks) were replaced with a single fullstop.

* English_ESV_21c.txt
* Finnish_20c.txt
* French_20c.txt
* German_20c.txt

### Getting started

#### 1. Software requirements

Before getting started you need to install R (available from:https://www.r-project.org/) and gzip (available from: http://www.gzip.org/).

#### 2. Folder structure

Save all R scripts in the same directory of your choice. Open the file *distcomp.loop.r* and adjust the path to the required source as necessary. Save and close the file.

    source("adjustedPath/distcomp.functions.r")

Create a new directory with a name of your choice. Within this directory create two folders named "data" and "temp". These folder names are hard-coded in the script but the script can be run from any location on your system provided you have adjusted the path as described above. Unzip the sample data and move the text files to the folder named "data".

#### 3. Input data

The distortion and compression loop takes plain text files (file extension
.txt) as input. It is designed to work on multiple-file datasets, i.e. you need
to provide at least two text files.

All end-of-sentence markers need to be replaced with a single fullstop so that the script can create samples of random sentences.

Further non-mandatory text processing: To obtain reliable results it is further recommended to convert your text files to lowercase and remove all non-alphabetical characters (i.e. XML or corpus mark-up, quotation marks, numbers, commas, hyphens, or special symbols like @,#,$ as well as invisible UTF8-characters, etc.). 

#### 4. How to use the scripts

Open R. Load the distortion and compression loop with 

        source("pathToScript/distcomp_loop.r")

Start the distortion and compression loop and save your results with the `measure.complexity()` function. This function takes two arguments:
1. The name of the directory where the data and temp folders are located.
2. The number of repetitions you wish to apply, i.e. the number of repetitions for drawing random samples, manipulating and compressing them. The customary number of repetitions applied with the compression technique is N = 1000.

        result = measure.complexity("yourDirectory/", repetitions)

This returns a list with the uncompressed and compressed file sizes for the original texts, the morphologically distorted texts, and the syntactically distorted texts in the corpus, respectively. It also contains ratios for morphological and syntactic complexity.

    > result
    [[1]]
                 orig.uncomp orig.comp morphdist.uncomp morphdist.comp syndist.uncomp
    English        7277      2973             6481           2969           6537
    Finnish        6685      2858             5904           2766           6076
    French         6271      2686             5543           2677           5619
    German         7026      2942             6248           2912           6305
            syndist.comp morphratio  synratio
    English         2727 -0.9986546 0.9172553
    Finnish         2624 -0.9678097 0.9181246
    French          2468 -0.9966493 0.9188384
    German          2693 -0.9898029 0.9153637

The result can be saved with

    write.csv(result, "result.csv")
    
To store the result in a dataframe and calculate complexity scores as described in Ehret (2017) use the commands listed in *complexity_analysis.r*. Adapt the commands according to the number of repetitions with which the distortion and compression loop has been applied.


Note that the software has been developed and tested on Debian GNU/Linux 9.4. It has not been tested on Windows.

### Cite as

Kat Ehret (2020). katehret/measuring-language-complexity: Compression_technique (v1.0). Zenodo. https://doi.org/10.5281/zenodo.3727536

### Related publications

Ehret Katharina and Maite Taboada. 2021. "The interplay of complexity and subjectivity in opinionated discourse". Discourse Studies 23 (2), 141-165.  DOI: https://doi.org/10.1177/1461445620966923

Ehret, Katharina. 2021. “An Information-Theoretic View on Language Complexity and Register Variation: Compressing Naturalistic Corpus Data.” Corpus Linguistics and Linguistic Theory 17 (2) : 383-410. DOI: https://doi.org/10.1515/cllt-2018-0033

Ehret, Katharina & Benedikt Szmrecsanyi. 2019. "Compressing learner language: an information-theoretic measure of complexity in SLA".  *Second Language Research*. 35(1), 23-45. DOI: [10.1177/0267658316669559](https://journals.sagepub.com/doi/abs/10.1177/0267658316669559)

Ehret, Katharina. 2018. "[Kolmogorov complexity as a universal measure of language complexity](http://www.christianbentz.de/MLC2018/Ehret.pdf)". In: Aleksandrs Berdicevskis & Christian Bentz  (eds.), *Proceedings of the First Shared Task on Measuring Language Complexity*, 8-14. Workshop on "Measuring Language Complexity", EvoLang XII, Torun, Poland.

Ehret, Katharina. 2017. "[An information-theoretic approach to language complexity: variation in naturalistic corpora](https://freidok.uni-freiburg.de/data/12243)". FreiDok plus, Universität Freiburg. DOI: 10.6094/UNIFR/12243.

Ehret, Katharina & Benedikt Szmrecsanyi. 2016. "An information-theoretic approach to assess linguistic complexity". In: Raffaela Baechler & Guido Seiler (eds.), *Complexity, Isolation, and Variation*, 71-94. Berlin: de Gruyter. 
