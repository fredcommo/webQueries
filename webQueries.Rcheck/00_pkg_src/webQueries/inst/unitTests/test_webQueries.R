test_geneQueries <- function(){
	checkEquals(gettext(geneQuery("erbb2", verbose = FALSE)[2]), "ERBB2")
	checkEquals(gettext(geneQuery("ERBB2", verbose = FALSE)[2]), "ERBB2")
	checkEquals(gettext(geneQuery(2064, verbose = FALSE)[16]), "2064")
}
test_protQueries <- function(){
	checkEquals(gettext(protQuery("erbb2", verbose = FALSE)[4]), "P04626")
	checkEquals(gettext(protQuery("ERBB2", verbose = FALSE)[4]), "P04626")
	checkEquals(gettext(protQuery("P04626", verbose = FALSE)[4]), "P04626")
}
test_badQueries <- function(){
	checkTrue(is.null(geneQuery("doesNotExist", verbose = FALSE)))
	checkTrue(is.null(geneQuery(0123456789, verbose = FALSE)))
	checkTrue(is.null(protQuery("doesNotExist", verbose = FALSE)))
	checkTrue(is.null(geneQuery(0123456789, verbose = FALSE)))
}