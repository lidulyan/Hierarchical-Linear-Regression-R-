HLR_Forward_PredictPermute <- function(mydtt,Niteration,data_split){
  set.seed(0)
  random_seq = unique(sample(20000, Niteration, rep=F))
  number_of_iter <- seq(1:Niteration)
  corr_coef = 0
  staats_i = as.data.frame(corr_coef)
  staats_i$corr_pvalue = 0
  formulas = list()
  for (i in number_of_iter){
    if (i == 61){
      print("hellothere")
    }
    result <- HLR_Forward_prediction(mydtt, random_seq[i], data_split)
    if (all(is.na(result))){
      corr_coef = NA
      staats = as.data.frame(corr_coef)
      staats$corr_pvalue = NA
      staats_i <- rbind(staats_i,staats)
      
      formula_i <- NA
      formulas <- c(formulas,formula_i)
      print(c(number_of_iter[i],random_seq[i]))
    } else {
      staats <- as.data.frame(result[1])
      staats_i <- rbind(staats_i, staats)
      
      formula_i <- result[2]
      formulas <- c(formulas,formula_i)
      print(c(number_of_iter[i],random_seq[i]))
    }
  }
  return(list(staats_i,formulas,random_seq,result[6],result))
}
