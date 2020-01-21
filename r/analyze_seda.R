seda <- read_csv("data-clean/seda.csv")

seda %>% View()

model <- lm(test_score ~ urbanicity + level + perecd, data = seda)

broom::tidy(model) # can output this as csv

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
