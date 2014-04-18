Initial Result with IMPLAN data
========================================================

Here are a few functions for working with the IMPLAN data, as well as some simple results. These are now automated to the point that any further use of them takes only a matter of seconds.I'm not sure what the units are for this (I think millions of dollars).


```r
## load data
load("VAdata.Rda")
source("VAfunctions.R")

# function to calc GDP for a given year

getGDP(2008)  #GDP for 2008
```

```
## [1] 14441400
```

```r
getGDP(2011)  #GDP for 2011
```

```
## [1] 15075503
```

```r

## percent GDP change
percentGDPchange(2008, 2009)  #change from 08 to 09
```

```
## [1] -2.232
```

```r
percentGDPchange(2009, 2010)  #change from 09 to 10
```

```
## [1] 2.857
```

```r
percentGDPchange(2008, 2011)  #change from 08 to 11
```

```
## [1] 4.391
```

```r


# function to calc GDP for county for year

getGCP(2282, 2008)  #gross county product for FIPS = 2282
```

```
## [1] 27.57
```

```r


# function to calc GDP for an industry in a county for a given year

getICP(2275, 439, 2008)  #total Value Added for FIPS = 2275, industry = 439
```

```
## [1] 20.43
```

```r

```



