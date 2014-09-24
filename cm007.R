install.packages("dplyr")
suppressPackageStartupMessages(library(dplyr))
library(dplyr)

gd_url <- "http://tiny.cc/gapminder"
gdf <- read.delim(file = gd_url)

# GEneral Information

str(gdf)

head(gdf) #first few lines

gtbl <- tbl_df(gdf) # data frame and first few lines
gtbl
