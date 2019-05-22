#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
options(shiny.maxRequestSize=30*1024^2) 
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$filedf <- renderTable({
        if(is.null(input$file)){return ()}
        input$file # the file input data frame object that contains the file attributes
    })
    
    
    output$filedf2 <- renderTable({
    if(is.null(input$file)){return ()}
    input$file$datapath })
    
    output$fileob <- renderPrint({
        if(is.null(input$file)){return ()}
        str(input$file)
    })
    
    ## Summary Stats code ##
    # this reactive output contains the summary of the dataset and display the summary in table format
    output$summ <- renderPrint({
        if(is.null(input$file)){return()}
        summary(read.table(file=input$file$datapath,
                           sep=input$sep, 
                           header = input$header, 
                           stringsAsFactors = input$stringAsFactors))})
    
    ## Dataset code ##
    # This reactive output contains the dataset and display the dataset in table format
    output$table <- renderTable({ 
        if(is.null(input$file)){return()}
        read.table(file=input$file$datapath,  sep=input$sep, 
                   header = input$header, 
              stringsAsFactors = input$stringAsFactors)
         })
        
        
    
    
    ## MainPanel tabset renderUI code ##
    # the following renderUI is used to dynamically generate the tabsets when the file is loaded. 
    # Until the file is loaded, app will not show the tabset.
    output$tb <- renderUI({
        if(is.null(input$file)) {return()}
        else
            tabsetPanel(
                tabPanel("Input File Object DF ", tableOutput("filedf"), tableOutput("filedf2")),
                tabPanel("Input File Object Structure", verbatimTextOutput("fileob")),
                tabPanel("Dataset", tableOutput("table")),
                tabPanel("Summary Stats", verbatimTextOutput("summ")))
    })
    
    
    output$myhist <- renderPlot(
        
        {if(is.null(input$file)){return()}
            df<- read.table(file=input$file$datapath,  sep=input$sep, 
                       header = input$header, 
                       stringsAsFactors = input$stringAsFactors)
            colm = as.numeric(input$var)
            hist(df[,colm], col =input$colour, xlim = c(0, max(df[,colm])), main = "Histogram of Loan dataset", breaks = seq(0, max(df[,colm]),l=input$bin+1), xlab = names(df[colm]))}
        
    )    
   

})



    