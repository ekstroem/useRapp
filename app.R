library(shiny)
data(mtcars)

vars <- lapply(1:ncol(mtcars), function(i) { i })
names(vars) <- names(mtcars)

ui <- fluidPage(

    ## Application title
    titlePanel("mtcars data"),

    ## Sidebar with controls to select the random distribution type
    ## and number of observations to generate. Note the use of the
    ## br() element to introduce extra vertical spacing

    sidebarLayout(     # Global layout 
        sidebarPanel(  # Contents for the side bar
            selectInput("xvar", label = h3("Select x variable"),
                        choices = vars,
                        selected = 1),

            selectInput("yvar", label = h3("Select y variable"),
                        choices = vars,
                        selected = 2),
                            
            br(),br()
       ),
       mainPanel(      # What is in the main panel
            plotOutput("plot", height="600")
            )
    )
)

server <- function(input, output) {

    output$plot <- renderPlot({
        v1 <- as.numeric(input$xvar)
        v2 <- as.numeric(input$yvar)
        par(mar=c(4,4,0,0)+.1, cex=1.4)
        plot(mtcars[,v1], mtcars[,v2], col="red", main="", xlab=names(mtcars)[v1],  ylab=names(mtcars)[v2], pch=20)
    })
}

shinyApp(ui = ui, server = server)

