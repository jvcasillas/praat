library(tidyverse)

formants_df <- read_csv("timeseries_formants.csv") %>% 
  gather(., key = step, val = value, -Filename, -TextGridLabel) %>% 
  filter(., step != "duration") %>% 
  separate(., step, c("measurement", "step"), sep = "_") %>% 
  spread(., measurement, value) %>% 
  mutate(., step = as.numeric(step), 
            f0 = as.numeric(f0), 
            f1 = as.numeric(f1), 
            f2 = as.numeric(f2), 
            f3 = as.numeric(f3))

glimpse(formants_df)

ggplot(formants_df, aes(x = step, y = f0)) + 
  geom_smooth(method = 'gam', formula = y ~ s(x, bs = "cs"))

ggplot(formants_df, aes(x = step, y = f1)) + 
  geom_smooth(method = 'gam', formula = y ~ s(x, bs = "cs"))

ggplot(formants_df, aes(x = step, y = f2)) + 
  geom_smooth(method = 'gam', formula = y ~ s(x, bs = "cs"))

ggplot(formants_df, aes(x = step, y = f3)) + 
  geom_smooth(method = 'gam', formula = y ~ s(x, bs = "cs"))
