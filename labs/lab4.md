---
title: 'Lab 4: Cluster, Cox and Gibbs models'
---

```{r, include = FALSE}
# This option turns evaluation of R code off in this document. Remove it
# if you use it as a template for solving the lab exercise.
knitr::opts_chunk$set(eval = FALSE)
```

This session is concerned with summary statistics for interpoint
spacing and distances.  
The lecturer's R script is [available here](https://raw.githubusercontent.com/spatstat/useR2015/master/Scripts/script4.R) (right click and save).

```{r include=FALSE}
library(spatstat)
```

### Exercise 1

The command `rThomas` generates simulated realisations of
the Thomas model (‘modified Thomas cluster process’).

1.  Read the help file.

2.  Type `plot(rThomas(10, 0.05, 8))` a few times, and
    interpret the results.

3.  Experiment with the arguments of `rThomas` to obtain
    point patterns that
    1.  consist of a few, well-separated, very tight clusters of
        points;
    2.  look similar to realisations of a uniform Poisson process.


### Exercise 2

1.  Read the help file for `kppm`.

2.  Fit the Thomas model to the `redwood` data by the
    method of minimum contrast:
    ```{r}
    fit <- kppm(redwood ~ 1, clusters="Thomas")
    fit
    plot(fit)
    ```

3.  Read off the parameters of the fitted model, and generate a
    simulated realisation of the fitted model using `rThomas`.

4.  Type `plot(simulate(fit))` to generate a simulated realisation
    of the fitted model automatically.

5.  Try the command
    ```{r}
    fit2 <- kppm(redwood ~ 1, clusters="Thomas", startpar=c(kappa=10, scale=0.1))
    ```
    and briefly explore the fitting algorithm’s sensitivity to the
    initial guesses at the parameter values `kappa` and `scale`.

6.  Generate and plot several simulated realisations of the fitted
    model, to assess whether it is plausible.

7.  Extract and plot the fitted pair correlation function by
    ```{r}
    pcffit <- pcfmodel(fit)
    plot(pcffit, xlim = c(0, 0.3))
    ```

8.  Type `plot(envelope(fit, Lest, nsim=39))` to generate simulation
    envelopes of the $L$ function from this fitted model. Do they
    suggest the model is plausible?


### Exercise 3

1.  Fit a Matern cluster process to the `redwood` data.

2.  Use `vcov` to estimate the covariance matrix of the parameter estimates.

3.  Compare with the covariance matrix obtained when fitting a homogeneous Poisson model.

### Exercise 4

In this exercise we fit a Strauss point process model to
the `swedishpines` data.

1.  We need a guess at the interaction distance $R$. Compute and
    plot the $L$-function of the dataset and choose the value $r$
    which maximises the discrepancy $|L(r)-r|$.

2.  Fit the stationary Strauss model with the chosen interaction
    distance using
    ```{r}
    ppm(swedishpines ~ 1, Strauss(R))
    ```
    where `R` is your chosen value.

    3.  Interpret the printout: how strong is the interaction?

    4.  Plot the fitted pairwise interaction function using
        `plot(fitin(fit))`.

### Exercise 5

In Exercise 4 we guesstimated the Strauss interaction distance 
parameter. Alternatively this parameter could be estimated by 
profile pseudolikelihood.

1.  Look again at the plot of the $L$-function of
    `swedishpines` and determine a plausible range of
    possible values for the interaction distance.

2.  Generate a sequence of values equally spaced across this range,
    for example, if your range of plausible values was
    $[0.05, 0.3]$, then type
    ```{r}
    rvals <- seq(0.05, 0.3, by=0.01)
    ```

3.  Construct a data frame, with one column named `r`
    (matching the argument name of `Strauss`), containing
    these values. For example
    ```{r}
    D <- data.frame(r = rvals)
    ```

4.  Execute
    ```{r}
    fitp <- profilepl(D, Strauss, swedishpines ~ 1)
    ```
    to find the maximum profile pseudolikelihood fit.

5.  Print and plot the object `fitp`.

6.  Compare the computed estimate of interaction distance $r$ with
    your guesstimate. Compare the corresponding estimates of the
    Strauss interaction parameter $\gamma$.

7.  Extract the fitted Gibbs point process model from the object
    `fitp` as 
    ```{r}
    bestfit <- as.ppm(fitp)
    ```

### Exercise 6

For the Strauss model fitted in Exercise 4,

1.  Generate and plot a simulated realisation of the fitted model
    using `simulate`.

2.  Plot the $L$-function of the data along with the global
    simulation envelopes from 19 realisations of the fitted model.


### Exercise 7

1.  Read the help file for `Geyer`.

2.  Fit a stationary Geyer saturation process to `swedishpines`, with the 
    same interaction distance as for the Strauss model computed in Question 2,
    and trying different values of the saturation parameter `sat = 1, 2, 3` say.

3.  Fit the same model with the addition of a log-quadratic trend.

4.  Plot the fitted trend and conditional intensity.

### Exercise 8

Modify Exercise 4 by using the Huang-Ogata approximate
maximum likelihood algorithm (`method="ho"`) instead of maximum
pseudolikelihood (the default, `method="mpl"`).

### Exercise 9

Repeat Exercise 5 for the inhomogeneous Strauss process with
log-quadratic trend. The corresponding call to `profilepl` is
```{r}
fitp <- profilepl(D, Strauss, swedishpines ~ polynom(x,y,2))
```
    
### Exercise 10

Repeat Exercise 6 for the inhomogeneous Strauss process with
log-quadratic trend, using the inhomogeneous $L$-function `Linhom`
in place of the usual $L$-function.
