library(shiny)

shinyUI(fluidPage(
    titlePanel("Can you survive the Titanic?"),
    
    fluidRow(
        column(6, wellPanel(
            numericInput('age', 'Your age:', 20, min = 1, max = 100, step = 1),
            radioButtons('type', 'What ticket would you buy: ', c(
                '1st class' = '1',
                '2nd class' = '2',
                '3rd class' = '3'
            )),
            radioButtons('sex', 'Your sex: ', c(
                'Male' = 'male',
                'Female' = 'female'
            )),
            radioButtons('parch', 'Would you bring your family onboard? If yes, how many family members?', c(
                'No' = '0',
                '1' = '1',
                '2' = '2',
                '3' = '3',
                '4' = '4',
                '5' = '5',
                '6' = '6'
            )),
            actionButton('goButton', 'Submit')
        )),
        column(6, wellPanel(
            h3('Prediction result (you need to click Submit for this to update)'),
            verbatimTextOutput('survive'),
            h3('Your data'),
            h5('Your age:'),
            verbatimTextOutput('age'),
            h5('Your ticket:'),
            verbatimTextOutput('type'),
            h5('Your sex:'),
            verbatimTextOutput('sex'),
            h5('Family members onboard:'),
            verbatimTextOutput('family')
        ))
    ),
    fluidRow(
        h3('About this app'),
        h4('How this app works'),
        p('Using the Titanic survival data available at https://www.kaggle.com/c/titanic-gettingStarted/data, 
            we were able to build a prediction model was built. Based on your age, ticket class, gender and 
            number of family members onboard, we can predict your chance of surviving the Titanic shipwreck.'
        ),
        h4('How to use this app'),
        p('Using this application is simple. You just need to fill in all the information and click Submit.
          After Submit is clicked, your data will be send to our server. Our prediction model will then be
          used to predict whether you can survive the Titanic shipwreck.
          Note: As soon as you select new choices, the "Your data" section on the right will immediately
          change. However, you will need to click on Submit for us to generate new prediction.')
    )
))
