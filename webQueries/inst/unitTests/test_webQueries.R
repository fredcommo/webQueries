test_geneQueries <- function(){
	checkEquals(gettext(runQuery("erbb2", "gene")$Name), "ERBB2")
	checkEquals(gettext(runQuery("ERBB2", "gene")$Name), "ERBB2")
	checkEquals(gettext(runQuery(2064, "gene", bySymbol=FALSE)$Name), "ERBB2")
}
test_protQueries <- function(){
	checkEquals(gettext(runQuery("erbb2", "protein")$Caption[1]), "P04626")
	checkEquals(gettext(runQuery("ERBB2", "protein")$Caption[1]), "P04626")
	checkEquals(gettext(runQuery("P04626", "protein")$Caption[1]), "P04626")
}
test_snpQueries <- function(){
	checkTrue(nrow(runQuery("erbb2", "snp"))>0)
	checkTrue(nrow(runQuery("2064", "snp"))>0)
	checkTrue(nrow(runQuery(2064, "snp"))>0)
}
test_badQueries <- function(){
	checkTrue(is.null(runQuery("doesNotExist", "gene")))
	checkTrue(is.null(runQuery(0123456789, "gene")))
	checkTrue(is.null(protQuery("doesNotExist", verbose = FALSE)))
	checkTrue(is.null(geneQuery(0123456789, verbose = FALSE)))
}