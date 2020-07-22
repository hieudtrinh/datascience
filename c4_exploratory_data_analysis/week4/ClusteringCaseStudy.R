 # Slightly processed data Slightly processed data
load("data/samsungData.rda")
names(samsungData)[1:12]

# [1] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z"
# [4] "tBodyAcc-std()-X"  "tBodyAcc-std()-Y"  "tBodyAcc-std()-Z" 
# [7] "tBodyAcc-mad()-X"  "tBodyAcc-mad()-Y"  "tBodyAcc-mad()-Z" 
# [10] "tBodyAcc-max()-X"  "tBodyAcc-max()-Y"  "tBodyAcc-max()-Z" 

table(samsungData$activity)

# laying  sitting standing     walk walkdown   walkup 
# 1407     1286     1374     1226      986     1073 

# Plotting average acceleration for first subject Plotting average acceleration for first subject
par(mfrow = c(1, 2), mar = c(5, 4, 1, 1))
samsungData <- transform(samsungData, activity = factor(activity))
sub1 <- subset(samsungData, subject == 1)
plot(sub1[, 1], col = sub1$activity, ylab = names(sub1)[1])
plot(sub1[, 2], col = sub1$activity, ylab = names(sub1)[2])
legend("bottomright", legend = unique(sub1$activity), col = unique(sub1$activity), pch = 1)


# Clustering based just on average acceleration
source("myplclust.R")
distanceMatrix <- dist(sub1[, 1:3])
hclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col = unclass(sub1$activity))

# QUESTION
# Why is the dendrogram produced using the average acceleration features 
# relatively uninformative?
#   
#   
# Average acceleration is a binary feature and cannot be used by the 
# hclust function.
# 
# 
# The average acceleration features do not appear to be able to discriminate 
# between the six different behaviors.
# 
# Correct 
# is selected.This is correct.
# 
# The dendrogram would be more informative if a better color scheme were 
# used to color the terminal nodes.

# Plotting max acceleration for the first subject Plotting max acceleration for the first subject
par(mfrow = c(1, 2))
plot(sub1[, 10], pch = 19, col = sub1$activity, ylab = names(sub1)[10])
plot(sub1[, 11], pch = 19, col = sub1$activity, ylab = names(sub1)[11])

# Clustering based on maximum acceleration Clustering based on maximum acceleration
source("myplclust.R")
distanceMatrix <- dist(sub1[, 10:12])
hclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col = unclass(sub1$activity))

# Singular Value Decomposition Singular Value Decomposition
# [1] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z"
svd1 = svd(scale(sub1[, -c(562, 563)]))
par(mfrow = c(1, 2))
plot(svd1$u[, 1], col = sub1$activity, pch = 19)
plot(svd1$u[, 2], col = sub1$activity, pch = 19)

# Find maximum contributor Find maximum contributor
plot(svd1$v[, 2], pch = 19)

# New clustering with maximum contributer New clustering with maximum contributer
maxContrib <- which.max(svd1$v[, 2])
distanceMatrix <- dist(sub1[, c(10:12, maxContrib)])
hclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col = unclass(sub1$activity))


# New clustering with maximum contributer New clustering with maximum contributer
names(samsungData)[maxContrib]


# K-means clustering (nstart=1, first try) K-means clustering (nstart=1, first try)
kClust <- kmeans(sub1[, -c(562, 563)], centers = 6)
table(kClust$cluster, sub1$activity)


# K-means clustering (nstart=1, second try) K-means clustering (nstart=1, second try)
kClust <- kmeans(sub1[, -c(562, 563)], centers = 6, nstart = 1)
table(kClust$cluster, sub1$activity)


# K-means clustering (nstart=100, first try) K-means clustering (nstart=100, first try)
kClust <- kmeans(sub1[, -c(562, 563)], centers = 6, nstart = 100)
table(kClust$cluster, sub1$activity)


# K-means clustering (nstart=100, second try) K-means clustering (nstart=100, second try)
kClust <- kmeans(sub1[, -c(562, 563)], centers = 6, nstart = 100)
table(kClust$cluster, sub1$activity)

# Why does the K-Means algorithm produce different clustering solutions every 
# time you run it?
#   
# 1) K-Means chooses are random starting point by default.
#    Answer is 1.
#
# 2) The algorithm that K-Means uses to find the cluster centers uses stochastic 
# simulation.
# 
# 3) K-Means assumes that the cluster centers are Normally distributed.

# Cluster 1 Variable Centers (Laying) Cluster 1 Variable Centers (Laying)
plot(kClust$center[1, 1:10], pch = 19, ylab = "Cluster Center", xlab = "")

# Cluster 2 Variable Centers (Walking) Cluster 2 Variable Centers (Walking)
plot(kClust$center[4, 1:10], pch = 19, ylab = "Cluster Center", xlab = "")



