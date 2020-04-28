
shinyServer(function(input, output){

############################## OVERVIEW ################################
    
    output$Graph1 <- renderPlotly({
            p <- data %>% filter(Location == 'United States') %>% 
                ggplot(aes(x = Year, y = `Rate`, group = `Rate Type`)) +
                geom_point() + geom_line(aes(color = `Rate Type`)) + 
                ggtitle('Death Rates Trends') + 
                ylab("Death Rates (per 100k Population)") + 
                scale_color_manual(values = c("orange", "mediumpurple"))
            
            ggplotly(p) %>% layout(legend = list(orientation = "h"))
                
    })
    output$Graph2 <- renderPlotly({
        p <- data %>% filter(Location == 'United States') %>% 
            ggplot(aes(x = Year, y = `Rate`, fill = `Rate Type`)) +
            geom_col(position = position_dodge(0)) + 
            theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
            scale_x_continuous(breaks = c(2009:2018)) + 
            ylab("Death Rates (per 100k Population)") +  
            ggtitle('Comparison of Death Rates') + 
            scale_fill_manual(values = c("orange", "mediumpurple"))
        
        ggplotly(p) %>% layout(legend = list(orientation = "h"))
    })
    
    output$Graph3 <- renderPlotly({
        p <- data %>% filter(Location != "United States", `Rate Type` == "Opioid Overdose") %>% 
            group_by(Location, `Rate Type`) %>% 
            ggplot(aes(x = Location, y = Rate, fill = Location)) + geom_boxplot() +
            theme(axis.text.x = element_text(angle = 90, vjust = 0.5), legend.position = "none") +
            ggtitle('Box Plot of Opioid Overdose Death Rates for all 50 states') + 
            ylab('Death Rates (per 100k Population)')
        
        ggplotly(p)
    })
    
################### INTERACTIVE GRAPHS ######################
    
    output$iGraph1 <- renderPlotly({
        p <- data %>% filter(Location == input$Location) %>% 
            ggplot(aes(x = Year, y = `Rate`, fill = `Rate Type`)) +
            geom_col(position = position_dodge(0)) + 
            theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
            scale_x_continuous(breaks = c(2009:2018)) + 
            labs(title = 'Statewide Comparison of Death Rates') + 
            ylab("Death Rates (per 100k Population)") + 
            scale_fill_manual(values = c("orange", "mediumpurple"))
        
        ggplotly(p) %>%
            layout(legend = list(orientation = "h"))
                                })
    
    output$iGraph3 <- renderPlotly({ 
        p <- data %>% filter(Location != 'United States') %>% filter(Year == input$Year2) %>% 
            ggplot(aes(x = Location, y = Rate, fill = `Rate Type`)) +
            geom_col(position = position_dodge(0)) + 
            theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
            labs(title = 'All States Comparison of Death Rates') + 
            ylab("Death Rates (per 100k Population)") + 
            scale_fill_manual(values = c("orange", "mediumpurple"))
        
        ggplotly(p) %>%
            layout(legend = list(orientation = "h"))
                                })
    
    output$iGraph2 <- renderPlotly({
        p <- data %>% filter(Location %in% c(input$Location1, input$Location2, input$Location3)) %>% 
            ggplot(aes(x = Year, y = Rate, color = Location)) + geom_point() + 
            geom_line() + facet_wrap(~ `Rate Type`) + ylab('Death Rate (per 100k population)') +
            ggtitle('Comparison of Death Rates Trends') + 
            scale_color_manual(values = c("orange", "mediumpurple", "tomato1"))
        
        ggplotly(p) %>%
            layout(legend = list(orientation = "h"))
        
                                })
    
###################### MAP ##########################
    
    output$Map2 <- renderPlotly({
        g <- list(
            scope = 'usa',
            projection = list(type = 'albers usa'),
            showlakes = TRUE,
            lakecolor = toRGB('white')
        )
        
        rate %>% filter(Year == input$Year1, `Rate Type` == input$RateType) %>% 
            plot_geo(locationmode = 'USA-states') %>%
            add_trace(z = ~Rate, locations = ~Code,
                      color = ~Rate, colors = 'Purples') %>% 
            colorbar(title = "Death Rate (per 100k population)", limits = c(0,58)) %>% 
            layout(
                title = 'Heatmap of Death Rates in USA',
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
    
    output$maxBox3 <- renderInfoBox({
        max <- data %>% 
            filter(Year == input$Year1, `Rate Type` == 'Opioid Overdose') %>% top_n(2)
        
        infoBox("2nd Max Opioid Death Rate", max$Rate[1], max$Location[1], 
                color = "purple", fill = TRUE)
    })
    
    output$maxBox4 <- renderInfoBox({
        max <- data %>% 
            filter(Year == input$Year1, `Rate Type` == 'All Overdose') %>% top_n(2)
        
        infoBox("2nd Max Overdose Death Rate", max$Rate[1], max$Location[1], 
                color = "purple", fill = TRUE)
    })
    
######################### DATA TABLE ############################
    output$table <- DT::renderDataTable({data})
    })



