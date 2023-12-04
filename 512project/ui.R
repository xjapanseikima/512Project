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
  titlePanel("Explore Factors that May Affect Sleep Quality"),
  HTML("<br>"),
  HTML("<p style='font-size: 16px;'>by Chun-Yu Tseng, Hang Lu, Qiaoyi Wu</p>"),
  HTML("<br>"),
  HTML("<p style='font-size: 16px;'>Description</p>"),
  HTML("<br>"),
  HTML("<p style='font-size: 16px;'>This data allows exploration and analysis of relationships between various health and lifestyle factors, potentially enabling insights into how sleep, physical activity, stress, and other factors relate to overall health and well-being. Analyzing this dataset could help identify correlations or patterns influencing individuals' health conditions and sleep-related issues.
       Overall, we have a several conclusion of what we found in these datasets</p>"),
  HTML("<br>"),
  HTML("1. Physical activity vs sleep quality：Physical activity positively correlates with sleep quality. Higher levels of physical activity are associated with better sleep quality."),
  HTML("<br>"),
  HTML("2. Stress level vs blood pressure:  Stress level's impact on blood pressure is complex. While common belief suggests higher stress may lead to elevated blood pressure, this dataset doesn’t provide strong evidence to support it."),
  HTML("<br>"),
  HTML("3. Daily steps vs blood pressure: Daily steps are inversely correlated with blood pressure in this data. Individuals with more daily steps tend to have lower blood pressure."),
  HTML("<br>"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins","Number of bins:", min = 1, max = 60, value = 10),
      p("These selction (xyz) will affect plot 2,3,4."),
      selectInput('xcol','X Variable', names(data)),
      selectInput('ycol','Y Variable', names(data)),
      selectInput('zcol','Z Variable (Only used for 3d plot)', names(data)),
      selected = names(data)[[2]],
      p("Below selction will affect only in confusion matrix."),
      checkboxGroupInput("choices",
                         label = "Which category would you like to see in the Correlation plot?
                         Some variable have not categrrized yet..",
                         choices = unique(colnames(data)),
                         selected = unique(data)),
      textOutput("txt"),
      p("Choose two variable you want to plot in the ploty and do analysis."),
        menuItem("Description Table", tabName = "Conlusion Table"),
        #menuItem("Conclusion 1", tabName = "Conclusion"),
    ),
    mainPanel(
      DT::dataTableOutput("table"),
      plotlyOutput("scatterplot"),
      plotlyOutput("box"),
      plotOutput("distPlot"),
      plotOutput("x2"),
      plotlyOutput("threeDPlot"),
      plotOutput("corrPlot"),
      tabItem(
        tabName = "Conlusion Table",
        HTML("<p style='font-size: 16px;'> Conlusion 1:
        In this profound exploration of 400 individuals' lives, 
       the Sleep Health and Lifestyle Dataset unveils the intricate dance between work, health, and sleep quality. 
       Immerse yourself in a wealth of data covering sleep duration, quality, and lifestyle factors such as physical 
       activity levels and stress ratings. With a keen eye on cardiovascular health, this dataset delves into blood 
       pressure and heart rate metrics. The presence or absence of sleep disorders, including Insomnia and Sleep Apnea, 
       adds a critical layer to understanding the holistic well-being of each participant. Join us in deciphering the 
       profound connections within work, health, and the quality of sleep.</p>"),
        DTOutput("table2")
      ),
      # Adding from here in the Main Bar panel
    )
  )
)