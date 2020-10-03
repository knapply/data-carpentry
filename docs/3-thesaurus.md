---
output: html_document
editor_options:
  chunk_output_type: console
---




# Manipulating Data Frames {#manipulating-data-frames}



```r
library(tidyverse, warn.conflicts = FALSE)
#> ── Attaching packages ──────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──
#> ✓ ggplot2 3.3.2     ✓ purrr   0.3.4
#> ✓ tibble  3.0.3     ✓ dplyr   1.0.2
#> ✓ tidyr   1.1.2     ✓ stringr 1.4.0
#> ✓ readr   1.3.1     ✓ forcats 0.5.0
#> ── Conflicts ─────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()

df <- tibble(
  group = c("a", "a", "b", "b", "b"),
  a = c(1, 4, NA, 3, 5),
  b = c(9, NA, 8, 10, 7),
  c = c(TRUE, FALSE, NA, FALSE, TRUE),
  d = c(LETTERS[1:3], NA, LETTERS[[5]]),
  e = factor(1:5, labels = c("tiny", "small", "medium", "big", "huge")),
  f_col = c(as.Date(NA), as.Date("2020-09-23") + c(3, 2, 1, 4)),
  g_col = c(as.POSIXct("2020-09-23 00:00:00") + 1:4 * 60 * 60 * 24 * 1.1, NA),
  col_h = list(c(1, 10), c(2, NA), c(3, 8), c(4, 7), c(5, 6)),
  col_i = list(NULL, pi, month.abb[6:10], iris, as.matrix(mtcars))
)

df
#> # A tibble: 5 x 10
#>   group     a     b c     d     e      f_col      g_col               col_h     col_i               
#>   <chr> <dbl> <dbl> <lgl> <chr> <fct>  <date>     <dttm>              <list>    <list>              
#> 1 a         1     9 TRUE  A     tiny   NA         2020-09-24 02:24:00 <dbl [2]> <NULL>              
#> 2 a         4    NA FALSE B     small  2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>           
#> 3 b        NA     8 NA    C     medium 2020-09-25 2020-09-26 07:12:00 <dbl [2]> <chr [5]>           
#> 4 b         3    10 FALSE <NA>  big    2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>  
#> 5 b         5     7 TRUE  E     huge   2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
glimpse(df)
#> Rows: 5
#> Columns: 10
#> $ group <chr> "a", "a", "b", "b", "b"
#> $ a     <dbl> 1, 4, NA, 3, 5
#> $ b     <dbl> 9, NA, 8, 10, 7
#> $ c     <lgl> TRUE, FALSE, NA, FALSE, TRUE
#> $ d     <chr> "A", "B", "C", NA, "E"
#> $ e     <fct> tiny, small, medium, big, huge
#> $ f_col <date> NA, 2020-09-26, 2020-09-25, 2020-09-24, 2020-09-27
#> $ g_col <dttm> 2020-09-24 02:24:00, 2020-09-25 04:48:00, 2020-09-26 07:12:00, 2020-09-27 09:36:00, NA
#> $ col_h <list> [<1, 10>, <2, NA>, <3, 8>, <4, 7>, <5, 6>]
#> $ col_i <list> [NULL, 3.14, <"Jun", "Jul", "Aug", "Sep", "Oct">, <data.frame[150 x 5]>, <matrix[32 x 11]>]
```

## `select()` Columns



### by Name


```r
df %>%
  select(a)
#> # A tibble: 5 x 1
#>       a
#>   <dbl>
#> 1     1
#> 2     4
#> 3    NA
#> 4     3
#> 5     5
```


```r
df %>%
  select(a, c, e)
#> # A tibble: 5 x 3
#>       a c     e     
#>   <dbl> <lgl> <fct> 
#> 1     1 TRUE  tiny  
#> 2     4 FALSE small 
#> 3    NA NA    medium
#> 4     3 FALSE big   
#> 5     5 TRUE  huge
```


```r
df %>%
  select(b, d, f_col)
#> # A tibble: 5 x 3
#>       b d     f_col     
#>   <dbl> <chr> <date>    
#> 1     9 A     NA        
#> 2    NA B     2020-09-26
#> 3     8 C     2020-09-25
#> 4    10 <NA>  2020-09-24
#> 5     7 E     2020-09-27
```


