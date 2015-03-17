\name{webQueries-package}
\alias{webQueries-package}
\alias{XML-package}

\docType{package}
\title{
Querying NCBI for Gene and/or Protein Annotations.
}
\description{
Retrieve gene and protein annotations from NCBI, given HUGO symbols or
official ids (entrezgene and Uniprot are supported). See \code{note}.\cr
\code{\link[XML]{xpathApply}} is used to extract information from xml files.
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
    See \href{http://www.ncbi.nlm.nih.gov/books/NBK25500/}{Introduction to
    the E-utilities} for more details.
}

\examples{
# Using HUGO symbol
geneQuery("erbb2")

# Using entrezgene id
geneQuery(2064)

# Using HUGO symbol
protQuery("erbb2")

# Using UniProt id
protQuery("P04626")
}
