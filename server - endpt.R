options(shiny.maxRequestSize=20*1024^2)
shinyServer(function(input,output,session){
    
    #fancy work here
    #render images
    output$titlePNG<-renderImage({
        list(src="images/title.png", alt=NULL)
    },deleteFile=FALSE)
    
    output$logoPNG<-renderImage({
        list(src="images/logo.png", alt=NULL)
    },deleteFile=FALSE)
    
    output$algoPNG<-renderImage({
        list(src="images/redhyte algo.png",alt=NULL)
    },deleteFile=FALSE)
    
    
    #=============================================#
    #=============================================#
    #=============================================#
    
    #grabbing the data
    
    #*********************************************#
    #***************REACTIVE**********************#
    #*********************************************#
    
    #Data() consists of *THREE* things at the moment
    # 1. Data()[[1]] is the data itself
    # 2. Data()[[2]] is the type of variable: numerical or categorical
    # 3. Data()[[3]] is the number of classes for categorical attributes, NA for num.
    
    
    Data<-reactive({
        datFile<-input$datFile
        path<-as.character(datFile$datapath)
        df<-read.csv(path,
                     header=input$datHeader,
                     sep=input$datSep,
                     quote=input$datQuote,
                     stringsAsFactors=F)

        if(input$datTranspose == TRUE) df<-t(df)
        
        typ<-NULL
        numCl<-NULL
        for(i in seq(ncol(df))){
            if(is.numeric(df[,i]) && length(unique(df[,i]))>input$maxClass){
                typ<-c(typ,"Num")
                numCl<-c(numCl,NA)
            }
            else{
                typ<-c(typ,"Cate")
                numCl<-c(numCl,length(unique(df[,i])))
            }
        }
        names(typ)<-names(numCl)<-colnames(df)
        return(list(df,typ,numCl))
    })
    
    #*********************************************#
    #***************END REACTIVE******************#
    #*********************************************#
    
    #=============================================#
    #==============1. Data preview================#
    #=============================================#
    
    #displaying a preview of the data, 10 rows, all columns
    output$data.preview<-renderTable({
        if(is.null(Data()[1])) return(NULL)
        data.frame(Data()[[1]][1:input$previewRows,])
    },digits=3)
    
})