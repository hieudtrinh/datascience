pm0 <- read.table("pm25_data/RD_501_88101_1999-0.txt", comment.char = "#", header = FALSE, sep = "|", na.strings = "")
cnames <- readLines("pm25_data/RD_501_88101_1999-0.txt", 1)
cnames <- strsplit(cnames, "|", fixed = TRUE)

cnames
# [[1]]
# [1] "# RD"                              "Action Code"                       "State Code"                       
# [4] "County Code"                       "Site ID"                           "Parameter"                        

class(cnames)
# [1] "list"
names(pm0) <- cnames[[1]]
names(pm0) <- make.names(cnames[[1]])

# find the about the missing value
x0 <- pm0$Sample.Value
class(x0)
str(x0)
summary(x0)
mean(is.na(x0))


pm1 <- read.table("pm25_data/RD_501_88101_2012-0.txt", comment.char = "#", header = FALSE, sep = "|", na.strings = "")
cnames <- readLines("pm25_data/RD_501_88101_1999-0.txt", 1)
cnames <- strsplit(cnames, "|", fixed = TRUE)

cnames
# [[1]]
# [1] "# RD"                              "Action Code"                       "State Code"                       
# [4] "County Code"                       "Site ID"                           "Parameter"                        

class(cnames)
# [1] "list"
names(pm1) <- cnames[[1]]
names(pm1) <- make.names(cnames[[1]])

x1 <- pm1$Sample.Value
class(x1)
str(x1)
summary(x1)
mean(is.na(x1))


# Let's take a look at the 1999 and 2012
summary(x0)
summary(x1)

# percentage of missing value in 2012 is 5.6% in 1999 is 11.25%
mean(is.na(x0))
mean(is.na(x1))

# let look at the boxpot
boxplot(x0, x1)

boxplot(log10(x0), log10(x1))

# Making the boxplot of the logged data produces the following warnings:
#   
#   Warning messages:
#   
# 1: In boxplot.default(log10(x0), log10(x1)) : NaNs produced
# 2: In bplt(at[i], wid = width[i], stats = z$stats[, i], out = z$out[z$group == :
#    Outlier (-Inf) in boxplot 1 is not drawn
# 3: In bplt(at[i], wid = width[i], stats = z$stats[, i], out = z$out[z$group == :
# 
# Why are these warnings produced by R?
#   
# 1) The data contain negative numbers and so the log function returns a NaN value 
#     those numbers.
#       Correct 
#       There are two possible issues with the call to boxplot here. One is that 
#       the boxplot function generated the warning and the other is that the log 
#       function produced the warning.
# 
# 
# 2) The dataset is too large for the boxplot function to plot all the data.
# 
# 3) The boxplot function cannot plot data on a log scale.
# 
# 4) It is not appropriate to combine the log function and the boxplot 
# function into a single function call.

# It look like 2012 has lower mean 1999, however 2012 has negative value which
# is kind of odd because the PM is mass/million cannot be negative
summary(x1)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# 0.00    7.20   11.50   13.74   17.90  157.10   13217
summary(x1)
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# -10.00    4.00    7.63    9.14   12.00  908.97   73133 

# Let's find out how many of them are negative
negative <- x1 < 0
str(negative)
# logi [1:1304287] FALSE FALSE FALSE FALSE FALSE FALSE ...

sum(negative, na.rm = TRUE)
# [1] 26474

mean(negative, na.rm = TRUE)
# [1] 0.0215034

# There are 2.15% negative values

# Let see if the negative value come from certain day of year or from 
# particular site?
dates <-pm1$Date
str(dates)
# int [1:1304287] 20120101 20120104 20120107 20120110 20120113 20120116 20120119 20120122 20120125 20120128 ...

dates <- as.Date(as.character(dates), "%Y%m%d")
str(dates)
# Date[1:1304287], format: "2012-01-01" "2012-01-04" "2012-01-07" "2012-01-10" "2012-01-13" "2012-01-16" "2012-01-19" "2012-01-22" 

# Let's take a look at the hist to see when the collection occurs. Let's do it by month
hist(dates, "month")

# Let's take a look at when the negative occur
# NOTE: negative is a boolean vector of all the negatives
hist(dates[negative], "month")

