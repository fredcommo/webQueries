\name{webQueries-package}
\alias{webQueries-package}
\alias{XML-package}

\docType{package}
\title{
  NCBI Queries for Gene and Protein Annotation.
}
\description{
  Retrieve gene and protein annotations from NCBI, given HUGO symbols or official ids (entrezgene and Uniprot are supported). See \code{note}.
  \code{\link[XML]{xpathApply}} is used to extract information from xml files.
}
\details{
  \tabular{ll}{
    Package: \tab webQueries\cr
    Type: \tab Package\cr
    Version: \tab 1.0\cr
    Date: \tab 2015-02-06\cr
    License: \tab GPL\cr
  }
  This function simply constructs an appropriate link to query the NCBI databases, using E-utilities
  Information is extracted from the returned xml file.
}
\author{
Frederic Commo <frederic.commo@gustaveroussy.fr>
}
\note{
  See \href{http://www.ncbi.nlm.nih.gov/books/NBK25500/}{Introduction to the E-utilities} for more details.
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
