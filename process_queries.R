library(dplyr)


PATH="data/"
QUINTRDAFILE= paste(PATH,"quint_df.rda",sep="")
QUADRDAFILE= paste(PATH,"quad_df.rda",sep="")
TRIRDAFILE= paste(PATH,"tri_df.rda",sep="")
BIRDAFILE= paste(PATH,"bi_df.rda",sep="")

load(QUINTRDAFILE)
load(QUADRDAFILE)
load(TRIRDAFILE)
load(BIRDAFILE)



QUINT_LAMBDA=0.30
QUAD_LAMBDA=0.25
TRI_LAMBDA=0.20
BI_LAMBDA=0.15
UNI_LAMBDA=0.10



input_sentence = "construction would likely"


fourth_word<-""
third_word<-""
second_word<-""
first_word<-""

words <- strsplit(input_sentence, " ")[[1]]
str(words)
words_length<-length(words)
cat(words_length)

if (words_length >= 1) {
  fourth_word<-words[words_length]
  if (words_length >=2)
    third_word<-words[words_length-1]
  if (words_length >=3)
    second_word<-words[words_length-2]
  if (words_length >=4)
    first_word<-words[words_length-3]
}





#head(filter(quint_df,first==first_word,second==second_word,third==third_word,fourth==fourth_word))
#head(filter(quad_df,first==second_word,second==third_word,third==fourth_word))
#head(filter(tri_df,first==third_word,second==fourth_word))
#head(filter(bi_df,first==fourth_word))

results<-data.frame(word=character(),percent=double(),stringsAsFactors=FALSE)




f<-filter(quint_df,first==first_word,second==second_word,
          third==third_word,fourth==fourth_word)
if (nrow(f)>0) {
  results<-rbind(results,data.frame(word=f[1,5],percent=as.numeric(f[1,6])/sum(f$count)*QUINT_LAMBDA,stringsAsFactors=FALSE))
}

if (nrow(f)>1) {
  results<-rbind(results,data.frame(word=f[2,5],percent=as.numeric(f[2,6])/sum(f$count)*QUINT_LAMBDA,stringsAsFactors=FALSE))
}


if (nrow(f)>2) {
  results<-rbind(results,data.frame(word=f[3,5],percent=as.numeric(f[3,6])/sum(f$count)*QUINT_LAMBDA,stringsAsFactors=FALSE))
}



f<-filter(quad_df,first==second_word,second==third_word,third==fourth_word)
if (nrow(f)>0) {
  results<-rbind(results,data.frame(word=f[1,4],percent=as.numeric(f[1,5])/sum(f$count)*QUAD_LAMBDA,stringsAsFactors=FALSE))
}

if (nrow(f)>1) {
  results<-rbind(results,data.frame(word=f[2,4],percent=as.numeric(f[2,5])/sum(f$count)*QUAD_LAMBDA,stringsAsFactors=FALSE))
}

if (nrow(f)>2) {
  results<-rbind(results,data.frame(word=f[3,4],percent=as.numeric(f[3,5])/sum(f$count)*QUAD_LAMBDA,stringsAsFactors=FALSE))
}





f<-filter(tri_df,first==third_word,second==fourth_word)
if (nrow(f)>0) {
  results<-rbind(results,data.frame(word=f[1,3],percent=as.numeric(f[1,4])/sum(f$count)*TRI_LAMBDA,stringsAsFactors=FALSE))
}

if (nrow(f)>1) {
  results<-rbind(results,data.frame(word=f[2,3],percent=as.numeric(f[2,4])/sum(f$count)*TRI_LAMBDA,stringsAsFactors=FALSE))
}

if (nrow(f)>2) {
  results<-rbind(results,data.frame(word=f[3,3],percent=as.numeric(f[3,4])/sum(f$count)*TRI_LAMBDA,stringsAsFactors=FALSE))
}







f<-filter(bi_df,first==fourth_word)
if (nrow(f)>0) {
  results<-rbind(results,data.frame(word=f[1,2],percent=as.numeric(f[1,3])/sum(f$count)*BI_LAMBDA,stringsAsFactors=FALSE))
}

if (nrow(f)>1) {
  results<-rbind(results,data.frame(word=f[2,2],percent=as.numeric(f[2,3])/sum(f$count)*BI_LAMBDA,stringsAsFactors=FALSE))
}

if (nrow(f)>2) {
  results<-rbind(results,data.frame(word=f[3,2],percent=as.numeric(f[3,3])/sum(f$count)*BI_LAMBDA,stringsAsFactors=FALSE))
}




results<-rbind(results,data.frame(word="the",percent=0.0367*UNI_LAMBDA))


## aggregate like words
results<-aggregate(percent ~ word, data=results, FUN=sum)


results<-arrange(results,desc(percent))




results


p<-ggplot(subset(f, count>1), aes(third, count))    
p<-p + geom_bar(stat="identity")   
p<-p + theme(axis.text.x=element_text(angle=45, hjust=1))   
p

wordcloud(f$second, f$count,min.freq=0,max.words=10)


