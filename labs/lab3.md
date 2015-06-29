---
title: 'Lab 3: Models'
---

```{r, include = FALSE}
# This option turns evaluation of R code off in this document. Remove it
# if you use it as a template for solving the lab exercise.
knitr::opts_chunk$set(eval = FALSE)
```

This session covers tools for investigating the dependence of the
point process intensity on a covariate. They include nonparametric methods
and parametric models.
The lecturer's R script is [available here](https://raw.githubusercontent.com/spatstat/useR2015/master/Scripts/script3.R) (right click and save).

```{r include=FALSE}
library(spatstat)
```


### Exercise 1

The `bei` dataset gives the locations of trees in a survey area with additional
covariate information in a list `bei.extra`.

1.  Assign the elevation covariate to a variable `elev` by typing
    ```{r}
    elev <- bei.extra$elev
    ```

2.  Plot the trees on top of an image of the elevation covariate.

3.  Cut the study region into 4 areas according to the value of the 
    terrain elevation, and make a texture plot of the result.

4.	Convert the image from above to a tesselation, count the number 
    of points in each region using `quadratcount`, and plot the
    quadrat counts.

5.  Estimate the intensity in each of the four regions.


### Exercise 2

Assume that the intensity of trees is a function $\lambda(u) = \rho(e(u))$
where $e(u)$ is the terrain elevation at location u.

1.  Compute a nonparametric estimate of the function $\rho$ and plot it by
    ```{r}
    rh <- rhohat(bei, elev)
    plot(rh)
    ```

2.	Compute the predicted intensity based on this estimate of $\rho$.

3.  Compute a non-parametric estimate by kernel smoothing and
  	compare with the predicted intensity above.

4.  Bonus info: To plot the two intensity estimates next to each
  	other you collect the estimates as a spatial object list
  	(`solist`) and plot the result (the estimates are called
  	`pred` and `ker` below):
    ```{r}
    l <- solist(pred, ker)
    plot(l, equal.ribbon = TRUE, main = "", 
         main.panel = c("rhohat prediction", "kernel smoothing"))
    ```


### Exercise 3

Continuing with the dataset `bei` conduct both Berman's Z1 and Z2 tests for
dependence on `elev`, and plot the results.

### Exercise 4

The command `rpoispp(100)` generates realisations of the
Poisson process with intensity $\lambda = 100$ in the unit square.

1.  Repeat the command `plot(rpoispp(100))` several times
    to build your intuition about the appearance of a completely
    random pattern of points.

2.  Try the same thing with intensity $\lambda = 1.5$.


### Exercise 5

Returning to the Japanese Pines data,

1.  Fit the uniform Poisson point process model to the Japanese
    Pines data
    ```{r}
    ppm(japanesepines~1)
    ```

2.  Read off the fitted intensity. Check that this is the correct
    value of the maximum likelihood estimate of the intensity.

### Exercise 6

The `japanesepines` dataset is believed to exhibit
spatial inhomogeneity.

1.  Plot a kernel smoothed intensity estimate.

2.  Fit the Poisson point process models with loglinear intensity
    (trend formula `~x+y`) and log-quadratic intensity (trend
    formula `~polynom(x,y,2)`) to the Japanese Pines data.

3.  extract the fitted coefficients for these models using
    `coef`.

4.  Plot the fitted model intensity (using `plot(fit)`)

5.  perform the Likelihood Ratio Test for the null hypothesis of a
    loglinear intensity against the alternative of a log-quadratic
    intensity, using `anova`.

6.  Generate 10 simulated realisations of the fitted log-quadratic
    model, and plot them, using `plot(simulate(fit, nsim=10))` where 
    `fit` is the fitted model.


### Exercise 7

The `update` command can be used to re-fit a point
process model using a different model formula.

1.  Type the following commands and interpret the results:
    ```{r}
    fit0 <- ppm(japanesepines ~ 1)
    fit1 <- update(fit0, . ~ x)
    fit1
    fit2 <- update(fit1, . ~ . + y)
    fit2
    ```

2.  Now type `step(fit2)` and interpret the results.
    

### Exercise 8

The `bei` dataset gives the locations of trees in a survey area
with additional covariate information in a list `bei.extra`.

1.  Assign both terrain elevation and slope (gradient) sensible names
    ```{r}
    elev <- bei.extra$elev
    grad <- bei.extra$grad
    ```

2.  Fit a Poisson point process model to the data which assumes
    that the intensity is a loglinear function of terrain slope
    and elevation

3.  Read off the fitted coefficients and write down the fitted
    intensity function.

4.  Plot the fitted intensity as a colour image.

5.  extract the estimated variance-covariance matrix of the
    coefficient estimates, using `vcov`.

6.  Compute and plot the standard error of the intensity estimate
    (see `help(predict.ppm)`).


### Exercise 9

Fit Poisson point process models to the Japanese Pines data, with
the following trend formulas. Read off an expression for the fitted
intensity function in each case.

|Trend formula     |Fitted intensity function                   |
|:-----------------|:-------------------------------------------|
|`~1`              |                                            |
|`~x`              |                                            |
|`~sin(x)`         |                                            |
|`~x+y`            |                                            |
|`~polynom(x,y,2)` |                                            |
|`~factor(x < 0.4)`|                                            |

### Exercise 10

Make image plots of the fitted intensities for the inhomogeneous
models above.
