library(shiny)
library(tidyverse)
homerange <- readr::read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")

ui <- fluidPage(selectInput( "x", "Select X Variable", choices = c("trophic.guild", "thermoregulation"), selected = "trophic.guild"), 
                selectInput("y", "Select Y Variable", choices = "locomotion", selected = "locomotion"), 
                plotOutput("plot", width ="500px", height="400px"))

server <- function(input, output, session) 
{output$plot <- renderPlot({ggplot(data=homerange, aes_string(x="locomotion", fill=input$x))+geom_bar()  + theme_classic(base_size = 18)})}

shinyApp(ui, server)