
# 1. Expected value of S
N <- 25
p <- 0.5  # You can adjust this value as needed
E_S <- N * p
cat("Expected value of S:", E_S, "\n")

# 2. Standard error of S
SE_S <- sqrt(N * p * (1 - p))
cat("Standard error of S:", SE_S, "\n")

# 3. Expected value of X_bar (sample average)
E_X_bar <- p
cat("Expected value of X_bar:", E_X_bar, "\n")

# 4. Standard error of X_bar
SE_X_bar <- sqrt(p * (1 - p)) / sqrt(N)
cat("Standard error of X_bar:", SE_X_bar, "\n")

# 5. Plotting the standard error for different values of p
# Define the values of p
p_vals <- seq(0, 1, length = 100)

# Sample size N = 25
N <- 25
se_vals <- sqrt(p_vals * (1 - p_vals)) / sqrt(N)

# Create the initial plot for N = 25
plot(p_vals, se_vals, type = "l", col = "blue", xlab = "p", ylab = "Standard Error", 
     main = "Standard Error vs p")

# 6. Plotting for different values of N
# Define the sample sizes and colors for plotting
N_vals <- c(25, 100, 1000)
colors <- c("red", "green", "blue")

# Create the initial plot with N = 25
N <- N_vals[1]
se_vals <- sqrt(p_vals * (1 - p_vals)) / sqrt(N)
plot(p_vals, se_vals, type = "l", col = colors[1], xlab = "p", ylab = "Standard Error", 
     ylim = c(0, max(se_vals)), main = "Standard Error vs p for Different N")

# Add lines for N = 100 and N = 1000
for (i in 2:length(N_vals)) {
  N <- N_vals[i]
  se_vals <- sqrt(p_vals * (1 - p_vals)) / sqrt(N)
  lines(p_vals, se_vals, col = colors[i])
}

# Add a legend to the plot
legend("topright", legend = c("N=25", "N=100", "N=1000"), col = colors, lty = 1)

# 7. Expected value of d
E_d <- 2 * p - 1
cat("Expected value of d:", E_d, "\n")

# 8. Standard error of d
SE_d <- 2 * SE_X_bar
cat("Standard error of d:", SE_d, "\n")

# 9. Standard error with p = 0.45
p <- 0.45
N <- 25
SE_X_bar <- sqrt(p * (1 - p)) / sqrt(N)
SE_d <- 2 * SE_X_bar
cat("Standard error of d with p = 0.45:", SE_d, "\n")
