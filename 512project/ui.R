#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shiny.fluent)
library(tibble)
library(ggplot2)
library(plotly)
library(pheatmap)
library(corrplot)
library(reshape2)


ui <- fluidPage(
  titlePanel("512 Project"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins","Number of bins:", min = 1, max = 60, value = 10),
      selectInput('xcol','X Variable', names(data)),
      selectInput('ycol','Y Variable', names(data)),
      selectInput('zcol','Z Variable (Only used for 3d plot)', names(data)),
      selected = names(data)[[2]],
      checkboxGroupInput("choices",
                         label = "Which category would you like to see in the Correlation plot?
                         Some variable have not categrrized yet..",
                         choices = unique(colnames(data)),
                         selected = unique(data)),
      textOutput("txt"),
      p("Choose two variable you want to plot in the ploty and do analysis."),
      p("Thinking...", style = "font-family: 'times'; font-si16pt"),
      # Adding from here in the SideBar panel
    ),
    mainPanel(
      DT::dataTableOutput("table"),
      plotlyOutput("scatterplot"),
      plotlyOutput("box"),
      plotOutput("distPlot"),
      plotOutput("x2"),
      plotlyOutput("threeDPlot"),
      plotOutput("corrPlot")
      # Adding from here in the Main Bar panel
    )
  )
)