```r
df %>%
  select(b, c, everything())
#> # A tibble: 5 x 10
#>       b c     group     a d     e      f_col      g_col               col_h     col_i               
#>   <dbl> <lgl> <chr> <dbl> <chr> <fct>  <date>     <dttm>              <list>    <list>              
#> 1     9 TRUE  a         1 A     tiny   NA         2020-09-24 02:24:00 <dbl [2]> <NULL>              
#> 2    NA FALSE a         4 B     small  2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>           
#> 3     8 NA    b        NA C     medium 2020-09-25 2020-09-26 07:12:00 <dbl [2]> <chr [5]>           
#> 4    10 FALSE b         3 <NA>  big    2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>  
#> 5     7 TRUE  b         5 E     huge   2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```


```r
df %>%
  select(b, c, everything(), -a)
#> # A tibble: 5 x 9
#>       b c     group d     e      f_col      g_col               col_h     col_i               
#>   <dbl> <lgl> <chr> <chr> <fct>  <date>     <dttm>              <list>    <list>              
#> 1     9 TRUE  a     A     tiny   NA         2020-09-24 02:24:00 <dbl [2]> <NULL>              
#> 2    NA FALSE a     B     small  2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>           
#> 3     8 NA    b     C     medium 2020-09-25 2020-09-26 07:12:00 <dbl [2]> <chr [5]>           
#> 4    10 FALSE b     <NA>  big    2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>  
#> 5     7 TRUE  b     E     huge   2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```


```r
cols_to_select <- c("a", "c", "e")
df %>%
  select(all_of(cols_to_select))
#> # A tibble: 5 x 3
#>       a c     e     
#>   <dbl> <lgl> <fct> 
#> 1     1 TRUE  tiny  
#> 2     4 FALSE small 
#> 3    NA NA    medium
#> 4     3 FALSE big   
#> 5     5 TRUE  huge
```


<!-- ```{r, error=TRUE} -->
<!-- cols_to_select <- c("a", "c", "e", "missing_column") -->
<!-- df %>% -->
<!--   select(all_of(cols_to_select)) -->
<!-- ``` -->

<!-- ```{r, error=TRUE} -->
<!-- cols_to_select <- c("a", "c", "e", "missing_column") -->
<!-- df %>% -->
<!--   select(any_of(cols_to_select)) -->
<!-- ``` -->



### by Index


```r
df %>%
  select(1L)
#> # A tibble: 5 x 1
#>   group
#>   <chr>
#> 1 a    
#> 2 a    
#> 3 b    
#> 4 b    
#> 5 b
```


```r
df %>%
  select(1, 3, 5)
#> # A tibble: 5 x 3
#>   group     b d    
#>   <chr> <dbl> <chr>
#> 1 a         9 A    
#> 2 a        NA B    
#> 3 b         8 C    
#> 4 b        10 <NA> 
#> 5 b         7 E
```



```r
df %>%
  select(2, 4, 6)
#> # A tibble: 5 x 3
#>       a c     e     
#>   <dbl> <lgl> <fct> 
#> 1     1 TRUE  tiny  
#> 2     4 FALSE small 
#> 3    NA NA    medium
#> 4     3 FALSE big   
#> 5     5 TRUE  huge
```



```r
df %>%
  select(2:3, everything())
#> # A tibble: 5 x 10
#>       a     b group c     d     e      f_col      g_col               col_h     col_i               
#>   <dbl> <dbl> <chr> <lgl> <chr> <fct>  <date>     <dttm>              <list>    <list>              
#> 1     1     9 a     TRUE  A     tiny   NA         2020-09-24 02:24:00 <dbl [2]> <NULL>              
#> 2     4    NA a     FALSE B     small  2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>           
#> 3    NA     8 b     NA    C     medium 2020-09-25 2020-09-26 07:12:00 <dbl [2]> <chr [5]>           
#> 4     3    10 b     FALSE <NA>  big    2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>  
#> 5     5     7 b     TRUE  E     huge   2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```


```r
df %>%
  select(2:3, everything(), -1)
#> # A tibble: 5 x 9
#>       a     b c     d     e      f_col      g_col               col_h     col_i               
#>   <dbl> <dbl> <lgl> <chr> <fct>  <date>     <dttm>              <list>    <list>              
#> 1     1     9 TRUE  A     tiny   NA         2020-09-24 02:24:00 <dbl [2]> <NULL>              
#> 2     4    NA FALSE B     small  2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>           
#> 3    NA     8 NA    C     medium 2020-09-25 2020-09-26 07:12:00 <dbl [2]> <chr [5]>           
#> 4     3    10 FALSE <NA>  big    2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>  
#> 5     5     7 TRUE  E     huge   2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```



```r
cols_to_select <- c(1, 3, 5)
df %>%
  select(all_of(cols_to_select))
#> # A tibble: 5 x 3
#>   group     b d    
#>   <chr> <dbl> <chr>
#> 1 a         9 A    
#> 2 a        NA B    
#> 3 b         8 C    
#> 4 b        10 <NA> 
#> 5 b         7 E
```


