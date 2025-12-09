# install.packages("pak")
pak::pak("thiyangt/stochastic")
library(stochastic)
# ---------------------------
# Step 1: Define the transition matrix
# ---------------------------
P <- matrix(c(
  0.5, 0.5, 0.0, 0.0,  # Level 1
  0.2, 0.5, 0.3, 0.0,  # Level 2
  0.0, 0.3, 0.3, 0.4,  # Level 3
  0.0, 0.0, 0.2, 0.8   # Level 4
), nrow = 4, byrow = TRUE)

# Optional: name the rows and columns
rownames(P) <- colnames(P) <- c("Level 1", "Level 2", "Level 3", "Level 4")

P

# ---------------------------
# Step 2: Simulate the Markov chain
# ---------------------------

init <- c(1L, 0L, 0L, 0L)
set.seed(123)  # for reproducibility
simmarkov(init, P, 50, c("Level 1", "Level 2", "Level 3", "Level 4"))

# ---------------------------
# Step 3: Compute stationary distribution
# ---------------------------
library(expm)  # for matrix power

# Method: solve pi*P = pi, sum(pi) = 1
# Solve (P' - I) * pi' = 0
n <- nrow(P)
A <- t(P) - diag(n)
A <- rbind(A, rep(1, n))  # add sum(pi) = 1
b <- c(rep(0, n), 1)
stationary <- solve(t(A) %*% A) %*% t(A) %*% b
names(stationary) <- levels

stationary

# ---------------------------
# Step 4: Plot the simulated chain
# ---------------------------
library(ggplot2)
df <- data.frame(
  Time = 1:50,
  Level = factor(sim_chain_named, levels = levels)
)

ggplot(df, aes(x = Time, y = Level)) +
  geom_point(color = "blue", size = 3) +
  geom_line(aes(group = 1), color = "gray", alpha = 0.5) +
  labs(title = "Simulated Discount Levels Over Time",
       x = "Time Period",
       y = "Discount Level") +
  theme_minimal()
