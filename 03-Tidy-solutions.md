Tidy Data (solutions)
================

<!-- This file by Charlotte Wickham is licensed under a Creative Commons Attribution 4.0 International License, adapted from the orignal work at https://github.com/rstudio/master-the-tidyverse by RStudio. -->
``` r
library(tidyverse)

# Toy data
cases <- tribble(
  ~Country, ~"2011", ~"2012", ~"2013",
      "FR",    7000,    6900,    7000,
      "DE",    5800,    6000,    6200,
      "US",   15000,   14000,   13000
)

pollution <- tribble(
       ~city,   ~size, ~amount,
  "New York", "large",      23,
  "New York", "small",      14,
    "London", "large",      22,
    "London", "small",      16,
   "Beijing", "large",     121,
   "Beijing", "small",     121
)


bp_systolic <- tribble(
  ~ subject_id,  ~ time_1, ~ time_2, ~ time_3,
             1,       120,      118,      121,
             2,       125,      131,       NA,
             3,       141,       NA,       NA 
)

bp_systolic2 <- tribble(
  ~ subject_id,  ~ time, ~ systolic,
             1,       1,        120,
             1,       2,        118,
             1,       3,        121,
             2,       1,        125,
             2,       2,        131,
             3,       1,        141
)
```

Tidy and untidy data
--------------------

`table1` is tidy:

``` r
table1 
```

    ## # A tibble: 6 x 4
    ##   country      year  cases population
    ##   <chr>       <int>  <int>      <int>
    ## 1 Afghanistan  1999    745   19987071
    ## 2 Afghanistan  2000   2666   20595360
    ## 3 Brazil       1999  37737  172006362
    ## 4 Brazil       2000  80488  174504898
    ## 5 China        1999 212258 1272915272
    ## 6 China        2000 213766 1280428583

For example, it's easy to add a rate column with `mutate()`:

``` r
table1 %>%
  mutate(rate = cases/population)
```

    ## # A tibble: 6 x 5
    ##   country      year  cases population      rate
    ##   <chr>       <int>  <int>      <int>     <dbl>
    ## 1 Afghanistan  1999    745   19987071 0.0000373
    ## 2 Afghanistan  2000   2666   20595360 0.000129 
    ## 3 Brazil       1999  37737  172006362 0.000219 
    ## 4 Brazil       2000  80488  174504898 0.000461 
    ## 5 China        1999 212258 1272915272 0.000167 
    ## 6 China        2000 213766 1280428583 0.000167

`table2` isn't tidy, the count column really contains two variables:

``` r
table2
```

    ## # A tibble: 12 x 4
    ##    country      year type            count
    ##    <chr>       <int> <chr>           <int>
    ##  1 Afghanistan  1999 cases             745
    ##  2 Afghanistan  1999 population   19987071
    ##  3 Afghanistan  2000 cases            2666
    ##  4 Afghanistan  2000 population   20595360
    ##  5 Brazil       1999 cases           37737
    ##  6 Brazil       1999 population  172006362
    ##  7 Brazil       2000 cases           80488
    ##  8 Brazil       2000 population  174504898
    ##  9 China        1999 cases          212258
    ## 10 China        1999 population 1272915272
    ## 11 China        2000 cases          213766
    ## 12 China        2000 population 1280428583

It makes it very hard to manipulate.

Your Turn 1
-----------

Is `bp_systolic` tidy?

``` r
bp_systolic2 
```

    ## # A tibble: 6 x 3
    ##   subject_id  time systolic
    ##        <dbl> <dbl>    <dbl>
    ## 1       1.00  1.00      120
    ## 2       1.00  2.00      118
    ## 3       1.00  3.00      121
    ## 4       2.00  1.00      125
    ## 5       2.00  2.00      131
    ## 6       3.00  1.00      141

Your Turn 2
-----------

Using `bp_systolic2` with `group_by()`, and `summarise()`:

-   Find the average systolic blood pressure for each subject
-   Find the last time each subject was measured

``` r
bp_systolic2 %>% 
  group_by(subject_id) %>%
  summarise(avg_bp = mean(systolic),
    last_time = max(time))
```

    ## # A tibble: 3 x 3
    ##   subject_id avg_bp last_time
    ##        <dbl>  <dbl>     <dbl>
    ## 1       1.00    120      3.00
    ## 2       2.00    128      2.00
    ## 3       3.00    141      1.00

Your Turn 3
-----------

On a sheet of paper, draw how the cases data set would look if it had the same values grouped into three columns: **country**, **year**, **n**

<table style="width:40%;">
<colgroup>
<col width="19%" />
<col width="9%" />
<col width="11%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">country</th>
<th align="center">year</th>
<th align="center">cases</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Afghanistan</td>
<td align="center">1999</td>
<td align="center">745</td>
</tr>
<tr class="even">
<td align="center">Afghanistan</td>
<td align="center">2000</td>
<td align="center">2666</td>
</tr>
<tr class="odd">
<td align="center">Brazil</td>
<td align="center">1999</td>
<td align="center">37737</td>
</tr>
<tr class="even">
<td align="center">Brazil</td>
<td align="center">2000</td>
<td align="center">80488</td>
</tr>
<tr class="odd">
<td align="center">China</td>
<td align="center">1999</td>
<td align="center">212258</td>
</tr>
<tr class="even">
<td align="center">China</td>
<td align="center">2000</td>
<td align="center">213766</td>
</tr>
</tbody>
</table>

Your Turn 4
-----------

Use `gather()` to reorganize `table4a` into three columns: **country**, **year**, and **cases**.

``` r
table4a %>%
  gather(key = "year", 
    value = "cases", -country) %>%
  arrange(country)
```

    ## # A tibble: 6 x 3
    ##   country     year   cases
    ##   <chr>       <chr>  <int>
    ## 1 Afghanistan 1999     745
    ## 2 Afghanistan 2000    2666
    ## 3 Brazil      1999   37737
    ## 4 Brazil      2000   80488
    ## 5 China       1999  212258
    ## 6 China       2000  213766

Your Turn 5
-----------

On a sheet of paper, draw how `pollution` would look if it had the same values grouped into three columns: **city**, **large**, **small**

<table style="width:38%;">
<colgroup>
<col width="15%" />
<col width="11%" />
<col width="11%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">city</th>
<th align="center">large</th>
<th align="center">small</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Beijing</td>
<td align="center">121</td>
<td align="center">121</td>
</tr>
<tr class="even">
<td align="center">London</td>
<td align="center">22</td>
<td align="center">16</td>
</tr>
<tr class="odd">
<td align="center">New York</td>
<td align="center">23</td>
<td align="center">14</td>
</tr>
</tbody>
</table>

Your Turn 6
-----------

Use `spread()` to reorganize `table2` into four columns: **country**, **year**, **cases**, and **population**.

``` r
table2 %>%
  spread(key = type, value = count)
```

    ## # A tibble: 6 x 4
    ##   country      year  cases population
    ## * <chr>       <int>  <int>      <int>
    ## 1 Afghanistan  1999    745   19987071
    ## 2 Afghanistan  2000   2666   20595360
    ## 3 Brazil       1999  37737  172006362
    ## 4 Brazil       2000  80488  174504898
    ## 5 China        1999 212258 1272915272
    ## 6 China        2000 213766 1280428583

------------------------------------------------------------------------

Take Aways
==========

Data comes in many formats but R prefers just one: *tidy data*.

A data set is tidy if and only if:

1.  Every variable is in its own column
2.  Every observation is in its own row
3.  Every value is in its own cell (which follows from the above)

What is a variable and an observation may depend on your immediate goal.
