setwd("C:/Users/Gary/Google Drive/R")
library(ggplot2)
library(psych)
library(lubridate)
library(zoo)
library(gridExtra)


#tbs<-read.csv("tbs_fc.csv",header=F)
tbs<-read.csv("tbs.csv",header=F,stringsAsFactors=FALSE)
names(tbs) <- c("db_name","tablespace_name","date_key","size_mb","used_mb","free_mb","pct_used","max_mb","pct_max_used")
tbs$date_key <- dmy(as.character(tbs$date_key))
tbs$tablespace_name<- factor(tbs$tablespace_name)

# call function that creates graph
exclusions <- c("TEMP","UNDOTBS1")

source("PlotDB.R")
PlotDatabaseSpace(tbs,"MVNO",2100,exclusions,chart.type = 'line',output.screen = FALSE,output.file = "mvno.png")

PlotDatabaseSpace(tbs,"MVNO",2100,exclusions,chart.type = 'facet',output.screen = T,output.file = "mvno.png")
PlotDatabaseSpace(tbs,"RAC",2100,exclusions,chart.type = 'facet',output.screen = T,output.file = "mvno.png")

PlotDatabaseSpace(tbs,"FCPROD",150000,output.screen = TRUE,output.file = "FCPROD.png")