<!-- ```{r, error=TRUE} -->
<!-- cols_to_select <- c(1, 3, 5, 1000) -->
<!-- df %>% -->
<!--   select(all_of(cols_to_select)) -->
<!-- ``` -->



```r
cols_to_select <- c(1, 3, 5, 1000)
df %>%
  select(any_of(cols_to_select))
#> # A tibble: 5 x 3
#>   group     b d    
#>   <chr> <dbl> <chr>
#> 1 a         9 A    
#> 2 a        NA B    
#> 3 b         8 C    
#> 4 b        10 <NA> 
#> 5 b         7 E
```


### by Name Pattern

`contains()` selects a column if _any_ part of its name contains `match=`.


```r
df %>%
  select(contains(match = "col"))
#> # A tibble: 5 x 4
#>   f_col      g_col               col_h     col_i               
#>   <date>     <dttm>              <list>    <list>              
#> 1 NA         2020-09-24 02:24:00 <dbl [2]> <NULL>              
#> 2 2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>           
#> 3 2020-09-25 2020-09-26 07:12:00 <dbl [2]> <chr [5]>           
#> 4 2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>  
#> 5 2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```

`starts_with()` selects a column if its name starts with `match=`.


```r
df %>%
  select(starts_with("col_"))
#> # A tibble: 5 x 2
#>   col_h     col_i               
#>   <list>    <list>              
#> 1 <dbl [2]> <NULL>              
#> 2 <dbl [2]> <dbl [1]>           
#> 3 <dbl [2]> <chr [5]>           
#> 4 <dbl [2]> <df[,5] [150 × 5]>  
#> 5 <dbl [2]> <dbl[,11] [32 × 11]>
```

`starts_with()` selects a column if its name ends with `match=`.


```r
df %>%
  select(ends_with("_col"))
#> # A tibble: 5 x 2
#>   f_col      g_col              
#>   <date>     <dttm>             
#> 1 NA         2020-09-24 02:24:00
#> 2 2020-09-26 2020-09-25 04:48:00
#> 3 2020-09-25 2020-09-26 07:12:00
#> 4 2020-09-24 2020-09-27 09:36:00
#> 5 2020-09-27 NA
```

`matches()`s Selects a column if its name matches a regular expression pattern.


```r
df %>%
  select(matches("(^\\w_)?col(_\\w)?"))
#> # A tibble: 5 x 4
#>   f_col      g_col               col_h     col_i               
#>   <date>     <dttm>              <list>    <list>              
#> 1 NA         2020-09-24 02:24:00 <dbl [2]> <NULL>              
#> 2 2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>           
#> 3 2020-09-25 2020-09-26 07:12:00 <dbl [2]> <chr [5]>           
#> 4 2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>  
#> 5 2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```


### by Data Type


```r
df %>%
  select(where(is.factor))
#> # A tibble: 5 x 1
#>   e     
#>   <fct> 
#> 1 tiny  
#> 2 small 
#> 3 medium
#> 4 big   
#> 5 huge
```


```r
df %>%
  select_if(is.factor)
#> # A tibble: 5 x 1
#>   e     
#>   <fct> 
#> 1 tiny  
#> 2 small 
#> 3 medium
#> 4 big   
#> 5 huge
```


```r
df %>%
  select(where(is.factor), f_col)
#> # A tibble: 5 x 2
#>   e      f_col     
#>   <fct>  <date>    
#> 1 tiny   NA        
#> 2 small  2020-09-26
#> 3 medium 2020-09-25
#> 4 big    2020-09-24
#> 5 huge   2020-09-27
```



```r
df %>%
  select(a, !where(is.integer))
#> # A tibble: 5 x 10
#>       a group     b c     d     e      f_col      g_col               col_h     col_i               
#>   <dbl> <chr> <dbl> <lgl> <chr> <fct>  <date>     <dttm>              <list>    <list>              
#> 1     1 a         9 TRUE  A     tiny   NA         2020-09-24 02:24:00 <dbl [2]> <NULL>              
#> 2     4 a        NA FALSE B     small  2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>           
#> 3    NA b         8 NA    C     medium 2020-09-25 2020-09-26 07:12:00 <dbl [2]> <chr [5]>           
#> 4     3 b        10 FALSE <NA>  big    2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>  
#> 5     5 b         7 TRUE  E     huge   2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```




