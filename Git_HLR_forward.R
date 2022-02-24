HLR_Forward <- function(my_df) {
  # Some variables that will be useful
  name_of_dep_var = colnames(my_df)[1]
  model_i <- list()
  mod_summaries <- list()
  r2adj <- list()
  keep_component = NA
  
  for(i in 2:ncol(my_df)-1) {
    # Create the first model (only one predictor which is the the Component1)
    f1 = as.formula(paste(name_of_dep_var, paste0(colnames(my_df)[2], collapse = " + "), sep = " ~ "))
    first_model = eval(bquote(lm(.(f1), data = my_df)))
    
    ##########################################
    ## Which component we want to add?      ##
    ##########################################
    last_added_component_i = paste0("Component", as.character(ncol(my_df)-(46-i)))
    if (i != 46){
      predictors_i <- colnames(my_df)[2:(ncol(my_df)-(45-i))]
      #predictors_i contains the list of predictors plus those components that were important in explaining the variance
      #predictors_i <- na.omit(c(predictors_i, keep_component)) 
      predictors_i <- na.omit(predictors_i[! predictors_i %in% keep_component])
    } else {
      predictors_i <- colnames(my_df)[2:(ncol(my_df)-(45-i))]
      predictors_i <- na.omit(predictors_i[! predictors_i %in% keep_component])
      predictors_i <- na.omit(predictors_i[! predictors_i %in% "Component1"])
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
        if (anova(first_model,model_i[[i]])[2, 6]<0.05){             # If the comparison between two models is significant,
          # then it means that the component that we added is
          the_best_model <- model_i[[i]]                             # important and we should keep it.
        } else {
          the_best_model <- first_model
          keep_component = c(keep_component,last_added_component_i)  # If the comparison is not significant then the component
        }                                                            # that was not important so we consider the model with less
        #If The last comparison                                      # predictors as "the best model" because it can explain the
      } else if (i == 46) {                                          # the variance in data in the same way with less components
        last_added_component_i = paste0("Component", as.character(1))
        
        predictors_i <- colnames(my_df)[2:(ncol(my_df)-(45-i))]
        predictors_i <- na.omit(predictors_i[! predictors_i %in% keep_component])
        predictors_i <- na.omit(predictors_i[! predictors_i %in% "Component1"])
        
        f <- as.formula(paste(name_of_dep_var, paste(predictors_i, collapse = " + "), sep = " ~ "))
        mod <- eval(bquote(lm(.(f), data = my_df)))
        model_i[[i]] <- mod
        mod_summaries[[i]] <- summary(model_i[[i]])
        r2adj[[i]] <- summary(model_i[[i]])$adj.r.squared
        if (anova(the_best_model,model_i[[i]])[2, 6]<0.05){
          the_best_model <- the_best_model
          keep_component = c(keep_component,last_added_component_i)
        } else {
          the_best_model <- model_i[[i]] 
        }
        #    #If all other comparisons
      } else {
        if (anova(the_best_model,model_i[[i]])[2, 6]<0.05){             
          the_best_model <- model_i[[i]]                            
        } else {
          the_best_model <- the_best_model
          keep_component = c(keep_component,last_added_component_i)
        }
      }
    }
    results = list(the_best_model,model_i)
  }  
  return(results)
}
