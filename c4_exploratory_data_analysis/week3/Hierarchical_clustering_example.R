set.seed(1234)
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

# Hierarchical clustering - Hierarchical clustering - dist

dataFrame <- data.frame(x = x, y = y)
head(dataFrame)
# x         y
# 1 0.7585869 0.8447492
# 2 1.0554858 1.0128918
# 3 1.2168882 1.1918988
# 4 0.5308605 0.9779429
# 5 2.0858249 1.8977981
# 6 2.1012112 1.8177609

dist(dataFrame)
# 1          2          3          4          5          6          7          8          9         10         11
# 2  0.34120511                                                                                                              
# 3  0.57493739 0.24102750                                                                                                   
# 4  0.26381786 0.52578819 0.71861759                                                                                        
# 5  1.69424700 1.35818182 1.11952883 1.80666768                                                                             
# 6  1.65812902 1.31960442 1.08338841 1.78081321 0.08150268                                                                  
# 7  1.49823399 1.16620981 0.92568723 1.60131659 0.21110433 0.21666557                                                       
# 8  1.99149025 1.69093111 1.45648906 2.02849490 0.61704200 0.69791931 0.65062566                                            
# 9  2.13629539 1.83167669 1.67835968 2.35675598 1.18349654 1.11500116 1.28582631 1.76460709                                 
# 10 2.06419586 1.76999236 1.63109790 2.29239480 1.23847877 1.16550201 1.32063059 1.83517785 0.14090406                      
# 11 2.14702468 1.85183204 1.71074417 2.37461984 1.28153948 1.21077373 1.37369662 1.86999431 0.11624471 0.08317570           
# 12 2.05664233 1.74662555 1.58658782 2.27232243 1.07700974 1.00777231 1.17740375 1.66223814 0.10848966 0.19128645 0.20802789

# to calculate Euclidean (bird fly) distance between point 2 and point 1
sqrt((0.7585869 - 1.0554858)^ 2 + (0.8447492 - 1.0128918)^ 2) 
# [1] 0.3412051

# Hierarchical clustering - hclust
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
plot(hClustering)



# Prettier dendrograms 
myplclust <- function(hclust, lab = hclust$labels, lab.col = rep(1, length(hclust$labels)),
                      hang = 0.1, ...) {
  ## modifiction of plclust for plotting hclust objects *in colour*! Copyright
  ## Eva KF Chan 2009 Arguments: hclust: hclust object lab: a character vector
  ## of labels of the leaves of the tree lab.col: colour for the labels;
  ## NA=default device foreground colour hang: as in hclust & plclust Side
  ## effect: A display of hierarchical cluster with coloured leaf labels.
  y <- rep(hclust$height, 2)
  x <- as.numeric(hclust$merge)
  y <- y[which(x < 0)]
  x <- x[which(x < 0)]
  x <- abs(x)
  y <- y[order(x)]
  x <- x[order(x)]
  plot(hclust, labels = FALSE, hang = hang, ...)
  text(x = x, y = y[hclust$order] - (max(hclust$height) * hang), labels = lab[hclust$order],
       col = lab.col[hclust$order], srt = 90, adj = c(1, 0.5), xpd = NA, ...)
}

# Pretty dendrograms Pretty dendrograms
dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
myplclust(hClustering, lab = rep(1:3, each = 4), lab.col = rep(1:3, each = 4))

