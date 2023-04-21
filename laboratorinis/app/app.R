data = read.csv("../data/lab_sodra.csv")
data = subset(data, data$ecoActCode == 	460000)
library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Average Wage by Month for a Company"),
  sidebarLayout(
    sidebarPanel(
      textInput("code", "Enter Company Code:")
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output) {
  filtered_data <- reactive({
    subset(data, code == as.numeric(input$code))
  })
  
  output$plot <- renderPlot({
    ggplot(filtered_data(), aes(x = month, y = avgWage)) + 
      geom_line() +
      labs(x = "Month", y = "Average Wage") +
      ggtitle(paste("Average Wage by Month for", unique(filtered_data()$name)))
  })
}

shinyApp(ui, server)
