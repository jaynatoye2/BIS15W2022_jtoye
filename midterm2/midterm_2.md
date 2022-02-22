---
title: "BIS 15L Midterm 2"
author: "Jayna Toye"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Be sure to **add your name** to the author header above. You may use any resources to answer these questions (including each other), but you may not post questions to Open Stacks or external help sites. There are 10 total questions.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean! Your plots should use consistent aesthetics throughout.  

This exam is due by **12:00p on Tuesday, February 22**.  


```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
```

```
## ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
## ✓ tibble  3.1.6     ✓ dplyr   1.0.7
## ✓ tidyr   1.1.4     ✓ stringr 1.4.0
## ✓ readr   2.1.1     ✓ forcats 0.5.1
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(janitor)
```

```
## 
## Attaching package: 'janitor'
```

```
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

```r
library(ggthemes)
```


## Gapminder
For this assignment, we are going to use data from  [gapminder](https://www.gapminder.org/). Gapminder includes information about economics, population, social issues, and life expectancy from countries all over the world. We will use three data sets, so please load all three as separate objects.    

1. population_total.csv  
2. income_per_person_gdppercapita_ppp_inflation_adjusted.csv  
3. life_expectancy_years.csv  


```r
population_total <- readr::read_csv("data/population_total.csv") %>%clean_names() #clean_names() to help when mutating a slope
```

```
## Rows: 195 Columns: 302
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr   (1): country
## dbl (301): 1800, 1801, 1802, 1803, 1804, 1805, 1806, 1807, 1808, 1809, 1810,...
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


```r
gdp_data <- readr::read_csv("data/income_per_person_gdppercapita_ppp_inflation_adjusted.csv")%>%clean_names()#clean_names() to help when mutating a slope
```

```
## Rows: 193 Columns: 242
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr   (1): country
## dbl (241): 1800, 1801, 1802, 1803, 1804, 1805, 1806, 1807, 1808, 1809, 1810,...
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
life_expectancy <- readr::read_csv("data/life_expectancy_years.csv") %>%clean_names()#clean_names() to help when mutating a slope
```

```
## Rows: 187 Columns: 302
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr   (1): country
## dbl (301): 1800, 1801, 1802, 1803, 1804, 1805, 1806, 1807, 1808, 1809, 1810,...
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

1. (3 points) Once you have an idea of the structure of the data, please make each data set tidy (hint: think back to pivots) and store them as new objects. You will need both the original (wide) and tidy (long) data!  


```r
gdp_data
```

```
## # A tibble: 193 × 242
##    country     x1800 x1801 x1802 x1803 x1804 x1805 x1806 x1807 x1808 x1809 x1810
##    <chr>       <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
##  1 Afghanistan   603   603   603   603   603   603   603   603   603   603   604
##  2 Albania       667   667   667   667   667   668   668   668   668   668   668
##  3 Algeria       715   716   717   718   719   720   721   722   723   724   725
##  4 Andorra      1200  1200  1200  1200  1210  1210  1210  1210  1220  1220  1220
##  5 Angola        618   620   623   626   628   631   634   637   640   642   645
##  6 Antigua an…   757   757   757   757   757   757   757   758   758   758   758
##  7 Argentina    1640  1640  1650  1650  1660  1660  1670  1680  1680  1690  1690
##  8 Armenia       514   514   514   514   514   514   514   514   514   514   514
##  9 Australia     817   822   826   831   836   841   845   850   855   860   865
## 10 Austria      1850  1850  1860  1870  1880  1880  1890  1900  1910  1920  1920
## # … with 183 more rows, and 230 more variables: x1811 <dbl>, x1812 <dbl>,
## #   x1813 <dbl>, x1814 <dbl>, x1815 <dbl>, x1816 <dbl>, x1817 <dbl>,
## #   x1818 <dbl>, x1819 <dbl>, x1820 <dbl>, x1821 <dbl>, x1822 <dbl>,
## #   x1823 <dbl>, x1824 <dbl>, x1825 <dbl>, x1826 <dbl>, x1827 <dbl>,
## #   x1828 <dbl>, x1829 <dbl>, x1830 <dbl>, x1831 <dbl>, x1832 <dbl>,
## #   x1833 <dbl>, x1834 <dbl>, x1835 <dbl>, x1836 <dbl>, x1837 <dbl>,
## #   x1838 <dbl>, x1839 <dbl>, x1840 <dbl>, x1841 <dbl>, x1842 <dbl>, …
```


```r
gdp_data_tidy <- gdp_data%>%
  pivot_longer(-country, names_to = "year", values_to = "gdp")