```r
df %>%
  select(where(is.character) | where(is.factor))
#> # A tibble: 5 x 3
#>   group d     e     
#>   <chr> <chr> <fct> 
#> 1 a     A     tiny  
#> 2 a     B     small 
#> 3 b     C     medium
#> 4 b     <NA>  big   
#> 5 b     E     huge
```


```r
df %>%
  select(where(~ is.double(.) | is.list(.)))
#> # A tibble: 5 x 6
#>       a     b f_col      g_col               col_h     col_i               
#>   <dbl> <dbl> <date>     <dttm>              <list>    <list>              
#> 1     1     9 NA         2020-09-24 02:24:00 <dbl [2]> <NULL>              
#> 2     4    NA 2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>           
#> 3    NA     8 2020-09-25 2020-09-26 07:12:00 <dbl [2]> <chr [5]>           
#> 4     3    10 2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>  
#> 5     5     7 2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```


```r
df %>%
  select_if(~ is.character(.x) | is.factor(.x))
#> # A tibble: 5 x 3
#>   group d     e     
#>   <chr> <chr> <fct> 
#> 1 a     A     tiny  
#> 2 a     B     small 
#> 3 b     C     medium
#> 4 b     <NA>  big   
#> 5 b     E     huge
```

## `filter()` Rows

### by `row_number()`


```r
df %>%
  filter(row_number() == 1)
#> # A tibble: 1 x 10
#>   group     a     b c     d     e     f_col      g_col               col_h     col_i 
#>   <chr> <dbl> <dbl> <lgl> <chr> <fct> <date>     <dttm>              <list>    <list>
#> 1 a         1     9 TRUE  A     tiny  NA         2020-09-24 02:24:00 <dbl [2]> <NULL>
```


```r
df %>%
  filter(row_number() > 1)
#> # A tibble: 4 x 10
#>   group     a     b c     d     e      f_col      g_col               col_h     col_i               
#>   <chr> <dbl> <dbl> <lgl> <chr> <fct>  <date>     <dttm>              <list>    <list>              
#> 1 a         4    NA FALSE B     small  2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>           
#> 2 b        NA     8 NA    C     medium 2020-09-25 2020-09-26 07:12:00 <dbl [2]> <chr [5]>           
#> 3 b         3    10 FALSE <NA>  big    2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>  
#> 4 b         5     7 TRUE  E     huge   2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```


### by Name


```r
df %>%
  filter(a == 2)
#> # A tibble: 0 x 10
#> # … with 10 variables: group <chr>, a <dbl>, b <dbl>, c <lgl>, d <chr>, e <fct>, f_col <date>, g_col <dttm>, col_h <list>, col_i <list>
```


```r
df %>%
  filter(a != 2)
#> # A tibble: 4 x 10
#>   group     a     b c     d     e     f_col      g_col               col_h     col_i               
#>   <chr> <dbl> <dbl> <lgl> <chr> <fct> <date>     <dttm>              <list>    <list>              
#> 1 a         1     9 TRUE  A     tiny  NA         2020-09-24 02:24:00 <dbl [2]> <NULL>              
#> 2 a         4    NA FALSE B     small 2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>           
#> 3 b         3    10 FALSE <NA>  big   2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>  
#> 4 b         5     7 TRUE  E     huge  2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```


```r
df %>%
  filter(c)
#> # A tibble: 2 x 10
#>   group     a     b c     d     e     f_col      g_col               col_h     col_i               
#>   <chr> <dbl> <dbl> <lgl> <chr> <fct> <date>     <dttm>              <list>    <list>              
#> 1 a         1     9 TRUE  A     tiny  NA         2020-09-24 02:24:00 <dbl [2]> <NULL>              
#> 2 b         5     7 TRUE  E     huge  2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```


```r
df %>%
  filter(!c)
#> # A tibble: 2 x 10
#>   group     a     b c     d     e     f_col      g_col               col_h     col_i             
#>   <chr> <dbl> <dbl> <lgl> <chr> <fct> <date>     <dttm>              <list>    <list>            
#> 1 a         4    NA FALSE B     small 2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>         
#> 2 b         3    10 FALSE <NA>  big   2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>
```



```r
df %>%
  filter(a == 5, d == "E")
#> # A tibble: 1 x 10
#>   group     a     b c     d     e     f_col      g_col               col_h     col_i               
#>   <chr> <dbl> <dbl> <lgl> <chr> <fct> <date>     <dttm>              <list>    <list>              
#> 1 b         5     7 TRUE  E     huge  2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```


