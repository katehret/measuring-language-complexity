#####commands to calculate complexity scores for overall, morphological and syntactic complexity as well as their standard deviation


#get complexity scores and file sizes from the result of the distortion and compression loop with N = 1000 repetitions

df = data.frame(
      synratio = sapply(result, function(x) x$synratio),
      morphratio = sapply(result, function(x) x$morphratio),
      orig.uncomp = sapply(result, function(x) x$orig.uncomp),
      orig.comp = sapply(result, function(x) x$orig.comp)
)

#use corpus filenames as rownames
filenames = rownames(result[[1]])
rownames(df) = filenames


##calculate average morphological/syntactic complexity scores and store in dataframe
df$meansynratio = rowMeans(df[1:1000])  
df$meanmorphratio = rowMeans(df[1001:2000])

#standard deviation of morphological/syntactic complexity scores
df$syn.sd = apply(df[1:1000], 1, sd)
df$morph.sd = apply(df[1001:2000], 1, sd)


##calculate adjusted overall complexity scores
#get the mean original uncompressed and compressed file sizes
df$average.orig.uncomp = rowMeans(df[2001:3000])
df$average.orig.comp = rowMeans(df[3001:4000])

#compute regression residuals (adjusted overall complexity scores)
df$average.comp.res = resid(lm(df$average.orig.comp ~ df$average.orig.uncomp))

#standard deviation of compressed/uncompressed file sizes
df$orig.uncomp.sd =  apply(df[2001:3000], 1, sd)
df$orig.comp.sd =  apply(df[3001:4000], 1, sd)




