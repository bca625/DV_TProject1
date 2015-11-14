#Produce fisrt bar chart, rotated on its side so you can actually read the conferences
ggplot(df, aes(CONF, PTS, fill=CONF)) + geom_bar(stat="identity") + geom_hline(yintercept=23425) + coord_flip()