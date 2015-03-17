\name{geneQuery}
\alias{geneQuery}

\title{
Gene annotations via Web Queries
}
\description{
This function simply constructs an appropriate link to query the NCBI databases,
using E-utilities. See \code{note}. HUGO symbols and entrezgene ids
are supported.\cr
Information is extracted from the returned xml file,
using \code{\link[XML]{xpathApply}} from \code{XLM} package.
}
\usage{
geneQuery(geneId, DB = "gene", bySymb = TRUE, kTries = 10, verbose = TRUE)
}

\arguments{
    \item{geneId}{
        : character or numeric. \code{geneId} can be either a valid HUGO symbol
        (not case sensitive), or an entrezgene id. See \code{note}.
        }
    \item{DB}{
        : string. The NCBI database to query. This must be one of the NCBI
        databases supporting web queries.
        }
    \item{bySymb}{
        : logical. Must be set to \code{TRUE} when a HUGO symbols is used.
        }
    \item{kTries}{
        : numeric. The number of retries when connexion errors occur.
        Default is 10.
        }
    \item{verbose}{
        : logical. If \code{TRUE}, progress in prompted.
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
    the E-utilities} for more details.
}
\seealso{
    \code{\link{protQuery}} 
}

\examples{
# Simple query using HUGO symbol or entrezgene id
geneQuery("erbb2")
geneQuery(2064)

# Multiple queries
ids <- c("egfr", "erbb2", "fgfr1")
annots <- lapply(ids, function(id) geneQuery(id) )
annots <- do.call(rbind, annots)
annots
}