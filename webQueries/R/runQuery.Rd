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
\usage{
runQuery(geneId, DB, bySymbol = TRUE, kTries = 10)
}

\arguments{
    \item{geneId}{
        : character or numeric. \code{geneId} can be either a valid HUGO symbol
        (not case sensitive), or an entrezgene id. See \code{note}.
        }
    \item{DB}{
        : string. The NCBI database to query.
        \code{"gene"}, \code{"protein"}, and \code{"snp"} are supported.
        }
    \item{bySymb}{
        : logical. Must be set to \code{TRUE} when a HUGO symbols is used.
        }
    \item{kTries}{
        : numeric. The number of retries when connexion errors occur.
        Default is 10.
        }
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

\examples{
# Querying the gene database using HUGO symbol or entrezgene id
runQuery("erbb2", "gene")
runQuery(2064, "gene", bySymbol = FALSE)

# Querying the Protein database
runQuery("erbb2", "protein")
runQuery(2064, "protein", bySymbol = FALSE)

# Querying the SNP database
runQuery("erbb2", "snp")
runQuery(2064, "snp", bySymbol = FALSE)

# Multiple queries
ids <- c("egfr", "erbb2", "fgfr1")
annots <- lapply(ids, function(id) runQuery(id, "gene") )
annots <- do.call(rbind, annots)
annots
}