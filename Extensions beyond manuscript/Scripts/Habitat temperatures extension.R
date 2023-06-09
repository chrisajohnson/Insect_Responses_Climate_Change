#############################################################################
#### This R script fits sinusoidal functions to habitat temperature data ####
#############################################################################

# Load packages and set working directory
library(tidyr)
library(ggplot2)
library(dplyr)
library(tidyverse)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# USER: enter location
location <- "US Ithaca"

# INPUT DATA
# Select a location by removing # in front of name and placing # in front of other locations
data.h <- as.data.frame(read_csv(paste0("Climate data/Historical climate data ",location,".csv")))
data.f <- as.data.frame(read_csv(paste0("Climate data/Future climate data ",location,".csv")))

# REMOVE DAILY MINIMUM TEMPERATURES
#data.h <- data.h[data.h$day %% 1 != 0,]
#data.f <- data.f[data.f$day %% 1 != 0,]

# AVERAGE DAILY MINIMUM AND MAXIMUM TEMPERATURES
# historical
data.h$day <- floor(data.h$day)
data.h.min <- data.h[duplicated(data.h$day),]
data.h.max <- data.h[duplicated(data.h$day, fromLast=TRUE),]
data.h <- data.frame(data.h.min$day, (data.h.min$T + data.h.max$T)/2)
names(data.h) <- c("day", "T")
# future
data.f$day <- floor(data.f$day)
data.f.min <- data.f[duplicated(data.f$day),]
data.f.max <- data.f[duplicated(data.f$day, fromLast=TRUE),]
data.f <- data.frame(data.f.min$day, (data.f.min$T + data.f.max$T)/2)
names(data.f) <- c("day", "T")



#################################### HISTORICAL CLIMATE #####################################
# Fit sinusoidal function with annual temperature variation to climate data
(fit.h <- summary(nls(T ~ meanT - amplT*cos(2*pi*(day + shiftT)/365), data = data.h,
                      start = list(meanT = 300, amplT = 1, shiftT = 30))))

# Fit sinusoidal function with annual temperature variation to climate data (delta_mean and delta_ampl)
#(fit.h <- summary(nls(T ~ (meanT + delta_mean*day) - (amplT + delta_ampl*day)*cos(2*pi*(day + shiftT)/365), data = data.h,
#                      start = list(meanT = 300, amplT = 1, shiftT = 30, delta_mean = 0.1, delta_ampl = 0.1))))

# Then estimate diurnal variation as average daily difference between Tmax and Tmin
# diurnal.h <- 0
# count.h <- 0
# l <- nrow(data.h)-1
# for(i in 1:l){
#   if(round(data.h[i+1,"day"]-0.1,0) == round(data.h[i,"day"]-0.1,0)) {
#     diurnal.h <- diurnal.h + data.h[i+1,"T"] - data.h[i,"T"]
#     count.h <- count.h + 1 }}
#(diurnal.h <- diurnal.h/count.h)

# Fit sinusoidal function with annual and diurnal temperature variation to climate data
# estimating all parameters (underestimates temperature variation)
# fit.h2 <- nls(T ~ (meanT + delta_mean*day) - (amplT + delta_ampl*day)*cos(2*pi*(day + shiftT)/365) - amplD*cos(2*pi*day),
#              data = data.h, start = list(meanT = 300, amplT = 5, shiftT = 30, amplD = 5, delta_mean = 0.1, delta_ampl = 0.1))
# summary(fit.h2)

# Fit sinusoidal function with annual and diurnal temperature variation (no delta parameters)
#fit.h2 <- nls(T ~ meanT - amplT*cos(2*pi*(day + shiftT)/365) - amplD*cos(2*pi*day),
#             data = data.h, start = list(meanT = 300, amplT = 1, shiftT = 30, amplD = 5))
#summary(fit.h2)

# Calculate temperature at start of experiment for census data
start <- 120 # mid-May for Apolygus lucorum (Lu et al. 2008)
coef(fit.h)[1] - coef(fit.h)[2]*cos(2*pi*(start + coef(fit.h)[3])/365)

# Assess whether delta_mean or delta_ampl are significant and if not set to zero
#if(fit.h[["coefficients"]][4,4] > 0.05) { fit.h[["coefficients"]][4,1] <- 0 } # delta_mean
#if(fit.h[["coefficients"]][5,4] > 0.05) { fit.h[["coefficients"]][5,1] <- 0 } # delta_ampl

