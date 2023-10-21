library(gdalUtils)
library(sf)
library(rgdal)
# Provides detailed data on hdf4 files but takes ages

gdalinfo("../inputs/test/LC08_L1TP_070011_20180911_20180927_01_T1_albedo_broad.hdf")

# Tells me what subdatasets are within my hdf4 MODIS files and makes them into a list

sds <- get_subdatasets("../inputs/test/LC08_L1TP_070011_20180911_20180927_01_T1_albedo_broad.hdf")
sds


# I'm only interested in the first subdataset and I can use gdal_translate to convert it to a .tif

gdal_translate(sds[1], dst_dataset = "NPP2000.tif")

# Load and plot the new .tif

rast <- raster("NPP2000.tif")
plot(rast)

# If you have lots of files then you can make a loop to do all this for you

files <- dir(pattern = ".hdf")
files


filename <- substr(files,11,14)
filename <- paste0("NPP", filename, ".tif")
filename


i <- 1

for (i in 1:15){
  sds <- get_subdatasets(files[i])
  gdal_translate(sds[1], dst_dataset = filename[i])
}