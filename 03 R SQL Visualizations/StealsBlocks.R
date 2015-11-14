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