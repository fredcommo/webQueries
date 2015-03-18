\name{runQuery}
\alias{runQuery}

\title{
Retrieve NCBI annotations through Web Queries
}
\description{
This function simply constructs an appropriate link to query the NCBI databases,
using E-utilities. See \code{note}.
HUGO symbols or official ids are supported.\cr
Information is extracted from the returned xml file,
using \code{\link[XML]{xpathApply}} from \code{XLM} package.
}
\usage{
    runQuery(symbol, db, bySymbol = TRUE, updateOnly = TRUE, ktries = 10)
}
\arguments{
    \item{symbol}{
        : character or numeric. \code{geneId} can be either a valid HUGO symbol
        (not case sensitive), or an entrezgene id.
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
}
\value{
    A vector of values.  
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
# Querying the gene database using HUGO symbol or entrezgene id
gquery <- runQuery("erbb2", "gene")
as.list(gquery)

# Querying the Protein database
pquery <- runQuery("P04626", "protein", bySymbol = FALSE)
as.list(pquery)

# Querying the SNP database
snpquery <- runQuery(2064, "snp", bySymbol = FALSE, updateOnly = FALSE)
snpquery[,1:5]
}