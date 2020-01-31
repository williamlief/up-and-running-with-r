library(tidyverse)
library(tidylog)

#####################
# Read in seda data #
#####################


seda_raw <- read_csv("data-raw/seda_school_pool_gcs_v30.csv")
spec(seda_raw) # How are the variables being parsed? - first 1000 rows

seda_raw_2 <- read_csv("data-raw/seda_school_pool_gcs_v30.csv", 
                     col_types = cols(schoolname = col_double()
                     ))
problems(seda_raw_2)


seda <- seda_raw %>% 
  select(ncessch, stateabb, mn_avg_ol, mn_grd_ol) %>% 
  rename("test_score" = mn_avg_ol, 
         "learn_rate" = mn_grd_ol) %>% 
  filter(stateabb == "CA") %>% 
  drop_na() # row-wise deletion

glimpse(seda)

######################
# Read in covariates (CORE_89_comp.csv)
# 1) read data       
# 2) select ncessch, urbanicity, level, perecd, other?
######################

core_raw <- read_csv("data-raw/CORE_89_comp.csv")
glimpse(core_raw)

core <- core_raw %>% 
  select(ncessch, urbanicity, level, perecd) %>% 
  mutate(ncessch = as.numeric(ncessch), 
         urbanicity = as.factor(urbanicity), 
         level = as.factor(level),
         high_ecd = if_else(perecd > mean(perecd, na.rm = T), 1, 0))

glimpse(core)

##################
# Merge the data #
##################

seda <- seda %>% 
  left_join(core, by = c("ncessch")) %>% 
  select(-stateabb)



# Other important joins are 'full', 'inner', and 'right'
# Watch out for row inflation - many to one, 

#############
# save data #
#############

write_rds(seda, "data-clean/seda.rds")
write_csv(seda, "data-clean/seda.csv")