# This R file contains common function to be used by other R programs

downloadF <- function(fromUrl, fileName, directory = "data") {
    # create data sub-directory data store if needed
    
    if (!file.exists(directory)) {
        dir.create(directory)
    }
    pathName <- paste(directory, fileName, sep = "/")
    download.file(fromUrl, destfile = pathName, method = "curl")
    downloadedDate <- date()
    print(downloadedDate)
    pathName
}

