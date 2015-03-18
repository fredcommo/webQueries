## ----setup, include=FALSE------------------------------------------------
require(knitr)
opts_chunk$set(fig.align='center', fig.width=5.5, fig.height=4.5,
    dev='pdf', prompt=TRUE, comment=NA, highlight=FALSE, tidy=FALSE)

## ----gene----------------------------------------------------------------
require(webQueries)
gquery <- runQuery("erbb2", "gene")

# The first 5 items
as.list(gquery)[1:5]

## ----prot----------------------------------------------------------------
pquery <- runQuery("P04626", "protein", bySymbol = FALSE)

# The first 5 items
as.list(pquery)[1:5]

## ----snpQuery------------------------------------------------------------
query <- runQuery("erbb2", "snp", updateOnly = FALSE)
query[,1:5]

## ----multi---------------------------------------------------------------
# Multiple queries on the Gene database, using HUGO symbols
ids <- c("egfr", "erbb2", "fgfr1")
annots <- multiQueries(ids, "gene")
annots[,1:8]
# List of returned items
names(annots)

