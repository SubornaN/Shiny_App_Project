shinyServer(function(input, output){
    
    output$Text1 <- renderText({'Will add info'})
    
    output$table <- DT::renderDataTable({data})
    
    output$Line1 <- renderPlotly({
            p <- data %>% filter(Location == 'United States') %>% 
                ggplot(aes(x = Year, y = `Rate`, group = `Rate Type`)) +
                geom_point() + geom_line(aes(color = `Rate Type`)) + 
                ggtitle('Trends of All Overdose & Opioid Death Rates') + 
                ylab("Death Rates (per 100,000 Population)")
            ggplotly(p) %>%
                layout(legend = list(orientation = "h"))
    })
    output$Bar1 <- renderPlotly({
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

    
    })