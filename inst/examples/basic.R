library(shiny)
library(snapper)
options(device.ask.default = FALSE)
# Define UI
ui <- fluidPage(id = 'page',

# load snapper into the app
load_snapper(),

titlePanel("Hello Shiny!"),

sidebarLayout(

 sidebarPanel(id = 'side', # add id to side panel
   sliderInput("obs",
               "Number of observations:",
               min = 0,
               max = 1000,
               value = 500),

   # add a download button for the side panel by id
   snapper::download_button(ui = '#side',
   label = 'Download Side Panel',
   filename = 'side_panel.png'),

   # add a preview button for the side panel by id
   snapper::preview_button(ui = '#side',
   previewId = 'preview_side',
   label = 'Preview Side Panel'),

   # add a preview button for the main panel by id
   snapper::preview_button(ui = '#main',
   previewId = 'preview_main',
   label = 'Preview Main Panel')
 ),

 # Show a plot of the generated distribution
 mainPanel(id = 'main', # add id to main panel

   # add a download link for the main panel
   snapper::download_link(
      ui = '#main',
      label = '',
      filename = 'main_panel.png'
   ),
   plotOutput("distPlot"),

   # create a div that will display the content created by preview_side
   shiny::tags$h3('Preview Side Panel'),
   snapper::snapper_div(id = 'preview_side'),

   # create a div that will display the content created by preview_main
   shiny::tags$h3('Preview Main Panel'),
   snapper::snapper_div(id = 'preview_main')
 )
  )
)

# Server logic
server <- function(input, output) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
}

# Complete app with UI and server components
shinyApp(ui, server)
