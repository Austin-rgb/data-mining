# Load necessary libraries
library(rpart)
library(rpart.plot)
library(caret)

# Load the iris dataset
data(iris)

# View the structure of the dataset
str(iris)

# Display the first few rows of the dataset
head(iris)

# Build the decision tree model with rpart
tree_iris <- rpart(Species ~ ., data = iris)

# Print the tree structure
print(tree_iris)

# Plot the decision tree
rpart.plot(tree_iris, extra = 2)

# Make predictions on the training data
pred_iris <- predict(tree_iris, iris, type = "class")

# View the first few predictions
head(pred_iris)

# Calculate the confusion matrix and accuracy
confusionMatrix(data = pred_iris, reference = iris$Species)