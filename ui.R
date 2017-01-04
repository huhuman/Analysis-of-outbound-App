library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("R語言與資料科學導論期末展示 Group13"),
  br(),
  sidebarLayout(sidebarPanel(
    h4("旅日人數分析預測"),
    a(strong("Online presentation"),href = "https://huhuman.github.io/Analysis-of-outbound-tourism-statistics/#data_collection"),
    h3(strong("互動模型")),
    helpText("Create demographic maps with information from the 2010 US Census."),
    selectInput("model", 
                label = "Choose a model to display",
                choices = list("Model1" = 1, "Model2" = 2, "Model3" = 3),
                selected = 1),
    
    numericInput("GDP",label = h5("Value of Taiwan GDP"),value = 0),
    textOutput("Predictor"),
    textOutput("GDPvalue")
  ),
  mainPanel(
    h3("Date mining & collection"),
    p("資料來源："),
    br(),
    h3(strong("變因選擇")),
    p("          "),
    h5("1.台日匯率"),
    h5("2.台灣GDP"),
    h5("3.台灣總人口數"),
    h5("4.日本天災發生次數(地震、豪雨)"),
    h5("5.台灣造訪日本以外國家人數"),
    h5("6.台灣年齡結構(分為0-14、15-65、65↑"),
    h5("7.台灣結婚對數"),
    h5("8.台灣各地氣溫狀況"),
    h5("9.旅日人數成長率"),
    h5("10.台灣造訪日本以外國家人數成長率"),
    br(),
    br(),
    br(),
    br(),
    plotOutput("plot")
  ))
))