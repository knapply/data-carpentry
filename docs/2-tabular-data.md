---
output: html_document
editor_options: 
  chunk_output_type: console
---





# Tabular Data {#tabular-data}

- Aliases: 
  + Tabular files
  + Flat
  + Delimited
- Includes:
  + Comma-Separated Value (.csv)
  + Tab-Separated Value (.tsv)
  
## Basics


```r
library(readr)
```

Here's some example data, modified from http://www.gapminder.org/data/


```
country,continent,year,lifeExp,pop,gdpPercap       # header/column names, separated by commas
Afghanistan,Asia,1952,28.801,8425333,779.4453145
Afghanistan,Asia,1957,30.332,9240934,820.8530296   # comma-separated values
Afghanistan,Asia,1962,31.997,10267083,853.10071
Afghanistan,Asia,1967,34.02,11537966,836.1971382
Afghanistan,Asia,1972,36.088,13079460,739.9811058
Afghanistan,Asia,1977,38.438,14880372,786.11336
Afghanistan,Asia,1982,39.854,12881816,978.0114388
Afghanistan,Asia,1987,40.822,13867957,852.3959448
```


```r
csv_text <- 
'country,continent,year,lifeExp,pop,gdpPercap     
Afghanistan,Asia,1952,28.801,8425333,779.4453145
Afghanistan,Asia,1957,30.332,9240934,820.8530296
Afghanistan,Asia,1962,31.997,10267083,853.10071
Afghanistan,Asia,1967,34.02,11537966,836.1971382
Afghanistan,Asia,1972,36.088,13079460,739.9811058
Afghanistan,Asia,1977,38.438,14880372,786.11336
Afghanistan,Asia,1982,39.854,12881816,978.0114388
Afghanistan,Asia,1987,40.822,13867957,852.3959448'

csv_file <- tempfile(fileext = ".csv")      
csv_file # a temporary file path
#> [1] "/tmp/RtmpkiXbVj/filec5e2405303c.csv"
writeLines(text = csv_text, con = csv_file) # write `csv_text` to `csv_file`
```



```r
read_csv(file = csv_file)
#> Parsed with column specification:
#> cols(
#>   country = col_character(),
#>   continent = col_character(),
#>   year = col_double(),
#>   lifeExp = col_double(),
#>   pop = col_double(),
#>   gdpPercap = col_double()
#> )
#> # A tibble: 8 x 6
#>   country     continent  year lifeExp      pop gdpPercap
#>   <chr>       <chr>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 Afghanistan Asia       1952    28.8  8425333      779.
#> 2 Afghanistan Asia       1957    30.3  9240934      821.
#> 3 Afghanistan Asia       1962    32.0 10267083      853.
#> 4 Afghanistan Asia       1967    34.0 11537966      836.
#> 5 Afghanistan Asia       1972    36.1 13079460      740.
#> 6 Afghanistan Asia       1977    38.4 14880372      786.
#> 7 Afghanistan Asia       1982    39.9 12881816      978.
#> 8 Afghanistan Asia       1987    40.8 13867957      852.
```



You may encounter Tab-Delimited data where values are separated by `\t` instead of `,`. Instead of `readr::read_csv()`, we can use `readr::read_tsv()`.



```r
tsv_text <- 
'country\tcontinent\tyear\tlifeExp\tpop\tgdpPercap     
Afghanistan\tAsia\t1952\t28.801\t8425333\t779.4453145
Afghanistan\tAsia\t1957\t30.332\t9240934\t820.8530296
Afghanistan\tAsia\t1962\t31.997\t10267083\t853.10071
Afghanistan\tAsia\t1967\t34.02\t11537966\t836.1971382
Afghanistan\tAsia\t1972\t36.088\t13079460\t739.9811058
Afghanistan\tAsia\t1977\t38.438\t14880372\t786.11336
Afghanistan\tAsia\t1982\t39.854\t12881816\t978.0114388
Afghanistan\tAsia\t1987\t40.822\t13867957\t852.3959448'

tsv_file <- tempfile(fileext = ".tsv")
writeLines(text = tsv_text, con = tsv_file)
```


