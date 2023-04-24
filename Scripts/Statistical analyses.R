#############################################################################
#### This R script analyzes thermal performance curve and DDE model data ####
#############################################################################


# Load packages and set working directory
library(tidyverse)
library(ggplot2)
library(cowplot)

# Set working directory (if neccessary)
#setwd() # enter working directory of main downloaded file (containing R project file)

# Read in predictions from "Model TPC analyses.R"
r.data <- as.data.frame(read_csv("Predictions/Predictions rm.csv"))
R0.data <- as.data.frame(read_csv("Predictions/Predictions R0.csv"))
b.data <- as.data.frame(read_csv("Predictions/Predictions birth.csv"))
g.data <- as.data.frame(read_csv("Predictions/Predictions development.csv"))
s.data <- as.data.frame(read_csv("Predictions/Predictions survival.csv"))
l.data <- as.data.frame(read_csv("Predictions/Predictions longevity.csv"))
# Population dynamics
pop.data <- as.data.frame(read_csv("Predictions/Predictions population dynamics.csv"))


######################################## STATISTICS #########################################
# FITNESS
# Model vs Latitude (Fig. 3a)
r.lat <- lm(delta.model ~ Latitude, data=r.data)
summary(r.lat) # significant!
# Correlation (Fig. 4a)
r.delta <- lm(delta.TPC ~ delta.model, data=r.data)
summary(r.delta) # significant!

# R0
# Model vs Latitude (Fig. 3b)
R0.lat <- lm(delta.model ~ Latitude, data=R0.data)
summary(R0.lat) # significant!
# Correlation (Fig. 4b)
R0.delta <- lm(delta.TPC ~ delta.model, data=R0.data)
summary(R0.delta) # significant!

# SURVIVAL
# Model vs Latitude (Fig. 3c)
s.lat <- lm(delta.model ~ Latitude, data=s.data)
summary(s.lat) # marginally-significant
# Correlation (Fig. 4c)
s.delta <- lm(delta.TPC ~ delta.model, data=s.data)
summary(s.delta)  # significant!

# BIRTH RATE
# Model vs Latitude (Fig. 3d)
b.lat <- lm(delta.model ~ Latitude, data=b.data)
summary(b.lat) # significant!

# DEVELOPMENT TIME
# Model vs Latitude (Fig. 3e)
g.lat <- lm(delta.model ~ Latitude, data=g.data)
summary(g.lat) # significant!
# Correlation (Fig. 4d)
g.delta <- lm(delta.TPC ~ delta.model, data=g.data)
summary(g.delta)  # non-significant

# ADULT LONGEVITY
# Model vs Latitude (Fig. 3f)
l.lat <- lm(delta.model ~ Latitude, data=l.data)
summary(l.lat) # significant!


# POPULATION DYNAMICS
# Mean adult density vs Latitude
mean.lat <- lm(delta.mean ~ Latitude, data=pop.data)
summary(mean.lat) # non-significant

# CV of adult density vs Latitude
CV.lat <- lm(delta.CV ~ Latitude, data=pop.data[-c(14,15,18:20),]) # excluding populations that went extinct
summary(CV.lat) # significant!

# Active period vs Latitude (NOTE: evaluating temperate species only because tropical/subtropical species do not overwinter)
active.lat <- lm(delta.active ~ Latitude, data=pop.data[pop.data$Habitat == "Temperate",])
summary(active.lat) # non-significant



########################################### PLOTS ###########################################
# r_m
# Latitude (Fig. 3a)
Xmin <- 0
Xmax <- 60
Ymin <- -1.05
Ymax <- 0.18
#dev.new(width=3, height=3, unit="in")
plot(-100, xlim=c(Xmin,Xmax), ylim=c(Ymin,Ymax), xlab="Latitude", ylab="Model", cex.axis=2)
abline(0, 0, col="gray", lwd=3, lty="longdash")
points(r.data[r.data$Habitat=="Tropical","Latitude"], r.data[r.data$Habitat=="Tropical","delta.model"], pch=19, cex=1.5, col="#FFB000") # orange
points(r.data[r.data$Habitat=="Subtropical","Latitude"], r.data[r.data$Habitat=="Subtropical","delta.model"], pch=19, cex=1.5, col="#6FD012") # green
points(r.data[r.data$Habitat=="Temperate","Latitude"], r.data[r.data$Habitat=="Temperate","delta.model"], pch=19, cex=1.5, col="#785EF0") # purple
points(seq(Xmin,Xmax,1), coef(r.lat)[2]*seq(Xmin,Xmax,1) + coef(r.lat)[1], type="l", lwd=3, col="black")

