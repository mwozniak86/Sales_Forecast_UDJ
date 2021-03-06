
shinyUI(pageWithSidebar(
  
  ##########################################
  # STEP 1: The name of the application
  
  headerPanel("A UDJ Regression App"),
  
  ##########################################
  # STEP 2: The left menu, which reads the data as
  # well as all the inputs exactly like the inputs in RunStudy.R
  
  sidebarPanel(
    
    ###########################################################    
    # STEP 2.1: read the data
    
    HTML("<hr>"),
    HTML("<center>Choose the data to use:"),    
    selectInput('datafile_name_coded', '', c("SALES","LIFE","harmonData"),multiple = FALSE),
    HTML("<hr>"),
    
    ###########################################################
    # STEP 2.2: read the INPUTS. 
    # THESE ARE THE *SAME* INPUT PARAMETERS AS IN THE RunStudy.R
    
    HTML("<h4>Variable Selection </h4>"),
    HTML("(<strong>press 'ctrl'</strong> to select multiple independent variables)"),
    HTML("<br>"),
    HTML("<br>"),
    selectInput("dependent_variable","Dependent variable",  choices=c("dependent Variable"),selected=NULL, multiple=FALSE),
    #uiOutput("dependent_variable"),
    HTML("<br>"),
    selectInput("independent_variables","Independent variables",  choices = c("independent Variables"), selected=NULL, multiple=TRUE),
    #uiOutput("independent_variables"),
    HTML("<center><hr>"),
    
    ###########################################################
    # STEP 2.3: buttons to download the new report and new slides 
    
    #HTML("<h4>Download the new HTML report </h4>"),
    #downloadButton('report', label = "Download"),
    #HTML("<hr>"),
    #HTML("<h4>Download the new HTML5 slides </h4>"),
    #downloadButton('slide', label = "Download"),
    
    HTML("<hr>")    
  ),
  
  ###########################################################
  # STEP 3: The output tabs (these follow more or less the 
  # order of the Rchunks in the report and slides)
  
  mainPanel(
    # Just set it up
    tags$style(type="text/css",
               ".shiny-output-error { visibility: hidden; }",
               ".shiny-output-error:before { visibility: hidden; }"
    ),
    
    # Now these are the taps one by one. 
    # NOTE: each tab has a name that appears in the web app, as well as a
    # "variable" which has exactly the same name as the variables in the 
    # output$ part of code in the server.R file 
    # (e.g. tableOutput('parameters') corresponds to output$parameters in server.r)
    
    tabsetPanel(
      
      tabPanel("Parameters", 
               div(class="row-fluid",
                   actionButton("action_parameters", "Show/Update Results"),
                   HTML("<br>"),
                   div(class="span12",h4("Summary of Key Parameters")),
                   tags$hr(),
                   tableOutput('parameters')
               )
      ),
      
      tabPanel("Summary", 
               actionButton("action_summary", "Show/Update Results"),
               HTML("<br>"),
               tableOutput('summary')),
      
      tabPanel("Histograms",
               div(class="row-fluid", 
                   HTML("<h5>Select the name of the variable to see (<strong>must be a variable in your dataset</strong>)</h5>"),                   
                   selectInput("hist_var","Select Variable",  choices=c("attributes used"),selected=NULL, multiple=FALSE),
                   tags$hr(),
                   actionButton("action_Histograms", "Show/Update Results"),
                   HTML("<br>"),
                   div(class="span6",plotOutput('histogram'))
               )
      ),
      
      tabPanel("Correlations",
               actionButton("action_correlations", "Show/Update Results"),
               HTML("<br>"),
               tableOutput('correlation')),
      
      tabPanel("Scatter Plots", 
               div(class="row-fluid",
                   HTML("<h5>Select the names of the variables to plot (<strong>must be variables in your dataset</strong>)</h5>"),                   
                   selectInput("scatter1","x-axis",  choices=c("attributes used"),selected=NULL, multiple=FALSE),
                   tags$hr(),
                   selectInput("scatter2","y-axis",  choices=c("attributes used"),selected=NULL, multiple=FALSE),
                   tags$hr(),
                   actionButton("action_scatterplots", "Show/Update Results"),
                   HTML("<br>"),
                   div(class="span12",h4("The Scatter Plot")),
                   div(class="span6",plotOutput('scatter'))
               )
      ),               
      
      tabPanel("Regression Output", 
               actionButton("action_regression", "Show/Update Results"),
               HTML("<br>"),
               HTML("<br>"),
               HTML("<br>"),
               tableOutput("regression_output"),
               tags$hr(),
               tableOutput('Resparameters')
               ),
      
      tabPanel("Residuals Plot", 
               actionButton("action_residuals", "Show/Update Results"),
               HTML("<br>"),
               plotOutput("residuals_plot")),
      
      tabPanel("Residuals Histogram", 
               actionButton("action_residualshist", "Show/Update Results"),
               HTML("<br>"),
               plotOutput("residuals_hist")),
      
      tabPanel("Residuals Scatter Plots", 
               div(class="row-fluid",
                   HTML("<h5>Select the name of the variable to plot the residuals against (<strong>must be a variable in your dataset</strong>)</h5>"),                   
                   selectInput("residual_scatter1","Select Variable",  choices=c("attributes used"),selected=NULL, multiple=FALSE),
                   tags$hr(),
                   actionButton("action_residuals_scatter", "Show/Update Results"),
                   HTML("<br>"),
                   div(class="span12",h4("The Scatter Plot")),
                   div(class="span6",plotOutput('residuals_scatter'))
               )
      )
      
    )
  )
))