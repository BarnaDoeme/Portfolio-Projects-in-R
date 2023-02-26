library(tidyverse)

#### data_cleaning + exploratory data analysis----

values <- as_tibble(read.csv("data/values.csv", sep=";"))
#View(values)
values$X <- NULL #remove empty column
values$dt <- seq(3, 3*401499, by = 3) #data points were recorded every 3 seconds
str(values)
values[] <- lapply(values, function(x) as.numeric(as.character(x)))
str(values)
data <- values[complete.cases(values),]
str(data)

b <- boxplot(data$o2)
summary(data$o2)
filtered_o2 <- data[(which(nchar(data$o2) == 6)),] #removing erroneous records
boxplot(filtered_o2$o2)

#### visualization ----
theme_set(theme_light())

ggplot(filtered_o2, aes(dt, temp)) + 
  geom_point(aes(color = temp), size = 0.000001) + 
  labs(x = "Elapsed time (s)", y = "Temperature (C°)") + 
  scale_colour_gradient(name = "Temperature \n(C°)", low = "#336600", high = "#ff3300") +
  scale_x_continuous(labels = function(x) format(x, big.mark = " "))
ggsave("output/temperature.TIFF", width = 16, height = 9)

ggplot(filtered_o2, aes(dt, ph)) + 
  geom_point(aes(color = ph), size = 0.00001) + 
  labs(x = "Elapsed time (s)", y = "pH") +
  scale_colour_gradient(name = "pH", low ="orange", high = "blue") +
  scale_x_continuous(labels = function(x) format(x, big.mark = " "))
ggsave("output/pH.png", width = 16, height = 9)


ggplot(filtered_o2, aes(dt, do)) + 
  geom_point(size = 0.0000001) + 
  labs(x = "Elapsed time (s)", y = "Dissolved oxygen (%)") +
  scale_x_continuous(labels = function(x) format(x, big.mark = " ")) +
  theme(plot.margin = margin(5.5, 12, 5.5, 5.5))
ggsave("output/dissolved_oxygen.tiff", width = 16, height = 9)

ggplot(filtered_o2, aes(dt, o2)) +
  geom_point(size = 0.0000001) + 
  labs(x = "Elapsed time (s)", y = "Oxygen (ppm)") +
  scale_x_continuous(labels = function(x) format(x, big.mark = " ")) +
  theme(plot.margin = margin(5.5, 12, 5.5, 5.5))
ggsave("output/O2.tiff", width = 16, height = 9)

#the oxygen sensor had some weird readings, let's see the data on a linegraph
ggplot(filtered_o2, aes(dt, o2)) +
  geom_line(size = 0.07) + 
  labs(x = "Elapsed time (s)", y = "Oxygen (ppm)") +
  scale_x_continuous(labels = function(x) format(x, big.mark = " ")) +
  theme(plot.margin = margin(5.5, 12, 5.5, 5.5))
ggsave("output/O2_line.tiff", width = 16, height = 9)

ggplot(filtered_o2, aes(dt, co2)) +
  geom_point(size = 0.00000000001) + 
  labs(x = "Elapsed time (s)", y = "Carbon dioxide (ppm)") +
  theme(plot.margin = margin(5.5, 12, 5.5, 5.5))
ggsave("output/CO2.tiff", width = 16, height = 9)


