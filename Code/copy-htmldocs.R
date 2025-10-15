
cat(commandArgs(), fill = TRUE)

options(warn = 1)

## Data source via HTTP[S]: Can point to github (slower) or to a git
## clone served locally (see README)

## RAWDATALOC <- "https://raw.githubusercontent.com/deepayan/nhanes-snapshot/main/"
RAWDATALOC <- "http://192.168.1.173:9849/snapshot/"

RAWDATASRC <- paste0(RAWDATALOC, "docs/")

htmlfiles <- readLines(paste0(RAWDATASRC, "MANIFEST.txt"))
htmlfiles <- htmlfiles[!endsWith(htmlfiles, "All Years.htm")]

## adjust path to match CDC web layout

htmlfiles <- file.path("/htmldoc/Nchs/Data/Nhanes/Public", htmlfiles)
htmldirs <- unique(dirname(htmlfiles))
cat(htmldirs)
sapply(htmldirs, dir.create, recursive = TRUE)

for (f in htmlfiles) {
    cat("=== Copying ", f, "...\n")
    download.file(paste0(RAWDATASRC, gsub("/htmldoc/Nchs/Data/Nhanes/Public/", "", f)),
                  destfile = f)
}

