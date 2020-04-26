shinyServer(function(input, output){
    
    output$Text1 <- renderText({'Will add info'})
    
    output$table <- DT::renderDataTable({data})
    
    output$Graph1 <- renderPlotly({
            p <- data %>% filter(Location == 'United States') %>% 
                ggplot(aes(x = Year, y = `Rate`, group = `Rate Type`)) +
                geom_point() + geom_line(aes(color = `Rate Type`)) + 
                ggtitle('Trends of All Overdose & Opioid Death Rates') + 
                ylab("Death Rates (per 100,000 Population)")
            ggplotly(p) %>%
                layout(legend = list(orientation = "h"))
    })
    output$Graph2 <- renderPlotly({
        p <- data %>% filter(Location == 'United States') %>% 
            ggplot(aes(x = Year, y = `Rate`, fill = `Rate Type`)) +
            geom_col(position = 'dodge') + 
            theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
            scale_x_continuous(breaks = c(2009:2018)) + labs(title = ) + 
            ylab("Death Rates (per 100,000 Population)") + 
            ggtitle('Death Rates Comparison of All Overdose & Opioid')
        
        ggplotly(p) %>%
            layout(legend = list(orientation = "h"))
    })
    output$Graph3 <- renderPlotly({
        p <- data %>% filter(Location == input$Location1) %>% 
            ggplot(aes(x = Year, y = `Rate`, fill = `Rate Type`)) +
            geom_col(position = 'dodge') + 
            theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
            scale_x_continuous(breaks = c(2009:2018)) + 
            labs(title = 'State Yearly Comparison of All Overdose & Opioid Death Rate') + 
            ylab("Death Rates (per 100,000 Population)")
        
        ggplotly(p) %>%
            layout(legend = list(orientation = "h"))
    })

    output$Map1 <- renderPlotly({
        rate %>% filter(Year == input$Year1, `Rate Type` == 'Opioid Overdose') %>% 
            plot_geo(locationmode = 'USA-states') %>%
            add_trace(z = ~Rate, locations = ~Code,
                      color = ~Rate, colors = 'Reds') %>% 
            colorbar(title = "Death Rate (per 100,000 population)", limits = c(0,58)) %>% 
            layout(
                title = 'All Drug Overdose Deaths in USA from 2009 - 2018',
                geo = g)
    })
    output$Map2 <- renderPlotly({
        rate %>% filter(Year == input$Year1, `Rate Type` == 'All Overdose') %>% 
            plot_geo(locationmode = 'USA-states') %>%
            add_trace(z = ~Rate, locations = ~Code,
                      color = ~Rate, colors = 'Reds') %>% 
            colorbar(title = "Death Rate (per 100,000 population)", limits = c(0,58)) %>% 
            layout(
                title = 'Opioid Drug Overdose Deaths in USA from 2009 - 2018',
                geo = g)
    })
    output$maxBox1 <- renderInfoBox({
        max <- data %>% 
            filter(Year == input$Year1, `Rate Type` == 'Opioid Overdose') %>% top_n(1)
        
        infoBox("Opioid", 
                max$Rate, max$Location,
                color = "yellow", fill = TRUE)
    })
    
    output$maxBox2 <- renderInfoBox({
        max <- data %>% 
            filter(Year == input$Year1, `Rate Type` == 'All Overdose') %>% top_n(1)
        
        infoBox("All", max$Rate, max$Location, 
                color = "yellow", fill = TRUE)
    })
    
    
    
    
    
    
    
    })