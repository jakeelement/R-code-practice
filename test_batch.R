library(dplyr)
library(ggplot2)

var1 <- 1:100
var2 <- runif(100, min=0, max=1000)
factors <- c("a","b","c","d")
var3 <- sample(factors, size = 100, replace = TRUE)

testframe <- as.data.frame(cbind(var1,var2,var3))
testframe$var1 = as.numeric(as.character(testframe$var1))
testframe$var2 = as.numeric(as.character(testframe$var2))
testframe$var3 = as.factor(testframe$var3)

testframe <- testframe %>% mutate(var4 = var1*var2)
testframe <- testframe %>% mutate(var5 = paste0(var4,var3))


ggplot(testframe, aes(x = var1, y = var4))+
  geom_point(aes(colour=var3), shape = 3)
  
