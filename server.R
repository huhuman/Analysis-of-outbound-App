library(shiny)
library(ggplot2)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$Predictor <- renderText({ 
    paste("You have selected Model",input$model)
  })
  output$GDPvalue <- renderText({ 
    paste("Taiwan's GDP:  ",input$GDP)
  })
  
  dataInput <- reactive({
    read.csv("~/R/dsR/finalapp/Analysis-of-outbound-App/FinalData.csv")
  })
  output$plot <- renderPlot({
    data <- dataInput()
    data <- data[2:10,]
    ggplot(data,aes(Date,Taiwan2Japan)) + geom_point() + theme(axis.text.x = element_blank())
  })
})