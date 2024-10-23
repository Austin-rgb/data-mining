
title: "Chapter 3: Classification: Basic Concepts and Techniques"
author: "Your Name"
date: "`r Sys.Date()`"
output: html_document
---

# Classification: Basic Concepts and Techniques

This chapter introduces decision trees for classification and discusses how models are built and evaluated. The corresponding chapter of the data mining textbook is available online: [Chapter 3: Classification: Basic Concepts and Techniques](<link-to-textbook>).

## Packages Used in this Chapter

```{r}
pkgs <- c("caret", "FSelector", "lattice", "mlbench", 
          "palmerpenguins", "party", "pROC", "rpart", "rpart.plot", 
          "sampling", "tidyverse")
pkgs_install <- pkgs[!(pkgs %in% installed.packages()[,"Package"])]
if(length(pkgs_install)) install.packages(pkgs_install)
```

The packages used for this chapter are:

- **caret** (M. Kuhn 2023)
- **FSelector** (Romanski Kotthoff and Schratz 2023)
- **lattice** (Sarkar 2023)
- **mlbench** (Leisch and Dimitriadou 2024)
- **palmerpenguins** (Horst Hill and Gorman 2022)
- **party** (Hothorn et al. 2024)
- **pROC** (Robin et al. 2023)
- **rpart** (Therneau and Atkinson 2023)
- **rpart.plot** (Milborrow 2024)
- **sampling** (Tillé and Matei 2023)
- **tidyverse** (Wickham 2023c)

A great cheat sheet for `caret` can be found [here](<link-to-cheatsheet>).

## Basic Concepts

Classification is a machine learning task where we learn a predictive function \( y = f(x) \), where \( x \) is the attribute set and \( y \) is the class label. This is a **supervised learning** problem, where the class label is available in the training data.

A related supervised learning problem is **regression**, where \( y \) is a number instead of a label.

## General Framework for Classification

Supervised learning has two steps:

1. **Induction**: Train a model on **training data** with known class labels.
2. **Deduction**: Predict class labels for new data.

We evaluate models on **test data** that does not overlap with the training data. The error on test data is called the **generalization error**.

## The Zoo Dataset

To demonstrate classification, we will use the Zoo dataset from the `mlbench` package.

```{r}
data(Zoo, package = "mlbench")
head(Zoo)
```

We convert the data frame to a `tibble` from `tidyverse`:

```{r}
library(tidyverse)
as_tibble(Zoo, rownames = "animal")
```

We will translate all `TRUE/FALSE` values into factors.

```{r}
Zoo <- Zoo |> 
  mutate(across(where(is.logical), 
                ~ factor(.x, levels = c("TRUE", "FALSE")))) |>
  mutate(across(where(is.character), factor))

summary(Zoo)
```

## Decision Tree Classifiers

We'll use the `rpart` package to build a decision tree.

```{r}
library(rpart)
tree_default <- rpart(type ~ ., data = Zoo)
tree_default
```

We can plot the resulting tree:

```{r}
library(rpart.plot)
rpart.plot(tree_default, extra = 2)
```

### Predictions for New Data

Here's how to make predictions for a new animal:

```{r}
my_animal <- tibble(hair = TRUE, feathers = TRUE, eggs = FALSE, milk = TRUE, 
                    airborne = TRUE, aquatic = FALSE, predator = TRUE,
                    toothed = TRUE, backbone = TRUE, breathes = TRUE,
                    venomous = FALSE, fins = FALSE, legs = 4, tail = TRUE, 
                    domestic = FALSE, catsize = FALSE, type = NA)

my_animal <- my_animal |> 
  mutate(across(where(is.logical), 
                ~ factor(.x, levels = c("TRUE", "FALSE"))))

predict(tree_default, my_animal, type = "class")
```

## Model Evaluation

We calculate accuracy and error of the model on the training data.

```{r}
pred <- predict(tree_default, Zoo, type = "class")
confusion_table <- with(Zoo, table(type, pred))
correct <- diag(confusion_table) |> sum()
error <- sum(confusion_table) - correct
accuracy <- correct / (correct + error)
accuracy
```

We can also use the `caret` package for evaluation.

```{r}
library(caret)
confusionMatrix(data = pred, reference = Zoo$type)
```

## Conclusion

This chapter has introduced classification with decision trees and model evaluation techniques using the Zoo dataset.
