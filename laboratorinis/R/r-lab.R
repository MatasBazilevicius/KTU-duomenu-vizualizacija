data = read.csv("../data/lab_sodra.csv")
data = subset(data, data$ecoActCode == 	460000)
install.packages("ggplot2")
library(ggplot2)

ggplot(data, aes(x = avgWage)) +
  geom_histogram(binwidth = 100, fill = "blue", color = "black") + 
  ggtitle("Histogram average wage") +
  xlab("Average wage") +
  ylab("Frequency")

top5 = data[order(data$avgWage , decreasing = TRUE), ][1:5, ]
top5data = subset(data, name %in% top5$name)
ggplot(top5data, aes(x = month, y = avgWage, group = name, color = name)) +
  geom_line() +
  ggtitle("Change of Monthly Wages Throughout the Year for Top 5 Companies") +
  xlab("Month") +
  ylab("Average Monthly Wage")

maxInsured = aggregate(top5data$numInsured, by = list(top5data$name), FUN = max)
maxInsured$Group.1 = reorder(maxInsured$Group.1, -maxInsured$x)
ggplot(maxInsured, aes(x = Group.1, y = x, fill = Group.1)) +
  geom_bar(stat = "identity") +
  labs(title = "Most insured workers",
       x = "Name",
       y = "Number of insured workers") +
  theme(axis.text.x = element_text(angle = -45, hjust = 0))
