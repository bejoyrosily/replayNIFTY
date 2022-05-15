library(shiny)
library(plotly)
library(markdown)

ui <- navbarPage('Replay NIFTY',
                 
  tabPanel("Replay",
           
           sidebarPanel(
             
             dateInput('date', 'Date (From 2010-01-01 to 2020-12-31) :',  value = "2015-08-17"),
             actionButton("submit", "Submit"),
             br(),
             br(),
             actionButton("prev_candle", "Previous Candle", width = "40%"),
             actionButton("next_candle", "Next Candle", width = "40%"),
             br(),
             br(),
             sliderInput("yRange", "yRange:",
                         min = -10, max = 10, step = 0.1,
                         value = c(-1,1)),
             br(),
             br(),
             fluidRow(
               column(4,
                      actionButton("long1", "L", width = "50%"),
                      br(),
                      br(),
                      textOutput('long1_value'),
               ),
               column(4,
                      actionButton("short1", "S", width = "50%"),
                      br(),
                      br(),
                      textOutput('short1_value'),
               ),
               column(4,
                      actionButton("pl1", "PL", width = "50%"),
                      br(),
                      br(),
                      textOutput('PL1')
               ),
             ),
             br(),
             br(),
             br(),
             fluidRow(
               column(4,
                      actionButton("long2", "L", width = "50%"),
                      br(),
                      br(),
                      textOutput('long2_value'),
               ),
               column(4,
                      actionButton("short2", "S", width = "50%"),
                      br(),
                      br(),
                      textOutput('short2_value'),
               ),
               column(4,
                      actionButton("pl2", "PL", width = "50%"),
                      br(),
                      br(),
                      textOutput('PL2')
               ),
             ),
             
           ),
           
           mainPanel(
             
             fluidRow(
               
               tags$head(tags$style("#fig_scrip{height:100vh !important;}")),
               
               plotlyOutput("fig_scrip", width = '100%', height = 'auto')
               
             )
           )
  ),
  
  tabPanel("about",
           
           mainPanel(
             h1('about Replay NIFTY'),
             includeMarkdown("about.Rmd")
           )
           
  )
)