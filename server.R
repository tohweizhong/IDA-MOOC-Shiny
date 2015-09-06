# server.R

shinyServer(function(input, output, session){
  
    output$titlePNG<-renderImage({
        list(src="images/title.png", alt=NULL)
    },deleteFile=FALSE)
    
    output$logoPNG<-renderImage({
        list(src="images/logo.png", alt=NULL)
    },deleteFile=FALSE)
    
    output$algoPNG<-renderImage({
        list(src="images/redhyte algo.png",alt=NULL)
    },deleteFile=FALSE)
    
    
    
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
    
    
    #displaying a preview of the data, 10 rows, all columns
    output$data.preview<-renderTable({
        if(is.null(Data()[1])) return(NULL)
        data.frame(Data()[[1]][1:input$previewRows,])
    },digits=3)
})