```r
df %>%
  filter(a >= 3 | f_col == "2020-09-24")
#> # A tibble: 3 x 10
#>   group     a     b c     d     e     f_col      g_col               col_h     col_i               
#>   <chr> <dbl> <dbl> <lgl> <chr> <fct> <date>     <dttm>              <list>    <list>              
#> 1 a         4    NA FALSE B     small 2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>           
#> 2 b         3    10 FALSE <NA>  big   2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>  
#> 3 b         5     7 TRUE  E     huge  2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```


```r
df %>%
  filter(a < 2 | c)
#> # A tibble: 2 x 10
#>   group     a     b c     d     e     f_col      g_col               col_h     col_i               
#>   <chr> <dbl> <dbl> <lgl> <chr> <fct> <date>     <dttm>              <list>    <list>              
#> 1 a         1     9 TRUE  A     tiny  NA         2020-09-24 02:24:00 <dbl [2]> <NULL>              
#> 2 b         5     7 TRUE  E     huge  2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```


```r
df %>%
  filter(!is.na(a), !is.na(b), !is.na(d))
#> # A tibble: 2 x 10
#>   group     a     b c     d     e     f_col      g_col               col_h     col_i               
#>   <chr> <dbl> <dbl> <lgl> <chr> <fct> <date>     <dttm>              <list>    <list>              
#> 1 a         1     9 TRUE  A     tiny  NA         2020-09-24 02:24:00 <dbl [2]> <NULL>              
#> 2 b         5     7 TRUE  E     huge  2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```

### by Type


```r
df %>%
  filter(across(where(is.numeric), ~ .x >= 5))
#> # A tibble: 1 x 10
#>   group     a     b c     d     e     f_col      g_col               col_h     col_i               
#>   <chr> <dbl> <dbl> <lgl> <chr> <fct> <date>     <dttm>              <list>    <list>              
#> 1 b         5     7 TRUE  E     huge  2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```



```r
df %>%
  filter_if(is.numeric, ~ .x >= 5)
#> # A tibble: 1 x 10
#>   group     a     b c     d     e     f_col      g_col               col_h     col_i               
#>   <chr> <dbl> <dbl> <lgl> <chr> <fct> <date>     <dttm>              <list>    <list>              
#> 1 b         5     7 TRUE  E     huge  2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```



```r
df %>%
  filter_if(is.list, ~ map_lgl(.x, ~ !is.null(.x)))
#> # A tibble: 4 x 10
#>   group     a     b c     d     e      f_col      g_col               col_h     col_i               
#>   <chr> <dbl> <dbl> <lgl> <chr> <fct>  <date>     <dttm>              <list>    <list>              
#> 1 a         4    NA FALSE B     small  2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>           
#> 2 b        NA     8 NA    C     medium 2020-09-25 2020-09-26 07:12:00 <dbl [2]> <chr [5]>           
#> 3 b         3    10 FALSE <NA>  big    2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>  
#> 4 b         5     7 TRUE  E     huge   2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
```


## `arrange()` Rows


```r
df %>%
  arrange(a)
#> # A tibble: 5 x 10
#>   group     a     b c     d     e      f_col      g_col               col_h     col_i               
#>   <chr> <dbl> <dbl> <lgl> <chr> <fct>  <date>     <dttm>              <list>    <list>              
#> 1 a         1     9 TRUE  A     tiny   NA         2020-09-24 02:24:00 <dbl [2]> <NULL>              
#> 2 b         3    10 FALSE <NA>  big    2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>  
#> 3 a         4    NA FALSE B     small  2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>           
#> 4 b         5     7 TRUE  E     huge   2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
#> 5 b        NA     8 NA    C     medium 2020-09-25 2020-09-26 07:12:00 <dbl [2]> <chr [5]>
```


```r
df %>%
  arrange(desc(a))
#> # A tibble: 5 x 10
#>   group     a     b c     d     e      f_col      g_col               col_h     col_i               
#>   <chr> <dbl> <dbl> <lgl> <chr> <fct>  <date>     <dttm>              <list>    <list>              
#> 1 b         5     7 TRUE  E     huge   2020-09-27 NA                  <dbl [2]> <dbl[,11] [32 × 11]>
#> 2 a         4    NA FALSE B     small  2020-09-26 2020-09-25 04:48:00 <dbl [2]> <dbl [1]>           
#> 3 b         3    10 FALSE <NA>  big    2020-09-24 2020-09-27 09:36:00 <dbl [2]> <df[,5] [150 × 5]>  
#> 4 a         1     9 TRUE  A     tiny   NA         2020-09-24 02:24:00 <dbl [2]> <NULL>              
#> 5 b        NA     8 NA    C     medium 2020-09-25 2020-09-26 07:12:00 <dbl [2]> <chr [5]>
```



