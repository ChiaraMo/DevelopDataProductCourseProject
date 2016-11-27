#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(
    navbarPage("Miles per Gallon Interactive Analysis", 
               
               # First Tab of the App: description of the mtcars dataset (from ?mtcars)
               tabPanel("Dataset Details",
                        h2("Motor Trend Car Road Test"),
                        hr(),
                        h3("Description"), 
                        helpText("The data was extracted from the 1974 Motor Trend US magazine,", 
                                 " and comprises fuel consumption and 10 aspects of automobile design and perfomances",
                                 " for the 32 automobiles (1973-74 models)."),
                        h3("Format"), 
                        p("A data frame with 32 observations on 11 variables."),
                        
                        p(" [, 1]	 mpg	 Miles/(US) gallon"),
                        p(" [, 2]	 cyl	 Number of cylinders"),
                        p(" [, 3]	 disp	 Displacement (cu.in.)"),
                        p(" [, 4]	 hp	 Gross horsepower"),
                        p(" [, 5]	 drat	 Rear axle ratio"),
                        p(" [, 6]	 wt	 Weight (1000 lbs)"),
                        p(" [, 7]	 qsec	 1/4 mile time"),
                        p(" [, 8]	 vs	 V/S"),
                        p(" [, 9]	 am	 Transmission (0 = automatic, 1 = manual)"),
                        p(" [,10]	 gear	 Number of forward gears"),
                        p(" [,11]	 carb	 Number of carburetors"),
                        
                        h3("Source"),
                        
                        p("Henderson and Velleman (1981), Building multiple regression models interactively. Biometrics, 37, 391-411.")
                        ),
               
               # Second Tab of the App: intercative analysis of the relationship between mpg and other variables
               tabPanel("Analysis",
                        fluidPage(
                            titlePanel("How are variables related to Miles per Gallon (MPG)?"),
                            
                            # Side Bar Panel
                            sidebarLayout(
                                sidebarPanel(
                                    selectInput("variable", "Variable:",
                                                c("Number of cylinders" = "cyl",
                                                  "Displacement (cu.in.)" = "disp",
                                                  "Gross horsepower" = "hp",
                                                  "Rear axle ratio" = "drat",
                                                  "Weight (lb/1000)" = "wt",
                                                  "1/4 mile time" = "qsec",
                                                  "V/S" = "vs",
                                                  "Transmission" = "am",
                                                  "Number of forward gears" = "gear",
                                                  "Number of carburetors" = "carb"
                                                ))
                                ),
                                
                                # Main Panel: shows the boxplot and the regression model MPG ~ Transmission Type
                                mainPanel(
                                    h3(textOutput("caption")),
                                    
                                    tabsetPanel(type = "tabs",
                                                
                                                # Display the boxplot calculated in the Server function
                                                tabPanel("BoxPlot", 
                                                         plotOutput("mpgBoxPlot")
                                                         ),
                                                
                                                # Display the regression model plot calculated in the server function
                                                tabPanel("Regression Model", 
                                                         plotOutput("mpgPlot"),
                                                         verbatimTextOutput("fit")
                                                         )
                                                )
                                )
                            )
                            
                        )
                        ),
               
               tabPanel("Best Model",
                        h2("Quantify the MPG difference between automatic and manual transmission type"),
                        hr(),
                        helpText("The best linear regression model seems to be the one including weight (wt),", 
                                 " 1/4 mile time (acceleration, qsec) and transmission type (am),",
                                 " with weight impacting negatively on the mpg. The model is able to explain 85%  of variance."),
                        
                        verbatimTextOutput("BestModel")
                        )
        
    )
)
