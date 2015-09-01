library('ggplot2')

timeline_df <- read.csv('./data/timeline.csv')
timeline_df <- transform(timeline_df, time = as.Date(as.POSIXct(time, origin="1970-01-01")))

gplot <- ggplot(timeline.df, aes(x = time, y = type))
gplot <- gplot + labs(x = "", y = "Vehicle Type", title = "Rise of the vehicles")
gplot <- gplot + geom_point(aes(colour = factor(type)))
gplot <- gplot + scale_x_date(lim = c(as.Date("2014-12-01"), as.Date("2015-09-01")), breaks = date_breaks(width = "1 month"))
gplot <- gplot + geom_point(data = timeline.df, aes(x = time, y = type), size = 1, alpha = 0.9)