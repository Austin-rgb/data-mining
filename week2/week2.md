---
title: "??? Introduction to data visualizations in R ???"
author: "Akanksha Garlapati"
date: "2024-09-09"
output:
  word_document: 
    toc: true
    fig_caption: true
    keep_md: true
    fig_width: 7
    fig_height: 5.5
  pdf_document: default
  html_document: 
    toc: true
    fig_caption: true
    number_sections: true
---

# Introduction to data visualizations in R

## Loading packages and datasets


``` r
library (tidyverse)
```

```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.4     ✔ readr     2.1.5
## ✔ forcats   1.0.0     ✔ stringr   1.5.1
## ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
## ✔ lubridate 1.9.3     ✔ tidyr     1.3.1
## ✔ purrr     1.0.2     
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

``` r
library (modeldata)

library(readxl)
my_dataset <- read_excel("Animals_and_share _of_US_adults.xlsx")
View(my_dataset)
```

## Using scatter plot

We specify dataset to be plotted in ggplot, and the variables and other aesthetics in aes


``` r
ggplot(my_dataset, aes(x=Male,
    y=Female))
```

![](week2_files/figure-docx/unnamed-chunk-2-1.png)<!-- -->

We the add the specification for the type of plot with geom\_\*


``` r
ggplot (my_dataset, aes(x=Male,
    y = Female ))+
    geom_point()
```

![](week2_files/figure-docx/unnamed-chunk-3-1.png)<!-- -->

We can then add other things like labels


``` r
ggplot (my_dataset, aes(x = Male,
    y = Female ))+
    geom_point()+
    labs(x="Male",
        y="Female ",
        title="Cricket Chips",
        caption= "Source: Mcdonald (2009)")
```

![](week2_files/figure-docx/unnamed-chunk-4-1.png)<!-- -->

### Specifying other aesthetics

Add color with a variable


``` r
ggplot (my_dataset, aes(x=Male,
    y=Female,
    color=Animal ))+
    geom_point()+
    labs(x="Male",
        y="Female",
        title="Cricket Chips",
        caption= "Source: Mcdonald (2009)")
```

![](week2_files/figure-docx/unnamed-chunk-5-1.png)<!-- -->

Label color labels


``` r
ggplot (my_dataset, aes(x=Male,
    y=Female,
    color =Animal))+
    geom_point()+
    labs(x="Male",
        y="Female",
        color="Animal",
        title="Cricket Chips",
        caption= "Source: Mcdonald (2009)")
```

![](week2_files/figure-docx/unnamed-chunk-6-1.png)<!-- -->

Add color scaling


``` r
ggplot (my_dataset, aes(x=Male,
    y=Female,
    color =Animal))+
    geom_point()+
    labs(x="Male",
        y="Female",
        color="Animal",
        title="Cricket Chips",
        caption= "Source: Mcdonald (2009)")
```

![](week2_files/figure-docx/unnamed-chunk-7-1.png)<!-- -->

``` r
        #  not found: # soace_color_brewer(palette="Dark2")
```

### Modifying basic properties

Change plot color


``` r
ggplot (my_dataset, aes(x=Male,
    y=Female,
    color =Animal))+
    geom_point(color="Red")+
    labs(x="Male",
        y="Female",
        color="Animal",
        title="Cricket Chips",
        caption= "Source: Mcdonald (2009)")
```

![](week2_files/figure-docx/unnamed-chunk-8-1.png)<!-- -->

``` r
        # soace_color_brewer(palette="Dark2")
```

change plot size


``` r
ggplot (my_dataset, aes(x=Male,y=Female,color =Animal))+
    geom_point(size=2)+
    labs(x="Male",
        y="Female",
        color="Animal",
        title="Cricket Chips",
        caption= "Source: Mcdonald (2009)")
```

![](week2_files/figure-docx/unnamed-chunk-9-1.png)<!-- -->

``` r
        # soace_color_brewer(palette="Dark2")
```

Adding another plot layer


``` r
ggplot (my_dataset, aes(x=Male,
    y=Female,
    color =Animal))+
    geom_point()+
    geom_smooth()+
    labs(x="Male",
        y="Female",
        color="Animal",
        title="Cricket Chips",
        caption= "Source: Mcdonald (2009)")
```

```
## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

![](week2_files/figure-docx/unnamed-chunk-10-1.png)<!-- -->

``` r
    # soace_color_brewer(palette="Dark2")
```

Add geom_smooth method


``` r
ggplot (my_dataset, aes(x=Male,
    y=Female,
    color =Animal))+
    geom_point()+
    geom_smooth(method="lm")+
    labs(x="Male",
        y="Female",
        color="Animal",
        title="Cricket Chips",
        caption= "Source: Mcdonald (2009)")
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](week2_files/figure-docx/unnamed-chunk-11-1.png)<!-- -->

``` r
    # soace_color_brewer(palette="Dark2")
```

Remove geom_smooth error approximation


``` r
ggplot (my_dataset, aes(x=Male,
    y=Female,
    color =Animal))+
    geom_point()+
    geom_smooth(method="lm",
        se=FALSE)+
    labs(x="Male",
        y="Female",
        color="Animal",
        title="Cricket Chips",
        caption= "Source: Mcdonald (2009)")
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](week2_files/figure-docx/unnamed-chunk-12-1.png)<!-- -->

``` r
    # soace_color_brewer(palette="Dark2")
```

## Other plots

### Histogram


``` r
ggplot (my_dataset, aes(x=Male,
    color =Animal))+
    geom_histogram()
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![](week2_files/figure-docx/unnamed-chunk-13-1.png)<!-- -->

Modifying Histogram bins


``` r
ggplot (my_dataset, aes(x=Male))+
    geom_histogram(bins=15)
```

![](week2_files/figure-docx/unnamed-chunk-14-1.png)<!-- -->

### Frequency polygon


``` r
ggplot (my_dataset, aes(x=Male))+
    geom_freqpoly(bins=15)
```

![](week2_files/figure-docx/unnamed-chunk-15-1.png)<!-- -->

### Bars


``` r
ggplot (my_dataset, aes(x=Animal))+
    geom_bar(color="black",
        fill="lightblue")
```

![](week2_files/figure-docx/unnamed-chunk-16-1.png)<!-- -->

Coloring with classes


``` r
ggplot (my_dataset, aes(x=Animal,
    fill=Animal))+
    geom_bar()
```

![](week2_files/figure-docx/unnamed-chunk-17-1.png)<!-- -->

``` r
    # soace_fill_brewer(palette="Dark2")
```

Remove legend


``` r
ggplot (my_dataset, aes(x=Animal,
    fill=Animal))+
    geom_bar()
```

![](week2_files/figure-docx/unnamed-chunk-18-1.png)<!-- -->

``` r
    # soace_fill_brewer(palette="Dark2")
```

### Box plot


``` r
ggplot (my_dataset, aes(x=Animal,y=Female))+
    geom_boxplot()
```

![](week2_files/figure-docx/unnamed-chunk-19-1.png)<!-- -->

``` r
    # soace_fill_brewer(palette="Dark2")
```

## Faceting


``` r
ggplot (my_dataset, aes(x=Male))+
    geom_histogram(bins=15)+
    facet_wrap(~Animal)
```

![](week2_files/figure-docx/unnamed-chunk-20-1.png)<!-- -->

``` r
    # soace_fill_brewer(palette="Dark2")
```
