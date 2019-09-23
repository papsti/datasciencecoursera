shinyServer(function(input, output) {
   
  output$rentPlot <- renderPlot({
    
    ## Make plots of year vs value, with different colours for types of units, faceted by geographic location and type of structure
    
    ## Set variables
    facet_by_str <- TRUE
    if (input$facet_var == "type_of_structure"){
      colour_var <- "type_of_unit"
      col_name <- "Type of unit"
    } else {
      colour_var <- "type_of_structure"
      col_name <- "Type of structure"
    }
    
    ## CHANGE THIS BACK TO HOUSING
    plot_housing <- housing %>%
      filter(geo == input$select_geo)
    the_plot <- ggplot(plot_housing, aes(x = year,
                                          y = avg_monthly_rent,
                                          colour = get(colour_var))) + 
      facet_grid(cols = vars(get(input$facet_var))) + 
      labs(title = paste0("Average monthly rents over time for ", input$select_geo),
           x = "Year",
           y = "Average monthly rent",
           colour = col_name)
    
    ## Either show plot with linear model or a line plot
    if(input$show_lm){
      the_plot +
        geom_point() +
        geom_smooth(formula = y ~ x, method = "lm") 
    } else {
      the_plot +
        geom_line() 
    }
    
  }, res = 90)
  
})
