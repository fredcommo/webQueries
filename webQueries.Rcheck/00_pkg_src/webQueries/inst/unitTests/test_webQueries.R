test_geneQueries <- function(){
	checkEquals(gettext(tmp <- runQuery("erbb2", "gene")$Name), "ERBB2")
	checkEquals(gettext(tmp <- runQuery("ERBB2", "gene")$Name), "ERBB2")
	checkEquals(gettext(tmp <- runQuery(2064, "gene", bySymbol=FALSE)$Name), "ERBB2")
}
test_protQueries <- function(){
	checkEquals(gettext(tmp <- runQuery("erbb2", "protein")$Caption[1]), "P04626")
	checkEquals(gettext(tmp <- runQuery("ERBB2", "protein")$Caption[1]), "P04626")
	checkEquals(gettext(tmp <- runQuery("P04626", "protein")$Caption[1]), "P04626")
}
test_snpQueries <- function(){
	checkTrue(nrow(tmp <- runQuery("erbb2", "snp"))>0)
	checkTrue(nrow(tmp <- runQuery("2064", "snp"))>0)
	checkTrue(nrow(tmp <- runQuery(2064, "snp"))>0)
}
test_badQueries <- function(){
	checkTrue(is.null(tmp <- runQuery("doesNotExist", "gene")))
	checkTrue(is.null(tmp <- runQuery(0123456789, "gene")))
	checkTrue(is.null(tmp <- runQuery("doesNotExist", "protein")))
	checkTrue(is.null(tmp <- runQuery("doesNotExist", "snp")))
}