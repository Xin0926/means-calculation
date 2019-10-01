Hour <- rep(c(0:23),5113)
Day <- c(
  rep(c(rep(1:31, each=24),rep(1:28, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24)),3),
  rep(1:31, each=24),rep(1:29, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),
  rep(c(rep(1:31, each=24),rep(1:28, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24)),3),
  rep(1:31, each=24),rep(1:29, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),
  rep(c(rep(1:31, each=24),rep(1:28, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24)),3),
  rep(1:31, each=24),rep(1:29, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),
  rep(c(rep(1:31, each=24),rep(1:28, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24),rep(1:30, each=24),rep(1:31, each=24)),2))

Month <- c(
  rep(c(rep(1,744),rep(2,672),rep(3,744),rep(4,720),rep(5,744),rep(6,720),rep(7,744),rep(8,744),rep(9,720),rep(10,744),rep(11,720),rep(12,744)),3),
  rep(1,744),rep(2,696),rep(3,744),rep(4,720),rep(5,744),rep(6,720),rep(7,744),rep(8,744),rep(9,720),rep(10,744),rep(11,720),rep(12,744),
  rep(c(rep(1,744),rep(2,672),rep(3,744),rep(4,720),rep(5,744),rep(6,720),rep(7,744),rep(8,744),rep(9,720),rep(10,744),rep(11,720),rep(12,744)),3),
  rep(1,744),rep(2,696),rep(3,744),rep(4,720),rep(5,744),rep(6,720),rep(7,744),rep(8,744),rep(9,720),rep(10,744),rep(11,720),rep(12,744),
  rep(c(rep(1,744),rep(2,672),rep(3,744),rep(4,720),rep(5,744),rep(6,720),rep(7,744),rep(8,744),rep(9,720),rep(10,744),rep(11,720),rep(12,744)),3),
  rep(1,744),rep(2,696),rep(3,744),rep(4,720),rep(5,744),rep(6,720),rep(7,744),rep(8,744),rep(9,720),rep(10,744),rep(11,720),rep(12,744),
  rep(c(rep(1,744),rep(2,672),rep(3,744),rep(4,720),rep(5,744),rep(6,720),rep(7,744),rep(8,744),rep(9,720),rep(10,744),rep(11,720),rep(12,744)),2))

Year <- c( rep(c(2005,2006,2007), each=8760),rep(2008,each=8784), rep(c(2009,2010,2011),each=8760), rep(2012,each=8784),rep(c(2013,2014,2015),each=8760),rep(2016,each=8784),  rep(c(2017,2018),each=8760))

heat <- NULL
for(i in seq(1,736128,by=6)){
  vec <- colMeans(tower.flux[c(i:(i+5)),], na.rm=TRUE)
  heat <- rbind(heat, as.data.frame(rbind(vec)))
}
colnames(heat) <- c("heat.3/5m","heat.60m","heat.100m","heat.180m")
heat <- cbind(Year, Month, Day, Hour, heat)
write.table(heat,file=paste0("/Users/xin/Dropbox/Xin/CBW/heat.perhour.csv"),row.names = FALSE)