# Model vs TPCs (Fig. 4a)
Xmin <- -1.2
Xmax <- 0.2
Ymin <- -1.2
Ymax <- 0.2
#dev.new(width=3, height=3, unit="in")
plot(-100, xlim=c(Xmin,Xmax), ylim=c(Ymin,Ymax), xlab="Model", ylab="TPC", cex.axis=2)
polygon(c(2*Xmin,2*Xmin,2*Xmax),c(2*Ymin,2*Ymax,2*Ymax), col = "#E2E2E2", border = NA)
abline(0, 1, col="gray", lwd=1)
abline(0, 0, col="gray", lwd=3)
abline(v = 0, col="gray", lwd=3)
points(r.data[r.data$Habitat=="Tropical","delta.model"], r.data[r.data$Habitat=="Tropical","delta.TPC"], pch=19, cex=1.5, col="#FFB000") # orange
points(r.data[r.data$Habitat=="Subtropical","delta.model"], r.data[r.data$Habitat=="Subtropical","delta.TPC"], pch=19, cex=1.5, col="#40B0A6") # teal
points(r.data[r.data$Habitat=="Temperate","delta.model"], r.data[r.data$Habitat=="Temperate","delta.TPC"], pch=19, cex=1.5, col="#785EF0") # purple
points(seq(2*Xmin,2*Xmax,0.1), coef(r.delta)[2]*seq(2*Xmin,2*Xmax,0.1)+coef(r.delta)[1], type="l", lwd=3, col="black")


# R0
# Latitude (Fig. 3b)
Xmin <- 0
Xmax <- 60
Ymin <- -0.8
Ymax <- 0.2
#dev.new(width=3, height=3, unit="in")
plot(-100, xlim=c(Xmin,Xmax), ylim=c(Ymin,Ymax), xlab="Latitude", ylab="Model", cex.axis=2)
abline(0, 0, col="gray", lwd=3, lty="longdash")
points(R0.data[R0.data$Habitat=="Tropical","Latitude"], R0.data[R0.data$Habitat=="Tropical","delta.model"], pch=19, cex=1.5, col="#FFB000") # orange
points(R0.data[R0.data$Habitat=="Subtropical","Latitude"], R0.data[R0.data$Habitat=="Subtropical","delta.model"], pch=19, cex=1.5, col="#6FD012") # green
points(R0.data[R0.data$Habitat=="Temperate","Latitude"], R0.data[R0.data$Habitat=="Temperate","delta.model"], pch=19, cex=1.5, col="#785EF0") # purple
points(seq(Xmin,Xmax,1), coef(R0.lat)[2]*seq(Xmin,Xmax,1) + coef(R0.lat)[1], type="l", lwd=3, col="black")

# Model vs TPCs (Fig. 4b)
Xmin <- -0.8
Xmax <- 0.2
Ymin <- -0.8
Ymax <- 0.2
#dev.new(width=3, height=3, unit="in")
plot(-100, xlim=c(Xmin,Xmax), ylim=c(Ymin,Ymax), xlab="Model", ylab="TPC", cex.axis=2)
polygon(c(2*Xmin,2*Xmin,2*Xmax),c(2*Ymin,2*Ymax,2*Ymax), col = "#E2E2E2", border = NA)
abline(0, 1, col="gray", lwd=1)
abline(0, 0, col="gray", lwd=3)
abline(v = 0, col="gray", lwd=3)
points(R0.data[R0.data$Habitat=="Tropical","delta.model"], R0.data[R0.data$Habitat=="Tropical","delta.TPC"], pch=19, cex=1.5, col="#FFB000") # orange
points(R0.data[R0.data$Habitat=="Subtropical","delta.model"], R0.data[R0.data$Habitat=="Subtropical","delta.TPC"], pch=19, cex=1.5, col="#40B0A6") # teal
points(R0.data[R0.data$Habitat=="Temperate","delta.model"], R0.data[R0.data$Habitat=="Temperate","delta.TPC"], pch=19, cex=1.5, col="#785EF0") # purple
points(seq(2*Xmin,2*Xmax,0.1), coef(R0.delta)[2]*seq(2*Xmin,2*Xmax,0.1)+coef(R0.delta)[1], type="l", lwd=3, col="black")


