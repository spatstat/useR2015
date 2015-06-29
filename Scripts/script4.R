#'      Tutorial on analysing spatial point patterns with spatstat
#'                  useR! conference 2015
#' 
#'                   Lecturer's R script 
#'          Session 4: cluster, Cox, and Gibbs models
#' 
#'         Copyright (c) Adrian Baddeley and Ege Rubak 2015
#' 
library(spatstat)

set.seed(10)
plot(X <- rMatClust(kappa=4, scale=0.1, mu=10))
plot(attr(X, "parents"), add=TRUE, col="green",pch=16)

plot(rMatClust(4, 0.1, 10, nsim=20))

kppm(X ~ 1, "MatClust")

Z <- rMatClust(30, 0.05, 4)
plot(Z)
kppm(Z ~ 1, "MatClust")

set.seed(1919)
Y <- rThomas(50, 0.03, 10)
plot(Y)
kppm(Y ~ 1, "Thomas")

set.seed(1985)
U <- rnoise(runif, max=200)
V <- Smooth(U, sigma=0.05, normalise=TRUE)
V <- 100 + 7 * (V-100)
plot(V)
plot(rpoispp(V), add=TRUE, pch=16)

X <- rLGCP("exp", 4, var=1.5, scale=0.03)
plot(X)
plot(Kest(X))
plot(Lam <- attr(X, "Lambda"))
plot(log(Lam))
hist(log(Lam))

kppm(X ~ 1, "LGCP", model="exp", statistic="pcf")

set.seed(42)
XX <- rpoispp(10, nsim=20) 
plot(XX)
sapply(XX, minnndist) > 0.1

plot(rHardcore(beta=10, R=0.1, nsim=20))

plot(rHardcore(beta=50, R=0.1, nsim=20))

plot(cells)
ppm(cells ~ 1, Hardcore())

plot(rStrauss(beta=50, gamma=0.5, R=0.1, nsim=20))
plot(rStrauss(beta=50, gamma=0.9, R=0.1, nsim=20))
plot(rStrauss(beta=50, gamma=0.2, R=0.1, nsim=20))

ppm(cells ~ 1, Strauss(0.1))

plot(swedishpines)
plot(density(swedishpines))
fitP <- ppm(swedishpines ~ polynom(x, y, 2))
plot(Kinhom(swedishpines, sigma=bw.scott))
fitS <- ppm(swedishpines ~ polynom(x,y,2), Strauss(9))
anova(fitP, fitS, test="LR")

plot(predict(fitS, type="cif"))
plot(swedishpines, add=TRUE, cols="white", pch=16)

plot(intensity(fitS))
plot(simulate(fitS, nsim=10))

step(fitS)

plot(leverage(fitS))
plot(influence(fitS))

