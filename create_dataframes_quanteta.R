
library(quanteda)

PATH="final/en_US/samples100/"
TEXTFILE = paste(PATH,"en_US.all.sample.txt",sep="")
QUINTRDAFILE= paste(PATH,"quint_df.rda",sep="")
QUADRDAFILE= paste(PATH,"quad_df.rda",sep="")
TRIRDAFILE= paste(PATH,"tri_df.rda",sep="")
BIRDAFILE= paste(PATH,"bi_df.rda",sep="")



tf<-textfile(TEXTFILE)
corp<-corpus(tf)
rm(tf)

GSIZE=5
dfm<-dfm(corp, verbose = FALSE, toLower = TRUE,
           stem = FALSE, ignoredFeatures = NULL, keptFeatures = NULL,
           language = "english", thesaurus = NULL, dictionary = NULL,
           valuetype = c("glob", "regex", "fixed"), ngrams=GSIZE, concatenator=" ")

frequency<-sort(colSums(dfm),decreasing =TRUE)
rm(dfm)

s<-strsplit(names(frequency)," ")
m<-matrix(unlist(s),ncol=GSIZE, byrow=TRUE)
quint_df<-data.frame(m,stringsAsFactors=FALSE)
rm(s)
rm(m)

quint_df<-cbind(quint_df,frequency)
names(quint_df)<-c("first","second","third","fourth","fifth","count")
rownames(quint_df)<-c()
#quint_df<-filter(quint_df,count>1)

save(quint_df,file=QUINTRDAFILE)
rm(frequency)
rm(quint_df)
 
 
 
GSIZE=4
dfm<-dfm(corp, verbose = FALSE, toLower = TRUE,
         stem = FALSE, ignoredFeatures = NULL, keptFeatures = NULL,
         language = "english", thesaurus = NULL, dictionary = NULL,
         valuetype = c("glob", "regex", "fixed"), ngrams=GSIZE, concatenator=" ")

frequency<-sort(colSums(dfm),decreasing =TRUE)
rm(dfm)

s<-strsplit(names(frequency)," ")
m<-matrix(unlist(s),ncol=GSIZE, byrow=TRUE)
quad_df<-data.frame(m,stringsAsFactors=FALSE)
rm(s)
rm(m)

quad_df<-cbind(quad_df,frequency)
names(quad_df)<-c("first","second","third","fourth","count")
rownames(quad_df)<-c()
#quad_df<-filter(quad_df,count>1)


save(quad_df,file=QUADRDAFILE)
rm(frequency)
rm(quad_df)



GSIZE=3
dfm<-dfm(corp, verbose = FALSE, toLower = TRUE,
         stem = FALSE, ignoredFeatures = NULL, keptFeatures = NULL,
         language = "english", thesaurus = NULL, dictionary = NULL,
         valuetype = c("glob", "regex", "fixed"), ngrams=GSIZE, concatenator=" ")

frequency<-sort(colSums(dfm),decreasing =TRUE)
rm(dfm)

s<-strsplit(names(frequency)," ")
m<-matrix(unlist(s),ncol=GSIZE, byrow=TRUE)
tri_df<-data.frame(m,stringsAsFactors=FALSE)
rm(s)
rm(m)

tri_df<-cbind(tri_df,frequency)
names(tri_df)<-c("first","second","third","count")
rownames(tri_df)<-c()
#tri_df<-filter(tri_df,count>1)

save(tri_df,file=TRIRDAFILE)
rm(frequency)
rm(tri_df)

GSIZE=1
dfm<-dfm(corp, verbose = FALSE, toLower = TRUE,
         stem = FALSE, ignoredFeatures = NULL, keptFeatures = NULL,
         language = "english", thesaurus = NULL, dictionary = NULL,
         valuetype = c("glob", "regex", "fixed"), ngrams=GSIZE, concatenator=" ")

frequency<-sort(colSums(dfm),decreasing =TRUE)



GSIZE=2
dfm<-dfm(corp, verbose = FALSE, toLower = TRUE,
         stem = FALSE, ignoredFeatures = NULL, keptFeatures = NULL,
         language = "english", thesaurus = NULL, dictionary = NULL,
         valuetype = c("glob", "regex", "fixed"), ngrams=GSIZE, concatenator=" ")

frequency<-sort(colSums(dfm),decreasing =TRUE)
rm(dfm)

s<-strsplit(names(frequency)," ")
m<-matrix(unlist(s),ncol=GSIZE, byrow=TRUE)
bi_df<-data.frame(m,stringsAsFactors=FALSE)
rm(s)
rm(m)

bi_df<-cbind(bi_df,frequency)
names(bi_df)<-c("first","second","count")
rownames(bi_df)<-c()
#bi_df<-filter(bi_df,count>1)

save(bi_df,file=BIRDAFILE)
rm(frequency)
rm(bi_df)


