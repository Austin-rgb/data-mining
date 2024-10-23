# Load necessary libraries
library(rpart)
library(rpart.plot)
library(caret)

# Load the iris dataset
data(iris)

# Build the decision tree model with rpart
tree_iris <- rpart(Species ~ ., data = iris)

# Print the tree structure
print(tree_iris)

# Plot the decision tree
rpart.plot(tree_iris, extra = 2)