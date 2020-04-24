library(shinydashboard)

shinyUI(dashboardPage( skin = "purple",
    dashboardHeader(title = "Drug Overdose Deaths in USA ",
                    titleWidth = 230), 
    dashboardSidebar(
        sidebarUserPanel("Contents")
                     ), 
    dashboardBody(tags$head(tags$style(HTML('
      .main-header .logo {
        font-family: "Georgia", Times, "Century Gothic", serif;
        font-weight: bold;
        font-size: 16px;
      }
    '))))
))
