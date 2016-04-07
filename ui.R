shinyUI(
  pageWithSidebar(
    headerPanel("Next Word Prediction"),
    sidebarPanel(
      textInput("sentence", "Type in the sentence to complete", "construction would likely"),
      
      
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
It uses those dataframes to calculate the probability of the next word for each of the ngram models.  for example if the input words are \"in the case of\"  The 5-gram dataframe 
will be searched for all ngrams starting with \"in the case of\" and each match will be be assigned a probability equal to the number of occurances of that specific
ngram divided by the total number of 5-grams starting with these four words.  The same is done for the 4-gram data frame, the 3-gram dataframe, the 
2-gram dataframe, and the 1-gram dataframe.  Finally each of those probabilities is multiplied by a lambda value that is proportional to the ngram size.
The logic here is that a prediction from a 5-gram that matches the first 4 words is more likely to be correct and should be weighted higher than a prediction
from the 2-gram dataframe."),
                 p("Finally these computed \"scores\" are used to sort the results and present the top 3 to the user through the UI.  If fewer than three can be found then \"NA\" will show up."),
                 p("This approach is known as \"Interpolation\" since all of the ngram models are considered.  Use of ngrams and \"Interpolation\" is really the first step 
in trying to solve this problem.  From working with the corpus it quickly becomes apparent that there is a need to include some form of grammer modelling as well as 
semantic modelling with this approach.  Language is based on gramatical and semantic patterns, not really on simple ngram patterns."),
                 p(), p("Enter the start of the sentence and click \"Predict!\"")),
        
        tabPanel("Results",
                 
                 h4("Highest scoring result:"),
                 verbatimTextOutput("firstResult"),
                 
                 h4("Score:"),
                 verbatimTextOutput("firstResultPercent"),
                 
                 
                 h4("Second highest scoring result:"),
                 verbatimTextOutput("secondResult"),
                 
                 h4("Score:"),
                 verbatimTextOutput("secondResultPercent"),
                 
                 h4("Third highest scoring result:"),
                 verbatimTextOutput("thirdResult"),
                 
                 h4("Score:"),
                 verbatimTextOutput("thirdResultPercent")
        )
        , tabPanel("Result Clouds",
                   h4("Wordcloud from quint-grams"),
                   plotOutput("quintcloud"),
                   
                   h4("Wordcloud from quad-grams"),
                   plotOutput("quadcloud"),
                   
                   h4("Wordcloud from tri-grams"),
                   plotOutput("tricloud"),
                   
                   h4("Wordcloud from bi-grams"),
                   plotOutput("bicloud")
                   
        )
        
        , tabPanel("Result Plots",
                   h4("Plot from quint-grams"),
                   plotOutput("quintplot"),
                   
                   h4("Plot from quad-grams"),
                   plotOutput("quadplot"),
                   
                   h4("Plot from tri-grams"),
                   plotOutput("triplot"),
                   
                   h4("Plot from bi-grams"),
                   plotOutput("biplot")
                   
        )        
        
        
      )
      
    )
  )
)


