---
output: html_document
editor_options:
chunk_output_type: console
---

# Basic Syntax


```r
"Hello, World!"
#> [1] "Hello, World!"
```


## Arithmetic


```r
1 + 1
#> [1] 2

1 + 1 * 3
#> [1] 4

(1 + 1) * 3
#> [1] 6
```


::: {.infobox .caution data-latex="{caution}"}
If your code doesn't form a complete _expression_, then R will look for the rest of on the next line.

Here's an example:


```r
1 +
```

R says "`1 +`... what??" and if you run the code it will output something like the following:


```r
> 1 +
+ 
```

If you see this, press the escape/_Esc_ key.

:::


## Comments


```r
# comments start with `#`
# R doesn't think comments are code!
# so we can annotate our code!

# here's a (contrived) example!
-1 * -1000 # a negative number times a negative is positive
#> [1] 1000
```


## Variables


```r
my_first_var <- "referring to data w/ names is handy!"
my_first_var
#> [1] "referring to data w/ names is handy!"
```

## Multiple Values


```r
c(1, 2, 3, 4, 5, 6) # `c()` is short for "combine"
#> [1] 1 2 3 4 5 6

1:6 # `:` lets us create sequences
#> [1] 1 2 3 4 5 6

my_first_vector_var <- -10:10 # we'll explain `vector`s later,
my_first_vector_var
#>  [1] -10  -9  -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3   4   5   6   7   8
#> [20]   9  10
```

## Functions


```r
sqrt(x = 16)
#> [1] 4
# ^^ name of function
```


```r
letters
#>  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
#> [20] "t" "u" "v" "w" "x" "y" "z"
toupper(x = letters)
#>  [1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S"
#> [20] "T" "U" "V" "W" "X" "Y" "Z"
#       ^ parameter or formal (argument)

LETTERS
#>  [1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S"
#> [20] "T" "U" "V" "W" "X" "Y" "Z"
tolower(x = letters)
#>  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
#> [20] "t" "u" "v" "w" "x" "y" "z"
#           ^^^^^^^ argument (always)
```

We refer to `x = letters` as a _named_ argument because we specify the parameter (`x`) to which we're passing our argument (`letters`), but we often don't specify the name of a parameter.


```r
tolower(letters)
#>  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
#> [20] "t" "u" "v" "w" "x" "y" "z"
```

We can't screw up too easily since `tolower()` and `toupper()` only have one paramter (`x`), but many functions can take multiple arguments.

Let's say we have a `vector` of unsorted numbers:


```r
unsorted_numbers <- c(3, 2, 10, 8, 1, 4, 9, 6, 5, 7)
unsorted_numbers
#>  [1]  3  2 10  8  1  4  9  6  5  7
```

Like most languages, R has a built-in `sort()` function we can use, which works like so:


```r
sort(unsorted_numbers)
#>  [1]  1  2  3  4  5  6  7  8  9 10
```

By default, `sort()` sorts in _ascending_ order, but we oftentimes will want to sort in _descending_ (or `decreasing`) order.

Rather than having a separate function called `sort_decreasing()`, we pass an argument to `sort()`'s `decreasing` parameter.


```r
sort(x = unsorted_numbers, decreasing = TRUE)
#>  [1] 10  9  8  7  6  5  4  3  2  1
```

Even though `sort()` has multiple parameters, we can still skip the bames if we pass our arguments _by position_.


```r
sort(unsorted_numbers, TRUE)
#>  [1] 10  9  8  7  6  5  4  3  2  1
```

Considering that `x` is `sort()`'s first parameter, and `decreaing` is `sort()`'s second parameter, we can pass our arguments (`unsorted_numbers` and `TRUE`) in the same order and R will know what we meant.

We can also mix _positional_ and _named_ arguments, and often do.


```r
sort(unsorted_numbers, decreasing = TRUE)
#>  [1] 10  9  8  7  6  5  4  3  2  1
```

You're hopefully wondering "How could we know the order of `sort()`'s parameters?" which leads us to documentation.

If you want more information on a specific function, you should [check out the documentation](https://en.wikipedia.org/wiki/RTFM), which you can do with `?` or `help()`.

Here's what that looks like for `sort()`


```r
?sort
```

<img src="1-basic-syntax_files/figure-html/unnamed-chunk-17-1.png" width="70%" style="display: block; margin: auto;" />

There's _a ton_ of information here, but all we're interested in at the moment is the order in which we need to pass arguments to `sort()`, which we can find in the __Arguments__ section.



::: {.infobox .tip data-latex="{tip}"}
We'll cover functions in far more detail later, but sometimes it's easier to see the how the function is defined, which we can by running `sort` without `()`.


```r
sort
#> function (x, decreasing = FALSE, ...) 
#> {
#>     if (!is.logical(decreasing) || length(decreasing) != 1L) 
#>         stop("'decreasing' must be a length-1 logical vector.\nDid you intend to set 'partial'?")
#>     UseMethod("sort")
#> }
#> <bytecode: 0x55b222ab4368>
#> <environment: namespace:base>
```

Only pay attention to the first line right now, which is where you'll see the following:

```
function (x, decreasing = FALSE, ...)
```

This tells us `x` is the `sort()`'s first parameter and `decreasing` is its second parameter.
:::







