shinyServer(function(input, output){

    output$data <- DT::renderDataTable({Data})
    
    output$hist1 <- renderPlot({
        data %>% filter(Indicator == 'Overdose Deaths', Year != 2019) %>% 
        select(Year, Deaths) %>% group_by(Year) %>% summarise(Deaths = sum(Deaths)) %>% 
        ggplot() + geom_col(aes(x = Year, y = Deaths))
    })
    })