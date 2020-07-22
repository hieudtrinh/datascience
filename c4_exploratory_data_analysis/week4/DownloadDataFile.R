# Download data
fromUrl <- "https://spark-public.s3.amazonaws.com/dataanalysis/samsungData.rda"
localFile <- "data/samsungData.rda"

if (!file.exists("data")) dir.create("data")
download.file(fromUrl,destfile = localFile, method = "curl", extra = '-L')


# for pm25_data can be downloaded from here
# for the https://github.com/jtleek/modules/tree/master/04_ExploratoryAnalysis/CaseStudy/pm25_data
if (!file.exists("pm25_data")) dir.create("pm25_data")
download.file("https://github.com/jtleek/modules/tree/master/04_ExploratoryAnalysis/CaseStudy/pm25_data/RD_501_88101_1999-0.txt", "pm25_data/RD_501_88101_1999-0.txt", method = "curl", extra = '-L')
download.file("https://github.com/jtleek/modules/tree/master/04_ExploratoryAnalysis/CaseStudy/pm25_data/RD_501_88101_2012-0.txt", "pm25_data/RD_501_88101_2012-0.txt", method = "curl", extra = '-L')
