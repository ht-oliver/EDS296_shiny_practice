# ---- load packages ----
library(shiny)
library(tidyverse)
library(palmerpenguins)
library(DT)

# ---- user interface ----
ui <- fluidPage(
  
  # app title
  tags$h1("Very Cool and Sweet App"),
  
  # app subtitle
  h3(strong("Which Penguin Species is Best")),
  
  # body mass slider input ----
  sliderInput(inputId = "body_mass_input",
              label = "Select a range of body masses(g)",
              min = 2700, max = 6300, value = c(3000, 4000)),
  
  # body mass plot output
  plotOutput(outputId = "body_mass_scatterplot_output"),
  
  # checkbox year input
  checkboxGroupInput(inputId = "year_checkbox_input",
                     label = "Select year(s)",
                     choices = unique(penguins$year),
                     selected = c(2007, 2008, 2009)),
  
  # checkbox dt output
  DT::dataTableOutput(outputId = "year_checkbox_output")
)


# ---- server ----
server <- function(input, output) {
  
  # filter body masses ----
  body_mass_df <- reactive({
    penguins %>% 
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
  })
  
  output$body_mass_scatterplot_output <- renderPlot({
    
    # code to generate plot goes here
    
    ggplot(na.omit(body_mass_df()), 
           aes(x = flipper_length_mm, y = bill_length_mm, 
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
      scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
      labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
           color = "Penguin species", shape = "Penguin species") +
      guides(color = guide_legend(position = "inside"),
             size = guide_legend(position = "inside")) +
      theme_minimal() +
      theme(legend.position.inside = c(0.85, 0.2), 
            legend.background = element_rect(color = "white"))
    
  })
  
  # filter for years dt
  years_dt <-
    reactive({
      penguins %>% 
        filter(year %in% as.numeric(input$year_checkbox_input))
    })
  
  # Create DT table
  output$year_checkbox_output <- DT::renderDT({
    DT::datatable(years_dt())
  })
}

# ---- combine ui & server into an app ----
shinyApp(ui = ui, server = server)