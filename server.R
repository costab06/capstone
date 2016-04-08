
library(shiny)
library(dplyr)
library(wordcloud)
library(ggplot2)

#cat("starting")

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


shinyServer(
  function(input,output) {
    
    #cat("shinyServer called, about to block on predict button")
    
    
    observeEvent(input$predict, {
      
      
      #cat("predict button pushed")
      
      
      results<-data.frame(word=character(),percent=double(),stringsAsFactors=FALSE)
      fourth_word<-""
      third_word<-""
      second_word<-""
      first_word<-""
      
      words <- strsplit(input$sentence, " ")[[1]]
      
      
      
      words_length<-length(words)
      
      ##cat(words_length)
      
      if (words_length >= 1) {
        fourth_word<-words[words_length]
        if (words_length >=2)
          third_word<-words[words_length-1]
        if (words_length >=3)
          second_word<-words[words_length-2]
        if (words_length >=4)
          first_word<-words[words_length-3]
      } 
      
      quint_f<-filter(quint_df,first==first_word,second==second_word,
                      third==third_word,fourth==fourth_word)
      if (nrow(quint_f)>0) {
        results<-rbind(results,data.frame(word=quint_f[1,5],percent=as.numeric(quint_f[1,6])/sum(quint_f$count)*QUINT_LAMBDA,stringsAsFactors=FALSE))
        output$quintcloud<- renderPlot({wordcloud(quint_f$fifth, quint_f$count,min.freq=0,max.words=10,scale=c(8,2))})
        quint_f<-arrange(quint_f,desc(count))
        quint_f<-quint_f[1:10,]
        output$quintplot<- renderPlot({ggplot(quint_f, aes(fifth, count)) + geom_bar(stat="identity") + theme(axis.text.x=element_text(angle=45, hjust=1)) })
      }
      
      if (nrow(quint_f)>1) {
        results<-rbind(results,data.frame(word=f[2,5],percent=as.numeric(f[2,6])/sum(f$count)*QUINT_LAMBDA,stringsAsFactors=FALSE))
      }
      
      
      if (nrow(quint_f)>2) {
        results<-rbind(results,data.frame(word=quint_f[3,5],percent=as.numeric(quint_f[3,6])/sum(quint_f$count)*QUINT_LAMBDA,stringsAsFactors=FALSE))
      }
      
      
      
      quad_f<-filter(quad_df,first==second_word,second==third_word,third==fourth_word)
      if (nrow(quad_f)>0) {
        results<-rbind(results,data.frame(word=quad_f[1,4],percent=as.numeric(quad_f[1,5])/sum(quad_f$count)*QUAD_LAMBDA,stringsAsFactors=FALSE))
        output$quadcloud<- renderPlot({wordcloud(quad_f$fourth, quad_f$count,min.freq=0,max.words=10,scale=c(8,2))})
        quad_f<-arrange(quad_f,desc(count))
        quad_f<-quad_f[1:10,]
        output$quadplot<- renderPlot({ggplot(quad_f, aes(fourth, count)) + geom_bar(stat="identity") + theme(axis.text.x=element_text(angle=45, hjust=1)) })       
        
        
      }
      
      if (nrow(quad_f)>1) {
        results<-rbind(results,data.frame(word=quad_f[2,4],percent=as.numeric(quad_f[2,5])/sum(quad_f$count)*QUAD_LAMBDA,stringsAsFactors=FALSE))
      }
      
      if (nrow(quad_f)>2) {
        results<-rbind(results,data.frame(word=quad_f[3,4],percent=as.numeric(quad_f[3,5])/sum(quad_f$count)*QUAD_LAMBDA,stringsAsFactors=FALSE))
      }
      
      
      
      
      
      tri_f<-filter(tri_df,first==third_word,second==fourth_word)
      if (nrow(tri_f)>0) {
        results<-rbind(results,data.frame(word=tri_f[1,3],percent=as.numeric(tri_f[1,4])/sum(tri_f$count)*TRI_LAMBDA,stringsAsFactors=FALSE))
        output$tricloud<- renderPlot({wordcloud(tri_f$third, tri_f$count,min.freq=0,max.words=10,scale=c(8,2))})
        tri_f<-arrange(tri_f,desc(count))
        tri_f<-tri_f[1:10,]
        output$triplot<- renderPlot({ggplot(tri_f, aes(third, count)) + geom_bar(stat="identity") + theme(axis.text.x=element_text(angle=45, hjust=1)) })       
      }
      
      if (nrow(tri_f)>1) {
        results<-rbind(results,data.frame(word=tri_f[2,3],percent=as.numeric(tri_f[2,4])/sum(tri_f$count)*TRI_LAMBDA,stringsAsFactors=FALSE))
      }
      
      if (nrow(tri_f)>2) {
        results<-rbind(results,data.frame(word=tri_f[3,3],percent=as.numeric(tri_f[3,4])/sum(tri_f$count)*TRI_LAMBDA,stringsAsFactors=FALSE))
      }
      
      
      
      
      
      
      bi_f<-filter(bi_df,first==fourth_word)
      if (nrow(bi_f)>0) {
        results<-rbind(results,data.frame(word=bi_f[1,2],percent=as.numeric(bi_f[1,3])/sum(bi_f$count)*BI_LAMBDA,stringsAsFactors=FALSE))
        output$bicloud<- renderPlot({wordcloud(bi_f$second, bi_f$count,min.freq=0,max.words=10,scale=c(8,2))})
        bi_f<-arrange(bi_f,desc(count))
        bi_f<-bi_f[1:10,]
        output$biplot<- renderPlot({ggplot(bi_f, aes(second, count)) + geom_bar(stat="identity") + theme(axis.text.x=element_text(angle=45, hjust=1))}) 
      }
      
      if (nrow(bi_f)>1) {
        results<-rbind(results,data.frame(word=bi_f[2,2],percent=as.numeric(bi_f[2,3])/sum(bi_f$count)*BI_LAMBDA,stringsAsFactors=FALSE))
      }
      
      if (nrow(bi_f)>2) {
        results<-rbind(results,data.frame(word=bi_f[3,2],percent=as.numeric(bi_f[3,3])/sum(bi_f$count)*BI_LAMBDA,stringsAsFactors=FALSE))
      }
      
      
      
      results<-rbind(results,data.frame(word="the",percent=0.0367*UNI_LAMBDA))
      
      
      ## aggregate like words
      results<-aggregate(percent ~ word, data=results, FUN=sum)
      
      
      results<-arrange(results,desc(percent))
      
      
      
      
      
      
      #results
      
      
      output$firstResult <- renderPrint({results[1,1]})
      output$firstResultPercent <- renderPrint({results[1,2]})
      
      
      output$secondResult <- renderPrint({results[2,1]})
      output$secondResultPercent <- renderPrint({results[2,2]})
      
      
      output$thirdResult <- renderPrint({results[3,1]})
      output$thirdResultPercent <- renderPrint({results[3,2]})
      
      
      
      
    })
    
    
    
    
  })




