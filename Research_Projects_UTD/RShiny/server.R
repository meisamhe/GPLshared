library(shiny)
#library(shinyBS)
library(ggplot2)
library(data.table)
require(rCharts)
#===========================================================
#Global configuration
defaultThompsonSamplingPosteriorSize = 100
ThompsonSamplingPaxPerDay  = 500
ThompsonSamplingNumberOfDays = 7
#================================================================
#Meisam: to have a good margin it is best to use this option as well
# options(RCHART_WIDTH = 800)
# options(RCHART_HEIGHT = 600)
# HotelData = copy(HotelDatatmp)
#================================================
#visualization
#==========================================
#important note [Meisam]: This is the function that helps to apply the result of D3 on Shiny app
#link: https://github.com/ramnathv/rCharts/issues/522
renderChart3 <- function( expr, env = parent.frame(), quoted = FALSE ){
  func <- shiny::exprToFunction(expr, env, quoted)
  function() {
    rChart_ <- func()
    cht_style <- sprintf("<style>.rChart {width: %spx; height: %spx} </style>", 
                         rChart_$params$width, rChart_$params$height)
    cht <- paste(
      capture.output(cat(
        rChart_$print()
        ,render_template(
          rChart_$templates$afterScript %||% 
            "<script></script>"
          , list(chartId = rChart_$params$dom, container = rChart_$container)
        )
        ,sep = ""
      ))
      , collapse = "\n")
    HTML(paste(c(cht_style, cht), collapse = "\n"))
  }
}

#Visualization functions
#============================================

