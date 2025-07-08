library(magrittr)
library(dplyr)
library(ggplot2)
library(ggdist)
library(geomtextpath)
library(patchwork)
theme_set(
  theme_classic(
    base_size = 16
    , base_family = 'Times'
  )
)
# options(ggsave_width = 12.09, ggsave_height = 7.33)

options(contrasts = c('contr.sum','contr.sum'))

library(brms)
options(mc.cores = parallel::detectCores())
rstan::rstan_options(threads_per_chain = 2)
rstan::rstan_options(auto_write = TRUE)
options(brms.backend = "cmdstanr")
seed <- 93

grateful::cite_packages(
  output = 'paragraph'
  , out.dir = ('.')
  , pkgs = 'All'
  , cite.tidyverse = F
  , omit = NULL
  , include.RStudio = F
  , dependencies = F
)

sessionInfo()

library(magrittr)
library(dplyr)
library(ggplot2)
library(ggdist)
library(geomtextpath)
library(patchwork)
theme_set(
  theme_classic(
    base_size = 16
    , base_family = 'Times'
  )
)
# options(ggsave_width = 12.09, ggsave_height = 7.33)
options(contrasts = c('contr.sum','contr.sum'))
library(brms)
options(mc.cores = parallel::detectCores())
rstan::rstan_options(threads_per_chain = 2)
rstan::rstan_options(auto_write = TRUE)
options(brms.backend = "cmdstanr")
seed <- 93
grateful::cite_packages(
  output = 'paragraph'
  , out.dir = ('.')
  , pkgs = 'All'
  , cite.tidyverse = F
  , omit = NULL
  , include.RStudio = F
  , dependencies = F
)

sessionInfo()

library(magrittr)
library(dplyr)
library(ggplot2)
library(ggdist)
library(geomtextpath)
library(patchwork)
theme_set(
  theme_classic(
    base_size = 16
    , base_family = 'Times'
  )
)
# options(ggsave_width = 12.09, ggsave_height = 7.33)
options(contrasts = c('contr.sum','contr.sum'))
library(brms)
options(mc.cores = parallel::detectCores())
rstan::rstan_options(threads_per_chain = 2)
rstan::rstan_options(auto_write = TRUE)
options(brms.backend = "cmdstanr")
seed <- 93
grateful::cite_packages(
  output = 'paragraph'
  , out.dir = ('.')
  , pkgs = 'All'
  , cite.tidyverse = F
  , omit = NULL
  , include.RStudio = F
  , dependencies = F
)

sessionInfo()

