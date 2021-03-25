
library(shiny)
library(ggplot2)
library(magrittr)

starting_code = "
N = 100
df = data.frame(
    one = 1:N,
    two = rnorm(N)
)

p = ggplot(df,
    aes(x = one, y = two)) + 
    geom_point(col = 'red')
    
p"

shinyServer(function(input, output, session) {
    
  #####
  # Code download
  #####
  
  # Include a downloadable file of the plot in the output list.
  output$downloadCode <- downloadHandler(
    filename = function() {
      paste("ggplot2Code.R")   
    },
    # The argument content below takes filename as a function
    # and returns what's printed to it.
    content = function(con) {
      codeLines <- unlist(split(input$plotCode, "\n"))
      writeLines(codeLines, con)
    }
  )
  
  #####
  # Plotting tab
  #####
  
  ### evaluate the code in the editor and plot result
  output$plot = renderPlot({
    input$plotButton
    eval(parse(text = isolate(input$plotCode)))
  })
  
  ########### autocomplete
  comps <- reactive({
      comps <- list()
      # comps[[input$dataset]] <- colnames(dataset())
      comps <- c(comps, list(ggplot2 = getNamespaceExports("ggplot2")))
  })
  
  output$ace_editor <- renderUI({
      ## initially, only show completions in 'comps' (i.e., ggplot)
      shinyAce::aceEditor(
          "plotCode",
          mode = "r",
          theme='twilight',
          autoScrollEditorIntoView = TRUE,
          value = starting_code,
          autoComplete = "live",
          autoCompleters = "static",
          autoCompleteList = isolate(comps())
      )
  })
  
  ## Update static auto complete list according to dataset and add local completions
  observe({
      shinyAce::updateAceEditor(session,
                                "plotCode",
                                autoCompleters = c("static", "text", "rlang"),
                                autoCompleteList = comps()
      )
  })
  
})