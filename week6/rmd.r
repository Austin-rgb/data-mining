# Load the necessary libraries
library(dslabs)
library(tidyverse)

# Load the tissue_gene_expression dataset
data("tissue_gene_expression")

# Remove the row means
x <- sweep(tissue_gene_expression$x, 1, rowMeans(tissue_gene_expression$x))

# Compute the distance between each observation
d <- dist(x)

# Perform hierarchical clustering
h <- hclust(d)

# Plot the dendrogram with tissue types as labels
plot(h, labels = tissue_gene_expression$y, main = "Hierarchical Clustering of Tissue Types", xlab = "", cex = 0.6)

# Set K = 7 for k-means clustering
set.seed(123)  # Set seed for reproducibility
k <- kmeans(x, centers = 7)

# Compare the identified clusters with actual tissue types
table(k$cluster, tissue_gene_expression$y)

# Run the k-means algorithm multiple times
set.seed(456)
k_repeated <- kmeans(x, centers = 7)
table(k_repeated$cluster, tissue_gene_expression$y)

library(matrixStats)
library(RColorBrewer)

# Select the 50 most variable genes
sds <- rowSds(tissue_gene_expression$x)
top_genes <- order(sds, decreasing = TRUE)[1:50]

# Create a subset of data with the 50 most variable genes
x_subset <- tissue_gene_expression$x[top_genes, ]

# Center the predictors (rows)
x_subset <- sweep(x_subset, 1, rowMeans(x_subset))

# Create a color bar based on tissue types
# Ensure the number of colors matches the number of columns (samples) in x_subset
tissue_colors <- brewer.pal(7, "Set1")[as.numeric(factor(tissue_gene_expression$y))]

# Now ensure tissue_colors matches the number of columns in x_subset
# The number of tissue types (samples) should match the number of columns
if(length(tissue_colors) != ncol(x_subset)) {
  tissue_colors <- tissue_colors[1:ncol(x_subset)]
}

# Plot the heatmap with color bar
heatmap(x_subset, col = brewer.pal(11, "RdBu"), ColSideColors = tissue_colors, scale = "row")


