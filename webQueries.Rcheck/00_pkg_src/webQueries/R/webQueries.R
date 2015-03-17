
##################
# REQUIRED FILES
load(system.file("extdata", "hg19.rda", package="webQueries"))


##################
# MAIN FUNCTIONS
geneQuery <- function(geneId, DB = "gene", bySymb = TRUE, kTries = 10,
        verbose = TRUE){
    ow <- options("warn")
    options(warn = -1)
    cumLen <- hg19$cumLength
    Sys.sleep(0.01)
    if(is.numeric(geneId))
        bySymb <- FALSE
    entrezId <- NA
    if(bySymb){
        query <- toupper(geneId)
        ids <- unlist(.gsearch(paste0(query, "%5Bsymbol%5D%20homo%20sapiens"),
            DB, kTries))
        if(is.null(ids)){
            if(verbose)
                cat( sprintf("*** \"%s\" not found! ***\n", query) )
            return(NULL)
        }
        else{
            if(verbose)
                cat(query, "found:", length(ids), "id(s)...\t")
            j = 1
            id <- ids[j]
            geneSummary <- .gsummary(id, DB = DB, kTries)
            if(length(ids)>1){
                while (!.checkSummary(query, geneSummary) & j < length(ids)){
                    j = j + 1
                    id <- ids[j]
                    geneSummary <- .gsummary(id, DB = DB, kTries)
                }
            }
            if(.checkSummary(query, geneSummary)){
                out <- .getSummary(geneSummary, cumLen)
                entrezId <- as.numeric(id)
                if(verbose)
                    cat('Done.\n')
                return(
                    c("query"=query, out, "entrezgeneId"=as.numeric(entrezId))
                )
            }
        }
    }
    else{
        geneSummary <- .gsummary(geneId, DB = DB, kTries)
        if(is.null(geneSummary))
            return(NULL)
        out <- .getSummary(geneSummary, cumLen)
        entrezId <- as.numeric(geneId)
        return(c("query" = geneId, out, "entrezgeneId" = as.numeric(entrezId)))
    }
    options(ow)
    return(NULL)
}

protQuery <- function(protId, DB="protein", kTries=10, verbose=TRUE){
    protId <- toupper(protId)
    query <- .protLink(protId)
    ids <- unlist(.gsearch(query, DB, kTries))
    if(is.null(ids)){
        if(verbose)
            cat(sprintf("*** \"%s\"", protId), "not found! ***\n")
        return(NULL)
    }
    else{
        if(verbose)
            cat(protId, "found:", length(ids), "id(s)...\n")
        gsummary <- .gsummary(ids[1], DB, kTries)
        return(c(query=protId, .getProtValues(gsummary)))
    }
}

##################
# HELPER FUNCTIONS

.gsearch <- function (query, DB, kTries){
    gsrch.stem <- "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?"
    gsrch.mode <- paste("db=", DB, "&retmode=xml","&term=", sep = "")
    URL <- paste(gsrch.stem, gsrch.mode, query, sep = "")
    k = 1
    doc <- try(xmlTreeParse(URL, isURL = TRUE, useInternalNodes = TRUE),
        silent = TRUE)
    while(class(doc)[1] == 'try-error' & k <= kTries){
        doc <- try(xmlTreeParse(URL, isURL = TRUE, useInternalNodes = TRUE),
            silent = TRUE)
        k = k + 1
        cat("Connexion error during gsearch - I'm trying again...", k, "\n")
    }
    if(class(doc)[1] == 'try-error')
        stop ('Connection temporarily unavailable. Check it manually:\n', URL)
    sapply(c("//Id"), xpathApply, doc = doc, fun = xmlValue)
}
.gsummary <- function (id, DB, kTries){
    sum.stem <- "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?"
    sum.mode <- paste("db=", DB, "&id=", sep = "")
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
.getValue <- function(dat, item=NULL){
    if(item %in% names(dat))
        return(gettext(dat[item]))
    return(NA)
}
.getChr <- function(geneSummary){
    chr <- .getValue(geneSummary, "Chromosome")
    if(chr == "")
        chr <- NA
    if(!is.na(chr) & chr == "X")
        chr <- 23
    if(!is.na(chr) & chr == "Y")
        chr <- 24
    if(!is.na(chr) & chr == "X, Y")
        chr <- 23
    return(as.numeric(chr))
}
.getChrLoc <- function(geneSummary){
    chrAccVer <- .getValue(geneSummary, "ChrAccVer")
    chrStart <- as.numeric(.getValue(geneSummary, "ChrStart"))
    chrEnd <-  as.numeric(.getValue(geneSummary, "ChrStop"))
    return(
        cbind.data.frame(chrAccVer = chrAccVer,
        chrStart = chrStart, chrEnd = chrEnd)
        )
}
.getSummary <- function(geneSummary, cumLen){
    chr <- .getChr(geneSummary)
    geneLoc <- .getChrLoc(geneSummary)
    return(
        c(symbol = .getValue(geneSummary, "Name"),
        fullName = .getValue(geneSummary, "NomenclatureName"),
        alias = .getValue(geneSummary, "OtherAliases"),
        organism = .getValue(geneSummary, "ScientificName"),
        verifId = .getValue(geneSummary, "Status"),
        status = .getValue(geneSummary, "NomenclatureStatus"),
        chr = chr,
        cytoband = .getValue(geneSummary, "MapLocation"),
        exonCount = .getValue(geneSummary, "ExonCount"),
        accVersion = as.character(geneLoc$chrAccVer),
        chrStart = geneLoc$chrStart,
        chrEnd = geneLoc$chrEnd,
        genomStart = geneLoc$chrStart + cumLen[chr],
        genomEnd = geneLoc$chrEnd + cumLen[chr]
        )
    )
}
.checkSummary <- function(query, geneSummary){
    symbol <- .getValue(geneSummary, "Name") 
    alias <- .getValue(geneSummary, "OtherAliases")
    alias <- unlist(strsplit(alias, ', '))
    correctSymbol <- toupper(query) %in% c(symbol, alias)
    official <- .getValue(geneSummary, "NomenclatureStatus") == "Official"
    return(correctSymbol && official)
}
.protLink <- function(symbol){
    if(grepl("P\\d+", symbol))
        return(sprintf("%s%%20homo%%20sapiens", symbol))
    else
        return(sprintf("%s%%5BGene%%20Name%%5D%%20homo%%20sapiens", symbol))
}
.recName <- function(recname){
    rec <- alt <- NA
    recsplit <- unlist(strsplit(recname, "; "))
    if(any(grepl("RecName", recsplit)))
        rec <- gsub("(RecName: Full=)(.*)", "\\2",
            recsplit[grep("RecName", recsplit)])
    if(any(grepl("AltName", recsplit))){
        ii <- grep("AltName", recsplit)
        alt <- lapply(ii, function(kk) gsub("(AltName: )(.*)=(.*)", "\\3",
            recsplit[kk]) )
        alt <- Reduce(function(x, y) paste(x, y, sep="|"), alt)
    }
    return(c(recName=as.character(rec), altName=as.character(alt)) )
}
.getProtValues <- function(gsummary){
    return(
        c(.recName(gsummary["Title"]),
        UniProt = .getValue(gsummary, "Caption"),
        Gi = .getValue(gsummary, "Gi"),
        Extra = .getValue(gsummary, "Extra"),
        lengthAA = .getValue(gsummary, "Length")
        )
    )
}

