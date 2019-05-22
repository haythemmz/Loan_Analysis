#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(markdown)
#df <- read.csv("clean_loan.csv", header= TRUE , stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    navbarPage("My Application",
               tabPanel("Component 1",
                        sidebarLayout(
                            sidebarPanel(
                              fileInput("file1", "Choose CSV File",
                                        accept = c(
                                          "text/csv",
                                          "text/comma-separated-values,text/plain",
                                          ".csv")
                              ),
                              tags$hr(),
                              checkboxInput("header", "Header", TRUE)
                         
                            ),
                            mainPanel(
                                uiOutput("tb")
                        
                        )
                        )
               ),
               tabPanel("Component 2",
                        sidebarPanel(
                          conditionalPanel(condition="input.tabselected==1",
                          
                          
                          selectInput("var", label = "1. Select the quantitative Variable", 
                                      choices = c("loan_amnt" = 7, "funded_amnt" = 8, "int_rate" = 11, "installment"=12),
                                      selected = 3), 
                          
                          
                          sliderInput("bin", "2. Select the number of histogram BINs by using the slider below", min=5, max=25, value=15),
                          
                          radioButtons("colour", label = "3. Select the color of histogram",
                                       choices = c("Green", "Red",
                                                   "Yellow"), selected = "Green")
                        )
                        ,conditionalPanel(condition="input.tabselected==2",
                                            
                                            
                                            
                                            selectInput("var_1", label = "1. Select the quantitative Variable", 
                                                        choices = c("loan_amnt" = 7, "funded_amnt" = 8, "int_rate" = 11, "installment"=12),
                                                        selected = 3) 
                                            
                                            
                                            
                                          )
                        ),
                        mainPanel(
                          tabsetPanel(
                            tabPanel( "Histogramme", value=1,
                          
                          plotOutput("myhist")
                        ),
                        tabPanel( "Boxplot", value=2,
                                  
                                  plotOutput("myhist")
                        ),
                        id = "tabselected")       
                        
                        )),
               tabPanel("Component 3")
)
)
)

