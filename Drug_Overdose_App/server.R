
shinyServer(function(input, output){

############################## OVERVIEW ################################
    
    output$Graph1 <- renderPlotly({
            p <- data %>% filter(Location == 'United States') %>% 
                ggplot(aes(x = Year, y = `Rate`, group = `Rate Type`)) +
                geom_point() + geom_line(aes(color = `Rate Type`)) + 
                ggtitle('Yearly Death Rates Trends of "All Overdose" & "Opioid Overdose"') + 
                ylab("Death Rates (per 100k Population)")
            
            ggplotly(p) %>%
                layout(legend = list(orientation = "h"))
                
    })
    output$Graph2 <- renderPlotly({
        p <- data %>% filter(Location == 'United States') %>% 
            ggplot(aes(x = Year, y = `Rate`, fill = `Rate Type`)) +
            geom_col(position = position_dodge(0)) + 
            theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
            scale_x_continuous(breaks = c(2009:2018)) + 
            ylab("Death Rates Ratio (per 100k Population)") + 
            ggtitle('Yearly Death Rates Ratio Between "All Overdose" & "Opioid Overdose"') + 
            scale_fill_brewer( palette = "Accent")
        
        ggplotly(p) %>%
            layout(legend = list(orientation = "h"))
    })
    
################### INTERACTIVE GRAPHS ######################
    
    output$iGraph1 <- renderPlotly({
        p <- data %>% filter(Location == input$Location) %>% 
            ggplot(aes(x = Year, y = `Rate`, fill = `Rate Type`)) +
            geom_col(position = position_dodge(0)) + 
            theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
            scale_x_continuous(breaks = c(2009:2018)) + 
            labs(title = 'Statewide Yearly Comparison of "All Overdose" & "Opioid Overdose" Death Rates Ratio') + 
            ylab("Death Rates Ratio (per 100k Population)") + 
            scale_fill_brewer( palette = "Accent")
        
        ggplotly(p) %>%
            layout(legend = list(orientation = "h"))
                                })
    
    output$iGraph3 <- renderPlotly({ 
        p <- data %>% filter(Year == input$Year2) %>% 
            ggplot(aes(x = Location, y = Rate, fill = `Rate Type`)) +
            geom_col(position = position_dodge(0)) + 
            theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
            labs(title = 'All States Comparison of "All Overdose" & "Opioid Overdose" Death Rate') + 
            ylab("Death Rates (per 100k Population)") + 
            scale_fill_brewer( palette = "Accent")
        
        ggplotly(p) %>%
            layout(legend = list(orientation = "h"))
                                })
    
    output$iGraph2 <- renderPlotly({
        p <- data %>% filter(Location %in% c(input$Location1, input$Location2, input$Location3)) %>% 
            ggplot(aes(x = Year, y = Rate, color = Location)) + geom_point() + 
            geom_line() + facet_wrap(~ `Rate Type`) + ylab('Death Rate (per 100k population)') +
            ggtitle('Comparison of "All Overdose" & "Opioid Overdose" Death Rates Trends')
        
        ggplotly(p) %>%
            layout(legend = list(orientation = "h"))
        
                                })
    
###################### MAP ##########################
    
    output$Map1 <- renderPlotly({
        g <- list(
            scope = 'usa',
            projection = list(type = 'albers usa'),
            showlakes = TRUE,
            lakecolor = toRGB('white')
        )
        
        rate %>% filter(Year == input$Year1, `Rate Type` == 'Opioid Overdose') %>% 
            plot_geo(locationmode = 'USA-states') %>%
            add_trace(z = ~Rate, locations = ~Code,
                      color = ~Rate, colors = 'Purples') %>% 
            colorbar(title = "Death Rate (per 100k population)", limits = c(0,58)) %>% 
            layout(
                title = '"All Overdose" Death Rates in USA from 2009 - 2018',
                geo = g)
    })
    
    output$Map2 <- renderPlotly({
        g <- list(
            scope = 'usa',
            projection = list(type = 'albers usa'),
            showlakes = TRUE,
            lakecolor = toRGB('white')
        )
        
        rate %>% filter(Year == input$Year1, `Rate Type` == 'All Overdose') %>% 
            plot_geo(locationmode = 'USA-states') %>%
            add_trace(z = ~Rate, locations = ~Code,
                      color = ~Rate, colors = 'Purples') %>% 
            colorbar(title = "Death Rate (per 100k population)", limits = c(0,58)) %>% 
            layout(
                title = '"Opioid Overdose" Death Rates in USA from 2009 - 2018',
                geo = g)
    })
#################### INFOBOX #########################
    
    output$maxBox1 <- renderInfoBox({
        max <- data %>% 
            filter(Year == input$Year1, `Rate Type` == 'Opioid Overdose') %>% top_n(1)
        
        infoBox("Max Opioid Death Rate", 
                max$Rate, max$Location,
                color = "purple", fill = TRUE)
    })
    
    output$maxBox2 <- renderInfoBox({
        max <- data %>% 
            filter(Year == input$Year1, `Rate Type` == 'All Overdose') %>% top_n(1)
        
        infoBox("Max Overdose Death Rate", max$Rate, max$Location, 
                color = "purple", fill = TRUE)
    })
######################### DATA TABLE ############################
    output$table <- DT::renderDataTable({data})
    })















