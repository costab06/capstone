shinyUI(
  pageWithSidebar(
    headerPanel("Next Word Prediction"),
    sidebarPanel(
      textInput("first_word", "First word in the sequence", "first"),
      textInput("second_word", "Second word in the sequence", "second"),
      textInput("third_word", "Third word in the sequence", "third"),
      textInput("fourth_word", "Fourth word in the sequence", "fourth"),
      
      #     checkboxGroupInput("checkBoxValue","Checkbox",
      #                        c("Value 1" = "1",
      #                          "value 2" = "2",
      #                          "value 3" = "3")),
      #     dateInput("dateValue", "Date:"),
      
      
      #    sliderInput("mu", "Enter the multiplier",value=4,min=2,max=10,step=.5,)
      
      
      actionButton("predict","Predict!")
    ),
    mainPanel(
      tabsetPanel (
        tabPanel("Introduction",
                 p(),p("This application uses a corpus of text from news, blogs and twitter feeds (the SwiftKey corpus) to predict
            the next word in a sequence of words."),
                 p("The model uses 100% of the corpus, creates dataframes with ngrams from size 1 to 5 with counts of occurances of each ngram.
It uses those dataframes to calculate the probability of the next word.  for example if the input words are \"in the case of\"  The 5-gram dataframe 
will be searched for all ngrams starting with \"in the case of\" and each match will be be assigned a probability equal to the number of occurances of that specific
ngram divided by the total number of 5-grams starting with these four words.  The same is done for the 4-gram data frame, the 3-gram dataframe, the 
2-gram dataframe, and the 1-gram dataframe.  Finally each of those probabilities is multiplied by a lambda value that is proportional to the ngram size.
The logic here is that a prediction from a 5-gram that matches the first 4 words is more likely to be correct and should be weighted higher than a prediction
from the 2-gram dataframe."),
                p("Finally the computed \"scores\" are used to sort the results and present the top 3 to the user through the UI."),
                p("This approach is known as \"Stupid Backoff\".  Use of ngrams and \"Stupid Backoff\" is really the first step in trying to solve this problem.
From working with the corpus it quickly becomes apparent htat there is a need to include some form of grammer modelling as well as semantic modelling with this approach.  
Language is based on gramatical and semantic patterns, not really on simple ngram patterns."),
                p(), p("Enter 4 words in the sequence and click \"Predict!\"")),
        
        tabPanel("Results",
                 
                 h4("Highest probability result:"),
                 verbatimTextOutput("firstResult"),
                 
                 h4("Percent probability of highest result:"),
                 verbatimTextOutput("firstResultPercent"),
                 
                 
                 h4("Second highest probability result:"),
                 verbatimTextOutput("secondResult"),
                 
                 h4("Percent probability of second highest result:"),
                 verbatimTextOutput("secondResultPercent"),
                 
                 h4("Third highest probability result:"),
                 verbatimTextOutput("thirdResult"),
                 
                 h4("Percent probability of third highest result:"),
                 verbatimTextOutput("thirdResultPercent")
        )
        #        , tabPanel("Residuals",
        #                  h4("Residuals from linear model"),
        #                  plotOutput("lmResids"),
        #                  
        #                  h4("Residuals from single NNet model"),
        #                  plotOutput("singleNnetResids"),
        #                  
        #                  h4("Residuals from averaged NNet model"),
        #                  plotOutput("averageNnetResids")
        #         )
      )
    )
  )
)

