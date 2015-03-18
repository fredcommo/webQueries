# webQueries
A R package for querying NCBI *Gene*, *Protein*, and *SNP* databases.
R functions are implementations of NCBI E-utilities *http://www.ncbi.nlm.nih.gov/books/NBK25500/*

Download "webQueries_0.98.0.tar.gz"

then use R CMD INSTALL webQueries_0.98.0.tar.gz

or directly install from github using *devtools*, as follow:

```r
# in R session
require(devtools)
install_github("fredcommo/webQueries/webQueries")

# see examples
require(webQueries)

# How to run a single query
?runQuery

# How to run multiple queries
?multiQueries

# Reading the vignette
vignette(webQueries)
````