gdp_data_tidy
```

```
## # A tibble: 46,513 × 3
##    country     year    gdp
##    <chr>       <chr> <dbl>
##  1 Afghanistan x1800   603
##  2 Afghanistan x1801   603
##  3 Afghanistan x1802   603
##  4 Afghanistan x1803   603
##  5 Afghanistan x1804   603
##  6 Afghanistan x1805   603
##  7 Afghanistan x1806   603
##  8 Afghanistan x1807   603
##  9 Afghanistan x1808   603
## 10 Afghanistan x1809   603
## # … with 46,503 more rows
```


```r
life_expectancy_tidy <- life_expectancy%>%
  pivot_longer(-country, names_to = "year", values_to = "life_exp")
life_expectancy_tidy
```

```
## # A tibble: 56,287 × 3
##    country     year  life_exp
##    <chr>       <chr>    <dbl>
##  1 Afghanistan x1800     28.2
##  2 Afghanistan x1801     28.2
##  3 Afghanistan x1802     28.2
##  4 Afghanistan x1803     28.2
##  5 Afghanistan x1804     28.2
##  6 Afghanistan x1805     28.2
##  7 Afghanistan x1806     28.1
##  8 Afghanistan x1807     28.1
##  9 Afghanistan x1808     28.1
## 10 Afghanistan x1809     28.1
## # … with 56,277 more rows
```


```r
population_total
```

```
## # A tibble: 195 × 302
##    country  x1800  x1801  x1802  x1803  x1804  x1805  x1806  x1807  x1808  x1809
##    <chr>    <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
##  1 Afghan… 3.28e6 3.28e6 3.28e6 3.28e6 3.28e6 3.28e6 3.28e6 3.28e6 3.28e6 3.28e6
##  2 Albania 4   e5 4.02e5 4.04e5 4.05e5 4.07e5 4.09e5 4.11e5 4.13e5 4.14e5 4.16e5
##  3 Algeria 2.5 e6 2.51e6 2.52e6 2.53e6 2.54e6 2.55e6 2.56e6 2.56e6 2.57e6 2.58e6
##  4 Andorra 2.65e3 2.65e3 2.65e3 2.65e3 2.65e3 2.65e3 2.65e3 2.65e3 2.65e3 2.65e3
##  5 Angola  1.57e6 1.57e6 1.57e6 1.57e6 1.57e6 1.57e6 1.57e6 1.57e6 1.57e6 1.57e6
##  6 Antigu… 3.7 e4 3.7 e4 3.7 e4 3.7 e4 3.7 e4 3.7 e4 3.7 e4 3.7 e4 3.7 e4 3.7 e4
##  7 Argent… 5.34e5 5.2 e5 5.06e5 4.92e5 4.79e5 4.66e5 4.53e5 4.41e5 4.29e5 4.17e5
##  8 Armenia 4.13e5 4.13e5 4.13e5 4.13e5 4.13e5 4.13e5 4.13e5 4.13e5 4.13e5 4.13e5
##  9 Austra… 2   e5 2.05e5 2.11e5 2.16e5 2.22e5 2.27e5 2.33e5 2.39e5 2.46e5 2.52e5
## 10 Austria 3   e6 3.02e6 3.04e6 3.05e6 3.07e6 3.09e6 3.11e6 3.12e6 3.14e6 3.16e6
## # … with 185 more rows, and 291 more variables: x1810 <dbl>, x1811 <dbl>,
## #   x1812 <dbl>, x1813 <dbl>, x1814 <dbl>, x1815 <dbl>, x1816 <dbl>,
## #   x1817 <dbl>, x1818 <dbl>, x1819 <dbl>, x1820 <dbl>, x1821 <dbl>,
## #   x1822 <dbl>, x1823 <dbl>, x1824 <dbl>, x1825 <dbl>, x1826 <dbl>,
## #   x1827 <dbl>, x1828 <dbl>, x1829 <dbl>, x1830 <dbl>, x1831 <dbl>,
## #   x1832 <dbl>, x1833 <dbl>, x1834 <dbl>, x1835 <dbl>, x1836 <dbl>,
## #   x1837 <dbl>, x1838 <dbl>, x1839 <dbl>, x1840 <dbl>, x1841 <dbl>, …
```


```r
population_tidy <- population_total%>%
  pivot_longer(-country, names_to = "year", values_to = "n_population")
