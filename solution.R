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

    sidebarLayout(
        sidebarPanel(
            selectInput("xvar", label = h3("Select x variable"),
                        choices = vars,
                        selected = 1),

        selectInput("yvar", label = h3("Select y variable"),
                    choices = vars,
                    selected = 2),


            sliderInput("psize",
                        "Point size:",
                        value = 2,
                        min = 1,
                        max = 10),
            br(),br()
            ),

        mainPanel(
            plotOutput("plot", height="600")
            )


        )
    )

server <- function(input, output) {

    output$plot <- renderPlot({
        v1 <- as.numeric(input$xvar)
        v2 <- as.numeric(input$yvar)
        psize <- as.numeric(input$psize)

        par(mar=c(4,4,0,0)+.1, cex=1.4)
        plot(mtcars[,v1], mtcars[,v2], col="red", main="", xlab=names(mtcars)[v1],  ylab=names(mtcars)[v2], pch=20, cex=psize)
    })


}



# shinyServer(server)


shinyApp(ui = ui, server = server)
