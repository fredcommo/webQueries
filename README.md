# webQueries
A R package for querying NCBI \emph{Gene}, \emph{Protein}, and \emph{SNP} databases.
R functions are implementations of NCBI E-utilities \url{http://www.ncbi.nlm.nih.gov/books/NBK25500/}

Download "webQueries_0.98.0.tar.gz"

then use R CMD INSTALL webQueries_0.98.0.tar.gz

or

```r
# in R session
require(devtools)
install_github("fredcommo/webQueries/webQueries")

# see examples
require(webQueries)

# Reading the vignette
vignette(webQueries)

# To run a single query
?runQuery

# To run multiple queries
?multiQueries
````
