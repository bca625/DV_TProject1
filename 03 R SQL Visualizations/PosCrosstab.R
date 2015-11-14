KPI_Low_Max_value = 3     
KPI_Medium_Max_value = 7

crosstab <- df %>% 
  filter(CONF == "Big 12") %>% 
  group_by(SCHOOL, POS, CLASS) %>% 
  #summarize(sum_pts = sum(PTS), sum_games = sum(G)) %>% 
  mutate(PPG = PTS / G) %>% 
  summarize(avg_pts = mean(PPG)) %>% 
  mutate(kpi = ifelse(avg_pts <= KPI_Low_Max_value, 'Low', ifelse(avg_pts <= KPI_Medium_Max_value, 'Medium', 'High'))) %>% 
  rename(KPI=kpi)

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