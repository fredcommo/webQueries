######################
# Helper functions
#####################
.protLink <- function(symbol){
    if(is.numeric(symbol))
        stop("Please, provide either a HUGO symbol or a valid UniProt id.")
    else if(grepl("^P", toupper(symbol)))
        query <- sprintf("%s%%20homo%%20sapiens", symbol)
    else
        query <- sprintf("%s%%5BGene%%20Name%%5D%%20homo%%20sapiens", symbol)
    return(query)
}
.uidLink <- function(symbol){
    sprintf("%s%%5BUID%%5D+AND+%%22homo+sapiens%%22%%5Borganism%%5D", symbol)
}
.symbolLink <- function(symbol){
    sprintf("%s%%5Bsymbol%%5D+AND+%%22homo+sapiens%%22%%5Borganism%%5D", symbol)
}
.query <- function(symbol, db){
    if(all.is.numeric(symbol))
        symbol <- as.numeric(symbol)
    if(is.character(symbol))
        symbol <- toupper(symbol)
    if(db=="protein")
        query <- .protLink(symbol)
    else if(db=="gene" && is.numeric(symbol))
        query <- .uidLink(symbol)
    else
        query <- .symbolLink(symbol)
    return(query)
}
.gsearch <- function (query, db, kTries){
    gsrch.stem <- "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?"
    gsrch.mode <- paste("db=", db, "&retmode=xml","&term=", sep = "")
    URL <- paste(gsrch.stem, gsrch.mode, query, sep = "")
    k = 1
    doc <- try(xmlTreeParse(URL, isURL = TRUE, useInternalNodes = TRUE),
        silent = TRUE)
    while(class(doc)[1] == 'try-error' & k < kTries){
        doc <- try(xmlTreeParse(URL, isURL = TRUE, useInternalNodes = TRUE),
            silent = TRUE)
        k = k + 1
        cat("Connexion error during gsearch - I'm trying again...", k, "\n")
    }
    if(class(doc)[1] == 'try-error')
        stop ('Invalid url, or the connexion is temporarily unavailable.\n
            Check it manually:\n', URL)
    sapply(c("//Id"), xpathApply, doc = doc, fun = xmlValue)
}
.gsummary <- function (id, db, kTries){
    sum.stem <- "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?"
    sum.mode <- paste("db=", db, "&id=", sep = "")
    k = 1
    doc <- try(xmlTreeParse(paste(sum.stem, sum.mode, id, sep = ""),
        isURL = TRUE, useInternalNodes = TRUE), silent = TRUE)
    while(class(doc)[1] == 'try-error' & k < kTries){
        cat("Connexion error during gsummary - I'm trying again...", k, "\n")
        k = k + 1
        doc <- try(xmlTreeParse(paste(sum.stem, sum.mode, id, sep = ""),
            isURL = TRUE, useInternalNodes = TRUE), silent = TRUE)
    }
    items <- unlist(sapply(c("//Item"), xpathApply, doc = doc,
        fun = xmlGetAttr, name="Name")[1:30])
    values <- unlist(sapply(c("//Item"), xpathApply, doc = doc,
        fun = xmlValue)[1:30])
    names(values) <- items
    return(values)
}
.filtCol <- function(outList){
    isnull <- sapply(outList, function(tmp) is.null(tmp))
    items <- lapply(outList[!isnull], function(tmp) names(tmp))
    cmon <- Reduce(function(x, y) intersect(x, y), items)
    filtList <- lapply(outList, function(tmp) tmp[cmon])
    return(filtList)
}
######################
# Main function
#####################
runQuery <- function(symbol, db, bySymbol=TRUE, updateOnly=TRUE, ktries=10){
    if(db=="protein" || db=="snp")
        bySymbol <- TRUE
    if(bySymbol){
        query <- .query(symbol, db)
        ids <- .gsearch(query, db, ktries)
        if(length(unlist(ids))==0)
            return(NULL)
    }
    else
        ids <- symbol
    out <- lapply(ids, function(id){
        tmp <- .gsummary(id, db, ktries)
        if(is.null(tmp))
            return(NULL)
        else
            return(c(query=symbol, tmp, GI=id))
    })
    if(length(out)>1)
        out <- .filtCol(out)
    if(length(out)==0)
        return(NULL)
    out <- as.data.frame(do.call(rbind, out))
    if(updateOnly)
        out <- out[1,]
    return(out)
}
multiQueries <- function(List, db, bySymbol = TRUE, updateOnly=TRUE,
    ktries = 10, verbose=TRUE){
    annots <- lapply(List, function(id){
        id <- as.character(id)
        if(verbose) cat("Searching", id, "\n")
        runQuery(id, db, bySymbol, ktries)
    }
    )
    annots <- .filtCol(annots)
    annots <- as.data.frame(do.call(rbind, annots))
    rownames(annots) <- seq(1, nrow(annots))
    return(annots)
}

