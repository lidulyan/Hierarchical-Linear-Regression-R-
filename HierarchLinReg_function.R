HierarchLinReg <- function(my_df) {
  # Some variables that will be useful
  name_of_dep_var = colnames(my_df)[1]
  model_i <- list()
  mod_summaries <- list()
  r2adj <- list()
  keep_component = NA
  
  #It starts with the second column because the first column is the dependent variable
  for(i in 2:ncol(my_df)-1) {
    # Create the full model with all 46 predictors
    total_model <- lm(formula(my_df), data=my_df) 
    ##########################################
    ## Which component we want to take out? ##
    ##########################################
    
    #last_kicked_component_i will contain the component that will be kicked in the reduced model
    last_kicked_component_i = paste0("Component", as.character(ncol(my_df)-i))
    if (i != 46){
      predictors_i <- colnames(my_df)[2:(ncol(my_df)-i)]
      #predictors_i contains the list of predictors plus those components that were important in explaining the variance
      predictors_i <- na.omit(c(predictors_i, keep_component))
    } else {
      predictors_i <- na.omit(keep_component)
    }
    
    ##########################################
    ## Perform a linear regression          ##
    ##########################################
    if (length(predictors_i) == 0){
      model_i = NA
    } else {
      f <- as.formula(paste(name_of_dep_var, paste(predictors_i, collapse = " + "), sep = " ~ "))
      mod <- eval(bquote(lm(.(f), data = my_df)))
      
      ##########################################
      ## Store the results                    ##
      ##########################################  
      # The model itself
      model_i[[i]] <- mod
      # The summary of the model
      mod_summaries[[i]] <- summary(model_i[[i]])
      # The R2 adjusted
      r2adj[[i]] <- summary(model_i[[i]])$adj.r.squared
      
      #If The first comparison
      if (i==1) {
        if (anova(total_model,model_i[[i]])[2, 6]<0.05){             # If the comparison between two models is significant,
          keep_component = c(keep_component,last_kicked_component_i) # then it means that the component that we took out is
          the_best_model <- total_model                              # important and we should keep it.
        } else {
          the_best_model <- model_i[[i]]                             # If the comparison is not significant then the component
        }                                                            # was not important so we consider the model with less
        #If The last comparison                                      # predictors as "the best model" because it can explain the
      } else if (i==(ncol(my_df)-1)) {                               # the variance in data in the same way with less components
        last_kicked_component_i = paste0("Component", as.character(ncol(my_df)-i))
        predictors_i <- na.omit(keep_component)
        f <- as.formula(paste(name_of_dep_var, paste(predictors_i, collapse = " + "), sep = " ~ "))
        mod <- eval(bquote(lm(.(f), data = my_df)))
        model_i[[i]] <- mod
        mod_summaries[[i]] <- summary(model_i[[i]])
        r2adj[[i]] <- summary(model_i[[i]])$adj.r.squared
        if (anova(the_best_model,model_i[[i]])[2, 6]<0.05){
          keep_component = c(keep_component,last_kicked_component_i)
          the_best_model <- the_best_model
        } else {
          the_best_model <- model_i[[i]]
        }
        #If all other comparisons
      } else {
        if (anova(the_best_model,model_i[[i]])[2, 6]<0.05){
          keep_component = c(keep_component,last_kicked_component_i)
          the_best_model <- the_best_model
        } else {
          the_best_model <- model_i[[i]]
        }
      }
    }
  }  
  return(model_i)
}
