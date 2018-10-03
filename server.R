function(input, output) {

  #Read Tag
 
  ntext <-eventReactive(input$Read, {
    #如果沒有勾選頻率執行單點讀值
    #計時器沒為勾選的狀態
    if(input$checkTime==FALSE)
    {
    if(input$txtRest_Read=="")
    {
      return(("Tag欄位不可為空白")) #回傳警告訊息
    }
    else 
    {
      #paste為消除空白的格式
      data <- fromJSON(paste0("http://",input$txtRest,"/iotgateway/read?ids=",input$txtRest_Read))
      #table表單
      output$table <- renderTable({
        data
      })
      #總表
      output$summary <- renderPrint({
        data
      })
      #output$Tag_Name<-renderText(as.character(data[[1]][1]))  測試用
      #output$Tag_Quality<-renderText(as.character(data[[1]][2]))
      #output$Tag_Value<-renderText(as.character(data[[1]][4]))
      #output$Tag_Time<-renderText(as.character(data[[1]][5]))
    
    return(("success")) #抓到值回傳成功
    }
    }
    else
    {
      if(input$txtRest_Read=="")
      {
        return(("Tag欄位不可為空白"))
      }
      else 
      {
       #此處為R語言頻率
   #auto這段為制定頻率，as.numeric為強制轉換為實數
        autoInvalidate <- reactiveTimer(as.numeric(input$txtUpdatarate))
        #在這頻率下執行
        observe({
          autoInvalidate()
        data <- fromJSON(paste0("http://",input$txtRest,"/iotgateway/read?ids=",input$txtRest_Read))
        output$table <- renderTable({
          data
        })
        output$summary <- renderPrint({
          data
        })
        output$plot <- renderPlot({
          dist <- renderText(as.character(data[[1]][1]))
          n <- renderText(as.character(data[[1]][4]))
          
          hist(as.numeric(data[[1]][4])(), 
               main=paste('r', dist, '(', n, ')', sep=''))
        })
        #output$Tag_Name<-renderText(as.character(data[[1]][1]))
        #output$Tag_Quality<-renderText(as.character(data[[1]][2]))
        #output$Tag_Value<-renderText(as.character(data[[1]][4]))
        #output$Tag_Time<-renderText(as.character(data[[1]][5]))
        
       # return(("Update success"))
        })
        return(("頻率讀取"))
      }
    }
  })
  #Connect
  connect <- eventReactive(input$btnConnect, {
    
    if(input$txtRest=="")
    {
      return(("IP欄位不可以為空白，且格式要為IP+Port"))
      
    }
    else 
    {
      connect <- fromJSON(paste0("http://",input$txtRest,"/iotgateway/browse"))
      return("連線正常")
    }
  })
  write <-eventReactive(input$btnwrite, {
    require("httr")
    require("jsonlite")
    url <- paste0("http://",input$txtRest,"/iotgateway/write")
    body<-list(list("id"= paste(input$txtRest_Write),"v"= as.numeric(input$txtWrite_Value)))
    get_prices <- POST(url,body = body, encode = "json")
    get_prices_text <- content(get_prices, "text")
    get_prices_text
    return("寫入成功")
  })
  
  #output
  output$nText <- renderText({
    ntext()
  })
  output$connect <- renderText({
    connect()
  })
  output$write <- renderText({
    write()
  })
}