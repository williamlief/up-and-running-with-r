library(tidyverse)
library(tidylog)
library(readr)

# Read in seda data
seda_raw <- read_csv("data-raw/seda_school_pool_gcs_v30.csv")
glimpse(seda_raw)

seda <- seda_raw %>% 
  select(ncessch, stateabb, mn_avg_ol, mn_grd_ol) %>% 
  rename("test_score" = mn_avg_ol, 
         "learn_rate" = mn_grd_ol) %>% 
  filter(stateabb == "CA") %>% 
  drop_na()

# Read in covariates
core_raw <- read_csv("data-raw/CORE_89_comp.csv")
glimpse(core_raw)

core <- core_raw %>% 
  select(ncessch, urbanicity, level, perecd) %>% 
  mutate(ncessch = as.numeric(ncessch), 
         urbanicity = as.factor(urbanicity), 
         level = as.factor(level))

# Merge the data
seda <- seda %>% 
  left_join(core, by = c("ncessch")) %>% 
  select(-stateabb)

# save data
write_rds(seda, "data-clean/seda.rds")
write_csv(seda, "data-clean/seda.csv")