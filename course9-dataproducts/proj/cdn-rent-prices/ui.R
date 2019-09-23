# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Canadian rentals"),
  
  ## Description
  verticalLayout(
    HTML("<h4>Explore changes to the Canadian rental market over time</h4>
    <p>The data were gathered by the Canadian Mortgage and Housing 
       Corporation and were retrieved from 
       <a href='https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3410013301'>Statistics Canada</a>
       on 2019-09-09.</p>
    <p>Rental prices are <b>not</b> adjusted for inflation.</p>")
  ),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      h4("Choose options"),
      selectInput("select_geo", label = "City",
                  choices = sort(housing$geo),
                  selected = 1), ## CHANGE THIS BACK TO HOUSING
      selectInput("facet_var", label = "Facet variable",
                  choices = list("Type of structure" = "type_of_structure",
                                 "Type of unit" = "type_of_unit")),
      helpText("The facet variable is the variable by which to split 
               the plot into different panels (based on the different
               values for the facet variable)."),
      checkboxInput("show_lm", label = "Fit linear model", 
                    value = FALSE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("rentPlot")
    )
  )
))
