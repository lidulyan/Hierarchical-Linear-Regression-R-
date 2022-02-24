# Hierarchical Linear Regression Analysis (BACKWARD)

## HLR_Backward.R
- Performs backward hierarchical linear regression
______________


## HLR_Backward_prediction.R
- 1. Splits data into training and testing sets with "data_split" proportion 
  2. Performs HLR on the training set
  3. Predicts data on the testing set using the best model

Note: HLR_Backward_prediction.R uses HLR_Backward.R
______________


## HLR_Backward_PredictPermute.R
- 1. Splits data into training and testing sets with "data_split" proportion 
  2. Performs HLR on the training set
  3. Predicts data on the testing set using the best model
  4. Repeats everything "Niteration" times


Note: HLR_Backward_PredictPermute.R uses HLR_Backward_prediction.R 
______________





# Hierarchical Linear Regression Analysis (FORWARD)

## HLR_Forward.R
- Performs forward hierarchical linear regression
______________


## HLR_Forward_prediction.R
- 1. Splits data into training and testing sets with "data_split" proportion 
  2. Performs HLR on the training set
  3. Predicts data on the testing set using the best model

Note: HLR_Forward_prediction.R uses HLR_Forward.R
______________


## HLR_Forward_PredictPermute.R
- 1. Splits data into training and testing sets with "data_split" proportion 
  2. Performs HLR on the training set
  3. Predicts data on the testing set using the best model
  4. Repeats everything "Niteration" times


Note: HLR_Forward_PredictPermute.R uses HLR_Forward_prediction.R 
