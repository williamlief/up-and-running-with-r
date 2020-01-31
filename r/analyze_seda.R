library(tidyverse)
library(broom)

seda <- read_rds("data-clean/seda.rds")

View(seda)

# One variable plots:

## continuous variables

ggplot(seda, aes(x = test_score)) + 
    geom_histogram()

p <- ggplot(seda, aes(x = learn_rate)) +
    geom_histogram()

p

p + ggtitle('histogram of learn_rate')

## categorical variables

ggplot(seda, aes(x = urbanicity)) +
    geom_bar()


#############################################################################
### Now make a plot for the 'perecd' and 'binarized ''high_ecd' variables ###
#############################################################################


# Two variables: two ways

## both continuous

ggplot(seda, aes(x = test_score, y = learn_rate)) +
    geom_point(alpha = 0.3)

## one continuous, one categorical

ggplot(seda, aes(x = urbanicity, y = perecd)) +
    geom_boxplot()



#########################################################
### Make a plot of test score vs. perecd and high_ecd ###
#########################################################


# Three variables, two ways:

ggplot(seda, aes(x = test_score, y = learn_rate)) +
    geom_point(alpha = 0.2) +
    facet_wrap(~ level)

ggplot(seda, aes(y = test_score, x = perecd)) +
    geom_point(alpha = 0.2, aes(color = level))

########################################
### Make a plot including urbanicity ###
########################################


# Regressions!

model <- lm(test_score ~ perecd, data = seda)
summary(model)
tidy(model)


####################################
### Make a model with urbancity! ###
####################################


model <- lm(test_score ~ urbanicity + level + perecd, data = seda)
tidy(model)

ggplot(seda, aes(y = test_score, x = perecd)) +
    geom_point(alpha=0.2) +
    geom_smooth(method='lm')

ggplot(seda, aes(x = learn_rate, y = test_score, color = urbanicity)) +
    geom_point(alpha = 0.1) +
    geom_smooth(se = FALSE)

bin_seda <- seda %>%
    group_by(cut_learn_rate = cut_interval(learn_rate, 20), urbanicity) %>%
    summarize(mean_test_score = mean(test_score))

ggplot(bin_seda, aes(x = cut_learn_rate, y = mean_test_score, color = urbanicity)) +
    geom_point() +
    geom_path(aes(group = urbanicity)) +
    theme(axis.text.x = element_text(angle = 90))

# add in output
ggsave("output/wildplot.png")

coefs <- tidy(model)
write_csv(coefs, "output/model.csv")
