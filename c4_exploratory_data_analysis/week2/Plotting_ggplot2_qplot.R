library(ggplot2)
str(mpg)
# tibble [234 × 11] (S3: tbl_df/tbl/data.frame)
# $ manufacturer: chr [1:234] "audi" "audi" "audi" "audi" ...
# $ model       : chr [1:234] "a4" "a4" "a4" "a4" ...
# $ displ       : num [1:234] 1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
# $ year        : int [1:234] 1999 1999 2008 2008 1999 1999 2008 1999 1999 2008 ...
# $ cyl         : int [1:234] 4 4 4 4 6 6 6 4 4 4 ...
# $ trans       : chr [1:234] "auto(l5)" "manual(m5)" "manual(m6)" "auto(av)" ...
# $ drv         : chr [1:234] "f" "f" "f" "f" ...
# $ cty         : int [1:234] 18 21 20 21 16 18 18 18 16 20 ...
# $ hwy         : int [1:234] 29 29 31 30 26 26 27 26 25 28 ...
# $ fl          : chr [1:234] "p" "p" "p" "p" ...
# $ class       : chr [1:234] "compact" "compact" "compact" "compact" ...

## ggplot2 "Hello, world!"
qplot(displ, hwy, data = mpg)

## compare to the basic plot package
plot(mpg$displ, mpg$hwy, xlab = "Displacement", ylab = "Highway MPG")

## add legend and color for drive type: front wheel, 4w and rear wheel
qplot(displ, hwy, data = mpg, col = drv)

## Another thing that you sometimes want to add is a statistic. So a 
## statistic is just some summary of the data. And so the summary that we've 
## chosen to add here is is a kind of smoother or the more technical name 
## is called low S, and it smooths the data
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))

# behind the scence, it call geom_smooth(), gemo_line(), gemo_point()
qplot(displ, hwy, data = mpg, geom = c("line", "smooth"))

# We can make a histogram with specifying only 1 variable
qplot(hwy, data = mpg, fill = drv)


## Another feature of ggplot is called facets, and facets are like panels in 
## lattice. The idea is that you can create separate plots, which indicate, 
## again, subsets of your data indicated by a factor variable. And you can 
## make a panel of plots to look at separate subsets together. So, one option 
## to be to color code the subsets according to different colors, like we 
## did before.
qplot(displ, hwy, data = mpg, facets = . ~ drv)
## NOTE: The fastest variable takes a format that's basically a variable on 
## the left-hand side and a variable on the right-hand side. And they're 
## separated by a tilde. And so the variable on the right-hand side, determines 
## the columns of the panels. And the variable on the left-hand side indicates 
## the rows of this kind of matrix here
qplot(hwy, data = mpg, facets = drv ~ ., binwidth = 2)


## Example: MAACS
## So this comes from the Mouse Allergen and Asthma Cohort Study, which is 
## a study conducted here at Johns Hopkins of Baltimore children, aged five 
## to 17. These children all had persistent asthma, with an exacerbation in 
## the past year. And the overall goal of the study was to study the indoor 
## environment, so the home environment of these children, and its relationship 
## with asthma morbidity. So if you're interested in seeing what a little bit 
## of this was about, we have a recent publication and I give the link here.
library(ggplot2)
load("~/git/datascience/c4_exploratory_data_analysis/week2/maacs.Rda")
str(maacs)
# 'data.frame':	750 obs. of  5 variables:
#   $ id       : int  1 2 3 4 5 6 7 8 9 10 ...
# $ eno      : num  141 124 126 164 99 68 41 50 12 30 ...
# $ duBedMusM: num  2423 2793 3055 775 1634 ...
# $ pm25     : num  15.6 34.4 39 33.2 27.1 ...
# $ mopos    : Factor w/ 2 levels "no","yes": 2 2 2 2 2 2 2 2 2 2 ...

# eno: exhaled nitric oxide
qplot(log(eno), data = maacs)

qplot(log(eno), data = maacs, fill = mopos)

## Another way to visualize this data is to do a density smooth. So you can 
## see that on the left-hand side, I add the geom density to this 
## log(eno) variable. 
qplot(log(eno), data = maacs, geom = "density")

## So I split out the colors by whether they're positive to 
## mouse allergen or not.
qplot(log(eno), data = maacs, geom = "density", color = mopos)

qplot(log(pm25), log(eno), data = maacs)
qplot(log(pm25), log(eno), data = maacs, shape = mopos)
qplot(log(pm25), log(eno), data = maacs, color = mopos)


## One of the things you can do is to smooth the relationship between a 
## log PM2.5 and log eNO, and I wanna look at how this relationship is 
## different in the two groups. So I set the geom to be a point and a smooth, 
## and rather than use low S, I'm just gonna use a standard linear regression 
## model. So I say method equals LM.
qplot(log(pm25), log(eno), data = maacs, color = mopos) + geom_smooth(method = "lm")

