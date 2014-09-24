############ Introduction to dplyr ##############

install.packages("dplyr")
suppressPackageStartupMessages(library(dplyr))
library(dplyr)

gd_url <- "http://tiny.cc/gapminder"
gdf <- read.delim(file = gd_url)


### General Information

str(gdf)

head(gdf) # show first few lines

gtbl <- tbl_df(gdf) # data frame, display just first few lines
gtbl

glimpse(gtbl) # display the class of "gtbl"


### I just want data for CANADA!

(snippet <- subset(gdf, country == "Canada"))

### "filter" to subset data row-wise

filter(gtbl, lifeExp < 29)
filter(gtbl, country=="Rwanda")
filter(gtbl, country %in% c("Rwanda", "Afghanistan"))

gdf[gdf$lifeExp < 29, ] ## repeat `gdf`, [i, j] indexing is distracting
subset(gdf, country == "Rwanda") ## almost same as filter ... but wait ...

### pipe operator %>% by "Shift+Control+M"
#equivalent to "head(gdf)"
gdf %>% head 

###
select(gtbl, year, lifeExp) ## tbl_df prevents TMI from printing

gtbl %>%
  select(year, lifeExp) %>%
  head(4)

gtbl %>%
  filter(country == "Cambodia") %>%
  select(year, lifeExp)
# same as in normal R:
gdf[gdf$country == "Cambodia", c("year", "lifeExp")]
# same a subset in normal R:
subset(gdf, country == "Cambodia", select = c(year, lifeExp))




########## dplyr functions for a single dataset #############

suppressPackageStartupMessages(library(dplyr))
gd_url <- "http://tiny.cc/gapminder"
gtbl <- gd_url %>% read.delim %>% tbl_df
gtbl %>% glimpse

# Use mutate() to add new variables
gtbl <- gtbl %>%
  mutate(gdp = pop * gdpPercap)
gtbl %>% glimpse

    # use CANADA as base for GDP comparison
just_canada <- gtbl %>% filter(country == "Canada")
gtbl <- gtbl %>%
  mutate(canada = just_canada$gdpPercap[match(year, just_canada$year)], #create a new variable "canada" which repeats the gdpPercap of canada correspond to the years
         gdpPercapRel = gdpPercap / canada) #define new variabe measuring the real gdp per capita

gtbl %>%
  select(country, year, gdpPercap, canada, gdpPercapRel)

gtbl %>%
  select(gdpPercapRel) %>%
  summary

# order data
gtbl %>%
  arrange(year, country) # arrange by year first then country

gtbl %>%
  filter(year == 2007) %>%
  arrange(lifeExp)  # accending order by life expectancy

gtbl %>%
  filter(year == 2007) %>%
  arrange(desc(lifeExp)) # decending order by life expectancy

# rename variables 
#### not working right now! waiting for updated version!
gtbl <- gtbl %>%
  rename(life_exp = lifeExp, gdp_percap = gdpPercap,   #try "rename_vars"
         gdp_percap_rel = gdpPercapRel)
gtbl %>% glimpse

# counting 
gtbl %>%
  group_by(continent) %>%
  summarize(n_obs = n())
