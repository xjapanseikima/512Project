library(shiny)
library(shiny.fluent)
library(tibble)



ui <- fluentPage(
    uiOutput("analysis")
)

server <- function(input, output, session) {
    data = read.csv("../Sleep_health_and_lifestyle_dataset.csv")
    
    details_list_columns <- tibble(
        fieldName = c("rep_name", "date", "deal_amount", "client_name", "city", "is_closed", "is_closed_2", "is_closed_3", "is_closed_2", "is_closed_4"),
        name = c("Sales rep", "Close date", "Amount", "Client", "City", "Is closed?", "is_closed_2", "is_closed_3", "is_closed_2", "is_closed_4"),
        key = fieldName)
    # filters <- tagList(
    #     DatePicker.shinyInput("fromDate", value = as.Date('2020/01/01'), label = "From date"),
    #     DatePicker.shinyInput("toDate", value = as.Date('2020/12/31'), label = "To date")
    # )
    
    filtered_deals <- reactive({
        filtered_deals <- data
    })
    
    
    
    output$analysis <- renderUI({
        items_list <- if(nrow(filtered_deals()) > 0){
            DetailsList(items = filtered_deals())
        } else {
            p("No matching transactions.")
        }
        
        Stack(
            tokens = list(childrenGap = 5),
            Text(variant = "large", "Sales deals details", block = TRUE),
            div(style="max-height: 500px; overflow: auto", items_list)
        )
    })
}

shinyApp(ui, server)