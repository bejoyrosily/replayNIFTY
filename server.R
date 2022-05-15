library(shiny)
library(dplyr)
library(tidyquant)
library(plotly)



server <- function(input, output, session) {
  
  hline <- function(x0 , x1, y , color, dash) {
    
    list(
      
      type = "line",
      x0 = 0,
      x1 = 1,
      xref = "paper",
      y0 = y,
      y1 = y,
      line = list(color = color, dash = dash)
      
    )
  }
  
  globalvars <- reactiveValues(df = 0, n = 1, nRows = 0, plt = 0, lsdf = 0)
  data <- read.csv('./data/NIFTY_2008_2020_5min.csv')
  cprs <- read.csv('./data/cprs_2010_2020.csv')
  data$DateTime <- as.POSIXct(data$DateTime, tz = Sys.timezone())
  globalvars$lsdf <- data.frame(Long = numeric(5), Short = numeric(5))
  
  output$PL1 <- renderText({
    toString(round(globalvars$lsdf$Short[1] - globalvars$lsdf$Long[1],2))
  })
  output$PL2 <- renderText({
    toString(round(globalvars$lsdf$Short[2] - globalvars$lsdf$Long[2],2))
  })
 
  observeEvent(input$submit, {
    globalvars$lsdf[! is.na(globalvars$lsdf)] = NA
    df <- data[as.Date(data$DateTime) == input$date, ]
    cprs_df <- cprs[as.Date(cprs$Date) == input$date, ]
    globalvars$n = 1
    globalvars$df <- df
    globalvars$nRows <- nrow(df)
    
    output$fig_scrip <- renderPlotly({
      
   
      plot_ly(data = df[1:globalvars$n,], x = ~DateTime, type="candlestick",
                open = ~Open, close = ~Close,
                high = ~High, low = ~Low, name = 'nifty spot') %>%
        
        add_lines(x = ~DateTime, y = ~sma20, line = list(color = 'green', width =2), inherit = F, name = 'sma20') %>%
        add_lines(x = ~DateTime, y = ~sma50, line = list(color = 'red', width = 2), inherit = F, name = 'sma50') %>%
        add_lines(x = ~DateTime, y = ~sma200, line = list(color = 'black', width = 2), inherit = F, name = 'sma200') %>%
        
        layout(xaxis = list(rangeslider = list(visible = F), 
                            range = c(df$DateTime[1] - 900, df$DateTime[globalvars$nRows] + 900), title = 'Time'),
               yaxis = list(range = c(cprs_df[1, 'PP'] + input$yRange[1] *(cprs_df[1, 'PP'] - cprs_df[1, 'S1']),
                                      cprs_df[1, 'PP'] + input$yRange[2] *(cprs_df[1, 'R1'] - cprs_df[1, 'PP'])), title = 'NIFTY50'),
              
               shapes = list(hline(df$DateTime[1], df$DateTime[globalvars$nRows], cprs_df[1, 'R1'], 'fuchsia', 'dash'),
                hline(df$DateTime[1], df$DateTime[globalvars$nRows], cprs_df[1, 'R2'], 'fuchsia', 'dash'),
                hline(df$DateTime[1], df$DateTime[globalvars$nRows], cprs_df[1, 'R3'], 'fuchsia', 'dash'),
                hline(df$DateTime[1], df$DateTime[globalvars$nRows], cprs_df[1, 'R4'], 'fuchsia', 'dash'),
                hline(df$DateTime[1], df$DateTime[globalvars$nRows], cprs_df[1, 'R5'], 'fuchsia', 'dash'),
                hline(df$DateTime[1], df$DateTime[globalvars$nRows], cprs_df[1, 'S1'], 'blue', 'dash'),
                hline(df$DateTime[1], df$DateTime[globalvars$nRows], cprs_df[1, 'S2'], 'blue', 'dash'),
                hline(df$DateTime[1], df$DateTime[globalvars$nRows], cprs_df[1, 'S3'], 'blue', 'dash'),
                hline(df$DateTime[1], df$DateTime[globalvars$nRows], cprs_df[1, 'S4'], 'fuchsia', 'dash'),
                hline(df$DateTime[1], df$DateTime[globalvars$nRows], cprs_df[1, 'S5'], 'fuchsia', 'dash'),
                hline(df$DateTime[1], df$DateTime[globalvars$nRows], cprs_df[1, 'PP'], 'teal', 'dash')),
               
               annotations = list(list( 
                 x = df$DateTime[globalvars$nRows], 
                 y = cprs_df[1, 'R1']+5,
                 xref = 'x',
                 yref = 'y',
                 text = 'R1',
                 showarrow = FALSE
               ),
               list( 
                 x = df$DateTime[globalvars$nRows],
                 y = cprs_df[1, 'R2']+5,
                 xref = 'x',
                 yref = 'y',
                 text = 'R2',
                 showarrow = FALSE
               ),
               list( 
                 x = df$DateTime[globalvars$nRows],
                 y = cprs_df[1, 'R3']+5,
                 xref = 'x',
                 yref = 'y',
                 text = 'R3',
                 showarrow = FALSE
               ),
               list( 
                 x = df$DateTime[globalvars$nRows],
                 y = cprs_df[1, 'R4']+5,
                 xref = 'x',
                 yref = 'y',
                 text = 'R4',
                 showarrow = FALSE
               ),
               list( 
                 x = df$DateTime[globalvars$nRows],
                 y = cprs_df[1, 'R5']+5,
                 xref = 'x',
                 yref = 'y',
                 text = 'R5',
                 showarrow = FALSE
               ),
               list( 
                 x = df$DateTime[globalvars$nRows],
                 y = cprs_df[1, 'S1']-5,
                 xref = 'x',
                 yref = 'y',
                 text = 'S1',
                 showarrow = FALSE
               ),
               list( 
                 x = df$DateTime[globalvars$nRows],
                 y = cprs_df[1, 'S2']-5,
                 xref = 'x',
                 yref = 'y',
                 text = 'S2',
                 showarrow = FALSE
               ),
               list( 
                 x = df$DateTime[globalvars$nRows],
                 y = cprs_df[1, 'S3']-5,
                 xref = 'x',
                 yref = 'y',
                 text = 'S3',
                 showarrow = FALSE
               ),
               list( 
                 x = df$DateTime[globalvars$nRows],
                 y = cprs_df[1, 'S4']-5,
                 xref = 'x',
                 yref = 'y',
                 text = 'S4',
                 showarrow = FALSE
               ),
               list( 
                 x = df$DateTime[globalvars$nRows],
                 y = cprs_df[1, 'S5']-5,
                 xref = 'x',
                 yref = 'y',
                 text = 'S5',
                 showarrow = FALSE
               ),
               list( 
                 x = df$DateTime[globalvars$nRows],
                 y = cprs_df[1, 'PP']+5,
                 xref = 'x',
                 yref = 'y',
                 text = 'PP',
                 showarrow = FALSE
               )),
                
               showlegend = TRUE,
               legend = list(x = 0.9, y = 0.1))
        
      
    }
    ) 
  })
  
  observeEvent(input$next_candle, {
    if (globalvars$n < globalvars$nRows) {
      globalvars$n <- globalvars$n + 1
    }
  })
  
  observeEvent(input$prev_candle, {
    if (globalvars$n >= 2) {
      globalvars$n <- globalvars$n - 1
    }
  })
  
  observeEvent(input$long1, {
    globalvars$lsdf$Long[1] <- globalvars$df$Close[globalvars$n]
    output$long1_value <- renderText({
      toString(globalvars$lsdf$Long[1])
    })
  })
  
  observeEvent(input$short1, {
    globalvars$lsdf$Short[1] <- globalvars$df$Close[globalvars$n]
    output$short1_value <- renderText({
      toString(globalvars$lsdf$Short[1])
    })
  })
  
  observeEvent(input$long2, {
    globalvars$lsdf$Long[2] <- globalvars$df$Close[globalvars$n]
    output$long2_value <- renderText({
      toString(globalvars$lsdf$Long[2])
    })
  })
  
  observeEvent(input$short2, {
    globalvars$lsdf$Short[2] <- globalvars$df$Close[globalvars$n]
    output$short2_value <- renderText({
      toString(globalvars$lsdf$Short[2])
    })
  })
  
}
