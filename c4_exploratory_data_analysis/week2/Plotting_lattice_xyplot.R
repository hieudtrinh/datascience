library(lattice)
library(datasets)
## Simple scatterplot
xyplot(Ozone ~ Wind, data = airquality)


## Convert 'Month' to a factor variable
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))


## find the number of months in the dataset
months <- length(unique(airquality$Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(months, 1))


## Auto-printing if xyplot() is not store in object
p <- xyplot(Ozone ~ Wind, data = airquality) ## Nothing happens!
print(p) ## Plot appears


## Lattice Panel Functions Lattice Panel Functions
## Lattice functions have a panel function which controls what happens 
## inside each panel of the plot.
##
## The lattice package comes with default panel functions, but you can supply 
## your own if you want to customize what happens in each panel
## 
## Panel functions receive the x/y coordinates of the data points in 
## their panel (along with any
                                                                               optional arguments)
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2, 1)) ## Plot with 2 panels

## Custom panel function
xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...) ## First call the default panel function for 'xyplot'
  panel.abline(h = median(y), lty = 2) ## Add a horizontal line at the median
})

## Custom panel function
## Lattice Panel Functions: Regression line Lattice Panel Functions: 
## Regression line
xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...) ## First call default panel function
  panel.lmline(x, y, col = 2) ## Overlay a simple linear regression line
})

## both regression line and median
xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...) ## First call default panel function
  panel.lmline(x, y, col = 2) ## Overlay a simple linear regression line
  panel.abline(h = median(y), lty = 2) ## Add a horizontal line at the median
})

## try with 5 panels
set.seed(10)
x <- rnorm(100)
f <- rep(0:4, each = 20)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2", "Group 3", "Group 4", "Group 5"))
xyplot(y ~ x | f, layout = c(5, 1)) ## Plot with 5 panels
