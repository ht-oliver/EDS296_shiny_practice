# ---- user interface ----
ui <- navbarPage(
  
  # title
  title = "Sensitive Animal Exploration",
  
  # (Page 1) intro tabPanel ----
  tabPanel(title = "About the app",
           
          # intro text fluidRow
          fluidRow(
            
            column(1),
            column(10, includeMarkdown("text/about.md")),
            column(1)
          ), # END intro text fluidRow
          
          hr(),
          includeMarkdown("text/footer.md")
          
  ), # END (Page 1) intro tabPanel
  
  
  # (Page 2) data tabPanel
  tabPanel(title = "Explore the Data",
           
           # tabsetPanel to contain tabs for data viz 
           tabsetPanel(
             
             # trout tabPanel
             tabPanel(
               
               title = "Trout",
               # trout sidebarLayout
               sidebarLayout(
                 
                 # trout plot sidebarPanel ----
                 sidebarPanel(
                   
                   # channel type pickerInput ----
                   pickerInput(inputId = "channel_type_input", label = "Select channel type(s):",
                               choices = unique(clean_trout$channel_type),
                               selected = c("cascade", "pool"),
                               options = pickerOptions(actionsBox = TRUE),
                               multiple = TRUE), # END channel type pickerInput
                   
                   # section checkboxGroupButtons ----
                   checkboxGroupButtons(inputId = "section_input", label = "Select a sampling section(s):",
                                        choices = c("clear cut forest", "old growth forest"),
                                        selected = c("clear cut forest", "old growth forest"),
                                        individual = FALSE, justified = TRUE, size = "sm",
                                        checkIcon = list(yes = icon("check", lib = "font-awesome"), 
                                                         no = icon("xmark", lib = "font-awesome"))), # END section checkboxGroupInput
                   
                 ), # END trout plot sidebarPanel
                 
                 # trout mainPanel
                 mainPanel(
                   plotOutput(outputId = "trout_scatterplot_output")
                   
                 ) # End trout sidebarPanel
               ) # END trout sidebarLayout
               
             ), # END trout tabPanel
             
             # penguins tabPanel
             tabPanel(
               title = "Penguins",
               # penguin sidebarLayout ----
               sidebarLayout(
                 
                 # penguin sidebarPanel ----
                 sidebarPanel(
                   
                   # channel type pickerInput ----
                   pickerInput(inputId = "island_input", label = "Select island",
                               choices = unique(penguins$island),
                               selected = c("Dream", "Torgersen"),
                               options = pickerOptions(actionsBox = TRUE),
                               multiple = TRUE), # END channel type pickerInput
                   
                   # bin number slider input -----
                   sliderInput(inputId = "bin_num_input",
                               label = "Select number of bins",
                               min = 5, max = 50, value = 25),
                   
                   # section checkboxGroupButtons ----
                   checkboxGroupButtons(inputId = "species_input", label = "Select a species",
                                        choices = unique(penguins$species),
                                        selected = c("Adelie", "Chinstrap", "Gentoo"),
                                        individual = FALSE, justified = TRUE, size = "sm",
                                        checkIcon = list(yes = icon("check", lib = "font-awesome"), 
                                                         no = icon("xmark", lib = "font-awesome"))), # END section checkboxGroupInput
                   
                 ), # END penguin sidebarPanel
                 
                 # penguin mainPanel ----
                 mainPanel(
                   plotOutput(outputId = "penguin_histogram_output")
                   
                 ) # END penguin mainPanel
               ) # END penguin sidebarLayout
             ) # End penguins tabPanel
           ) # End tabsetPanel
  ), # End (Page 2) data tabPanel
)

