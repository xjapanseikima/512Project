#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shiny.fluent)
library(tibble)
library(DT)

server <- function(input, output, session) {
    #Reading Data
    data = read.csv("../Sleep_health_and_lifestyle_dataset.csv")
    #Reactive
    filtered_data <- reactive({
        selected <- c(input$choices)
        choosenData <- data[selected]
    })
    x <- reactive({
        data[,input$xcol]
    })
    
    y <- reactive({
        data[,input$ycol]
    })
    
    z <- reactive({
        data[,input$zcol]
    })
    
   # Age vs Daily Step
   # Occupation vs Daily Steps
    output$scatterplot <- renderPlotly(
        plot1 <- plot_ly(
            x = x(),
            y = y(), 
            type = 'scatter',
            mode = 'markers')
    )
    
    output$box <- renderPlotly(
        plot1 <- plot_ly(
            x = x(),
            y = y(), 
            type = 'bar')
    )

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x = x()
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = x(),
             main = 'Age Distribution')

    })
    
    
    output$table <- DT::renderDataTable(data, options = list(
        pageLength = 10,
        initComplete = I('function(setting, json) { }')
    ))
    
    output$x2 = renderPlot({
        s = input$table_rows_selected
        par(mar = c(4, 4, 1, .1))
        plot(data)
        if (length(s)) points(data[s, , drop = FALSE], pch = 19, cex = 2)
    })
    
    output$threeDPlot <- renderPlotly(
        fig <- plot_ly(data, x = x(), y = y(), z = z(),
                       marker = list(color = x(), colorscale = c('#FFE1A1', '#683531'), showscale = TRUE))
    )
    
    
    output$txt <- renderPrint({
        selected <- c(input$choices)
        print(selected)
        cormat <- round(cor(filtered_data()),2)
        head(cormat)
    })
    output$corrPlot <- renderPlot({
        cormat <- round(cor(filtered_data()),2)
        melted_cormat <- melt(cormat)
        ggplot(data = melted_cormat, aes(x=Var1, y=Var2, fill=value)) +  geom_tile()
        
    })
}





