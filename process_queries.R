library(dplyr)


PATH="final/en_US/samples100/"
QUINTRDAFILE= paste(PATH,"quint_df.rda",sep="")
QUADRDAFILE= paste(PATH,"quad_df.rda",sep="")
TRIRDAFILE= paste(PATH,"tri_df.rda",sep="")
BIRDAFILE= paste(PATH,"bi_df.rda",sep="")

load(QUINTRDAFILE)
load(QUADRDAFILE)
load(TRIRDAFILE)
load(BIRDAFILE)



QUINT_LAMBDA=0.32
QUAD_LAMBDA=0.26
TRI_LAMBDA=0.21
BI_LAMBDA=0.16
UNI_LAMBDA=0.05


first_word<-"one"
second_word<-"two"
third_word<-"three"
fourth_word<-"four"


#head(filter(quint_df,first==first_word,second==second_word,third==third_word,fourth==fourth_word))
#head(filter(quad_df,first==second_word,second==third_word,third==fourth_word))
#head(filter(tri_df,first==third_word,second==fourth_word))
#head(filter(bi_df,first==fourth_word))

results<-data.frame(word=character(),percent=double(),stringsAsFactors=FALSE)


f<-filter(quint_df,first==first_word,second==second_word,third==third_word,fourth==fourth_word)
if (nrow(f)==0) {
	results<-rbind(results,data.frame(word="",percent=0.0))
} else {
	results<-rbind(results,data.frame(word=f[1,5],percent=as.numeric(f[1,6])/sum(f$count)*QUINT_LAMBDA))
}


f<-filter(quad_df,first==second_word,second==third_word,third==fourth_word)
if (nrow(f)==0) {
	results<-rbind(results,data.frame(word="",percent=0.0))
} else {
	results<-rbind(results,data.frame(word=f[1,4],percent=as.numeric(f[1,5])/sum(f$count)*QUAD_LAMBDA))
}


f<-filter(tri_df,first==third_word,second==fourth_word)
if (nrow(f)==0) {
	results<-rbind(results,data.frame(word="",percent=0.0))
} else {
	results<-rbind(results,data.frame(word=f[1,3],percent=as.numeric(f[1,4])/sum(f$count)*TRI_LAMBDA))
}



f<-filter(bi_df,first==fourth_word)
if (nrow(f)==0) {
	results<-rbind(results,data.frame(word="",percent=0.0))
} else {
	results<-rbind(results,data.frame(word=f[1,2],percent=as.numeric(f[1,3])/sum(f$count)*BI_LAMBDA))
}


results<-rbind(results,data.frame(word="the",percent=0.0367*UNI_LAMBDA))



results<-arrange(results,desc(percent))
results


