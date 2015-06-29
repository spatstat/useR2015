---
title: 'Lab 1: Data types and basic techniques'
---

```{r, include = FALSE}
# This option turns evaluation of R code off in this document. Remove it
# if you use it as a template for solving the lab exercise.
knitr::opts_chunk$set(eval = FALSE)
```

This session is about reading in, displaying and summarising point patterns.  
This session covers exploratory tools for investigating intensity.  
The lecturer's R script is [available here](https://raw.githubusercontent.com/spatstat/useR2015/master/Scripts/script1.R) (right click and save).

If you have not already done so, you’ll need to start R and load the `spatstat`
package by typing
```r
library(spatstat)
```

### Exercise 1
We will study a dataset that records the locations of Ponderosa Pine
trees (*Pinus ponderosa*) in a study region in the
Klamath National Forest in northern California. The data are
included with `spatstat` as the dataset `ponderosa`.

1.  assign the data to a shorter name, like `X` or `P`;

2.  plot the data;

3.  find out how many trees are recorded;

4.  find the dimensions of the study region;

5.  obtain an estimate of the average intensity of trees (number of
    trees per unit area).

### Exercise 2

The Ponderosa data, continued:

1.  When you type `plot(ponderosa)`, the command that is
    actually executed is `plot.ppp`, the plot method for
    point patterns. Read the help file for the function
    `plot.ppp`, and find out which argument to the
    function can be used to control the main title for the plot;

2.  plot the Ponderosa data with the title *Ponderosa Pine
    Trees* above it;

3.  from your reading of the help file, predict what will happen if
    we type
    ```{r}
    plot(ponderosa, chars="X", cols="green")
    ```
    then check that your guess was correct;

4.  try different values of the argument `chars`, for
    example, one of the integers 0 to 25, or a letter of the
    alphabet. (Note the difference between `chars=3` and
    `chars="+"`, and the difference between `chars=4` and
    `chars="X"`).

### Exercise 3

The dataset `japanesepines` contains the locations of
Japanese Black Pine trees in a study region.

1.  Plot the `japanesepines` data.

2.  Use the command `quadratcount` to divide the study
    region of the Japanese Pines data into a 3x3 array of
    equal quadrats, and count the number of trees in each quadrat.

3.  Most plotting commands will accept the argument
    `add=TRUE` and interpret it to mean that the plot
    should be drawn over the existing display, without clearing the
    screen beforehand. Use this to plot the Japanese Pines data, and
    superimposed on this, the 3x3 array of quadrats, with
    the quadrat counts also displayed.

4.  Use the command `quadrat.test` to perform the
    $\chi$-square test of CSR on the Japanese Pines data.

5.  Plot the Japanese Pines data, and superimposed on this, the
    3x3 array of quadrats and the observed, expected and
    residual counts. Use the argument `cex` to make the
    numerals larger and `col` to display them in another
    colour.

### Exercise 4

Japanese Pines, continued:

1.  Using `density.ppp`, compute a kernel estimate of the
    spatially-varying intensity function for the Japanese pines
    data, using a Gaussian kernel with standard deviation
    $\sigma=0.1$ units, and store the estimated intensity in an
    object `D` say.

2.  Plot a colour image of the kernel estimate `D`.

3.  Plot a colour image of the kernel estimate `D` with
    the original Japanese Pines data superimposed.

4.  Plot the kernel estimate without the ‘colour ribbon’.

5.  Try the following command
    ```{r}
    persp(D, theta=70, phi=25, shade=0.4)
    ```
    and find the documentation for the arguments `theta`,
    `phi` and `shade`.