# SURVIVAL
# Latitude (Fig. 3c)
Xmin <- 0
Xmax <- 60
Ymin <- -1
Ymax <- 0.2
#dev.new(width=3, height=3, unit="in")
plot(-100, xlim=c(Xmin,Xmax), ylim=c(Ymin,Ymax), xlab="Latitude", ylab="Model", cex.axis=2)
abline(0, 0, col="gray", lwd=3, lty="longdash")
points(s.data[s.data$Habitat=="Tropical","Latitude"], s.data[s.data$Habitat=="Tropical","delta.model"], pch=19, cex=1.5, col="#FFB000") # orange
points(s.data[s.data$Habitat=="Subtropical","Latitude"], s.data[s.data$Habitat=="Subtropical","delta.model"], pch=19, cex=1.5, col="#6FD012") # green
points(s.data[s.data$Habitat=="Temperate","Latitude"], s.data[s.data$Habitat=="Temperate","delta.model"], pch=19, cex=1.5, col="#785EF0") # purple
points(seq(Xmin,Xmax,1), coef(s.lat)[2]*seq(Xmin,Xmax,1) + coef(s.lat)[1], type="l", lwd=3, col="black", lty="longdash")

# Model vs TPCs (Fig. 4c)
Xmin <- -1
Xmax <- 0.2
Ymin <- -1
Ymax <- 0.2
#dev.new(width=3, height=3, unit="in")
plot(-100, xlim=c(Xmin,Xmax), ylim=c(Ymin,Ymax), xlab="Model", ylab="TPC", cex.axis=2)
polygon(c(2*Xmin,2*Xmin,2*Xmax),c(2*Ymin,2*Ymax,2*Ymax), col = "#E2E2E2", border = NA)
abline(0, 1, col="gray", lwd=1)
abline(0, 0, col="gray", lwd=3)
abline(v = 0, col="gray", lwd=3)
points(s.data[s.data$Habitat=="Tropical","delta.model"], s.data[s.data$Habitat=="Tropical","delta.TPC"], pch=19, cex=1.5, col="#FFB000") # orange
points(s.data[s.data$Habitat=="Subtropical","delta.model"], s.data[s.data$Habitat=="Subtropical","delta.TPC"], pch=19, cex=1.5, col="#40B0A6") # teal
points(s.data[s.data$Habitat=="Temperate","delta.model"], s.data[s.data$Habitat=="Temperate","delta.TPC"], pch=19, cex=1.5, col="#785EF0") # purple
points(seq(2*Xmin,2*Xmax,0.1), coef(s.delta)[2]*seq(2*Xmin,2*Xmax,0.1)+coef(s.delta)[1], type="l", lwd=3, col="black")


# BIRTH RATE
# Latitude (Fig. 3d)
Xmin <- 0
Xmax <- 60
Ymin <- -0.6
Ymax <- 0.2
#dev.new(width=3, height=3, unit="in")
plot(-100, xlim=c(Xmin,Xmax), ylim=c(Ymin,Ymax), xlab="Latitude", ylab="Model", cex.axis=2)
abline(0, 0, col="gray", lwd=3, lty="longdash")
points(b.data[b.data$Habitat=="Tropical","Latitude"], b.data[b.data$Habitat=="Tropical","delta.model"], pch=19, cex=1.5, col="#FFB000") # orange
points(b.data[b.data$Habitat=="Subtropical","Latitude"], b.data[b.data$Habitat=="Subtropical","delta.model"], pch=19, cex=1.5, col="#6FD012") # green
points(b.data[b.data$Habitat=="Temperate","Latitude"], b.data[b.data$Habitat=="Temperate","delta.model"], pch=19, cex=1.5, col="#785EF0") # purple
points(seq(Xmin,Xmax,1), coef(b.lat)[2]*seq(Xmin,Xmax,1) + coef(b.lat)[1], type="l", lwd=3, col="black")

# Model vs TPCs
Xmin <- -0.6
Xmax <- 0.2
Ymin <- -0.6
Ymax <- 0.2
#dev.new(width=3, height=3, unit="in")
plot(-100, xlim=c(Xmin,Xmax), ylim=c(Ymin,Ymax), xlab="Model", ylab="TPC", cex.axis=2)
polygon(c(2*Xmin,2*Xmin,2*Xmax),c(2*Ymin,2*Ymax,2*Ymax), col = "#E2E2E2", border = NA)
abline(0, 1, col="gray", lwd=1)
abline(0, 0, col="gray", lwd=3)
abline(v = 0, col="gray", lwd=3)
points(b.data[b.data$Habitat=="Tropical","delta.model"], b.data[b.data$Habitat=="Tropical","delta.TPC"], pch=19, cex=1.5, col="#FFB000") # orange
points(b.data[b.data$Habitat=="Subtropical","delta.model"], b.data[b.data$Habitat=="Subtropical","delta.TPC"], pch=19, cex=1.5, col="#40B0A6") # teal
points(b.data[b.data$Habitat=="Temperate","delta.model"], b.data[b.data$Habitat=="Temperate","delta.TPC"], pch=19, cex=1.5, col="#785EF0") # purple


