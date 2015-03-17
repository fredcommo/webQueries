\name{webQueries-package}
\alias{webQueries-package}
\alias{XML-package}

\docType{package}
\title{
Querying NCBI for Gene and/or Protein Annotations.
}
\description{
This function simply constructs an appropriate link to query the NCBI databases,
using E-utilities. See \code{note}.
HUGO symbols or official ids are supported.\cr
Information is extracted from the returned xml file,
using \code{\link[XML]{xpathApply}} from \code{XLM} package.
}
\details{
    \tabular{ll}{
        Package: \tab webQueries\cr
        Type: \tab Package\cr
        Version: \tab 0.98.0\cr
        Date: \tab 2015-03-15\cr
        License: \tab Artistic-2.0\cr
        }
This function simply constructs an appropriate link to query the NCBI databases,
using E-utilities.\cr
Information is extracted from the returned xml file.
}
\author{
    Frederic Commo <frederic.commo@gustaveroussy.fr>
}
\note{
    See \href{http://www.ncbi.nlm.nih.gov/books/NBK25501/}{Introduction to
    the E-utilities} for more details.\cr
    \code{runQuery} only supports queries sent to
    \code{"gene"}, \code{"protein"} , and \code{"snp"} databases.
}

\examples{
\dontrun{
# Querying the gene database using HUGO symbol or entrezgene id
runQuery("erbb2", "gene")
runQuery(2064, "gene", bySymbol = FALSE)

# Querying the Protein database
runQuery("erbb2", "protein")
runQuery("P04626", "protein", bySymbol = FALSE)

# Querying the SNP database
runQuery("erbb2", "snp")
runQuery(2064, "snp", bySymbol = FALSE)

# Multiple queries
ids <- c("egfr", "erbb2", "fgfr1")
annots <- lapply(ids, function(id) runQuery(id, "gene") )
annots <- do.call(rbind, annots)
annots
}
}