# Plot (NOTE: plot does not have the resolution to show diurnal variation at large xmax)
xmin <- 0
xmax <- 3650 #round(max(data.h$day),0)
ymin <- round(min(data.h$T),0)
ymax <- round(max(data.h$T),0)+1
ggplot(data.h, aes(x=day, y=T)) + 
  geom_point(size=0.8, color="red") +
  #geom_line(size=0.8) +
  # function describing monthly temperature variation
  geom_function(fun = function(t){coef(fit.h)[1] - coef(fit.h)[2]*cos(2*pi*(t + coef(fit.h)[3])/365)},
                size=0.8, color="black") +
  #  daily maximum
  #geom_function(fun = function(t){coef(fit.h2)[1] - coef(fit.h2)[2]*cos(2*pi*(t + coef(fit.h2)[3])/365) + coef(fit.h2)[4]},
  #              size=0.8, color="black", linetype="longdash") +
  #  daily minimum
  #geom_function(fun = function(t){coef(fit.h2)[1] - coef(fit.h2)[2]*cos(2*pi*(t + coef(fit.h2)[3])/365) - coef(fit.h2)[4]},
  #              size=0.8, color="black", linetype="longdash") +
  # function describing monthly and diurnal temperature variation using diurnal.h
  #geom_function(fun = function(t){coef(fit.h2)[1] - coef(fit.h2)[2]*cos(2*pi*(t + coef(fit.h2)[3])/365) - coef(fit.h2)[4]*cos(2*pi*t)},
  #              size=0.8, color="black", linetype="longdash") +
  # function describing monthly and diurnal temperature variation using diurnal.h (delta_mean and delta_ampl)
  #geom_function(fun = function(t){(coef(fit.h)[1]+coef(fit.h)[4]*t) - (coef(fit.h)[2]+coef(fit.h)[5]*t)*cos(2*pi*(t + coef(fit.h)[3])/365) - diurnal.h*cos(2*pi*t)},
  #              size=0.8, color="black", linetype="longdash") +
  # function describing monthly and diurnal temperature variation via nls fits
  #geom_function(fun = function(t){coef(fit.h2)[1] - coef(fit.h2)[2]*cos(2*pi*(t + coef(fit.h2)[3])/365) - coef(fit.h2)[4]*cos(2*pi*t)},
  #              size=0.8, color="black", linetype="longdash") +
  labs(x="Time (days)", y="Temperature (K)") +
  scale_x_continuous(limits=c(xmin, xmax)) +
  scale_y_continuous(limits=c(ymin, ymax)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_rect(fill="transparent"), plot.background = element_rect(fill="transparent"),
        axis.line = element_line(colour = "black"), legend.position = "none", 
        axis.text = element_text(size=13), axis.title = element_text(size=20))



###################################### FUTURE CLIMATE #######################################
# Fit sinusoidal function with annual temperature variation to climate data
#(fit.f <- summary(nls(T ~ meanT - amplT*cos(2*pi*(day + shiftT)/365), data = data.f,
#                      start = list(meanT = 300, amplT = 1, shiftT = 30))))

# Fit sinusoidal function with annual temperature variation to climate data (delta_mean and delta_ampl)
(fit.f <- summary(nls(T ~ (meanT + delta_mean*day) - (amplT + delta_ampl*day) * cos(2*pi*(day + shiftT)/365), data = data.f,
             start = list(meanT = 300, amplT = 1, shiftT = 30, delta_mean = 0.1, delta_ampl = 0.1))))

# Then estimate diurnal variation as average daily difference between Tmax and Tmin
# diurnal.f <- 0
# count.f <- 0
# l <- nrow(data.f)-1
# for(i in 1:l){
#   if(round(data.f[i+1,"day"]-0.1,0) == round(data.f[i,"day"]-0.1,0)) {
#     diurnal.f <- diurnal.f + data.f[i+1,"T"] - data.f[i,"T"]
#     count.f <- count.f + 1}}
#(diurnal.f <- diurnal.f/count.f)

# Fit sinusoidal function with annual and diurnal temperature variation to climate data
# estimating all parameters (underestimates temperature variation)
# fit.f2 <- nls(T ~ (meanT + delta_mean*day) - (amplT + delta_ampl*day)*cos(2*pi*(day + shiftT)/365) - amplD*cos(2*pi*day),
#              data = data.f, start = list(meanT = 300, amplT = 5, shiftT = 30, amplD = 5, delta_mean = 0.1, delta_ampl = 0.1))
# summary(fit.f2)

# Fit sinusoidal function with annual and diurnal temperature variation (no delta parameters)
# fit.f2 <- nls(T ~ meanT - amplT*cos(2*pi*(day + shiftT)/365) - amplD*cos(2*pi*day),
#               data = data.f, start = list(meanT = 300, amplT = 5, shiftT = 30, amplD = 5))
# summary(fit.f2)

