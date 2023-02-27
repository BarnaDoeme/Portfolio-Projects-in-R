#Preparation----
library("readxl")
library("agricolae")

RL <- read_excel("data/Ocimum_root_length_watering_list.xlsx")
attach(RL)
str(RL)
conc <- ordered(conc, levels = c("control", "0.5", "1", "2.5", "5", "10")) 
levels(conc)
boxplot(root_length~conc)
summary(root_length)

#ANOVA----
alpha=0.05
model <- aov(root_length~conc, data = RL)
print(summary(model))

#Posthoc----
#although the anova showed know significant difference, we run posthoc and plot the results just to demonstrate the functions 
out <- LSD.test(model,alpha = 0.1, "conc", p.adj="none", console = T)
tiff(file = "output/fake_stats.tiff", width=16, height=10, units="in", res=100)
plot(out, xlab = "Treatment", ylab = "Root length (cm)", main = "Root lengths of Ocimum plants with different concentration of brown juice applied\n(NON-significant ANOVA, FALSE results)")

dev.off()
