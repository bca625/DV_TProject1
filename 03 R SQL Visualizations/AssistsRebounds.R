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
