library(tidyverse)
library(broom)

seda <- read_csv("data-clean/seda.csv")

View(seda)

seda %>% ggplot(aes(x = test_score)) + geom_histogram()
    


p <- seda %>% ggplot(aes(x = test_score)) + geom_histogram()

seda %>% ggplot(aes(x = learn_rate)) + geom_histogram()

seda %>% ggplot(aes(x = test_score, y = learn_rate)) + geom_point() + facet_wrap(~ level)

seda %>% ggplot(aes(y = test_score, x = perecd)) + geom_point(alpha = 0.1, aes(color = level))

model <- lm(test_score ~ perecd, data = seda)

# add in a plot

# add in model with urbancity


model <- lm(test_score ~ urbanicity + level + perecd, data = seda)

tidy(model) # can output this as csv

seda %>% 
    ggplot(aes(x = learn_rate, y = test_score, color = urbanicity)) +
    geom_point(alpha = 0.05) +
    geom_smooth()

seda %>% 
    group_by(cut_learn_rate = cut_interval(learn_rate, 20), urbanicity) %>% 
    summarize(mean_test_score = mean(test_score)) %>% 
    ggplot(aes(x = cut_learn_rate, y = mean_test_score, color = urbanicity)) +
    geom_point() +
    geom_path(aes(group = urbanicity)) +
    theme(axis.text.x = element_text(angle = 90))

# add in output
ggsave("output/klintiscool.png")

model %>% tidy() %>% write_csv("output/model.csv")

