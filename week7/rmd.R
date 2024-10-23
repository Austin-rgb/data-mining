# Install required packages if not already installed
# install.packages(c("dslabs", "caret", "tidyverse"))

library(dslabs)
library(caret)
library(tidyverse)

# Load the dataset
data("mnist_27")

# Define the models to train
models <- c("glm", "lda", "naive_bayes", "svmLinear", "gamboost",
            "gamLoess", "qda", "knn", "kknn", "loclda", "gam", "rf",
            "ranger", "wsrf", "Rborist", "avNNet", "mlp", "monmlp", "gbm",
            "adaboost", "svmRadial", "svmRadialCost", "svmRadialSigma")

# Train each model and store in a list
set.seed(123)
fits <- map(models, function(model) {
  train(y ~ ., method = model, data = mnist_27$train)
})

# Assign names to the list of models
names(fits) <- models

# Generate predictions for each model on the test set
predictions <- map(fits, function(fit) {
  predict(fit, newdata = mnist_27$test)
})

# Combine predictions into a matrix
prediction_matrix <- do.call(cbind, predictions)
colnames(prediction_matrix) <- models

# Calculate accuracy for each model
accuracy <- map_dbl(predictions, function(pred) {
  mean(pred == mnist_27$test$y)
})

# Display the accuracies
accuracy

# Create an ensemble prediction using majority vote
ensemble_pred <- apply(prediction_matrix, 1, function(row) {
  as.character(names(sort(table(row), decreasing = TRUE)[1]))
})

# Calculate the accuracy of the ensemble model
ensemble_accuracy <- mean(ensemble_pred == mnist_27$test$y)
ensemble_accuracy

# Compare accuracies of individual models to ensemble
individual_vs_ensemble <- accuracy > ensemble_accuracy
individual_vs_ensemble

# Extract cross-validation accuracy estimates from each model
cv_accuracies <- map_dbl(fits, function(fit) {
  max(fit$results$Accuracy)
})

# Keep models with accuracy >= 0.8
high_accuracy_models <- names(cv_accuracies[cv_accuracies >= 0.8])

# Rebuild ensemble using high accuracy models only
high_acc_preds <- prediction_matrix[, high_accuracy_models, drop = FALSE]
ensemble_high_acc <- apply(high_acc_preds, 1, function(row) {
  as.character(names(sort(table(row), decreasing = TRUE)[1]))
})

# Calculate accuracy of the new ensemble
high_acc_ensemble_accuracy <- mean(ensemble_high_acc == mnist_27$test$y)
high_acc_ensemble_accuracy

# Calculate similarity between each pair of models
similarity_matrix <- dist(t(prediction_matrix), method = "binary")

# Visualize the results using a heatmap
heatmap(as.matrix(similarity_matrix))

# Train models with class probabilities enabled
fits_prob <- map(models, function(model) {
  train(y ~ ., method = model, data = mnist_27$train, trControl = trainControl(classProbs = TRUE))
})

# Generate conditional probabilities for each model on the test set
probs <- map(fits_prob, function(fit) {
  predict(fit, newdata = mnist_27$test, type = "prob")
})

# Average the probabilities and make predictions
avg_probs <- Reduce(`+`, probs) / length(probs)
ensemble_prob <- factor(apply(avg_probs, 1, which.max) - 1, levels = levels(mnist_27$test$y))

# Calculate accuracy of the ensemble
ensemble_prob_accuracy <- mean(ensemble_prob == mnist_27$test$y)
ensemble_prob_accuracy


# Load necessary libraries
library(dslabs)
library(caret)
library(randomForest)

# Load the full MNIST dataset
mnist <- read_mnist()

# Sample from the training set to reduce computation time
set.seed(123)
index_train <- sample(nrow(mnist$train$images), 10000)
x_train <- mnist$train$images[index_train, ]
y_train <- factor(mnist$train$labels[index_train])

# Sample from the test set
index_test <- sample(nrow(mnist$test$images), 1000)
x_test <- mnist$test$images[index_test, ]
y_test <- factor(mnist$test$labels[index_test])

# Add column names (required by caret)
colnames(x_train) <- 1:ncol(x_train)
colnames(x_test) <- colnames(x_train)

# Train a Random Forest model
set.seed(123)
control <- trainControl(method = "cv", number = 5)
train_rf <- train(x_train, y_train, 
                  method = "rf", 
                  ntree = 150, 
                  trControl = control)

# Check model performance
print(train_rf)

# Make predictions on the test set
y_pred_rf <- predict(train_rf, x_test)

# Calculate accuracy
accuracy_rf <- mean(y_pred_rf == y_test)
print(paste("Random Forest Accuracy:", accuracy_rf))

# Tune Random Forest by adjusting mtry (number of features used at each split)
grid <- expand.grid(mtry = c(1, 5, 10, 25, 50))
train_rf_tuned <- train(x_train, y_train, 
                        method = "rf", 
                        tuneGrid = grid, 
                        ntree = 150, 
                        trControl = control)

# Check the best tuned model
print(train_rf_tuned)

# Make predictions with the tuned model
y_pred_rf_tuned <- predict(train_rf_tuned, x_test)

# Calculate accuracy of the tuned model
accuracy_rf_tuned <- mean(y_pred_rf_tuned == y_test)
print(paste("Tuned Random Forest Accuracy:", accuracy_rf_tuned))

# Example of fitting an SVM model (optional)
train_svm <- train(x_train, y_train, 
                   method = "svmLinear", 
                   trControl = control)

# Make predictions using the SVM model
y_pred_svm <- predict(train_svm, x_test)

# Calculate SVM accuracy
accuracy_svm <- mean(y_pred_svm == y_test)
print(paste("SVM Accuracy:", accuracy_svm))

