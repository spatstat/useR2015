#'      Tutorial on analysing spatial point patterns with spatstat
#'                  useR! conference 2015
#' 
#'                   Lecturer's R script 
#'          Session 1: Data types and basic techniques
#' 
#'         Copyright (c) Adrian Baddeley and Ege Rubak 2015
#' 
library(spatstat)
#' example of a point pattern
plot(bei)
#' [Discuss purposes of analysis]
#' what is 'bei'
bei
class(bei)
#' bei is an object of class 'ppp' (planar point pattern)
plot(bei)
#' plot is a 'generic' R function which does something sensible for any data.
#' For an object X of class 'ppp',
#' the command plot(X) is 'dispatched' as plot.ppp(X)
help(plot.ppp)
plot(bei, cols="blue")
plot(bei, chars=".")
#' web style help display - recommended
help.start()
help(plot.ppp)
#' Read The Help Files!
help(bei)

#' A point pattern has a 'window'
Window(bei)
W <- Window(bei)
class(W)
plot(chorley)
Window(chorley)
#' owin objects can be created & manipulated
square(2)

#' basic analysis of a point pattern
summary(bei)
#' dispatched to summary.ppp
intensity(bei)
#' [Discuss concept of intensity; dimensions]

plot(swedishpines)
swp <- swedishpines
#' Possible spatial variation in forest density
a <- quadratcount(swp, 3, 3)
a
plot(a)
#' object of a class that can be both printed and plotted.
#'
plot(swp)
plot(a, add=TRUE, col="red")
#'
#'
#' For homogeneous pattern, numbers should be **approximately* equal
#' Apply chi^2 test
quadrat.test(swp, 3, 3)
#' [Interpret]

b4 <- quadrat.test(bei, 4, 2)
b4
plot(bei, chars=".")
plot(b4, add=TRUE, col="blue")
#' test result can also be plotted

plot(q8 <- quadratcount(bei, 8, 4))
plot(q16 <- quadratcount(bei, 16, 8))

plot(intensity(q8, image=TRUE))
plot(intensity(q16, image=TRUE))
#' [concept of intensity function]

plot(density(bei))
Z <- density(bei)
#' density() is generic, with a method density.ppp()
#' [explain kernel smoothing]
Z
class(Z)
#' Pixel image 
plot(Z)
contour(Z)
persp(Z, theta=-30)
persp(Z, theta=-50, phi=20, border=NA, col="yellow", shade=0.7, apron=TRUE)
contour(Z)
#' intensity : points per unit area

plot(density(bei, sigma=100))
plot(density(bei, sigma=10))
#' bandwidth selection
bw.scott(bei)
bw.diggle(bei)
bop <- bw.diggle(bei)
bop
plot(bop)
plot(density(bei, sigma=bw.scott(bei)))
plot(density(bei, sigma=bw.scott))

