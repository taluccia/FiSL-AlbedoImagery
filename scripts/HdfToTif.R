library(gdalUtils)
library(sf)
years = seq(2018, 2018, 1)
in_path <- "../inputs/test"
out_path <- "../outputs/test"
dir.create(out_path, recursive = T)
for(y in years){
  #loop through and export
  for(folder in dir(file.path(in_path, y))){
    
    all_files <- list.files(file.path(in_path, y, folder), pattern='hdf$', full.names = TRUE)
    
    for (f in all_files){
      
      # out_name <- unlist(str_split(f, '/'))[13]
      out_name <- unlist(str_split(f, '/'))[10]
      
      albedo_out <- gsub(".hdf", "_albedo.tif", out_name)
      quality_out <- gsub(".hdf", "_quality.tif", out_name)
      #get subdatasets
      sds <- get_subdatasets(f)
      
      #get white sky shortwave
      wsa <- sds[4]
      
      #get white sky quality flage
      wsaq <- sds[7]
      
      gdal_translate(wsa, file.path(out_path, albedo_out))
      gdal_translate(wsaq, file.path(out_path, quality_out))
      
      print (f)
      
      file.remove(file.path(in_path, folder, f))
    }
  }
}
