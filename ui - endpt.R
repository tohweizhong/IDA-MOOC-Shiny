# ui.R

shinyUI(fluidPage(
    #theme = shinytheme("cerulean"),
    #theme = shinytheme("cosmo"),
    #theme = shinytheme("united"),
    theme = "lumen.css",
    
    titlePanel(imageOutput("logoPNG",width="180px",height="60px")),
    
    #main panel
    mainPanel(
        tabsetPanel(	
                    
                    #=============================================#
                    #=============0. Settings=====================#
                    #=============================================#
                    
                    tabPanel("0. Settings",
                             sidebarLayout(
                                 sidebarPanel(
                                     tags$hr(),
                                     #data input
                                     fileInput('datFile',
                                               tags$h5(tags$strong('Choose file to analyse')),
                                               accept=c('text/csv', 'text/comma-separated-values,text/plain')),
                                     tags$h5("Example dataset to try Redhyte out with:"),
                                     tags$a(href="https://dl.dropboxusercontent.com/u/36842028/linkouts/datasets/adult.csv",
                                            "US Census dataset",target="_blank"),
                                     tags$h5('(Refer to "About Redhyte")'),
                                     tags$hr(),
                                     #checkbox to indicate header == true or false
                                     checkboxInput('datHeader','Header contains attribute names', TRUE),
                                     tags$hr(),
                                     #file type
                                     radioButtons('datSep',
                                                  tags$h5(tags$strong("Separator")),
                                                  c("Comma(.csv)"=',',
                                                    "Tab(.txt/.tsv)"='\t'),
                                                  ','),
                                     tags$hr(),
                                     #quotation used in data file
                                     radioButtons('datQuote',
                                                  tags$h5(tags$strong('Quotes used in data file')),
                                                  c(None='',
                                                    'Double Quotes'='"',
                                                    'Single Quotes'="'"),
                                                  '"'),
                                     tags$hr(),
                                     #transpose data
                                     checkboxInput('datTranspose','Transpose data?',FALSE),
                                     width=3),
                                 mainPanel(
                                     tags$h4("Settings used in Redhyte"),
                                     tags$h5("Default settings are suitable for most purposes"),
                                     tags$hr(),
                                     sliderInput("maxClass",label ="Maximum number of classes for all categorical attribute",
                                                 min=5,max=20,value=5,step=1),
                                     sliderInput("p.significant",label ="p-value for test diagnostics",
                                                 min=0,max=0.15,value=0.05,step=0.05),
                                     sliderInput("acc.rf.default",label="Classification accuracy for context mining",
                                                 min=0,max=1,value=0.7,step=0.05),
                                     sliderInput("top.k",label="Number of context attributes to mine",
                                                 min=1,max=10,value=5,step=1),
                                     sliderInput("class.ratio",label="Class ratio threshold for class-imbalance learning",
                                                 min=2,max=5,value=3,step=1),
                                     sliderInput("min.sup.cij",label="Minimum cell support for mined hypotheses",
                                                 min=5,max=20,value=10,step=1)))),
                    
                    #=============================================#
                    #==============1. Data preview================#
                    #=============================================#
                    
                    tabPanel("1. Data preview",
                             tags$h4("Displaying a preview of your data"),
                             sliderInput("previewRows","Number of rows to display",
                                         min=1,max=20,value=10,step=1,animate=FALSE),
                             tableOutput("data.preview"))
        )
    ,width = 12)
))