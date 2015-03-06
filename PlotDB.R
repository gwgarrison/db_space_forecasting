PlotDatabaseSpace <- function (x, db.name, 
                               size.threshold = 1024, exclusions = c("TEMP")
                               ,chart.type = "facet", output.screen= TRUE,
                                output.file = "db_space.png") {
  
  
  library(ggplot2)
  # make R less likely to use Scientific Notation
  options(scipen=5)
  
  t <- x[x$db_name == db.name & x$size_mb > size.threshold
           & !(x$tablespace_name %in% exclusions),]

  g <- ggplot(t,aes(date_key,size_mb)) + geom_line(aes(color = tablespace_name)) + 
    labs(title = paste(db.name, "Report for Tablespaces Over ",size.threshold," MB in Size")) +
    labs(x = "Date", y = "Size MB")# + theme(legend.title = "Tablespace")
 
  if (chart.type == "facet") {
    g <- g + facet_grid(. ~ tablespace_name) + theme(legend.position="none")
  } else {
    g <- g + labs(color="Tablespace")
  }

  if (output.screen == TRUE){
    g 
  } else {
    ggsave(filename = output.file,plot = g)
  }
  
  
  # add code to create a file
  
}


