library(tidyverse)
library(broom)

seda <- read_csv("data-clean/seda.csv")

View(seda)

# One variable: Histograms

seda %>%
    ggplot(aes(x = test_score)) + 
    geom_histogram()

p <- seda %>%
    ggplot(aes(x = learn_rate)) +
    geom_histogram()

p

p + ggtitle('histogram of learn_rate')

######################################################
### Now make a histogram for the 'perecd' variable ###
######################################################


# Two variables: scatter plots

seda %>%
    ggplot(aes(x = test_score, y = learn_rate)) +
    geom_point()

####################################################
### Make a scatter plot of test score vs. perecd ###
####################################################


# Three variables, two ways:

seda %>%
    ggplot(aes(x = test_score, y = learn_rate)) +
    geom_point(alpha = 0.2) +
    facet_wrap(~ level)

seda %>%
    ggplot(aes(y = test_score, x = perecd)) +
    geom_point(alpha = 0.2, aes(color = level))

###############################################
### Make your own plot including urbanicity ###
###############################################


# Regressions!

model <- lm(test_score ~ perecd, data = seda)
tidy(model)


####################################
### Make a model with urbancity! ###
####################################


model <- lm(test_score ~ urbanicity + level + perecd, data = seda)

tidy(model)

seda %>%
    ggplot(aes(y = test_score, x = perecd)) +
    geom_point(alpha=0.2) +
    geom_smooth(method='lm')

seda %>%
    ggplot(aes(x = learn_rate, y = test_score, color = urbanicity)) +
    geom_point(alpha = 0.1) +
    geom_smooth(se = FALSE)

seda %>%
    ggplot(aes(x = urbanicity, y = perecd)) +
    geom_boxplot()

seda %>%
    group_by(cut_learn_rate = cut_interval(learn_rate, 20), urbanicity) %>%
    summarize(mean_test_score = mean(test_score)) %>%
    ggplot(aes(x = cut_learn_rate, y = mean_test_score, color = urbanicity)) +
    geom_point() +
    geom_path(aes(group = urbanicity)) +
    theme(axis.text.x = element_text(angle = 90))


# add in output
ggsave("output/wildplot.png")

model %>%
    tidy() %>%
    write_csv("output/model.csv")