# From the graph it is not clear why the negative data come from.
# We can see it occur more in the Winter as compare to other time. This may
# be because Winter has lower PM25.

# Instead looking at the entire country's monitors, let's try to find
# a single monitor in 1999 and in 2012 and compare
# Let's look at NY state.

# What does looking at the change in PM levels at a single monitor location 
# allow us to control for that we could not control for when looking at 
# the entire country?
#   
#   
#   We can control for possible changes in the monitoring locations between 
# 1999 and 2012.
# 
# Correct 
# is selected.This is correct.
# 
# We can control for changes in the pollution sources between 1999 and 2012.
# 
# 
# We can control for changes in the chemical composition of particulate matter 
# between 1999 and 2012.


# We can control for changes in global climate between 1999 and 2012.

site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID)))
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)))

# Create a key State.Code.Site.ID
site0 <- paste(site0[,1], site0[,2], sep = ".")
site1 <- paste(site1[,1], site1[,2], sep = ".")

str(site0)
# chr [1:33] "1.5" "1.12" "5.73" "5.80" "5.83" "5.110" "13.11" "27.1004" "29.2" "29.5" "29.1007" "31.3" "47.11" "47.76" ...
str(site1)
# chr [1:18] "1.5" "1.12" "5.80" "5.133" "13.11" "29.5" "31.3" "47.122" "55.1007" "61.79" "61.134" "63.2008" "67.1015" ...
# in 1999 NY has 33 and in 2012 NY has 18 stations

both <- intersect(site0, site1)
both
# [1] "1.5"     "1.12"    "5.80"    "13.11"   "29.5"    "31.3"    "63.2008" "67.1015" "85.55"   "101.3"  

# So there at 10 monitors in both 1999 and 2012 data sets

pm0$county.site <- with(pm0, paste(County.Code, Site.ID, sep = "."))
pm1$county.site <- with(pm1, paste(County.Code, Site.ID, sep = "."))

cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both)
cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)

# Let's split the dataframe by monitor
split(cnt0, cnt0$county.site)

sapply(split(cnt0, cnt0$county.site), nrow)
# 1.12     1.5   101.3   13.11    29.5    31.3    5.80 63.2008 67.1015   85.55 
# 61     122     152      61      61     183      61     122     122       7 


sapply(split(cnt1, cnt1$county.site), nrow)
# 1.12     1.5   101.3   13.11    29.5    31.3    5.80 63.2008 67.1015   85.55 
# 31      64      31      31      33      15      31      30      31      31 

# What does the code a %in% b produce, if a and b are both character vectors?
#   
#   
#   A logical vector of length equal to the length of a indicating which elements of a are in b.
# 
# Correct 
# is selected.This is correct.
# 
# A logical vector of length equal to the length of b indicating which elements of b are in a.
# 
# 
# A character vector containing the elements of a that are in the vector b.
# 
# 
# A character vector containing the elements of b that are in the vector a.


# Let's take a look at 63.2008 122 samples for 1999 and 63.2008 30 for 2012
pm0sub <- subset(pm0, State.Code == 36 & County.Code == 63 & Site.ID==2008)
pm1sub <- subset(pm1, State.Code == 36 & County.Code == 63 & Site.ID==2008)

dim(pm0sub)
# [1] 122  29

dim(pm1sub)
# [1] 30 29

dates1 <- pm1sub$Date
x1sub <- pm1sub$Sample.Value
plot(dates1, x1sub)

# Notice that the date is in integer format, let's convert it to Date format
dates1 <- as.Date(as.character(dates1), "%Y%m%d")

dates0 <- pm0sub$Date
x0sub <- pm0sub$Sample.Value
plot(dates0, x0sub)

# Notice that the date is in integer format, let's convert it to Date format
dates0 <- as.Date(as.character(dates0), "%Y%m%d")
plot(dates0, x0sub)



# Which argument to plot can be used to control the range of the y-axis so 
# that both plots can be drawn with same range?
#   
# yaxt
# pch
# xlim
# ylim
# Correct 

