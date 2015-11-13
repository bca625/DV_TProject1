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
ggplot(df, aes(CONF, PTS, fill=CONF)) + geom_bar(stat="identity") + coord_flip()


#Produce Second bar chart, rotated on its side so you can actually read the conferences
ggplot(df, aes(CONF, PTS, fill=POS)) + geom_bar(stat="identity") + coord_flip()

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
