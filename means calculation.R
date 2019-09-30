heat <- NULL
for(i in seq(1,736128,by=6)){
  vec <- colMeans(tower.flux[c(i:(i+5)),], na.rm=TRUE)
  heat <- rbind(heat, as.data.frame(rbind(vec)))
}
colnames(heat) <- c("heat.3/5m","heat.60m","heat.100m","heat.180m")
heat <- cbind(Year, Month, Day, Hour, heat)
write.table(heat,file=paste0("/Users/xin/Dropbox/Xin/CBW/heat.perhour.csv"),row.names = FALSE)