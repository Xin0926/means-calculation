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

if (1 == 2) {
  # Download the zip to a temporary location
  url <- "https://github.com/Xin0926/means-calculation/raw/master/tower.flux.csv.zip"
  zip_filename <- tempfile(pattern = "tower_flux", fileext = ".zip")
  curl::curl_download(url, destfile = zip_filename)
  testit::assert(file.exists(zip_filename))

  # Unzip the zip
  csv_filename <- utils::unzip(zipfile = zip_filename)
  testit::assert(file.exists(csv_filename))
}

# This is clunky, the code above does download and unzip
tower.flux <- read.csv("tower.flux.csv", sep = "", fill = TRUE, na.strings = "NA")

# Every 10 minutes, a measurement is done
# and stored in a column named H3.5
#
# Goal: summarize the 6 measurements within an hour to an average
#
# For https://stackoverflow.com/a/46661488

library(dplyr)

# Read the column names
names(tower.flux)

# Group by year, month, day, hour, take the mean of each H3.5 per group
mean_tower_flux_per_hour <- tower.flux %>%
    group_by(Year, Month, Day, Hour) %>%
    dplyr::summarize(Mean = mean(H3.5))

# Here ya go!
mean_tower_flux_per_hour

# Use old-skool naming
heat <- mean_tower_flux_per_hour


# Oldskool
if (1 == 2) {
  n_rows <- nrow(tower.flux)
  testit::assert(n_rows %% 6 == 0)

  heat <- NULL
  for(i in seq(1,n_rows,by=6)){
    vec <- colMeans(tower.flux[c(i:(i+5)),], na.rm=TRUE)
    heat <- rbind(heat, as.data.frame(rbind(vec)))
  }
  colnames(heat) <- c("heat.3/5m","heat.60m","heat.100m","heat.180m")
  heat <- cbind(Year, Month, Day, Hour, heat)
  write.table(heat,file=paste0("/Users/xin/Dropbox/Xin/CBW/heat.perhour.csv"),row.names = FALSE)


}



