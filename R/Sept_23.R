#install.packages("tidyverse")
library(tidyverse)

temp <- read.csv("/Users/sahandfarhoodi/BU/Fall_2019/TA_Accelerated_Statistics/R/temperature.csv", sep=",", header=TRUE) %>%
  filter(deg<500) %>% mutate(year=floor(date))

n <- 1000
temp_sample <- bind_rows(
  temp %>% filter(year==1990) %>% sample_n(n) %>% mutate(sample="1990"),
  temp %>% filter(year==2005) %>% sample_n(n) %>% mutate(sample="2005"),
  temp %>% sample_n(n) %>% mutate(sample="All1"),
  temp %>% sample_n(n) %>% mutate(sample="All2"))

# Looking at histograms
ggplot(temp_sample, aes(x=deg)) + geom_histogram(bins=20) + facet_wrap(~sample)
ggplot(temp_sample, aes(x=deg)) + geom_histogram(bins=100) + facet_wrap(~sample)

# Looking at kernel methods
ggplot(temp_sample, aes(x=deg)) + geom_density() + facet_wrap(~sample)
ggplot(temp_sample, aes(x=deg)) + geom_density(bw=0.5) + facet_wrap(~sample)

# Plotting qq-plot
ggplot(temp_sample, aes(sample=deg, color=sample)) + stat_qq() + facet_wrap(~sample)

# Standardizing deg before plotting qq-plot
temp_sample %>% group_by(sample) %>% mutate(stan_deg = (deg - mean(deg))/sd(deg)) %>% 
  ggplot(aes(sample=stan_deg, color=sample)) + stat_qq() + geom_abline(col="black") + 
  facet_wrap(~sample)

# Looking at ecdf with confidence band of all years
temp_sample %>% ggplot(aes(x=deg, color=sample)) + stat_ecdf() +
  stat_ecdf(position=position_nudge(y=1.36/sqrt(n)), alpha=0.3) +
  stat_ecdf(position=position_nudge(y=-1.36/sqrt(n)), alpha=0.3) +
  facet_wrap(~sample)

# Comparing ecdf of years 1990 and 2005
temp_sample %>% filter(sample %in% c("1990", "2005")) %>% ggplot(aes(x=deg, color=sample)) + stat_ecdf()
  stat_ecdf(position=position_nudge(y=1.36/sqrt(n)), alpha=0.3) +
  stat_ecdf(position=position_nudge(y=-1.36/sqrt(n)), alpha=0.3)

# Comparing ecdf of years All1 and All2
temp_sample %>% filter(sample %in% c("All1", "All2")) %>% ggplot(aes(x=deg, color=sample)) + stat_ecdf()
  stat_ecdf(position=position_nudge(y=1.36/sqrt(n)), alpha=0.3) +
  stat_ecdf(position=position_nudge(y=-1.36/sqrt(n)), alpha=0.3)

# Computing mean of cdf and compare to real mean
sample_temp_summary <- temp_sample %>% group_by(sample) %>% summarize(mean_deg = mean(deg), sd_deg = sd(deg),
  median_deg = median(deg))

temp_summary <- temp %>% filter(year %in% c("1990", "2005")) %>% group_by(year) %>% 
  summarize(mean_deg = mean(deg), sd_deg = sd(deg), median_deg = median(deg))

# Using bootstrap to see the distribution of mean and median
B <- 10000
n <- 100
means = rep(0, B)
medians = rep(0, B)
for (b in 1:B){
  samp <- temp %>% filter(year==1990) %>% sample_n(n) %>% select(deg)
  means[b] = mean(samp$deg)
  medians[b] = median(samp$deg)
}
plot(density(means))
plot(density(medians))

