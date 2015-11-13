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
ggplot(df, aes(CONF, PTS, fill=POS)) + geom_bar(stat="identity") + coord_flip()

