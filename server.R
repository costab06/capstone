
library(shiny)
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


shinyServer(
  function(input,output) {
    
    cat("shinyServer called, about to block on predict button")
    
    
    observeEvent(input$predict, {
      
      
      cat("predict button pushed")
      
      
      results<-data.frame(word=character(),percent=double(),stringsAsFactors=FALSE)
      
      
      f<-filter(quint_df,first==input$first_word,second==input$second_word,
                          third==input$third_word,fourth==input$fourth_word)
      if (nrow(f)==0) {
        results<-rbind(results,data.frame(word="",percent=0.0))
      } else {
        results<-rbind(results,data.frame(word=f[1,5],percent=as.numeric(f[1,6])/sum(f$count)*QUINT_LAMBDA))
      }
      
      
      f<-filter(quad_df,first==input$second_word,second==input$third_word,third==input$fourth_word)
      if (nrow(f)==0) {
        results<-rbind(results,data.frame(word="",percent=0.0))
      } else {
        results<-rbind(results,data.frame(word=f[1,4],percent=as.numeric(f[1,5])/sum(f$count)*QUAD_LAMBDA))
      }
      
      
      f<-filter(tri_df,first==input$third_word,second==input$fourth_word)
      if (nrow(f)==0) {
        results<-rbind(results,data.frame(word="",percent=0.0))
      } else {
        results<-rbind(results,data.frame(word=f[1,3],percent=as.numeric(f[1,4])/sum(f$count)*TRI_LAMBDA))
      }
      
      
      
      f<-filter(bi_df,first==input$fourth_word)
      if (nrow(f)==0) {
        results<-rbind(results,data.frame(word="",percent=0.0))
      } else {
        results<-rbind(results,data.frame(word=f[1,2],percent=as.numeric(f[1,3])/sum(f$count)*BI_LAMBDA))
      }
      
      
      results<-rbind(results,data.frame(word="the",percent=0.0367*UNI_LAMBDA))
      
      
      
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    #     
    #     
    #     singleNnetFit<-reactive({nnet(trainingData, solTrainY, size = input$numHiddenNodes, decay = input$inputDecay,
    #                                   linout = TRUE, trace = FALSE, maxit = 500, 
    #                                   MaxNWts = input$numHiddenNodes * (ncol(trainingData) + 1) + input$numHiddenNodes + 1)})
    #     
    #     
    #     singleNnetPred<-reactive({predict(singleNnetFit(), testingData)})
    #     singleNnetSummary<-reactive({defaultSummary(data.frame(obs=solTestY, pred=singleNnetPred()))})
    #     
    #     
    #     averageNnetFit<-reactive({avNNet(trainingData, solTrainY, size = input$numHiddenNodes, decay = input$inputDecay, repeats = input$numModels,
    #                                      linout = TRUE, trace = FALSE, maxit = 500, 
    #                                      MaxNWts = input$numHiddenNodes * (ncol(trainingData) + 1) + input$numHiddenNodes + 1)})
    #     
    #     
    #     averageNnetPred<-reactive({predict(averageNnetFit(), testingData)})
    #     averageNnetSummary<-reactive({defaultSummary(data.frame(obs=solTestY, pred=averageNnetPred()))})
    #     
    #     
    #     
    #     
    #     output$lmRMSE <- renderPrint({lmSummary[1]})
    #     output$lmRSquared <- renderPrint({lmSummary[2]})
    #     
    #     output$singleNnetRMSE <- renderPrint({as.data.frame(singleNnetSummary())[1,1]})
    #     output$singleNnetRSquared <- renderPrint({as.data.frame(singleNnetSummary())[2,1]})
    #     
    #     output$averageNnetRMSE <- renderPrint({as.data.frame(averageNnetSummary())[1,1]})
    #     output$averageNnetRSquared <- renderPrint({as.data.frame(averageNnetSummary())[2,1]})
    #     
    #     lmResids<-lmPred-solTestY
    #     output$lmResids<- renderPlot({plot(lmResids)})
    #     
    #     singleResids<-reactive(singleNnetPred()-solTestY)
    #     output$singleNnetResids<- renderPlot({plot(singleResids())})
    #     
    #     averageResids<-reactive(averageNnetPred()-solTestY)
    #     output$averageNnetResids<- renderPlot({plot(averageResids())})
    
    