population_tidy
```

```
## # A tibble: 58,695 × 3
##    country     year  n_population
##    <chr>       <chr>        <dbl>
##  1 Afghanistan x1800      3280000
##  2 Afghanistan x1801      3280000
##  3 Afghanistan x1802      3280000
##  4 Afghanistan x1803      3280000
##  5 Afghanistan x1804      3280000
##  6 Afghanistan x1805      3280000
##  7 Afghanistan x1806      3280000
##  8 Afghanistan x1807      3280000
##  9 Afghanistan x1808      3280000
## 10 Afghanistan x1809      3280000
## # … with 58,685 more rows
```


2. (1 point) How many different countries are represented in the data? Provide the total number and their names. Since each data set includes different numbers of countries, you will need to do this for each one.  


```r
gdp_data%>%
  count() #n=number of countries
```

```
## # A tibble: 1 × 1
##       n
##   <int>
## 1   193
```

```r
population_total%>%
  count() #n=number of countries
```

```
## # A tibble: 1 × 1
##       n
##   <int>
## 1   195
```


```r
life_expectancy%>%
  count() #n=number of countries
```

```
## # A tibble: 1 × 1
##       n
##   <int>
## 1   187
```

## Life Expectancy  

3. (2 points) Let's limit the data to 100 years (1920-2020). For these years, which country has the highest average life expectancy? How about the lowest average life expectancy?  


```r
life_expectancy%>%
  select(country, "x1920":"x2020")%>%
  pivot_longer(-country, names_to = "years", values_to = "life_exp")%>%
  group_by(country)%>%
  summarise(ave_life_exp = mean(life_exp))%>%
  arrange(ave_life_exp)%>%
  head(1)
```

```
## # A tibble: 1 × 2
##   country                  ave_life_exp
##   <chr>                           <dbl>
## 1 Central African Republic         41.8
```

```r
life_expectancy%>%
  select(country, "x1920":"x2020")%>%
  pivot_longer(-country, names_to = "years", values_to = "life_exp")%>%
  group_by(country)%>%
  summarise(ave_life_exp = mean(life_exp))%>%
  arrange(desc(ave_life_exp))%>%
  head(1)
```

```
## # A tibble: 1 × 2
##   country ave_life_exp
##   <chr>          <dbl>
## 1 Sweden          73.5
```


4. (3 points) Although we can see which country has the highest life expectancy for the past 100 years, we don't know which countries have changed the most. What are the top 5 countries that have experienced the biggest improvement in life expectancy between 1920-2020?  


```r
life_expectancy%>%
  select(country, "x1920":"x2020")%>%
  group_by(country)%>%
  mutate(slope=(x2020-x1920))%>%
  select(country, slope)%>%
  arrange(desc(slope))%>%
  head(5)
```

```
## # A tibble: 5 × 2
## # Groups:   country [5]
##   country         slope
##   <chr>           <dbl>
## 1 Kuwait           56.8
## 2 Kyrgyz Republic  56.5
## 3 Turkmenistan     55.3
## 4 South Korea      55  
## 5 Tajikistan       54.3
```


5. (3 points) Make a plot that shows the change over the past 100 years for the country with the biggest improvement in life expectancy. Be sure to add appropriate aesthetics to make the plot clean and clear. Once you have made the plot, do a little internet searching and see if you can discover what historical event may have contributed to this remarkable change.  


```r
life_p_K <- readr::read_csv("data/life_expectancy_years.csv")%>% #not using clean_names() to help with making years a numeric
  select(country, "1920":"2020")%>%
  filter(country=="Kuwait")%>%
  pivot_longer(-country, names_to = "years", values_to = "life_exp")
