cm007 Exercises: Exploring Aesthetic Mappings
================

Beyond the x and y aesthetics
=============================

Switch focus to exploring aesthetic mappings, instead of geoms.

``` r
library(tidyverse)
```

    ## Warning: package 'tidyverse' was built under R version 3.4.4

    ## -- Attaching packages -------------------------------------------------------------------------------------------- tidyverse 1.2.1 --

    ## √ ggplot2 3.0.0     √ purrr   0.2.5
    ## √ tibble  1.4.1     √ dplyr   0.7.6
    ## √ tidyr   0.8.1     √ stringr 1.2.0
    ## √ readr   1.1.1     √ forcats 0.3.0

    ## Warning: package 'ggplot2' was built under R version 3.4.4

    ## Warning: package 'tidyr' was built under R version 3.4.4

    ## Warning: package 'readr' was built under R version 3.4.4

    ## Warning: package 'purrr' was built under R version 3.4.4

    ## Warning: package 'dplyr' was built under R version 3.4.4

    ## Warning: package 'forcats' was built under R version 3.4.4

    ## -- Conflicts ----------------------------------------------------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(gapminder)
```

    ## Warning: package 'gapminder' was built under R version 3.4.4

Shapes
------

-   Try a scatterplot of `gdpPercap` vs `lifeExp` with a categorical variable (continent) as `shape`.

``` r
gvsl <- ggplot(gapminder,aes(gdpPercap, lifeExp))+
  scale_x_log10()
gvsl +geom_point(aes(shape=continent),alpha=0.2)
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-2-1.png)

-   As with all (?) aesthetics, we can also have them *not* as aesthetics!
    -   Try some shapes: first as integer from 0-24, then as keyboard characters.
    -   What's up with `pch`?

``` r
#can initialize shape not in aes function 
gvsl +geom_point(shape = 6)
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-3-1.png)

``` r
#pch same to shape
gvsl +geom_point(pch=6)
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-3-2.png)

``` r
# can also use any symbol inside quotation marks
gvsl +geom_point(shape="$")
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-3-3.png)

List of shapes can be found [at the bottom of the `scale_shape` documentation](https://ggplot2.tidyverse.org/reference/scale_shape.html).

Colour
------

Make a scatterplot. Then:

-   Try colour as categorical variable.

``` r
# use different colour to category
gvsl + geom_point(aes(colour=continent))
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-4-1.png)

-   Try `colour` and `color`.
-   Try colour as numeric variable.
    -   Try `trans="log10"` for log scale.

``` r
gvsl +geom_point(aes(color =pop)) + scale_color_continuous(trans="log10")
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-5-1.png)

``` r
# ggplot make a new column of segmentation
gvsl + geom_point(aes(color=lifeExp > 60))
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-5-2.png)

Make a line plot of `gdpPercap` over time for all countries. Colour by `lifeExp > 60` (remember that `lifeExp` looks bimodal?)

Try adding colour to a histogram. How is this different?

``` r
ggplot(gapminder, aes(lifeExp))+
  geom_histogram(aes(color=continent))
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-7-1.png)

``` r
ggplot(gapminder, aes(lifeExp))+
  geom_histogram(aes(fill=continent))
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-7-2.png)

Facetting
---------

Make histograms of `gdpPercap` for each continent. Try the `scales` and `ncol` arguments.

``` r
#histogram for each continent
# free of x will not have the same x range
ggplot(gapminder,aes(lifeExp))+
  facet_wrap( ~ continent, scales="free_x")+
  geom_histogram()
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-8-1.png)

Remove Oceania. Add another variable: `lifeExp > 60`.

``` r
# differ through another condition lifeExp>60
ggplot(gapminder, aes(gdpPercap))+
  facet_grid(continent ~ lifeExp > 60)+
  geom_histogram()
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-9-1.png)

Bubble Plots
------------

-   Add a `size` aesthetic to a scatterplot. What about `cex`?

``` r
gvsl + geom_point(aes(size=pop),alpha=0.2)
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-10-1.png)

-   Try adding `scale_radius()` and `scale_size_area()`. What's better?

``` r
gvsl + geom_point(aes(size=pop),alpha=0.2)+
  scale_size_area()
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-11-1.png)

-   Use `shape=21` to distinguish between `fill` (interior) and `colour` (exterior).

``` r
# interior pop,  , exterior continent
gvsl + geom_point(aes(size=pop,fill=continent),shape=21, color="black", alpha=0.2)
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-12-1.png)

"Complete" plot
---------------

Let's try plotting much of the data.

-   gdpPercap vs lifeExp with pop bubbles
-   facet by year
-   colour by continent

``` r
gvsl + geom_point(aes(size=pop, color=continent))+
  scale_size_area() + 
  facet_wrap( ~year)
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-13-1.png)

