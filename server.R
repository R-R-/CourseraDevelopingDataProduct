# setwd("/Users/thanhtnguyen/Coursera/DevelopingDataProduct/Ass")
library(e1071)
library(shiny)
library(caret)
library(RCurl)

# Load the Titanic dataset
if (file.exists('train.csv')) { # The file is in local
    Titanic = read.csv('train.csv')
} else {
    url <- getURL('https://raw.githubusercontent.com/R-R-/CourseraDevelopingDataProduct/master/train.csv')
    Titanic = read.csv(text = url)
}
goodColumnsNoLabel <- c("Pclass", "Sex", "Age", "Parch")
goodColumns <- c("Survived", goodColumnsNoLabel)
Titanic <- Titanic[, goodColumns]
Titanic$Pclass <- factor(Titanic$Pclass)
Titanic$Survived <- factor(Titanic$Survived)
Titanic$Parch <- factor(Titanic$Parch)

# Create a prediction model with caret
modelFit <- train(Survived ~ ., data = Titanic, method = "glm")

# Our predict function
makePredict <- function (age, type, sex, parch) {
    prediction <- predict(modelFit, data.frame(Age=age, Pclass=type, Sex=sex, Parch=parch))
    
    dice <- runif(1, 0, 1.0)
    if (dice < 0.25) {
        prefix <- "We predict that you will"
    } else if (dice < 0.50) {
        prefix <- "You will likely"
    } else if (dice < 0.75) {
        prefix <- "There is a high chance that you will"
    } else {
        prefix <- "Our data suggest that you will"
    }
    
    if (prediction == 0) {
        paste(prefix, "not survive :(")
    } else {
        paste(prefix, "survive")
    }
}

# Create shiny server
shinyServer(
    function (input, output) {
        output$age <- renderPrint({input$age})
        output$type <- renderPrint({input$type})
        output$sex <- renderPrint({input$sex})
        output$family <- renderPrint({input$parch})
        
        output$survive <- renderText({
            if (input$goButton > 0) {
                isolate(makePredict(input$age, input$type, input$sex, input$parch))
            } else {
                "Please enter your information and click Submit"
            }
        })
    }
)