# Let plot both datasets 1999 and 2012
par(mfrow = c(1,2), mar = c(4,4,2,1))
plot(dates0, x0sub, pch = 20)
abline(h = median(x0sub, na.rm = T))
plot(dates1, x1sub, pch = 20)
abline(h = median(x1sub, na.rm = T))

# Looking at the graph, it is not obvious that in what year the PM25 is less
# Let's plot both graphs in using the same y range
range(x0sub, x1sub, na.rm = T)
# [1]  3.0 40.1

rng <- range(x0sub, x1sub, na.rm = T)

par(mfrow = c(1,2))
plot(dates0, x0sub, pch = 20, ylim = rng)
abline(h = median(x0sub, na.rm = T))

plot(dates1, x1sub, pch = 20, ylim = rng)
abline(h = median(x1sub, na.rm = T))


# Let's take a average value by state for 1999 and for 2012
# We going to plot and connect two dots for each state for both years.

# Which function would be the most useful for trying to calculate the average 
# value of PM by State for either 1999 or 2012?
# 1) matrix
# 2) tapply
# Correct 
# is selected.This is correct.
# 4) table
# 5) factor

# Let create a mean for each state for 1999 dataset
mn0 <- with(pm0, tapply(Sample.Value, State.Code, mean, na.rm = T))
str(mn0)
# num [1:53(1d)] 19.96 6.67 10.8 15.68 17.66 ...
# - attr(*, "dimnames")=List of 1
# ..$ : chr [1:53] "1" "2" "4" "5" ...

# NOTE: the value 19.96 6.67 10.8 15.68 17.66 
#       are the mean value for each state
summary(mn0)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 4.862   9.519  12.315  12.406  15.640  19.956 
# NOTE: the mean Sample.Value for state range from 4.862 to 19.956

# Do the same for 2012
mn1 <- with(pm1, tapply(Sample.Value, State.Code, mean, na.rm = T))
str(mn1)
# num [1:52(1d)] 10.13 4.75 8.61 10.56 9.28 ...
# - attr(*, "dimnames")=List of 1
# ..$ : chr [1:52] "1" "2" "4" "5" ...

summary(mn1)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 4.006   7.355   8.729   8.759  10.613  11.992 

# Let's create DF from these mn0 and mn1
names(mn0)
# [1] "1"  "2"  "4"  "5"  "6"  "8"  "9"  "10" "11" "12" "13" "15" "16" "17" "18"
# [16] "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33"
# [31] "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48" "49"
# [46] "50" "51" "53" "54" "55" "56" "72" "78"
d0 <- data.frame(state = names(mn0), mean = mn0)
d1 <- data.frame(state = names(mn1), mean = mn1)
head(d0)
# state      mean
# 1     1 19.956391
# 2     2  6.665929
# 4     4 10.795547
# 5     5 15.676067
# 6     6 17.655412
# 8     8  7.533304

head(d1)
# state      mean
# 1     1 10.126190
# 2     2  4.750389
# 4     4  8.609956
# 5     5 10.563636
# 6     6  9.277373
# 8     8  4.117144

# Let merge d0 and d1
mrg <- merge(d0, d1, by = "state")
dim(mrg)
# [1] 52  3
head(mrg)
# state    mean.x    mean.y
# 1     1 19.956391 10.126190
# 2    10 14.492895 11.236059
# 3    11 15.786507 11.991697
# 4    12 11.137139  8.239690
# 5    13 19.943240 11.321364
# 6    15  4.861821  8.749336

# NOTE: mean.x is column is for 1999 Sample.Value mean by state
#       and mean.y is corespond to the 2012 data value

# setup 
par(mfrow = c(1,1))
# plot 1999 data xlim x-exel limit 1998 - 2013
# NOTE: mrg has 3 columns, state mean.x and mean.y
with(mrg, plot(rep(1999, 52), mrg[,2], xlim = c(1998, 2013)))
# Now, don't plot but just add points (2012 data) to the graph
# rep(2012,52) - create 2012 repeat 52 time because we have
# 52 data points for mean.x and mean.y
with(mrg, points(rep(2012, 52), mrg[,3]))
# Let's connect the dots for each state from 1999 and 2012 dataframes
segments(rep(1999, 52), mrg[,2], rep(2012, 52), mrg[,3])

