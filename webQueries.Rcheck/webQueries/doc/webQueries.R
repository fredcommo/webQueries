## ----setup, include=FALSE------------------------------------------------
require(knitr)
opts_chunk$set(fig.align='center', fig.width=5.5, fig.height=4.5,
    dev='pdf', prompt=TRUE, comment=NA, highlight=FALSE, tidy=FALSE)

## ----gene, echo=TRUE, prompt=FALSE---------------------------------------
require(webQueries)

# Using HUGO symbol
geneQuery("erbb2")

# Using entrezgene id
data.frame(output=geneQuery(2064))

## ----mutligene, echo=TRUE, prompt=FALSE----------------------------------
# Multiple queries
ids <- c("egfr", "erbb2", "fgfr1")
annots <- lapply(ids, function(id) geneQuery(id) )
annots <- do.call(rbind, annots)
annots

## ----prot, echo=TRUE, prompt=FALSE---------------------------------------
# Using UniProt id
myProt <- protQuery("P04626")
as.list(myProt)

## ----multiprot, echo=TRUE, prompt=FALSE----------------------------------
# Multiple queries
ids <- c("egfr", "erbb2", "fgfr1")
annots <- lapply(ids, function(id) protQuery(id) )
annots <- do.call(rbind, annots)
annots

