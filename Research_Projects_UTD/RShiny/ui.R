library(shinydashboard)

dashboardPage(
  skin = "red",
  dashboardHeader(title = "Price Test Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      img(src="X.png", height = 75, width = 230),
      menuItem("Common Initial Configuration", tabName = "initConfig", icon = icon("dashboard"),
               badgeColor = "red"),
      menuItemOutput("menuitem")
      # badgeLabel = "new",
      #uiOutput('mytabs')
    )
  ),
  dashboardBody(
    tags$head(
      includeCSS(path = "www/style.css")
    ),
    tabItems(
      
      #===============================================================================
      # initial configuration section
      #===============================================================================
      tabItem(tabName = "initConfig",
              h1("Please Configure Your Experiment:"),
              #fluidRow( 
                
              #  column(4,#offset = 1, 
              tags$tr(
                       box( wellPanel(
                         img(src="ABTesting.png", height = 35, width = 65),
                           radioButtons("Methodology", h3("Select Methodology:"),
                                                                     c("A/B Testing" = "ABTesting",
                                                                       "Thompson Sampling" = "ThompsonSampling")))),
                       box(  wellPanel(
                         img(src="network.png", height = 35, width = 65),
                            radioButtons("Network", h3("Select Network type:"),
                                        c("D" = "D",
                                          "SHI" = "SHI" ,
                                          "LHI" = "LHI")))
                           
                           ),
                       
                       box(
                         wellPanel(img(src="AirlineAncillary.jpg", height = 60, width = 240),
                         selectInput('ancillary', 'Select the Ancillary:',
                                     c('BIKE BOX','MUSICAL INSTRUMENTS UPTO 39 IN','1ST ADDITIONAL BAG', '2ND ADDITIONAL BAG', 'EXTRA LEGROOM', 'CARBON OFFSET',
                                       'Loyalty UPG FLX TO BIZ','Loyalty UPG FLX TO PREM',
                                                                 'PET IN HOLD SMALL','PET IN HOLD MEDIUM','PET IN HOLD EXTRA LARGE', 'GROUP INFLIGHT SNACK',
                                                                  'ADVANCE SEAT SELECTION','OVERWEIGHT BAG 24KG TO 32KG'))
                       )),
                       
                       box( wellPanel(
                         img(src="CustomerSegments.png", height = 63, width = 75),
                           radioButtons("CustSeg", h3("Customer Segment:"),
                                        c("Business" = "Business",
                                          "Leisure" = "Leisure",
                                          "Visiting Friends and Family" = "VFF")))
                           ),
                       box( wellPanel(
                         img(src="Four_seasons.jpg", height = 63, width = 150),
                           radioButtons("Seasonality", h3("Consider Seasonality:"),
                                        c("Simple (without seasonality)" = "NotSeasonal",
                                          "Seasonal (not active)" ="Seasonal")))),
                       
                       box( wellPanel(
                         img(src="AdvancePurchase.jpeg", height = 63, width = 75),
                           radioButtons("AdvancePurchase", h3("Consider Advance Purchase:"),
                                        c("Simple (not consider advance purchase)" = "NoAP",
                                          "Consider Advance Purchase (not active)" = "AP")))),
                       submitButton("Submit")
                      
                       
                       )
                                   
              #column(5,
          #   tags$td(      
           #          )
            #         img(src="PriceTestingConfig.jpg", height = 400, width = 650)) #),
           #column(6,
#            tags$div(
#             )
              
      ),
      
      #===============================================================================
      # Secondary configuration section
      #===============================================================================
      tabItem(tabName = "ABTestingConfig",
              img(src="AB-Testing-business.jpg", height = 100, width = 200),
              h1("A/B Testing"),
            #  fluidRow(
              tabBox(
                tabPanel("Common Configuration", h3(verbatimTextOutput("text"))),
                tabPanel("Historical Price Configuration", wellPanel(submitButton("Submit")), wellPanel(uiOutput("CurPrice")),
                         wellPanel(uiOutput("CurConvRate")),
                         wellPanel(uiOutput("secondaryConfig"))),
                tabPanel("Contender Price Options",wellPanel( submitButton("Submit")),wellPanel(uiOutput("priceOptions"))),
                tabPanel("View Experiment Details", wellPanel(p("Please Approve the Changes to See the updated Configuration:"),
                         submitButton("Submit")),h3("The A/B Testing Configuration:")
                                                             , dataTableOutput("DetailOfStatTest")
                         ),
                tabPanel("Results", plotOutput('ABTestingPlot'))
              )#)
      ),
      #===============================================================================
      # Results section
      #===============================================================================
      tabItem(tabName = "ThompsonSamplingConfig",
              img(src="multiArmBandit.png", height = 100, width = 200),
              h1("Thompson Sampling"),
              tabBox(
                tabPanel("Common Configuration", h3(verbatimTextOutput("TSCommConfig"))),
              
              tabPanel("Historical Price Configuration", wellPanel(submitButton("Submit")), wellPanel(uiOutput("CurPriceTS")),
                       wellPanel(uiOutput("CurConvRateTS")),
                       wellPanel(uiOutput("numberOfDays")),
                       wellPanel(uiOutput("numberOfDailyPassengers"))
                       ),## numberOfDays, numberOfDailyPassengers
              tabPanel("Contender Price Options",wellPanel( submitButton("Submit")),wellPanel(uiOutput("priceOptionsTS")))
#               tabPanel("View Experiment Details", wellPanel(p("Please Approve the Changes to See the updated Configuration:"),
#                                                             submitButton("Submit")),h3("The A/B Testing Configuration:")
#                        , dataTableOutput("DetailOfStatTest")
#               )
                ,tabPanel("Converstion Probability Results",  wellPanel(p('Please press show results and then submit button to view the results'),
                                                tags$div(actionButton("showTSRslt", "Show Results")),tags$br(),tags$div(submitButton("Submit"))), wellPanel(
                          wellPanel(plotOutput('TSProbPlot'))
                          ))
                  ,tabPanel("Revenue Distribution Results",  wellPanel(p('Please press show results and then submit button to view the results'),
                                tags$div(actionButton("showTSRslt", "Show Results")),tags$br(),tags$div(submitButton("Submit"))), wellPanel(
                                  wellPanel( plotOutput('TSRevPlot'))
                                ))
                  ,tabPanel("Dynamic Proportion of Price Exercise",  wellPanel(p('Please press show results and then submit button to view the results'),
                                                                         tags$div(actionButton("showTSRslt", "Show Results")),tags$br(),tags$div(submitButton("Submit"))), wellPanel(
                                                                           wellPanel( plotOutput('gpriceExerciseAcrossDays'))
                                                                         ))
                  #TSProbPlot TSRevPlot gpriceExerciseAcrossDays
              )
      )
    )
  )
)


#, icon = icon("X.png")