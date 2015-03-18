\name{multiQueries}
\alias{multiQueries}

\title{
Retrieve NCBI annotations through Web Queries
}
\description{
As for \code{link{runQuery}}, this function uses NCBI E-utilities to query NCBI
databases. See \code{note}
HUGO symbols or official ids are supported.\cr
This version allows to run multiple queries, and returns the common items.
}
\usage{
multiQueries(List, db, bySymbol = TRUE, updateOnly = TRUE,
    ktries = 10, verbose = TRUE)
}
\arguments{
    \item{List}{
        : character or numeric. A list or a vector of valid HUGO symbols
        (not case sensitive), or ids.
        }
    \item{db}{
        : string. The NCBI database to query.
        \code{"gene"}, \code{"protein"}, and \code{"snp"} are supported.
        }
    \item{bySymbol}{
        : logical. Must be set to \code{TRUE} when a HUGO symbols is used.
        }
    \item{updateOnly}{
        : logical. Should the query returns the last update only.
        Default is \code{TRUE}. May be set to \code{FALSE} when \code{snp} is
        queried.
        }
    \item{ktries}{
        : numeric. The number of retries when connexion errors occur.
        Default is 10.
        }
    \item{verbose}{
        : logical. Should the process be monitored. Default is \code{TRUE}.
}
}
\value{
    A data set.
}
\author{
    Frederic Commo
}
\note{
    See \href{http://www.ncbi.nlm.nih.gov/books/NBK25501/}{Introduction to
    the E-utilities} for more details.\cr
    \code{runQuery} only supports queries sent to
    \code{"gene"}, \code{"protein"} , and \code{"snp"} databases.
}
\seealso{
    \code{\link{runQuery}}
}
\examples{
# Multiple queries
ids <- c("egfr", "erbb2", "fgfr1")
queries <- multiQueries(ids, "gene")

# Show the first 3 columns
queries[,1:3]
}