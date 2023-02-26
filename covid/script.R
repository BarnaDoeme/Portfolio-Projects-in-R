#this code is based on the video of 'Using R to analyze COVID-19| R Programming Project' by Tech Tribe

library(Hmisc) #import package
data <- read.csv("COVID19_line_list_data.csv") #load dataset
describe(data)

data$Death_dummy <- as.integer(data$death != 0) #clean up death column

sum(data$Death_dummy) / nrow(data) #death rate

#AGE
#claim: people who die are older
dead = subset(data, Death_dummy == 1)
alive = subset(data, Death_dummy == 0)
mean(dead$age, na.rm = T)
mean(alive$age, na.rm = T)

#is.this statistically significant?
t.test(alive$age, dead$age, alternative = "two.sided", conf.level = 0.99)
# normally in statistics if p-value < 0.05, we reject the null hypothesis
# here, p-value = ~0, so we reject the null hypothesis and
# conclude that this is statistically significant

#GENDER
#claim: gender has no effect
men = subset(data, gender == "male")
women = subset(data, gender == "female")
mean(men$Death_dummy, na.rm = T) #8.4%
mean(women$Death_dummy, na.rm = T) #3.7%

#is.this statistically significant?
t.test(men$Death_dummy, women$Death_dummy, alternative = "two.sided", conf.level = 0.99)
#99% confidence: men have 0.8 to 8.8 higher chance of dying
#p-value = 0.002 < 0.05, so this is statistically significant