Continue from last time (geom exploration with `x` and `y` aesthetics)
======================================================================

Path plots
----------

Let's see how Rwanda's life expectancy and GDP per capita have evolved over time, using a path plot.

-   Try `geom_line()`. Try `geom_point()`.

-   Add `arrow=arrow()` option.
-   Add `geom_text`, with year label.

``` r
gapminder %>% 
  filter(country=="Rwanda") %>% 
  arrange(year) %>% 
  ggplot(aes(gdpPercap, lifeExp))+
  #scale_x_log10()+
  geom_point()+
  geom_path(arrow = arrow())
```

    ## Warning: package 'bindrcpp' was built under R version 3.4.4

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-14-1.png)

``` r
# geom_line and geom_path are different , path show exactly the transfer on data
```

Two categorical variables
-------------------------

Try `cyl` (number of cylinders) ~ `am` (transmission) in the `mtcars` data frame.

-   Scatterplot? Jitterplot? No.
-   `geom_count()`.
-   `geom_bin2d()`. Compare with `geom_tile()` with `fill` aes.

``` r
# geom_count, geom_bin2d
ggplot(mtcars, aes(factor(cyl), factor(am)))+
  geom_bin2d()
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-15-1.png)

Overplotting
------------

Try a scatterplot with:

-   Alpha transparency.
-   `geom_hex()`
-   `geom_density2d()`
-   `geom_smooth()`

``` r
#need install hexbin package
gvsl+geom_hex()
```

    ## Warning: package 'hexbin' was built under R version 3.4.4

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-16-1.png)

``` r
gvsl +geom_density2d()
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-16-2.png)

``` r
gvsl+geom_point(alpha=0.1)+geom_smooth(method = "lm")
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-16-3.png)

Bar plots
---------

How many countries are in each continent? Use the year 2007.

1.  After filtering the gapminder data to 2007, make a bar chart of the number of countries in each continent. Store everything except the geom in the variable `d`.

``` r
gapminder %>% 
  filter(year==2007) %>% 
  ggplot(aes(x=continent))+
  geom_bar()
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-17-1.png)

1.  Notice the y-axis. Oddly, `ggplot2` doesn't make it obvious how to change to proportion. Try adding a `y` aesthetic: `y=..count../sum(..count..)`.

**Uses of bar plots**: Get a sense of relative quantities of categories, or see the probability mass function of a categorical random variable.

Polar coordinates
-----------------

-   Add `coord_polar()` to a scatterplot.

``` r
gvsl+geom_point()+coord_polar()
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-18-1.png)

Want more practice?
===================

If you'd like some practice, give these exercises a try

**Exercise 1**: Make a plot of `year` (x) vs `lifeExp` (y), with points coloured by continent. Then, to that same plot, fit a straight regression line to each continent, without the error bars. If you can, try piping the data frame into the `ggplot` function.

``` r
ggplot(gapminder, aes(year, lifeExp,color=continent))+
  geom_point()+
  geom_smooth(method = "lm", se=FALSE)
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-19-1.png)

**Exercise 2**: Repeat Exercise 1, but switch the *regression line* and *geom\_point* layers. How is this plot different from that of Exercise 1?

``` r
ggplot(gapminder, aes(year, lifeExp,color=continent))+
  geom_smooth(method = "lm", se=FALSE)+
  geom_point()
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-20-1.png)

**Exercise 3**: Omit the `geom_point` layer from either of the above two plots (it doesn't matter which). Does the line still show up, even though the data aren't shown? Why or why not?

``` r
ggplot(gapminder, aes(year, lifeExp,color=continent))+
  geom_smooth(method = "lm", se=FALSE)
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-21-1.png)

**Exercise 4**: Make a plot of `year` (x) vs `lifeExp` (y), facetted by continent. Then, fit a smoother through the data for each continent, without the error bars. Choose a span that you feel is appropriate.

``` r
ggplot(gapminder, aes(year, lifeExp))+
  facet_wrap( ~continent)+
  geom_point()+
  geom_smooth(method = "lm", se=FALSE)
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-22-1.png)

**Exercise 5**: Plot the population over time (year) using lines, so that each country has its own line. Colour by `gdpPercap`. Add alpha transparency to your liking.

``` r
ggplot(gapminder, aes(year, pop, color=gdpPercap))+
  geom_line(aes(group=country),alpha=0.2)
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-23-1.png)

**Exercise 6**: Add points to the plot in Exercise 5.

``` r
ggplot(gapminder, aes(year, pop, color=gdpPercap))+
  geom_line(aes(group=country),alpha=0.2)+
  geom_point()
```

![](cm007-exercise_files/figure-markdown_github/unnamed-chunk-24-1.png)
