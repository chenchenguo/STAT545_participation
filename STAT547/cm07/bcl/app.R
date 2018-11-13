#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

bcl <- read.csv(file="D:/STAT545_Rfile/STAT545_participation/STAT547/cm07/bcl/bcl-data.csv", stringsAsFactors = FALSE)
# Define UI for application that draws a histogram

ui <- fluidPage(
  titlePanel("BC Liquor price app", 
             windowTitle = "BCL app"),
  sidebarLayout(
    sidebarPanel("This text is in the sidebar."),
    mainPanel(
      
      plotOutput("price_hist"),
      tableOutput("bcl_data")
      
      )
  )
   
)

# Run code in server and display the output in UI
# *output()

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$price_hist <- renderPlot(ggplot2::qplot(bcl$Price))
  output$bcl_data <- renderTable(bcl)
}

# Run the application 
shinyApp(ui = ui, server = server)

