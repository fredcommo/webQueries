pkgname <- "webQueries"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "webQueries-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('webQueries')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("runQuery")
### * runQuery

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: runQuery
### Title: Retrieve NCBI annotations through Web Queries
### Aliases: runQuery

### ** Examples

# Querying the gene database using HUGO symbol or entrezgene id
## Not run: 
##D runQuery("erbb2", "gene")
##D runQuery(2064, "gene", bySymbol = FALSE)
##D 
##D # Querying the Protein database
##D runQuery("erbb2", "protein")
##D runQuery("P04626", "protein", bySymbol = FALSE)
##D 
##D # Querying the SNP database
##D runQuery("erbb2", "snp")
##D runQuery(2064, "snp", bySymbol = FALSE)
##D 
##D # Multiple queries
##D ids <- c("egfr", "erbb2", "fgfr1")
##D annots <- lapply(ids, function(id) runQuery(id, "gene") )
##D annots <- do.call(rbind, annots)
##D annots
## End(Not run)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("runQuery", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("webQueries-package")
### * webQueries-package

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: webQueries-package
### Title: Querying NCBI for Gene and/or Protein Annotations.
### Aliases: webQueries-package XML-package

### ** Examples

## Not run: 
##D # Querying the gene database using HUGO symbol or entrezgene id
##D runQuery("erbb2", "gene")
##D runQuery(2064, "gene", bySymbol = FALSE)
##D 
##D # Querying the Protein database
##D runQuery("erbb2", "protein")
##D runQuery("P04626", "protein", bySymbol = FALSE)
##D 
##D # Querying the SNP database
##D runQuery("erbb2", "snp")
##D runQuery(2064, "snp", bySymbol = FALSE)
##D 
##D # Multiple queries
##D ids <- c("egfr", "erbb2", "fgfr1")
##D annots <- lapply(ids, function(id) runQuery(id, "gene") )
##D annots <- do.call(rbind, annots)
##D annots
## End(Not run)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("webQueries-package", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
