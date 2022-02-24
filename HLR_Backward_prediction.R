HLR_prediction_Backward <- function(mydt,seed,split){
  set.seed(seed)
  dt = sort(sample(nrow(mydt), nrow(mydt)*split))
  train_alm<-as.data.frame(mydt[dt,])
  test_alm<-as.data.frame(mydt[-dt,])
  
  hlr = HierarchLinReg_Backward(train_alm)
  if (all(is.na(hlr))){
    results = NA
  }else{
    #Predict on the testing set
    predicted1 <- predict(hlr[[46]],test_alm)   # Save the predicted values
    m <- as.data.frame(predicted1)
    m$real <- as.numeric(unlist(test_alm[1])) # Save the real values
    
    f <- cor.test(m$real,m$predicted1)
    corr_coef = f$estimate
    corr_pvalue = f$p.value
    stat = as.data.frame(corr_coef)
    stat$corr_pvalue =f$p.value
    #Plot it
    n <- ggplot(m, aes(x = real, y = predicted1)) +
      geom_smooth(method = "lm") +
      stat_cor() +
      geom_point() +
      theme_bw()+
      theme(axis.line = element_line(colour = "black"),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank()) 
    
    #Predict on the training set
    predicted2 <- predict(hlr[[46]])           # Save the predicted values
    m <- as.data.frame(predicted2)
    m$real <- as.numeric(unlist(train_alm[1])) # Save the real values
    
    #Plot i
    n2 <- ggplot(m, aes(x = real, y = predicted2)) +
      geom_smooth(method = "lm") +
      stat_cor() +
      geom_point() +
      theme_bw()+
      theme(axis.line = element_line(colour = "black"),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank()) 
    
    results = list(stat,hlr[[46]]$coefficients,hlr[[46]],n,n2,hlr)
  }
  return(results)
}