```r
read_tsv(file = tsv_file)
#> Parsed with column specification:
#> cols(
#>   country = col_character(),
#>   continent = col_character(),
#>   year = col_double(),
#>   lifeExp = col_double(),
#>   pop = col_double(),
#>   gdpPercap = col_double()
#> )
#> # A tibble: 8 x 6
#>   country     continent  year lifeExp      pop gdpPercap
#>   <chr>       <chr>     <dbl>   <dbl>    <dbl>     <dbl>
#> 1 Afghanistan Asia       1952    28.8  8425333      779.
#> 2 Afghanistan Asia       1957    30.3  9240934      821.
#> 3 Afghanistan Asia       1962    32.0 10267083      853.
#> 4 Afghanistan Asia       1967    34.0 11537966      836.
#> 5 Afghanistan Asia       1972    36.1 13079460      740.
#> 6 Afghanistan Asia       1977    38.4 14880372      786.
#> 7 Afghanistan Asia       1982    39.9 12881816      978.
#> 8 Afghanistan Asia       1987    40.8 13867957      852.
```




If we find ourselves reading delmited data that uses something other than `\t` or `,` to separate values, we can use `readr::read_delim()`.


```r
pipe_separated_values_text <- 
'country|continent|year|lifeExp|pop|gdpPercap     
Afghanistan|Asia|1952|28.801|8425333|779.4453145
Afghanistan|Asia|1957|30.332|9240934|820.8530296
Afghanistan|Asia|1962|31.997|10267083|853.10071
Afghanistan|Asia|1967|34.02|11537966|836.1971382
Afghanistan|Asia|1972|36.088|13079460|739.9811058
Afghanistan|Asia|1977|38.438|14880372|786.11336
Afghanistan|Asia|1982|39.854|12881816|978.0114388
Afghanistan|Asia|1987|40.822|13867957|852.3959448'

psv_file <- tempfile(fileext = ".tsv")
writeLines(text = pipe_separated_values_text, con = psv_file)
```


```r
read_delim(file = psv_file, delim = "|")
#> Parsed with column specification:
#> cols(
#>   country = col_character(),
#>   continent = col_character(),
#>   year = col_double(),
#>   lifeExp = col_double(),
#>   pop = col_double(),
#>   `gdpPercap     ` = col_double()
#> )
#> # A tibble: 8 x 6
#>   country     continent  year lifeExp      pop `gdpPercap     `
#>   <chr>       <chr>     <dbl>   <dbl>    <dbl>            <dbl>
#> 1 Afghanistan Asia       1952    28.8  8425333             779.
#> 2 Afghanistan Asia       1957    30.3  9240934             821.
#> 3 Afghanistan Asia       1962    32.0 10267083             853.
#> 4 Afghanistan Asia       1967    34.0 11537966             836.
#> 5 Afghanistan Asia       1972    36.1 13079460             740.
#> 6 Afghanistan Asia       1977    38.4 14880372             786.
#> 7 Afghanistan Asia       1982    39.9 12881816             978.
#> 8 Afghanistan Asia       1987    40.8 13867957             852.
```








```
country,continent,year,lifeExp,pop,gdpPercap       # header/column names
Afghanistan,Asia,1952,28.801,8425333,779.4453145
Afghanistan,Asia,1957,30.332,9240934,820.8530296
Afghanistan,Asia,1962,31.997,10267083,853.10071
Afghanistan,Asia,1967,34.02,11537966,836.1971382
Afghanistan,Asia,1972,36.088,13079460,739.9811058
Afghanistan,Asia,1977,38.438,14880372,786.11336
Afghanistan,Asia,1982,39.854,12881816,978.0114388
Afghanistan,Asia,1987,40.822,13867957,852.3959448
Afghanistan,,,N/A,,                                # notice that we're missing values
```


