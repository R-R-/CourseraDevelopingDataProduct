library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("Can you survive the Titanic?"),
    sidebarPanel(
        numericInput('age', 'Your age:', 20, min = 1, max = 100, step = 1),
        radioButtons('type', 'Your class: ', c(
            '1st' = '1',
            '2nd' = '2',
            '3rd' = '3'
        )),
        radioButtons('sex', 'Your sex: ', c(
            'Male' = 'male',
            'Female' = 'female'
        )),
        actionButton('goButton', 'Submit')
    ),
    mainPanel(
        h3('We predict that you will'),
        verbatimTextOutput('survive')
    )
))
