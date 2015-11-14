#Produce Second bar chart, rotated on its side so you can actually read the conferences
ggplot(df, aes(CONF, PTS, fill=POS)) + geom_bar(stat="identity") + geom_hline(yintercept=23425) + coord_flip()