#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    choicelist <-reactive({names(mtcars)[names(mtcars)!=input$outcome]})
    
    predictorlist <- reactive({paste(input$chkgrp, collapse = "+")})
   
    
    # Predictors checkbox groups
    output$chkgrp <- renderUI(
        
        checkboxGroupInput('chkgrp','Predictors:', choices =choicelist(),
                       selected = "am")
    )
    
    # Select All button
    observeEvent(input$clearAll,{
        updateCheckboxGroupInput(session=session, inputId="chkgrp", 
                                 selected="")
    })
    # Clear All button
    observeEvent(input$selectAll,{
        updateCheckboxGroupInput(session=session, inputId="chkgrp", 
                                 selected=choicelist())
    })
    
    output$outcome <-renderText({predictorlist()}) 
    output$chkout<-renderText({input$chkgrp}) 
    
    output$boxplot <- renderPlot({
        if(!is.null(input$chkgrp[1])){
        ggplot(data = mtcars, aes(x = cut(mtcars[,input$chkgrp[1]],5), y = mtcars[,input$outcome], .groups = 'keep')) +
            geom_boxplot()+
            xlab(input$chkgrp[1]) + 
            ylab(input$outcome)+
            theme(axis.text=element_text(size=12),
                  axis.title=element_text(size=14,face="bold"))
        }
    
    })
    
    fit <- reactive(lm(as.formula(paste(input$outcome, "~",predictorlist())), data = mtcars))
    
    output$summary<-renderPrint({
        
        if(!is.null(input$chkgrp[1])){summary(fit())}
        })
    
    output$diagplot <- renderPlot({
        
        if(!is.null(input$chkgrp[1])){
            par(mfrow = c(2,2))
            plot(fit())
        }})
    
    rv<- reactiveValues()
    
    #reactive variables
    observe({
        rv$nopredictor <- if(is.null(input$chkgrp[1])){"Please choose at least one predictor"}
        rv$nopredictor1 <- if(is.null(input$chkgrp[1])){"Please choose one predictor"}
        rv$outpred <- if(!is.null(input$chkgrp[1])){paste(input$outcome," vs ", predictorlist(),"</h4>")}
        rv$outpred1 <- if(!is.null(input$chkgrp[1])){paste(input$outcome," vs ", input$chkgrp[1],"</h4>")}
    })
    output$htmlbox <- renderText(paste("<h4>Box plot for: ",rv$outpred1))
    output$htmllm <- renderText(paste("<h4>Regression model for: ",rv$outpred))
    output$htmldiag <- renderText(paste("<h4>Diagnostics plots for: ",rv$outpred))
    output$askforpredictor1 <- renderText(rv$nopredictor1)
    output$askforpredictor2 <- renderText(rv$nopredictor)
    output$askforpredictor3 <- renderText(rv$nopredictor)


})
