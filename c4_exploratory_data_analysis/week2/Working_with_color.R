pal <- colorRamp(c("red", "blue"))
pal(0)
# [,1] [,2] [,3]
# [1,]  255    0    0

pal(1)
# [,1] [,2] [,3]
# [1,]    0    0  255

pal(.5)
# (127.5,0,127.5)

pal(seq(0,1,len=6))
# [,1] [,2] [,3]
# [1,]  255    0    0
# [2,]  204    0   51
# [3,]  153    0  102
# [4,]  102    0  153
# [5,]   51    0  204
# [6,]    0    0  255

p1 <- colorRampPalette(c("red","blue"))
p1(2)
# [1] "#FF0000" "#0000FF"

p1(6)
# [1] "#FF0000" "#CC0033" "#990066" "#650099" "#3200CC" "#0000FF"

0xcc
# [1] 204

p2 <- colorRampPalette(c("red", "yellow"))
p2(2)
# [1] "#FF0000" "#FFFF00"

p2(10)
# [1] "#FF0000" "#FF1C00" "#FF3800" "#FF5500" "#FF7100" "#FF8D00" "#FFAA00" "#FFC600" "#FFE200" "#FFFF00"

showMe <- 
function(cv){
  myarg <- deparse(substitute(cv))
  z<- outer( 1:20,1:20, "+")
  obj<- list( x=1:20,y=1:20,z=z )
  image(obj, col=cv, main=myarg  )
}

showMe(p1(20))
## Here we see a similar display, the colors moving from red to yellow, the base
## colors of our p2 palette. For fun, see what p2(2) looks like using showMe.
showMe(p2(20))
showMe(p2(2))

## We mentioned before that colorRamp (and colorRampPalette) could return a 3 
## or 4 long vector of colors. We saw 3-long vectors returned indicating red, 
## green, and blue intensities. What would the 4th entry be?
## We'll answer this indirectly. First, look at the function p1 that 
## colorRampPalette returned to you. Just type p1 at the command prompt.

p1
# function (n) 
# {
#     x <- ramp(seq.int(0, 1, length.out = n))
#     if (ncol(x) == 4L) 
#         rgb(x[, 1L], x[, 2L], x[, 3L], x[, 4L], maxColorValue = 255)
#     else rgb(x[, 1L], x[, 2L], x[, 3L], maxColorValue = 255)
# }
# <bytecode: 0x7fc7aa0832b0>
# <environment: 0x7fc7b05314d8>

## The heart of p1 is really the call to the function rgb with either 4 or 5 
## arguments. Use the ?fun construct to look at the R documentation for rgb now

## Create the function p3 now by calling colorRampPalette
## with the colors blue and green (remember to concatenate them into a single 
## argument) and setting the alpha argument to .5.
p3 <- colorRampPalette(c("blue", "green"), alpha = .5)

p3(5)
# [1] "#0000FFFF" "#003FBFFF" "#007F7FFF" "#00BF3FFF" "#00FF00FF"

## We generated 1000 random normal pairs for you in the variables x and y. 
## We'll plot them in a scatterplot by calling plot with 4 arguments. 
## The variables x and y are the first 2. The third is the print character
## argument pch. Set this equal to 19 (filled circles). The final argument 
## is col which should be set equal to a call to rgb. Give rgb 3 
## arguments, 0, .5, and .5.
plot(x,y,pch=19, col=rgb(0,.5,.5))


## Well this picture is okay for a scatterplot, a nice mix of blue and green, 
## but it really doesn't tell us too much information in the center portion, 
## since the points are so thick there. We see there are a lot of points,
## but is one area more filled than another? We can't really discriminate 
## between different point densities. This is where the alpha argument can 
## help us. Recall your plot command (use the up arrow) and add a 4th argument,
## .3, to the call to rgb. This will be our value for alpha.
plot(x,y,pch=19, col=rgb(0,.5,.5,.3))

## Our last topic for this lesson is the RColorBrewer Package, available 
## on CRAN, that contains interesting and useful color palettes, of which 
## there are 3 types, sequential, divergent, and qualitative. Which one 
## you would choose to use depends on your data.

## These colorBrewer palettes can be used in conjunction with the colorRamp() 
## and colorRampPalette() functions. You would use colors from a colorBrewer 
## palette as your base palette,i.e., as arguments to colorRamp or
## colorRampPalette which would interpolate them to create new colors.

## As an example of this, create a new object, cols by calling the function 
## brewer.pal with 2 arguments, 3 and "BuGn". The string "BuGn" is the 
## second last palette in the sequential display. The 3 tells the 
## function how many different colors we want.
cols <- brewer.pal(3, "BuGn")
showMe(cols)

## We see 3 colors, mixes of blue and green. Now create the variable pal by 
## calling colorRampPalette with cols as its argument.
pal <- colorRampPalette(cols)

showMe(pal(3))

##l The call showMe(pal(3)) would be identical to the showMe(cols) call. 
## So use showMe to look at pal(20)
showMe(pal(20))

## Now we can use the colors in pal(20) to display topographic information 
## on Auckland's Maunga Whau Volcano. R provides this information in a 
## matrix called volcano which is included in the package datasets.  Call the R
## function image with volcano as its first argument and col set equal to 
## pal(20) as its second.

pal(20)
# [1] "#E5F5F9" "#DDF1F3" "#D5EEEE" "#CDEBE9" "#C5E8E4" "#BDE5DF" "#B5E2DA" "#ADDFD5" "#A4DCD0" "#9DD9CB" "#93D5C3"
# [12] "#87CFB8" "#7CC9AD" "#70C4A1" "#65BE96" "#59B88B" "#4EB380" "#42AD75" "#37A76A" "#2CA25F"


image(volcano, col = pal(20)) 
## We see that the colors here of the sequential palette clue us in on the 
## topography. The darker colors are more concentrated than the lighter ones. 
## Just for fun, recall your last command calling image and instead of pal(20),
## use p1(20) as the second argument.
image(volcano, col = p1(20)) 

## True or False? Careful use of colors in plots/maps/etc. can make it easier 
## for the reader to understand what points you're trying to convey.

# 1: False
# 2: True
# 
# Selection: 2

## Which of the following is an R package that provides color palettes for 
## sequential, categorical, and diverging data?
  
# 1: RColorVintner
# 2: RColorBrewer
# 3: RColorBluer
# 4: RColorStewer

# Ans: 2: RColorBrewer

# True or False? The colorRamp and colorRampPalette functions can be used 
# in conjunction with color palettes to connect data to colors.
# 
# 1: True
# 2: False
# 
# Selection: 1

# True or False?  Transparency can NEVER be used to clarify plots with many points
# 
# 1: False
# 2: True
# 
# Selection: 1

# True or False?  The call p7 <- colorRamp("red","blue") would work (i.e., 
# not generate an error).
# 
# 1: True
# 2: False
# 
# Selection: 2
# 
# True or False?  The function colors returns only 10 colors. It return 600+
# 
# 1: True
# 2: False
# 
# Selection: 2
# 
# Transparency is determined by which parameter of the rgb function?
#   
# 1: delta
# 2: alpha
# 3: it's all Greek to me
# 4: beta
# 5: gamma
# 
# Selection: 2



