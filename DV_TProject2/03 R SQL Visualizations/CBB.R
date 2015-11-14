require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)

# The following is equivalent to KPI Story 2 Sheet 2 and Parameters Story 3 in "Crosstabs, KPIs, Barchart.twb"

# These will be made to more resemble Tableau Parameters when we study Shiny.
KPI_Low_Max_value = 3     
KPI_Medium_Max_value = 7

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query= "select * from CBB order by pos;"
')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_ba7433', PASS='orcl_ba7433', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1=KPI_Low_Max_value, p2=KPI_Medium_Max_value), verbose = TRUE))); View(df)


#Produce fisrt bar chart, rotated on its side so you can actually read the conferences
ggplot(df, aes(CONF, PTS, fill=CONF)) + geom_bar(stat="identity") + geom_hline(yintercept=23425) + coord_flip()


#Produce Second bar chart, rotated on its side so you can actually read the conferences
ggplot(df, aes(CONF, PTS, fill=POS)) + geom_bar(stat="identity") + geom_hline(yintercept=23425) + coord_flip()

#PNN = Position Not NUll
PNN <- df %>% filter(POS != "null") %>% tbl_df

#Assist by Position
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title='Assists By Position') +
  labs(x="Minutes Played", y=paste("Assists")) +
  layer(data=PNN, 
        mapping=aes(x=MP, y=AST, color=POS), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )

#Rebounds by Position
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title='Rebounds By Position') +
  labs(x="Minutes Played", y=paste("Total Rebounds")) +
  layer(data=PNN, 
        mapping=aes(x=MP, y=TRB, color=POS), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )


#Steals by position
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title='Steals By Position') +
  labs(x="Personal Fouls", y=paste("Steals")) +
  layer(data=PNN, 
        mapping=aes(x=as.numeric(as.character(PF)), y=as.numeric(as.character(STL)), color=POS), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )


#Blocks by Position
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title='Blocks By Position') +
  labs(x="Personal Fouls", y=paste("Blocks")) +
  layer(data=PNN, 
        mapping=aes(x=as.numeric(as.character(PF)), y=as.numeric(as.character(BLK)), color=POS), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )





# df <- diamonds %>% group_by(color, clarity) %>% summarize(sum_price = sum(price), sum_carat = sum(carat)) %>% mutate(ratio = sum_price / sum_carat) %>% mutate(kpi = ifelse(ratio <= KPI_Low_Max_value, '03 Low', ifelse(ratio <= KPI_Medium_Max_value, '02 Medium', '01 High'))) %>% rename(COLOR=color, CLARITY=clarity, SUM_PRICE=sum_price, SUM_CARAT=sum_carat, RATIO=ratio, KPI=kpi)




crosstab <- df %>% 
  filter(CONF == "Big 12") %>% 
  group_by(SCHOOL, POS, CLASS) %>% 
  #summarize(sum_pts = sum(PTS), sum_games = sum(G)) %>% 
  mutate(PPG = PTS / G) %>% 
  summarize(avg_pts = mean(PPG)) %>% 
  mutate(kpi = ifelse(avg_pts <= KPI_Low_Max_value, 'Low', ifelse(avg_pts <= KPI_Medium_Max_value, 'Medium', 'High'))) %>% 
  rename(KPI=kpi)

#Poits by Classification in the Big 12
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  labs(title='Points by Classification in the Big 12') +
  labs(x=paste("SCHOOL"), y=paste("CLASS")) +
  layer(data=crosstab, 
        mapping=aes(x=SCHOOL, y=CLASS, label=round(avg_pts, 2)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black"), 
        position=position_identity()
  ) +
  layer(data=crosstab, 
        mapping=aes(x=SCHOOL, y=CLASS, fill=KPI), 
        stat="identity", 
        stat_params=list(), 
        geom="tile",
        geom_params=list(alpha=0.50), 
        position=position_identity()
  )



#Points by Position
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  labs(title='Points by Position in the Big 12') +
  labs(x=paste("SCHOOL"), y=paste("POSITION")) +
  layer(data=crosstab, 
        mapping=aes(x=SCHOOL, y=POS, label=round(avg_pts, 2)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black"), 
        position=position_identity()
  ) +
  layer(data=crosstab, 
        mapping=aes(x=SCHOOL, y=CLASS, fill=KPI), 
        stat="identity", 
        stat_params=list(), 
        geom="tile",
        geom_params=list(alpha=0.50), 
        position=position_identity()
  )





CBB <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query= "select * from CBB;"
')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_ba7433', PASS='orcl_ba7433', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1=KPI_Low_Max_value, p2=KPI_Medium_Max_value), verbose = TRUE))); View(df)

draft <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query= "select * from draft;"
')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_ba7433', PASS='orcl_ba7433', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1=KPI_Low_Max_value, p2=KPI_Medium_Max_value), verbose = TRUE))); View(df)

rooks <- right_join(CBB,draft,by='PLAYER')
rookies <- rooks %>% mutate(cPPG = PTS.x / G.x) %>% filter(PLAYER != "null")

ggplot(rookies, aes(PLAYER, cPPG, fill=CLASS)) + geom_bar(stat="identity") + coord_flip() + ylab("PPG in College")

ggplot(rookies, aes(PLAYER, round(as.numeric(as.character(PPG), 2)), fill=CLASS)) + geom_bar(stat="identity") + coord_flip() + ylab("PPG in NBA")


