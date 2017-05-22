#copy the format from the shiny tutorial
palette(c("#E41A1C", "#377EB8"))

library (shiny)

ui <- fluidPage (
  headerPanel('Yo'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(iris)),
    selectInput('ycol', 'Y Variable', names(iris), 
                selected = names(iris)[[2]]),
    numericInput('clusters', 'Cluster count', 5, min = 1, max = 8)
  ),
  mainPanel(
    plotOutput('plot1')
  )
)

server <- function (input,output) {
 
   selectedData <- reactive({
     iris[, c(input$xcol, input$ycol)]
   })
   
   clusters <- reactive({
     kmeans(selectedData(), input$clusters)
   })
   
   output$plot1 <- renderPlot({
     par(mar = c(5.1, 4.1, 0, 1))
   })
}