```

```
## Rows: 187 Columns: 302
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr   (1): country
## dbl (301): 1800, 1801, 1802, 1803, 1804, 1805, 1806, 1807, 1808, 1809, 1810,...
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
life_p_K
```

```
## # A tibble: 101 × 3
##    country years life_exp
##    <chr>   <chr>    <dbl>
##  1 Kuwait  1920      26.6
##  2 Kuwait  1921      26.6
##  3 Kuwait  1922      26.6
##  4 Kuwait  1923      26.6
##  5 Kuwait  1924      26.7
##  6 Kuwait  1925      26.7
##  7 Kuwait  1926      26.7
##  8 Kuwait  1927      26.7
##  9 Kuwait  1928      26.7
## 10 Kuwait  1929      26.7
## # … with 91 more rows
```

```r
life_p_K$years <- as.numeric(life_p_K$years)
```


```r
life_p_K%>%
ggplot(aes(x=years, y=life_exp)) + geom_point(color="lightblue") + theme_clean() + labs(title="Life Expectancy for Kuwait from 1920 to 2020", x="Year", y="Life Expectancy")
```

![](midterm_2_files/figure-html/unnamed-chunk-18-1.png)<!-- -->


## Population Growth
6. (3 points) Which 5 countries have had the highest population growth over the past 100 years (1920-2020)?  

```r
population_total%>%
  select(country, "x1920":"x2020")%>%
  mutate(slope=(x2020-x1920))%>%
  arrange(desc(slope))%>%
  select(country, slope)%>%
  head(5)
```

```
## # A tibble: 5 × 2
##   country            slope
##   <chr>              <dbl>
## 1 India         1063000000
## 2 China          968000000
## 3 Indonesia      226700000
## 4 United States  220000000
## 5 Pakistan       199300000
```


7. (4 points) Produce a plot that shows the 5 countries that have had the highest population growth over the past 100 years (1920-2020). Which countries appear to have had exponential growth?  

```r
top_pop_notclean  <- readr::read_csv("data/population_total.csv")%>%#not using clean_names() to help with making years a numeric
  select(country, "1920":"2020")%>%
  pivot_longer(-country, names_to = "years", values_to = "population")%>%
  filter(country=="India" | country=="China" | country=="Indonesia" | country=="United States"| country=="Pakistan")
```

```
## Rows: 195 Columns: 302
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr   (1): country
## dbl (301): 1800, 1801, 1802, 1803, 1804, 1805, 1806, 1807, 1808, 1809, 1810,...
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
top_pop_notclean
```

```
## # A tibble: 505 × 3
##    country years population
##    <chr>   <chr>      <dbl>
##  1 China   1920   472000000
##  2 China   1921   475000000
##  3 China   1922   478000000
##  4 China   1923   479000000
##  5 China   1924   481000000
##  6 China   1925   483000000
##  7 China   1926   484000000
##  8 China   1927   486000000
##  9 China   1928   488000000
## 10 China   1929   490000000
## # … with 495 more rows
```


```r
top_pop_notclean$years <- as.numeric(top_pop_notclean$years)
```


```r
top_pop_notclean%>%
  ggplot(aes(x=years, y=log10(population), color=country)) + geom_point() + labs(title="Top 5 Countries with Highest Population Growth", y="Population (log10)", x="Year")
```

![](midterm_2_files/figure-html/unnamed-chunk-22-1.png)<!-- -->

## Income
The units used for income are gross domestic product per person adjusted for differences in purchasing power in international dollars.

8. (4 points) As in the previous questions, which countries have experienced the biggest growth in per person GDP. Show this as a table and then plot the changes for the top 5 countries. With a bit of research, you should be able to explain the dramatic downturns of the wealthiest economies that occurred during the 1980's.  


```r
gdp_data%>%
  select(country, "x1920":"x2020")%>%
  group_by(country)%>%
  mutate(slope=(x2020-x1920))%>%
  arrange(desc(slope))%>%
  head(5)%>%
  select(country, slope)
```

```
## # A tibble: 5 × 2
## # Groups:   country [5]
##   country     slope
##   <chr>       <dbl>
## 1 Qatar      113700
## 2 Luxembourg  89370
## 3 Singapore   88060
## 4 Brunei      72970
## 5 Ireland     68930
```


```r
gdp_notclean <- readr::read_csv("data/income_per_person_gdppercapita_ppp_inflation_adjusted.csv")%>%#not using clean_names() to help with making years a numeric
  select(country, "1920":"2020")%>%
  group_by(country)%>%
  pivot_longer(-country, names_to = "years", values_to = "gdp")%>%
  filter(country=="Qatar" | country=="Luxembourg" | country=="Singapore" | country=="Brunei"| country=="Ireland")
