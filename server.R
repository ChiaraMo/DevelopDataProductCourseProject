#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
# Load the necessary library that contains the mtcars dataset
library(datasets)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

BestModel <- step(lm(data = mpgData, mpg ~ .), trace = 0)


shinyServer(function(input, output) {
    
  formulaText <- reactive({
      paste("mpg ~", input$variable)
  })
  
  formulaTextPoint <- reactive({
      paste("mpg ~", "as.integer(", input$variable, ")")
  })
  
  fit <- reactive({
      lm(as.formula(formulaTextPoint()), data = mpgData)
  })
  
  output$caption <- renderText({
      formulaText()
  })
      
  output$mpgBoxPlot <- renderPlot({
      boxplot(as.formula(formulaText()), 
              data = mpgData
              )
  })
      
  output$fit <- renderPrint({
      summary(fit())
  })
  
  output$mpgPlot <- renderPlot({
      with(mpgData, {
          plot(as.formula(formulaTextPoint()))
          abline(fit(), col = 2)
      })
  })
  
  output$BestModel <- renderPrint({
      summary(BestModel)
  })
  
})
