#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Motor Trend Car Road Tests"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("outcome", "Outcome", 
                        names(mtcars), selected = "mpg"),
            uiOutput("chkgrp"),
            actionButton("selectAll","Select All"),
            actionButton("clearAll","Clear All"),
            
            HTML("<br/>"),
            HTML("<br/>"),
            #Documentation: 
            strong("Documentation:"),
            p('This app was built based on "mtcars" dataset. It allows the 
              regression analysis of the following variables:'),
            tags$ul(
                tags$li('mprg:  Miles/(US) gallon'),
                tags$li('cyl:	Number of cylinders'),
                tags$li('disp:	Displacement (cu.in.)'),
                tags$li('hp:	Gross horsepower'),
                tags$li('drat:	Rear axle ratio'),
                tags$li('wt:	Weight (1000 lbs)'),
                tags$li('qsec:	1/4 mile time'),
                tags$li('vs:	Engine (0 = V-shaped, 1 = straight)'),
                tags$li('am:	Transmission (0 = automatic, 1 = manual)'),
                tags$li('gear:	Number of forward gears'),
                tags$li('carb:	Number of carburetors')
                ),
            #Instructions
            strong("Instructions:"),
            HTML("<br/>"),
            HTML("<b>1)</b> Select an outcome from the textbox.<br/>"),
            HTML("<b>2)</b> Select at least one predictor. You can select all or clear all
              when you click the respective button.<br/>"),
            HTML("<b>3)</b> Click on the tabs to see the results.<br/>"),
            HTML("<br/>"),
            HTML("<b>Github repository with ui.R and server.R:</b>"),
            HTML("<a target='blank' href='https://github.com/Seruhio6/datasciencecoursera/tree/master/9.DevelopingDataProducts/PA94'>Link</a>")
        ),

        mainPanel(
            tabsetPanel(
                    tabPanel("Box plot", 
                             htmlOutput("htmlbox"),
                             h5('For box plot only first predictor chosen from the left will be plotted'),
                             HTML("<br/>"),
                             textOutput("askforpredictor1"),
                             plotOutput("boxplot")
                     
                            ), 
                    tabPanel("Regression model", 
                             htmlOutput("htmllm"),
                             HTML("<br/>"),
                             textOutput("askforpredictor2"),
                             verbatimTextOutput("summary")
                            ),
                    tabPanel("Diagnostics", 
                             htmlOutput("htmldiag"),
                             HTML("<br/>"),
                             textOutput("askforpredictor3"),
                             plotOutput("diagplot")

                    )
                    )
                )
    )

))
