# Hierarchical Linear Regression Analysis 

## HierarchLinReg_function.R
- Performs hierarchical linear regression
______________


## HLR_prediction.R
- 1. Splits data into training and testing sets with "data_split" proportion 
  2. Performs HLR on the training set
  3. Predicts data on the testing set using the best model

Note: HLR_prediction.R uses HierarchLinReg_function.R
______________


## HLR_Pred_Resample.R
- 1. Splits data into training and testing sets with "data_split" proportion 
  2. Performs HLR on the training set
  3. Predicts data on the testing set using the best model
  4. Repeats everything "Niteration" times


Note: HLR_Pred_Resample.R uses HLR_prediction.R 
______________
