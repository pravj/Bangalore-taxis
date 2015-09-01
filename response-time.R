library('ggplot2')

restime_df <- read.csv('./data/restime.csv')

gplot <- ggplot(restime_df, aes(x = 'distance', y = 'duration'))
gplot <- gplot + labs(x = "Distance (KM.)", y = "Duration (Minute)")
gplot + geom_line()