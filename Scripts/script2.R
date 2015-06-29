#'      Tutorial on analysing spatial point patterns with spatstat
#'                  useR! conference 2015
#' 
#'                   Lecturer's R script 
#'       Session 2: Summary functions and simulation envelopes
#' 
#'         Copyright (c) Adrian Baddeley and Ege Rubak 2015
#' 
library(spatstat)

set.seed(42)
inde <- rpoispp(100)
regu <- rSSI(0.09, 70)
clus <- rMatClust(30, 0.05, 4)

plot(regu)
plot(inde)
plot(clus)

plot(Kest(regu))
Kest(regu)

#' [resize window to 3 x 2]
par0 <- par(mfrow=c(2,3), mar=0.3+c(4,4,1,1))
plot(regu)
plot(inde)
plot(clus)
plot(Kest(regu))
plot(Kest(inde))
plot(Kest(clus))
par23x <- par(par0)

K <- Kest(regu)
plot(K, . ~ r)
plot(K, iso ~ r)
plot(K, . - theo ~ r)
plot(K, sqrt(./pi) ~ r)

plot(Lest(regu))
par(par23x)
plot(Lest(regu))
plot(Lest(inde))
plot(Lest(clus))
par(par0)

plot(Kest(clus), cbind(iso,theo) ~ r, lwd=2)
plot(Kest(rpoispp(ex=clus)), iso ~ r, add=TRUE)
for(i in 1:10) plot(Kest(rpoispp(ex=clus)), iso ~ r, add=TRUE)

plot(envelope(clus, Kest, nsim=19))

pats <- rpoispp(ex=clus, nsim=19)
pats[[20]] <- clus
plot(pats, main.panel="", pch=3)

clarkevans(clus)
clarkevans(clus, correction="D")
ce <- sapply(pats, clarkevans, correction="D")
mean(ce[20] >= ce)

plot(envelope(clus, Kest, nsim=39))

plot(envelope(clus, Lest, nsim=39))

plot(envelope(clus, Lest, nsim=19, global=TRUE))

mad.test(clus, Lest, nsim=19)

dclf.test(clus, Lest, nsim=19)