#======================================================
#function to generate bar chart by normalizing the frequencies (percentages)
#======================================================
GenerateOVerallSummaryPlotsPercentage<-function(dtData,feature1,ID,FileName=NULL){
  dtDataSubset<-subset(dtData,select=c(feature1,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  dtDataSubset<-dtDataSubset[,.N,by=c("dummy1",feature1)]
  dtDataSubset[,PCT:=N*100/sum(N)]
  
  
  if (!is.null(FileName)){
    plot<-
      #       ggplot(data=dtDataSubset,aes(x=dummy1,y=PCT,fill=dummy1))+ geom_bar(stat="identity")+
      #       ggtitle(feature1) +xlab("") + ylab("PCT")+ theme_bw()+guides(fill=FALSE)+
      #       scale_y_continuous(breaks=seq(0,max(dtDataSubset$PCT),10),limits=c(0,max(dtDataSubset$PCT)))+
      #       theme(text = element_text(size=20),
      #             axis.text.x = element_text(angle=90, vjust=1)) 
      #     ggsave(plot,filename=paste0(FileName, '.png'))  
      #dataSubset=subset(dtDataSubset,select=c(feature1,'freq'))
      #dataSubset$color=c('lightblue', 'lightgreen','lightpink')                 
      plot <-  nPlot(x = feature1, y = "PCT", data = subset(dtDataSubset,select=c(feature1,'PCT'))[order(-PCT)],
                     type = "discreteBarChart")
    plot$xAxis(
      tickFormat =   "#!
      function(d) {return d;}
      !#",
      rotateLabels = -30
    ) 
    # hPlot(x = feature1, y = "freq", data =dataSubset, type = "bar")
    #plot$plotOptions(column = list(cursor = 'pointer', point = list(events = list(click = "#! function() { location.href = this.options.url; } !#"))))
    #plot$plotOptions(series = list(color = 'lightgreen'))
    #show(plot)
    #       nPlot(x = feature1, y = "freq", data = subset(dtDataSubset,select=c(feature1,'freq'))[order(-freq)],
    #                      type = "discreteBarChart")
    #       plot$chart(margin = list(bottom = 100))
    #       plot$yAxis( axisLabel = "Randomness", width = 40 )
    #       plot$xAxis(staggerLabels = TRUE)
    # 
    # rPlot(x = list(var = feature1, sort = "freq"), y = "freq",     data = dtDataSubset, type = 'bar')
    
    
    #       rPlot(x = list(var = feature1, sort = "freq"), y = "freq", 
    #                     data = subset(dtDataSubset,select=c(feature1,'freq')), type = 'bar',color='black')
    
    return (plot)
  }else{
    #     plot=ggplot(data=dtDataSubset,aes(x=dummy1,y=PCT,fill=dummy1))+ geom_bar(stat="identity")+
    #       ggtitle(feature1) +xlab("") + ylab("PCT")+ theme_bw()+guides(fill=FALSE)+
    #       scale_y_continuous(breaks=seq(0,max(dtDataSubset$PCT),10),limits=c(0,max(dtDataSubset$PCT)))+
    #       theme(text = element_text(size=20),
    #             axis.text.x = element_text(angle=90, vjust=1)) 
    plot  <-  nPlot(x = feature1, y = "PCT", data = subset(dtDataSubset,select=c(feature1,'PCT'))[order(-PCT)],
                    type = "discreteBarChart")
    plot$chart(margin = list(bottom = 200))
    #http://stackoverflow.com/questions/24344794/rcharts-nplot-formating-x-axis-with-dates
    plot$xAxis(
      tickFormat =   "#!
      function(d) {return d;}
      !#",
      rotateLabels = -30
    )
    plot$yAxis(tickFormat = "#! function(d) {return '%' + d.toFixed(2)} !#")
    #http://stackoverflow.com/questions/13136964/how-can-i-position-rotated-x-axis-labels-on-column-chart-using-nvd3
    #     plot$templates$script  = 
    #                      "<script type='text/javascript'>
    #                   chart.margin({bottom: 60});
    #     d3.select('.nv-x.nv-axis > g').selectAll('g').selectAll('text').attr('transform', function(d,i,j) { return 'translate (-10, 25) rotate(-90 0,0)' }) ;
    #                    </script>"
    #http://zevross.com/blog/2014/04/03/interactive-visualization-from-r-to-d3-using-rcharts/
    #     plot$templates$script = system.file("C:\\\temp\\script_multiselect.html",
    #                                         package = "rCharts")
    
    return (plot)
  }
}
#======================================================
# function to generate bar chart based on the frequencies
#======================================================
GenerateOVerallSummaryPlotsFreq<-function(dtData,feature1,ID,FileName=NULL){
  dtDataSubset<-subset(dtData,select=c(feature1,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  dtDataSubset<-dtDataSubset[,.N,by=c("dummy1")]
  #dtDataSubset[,PCT:=N]
  dtDataSubset[,PCT:=N*100/sum(N)]
  
  if (!is.null(FileName)){
    plot<-
      #       ggplot(data=dtDataSubset,aes(x=dummy1,y=PCT,fill=dummy1))+ geom_bar(stat="identity")+
      #       ggtitle(feature1) +xlab("") + ylab("PCT")+ theme_bw()+guides(fill=FALSE)+
      #       scale_y_continuous(breaks=seq(0,max(dtDataSubset$PCT),round(max(dtDataSubset$PCT)/10),0),limits=c(0,max(dtDataSubset$PCT)))+
      #       theme(text = element_text(size=20),
      #             axis.text.x = element_text(angle=90, vjust=1)) +
      #       ggsave(filename=paste0(FileName, '.png'))
      plot  <-  nPlot(x = feature1, y = "PCT", data = subset(dtDataSubset,select=c(feature1,'PCT'))[order(PCT)],
                      type = "discreteBarChart")
    plot$xAxis(
      tickFormat =   "#!
      function(d) {return d;}
      !#",
      rotateLabels = -30
    )
    return (plot)
  }else{
    #     plot = ggplot(data=dtDataSubset,aes(x=dummy1,y=PCT,fill=dummy1))+ geom_bar(stat="identity")+
    #       ggtitle(feature1) +xlab("") + ylab("PCT")+ theme_bw()+guides(fill=FALSE)+
    #       scale_y_continuous(breaks=seq(0,max(dtDataSubset$PCT),round(max(dtDataSubset$PCT)/10,0)),limits=c(0,max(dtDataSubset$PCT)))+
    #       theme(text = element_text(size=20),
    #             axis.text.x = element_text(angle=90, vjust=1)) 
    plot  <-  nPlot(x = feature1, y = "PCT", data = subset(dtDataSubset,select=c(feature1,'PCT'))[order(-PCT)],
                    type = "discreteBarChart")
    plot$xAxis(
      tickFormat =   "#!
      function(d) {return '%' + d;}
      !#",
      rotateLabels = -30
    )
    plot$yAxis(tickFormat = "#! function(d) {return '%' + d.toFixed(2)} !#")
    return (plot)
  }
}

#======================================================
# stacked bar chart
#======================================================
GenerateStackkedBarChart<-function(dtData,feature1,segment,ID,FileName=NULL){
  require(gridExtra)
  require(rjson)
  require(stringr)
  require(plyr)
  require(rCharts)
  require(reshape2)
  #toPlotData = copy(HotelData);  setnames(toPlotData,"Property_Nm","Property.Name");  setnames(toPlotData,"Profile_Type_Nm","Profile.Class")
  #dtData=toPlotData;feature1="Property.Name";segment="Profile.Class";ID="Confirm_Nbr"
  #rm(toPlotData);   gc()
  
  dtDataSubset<-subset(dtData,select=c(feature1,segment,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  dtDataSubset[,Segments:=get(segment)]
  
  #if it is 0 and 1 levels then replace them with feature name and not feature name
  if (length(unique(dtDataSubset$dummy1))==2){
    checkBinary= all(unique(dtDataSubset$dummy1)%in% c(0,1)) | all(unique(dtDataSubset$dummy1)%in% c(T,F))
    if (checkBinary){
      dtDataSubset[get(feature1)==0,dummy2:=paste0("Not ",feature1)]
      dtDataSubset[get(feature1)==1,dummy2:=feature1]
      dtDataSubset[,dummy1:=NULL]
      setnames(dtDataSubset,"dummy2","dummy1")
    }
  }
  
  
  if (!is.null(FileName)){
    plot = ggplot(dtDataSubset, aes(dummy1, fill=Segments)) + geom_bar()+ ylab("Freq.")+xlab("")+
      ggtitle(feature1) +theme(text = element_text(size=20),axis.text.x = element_text(angle=90, vjust=1)) 
    ggsave(filename=paste0(FileName, '.png'))  
    return (plot)
  }else{
    #option 1: old ggplot 
    #     plot = ggplot(dtDataSubset, aes(dummy1, fill=Segments)) + geom_bar()+ ylab("Freq.")+xlab("")+
    #       ggtitle(feature1) +theme(text = element_text(size=20),axis.text.x = element_text(angle=90, vjust=1)) 
    #     
    #rchart
    
    dtRChartSubset = subset(dtDataSubset,select=c(ID,"dummy1","Segments"))
    df.melt <-melt(table(dtRChartSubset$dummy1,dtRChartSubset$Segments))
    names(df.melt)=c(feature1,segment,"PCT")
    setDT(df.melt)
    df.melt[,PCT:=PCT*100/sum(PCT)]
    
    #option 2: using dplot in rchart
    #     d1 <- dPlot(
    #       x = "Freq", 
    #       y = feature1, 
    #       groups = segment, 
    #       data = df.melt, 
    #       type = 'bar')
    #     
    #     #Here, set the chart options to tell rCharts how to format the visualization  
    #     d1$xAxis(type = "addPctAxis")
    #     d1$yAxis(type = "addCategoryAxis", orderRule = segment)
    #     
    #     d1$legend( x = 80, y = 10, width = 1000, height = 30, horizontalAlign = "left", orderRule = segment)
    
    
    
    #d1$set(width = 1200)
    # set the size
    #d1$params$width <- 1000
    #d1$params$height <- 700
    
    #     d1$setTemplate(
    #       afterScript = "
    #         <script>
    #         d3.selectAll('#{{ chartId }} svg text')
    #           .style('font-size', '18')
    #         d3.selectAll(' svg text').style('font-size', '15')
    #         </script>
    #       ")
    #grid.arrange(plot, d1, ncol=2)
    df.meltTemp <-df.melt
    names(df.meltTemp)=c(make.names(feature1),segment,"PCT")
    
    
    # option 3: dPlot in rChart
    #check horizontal one:
    #     p2 <- dPlot(as.formula(paste("Freq ~ ",make.names(feature1))), groups = segment,
    #                 data = df.meltTemp,
    #                 type = 'bar'
    #     )
    #     p2$chart(margin = list(left = 500,right=500,bottom=500,top=500)) # margin makes room for label
    #     p2$yAxis( axisLabel = "Randomness" )
    #     p2$legend( x = 600, y = 30, width = 100, height = 30, horizontalAlign = "right", orderRule = segment)
    
    #p2$xAxis(axisLabel = 'Year')
    #p2$yAxis(categories = c(unique(as.character(dtDataSubset[,dummy1]))),
    #        title=list(text = ""))
    
    #p2$defaultColors(c('brown', 'blue', '#594c26', 'green'))
    # solution from dimple original java script library:
    #https://github.com/PMSI-AlignAlytics/dimple/wiki/dimple.chart
    #https://github.com/ramnathv/rCharts/issues/77
    # by taking the str of the object it is possible to find out what is the chart in d3
    #     p2$setTemplate(
    #       afterScript = "
    #       <script>
    #         //d3.selectAll('#{{ chartId }} svg text')
    #         //myChart.style('font-size', '14')
    #         myChart.setMargins(50, 50, 50, 200);  //dimple code to set margin by meisam
    #         //myChart.setBounds(20, 20, 1000, 1000); // dimple code to set chart size by meisam
    #       </script>
    #       ")
    
    #======================================================
    # rotation is required only if the length is too much
    #======================================================
    #     
    #     if (feature1=='Rate Category'){
    #       p2$setTemplate(afterScript = 
    #                        "<script>
    #         myChart.setMargins(50, 100, 50, 200)  //dimple code to set margin by meisam
    #         d3.selectAll('#{{ chartId }} svg text').style('font-size', '14')
    #         myChart.axes[0].shapes.selectAll('text').attr('transform', 'rotate(10)').style('text-anchor','middle').style('font-size','150%')
    #         myChart.svg.append('text').attr('x', 40).attr('y', 20).style('text-anchor','beginning').style('font-size', '100%')
    #         myChart.addMeasureAxis('y', 'attendance');// axes[0] if for x asix and axes[1] is for y axis     
    #       </script>"
    #       )
    #     }else{
    #       p2$setTemplate(afterScript = 
    #                        "<script>
    #         myChart.setMargins(50, 100, 50, 200)  //dimple code to set margin by meisam
    #         d3.selectAll('#{{ chartId }} svg text').style('font-size', '14');
    #          </script>"
    #       )
    #     }
    
    #
    p3 =nPlot(as.formula(paste("PCT ~ ",make.names(feature1))), group = segment, data =  df.meltTemp, type = 'multiBarChart')
    p3$chart(margin = list(left = 80))
    p3$yAxis(axisLabel = "PCT", width = 70)
    p3$chart(margin = list(right = 80))
    p3$chart(margin = list(bottom = 150))
    p3$chart(margin = list(top = 80))
    p3$xAxis(
      tickFormat =   "#!
      function(d) {return d;}
      !#",
      rotateLabels = -30
    )
    p3$yAxis(tickFormat = "#! function(d) {return '%' + d.toFixed(2)} !#")
    return (p3)
  }
}

#create the Histogram for the numerical features
#========================================================================

#function to draw a histogram of feature1 distribution, it recieves the min and max and step to visualize
histogramDraw<-function(dtData,feature1,ID, MinValueDraw, MaxValueDraw, stepSizeDraw, FileName=NULL){
  dtDataSubset<-subset(dtData,select=c(feature1,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  
  if (!is.null(FileName)){
    plot = ggplot(data=dtDataSubset, aes(as.numeric(dtDataSubset$dummy1))) + 
      geom_histogram( 
        breaks=seq(MinValueDraw, MaxValueDraw, by = stepSizeDraw), 
        col="blue", 
        aes(fill=..count..), 
        alpha = .2) + 
      labs(title=paste0("Histogram for ",feature1)) +
      labs(x=paste0(feature1), y="Freq.")
    
    ggsave(filename=paste0(FileName, '.png'))  
    return (plot)
  }else{
    plot = ggplot(data=dtDataSubset, aes(as.numeric(dtDataSubset$dummy1))) + 
      geom_histogram( 
        breaks=seq(MinValueDraw, MaxValueDraw, by = stepSizeDraw), 
        col="blue", 
        aes(fill=..count..), 
        alpha = .2) + 
      labs(title=paste0("Histogram for ",feature1)) +
      labs(x=paste0(feature1), y="Freq.")
    return (plot)
  }
}

#===============================================================================
#function to draw a histogram of feature1 distribution only for segment SegInstance, it recieves the min and max and step to visualize

histogramSegmentDraw<-function(dtData,feature1,segmentVarName, SegInstance, MinValueDraw, MaxValueDraw, stepSizeDraw, ID,FileName=NULL){
  dtDataSubset<-subset(dtData,select=c(feature1,segmentVarName,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  dtDataSubset[,Segments:=get(segmentVarName)]
  dtDataSubset = dtDataSubset[Segments==SegInstance,]
  
  if (!is.null(FileName)){
    plot=ggplot(data=dtDataSubset, aes(as.numeric(dtDataSubset$dummy1))) + 
      geom_histogram( 
        breaks=seq(MinValueDraw, MaxValueDraw, by = stepSizeDraw), 
        col="blue", 
        aes(fill=..count..), 
        alpha = .2) + 
      labs(title=paste0("Histogram of ",feature1, "for ", SegInstance, "Segment")) +
      labs(x=paste0(feature1), y="Freq.")
    
    ggsave(filename=paste0(FileName, '.png'))  
    return (plot)
  }else{
    plot = ggplot(data=dtDataSubset, aes(as.numeric(dtDataSubset$dummy1))) + 
      geom_histogram( 
        breaks=seq(MinValueDraw, MaxValueDraw, by = stepSizeDraw), 
        col="blue", 
        aes(fill=..count..), 
        alpha = .2) + 
      labs(title=paste0("Histogram of ",feature1, "for ", SegInstance, "Segment")) +
      labs(x=paste0(feature1), y="Freq.")
    return (plot)
  }
}

#=========================================
# Thompson Sampling Functions: Begin
#=========================================
# reused function from binomial-bandit
SimulateBinomialPosterior <- function(y, n, ndraws){
  # Args:
  #   y:  Vector of success counts, per arm.
  #   n:  Vector of trial counts, per arm
  # ndraws:  The desired number of posterior draws 
  number.of.arms <- length(y)
  ans <- matrix(nrow = ndraws,
                ncol = number.of.arms)
  for(arm in 1:number.of.arms) {
    ans[, arm]<-rbeta(ndraws,
                      y[arm] + 1,
                      n[arm] - y[arm] + 1)
  }
  return(ans)
}

# Meisam: new function created by Meisam to be consistent with revenue management structure
TSOptimProblem <- function(xVec,priceVec,value.posterior){
  # Args:
  #   xVec: A vector of optimal weights to find
  #   priceVec: A vector of prices (bandits) 
  #   value.posterior:  A matrix representing the value
  #     of each arm.  Rows are Monte Carlo draws from the
  #     posterior distribution of value.  Columns
  #     represent different arms.
  # Returns:
  #   The vector of optimal arm probabilites.
  number.of.arms <- ncol(value.posterior)
  #   optimal.arm.probabilities <- table(
  #     factor(max.col(value.posterior),
  #            levels = 1:number.of.arms))
  #  return(optimal.arm.probabilities / nrow(value.posterior))
  
  # Meisam: output is the function of optimal proportions
  ftt = 0
  for (mcItem in 1:nrow(value.posterior)){
    ftt = ftt+ sum(xVec*priceVec*value.posterior[mcItem,])
  }
  ftt = ftt/nrow(value.posterior)
  if (is.infinite(ftt)){
    return (500)
  }
  return (-ftt)
  
}

# Meisam: gradient function created by Meisam to be consistent with revenue management structure
gradTSOptimProblem <- function(xVec,priceVec,value.posterior){
  # Args:
  #   xVec: A vector of optimal weights to find
  #   priceVec: A vector of prices (bandits) 
  #   value.posterior:  A matrix representing the value
  #     of each arm.  Rows are Monte Carlo draws from the
  #     posterior distribution of value.  Columns
  #     represent different arms.
  # Returns:
  #   The vector of optimal arm probabilites.
  number.of.arms <- ncol(value.posterior)
  
  # Meisam: output is the function of optimal proportions
  ftt = 0
  for (mcItem in 1:nrow(value.posterior)){
    ftt = ftt+ priceVec*value.posterior[mcItem,]
  }
  ftt = ftt/nrow(value.posterior)
  return (t(-ftt))
}

# Meisam: new function updated for revenue management purpose
ComputeWinProbability <- function(priceVec1,value.posterior1,number.of.arms1){
  # Args:
  #   xVec: A vector of optimal weights to find
  #   priceVec: A vector of prices (bandits) 
  #   value.posterior:  A matrix representing the value
  #     of each arm.  Rows are Monte Carlo draws from the
  #     posterior distribution of value.  Columns
  #     represent different arms.
  # Returns:
  #   The vector of optimal arm probabilites.
  
  #   value.posterior:  A matrix representing the value
  #     of each arm.  Rows are Monte Carlo draws from the
  #     posterior distribution of value.  Columns
  #     represent different arms.
  #  x <= 0.9,  y - x > 0.1
  #constrOptim(c(.5,0), fr, grr, ui = rbind(c(-1,0), c(1,-1)), ci = c(-0.9,0.1))
  # normalize in case it is not
  #value.posterior = value.posterior/sum(value.posterior)
  priceVec = priceVec1
  value.posterior = value.posterior1
  number.of.arms= number.of.arms1
  value.posterior =     t(constrOptim(theta=t(t(rep(0.01,number.of.arms))), TSOptimProblem, NULL,# no gradient is passed for now
                                      #gradTSOptimProblem,
                                      ui = rbind(diag(1,number.of.arms),c(rep(-1,number.of.arms))),
                                      ci = c(rep(0,number.of.arms),-1),
                                      priceVec=priceVec,value.posterior=value.posterior)$par)
  
  
  #     optim(par=value.posterior, fn=TSOptimProblem, lower=c(rep(0,number.of.arms)), 
  #                           upper=c(rep(1,number.of.arms)),
  #                           method="L-BFGS-B",
  #                           priceVec=priceVec,value.posterior=value.posterior)$par 
  
  #TSOptimProblem(value.posterior,priceVec,value.posterior)
  #gradTSOptimProblem(value.posterior,priceVec,value.posterior)
  #optim(value.posterior,TSOptimProblem, priceVec=priceVec,value.posterior=value.posterior)
  
  #number.of.arms <- ncol(value.posterior)
  #   optimal.arm.probabilities <- table(
  #     factor(max.col(value.posterior),
  #            levels = 1:number.of.arms))
  return(value.posterior / sum(value.posterior))
}

BinomialBandit <- function(y1, n1, ndraws1,number.of.arms1,priceVec1){
  # Args:
  #   y:  Vector of success counts, per arm.
  #   n:  Vector of trial counts, per arm.
  # ndraws:  The desired number of posterior draws
  success.probabilities <- SimulateBinomialPosterior(
    y1, n1, ndraws1)
  winprob <- ComputeWinProbability(priceVec1,success.probabilities,number.of.arms1)
  ans <- list(
    success.probabilities = success.probabilities,
    optimal.arm.probabilities = winprob)
  class(ans) <- "BinomialBandit"
  return(ans)
}
# plot performance of Thompson sampling
#==============================================
PlotBinomialBanditSimulation <- function(sim) {
  ## Args:
  ##   sim:  The output of SimulateBinomialBandit.
  opar <- par(mfrow = c(2,2))
  on.exit(par(opar))
  number.of.arms <- ncol(sim$optimal.arm.probabilities)
  colors <- rainbow(number.of.arms)
  
  boxplot(sim$bandit$success.probabilities,
          col = colors,
          main = "Success Probabilities")
  
  positions <- 1:number.of.arms
  segments(positions - .25, sim$true.demand.prob,
           positions + .25, sim$true.demand.prob,
           col = "black",
           lwd = 2)
  points(positions - .25, sim$true.demand.prob, pch = "|")
  points(positions + .25, sim$true.demand.prob, pch = "|")
  
  plot.ts(sim$optimal.arm.probabilities,
          plot.type = "single",
          col = colors,
          ylim = c(0, 1),
          ylab = "",
          main = "Optimal Arm Probabilities")
  
  plot.ts(sim$regret,
          main = "Regret",
          ylab = "Conversions")
  
  plot.ts(cumsum(sim$regret),
          main = "Cumulative Regret",
          ylab = "Conversions")
}

plot.BinomialBanditSimulation <- function(x, y, ...) {
  PlotBinomialBanditSimulation(x)
}
#-------------------------------
# Main Function for Thompson Sampling
#--------------------------------
#MainThompsonSampling (priceLevels,ProbPurchase,observations.per.update,numUpdates)
MainThompsonSampling <- function (priceLevels,ProbPurchase,observations.per.update,numUpdates){
  priceVec=priceLevels
  true.demand.prob=t(ProbPurchase)
  observations.per.update1 = observations.per.update
  number.of.updates = numUpdates
  posterior.samples = defaultThompsonSamplingPosteriorSize 
  ## Simulate the running of a binomial bandit experiment.
  ## Args:
  ##   priceVec: A vector of prices (bandits) 
  ##   true.demand.prob: the probability of purchase under each price
  ##   observations.per.update: The number of observations to be
  ##     allocated each update period.
  ##   number.of.updates:  The number of update periods to simulate.
  ##   posterior.samples: The number of posterior samples to use for
  ##     the bandit in each update period.
  observations.per.update = observations.per.update1
  regret <- numeric(number.of.updates)
  number.of.arms <- length(true.demand.prob)
  optimal.arm.probabilities <- matrix(nrow = number.of.updates,
                                      ncol = number.of.arms)
  trials <- rep(0, number.of.arms)
  successes <- rep(0, number.of.arms)
  bandit <- list(optimal.arm.probabilities =
                   rep(1.0 / number.of.arms, number.of.arms))
  
  ##   true.success.rates: A vector of true success probabilities for
  ##     each arm.(it should be result of running TSOptimProblem)
  true.success.rates = ComputeWinProbability(priceVec1=priceVec,
                                             value.posterior1=matrix(rep(true.demand.prob,each=posterior.samples),nrow=posterior.samples),
                                             number.of.arms1=number.of.arms)
  regret.per.arm <- max(true.success.rates) - true.success.rates
  
  #Meisam: New for the progress bare in Shiny
  withProgress(message = 'Preparing plot', value = 0, {
    for (i in 1:number.of.updates) {
      print (i)
      incProgress(1/number.of.updates, detail = paste(i,"'th step out of ",number.of.updates, 'in progress' ))
      incremental.trials <- as.numeric(
        rmultinom(n = 1,
                  size=observations.per.update,
                  prob=bandit$optimal.arm.probabilities))
      incremental.successes <- rbinom(
        number.of.arms,
        incremental.trials,
        true.demand.prob)
      # true.success.rates)
      regret[i] <- sum(incremental.trials * regret.per.arm)
      # meisam: interesting note that these are cumulative
      trials <- trials + incremental.trials
      successes <- successes + incremental.successes
      bandit <- BinomialBandit(y1=successes, n1=trials, ndraws1 = posterior.samples,number.of.arms1=number.of.arms,priceVec1=priceVec)
      optimal.arm.probabilities[i, ] <- bandit$optimal.arm.probabilities
    }
  })
  ans <- list(
    true.success.rates = true.success.rates,
    bandit = bandit,
    regret = regret,
    trials = trials,
    successes = successes,
    optimal.arm.probabilities = optimal.arm.probabilities,
    true.demand.prob=true.demand.prob
  )
  class(ans) <- "BinomialBanditSimulation"
  #   return(ans)
  # }
  
  #simResults = SimulateBinomialBandit()
  simResults = ans
  return(simResults)
}



#===========================================
# End of Thompson Sampling Functions
#===========================================

#=============================================================================
# Shiny portion of the application
#=============================================================================

shinyServer(function(input, output,session) {
  #============================================
  #A/B Testing
  #============================================
  
  
  #output$value <- renderPrint({ input$radio })
  commonConfig <- function(){
    paste(" o Selected Methodology is:", ifelse (input$Methodology=="ABTesting","A/B Testing",
                                                 ifelse(input$Methodology=="ThompsonSampling","Thompson Sampling","Not Selected")),"\n",
          "o Selected Network is:", ifelse (input$Network=="Domestic","Domestic",
                                            ifelse(input$Network=="ShortHaul","Short-Haul International",
                                                   ifelse(input$Network=="LongHaul","Long-Haul International","Not Selected"))), "\n",
          "o Selected Ancillary is:", input$ancillary, "\n",
          "o Selected Customer Segment is:", ifelse (input$CustSeg=="Business","Business",
                                                     ifelse(input$CustSeg=="Leisure","Leisure",
                                                            ifelse(input$CustSeg=="VFF","Visiting Friends and Family"))), "\n",
          "o Selected Seasonality Mode:", ifelse (input$Seasonality=="NotSeasonal","Simple (without seasonality)",
                                                  ifelse(input$Seasonality=="Seasonal","Seasonal (not active)")), "\n",
          "o Selected Advance Purchase Mode:", ifelse (input$AdvancePurchase=="NoAP","Simple (not consider advance purchase)",
                                                       ifelse(input$AdvancePurchase=="AP","Consider Advance Purchase (not active)")), "\n",
          "**Please go back to the common configuration tab to change the configuration, and submit your change. \n"
    )
  }
  
  output$text <- renderText({
    commonConfig()
  })
  output$TSCommConfig <- renderText({
    commonConfig()
  })
  
  # for A/B testing
  # start with the historical price and conversion rate
  # also suggest a list of prices to use, but allow to add price
  # show the contender and statistical contender conversion rate required
  # show the sample size required and allow override
  # put a button for the next test, and per click add new item like above
  # show the results in terms of two curves of distribution of results (show all so far)
  
  library(data.table)
  ancillaryPriceDemand = read.csv("C:/Users/sg0224373/Desktop/SabreTasks/PriceTesting/Dashboard/shiny/AncillaryPriceDemandDomesticBusiness.csv")
  ancillaryPriceDemand = setDT(ancillaryPriceDemand)
  
  # show the list of potential prices to choose
  #-----------------------
  output$priceOptions <- renderUI({
    if (is.null(input$curPrice)){
      curPrice = ancillaryPriceDemand[Ancillary==input$ancillary & CurrentPrice == 1, Price]
    }else{
      curPrice = input$curPrice
    }
    currentAncillaryPD= ancillaryPriceDemand[Ancillary==input$ancillary & Price != curPrice,]
    checkboxGroupInput("PriceOpts", paste("Price Options for ",input$ancillary ,"Ancillary:"),
                       c(currentAncillaryPD$Price), selected =c(currentAncillaryPD$Price) )
  })
  
  # Show the current price rate
  output$CurPrice <- renderUI({
    currentAncillaryPD= ancillaryPriceDemand[Ancillary==input$ancillary,]
    textInput("curPrice", "Current Price",paste(currentAncillaryPD[CurrentPrice==1,Price]))
  })
  
  # Show the current conversion rate
  output$CurConvRate <- renderUI({
    currentAncillaryPD= ancillaryPriceDemand[Ancillary==input$ancillary,]
    textInput("curConvRt", "Current Conversion Rate",paste(currentAncillaryPD[CurrentPrice==1,Demand]))
  })
  
  # show the list of conversion rate we are interested in and the sample size (selectable)
  #---------------
  updateABTestingconfig<- function (){
    currentAncillaryPD= ancillaryPriceDemand[Ancillary==input$ancillary,]
    if (is.null(input$curPrice)){
      curPrice =currentAncillaryPD[CurrentPrice==1,Price]
    }else{
      curPrice = as.numeric(input$curPrice)
    }
    if (is.null(input$curConvRt )){
      curConvRt =currentAncillaryPD[CurrentPrice==1,Demand]
    }else{
      curConvRt = as.numeric(input$curConvRt)
    }
    if (is.null(input$PriceOpts)){
      contenderPrice = currentAncillaryPD[Price!=curPrice,Price]
    }else{
      contenderOptions = setdiff(as.numeric(input$PriceOpts),curPrice)
      contenderPrice = contenderOptions
    }
    #print(contenderPrice)
    #print (curPrice)
    if (length(contenderPrice)>0){
      TestInformation = data.table(Sample.Size=c(0),Original.Price=c(curPrice),Contender.Price = contenderPrice)
      TestInformation = setDT(TestInformation)
    }
    #print(TestInformation)
    if (is.null(input$Power)){
      power = 0.95
    }else{
      power = as.numeric(input$Power)
    }
    
    for (candidatePrice in contenderPrice){
      p1 = curConvRt
      p2 = p1 * curPrice/candidatePrice
      ABTestingInfo = power.prop.test(p1=p1,p2=p2,power=1- ((1-power)/length(contenderPrice)))
      TestInformation[Contender.Price==candidatePrice,Sample.Size:=floor(ABTestingInfo$n)]
      #       TestInformation = paste(TestInformation,"\n", floor(ABTestingInfo$n), "passengers required for each", 
      #                               "First Price:",curPrice, "and Second Price:",candidatePrice)
    }
    #take a copy for visualization
    temp<<- cbind(TestInformation,data.table(matrix(currentAncillaryPD[Price %in% contenderPrice,Demand],ncol=1)))
    if ('V1' %in% names(temp)){
      setnames(temp, 'V1','ConversionRate')
    }
    ABTestingInfo<<-temp
    #print(temp)
    
    setnames(TestInformation, "Sample.Size", "Sample Size (Passengers)")
    setnames(TestInformation, "Original.Price", "Original Price ($ Dollar)")
    setnames(TestInformation, "Contender.Price", "Contender Price ($ Dollar)")
    TestInformation
  }
  output$DetailOfStatTest <- renderDataTable(
      {
        updateABTestingconfig()
        #  textInput("DStatTest", "Details of Statistical Test", input$curConvRt)
        
      },  options = list(pageLength = 10)
      )
  
  # the renderUI function creates active reactive context
  #--------------------
  output$secondaryConfig <- renderUI({
    switch(input$Methodology,
           "ABTesting" = textInput("Power", "Power of Statistic Test","0.95"),
           "ThompsonSampling" = textInput("dynamic", "Dynamic","Thompson Sampling"),
           textInput("dynamic", "Dynamic","Not Selected")
    )
  })

  #ABTestingInfo
  
  # draw the posterior after the test (simulate 1000 points from est, STE) => (revenue, density, price)
  #-------------------------------------------
  #autoInvalidate <- reactiveTimer(5000, session) #authomatically update the figure
  output$ABTestingPlot <- renderPlot( {
    updateABTestingconfig()
    #autoInvalidate() #authomatically update the figure
    # include  the following to make sure the figure is updated when PriceOpts changes
    if (is.null(input$PriceOpts)){
      contenderPrice = currentAncillaryPD[,Price]
    }else{
      contenderOptions =as.numeric(input$PriceOpts)
    }
    #---------
    numberOfBuckets = 20
    if (is.null(input$ancillary)){
      ancillary = 'BIKE BOX'
    }else{
      ancillary = input$ancillary
    }
    currentAncillaryPD= ancillaryPriceDemand[Ancillary==ancillary,]
    if (is.null(input$curPrice)){
      curPrice =currentAncillaryPD[CurrentPrice==1,Price]
    }else{
      curPrice = as.numeric(input$curPrice)
    }
    if (is.null(input$curConvRt )){
      curConvRt =currentAncillaryPD[CurrentPrice==1,Demand]
    }else{
      curConvRt = as.numeric(input$curConvRt)
    }
    #print(ABTestingInfo)
   # setnames(ABTestingInfo,"V1","ConversionRate")
    #print(ABTestingInfo)
    
    NOrigin = max(ABTestingInfo$Sample.Size)
    g = data.table(matrix(rep(0,numberOfBuckets*(nrow(ABTestingInfo)+1)*3),ncol=3))
    setnames(g,'V1','revenue')
    setnames(g,'V2','density')
    setnames(g,'V3','price')
    # simulate and prepare result for the first case
    #--------------------------
    simulatedResponse = rbinom(NOrigin,1,curConvRt)
    tabulated = table(simulatedResponse)
    estProb = tabulated[2]/sum(tabulated)
    ste = sqrt(estProb*(1-estProb))/sqrt(NOrigin)
    tmpDistrib = rnorm(1000,estProb,ste)
    minTmpDistrib = min(tmpDistrib)
    maxTmpDistrib = max(tmpDistrib)
    #print(paste('number of buckets is:',numberOfBuckets))
    #print(paste('minTmpDistrib is:',minTmpDistrib))
    #print(paste('maxTmpDistrib is:',maxTmpDistrib))
    tmpDistrib = c(tmpDistrib,minTmpDistrib + (maxTmpDistrib-minTmpDistrib)*(0:numberOfBuckets)/numberOfBuckets)
    breaks = (minTmpDistrib + (maxTmpDistrib-minTmpDistrib)*(0:numberOfBuckets)/numberOfBuckets)*curPrice
    rv = hist(tmpDistrib*curPrice,breaks=breaks)
#     print(NOrigin)
#     print(simulatedResponse)
#     print(curPrice)
#     print(curConvRt)
#     print(estProb)
#     print(ste)
#     print(rv)
    g[1:numberOfBuckets,revenue:=rv$breaks[-1]]
    g[1:numberOfBuckets,density:=rv$density]
    g[1:numberOfBuckets,price:=curPrice]
#     print(g)
#     print(dim(g))
    # simulate and prepare result for the rest of cases
    #--------------------------
    curOffset = numberOfBuckets
    for (i in 1:nrow(ABTestingInfo)){
     # print(i)
      simulatedResponse = rbinom(ABTestingInfo[i,Sample.Size],1,ABTestingInfo[i,ConversionRate])
      tabulated = table(simulatedResponse)
      if (length(tabulated)>1){
        estProb = tabulated[2]/sum(tabulated)
      }else{
        estProb = 0.00000001 # smoothing
      }
      
      ste = sqrt(estProb*(1-estProb))/sqrt(ABTestingInfo[i,Sample.Size])
#       print(i)
#       print(tabulated)
#       print(estProb)
#       print(ste)
#       print(ABTestingInfo)
      tmpDistrib = rnorm(1000,estProb,ste)
      minTmpDistrib = min(tmpDistrib)
      maxTmpDistrib = max(tmpDistrib)
      breaks = (minTmpDistrib + (maxTmpDistrib-minTmpDistrib)*(0:numberOfBuckets)/numberOfBuckets)*ABTestingInfo[i,Contender.Price]
      tmpDistrib = c(tmpDistrib,minTmpDistrib + (maxTmpDistrib-minTmpDistrib)*(0:numberOfBuckets)/numberOfBuckets)
      rv = hist(tmpDistrib*ABTestingInfo[i,Contender.Price],breaks=breaks)
      #print(rv$breaks)
      #print(rv$density)
      g[curOffset+(1:numberOfBuckets),revenue:=rv$breaks[-1]]
      g[curOffset+(1:numberOfBuckets),density:=rv$density]
      g[curOffset+(1:numberOfBuckets),price:=ABTestingInfo[i,Contender.Price]]
      curOffset = curOffset + numberOfBuckets
     # print(i)
      #print(g[curOffset+(1:50),])
    }

      
#     size = 2
#     rv1 = hist(abs(rnorm(1000,100,50)),breaks=50)
#     rv2 =  hist(abs(rnorm(1000,120,100)),breaks=50)
#     rv3 =  hist(abs(rnorm(1000,90,200)), breaks = 50)
#     g = data.table(revenue=c(rv1$breaks[-1],rv2$breaks[-1],rv3$breaks[-1]),
#                    density = c(rv1$density, rv2$density, rv3$density),
#                    price = c(rep(100,length(rv1$density)),rep(200,length(rv2$density)),rep(300,length(rv3$density)))
#     )
    g$price <- as.factor(g$price)
    if (sum(is.na(g$density))+sum(is.na(g$price))+sum(is.na(g$revenue))<30){
      p = ggplot(data=g) +
        geom_line(aes(x=revenue,y=density,color=price,linetype=price),size=size) +
        geom_ribbon(aes(x=revenue,ymin=0,ymax=density,fill=price),alpha=0.1) +
        xlab('Possible Observed Expected Revenue per Price (dollars)') +
#         scale_x_continuous(limits = c(adoptedQuantile(g$revenue,g$density,0.001),
#                                       adoptedQuantile(g$revenue,g$density,0.999))) +
        ggtitle(paste('Distribution of possible observed Expected Revenue Per Passenger for',ancillary,'\n')) +
        theme_bw()+theme(axis.text=element_text(size=14),
                         axis.title=element_text(size=16,face="bold"),plot.title = element_text(size=18))
      print(p)
    }
  })
  
  #==================================================================================================================
  # Thompson Sampling (Multi arm bandit)
  #==================================================================================================================
  # show the common configuration (send error if it is A/B testing)
  # Show the list of contender prices to select
  # View experiment detail (but here it is sequential, so it is a little bit hard to handle)
  # Show the results
  #----------------------------
  # show the list of potential prices to choose
  #-----------------------
  output$priceOptionsTS <- renderUI({
    if (is.null(input$curPriceTS)){
      curPrice = ancillaryPriceDemand[Ancillary==input$ancillary & CurrentPrice == 1, Price]
    }else{
      curPrice = input$curPriceTS
    }
    currentAncillaryPD= ancillaryPriceDemand[Ancillary==input$ancillary & Price != curPrice,]
    checkboxGroupInput("PriceOptsTS", paste("Price Options for ",input$ancillary ,"Ancillary:"),
                       c(currentAncillaryPD$Price), selected =c(currentAncillaryPD$Price) )
  })
  
  # Show the current price rate
  output$CurPriceTS <- renderUI({
    currentAncillaryPD= ancillaryPriceDemand[Ancillary==input$ancillary,]
    textInput("curPriceTS", "Current Price",paste(currentAncillaryPD[CurrentPrice==1,Price]))
  })
  
  # Show the current conversion rate
  output$CurConvRateTS <- renderUI({
    currentAncillaryPD= ancillaryPriceDemand[Ancillary==input$ancillary,]
    textInput("curConvRtTS", "Current Conversion Rate",paste(currentAncillaryPD[CurrentPrice==1,Demand]))
  })
  
  output$numberOfDays <- renderUI({
    textInput("numDaysTS", "Expected Number of Experiment Days",paste(ThompsonSamplingNumberOfDays))
  })
  output$numberOfDailyPassengers <- renderUI({ 
    textInput("numDailyPax", "Number of Passengers to Expose",paste(ThompsonSamplingPaxPerDay))
  })
  
#   numUpdates = 12
#   observations.per.update = floor(59048/numUpdates)
#   MainThompsonSampling (priceLevels,ProbPurchase,observations.per.update,numUpdates) 

  # Purchase Probability curve
  #-------------------------------
  # Box plot of the success probabilities
  #===============================================
  #PurchaseProbDistrib(priceLevels,ProbPurchase,observations.per.update,numUpdates)
  ThompsonSamplingPlots <- function(priceLevels,ProbPurchase,observations.per.update,numUpdates){
    simResults = MainThompsonSampling (priceLevels,ProbPurchase,observations.per.update,numUpdates) 
    gPurchProb = PurchaseProbDistrib(priceLevels,ProbPurchase,observations.per.update,numUpdates,simResults)
    gRevDistrib = RevenueDistrib(priceLevels,ProbPurchase,observations.per.update,numUpdates,simResults)
    gpriceExerciseAcrossDays=  armExerciseAcrossDays(priceLevels,ProbPurchase,observations.per.update,numUpdates,simResults)
    return(list(gPurchProb=gPurchProb, gRevDistrib=gRevDistrib, gpriceExerciseAcrossDays = gpriceExerciseAcrossDays))
  }
  
  #bar plot for the exploration versus exploitation
  #=================================
  armExerciseAcrossDays <- function(priceLevels,ProbPurchase,observations.per.update,numUpdates,simResults){
    number.of.arms = length(priceLevels)
    originalDay=as.numeric(
      rmultinom(n = 1,
                size=observations.per.update,
                prob=rep(1.0 / number.of.arms, number.of.arms)))
    optimalArmProb = as.data.frame(rbind(originalDay,simResults$optimal.arm.probabilities))
    setDT(optimalArmProb)
    names(optimalArmProb)=paste0('$',priceLevels)
    optimalArmProb$Day=paste0("Day ",1:numUpdates)
    optimalArmProbMelted=melt(optimalArmProb,id.vars=c("Day"))
    names(optimalArmProbMelted)=c("Day","Price","Probability")
    optimalArmProbMelted$Day <- factor(optimalArmProbMelted$Day, levels=unique(as.character(optimalArmProbMelted$Day)) )
    optimalArmProbMelted$Price <- factor(optimalArmProbMelted$Price, levels=unique(as.character(optimalArmProbMelted$Price)) )
    
    
    library(scales)
    g = ggplot(optimalArmProbMelted,aes(x = Day, y = Probability,fill = Price)) + 
      geom_bar(position = "fill",stat = "identity") + 
      scale_y_continuous(labels = percent_format()) + theme(axis.text.x = element_text(angle = 90, hjust = 1))+
      ggtitle(paste('Proportion of Applying each Price across Experiment Days')) +
      theme_bw()+theme(axis.text=element_text(size=14),
                       axis.title=element_text(size=16,face="bold"),plot.title = element_text(size=18))
    
  }
  
  # Box plot of the revenue
  #===================================================
  RevenueDistrib <- function(priceLevels,ProbPurchase,observations.per.update,numUpdates,simResults){
    library(data.table)
    expectedRevenue = as.data.frame(t(t(simResults$bandit$success.probabilities)*priceLevels))
    setDT(expectedRevenue)
    names(expectedRevenue)=paste0('$',priceLevels)
    
    visualExpectedRev=melt(expectedRevenue)
    names(visualExpectedRev)=c("Price","ExpectedRevenue")
    
    
    g = ggplot(data=visualExpectedRev, aes(factor(Price), ExpectedRevenue))+ 
      geom_boxplot(aes(fill = factor(Price)),outlier.colour = "green", outlier.size = 3)+
      ggtitle("Expected Revenue Distribution ") +
      labs(x="Price",y="Expected Revenue") 
  }
  
  # Box plot of the Conversion Probability
  #===================================================
  PurchaseProbDistrib <- function (priceLevels,ProbPurchase,observations.per.update,numUpdates,simResults){
    succesProb = as.data.frame(simResults$bandit$success.probabilities)
    setDT(succesProb)
    names(succesProb)=paste0('$',priceLevels)
    
    visualSuccessProb=melt(succesProb)
    names(visualSuccessProb)=c("Price","PurchaseProb")
    
    # segment for actual values
    number.of.arms = length(priceLevels)
    positions <- 1:number.of.arms
    actualValue=as.data.frame(list(x1=positions - .25, y1=c(simResults$true.demand.prob),
                                   x2=positions + .25, y2=c(simResults$true.demand.prob)))
    beginPoint=as.data.frame(list(x1=positions - .25, y1= c(simResults$true.demand.prob)))
    
    g = ggplot(data=visualSuccessProb, aes(factor(Price), PurchaseProb))+ 
      geom_boxplot(aes(fill = factor(Price)),outlier.colour = "green", outlier.size = 3)+ # add segments
      geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2,color="Correct Choice Prob."), data = actualValue) + # add points
      geom_point( data=beginPoint, fill="red",aes(x = x1, y = y1))+ ggtitle("Purchase Probability Distribution ") +
      labs(x="Price",y="Purchase Probability") 
    return(g)
  }
  
  # Thompson Sampling Result
  ThompsonSamplingRslt <- function(){
    currentAncillaryPD= ancillaryPriceDemand[Ancillary==input$ancillary,]
    # put together the priceLevels vector
    #----------
    if (!is.null(input$curPriceTS)){
      currentPrice = as.numeric(input$curPriceTS)
    }else{
      currentPrice = currentAncillaryPD[CurrentPrice==1,Price]
    }
    #print('current price is:',currentPrice)
    if (!is.null(input$PriceOptsTS)){
      contenderPriceTS=as.numeric(input$PriceOptsTS)
    }else{
      contenderPriceTS= currentAncillaryPD[Price != currentPrice,Price]
    }
    priceLevels = c(currentPrice,contenderPriceTS) 
    # put together the conversion vector rate
    #----------
    if (!is.null(input$CurConvRateTS)){
      CurConvRateTS = as.numeric(input$CurConvRateTS)
    }else{
      CurConvRateTS = currentAncillaryPD[CurrentPrice==1,Demand]
    }
    if (!is.null(input$PriceOptsTS)){
      contenderConvRateTS = currentAncillaryPD[Price %in% input$PriceOptsTS,Demand]
    }else{
      contenderConvRateTS = currentAncillaryPD[Price != currentPrice,Demand]
    }
    ProbPurchase = c(CurConvRateTS,contenderConvRateTS) 
    # set the number of daily passengers
    #-------------
    if (!is.null(input$numDailyPax)){
      observations.per.update = as.numeric(input$numDailyPax)
    }else{
      observations.per.update = ThompsonSamplingPaxPerDay
    }
    # set the number of days to update
    #---------------
    if (!is.null(input$numDaysTS)){
      numUpdates = as.numeric(input$numDaysTS)
    }else{
      numUpdates = ThompsonSamplingNumberOfDays 
    }
    ThompsonSamplingPlots(priceLevels,ProbPurchase,observations.per.update,numUpdates)
  }
  
  # action button to show Thompson Sampling Results
  TSRsltButtonPushed <- eventReactive(input$showTSRslt, {
    ThompsonSamplingRslt <- isolate(ThompsonSamplingRslt())
    gRevDistrib <<- ThompsonSamplingRslt$gRevDistrib
    gPurchProb <<- ThompsonSamplingRslt$gPurchProb
    gpriceExerciseAcrossDays <<- ThompsonSamplingRslt$gpriceExerciseAcrossDays
  })
  
  output$TSProbPlot <- renderPlot( {
    # only when this button is pushed the result will be shown
    TSRsltButtonPushed()
    # priceLevels
    # ProbPurchase
    #observations.per.update
    #numUpdates
    #print(paste('priceLevels:',priceLevels,'ProbPurchase:', ProbPurchase,'observations.per.update:',observations.per.update,'numUpdates:',numUpdates ))
    print(gPurchProb)
  })
  output$TSRevPlot <- renderPlot( {
    TSRsltButtonPushed()
    print(gRevDistrib)
  })
  output$gpriceExerciseAcrossDays <- renderPlot( {
    TSRsltButtonPushed()
    print(gpriceExerciseAcrossDays)
  })
  
  #---------------------------
  # handle the navigation between tabs
  #--------------------------
  
  observeEvent(input$Methodology,{
    output$menuitem <- renderMenu({
      if (input$Methodology=="ABTesting"){
        menuItem("A/B Testing", icon = icon("bar-chart"), tabName = "ABTestingConfig",
                 badgeColor = "red")
      }else{
        menuItem("Thompson Sampling", tabName = "ThompsonSamplingConfig", icon = icon("bar-chart"),
                 badgeColor = "green") 
      }
    })
  })
  
  #------------------------------------
  # Handle different type of Network
  #-----------------------------------
  observeEvent(input$Network,{
     if (!is.null(input$CustSeg)){
       custSeg = input$CustSeg
     }else{
       custSeg = "Business"
     }
     if (!is.null(input$Network)){
       filepath = paste0("AncillaryPriceDemand",input$Network,custSeg,".csv")  
       print(filepath)
       ancillaryPriceDemand <<- setDT(read.csv(paste0("C:/Users/sg0224373/Desktop/SabreTasks/PriceTesting/Dashboard/shiny/",filepath)))
     }
  })
  observeEvent(input$CustSeg,{
    if (!is.null(input$Network)){
      inputNetwork = input$Network
    }else{
      inputNetwork = "Domestic"
    }
    if (!is.null(input$CustSeg)){
      filepath = paste0("AncillaryPriceDemand",inputNetwork,input$CustSeg,".csv")  
      print(filepath)
      ancillaryPriceDemand <<- setDT(read.csv(paste0("C:/Users/sg0224373/Desktop/SabreTasks/PriceTesting/Dashboard/shiny/",filepath)))
    }
  })
  
  
  
#   observe({
#     if(input$Methodology=="ABTesting"){
#       updateTabsetPanel(session, "inTabset", selected = "ABTestingConfig")
#     }else{
#       if(input$Methodology=="ThompsonSampling"){
#         updateTabsetPanel(session, "inTabset", selected = "ThompsonSamplingConfig")
#       }
#     } 
#   })
  
#   output$mytabs = renderUI({
#     nTabs = input$nTabs
#     myTabs = lapply(paste('Tab', 1: nTabs), tabPanel)
#     do.call(tabsetPanel, myTabs)
#   })

    
#   observeEvent(input$Methodology,{
#     print('pushed')
#     js_string <-  "$('#ThompsonSamplingConfig').hide()"
#     session$sendCustomMessage(type='jsCode', list(value = js_string))
# #     if (!is.null(input$Methodology)){
# #       if(input$Methodology == "ABTesting"){
# #         session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "show", tabName = "ABTestingConfig"))
# #         session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "ThompsonSamplingConfig"))
# #       }else{
# #         session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "show", tabName = "ThompsonSamplingConfig"))
# #         session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "ABTestingConfig"))
# #       }
# #     }else{
# #       session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "show", tabName = "ABTestingConfig"))
# #       session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "ThompsonSamplingConfig"))
# #     }
#   })
#   reactive(
#   if (!is.null(input$Methodology)){
#     if(input$Methodology == "ABTesting"){
#       session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "show", tabName = "ABTestingConfig"))
#       session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "ThompsonSamplingConfig"))
#     }else{
#       session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "show", tabName = "ThompsonSamplingConfig"))
#       session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "ABTestingConfig"))
#     }
#   }else{
#     session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "show", tabName = "ABTestingConfig"))
#     session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "ThompsonSamplingConfig"))
#   })
 
    
#==================================================================================================================
  #renderPlot
  #renderChart3
#   output$plot <-renderChart2({
#     if((input$x =="Research group segmentation") &  (input$y =="Property Names") ){
#       #stacked bar chart to check the percentage of customers in each property estimated by research group
#       #===========================================
#       toPlotData = copy(HotelData)
#       setnames(toPlotData,"Property_Nm","Property.Name")
#       setnames(toPlotData,"Profile_Type_Nm","Profile.Class")
#       g=GenerateStackkedBarChart(dtData=toPlotData,feature1="Property.Name",segment="Profile.Class",ID="Confirm_Nbr",
#                                  NULL)
#       rm(toPlotData)
#       gc()
#       
#     }    else{
#       dir.create(paste0(getwd(),"/imagesForPresentation"), recursive = T, showWarnings = F)
#       toPlotData = copy(HotelData)
#       setnames(toPlotData,"Property_Nm","Property.Name")
#       g=GenerateOVerallSummaryPlotsPercentage(dtData=toPlotData,feature1="Property.Name",ID="Confirm_Nbr",FileName=NULL)
#       rm(toPlotData)
#       gc()
#     } 
#     #print(g)
#     g
#   })#, height=700)
  
  
# output$value <- renderText({paste(input$x,input$y)})
  #"Business rule Rate Category""
  
  
  # for closing the session in deployment
  session$onSessionEnded(function() {
    stopApp()
  })
  
})