```

```
## Rows: 193 Columns: 242
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr   (1): country
## dbl (241): 1800, 1801, 1802, 1803, 1804, 1805, 1806, 1807, 1808, 1809, 1810,...
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
gdp_notclean
```

```
## # A tibble: 505 × 3
## # Groups:   country [5]
##    country years   gdp
##    <chr>   <chr> <dbl>
##  1 Brunei  1920   2130
##  2 Brunei  1921   2140
##  3 Brunei  1922   2150
##  4 Brunei  1923   2160
##  5 Brunei  1924   2170
##  6 Brunei  1925   2180
##  7 Brunei  1926   2190
##  8 Brunei  1927   2200
##  9 Brunei  1928   2210
## 10 Brunei  1929   2220
## # … with 495 more rows
```


```r
gdp_notclean$years <- as.numeric(gdp_notclean$years)
```


```r
gdp_notclean%>%
  ggplot(aes(x=years, y=log10(gdp), color=country))+ geom_point() +theme_clean() + labs(title= "Top 5 Countries with Largest Income Growth", x="Year", y="Income")
```

![](midterm_2_files/figure-html/unnamed-chunk-26-1.png)<!-- -->

#notes: compare change in gdp between countries, (gdpf-gdpi)

9. (3 points) Create three new objects that restrict each data set (life expectancy, population, income) to the years 1920-2020. Hint: I suggest doing this with the long form of your data. Once this is done, merge all three data sets using the code I provide below. You may need to adjust the code depending on how you have named your objects. I called mine `life_expectancy_100`, `population_100`, and `income_100`. For some of you, learning these `joins` will be important for your project.  


```r
life_expectancy_100 <- life_expectancy%>%
  select(country, "x1920":"x2020")%>%
  pivot_longer(-country, names_to = "years", values_to = "life_exp")
life_expectancy_100
```

```
## # A tibble: 18,887 × 3
##    country     years life_exp
##    <chr>       <chr>    <dbl>
##  1 Afghanistan x1920     30.6
##  2 Afghanistan x1921     30.7
##  3 Afghanistan x1922     30.8
##  4 Afghanistan x1923     30.8
##  5 Afghanistan x1924     30.9
##  6 Afghanistan x1925     31  
##  7 Afghanistan x1926     31  
##  8 Afghanistan x1927     31.1
##  9 Afghanistan x1928     31.1
## 10 Afghanistan x1929     31.2
## # … with 18,877 more rows
```

```r
population_100 <- population_total%>%
  select(country, "x1920":"x2020")%>%
  pivot_longer(-country, names_to = "years", values_to = "pop")
population_100
```

```
## # A tibble: 19,695 × 3
##    country     years      pop
##    <chr>       <chr>    <dbl>
##  1 Afghanistan x1920 10600000
##  2 Afghanistan x1921 10500000
##  3 Afghanistan x1922 10300000
##  4 Afghanistan x1923  9710000
##  5 Afghanistan x1924  9200000
##  6 Afghanistan x1925  8720000
##  7 Afghanistan x1926  8260000
##  8 Afghanistan x1927  7830000
##  9 Afghanistan x1928  7420000
## 10 Afghanistan x1929  7100000
## # … with 19,685 more rows
```


```r
income_100 <- gdp_data%>%
  select(country, "x1920":"x2020")%>%
  pivot_longer(-country, names_to = "years", values_to = "gdp")
