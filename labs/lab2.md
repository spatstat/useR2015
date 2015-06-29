---
title: 'Lab 2: Summary functions and simulation envelopes'
---

```{r, include = FALSE}
# This option turns evaluation of R code off in this document. Remove it
# if you use it as a template for solving the lab exercise.
knitr::opts_chunk$set(eval = FALSE)
```

This session is concerned with summary statistics for interpoint
correlation (i.e. dependence between points).  
This session is concerned with evelopes of summary statistics and Monte Carlo tests.  
The lecturer's R script is [available here](https://raw.githubusercontent.com/spatstat/useR2015/master/Scripts/script2.R) (right click and save).

```{r include=FALSE}
library(spatstat)
```

### Exercise 1

The `swedishpines` dataset was recorded in a study plot
in a large forest. We shall assume the pattern is stationary.

1.  Calculate the estimate of the $K$-function using `Kest`.

2.  Plot $\widehat K(r)$ against $r$

3.  Plot $\widehat K(r) - \pi r^2$ against $r$.

4.  Calculate the estimate of the $L$-function and plot it against
    $r$.

5.  Plot $\widehat L(r) - r$ against $r$.

6.  Calculate and plot an estimate of the pair correlation function
    using `pcf`.

7.  Draw tentative conclusions from these plots about interpoint
    interaction in the data.

### Exercise 2

For the `swedishpines` data:

1.  Plot the $K$ function along with pointwise envelopes from 39
    simulations of CSR:
    ```{r}
    plot(envelope(swedishpines, Kest, nsim=39))
    ```

2.  Plot the $L$ function along with pointwise envelopes from 39
    simulations of CSR.

3.  Plot the $L$ function along with **simultaneous**
    envelopes from **19** simulations of CSR, using
    `ginterval=c(0,0.5)`.

4.  Plot the $L$ function for along with
    **simultaneous** envelopes from **99**
    simulations of CSR using `ginterval=c(0,0.5)`. What
    is the significance level of the associated test?

