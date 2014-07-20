# setwd("/Users/thanhtnguyen/Coursera/DevelopingDataProduct/Ass")

library(shiny)
library(caret)
library(RCurl)

# Load the Titanic dataset
url <- getURL('https://www.dropbox.com/s/gzbk5gsga1rtdu0/train.csv?dl=1')
Titanic = read.csv(test = url)
goodColumnsNoLabel <- c("Pclass", "Sex", "Age")
goodColumns <- c("Survived", goodColumnsNoLabel)
Titanic <- Titanic[, goodColumns]
Titanic$Pclass <- factor(Titanic$Pclass)
Titanic$Survived <- factor(Titanic$Survived)

# Create a prediction model with caret
modelFit <- train(Survived ~ ., data = Titanic, method = "glm")

# Our predict function
makePredict <- function (age, type, sex) {
    prediction <- predict(modelFit, data.frame(Age=age, Pclass=type, Sex=sex))
    if (prediction == 0) {
        "Not survive"
    } else {
        "Survive"
    }
}

# Create shiny server
shinyServer(
    function (input, output) {
        output$age <- renderPrint({input$age})
        output$type <- renderPrint({input$type})
        output$sex <- renderPrint({input$sex})
        
        output$survive <- renderText({
            if (input$goButton > 0) {
                isolate(makePredict(input$age, input$type, input$sex))
            }
        })
    }
)