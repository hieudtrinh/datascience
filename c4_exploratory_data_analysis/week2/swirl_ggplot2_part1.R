library(ggplot2)
## A grammar of graphics represents an abstraction of graphics, that is, 
## a theory of graphics which conceptualizes basic pieces from which you 
## can build new graphics and graphical objects. The goal of the grammar 
## is to “Shorten the distance from mind to page”. From Hadley Wickham's 
## book we learn that

# Recall what you know about R's base plotting system. Which of the following 
# does NOT apply to it?
# 
# 1: Can easily go back once the plot has started (e.g., to adjust margins or 
#    correct a typo)
# 2: It is convenient and mirrors how we think of building plots and analyzing 
#    data
# 3: Use annotation functions to add/modify (text, lines, points, axis)
# 4: Start with plot (or similar) function
# 
# Selection: 1
# 
# Recall what you know about R's lattice plotting system. Which of the following 
# does NOT apply to it?
#   
# 1: Margins and spacing are set automatically because entire plot is specified at once
# 2: Most useful for conditioning types of plots and putting many panels on one plot
# 3: Plots are created with a single function call (xyplot, bwplot, etc.)
# 4: Can always add to the plot once it is created
# Selection: 4
# 
# If we told you that ggplot2 combines the best of base and lattice, that would 
# mean it ...?
#   
# 1: Like lattice it allows for multipanels but more easily and intuitively
# 2: Automatically deals with spacings, text, titles but also allows you to annotate
# 3: Its default mode makes many choices for you (but you can customize!)
# 4: All of the others
# 
# Selection: 4

# The ggplot2 package has 2 workhorse functions. The more basic workhorse 
# function is qplot, (think quick plot), which works like the
# plot function in the base graphics system. It can produce many types 
# of plots (scatter, histograms, box and whisker) while hiding
# tedious details from the user. Similar to lattice functions, it looks 
# for data in a data frame or parent environment.

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


# We see that there are 234 points in the dataset concerning 11 different 
# characteristics of the cars. Suppose we want to see if there's
# a correlation between engine displacement (displ) and highway miles per 
# gallon (hwy). As we did with the plot function of the base
# system we could simply call qplot with 3 arguments, the first two are the 
# variables we want to examine and the third argument data is
# set equal to the name of the dataset which contains them (in this case, mpg). 
# Try this now.

qplot(displ, hwy, data = mpg)


qplot(displ, hwy, data = mpg, color = drv)

# | Now let's add a second geom to the default points. How about some smoothing
# | function to produce trend lines, one for each color? Just add a fifth
# | argument, geom, and using the R function c(), set it equal to the
# | concatenation of the two strings "point" and "smooth". The first refers to the
# | data points and second to the trend lines we want plotted. Try this now.

qplot(displ, hwy, data = mpg, color = drv, geom = c("point", "smooth")) 

# | Before we leave qplot's scatterplotting ability, call qplot again, this time
# | with 3 arguments. The first is y set equal to hwy, the second is data set
# | equal to mpg, and the third is color set equal to drv. Try this now.

qplot(y = hwy, data = mpg, color = drv)

# | What's this plot showing? We see the x-axis ranges from 0 to 250 and we
# | remember that we had 234 data points in our set, so we can infer that each
# | point in the plot represents one of the hwy values (indicated by the y-axis).
# | We've created the vector myhigh for you which contains the hwy data from the
# | mpg dataset. Look at myhigh now.

# | The all-purpose qplot can also create box and whisker plots.  Call qplot now
# | with 4 arguments. First specify the variable by which you'll split the data,
# | in this case drv, then specify the variable which you want to examine, in this
# | case hwy. The third argument is data (set equal to mpg), and the fourth, the
# | geom, set equal to the string "boxplot"
 
qplot(drv, hwy, data = mpg, geom = "boxplot")

# | We see 3 boxes, one for each drive. Now to impress you, call qplot with 5
# | arguments. The first 4 are just as you used previously, (drv, hwy, data set
# | equal to mpg, and geom set equal to the string "boxplot"). Now add a fifth
# | argument, color, equal to manufacturer.

qplot(drv, hwy, data = mpg, geom = "boxplot", color = manufacturer)

# | Now, on to histograms. These display frequency counts for a single variable.
# | Let's start with an easy one. Call qplot with 3 arguments. First specify the
# | variable for which you want the frequency count, in this case hwy, then
# | specify the data (set equal to mpg), and finally, the aesthetic, fill, set
# | equal to drv. Instead of a plain old histogram, this will again use colors to
# | distinguish the 3 different drive factors.
qplot(hwy, data = mpg, fill = drv)

# | We'll do two plots, a scatterplot and then a histogram, each with 3 facets.
# | For the scatterplot, call qplot with 4 arguments. The first two are displ and
# | hwy and the third is the argument data set equal to mpg. The fourth is the
# | argument facets which will be set equal to the expression . ~ drv which is
# | ggplot2's shorthand for number of rows (to the left of the ~) and number of
# | columns (to the right of the ~). Here the . indicates a single row and drv
# | implies 3, since there are 3 distinct drive factors. Try this now.

qplot(displ, hwy, data = mpg, facets = . ~ drv)

# | Now we'll do a histogram, again calling qplot with 4 arguments. This time,
# | since we need only one variable for a histogram, the first is hwy and the
# | second is the argument data set equal to mpg. The third is the argument facets
# | which we'll set equal to the expression drv ~ . . This will give us a
# | different arrangement of the facets. The fourth argument is binwidth. Set this
# | equal to 2. Try this now.
qplot(hwy, data = mpg, facets = drv ~ ., binwidth = 2)

# The facets argument, drv ~ ., resulted in what arrangement of facets?
#   
# 1: 3 by 1
# 2: 1 by 3
# 3: 2 by 2
# 4: huh?
#   
#   Selection: 1

#  Which of the following is a basic workhorse function of ggplot2?
#   
# 1: qplot
# 2: hist
# 3: xyplot
# 4: gplot
# 5: scatterplot
# 
# Selection: 1

# Which types of plot does qplot plot?
#   
# 1: all of the others
# 2: histograms
# 3: box and whisker plots
# 4: scatterplots
# 
# Selection: 1

# What does the gg in ggplot2 stand for?
#   
# 1: goto graphics
# 2: grammar of graphics
# 3: good grief
# 4: good graphics
# 
# Selection: 2

# True or False? The geom argument takes a string for a value.
# 
# 1: True
# 2: False
# 
# Selection: 1

# True or False? The data argument takes a string for a value.
# 
# 1: False
# 2: True
# 
# Selection: 1

# True or False? The binwidth argument takes a string for a value.
# 
# 1: True
# 2: False
# 
# Selection: 2


# True or False? The user must specify x- and y-axis labels when using qplot.
# 
# 1: False
# 2: True
# 
# Selection: 1





