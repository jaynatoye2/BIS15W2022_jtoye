---
title: "Lab 6 Homework"
author: "Jayna Toye"
date: "2022-01-25"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(skimr)
```

For this assignment we are going to work with a large data set from the [United Nations Food and Agriculture Organization](http://www.fao.org/about/en/) on world fisheries. These data are pretty wild, so we need to do some cleaning. First, load the data.  

Load the data `FAO_1950to2012_111914.csv` as a new object titled `fisheries`.

```r
fisheries <- readr::read_csv(file = "data/FAO_1950to2012_111914.csv")
```

```
## Rows: 17692 Columns: 71
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (69): Country, Common name, ISSCAAP taxonomic group, ASFIS species#, ASF...
## dbl  (2): ISSCAAP group#, FAO major fishing area
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

1. Do an exploratory analysis of the data (your choice). What are the names of the variables, what are the dimensions, are there any NA's, what are the classes of the variables?  

```r
glimpse(fisheries)
```

```
## Rows: 17,692
## Columns: 71
## $ Country                   <chr> "Albania", "Albania", "Albania", "Albania", …
## $ `Common name`             <chr> "Angelsharks, sand devils nei", "Atlantic bo…
## $ `ISSCAAP group#`          <dbl> 38, 36, 37, 45, 32, 37, 33, 45, 38, 57, 33, …
## $ `ISSCAAP taxonomic group` <chr> "Sharks, rays, chimaeras", "Tunas, bonitos, …
## $ `ASFIS species#`          <chr> "10903XXXXX", "1750100101", "17710001XX", "2…
## $ `ASFIS species name`      <chr> "Squatinidae", "Sarda sarda", "Sphyraena spp…
## $ `FAO major fishing area`  <dbl> 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, …
## $ Measure                   <chr> "Quantity (tonnes)", "Quantity (tonnes)", "Q…
## $ `1950`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1951`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1952`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1953`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1954`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1955`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1956`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1957`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1958`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1959`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1960`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1961`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1962`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1963`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1964`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1965`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1966`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1967`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1968`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1969`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1970`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1971`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1972`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1973`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1974`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1975`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1976`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1977`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1978`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1979`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1980`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1981`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1982`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1983`                    <chr> NA, NA, NA, NA, NA, NA, "559", NA, NA, NA, N…
## $ `1984`                    <chr> NA, NA, NA, NA, NA, NA, "392", NA, NA, NA, N…
## $ `1985`                    <chr> NA, NA, NA, NA, NA, NA, "406", NA, NA, NA, N…
## $ `1986`                    <chr> NA, NA, NA, NA, NA, NA, "499", NA, NA, NA, N…
## $ `1987`                    <chr> NA, NA, NA, NA, NA, NA, "564", NA, NA, NA, N…
## $ `1988`                    <chr> NA, NA, NA, NA, NA, NA, "724", NA, NA, NA, N…
## $ `1989`                    <chr> NA, NA, NA, NA, NA, NA, "583", NA, NA, NA, N…
## $ `1990`                    <chr> NA, NA, NA, NA, NA, NA, "754", NA, NA, NA, N…
## $ `1991`                    <chr> NA, NA, NA, NA, NA, NA, "283", NA, NA, NA, N…
## $ `1992`                    <chr> NA, NA, NA, NA, NA, NA, "196", NA, NA, NA, N…
## $ `1993`                    <chr> NA, NA, NA, NA, NA, NA, "150 F", NA, NA, NA,…
## $ `1994`                    <chr> NA, NA, NA, NA, NA, NA, "100 F", NA, NA, NA,…
## $ `1995`                    <chr> "0 0", "1", NA, "0 0", "0 0", NA, "52", "30"…
## $ `1996`                    <chr> "53", "2", NA, "3", "2", NA, "104", "8", NA,…
## $ `1997`                    <chr> "20", "0 0", NA, "0 0", "0 0", NA, "65", "4"…
## $ `1998`                    <chr> "31", "12", NA, NA, NA, NA, "220", "18", NA,…
## $ `1999`                    <chr> "30", "30", NA, NA, NA, NA, "220", "18", NA,…
## $ `2000`                    <chr> "30", "25", "2", NA, NA, NA, "220", "20", NA…
## $ `2001`                    <chr> "16", "30", NA, NA, NA, NA, "120", "23", NA,…
## $ `2002`                    <chr> "79", "24", NA, "34", "6", NA, "150", "84", …
## $ `2003`                    <chr> "1", "4", NA, "22", NA, NA, "84", "178", NA,…
## $ `2004`                    <chr> "4", "2", "2", "15", "1", "2", "76", "285", …
## $ `2005`                    <chr> "68", "23", "4", "12", "5", "6", "68", "150"…
## $ `2006`                    <chr> "55", "30", "7", "18", "8", "9", "86", "102"…
## $ `2007`                    <chr> "12", "19", NA, NA, NA, NA, "132", "18", NA,…
## $ `2008`                    <chr> "23", "27", NA, NA, NA, NA, "132", "23", NA,…
## $ `2009`                    <chr> "14", "21", NA, NA, NA, NA, "154", "20", NA,…
## $ `2010`                    <chr> "78", "23", "7", NA, NA, NA, "80", "228", NA…
## $ `2011`                    <chr> "12", "12", NA, NA, NA, NA, "88", "9", NA, "…
## $ `2012`                    <chr> "5", "5", NA, NA, NA, NA, "129", "290", NA, …
```

2. Use `janitor` to rename the columns and make them easier to use. As part of this cleaning step, change `country`, `isscaap_group_number`, `asfis_species_number`, and `fao_major_fishing_area` to data class factor. 

```r
fisheries <- janitor::clean_names(fisheries)
fisheries
```

```
## # A tibble: 17,692 × 71
##    country common_name    isscaap_group_nu… isscaap_taxonomic_… asfis_species_n…
##    <chr>   <chr>                      <dbl> <chr>               <chr>           
##  1 Albania Angelsharks, …                38 Sharks, rays, chim… 10903XXXXX      
##  2 Albania Atlantic boni…                36 Tunas, bonitos, bi… 1750100101      
##  3 Albania Barracudas nei                37 Miscellaneous pela… 17710001XX      
##  4 Albania Blue and red …                45 Shrimps, prawns     2280203101      
##  5 Albania Blue whiting(…                32 Cods, hakes, haddo… 1480403301      
##  6 Albania Bluefish                      37 Miscellaneous pela… 1702021301      
##  7 Albania Bogue                         33 Miscellaneous coas… 1703926101      
##  8 Albania Caramote prawn                45 Shrimps, prawns     2280100117      
##  9 Albania Catsharks, nu…                38 Sharks, rays, chim… 10801003XX      
## 10 Albania Common cuttle…                57 Squids, cuttlefish… 3210200202      
## # … with 17,682 more rows, and 66 more variables: asfis_species_name <chr>,
## #   fao_major_fishing_area <dbl>, measure <chr>, x1950 <chr>, x1951 <chr>,
## #   x1952 <chr>, x1953 <chr>, x1954 <chr>, x1955 <chr>, x1956 <chr>,
## #   x1957 <chr>, x1958 <chr>, x1959 <chr>, x1960 <chr>, x1961 <chr>,
## #   x1962 <chr>, x1963 <chr>, x1964 <chr>, x1965 <chr>, x1966 <chr>,
## #   x1967 <chr>, x1968 <chr>, x1969 <chr>, x1970 <chr>, x1971 <chr>,
## #   x1972 <chr>, x1973 <chr>, x1974 <chr>, x1975 <chr>, x1976 <chr>, …
```

```r
fisheries$country<- as.factor(fisheries$country)
fisheries$isscaap_group_number<- as.factor(fisheries$isscaap_group_number)
fisheries$asfis_species_number <- as.factor(fisheries$asfis_species_number)
fisheries$fao_major_fishing_area<- as.factor(fisheries$fao_major_fishing_area)
```


```r
class(fisheries$country)
```

```
## [1] "factor"
```

```r
class(fisheries$isscaap_group_number)
```

```
## [1] "factor"
```

```r
class(fisheries$asfis_species_number)
```

```
## [1] "factor"
```

```r
class(fisheries$fao_major_fishing_area)
```

```
## [1] "factor"
```

We need to deal with the years because they are being treated as characters and start with an X. We also have the problem that the column names that are years actually represent data. We haven't discussed tidy data yet, so here is some help. You should run this ugly chunk to transform the data for the rest of the homework. It will only work if you have used janitor to rename the variables in question 2!

```r
fisheries_tidy <- fisheries %>% 
  pivot_longer(-c(country,common_name,isscaap_group_number,isscaap_taxonomic_group,asfis_species_number,asfis_species_name,fao_major_fishing_area,measure),
               names_to = "year",
               values_to = "catch",
               values_drop_na = TRUE) %>% 
  mutate(year= as.numeric(str_replace(year, 'x', ''))) %>% 
  mutate(catch= str_replace(catch, c(' F'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('...'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('-'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('0 0'), replacement = ''))

fisheries_tidy$catch <- as.numeric(fisheries_tidy$catch)
```

3. How many countries are represented in the data? Provide a count and list their names.

```r
fisheries%>%
  count(country)
```

```
## # A tibble: 204 × 2
##    country                 n
##    <fct>               <int>
##  1 Albania                67
##  2 Algeria                59
##  3 American Samoa         32
##  4 Angola                 88
##  5 Anguilla                3
##  6 Antigua and Barbuda    22
##  7 Argentina             140
##  8 Aruba                   5
##  9 Australia             301
## 10 Bahamas                14
## # … with 194 more rows
```

4. Refocus the data only to include country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch.

```r
names(fisheries_tidy)
```

```
##  [1] "country"                 "common_name"            
##  [3] "isscaap_group_number"    "isscaap_taxonomic_group"
##  [5] "asfis_species_number"    "asfis_species_name"     
##  [7] "fao_major_fishing_area"  "measure"                
##  [9] "year"                    "catch"
```


```r
fisheries_tidy%>%
  select("country", "isscaap_taxonomic_group", "asfis_species_name", "asfis_species_number", "year", "catch")
```

```
## # A tibble: 376,771 × 6
##    country isscaap_taxonomic_group asfis_species_n… asfis_species_n…  year catch
##    <fct>   <chr>                   <chr>            <fct>            <dbl> <dbl>
##  1 Albania Sharks, rays, chimaeras Squatinidae      10903XXXXX        1995    NA
##  2 Albania Sharks, rays, chimaeras Squatinidae      10903XXXXX        1996    53
##  3 Albania Sharks, rays, chimaeras Squatinidae      10903XXXXX        1997    20
##  4 Albania Sharks, rays, chimaeras Squatinidae      10903XXXXX        1998    31
##  5 Albania Sharks, rays, chimaeras Squatinidae      10903XXXXX        1999    30
##  6 Albania Sharks, rays, chimaeras Squatinidae      10903XXXXX        2000    30
##  7 Albania Sharks, rays, chimaeras Squatinidae      10903XXXXX        2001    16
##  8 Albania Sharks, rays, chimaeras Squatinidae      10903XXXXX        2002    79
##  9 Albania Sharks, rays, chimaeras Squatinidae      10903XXXXX        2003     1
## 10 Albania Sharks, rays, chimaeras Squatinidae      10903XXXXX        2004     4
## # … with 376,761 more rows
```


5. Based on the asfis_species_number, how many distinct fish species were caught as part of these data?

```r
fisheries_tidy%>%
  distinct(asfis_species_number)
```

```
## # A tibble: 1,551 × 1
##    asfis_species_number
##    <fct>               
##  1 10903XXXXX          
##  2 1750100101          
##  3 17710001XX          
##  4 2280203101          
##  5 1480403301          
##  6 1702021301          
##  7 1703926101          
##  8 2280100117          
##  9 10801003XX          
## 10 3210200202          
## # … with 1,541 more rows
```

6. Which country had the largest overall catch in the year 2000?

```r
fisheries_tidy%>%
  select(country, year, catch)%>%
  filter(year==2000)%>%
  arrange(desc(catch))
```

```
## # A tibble: 8,793 × 3
##    country                   year catch
##    <fct>                    <dbl> <dbl>
##  1 China                     2000  9068
##  2 Peru                      2000  5717
##  3 Russian Federation        2000  5065
##  4 Viet Nam                  2000  4945
##  5 Chile                     2000  4299
##  6 China                     2000  3288
##  7 China                     2000  2782
##  8 United States of America  2000  2438
##  9 China                     2000  1234
## 10 Philippines               2000   999
## # … with 8,783 more rows
```

China had the largest catch of 2000.   

7. Which country caught the most sardines (_Sardina pilchardus_) between the years 1990-2000?

```r
names(fisheries_tidy)
```

```
##  [1] "country"                 "common_name"            
##  [3] "isscaap_group_number"    "isscaap_taxonomic_group"
##  [5] "asfis_species_number"    "asfis_species_name"     
##  [7] "fao_major_fishing_area"  "measure"                
##  [9] "year"                    "catch"
```


```r
fisheries_tidy%>%
  select(country, year, asfis_species_name, catch)%>%
  filter(between(year, 1990, 2000))%>%
  filter(asfis_species_name=="Sardina pilchardus")%>%
  arrange(desc(catch))
```

```
## # A tibble: 336 × 4
##    country             year asfis_species_name catch
##    <fct>              <dbl> <chr>              <dbl>
##  1 Morocco             1994 Sardina pilchardus   947
##  2 Morocco             1996 Sardina pilchardus   925
##  3 Spain               1996 Sardina pilchardus   912
##  4 Morocco             2000 Sardina pilchardus   859
##  5 Morocco             1990 Sardina pilchardus   845
##  6 Morocco             1991 Sardina pilchardus   827
##  7 Morocco             1998 Sardina pilchardus   723
##  8 Morocco             1993 Sardina pilchardus   710
##  9 Russian Federation  1992 Sardina pilchardus   627
## 10 Russian Federation  1991 Sardina pilchardus   579
## # … with 326 more rows
```
Morocco caught the most Sardina pilchardus between the years of 1990-2000

8. Which five countries caught the most cephalopods between 2008-2012?


```r
fisheries_tidy%>%
  select(country, year, isscaap_taxonomic_group, catch)%>%
  filter(between(year, 2008, 2012))%>%
  filter(isscaap_taxonomic_group=="Squids, cuttlefishes, octopuses")%>%
  arrange(desc(catch))
```

```
## # A tibble: 1,801 × 4
##    country                   year isscaap_taxonomic_group         catch
##    <fct>                    <dbl> <chr>                           <dbl>
##  1 Indonesia                 2012 Squids, cuttlefishes, octopuses   991
##  2 China                     2008 Squids, cuttlefishes, octopuses   981
##  3 Chile                     2012 Squids, cuttlefishes, octopuses   965
##  4 United States of America  2010 Squids, cuttlefishes, octopuses   901
##  5 China                     2012 Squids, cuttlefishes, octopuses   845
##  6 Japan                     2010 Squids, cuttlefishes, octopuses   832
##  7 China                     2010 Squids, cuttlefishes, octopuses   826
##  8 Peru                      2010 Squids, cuttlefishes, octopuses   822
##  9 Korea, Republic of        2008 Squids, cuttlefishes, octopuses   816
## 10 Peru                      2009 Squids, cuttlefishes, octopuses   805
## # … with 1,791 more rows
```
Indonesia, China, Chile, United States and Japan caught the most cephalopods between the years of 2008-2012. 


9. Which species had the highest catch total between 2008-2012? (hint: Osteichthyes is not a species)

```r
fisheries_tidy%>%
  select(catch, asfis_species_name, year)%>%
  filter(between(year, 2008, 2012))%>%
  group_by(asfis_species_name)%>%
  summarise(catch_total=sum(catch, na.rm=T))%>%
  arrange(desc(catch_total))
```

```
## # A tibble: 1,472 × 2
##    asfis_species_name    catch_total
##    <chr>                       <dbl>
##  1 Osteichthyes               107808
##  2 Theragra chalcogramma       41075
##  3 Engraulis ringens           35523
##  4 Katsuwonus pelamis          32153
##  5 Trichiurus lepturus         30400
##  6 Clupea harengus             28527
##  7 Thunnus albacares           20119
##  8 Scomber japonicus           14723
##  9 Gadus morhua                13253
## 10 Thunnus alalunga            12019
## # … with 1,462 more rows
```


10. Use the data to do at least one analysis of your choice.

```r
summary(fisheries_tidy)
```

```
##                      country       common_name        isscaap_group_number
##  United States of America: 18080   Length:376771      33     : 69821      
##  Spain                   : 17482   Class :character   36     : 61839      
##  Japan                   : 15429   Mode  :character   37     : 38992      
##  Portugal                : 11570                      34     : 27360      
##  Korea, Republic of      : 10824                      38     : 23210      
##  France                  : 10639                      32     : 21616      
##  (Other)                 :292747                      (Other):133933      
##  isscaap_taxonomic_group    asfis_species_number asfis_species_name
##  Length:376771           199XXXXXXX010: 14289    Length:376771     
##  Class :character        1750102610   :  6866    Class :character  
##  Mode  :character        199XXXXXXX054:  6405    Mode  :character  
##                          1750102501   :  5785                      
##                          1750102612   :  5341                      
##                          1750400301   :  5143                      
##                          (Other)      :332942                      
##  fao_major_fishing_area   measure               year          catch         
##  27     : 58309         Length:376771      Min.   :1950   Min.   :    0.00  
##  34     : 47080         Class :character   1st Qu.:1977   1st Qu.:    2.00  
##  37     : 40698         Mode  :character   Median :1991   Median :    7.00  
##  51     : 33244                            Mean   :1989   Mean   :   39.36  
##  31     : 30530                            3rd Qu.:2003   3rd Qu.:   32.00  
##  71     : 30065                            Max.   :2012   Max.   :77000.00  
##  (Other):136845                                           NA's   :133583
```


## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