# DEVELOPMENT TIME
# Latitude (Fig. 3e)
Xmin <- 0
Xmax <- 60
Ymin <- -5
Ymax <- 0
#dev.new(width=3, height=3, unit="in")
plot(-100, xlim=c(Xmin,Xmax), ylim=c(Ymin,Ymax), xlab="Latitude", ylab="Model", cex.axis=2)
abline(0, 0, col="gray", lwd=3, lty="longdash")
points(g.data[g.data$Habitat=="Tropical","Latitude"], g.data[g.data$Habitat=="Tropical","delta.model"], pch=19, cex=1.5, col="#FFB000") # orange
points(g.data[g.data$Habitat=="Subtropical","Latitude"], g.data[g.data$Habitat=="Subtropical","delta.model"], pch=19, cex=1.5, col="#6FD012") # green
points(g.data[g.data$Habitat=="Temperate","Latitude"], g.data[g.data$Habitat=="Temperate","delta.model"], pch=19, cex=1.5, col="#785EF0") # purple
points(seq(Xmin,Xmax,1), coef(g.lat)[2]*seq(Xmin,Xmax,1) + coef(g.lat)[1], type="l", lwd=3, col="black")

# Model vs TPCs (Fig. 4e)
Xmin <- -5
Xmax <- 0
Ymin <- -5
Ymax <- 0
#dev.new(width=3, height=3, unit="in")
plot(-100, xlim=c(Xmin,Xmax), ylim=c(Ymin,Ymax), xlab="Model", ylab="TPC", cex.axis=2)
polygon(c(2*Xmin,2*Xmin,1),c(2*Xmin,1,1), col = "#E2E2E2", border = NA)
abline(0, 1, col="gray", lwd=1)
abline(0, 0, col="gray", lwd=3)
abline(v = 0, col="gray", lwd=3)
points(g.data[g.data$Habitat=="Tropical","delta.model"], g.data[g.data$Habitat=="Tropical","delta.TPC"], pch=19, cex=1.5, col="#FFB000") # orange
points(g.data[g.data$Habitat=="Subtropical","delta.model"], g.data[g.data$Habitat=="Subtropical","delta.TPC"], pch=19, cex=1.5, col="#40B0A6") # teal
points(g.data[g.data$Habitat=="Temperate","delta.model"], g.data[g.data$Habitat=="Temperate","delta.TPC"], pch=19, cex=1.5, col="#785EF0") # purple
points(seq(2*Xmin,1,0.1), coef(g.delta)[2]*seq(2*Xmin,1,0.1)+coef(g.delta)[1], type="l", lwd=3, col="black")


# ADULT LONGEVITY
# Latitude (Fig. 3f)
Xmin <- 0
Xmax <- 60
Ymin <- -0.4
Ymax <- 0.1
#dev.new(width=3, height=3, unit="in")
plot(-100, xlim=c(Xmin,Xmax), ylim=c(Ymin,Ymax), xlab="Latitude", ylab="Model", cex.axis=2)
abline(0, 0, col="gray", lwd=3, lty="longdash")
points(l.data[l.data$Habitat=="Tropical","Latitude"], l.data[l.data$Habitat=="Tropical","delta.model"], pch=19, cex=1.5, col="#FFB000") # orange
points(l.data[l.data$Habitat=="Subtropical","Latitude"], l.data[l.data$Habitat=="Subtropical","delta.model"], pch=19, cex=1.5, col="#6FD012") # green
points(l.data[l.data$Habitat=="Temperate","Latitude"], l.data[l.data$Habitat=="Temperate","delta.model"], pch=19, cex=1.5, col="#785EF0") # purple
points(seq(Xmin,Xmax,1), coef(l.lat)[2]*seq(Xmin,Xmax,1) + coef(l.lat)[1], type="l", lwd=3, col="black")

