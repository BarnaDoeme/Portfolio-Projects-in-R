library(readxl)
library(ggplot2)

#### CO2_1 ----
#data_cleaning + exploratory data analysis

data <- read_excel("data/CO2_1.xlsx")
attach(data)
data$Time <- format(Time, format = "%H:%M:%S")
data$datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")
str(data)

#visualization
theme_set(theme_bw())

ggplot(data, aes(datetime, Ch3_Value)) +
  geom_line(color = "grey") +
  geom_area(fill="grey", alpha=0.35) +
  geom_point(aes(color = Period), size = .7) + 
  scale_color_manual(values=c("#999999", "#f2c852")) +
  xlab("Date") +
  ylab(expression(CO[2]*" concentration (ppm)")) +
  scale_x_datetime(breaks = "2 days", expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 2400), expand = c(0, 0)) +
  theme(legend.key = element_rect(fill = "white", colour = "black"),
        legend.position = c(.96, .92)) +
  guides(color = guide_legend(override.aes = list(size = 1.5)))

ggsave("output/CO2_1.tiff", width = 16, height = 9)

#### CO2_2 ----
#data_cleaning + exploratory data analysis

data <- read_excel("data/CO2_2.xlsx")
attach(data)
data$Time <- format(Time, format = "%H:%M:%S")
data$datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")
str(data)

#visualization
theme_set(theme_bw())

ggplot(data, aes(datetime, Ch3_Value)) +
  geom_line(color = "grey") +
  geom_area(fill="grey", alpha=0.35) +
  geom_point(aes(color = Period), size = .7) + 
  scale_color_manual(values=c("#999999", "#f2c852")) +
  xlab("Date") +
  ylab(expression(CO[2]*" concentration (ppm)")) +
  scale_x_datetime(breaks = "2 days", expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 2400), expand = c(0, 0)) +
  theme(legend.key = element_rect(fill = "white", colour = "black"),
    legend.position = c(.96, .92)) +
  guides(color = guide_legend(override.aes = list(size = 1.5)))

ggsave("output/CO2_2.tiff", width = 16, height = 9)

