#### STAT 2321 Homework 1 ####

install.packages ("xts")
library(xts)
library(zoo)

install.packages("devtools")
devtools::install_github("nickpoison/astsa")
library(astsa)

(1:20/10) %% 1
help("%%")

# i = sqrt(-1) # NaNs produced
1/1i

exp(1)^(1i * pi)

# Calculate cos(pi/2), cos(pi), cos(3pi/2), cos(2pi)
cos(pi/2) ; cos(pi) ; cos(3*pi/2) ; cos(2*pi)

cos(pi*1:4/2)

x <- 1 + 2
x = 1 + 2
1 + 2 -> x
(y = 9*3) # parentheses show what y is without having to type y
(z = rnorm(5))
x = c(1, 2, 3)
y = c("one", "two", "three")
z = c(TRUE, TRUE, FALSE)

x = c(0, 1, NA)
2*x
is.na(x)
x/0

help("assignOps") # see the difference between the assignment operators
# <- can be used anywhere
# = can only be used at the top level

0 = x = y
0 -> x -> y

x = c(1:4)
y = c(2, 4)
z = c(8, 3, 2)
x*y
y + z

ls() # list of all objects
ls(pattern = "my") # list objects with "my"
rm() # remove something from the environment
rm(list = ls()) # remove everything
data() # list of available datasets
help(ls) ; ?ls # help - these two are the same
getwd() # get working directory
setwd() # set working directory
q() # end the session

getwd()
library(astsa)
help(cpg) # cost per GB
write(cpg, file = "zzz.txt", ncolumns = 1)

mydata = c(1, 2, 3, 2, 1)
mydata
mydata[3:5] # 3rd - 5th elements
mydata[-(1:2)] # all but 1st and 2nd elements
length(mydata)
scale(mydata)
dim(mydata)
mydata = as.matrix(mydata)
dim(mydata)

cost_per_gig = scan("zzz.txt")

options(digits = 2) # significant digits to print - default is 7
x = runif(4) # generate 4 values from uniform(0, 1) into object x
y = runif(4) # generate 4 more and put into y
cbind(x, y) # column bind the two vectors (4 by 2 matrix)
rbind(x, y) # row bind (2 by 4 matrix)

a = seq(1, 10, by = 2)
b = seq(2, 10, by = 2)
x = cbind(a, b)

options(digits = 3) # output control
set.seed(911)
x = rnorm(25, 10, 4) # generate 25 normals, with mu = 10 and sigma = 4
c(mean(x), median(x), var(x), sd(x))
c(min(x), max(x))
which.max(x) # index of max
boxplot(x); hist(x); stem(x)

boxplot(rnorm(100))

oneover <- function(x){
  1/x
}
oneover(0)
oneover(-4)

xty <- function(x,y){
  x*y
}
xty(20, .5)

simple <- function(x,y){
   x^y
}
simple(25, .5)

set.seed(666) # fix initial value of generation algorithm
x = rnorm(10) # 10 standard normals
y = 1 + 2*x + rnorm(10) # generate simple linear model
summary(fit <- lm(y~x)) # fit the model
plot(x, y)
abline(fit, col = 4)

abline(h = mean(y), col = 2, lty = 2)
abline(v = mean(x), col = 2, lty = 2)

plot(resid(fit))
fitted(fit)

(mydata = c(1, 2, 3, 2, 1))
(mydata = ts(mydata, start = 1990))
(mydata = ts(mydata, start = c(1990, 3), frequency = 4))
time(mydata) # view sampled times
(x = window(mydata, start = c(1991, 1), end = c(1991, 3))) # part of the time series

x = ts(1:5)
cbind(x, lag(x), lag(x, -1))
ts.intersect(x, lag(x, 1), lag(x, -1))
options(digits = 7)
tsp(UnempRate) # use tsp to examine ts attributes, and UnempRate is a dataset in astsa

diff(x)
diff(x, 2) # this is NOT second order differencing, instead:
diff(diff(x))

ded = ts.intersect(cmort, part, part4 = lag(part, -4))
summary(fit <- lm(cmort ~ part + part4, data = ded, na.action = NULL)) # only do fit AFTER aligning with ts.intersect

part4 <- lag(part, -4)
summary(fit <- lm(cmort ~ part + part4, na.action = NULL))

trend = time(jj) - 1970 # "center" time
Q = factor(cycle(jj)) # make quarter factors
reg = lm(log(jj) ~ 0 + trend + Q, na.action = NULL) # 0 = no intercept
model.matrix(reg) # view model design matrix
summary(reg) # view results

tsplot(gtemp_land) # tsplot is in package astsa
plot.ts(cbind(soi, rec)) # multifigure plot

par(mfrow = c(2, 1))
tsplot(soi, col = 4, main = "Southern Oscillation Index")
tsplot(rec, col = 4, main = "Recruitment")

ts.plot(cmort, tempr, part, col = 2:4)
legend("topright", legend = c("M", "T", "P"), lty = 1, col = 2:4)

plot.ts(cbind(cmort, tempr, part))
plot.ts(eqexp) # warning/error
plot.ts(eqexp[,9:16], main = "Explosions") # this works

library(ggplot2)
gtemp.df = data.frame(Time = c(time(gtemp_land)), gtemp1 = c(gtemp_land),
                      gtemp2 = c(gtemp_ocean))
ggplot(data = gtemp.df, aes(x = Time, y = value, color = variable)) +
  ylab("Temperature Deviations") +
  geom_line(aes(y = gtemp1, col = "Land"), size = 1, alpha = .5) +
  geom_point(aes(y = gtemp1, col = "Land"), pch = 0) +
  geom_line(aes(y = gtemp2, col = "Ocean"), size = 1, alpha = .5) +
  geom_point(aes(y = gtemp2, col = "Ocean"), pch = 2) +
  theme(legend.position = c(.1, .85))

# do the same thing with base graphics
culer = c(rgb(217, 77, 30, 128, max = 255), rgb(30, 170, 217, 128, max = 255))
par(mar = c(2, 2, 0, 0) + .75, mgp = c(1.8, .6, 0), tcl = -.2, las = 1, cex.axis = .9)
ts.plot(gtemp_land, gtemp_ocean, ylab = "Temperature Deviations", type = "n")
edge = par("usr")
rect(edge[1], edge[3], edge[2], edge[4], col = gray(.9), border = 8)
grid(lty = 1, col = "White")
lines(gtemp_land, lwd = 2, col = culer[1], type = "o", pch = 0)
lines(gtemp_ocean, lwd =2, col = culer[2], type = "o", pch = 2)
legend("topleft", col = culer, lwd = 2, pch = c(0,2), bty = "n",
       legend = c("Land", "Ocean"))

layout(matrix(1:2), height = c(4, 10))
tsplot(sunspotz, col = 4, type = "o", pch = 20, ylab = "")
tsplot(sunspotz, col = 4, type = "o", pch = 20, ylab = "")
mtext(side = 2, "Sunspot Numbers", line = 1.5, adj = 1.25, cex = 1.25)

par(mfrow = c(2,1))
tsplot(sunspotz, type = "o")
tsplot(lynx, type = "o")