income_100
```

```
## # A tibble: 19,493 × 3
##    country     years   gdp
##    <chr>       <chr> <dbl>
##  1 Afghanistan x1920  1490
##  2 Afghanistan x1921  1520
##  3 Afghanistan x1922  1550
##  4 Afghanistan x1923  1570
##  5 Afghanistan x1924  1600
##  6 Afghanistan x1925  1630
##  7 Afghanistan x1926  1650
##  8 Afghanistan x1927  1680
##  9 Afghanistan x1928  1710
## 10 Afghanistan x1929  1740
## # … with 19,483 more rows
```


```r
gapminder_join <- inner_join(life_expectancy_100, population_100, by= c("country", "years"))
gapminder_join <- inner_join(gapminder_join, income_100, by= c("country", "years"))
gapminder_join
```

```
## # A tibble: 18,887 × 5
##    country     years life_exp      pop   gdp
##    <chr>       <chr>    <dbl>    <dbl> <dbl>
##  1 Afghanistan x1920     30.6 10600000  1490
##  2 Afghanistan x1921     30.7 10500000  1520
##  3 Afghanistan x1922     30.8 10300000  1550
##  4 Afghanistan x1923     30.8  9710000  1570
##  5 Afghanistan x1924     30.9  9200000  1600
##  6 Afghanistan x1925     31    8720000  1630
##  7 Afghanistan x1926     31    8260000  1650
##  8 Afghanistan x1927     31.1  7830000  1680
##  9 Afghanistan x1928     31.1  7420000  1710
## 10 Afghanistan x1929     31.2  7100000  1740
## # … with 18,877 more rows
```

10. (4 points) Use the joined data to perform an analysis of your choice. The analysis should include a comparison between two or more of the variables `life_expectancy`, `population`, or `income.`  


```r
summary(gapminder_join)
```

```
##    country             years              life_exp          pop           
##  Length:18887       Length:18887       Min.   : 4.07   Min.   :5.040e+03  
##  Class :character   Class :character   1st Qu.:43.80   1st Qu.:9.095e+05  
##  Mode  :character   Mode  :character   Median :59.00   Median :3.960e+06  
##                                        Mean   :56.59   Mean   :2.205e+07  
##                                        3rd Qu.:70.20   3rd Qu.:1.165e+07  
##                                        Max.   :85.30   Max.   :1.440e+09  
##                                        NA's   :159                        
##       gdp        
##  Min.   :   312  
##  1st Qu.:  1630  
##  Median :  3500  
##  Mean   :  8824  
##  3rd Qu.:  9620  
##  Max.   :179000  
## 
```


```r
gapminder_join_categories <- gapminder_join%>%
  group_by(country)%>%
  summarise(mean_life_exp = mean(life_exp), mean_pop = mean(pop), mean_income= mean(gdp))%>%
  mutate(life_exp_categories = case_when(mean_life_exp<=43.80 ~ "short lifespan", mean_life_exp>43.80 &mean_life_exp<=70.20 ~ "medium lifespan", mean_life_exp >70.20 ~ "long lifespan" ))%>%
  mutate(pop_categories = case_when(mean_pop<=909500 ~ "small pop", mean_pop>909500 & mean_pop<=11650000 ~ "medium pop", mean_pop>11650000 ~ "large pop"))%>%
  mutate(income_categories = case_when(mean_income<=1630 ~ "low income", mean_income>1630  & mean_income<=9620 ~ "average income", mean_income>9620 ~ "high income"))
gapminder_join_categories
```

```
## # A tibble: 187 × 7
##    country    mean_life_exp mean_pop mean_income life_exp_catego… pop_categories
##    <chr>              <dbl>    <dbl>       <dbl> <chr>            <chr>         
##  1 Afghanist…          43.8   1.44e7       1939. short lifespan   large pop     
##  2 Albania             61.4   2.10e6       4170. medium lifespan  medium pop    
##  3 Algeria             56.3   1.85e7       7850. medium lifespan  large pop     
##  4 Andorra             NA     3.39e4      22644. <NA>             small pop     
##  5 Angola              44.0   1.01e7       3964. medium lifespan  medium pop    
##  6 Antigua a…          63.2   5.87e4       9941. medium lifespan  small pop     
##  7 Argentina           65.8   2.53e7      11752. medium lifespan  large pop     
##  8 Armenia             60.2   2.26e6       3403. medium lifespan  medium pop    
##  9 Australia           72.7   1.32e7      22795. long lifespan    large pop     
## 10 Austria             68.6   7.45e6      20916. medium lifespan  medium pop    
## # … with 177 more rows, and 1 more variable: income_categories <chr>
```

```r
gapminder_join_categories%>%
  select(country, life_exp_categories, pop_categories, income_categories)
```

```
## # A tibble: 187 × 4
##    country             life_exp_categories pop_categories income_categories
##    <chr>               <chr>               <chr>          <chr>            
##  1 Afghanistan         short lifespan      large pop      average income   
##  2 Albania             medium lifespan     medium pop     average income   
##  3 Algeria             medium lifespan     large pop      average income   
##  4 Andorra             <NA>                small pop      high income      
##  5 Angola              medium lifespan     medium pop     average income   
##  6 Antigua and Barbuda medium lifespan     small pop      high income      
##  7 Argentina           medium lifespan     large pop      high income      
##  8 Armenia             medium lifespan     medium pop     average income   
##  9 Australia           long lifespan       large pop      high income      
## 10 Austria             medium lifespan     medium pop     high income      
## # … with 177 more rows
```

```r
gapminder_join_categories%>%
  select(country, life_exp_categories, pop_categories, income_categories)%>%
  ggplot(aes(x=pop_categories, y="n", , fill=life_exp_categories)) +geom_col() + labs(title= "Population size vs Life Expectancy Range", y="Number of Countries", x= "Population") + theme_clean()
```

![](midterm_2_files/figure-html/unnamed-chunk-34-1.png)<!-- -->

