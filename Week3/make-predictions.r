# Load necessary libraries
library(rpart)
library(rpart.plot)
library(caret)

# Load the iris dataset
data(iris)

# Build the decision tree model with rpart
tree_iris <- rpart(Species ~ ., data = iris)

# Make predictions on the training data
pred_iris <- predict(tree_iris, iris, type = "class")

# View the first few predictions
head(pred_iris)