```r
csv_text <- 
'country,continent,year,lifeExp,pop,gdpPercap
Afghanistan,Asia,1952,28.801,8425333,779.4453145
Afghanistan,Asia,1957,30.332,9240934,820.8530296
Afghanistan,Asia,1962,31.997,10267083,853.10071
Afghanistan,Asia,1967,34.02,11537966,836.1971382
Afghanistan,Asia,1972,36.088,13079460,739.9811058
Afghanistan,Asia,1977,38.438,14880372,786.11336
Afghanistan,Asia,1982,39.854,12881816,978.0114388
Afghanistan,Asia,1987,40.822,13867957,852.3959448
Afghanistan,,,N/A,,'

csv_file <- tempfile(fileext = ".csv")
writeLines(text = csv_text, con = csv_file)
```


## Common Pitfalls

### Incorrect Column Types


```r
data_frame_from_csv <- read_csv(file = csv_file)
#> Parsed with column specification:
#> cols(
#>   country = col_character(),
#>   continent = col_character(),
#>   year = col_double(),
#>   lifeExp = col_character(),
#>   pop = col_double(),
#>   gdpPercap = col_double()
#> )
data_frame_from_csv
#> # A tibble: 9 x 6
#>   country     continent  year lifeExp      pop gdpPercap
#>   <chr>       <chr>     <dbl> <chr>      <dbl>     <dbl>
#> 1 Afghanistan Asia       1952 28.801   8425333      779.
#> 2 Afghanistan Asia       1957 30.332   9240934      821.
#> 3 Afghanistan Asia       1962 31.997  10267083      853.
#> 4 Afghanistan Asia       1967 34.02   11537966      836.
#> 5 Afghanistan Asia       1972 36.088  13079460      740.
#> 6 Afghanistan Asia       1977 38.438  14880372      786.
#> 7 Afghanistan Asia       1982 39.854  12881816      978.
#> 8 Afghanistan Asia       1987 40.822  13867957      852.
#> 9 Afghanistan <NA>         NA N/A           NA       NA
```

Notice that our `year` column says `<dbl>`, referring to it being of type `double`, yet all of our `year` values are whole numbers.


```r
typeof(data_frame_from_csv$year)
#> [1] "double"
data_frame_from_csv$year
#> [1] 1952 1957 1962 1967 1972 1977 1982 1987   NA
```

We also have `"N/A"` in our `lifeExp` column, forcing R to interpret all `lifeExp` values as `character`s (`<chr>`).


```r
typeof(data_frame_from_csv$lifeExp)
#> [1] "character"
data_frame_from_csv$lifeExp
#> [1] "28.801" "30.332" "31.997" "34.02"  "36.088" "38.438" "39.854" "40.822" "N/A"
```

#### Solution


```r
read_csv(
  file = csv_file,
  col_types = cols(
    country = col_character(),
    continent = col_character(),
    year = col_integer(),        # read `year` as `integer`
    lifeExp = col_double(),      # read `lifeExp` as `double`
    pop = col_double(),
    gdpPercap = col_double()
  ),
  na = c("", "N/A")              # be explicit about how `csv_file` represents missing values
)
#> # A tibble: 9 x 6
#>   country     continent  year lifeExp      pop gdpPercap
#>   <chr>       <chr>     <int>   <dbl>    <dbl>     <dbl>
#> 1 Afghanistan Asia       1952    28.8  8425333      779.
#> 2 Afghanistan Asia       1957    30.3  9240934      821.
#> 3 Afghanistan Asia       1962    32.0 10267083      853.
#> 4 Afghanistan Asia       1967    34.0 11537966      836.
#> 5 Afghanistan Asia       1972    36.1 13079460      740.
#> 6 Afghanistan Asia       1977    38.4 14880372      786.
#> 7 Afghanistan Asia       1982    39.9 12881816      978.
#> 8 Afghanistan Asia       1987    40.8 13867957      852.
#> 9 Afghanistan <NA>         NA    NA         NA       NA
```


