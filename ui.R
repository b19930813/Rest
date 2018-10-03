
library(jsonlite)
library(shiny)
shinyUI(fluidPage(
  titlePanel("R語言與REST連接"),
  sidebarLayout(
    sidebarPanel(
  textInput("txtRest", label = h3(""), value = "",placeholder = "IP+Port"),
  verbatimTextOutput("connect"),
  actionButton("btnConnect", label = "連線"),
  textOutput("Test_String"), 
  textOutput("Connect_State")
    ),
  mainPanel(
    tabsetPanel(type = "tabs", 
                tabPanel("表格", tableOutput("table")),
                tabPanel("Summary", verbatimTextOutput("summary")),
                tabPanel("Plot", plotOutput("plot"))
    )
  ),
  
  position=c("left")
),

  sidebarLayout(
    sidebarPanel(
  textInput("txtRest_Read", label = h3(""), value = "",placeholder = "Tag位置"),
      verbatimTextOutput("nText"),
  verbatimTextOutput("Tag_Write"),
  textInput("txtUpdatarate", label = h3("頻率設定"), value ="" ,placeholder="毫秒"),
  
    checkboxInput("checkTime", label = "設定頻率", value = FALSE),
  
  actionButton("Read", label = "讀取")
    ),
    mainPanel("")
  ),
sidebarLayout(
  sidebarPanel(

  #textOutput("Tag_Name"), 
  #textOutput("Tag_Value"),
  #textOutput("Tag_Quality"),
  #textOutput("Tag_Time"),
 textInput("txtRest_Write", label = h3("寫入REST"), value = "",placeholder = "寫入Tag名稱"),
 textInput("txtWrite_Value",value="",label=h3(""),placeholder = "寫入數值"),
 verbatimTextOutput("write"),
 actionButton("btnwrite",label="寫入")
),
mainPanel("")
)

  )
)



