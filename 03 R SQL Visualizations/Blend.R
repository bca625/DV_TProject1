CBB <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query= "select * from CBB;"
')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_ba7433', PASS='orcl_ba7433', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1=KPI_Low_Max_value, p2=KPI_Medium_Max_value), verbose = TRUE)))

draft <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query= "select * from draft;"
                                                   ')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_ba7433', PASS='orcl_ba7433', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1=KPI_Low_Max_value, p2=KPI_Medium_Max_value), verbose = TRUE)))

rooks <- right_join(CBB,draft,by='PLAYER')
rookies <- rooks %>% mutate(cPPG = PTS.x / G.x) %>% filter(PLAYER != "null")

ggplot(rookies, aes(PLAYER, cPPG, fill=CLASS)) + geom_bar(stat="identity") + coord_flip() + ylab("PPG in College")

ggplot(rookies, aes(PLAYER, round(as.numeric(as.character(PPG), 2)), fill=CLASS)) + geom_bar(stat="identity") + coord_flip() + ylab("PPG in NBA")