# Model vs TPCs
Xmin <- -0.4
Xmax <- 0.1
Ymin <- -0.4
Ymax <- 0.1
#dev.new(width=3, height=3, unit="in")
plot(-100, xlim=c(Xmin,Xmax), ylim=c(Ymin,Ymax), xlab="Model", ylab="TPC", cex.axis=2)
polygon(c(2*Xmin,2*Xmin,2*Xmax),c(2*Ymin,2*Ymax,2*Ymax), col = "#E2E2E2", border = NA)
abline(0, 1, col="gray", lwd=1)
abline(0, 0, col="gray", lwd=3)
abline(v = 0, col="gray", lwd=3)
points(l.data[l.data$Habitat=="Tropical","delta.model"], l.data[l.data$Habitat=="Tropical","delta.TPC"], pch=19, cex=1.5, col="#FFB000") # orange
points(l.data[l.data$Habitat=="Subtropical","delta.model"], l.data[l.data$Habitat=="Subtropical","delta.TPC"], pch=19, cex=1.5, col="#40B0A6") # teal
points(l.data[l.data$Habitat=="Temperate","delta.model"], l.data[l.data$Habitat=="Temperate","delta.TPC"], pch=19, cex=1.5, col="#785EF0") # purple


# POPULATION DYNAMICS
# Mean density vs latitude
Xmin <- 0
Xmax <- 60
Ymin <- -1
Ymax <- 0.5
#dev.new(width=3, height=3, unit="in")
plot(-100, xlim=c(Xmin,Xmax), ylim=c(Ymin,Ymax), xlab="Latitude", ylab="Model", cex.axis=2)
abline(0, 0, col="gray", lwd=3, lty="longdash")
points(pop.data[pop.data$Habitat=="Tropical","Latitude"], pop.data[pop.data$Habitat=="Tropical","delta.mean"], pch=19, cex=1.5, col="#FFB000") # orange
points(pop.data[pop.data$Habitat=="Temperate","Latitude"], pop.data[pop.data$Habitat=="Temperate","delta.mean"], pch=19, cex=1.5, col="#785EF0") # purple
points(pop.data[pop.data$Habitat=="Subtropical","Latitude"], pop.data[pop.data$Habitat=="Subtropical","delta.mean"], pch=19, cex=1.5, col="#6FD012") # green

# CV of density vs latitude
Xmin <- 0
Xmax <- 60
Ymin <- -1.1
Ymax <- 1.1
#dev.new(width=3, height=3, unit="in")
plot(-100, xlim=c(Xmin,Xmax), ylim=c(Ymin,Ymax), xlab="Latitude", ylab="Model", cex.axis=2)
abline(0, 0, col="gray", lwd=3, lty="longdash")
points(seq(2*Xmin,2*Xmax,1), coef(CV.lat)[2]*seq(2*Xmin,2*Xmax,1) + coef(CV.lat)[1], type="l", lwd=3, col="black")
points(pop.data[pop.data$Habitat=="Tropical","Latitude"], pop.data[pop.data$Habitat=="Tropical","delta.CV"], pch=19, cex=1.5, col="#FFB000") # orange
points(pop.data[pop.data$Habitat=="Subtropical","Latitude"], pop.data[pop.data$Habitat=="Subtropical","delta.CV"], pch=19, cex=1.5, col="#6FD012") # green
points(pop.data[pop.data$Habitat=="Temperate" & pop.data$CV.f != 0,"Latitude"], pop.data[pop.data$Habitat=="Temperate" & pop.data$CV.f != 0,"delta.CV"], pch=19, cex=1.5, col="#785EF0") # purple

# Active period vs latitude
Xmin <- 0
Xmax <- 60
Ymin <- 0
Ymax <- 0.4
#dev.new(width=3, height=3, unit="in")
plot(-100, xlim=c(Xmin,Xmax), ylim=c(Ymin,Ymax), xlab="Latitude", ylab="Model", cex.axis=2)
abline(0, 0, col="gray", lwd=3, lty="longdash")
points(pop.data[pop.data$Habitat=="Tropical","Latitude"], pop.data[pop.data$Habitat=="Tropical","delta.active"], pch=19, cex=1.5, col="#FFB000") # orange
points(pop.data[pop.data$Habitat=="Subtropical","Latitude"], pop.data[pop.data$Habitat=="Subtropical","delta.active"], pch=19, cex=1.5, col="#6FD012") # green
points(pop.data[pop.data$Habitat=="Temperate","Latitude"], pop.data[pop.data$Habitat=="Temperate","delta.active"], pch=19, cex=1.5, col="#785EF0") # purple