## So, another way to look at the same data is to split it out with facets. 
## So rather than overlapping the two groups and then color-coding them 
## separately, I can just split them out into two plots using the 
## facets argument
qplot(log(pm25), log(eno), data = maacs, facets = . ~ mopos) + geom_smooth(method = "lm")


## loading new data from 2015
maacs <- read.csv("bmi_pm25_no2_sim.csv")
qplot(logpm25, NocturnalSympt, data = maacs, facets = . ~ bmicat, geom = c("point", "smooth"), method = "lm")

head(maacs[, 1:3])
# logpm25 logno2_new        bmicat
# 1 1.2476997  1.1837987 normal weight
# 2 1.1216476  1.5515362    overweight
# 3 1.9300429  1.4323519 normal weight
# 4 1.3679246  1.7736804    overweight
# 5 0.7753367  0.7654826 normal weight
# 6 1.4872785  1.1127378 normal weight

g <- ggplot(maacs, aes(logpm25, NocturnalSympt))

summary(g)
# data: logpm25, logno2_new, bmicat, NocturnalSympt [517x4]
# mapping:  x = ~logpm25, y = ~NocturnalSympt
# faceting: <ggproto object: Class FacetNull, Facet, gg>

print(g)
# No layers in plot

p <- g + geom_point()
print(p)

## Auto print
g + geom_point()

## I added my points to make the scatter plot and I added a smooth a geom 
## underscore smooth function. It adds a little smoother which is the blue 
## line and the grey confidence bands and so I used the default for the geom 
## smooth which is a low s smoother.
g + geom_point() + geom_smooth()

g + geom_point() + geom_smooth(method = "lm")

## So a variable on the left-hand side and the variable on the right-hand 
## side, the in the product of the number of factor levels is going to be 
## the number of plots that you generate with the facets. So here I've added 
## the facet grid function and I also added the smoother with my lm. 
g + geom_point() + facet_grid(. ~ bmicat) + geom_smooth(method = "lm")

## So, I'll talk a little bit about kind of modifying some of the features 
## of the aesthetics. So for example, sometimes there, you might want to 
## change the colors of the points if you don't like black points or if you 
## don't like them to be solid. You like them to be transparent. You can, 
## on the left-hand side, I've modified, modified my, my basic scatter plot 
## of pm2.5 and nocturnal symptoms by doing two things. One is I've made the 
## color steel blue. I've increased the size of the points to be 4 the 
## default is 1. And I've, and I've changed the alpha transparency to be a 
## half rather than solid.
##
## NOTE: "steelblue" is a constant values
g + geom_point(color = "steelblue", size = 4, alpha = 1/2)

## NOTE: bmicat is a variable, different color to be assigned to the 
## value of bmicat
g + geom_point(aes(color = bmicat), size = 4, alpha = 1/2)

## Modifying the labels
g + geom_point(aes(color = bmicat)) + labs(title = "MAACS Cohort") + 
  labs(x = expression("log " * PM[2.5]), y = "Nocturnal Symptoms")


## Customizing the smooth
g + geom_point(aes(color = bmicat), size = 2, alpha = 1/2) + 
  geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)

## change the theme
g + geom_point(aes(color = bmicat)) + theme_bw(base_family = "Times")

## A Notes about Axis Limits
testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50,2] <- 100 ## Outliers!
plot(testdat$x, testdat$y, type = "l", ylim = c(-3,3))

## you can see the outlier
g <- ggplot(testdat, aes(x=x, y=y))
g + geom_line()

## Axis Limits
## This one omit the outlier data point
g + geom_line() + ylim(-3,3)

## This one does not omit the outlier data point
g + geom_line() + coord_cartesian(ylim = c(-3,3))

## Calculate the deciles of the data
## length = 11 and I changed to 4 to match the video
maacs <- read.csv("bmi_pm25_no2_sim.csv")
cutpoints <- quantile(maacs$logno2_new, seq(0, 1, length = 4), na.rm = TRUE)
## Cut the data at the deciles and create a new factor variable 
maacs$no2dec <- cut(maacs$logno2_new, cutpoints)
## See the levels of the newly created factor variable
levels(maacs$no2dec)

## Code for Final Plot
## Setup ggplot with data frame
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))

## Add layers
g + geom_point(alpha = 1 / 3) +
  facet_wrap(bmicat ~ no2dec, nrow = 2, ncol = 4) +
  geom_smooth(method = "lm", se = FALSE, col = "steelblue") +
  theme_bw(base_family = "Avenir", base_size = 10) +
  labs(x = expression("log " * PM[2.5])) +
  labs(y = "Nocturnal Symptoms") +
  labs(title = "MAACS Cohort")
       
