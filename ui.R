
library(shiny)

shinyUI(fluidPage(#theme='bootstrap.css',
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "main.css")
  ),

  h3("ggJAM"),
    
  fluidRow(
    
    column(4,
       uiOutput("ace_editor"),
       
       downloadButton(
         outputId = "downloadCode", 
         label    = "Download Code")
    ),
    column(8,
       plotOutput(outputId = "plot"),
       
       # Button to update plot.
       actionButton("plotButton", "Update Plot")
    )
  )
    
))