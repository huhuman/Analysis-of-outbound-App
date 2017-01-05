library(shiny)
library(ggplot2)
library(XML)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$Predictor <- renderText({ 
    paste("You have selected Model",input$model)
  })
  output$Index1 <- renderText({ 
    if(input$model == 1){
      paste("台日匯率: ",input$NTD2JPY)
    }else if (input$model == 2){
      paste("台日匯率: ",input$NTD2JPY)
    }else{
      paste("台灣造訪日本以外國家人數: ",input$Taiwan2Others)
    }
  })
  
  output$Index2 <- renderText({ 
    if(input$model == 1){
      paste("台灣GDP: ",input$GDP)
    }else if (input$model == 2){
      paste("台灣造訪日本以外國家人數: ",input$Taiwan2Others)
    }else{
      paste("台灣青少年(0-14)占人口比率: ",input$Youth)
    }
  })
  
  output$Index3 <- renderText({ 
    if(input$model == 1){
      paste("台灣造訪日本以外國家人數: ",input$Taiwan2Others)
    }else if (input$model == 2){
      
    }else{
      paste("台灣青壯年(15-65)占人口比率:  ",input$Workeage)
    }
  })
  
  output$Index4 <- renderText({ 
    if(input$model == 1){
      
    }else if (input$model == 2){
      
    }else{
      paste("前一年台灣訪日人數成長率",input$Growth4Japan)
    }
  })
  OS <- eventReactive(input$goButton, {
    if(input$model == 1){
      (-4.233*10**4 - 5.370*10**5*input$NTD2JPY + 0.1607*input$GDP + 0.07711*input$Taiwan2Others)
    }else if (input$model == 2){
      (1.867*10**4 - 4.189*10**5*input$NTD2JPY + 0.1173*input$Taiwan2Others)
    }else{
      (1.261*10**7+0.07131*input$Taiwan2Others-9.748*10**6*input$Youth-1.510*10**7*input$Workeage-2.201*10**4*input$Growth4Japan)
    }
  })
  output$Result <- renderText({ 
    OS()
  })
  
  dataInput <- reactive({
    read.csv(url("https://raw.githubusercontent.com/huhuman/Analysis-of-outbound-App/master/FinalData.csv"))
  })
  
  dataSelect <- eventReactive(input$plotButton, {
    dataInput()[,c("Date","Taiwan2Japan",input$Index), drop = FALSE]
  })
  
  output$FinalData <- renderTable({
    head(dataInput()[,c("Date","Taiwan2Japan",input$Index), drop = FALSE],5)
  }, rownames = TRUE)
  
  output$plot <- renderPlot({
    col <- colnames(dataSelect())
    g <- ggplot(dataSelect(),aes(Date))  +  theme(axis.text.x = element_blank(),legend.title = element_blank(),axis.title.y = element_blank())
    for(i in c(2:length(dataSelect()[1,]))){
      g <- g + geom_point(aes(y = dataInput()[,col[i]], colour = col[i]))
    }
    print(g)
  })
})