## ----setup, include=FALSE------------------------------------------------
require(knitr)
opts_chunk$set(fig.align='center', fig.width=5.5, fig.height=4.5,
    dev='pdf', prompt=TRUE, comment=NA, highlight=FALSE, tidy=FALSE)

## ----gene, echo=TRUE, prompt=FALSE---------------------------------------
require(webQueries)

runQuery("erbb2", "gene")
runQuery(2064, "gene", bySymbol = FALSE)

# Querying the Protein database
runQuery("erbb2", "protein")
runQuery("P04626", "protein", bySymbol = FALSE)

# Querying the SNP database
runQuery("erbb2", "snp")
runQuery(2064, "snp", bySymbol = FALSE)

## ----multi, echo=TRUE, prompt=FALSE--------------------------------------
# Multiple queries
ids <- c("egfr", "erbb2", "fgfr1")
annots <- lapply(ids, function(id) runQuery(id, "gene") )
annots <- do.call(rbind, annots)
annots