# Assess whether delta_mean or delta_ampl are significant and if not set to zero
#if(fit.f[["coefficients"]][4,4] > 0.05) { fit.f[["coefficients"]][4,1] <- 0 } # delta_mean
#if(fit.f[["coefficients"]][5,4] > 0.05) { fit.f[["coefficients"]][5,1] <- 0 } # delta_ampl

# Plot (NOTE: plot does not have the resolution to show diurnal variation at large xmax)
xmin <- 0
xmax <- 3650
ymin <- round(min(data.f$T),0)
ymax <- round(max(data.f$T),0)+1
ggplot(data.f, aes(x=day, y=T)) + 
  geom_point(size=0.8, color="red") +
  #geom_line(size=0.8) +
  # function describing monthly temperature variation
  geom_function(fun = function(t){(coef(fit.f)[1]+coef(fit.f)[4]*t) - (coef(fit.f)[2]+coef(fit.f)[5]*t)*cos(2*pi*(t + coef(fit.f)[3])/365)},
                size=0.8, color="black") +
  #  daily maximum
  #geom_function(fun = function(t){(coef(fit.f2)[1]+coef(fit.f2)[5]*t) - (coef(fit.f2)[2]+coef(fit.f2)[6]*t)*cos(2*pi*(t + coef(fit.f2)[3])/365) + coef(fit.f2)[4]},
  #              size=0.8, color="black", linetype="longdash") +
  #  daily minimum
  #geom_function(fun = function(t){(coef(fit.f2)[1]+coef(fit.f2)[5]*t) - (coef(fit.f2)[2]+coef(fit.f2)[6]*t)*cos(2*pi*(t + coef(fit.f2)[3])/365) - coef(fit.f2)[4]},
  #              size=0.8, color="black", linetype="longdash") +
  # function describing monthly and diurnal temperature variation using diurnal.f
  #geom_function(fun = function(t){(coef(fit.f2)[1]+coef(fit.f2)[5]*t) - (coef(fit.f2)[2]+coef(fit.f2)[6]*t)*cos(2*pi*(t + coef(fit.f2)[3])/365) - coef(fit.f2)[4]*cos(2*pi*t)},
  #              size=0.8, color="black", linetype="longdash") +
  # function describing monthly and diurnal temperature variation via nls fits
  #geom_function(fun = function(t){coef(fit.f2)[1] - coef(fit.f2)[2]*cos(2*pi*(t + coef(fit.f2)[3])/365) - coef(fit.f2)[4]*cos(2*pi*t)},
  #              size=0.8, color="black", linetype="longdash") +
  labs(x="Time (days)", y="Temperature (K)") +
  scale_x_continuous(limits=c(xmin, xmax)) +
  scale_y_continuous(limits=c(ymin, ymax)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_rect(fill="transparent"), plot.background = element_rect(fill="transparent"),
        axis.line = element_line(colour = "black"), legend.position = "none", 
        axis.text = element_text(size=13), axis.title = element_text(size=20))




# MEAN TEMPERATURE DURING ACTIVE PERIOD (mean T when T > Tmin)
# input temperature response parameters
#TR.data <- as.data.frame(read_csv("Temperature response parameters.csv"))


# Calculate active period in data (T > Tmin)
# T.sum <- 0 # sum of temperatures during active period
# length <- 0 # length of active period
# for(i in 1:nrow(data.f)) {if(data.f[i,"T_K"] > sp.data["Tmin"][[1]])
#   {T.sum <- T.sum + data.f[i,"T_K"]
#   length <- length + 1}
# }
# meanT.active <- T.sum/length
# meanT.active
# 
# 
# # Calculate active period in model (T(t) > Tmin)
# yr <- 365
# # temperature function
# T <- function(t) (coef(fit.f)[1] - coef(fit.f)[2] * cos(2*pi*(t + coef(fit.f)[3])/yr))[[1]]
# tStart <- 0 # start of active period
# tEnd <- 0 # end of active period
# T.active <- 0 # sum of temperatures during active period
# for(i in 0:yr) {
#   if(T(i) > sp.data["Tmin"] & tStart == 0) {tStart <- i}
#   if(T(i) > sp.data["Tmin"]) {tEnd <- i
#     T.active <- T.active + T(i)}
# }
# meanT.active <- T.active/(tEnd-tStart)
# tStart
# tEnd
# meanT.active
# coef(fit.f)[1][[1]] # meanT during future period


