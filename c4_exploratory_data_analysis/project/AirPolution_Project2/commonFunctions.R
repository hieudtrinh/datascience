downloadAndUnzipData <- function(datadir) {
    # Download database from the National Emissions Inventory (NEI) website
    fromUrl <-
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    zipFilePath <- "data/NEI_data.zip"
    if (!file.exists(datadir)) {
        dir.create(datadir)
    }
    
    if (!file.exists(zipFilePath)) {
        download.file(fromUrl,
                      destfile = zipFilePath,
                      method = "curl",
                      extra = '-L')
    }
    
    # Unxip file
    unzip(zipFilePath, exdir = datadir)
}
