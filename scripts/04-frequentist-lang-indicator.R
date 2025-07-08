source('scripts/02-read-data.R')

# ----lang-indicator----

# fit-treatment-indicator
fit.lang.indicator <- lmer(
  log(T) ~ L + (1 | S) + (1 | I)
  , data = salig.df
)

# equivalent formula
fit.lang.indicator <- lmer(
  log(T) ~ 1 + L + (1 | S) + (1 | I)
  , data = salig.df
)

# ----lang-indicator-summary----
summary(fit.lang.indicator)

# ----indicator-lang-coefs----

# extract population-level estimates
# from the model
indicator.lang.coef <- broom.mixed::tidy(
  fit.lang.indicator
  , conf.int = T
)

# the first two columns of the
# tidy output are irrelevant
# and I don't want std error and statistic
# obtain the colnames
# just to keep the relevant ones
cols <- colnames(indicator.lang.coef)

indicator.lang.coef <- indicator.lang.coef[
  indicator.lang.coef$effect == 'fixed'
  ,
  grepl(
    'term|^est|^conf'
    , cols
  )
]

indicator.lang.coef %>% 
  mutate_if(
    is.numeric
    , round
    , digits = 2
  ) %>% 
  mutate(
    `95% CI` = paste0(
      '['
      , conf.low
      , ', '
      , conf.high
      , ']'
    )
  ) %>% 
  select(
    -starts_with('conf')
  ) %>% 
  gt(
    , rowname_col = 'term'
  )

# ----lang-indicator-cmean-emm----

cmeans.emmeans <- data.frame(
  emmeans(fit.lang.indicator, ~ L)
)

cmeans.emmeans %>% 
  select(
    L
    , emmean
    , asymp.LCL
    , asymp.UCL
  ) %>% 
  mutate_if(
    is.numeric
    , round
    , digits = 2
  ) %>% 
  mutate(
    `95% CI` = paste0(
      '['
      , asymp.LCL
      , ', '
      , asymp.UCL
      , ']'
    )
  ) %>% 
  select(
    -starts_with('asymp')
  ) %>% 
  gt(
    , rowname_col = 'L'
  )

# ----lang-indicator-cmean-marg----
cmeans.marginaleffects <- data.frame(
  predictions(
    fit.lang.indicator
    , variables = 'L'
    , by = 'L'
    , re.form = NA
  )
)

cmeans.marginaleffects %>% 
  mutate_if(
    is.numeric
    , round
    , digits = 2
  ) %>% 
  mutate(
    `95% CI` = paste0(
      '['
      , conf.low
      , ', '
      , conf.high
      , ']'
    )
  ) %>% 
  select(
    L
    , estimate
    , `95% CI`
  ) %>% 
  gt(
    , rowname_col = 'L'
  )

# ----lang-indicator-gmean-emm----

gmean.emmeans <- data.frame(
  emmeans(fit.lang.indicator, ~ 1)
)

gmean.emmeans %>% 
  select(
    , emmean
    , asymp.LCL
    , asymp.UCL
  ) %>% 
  mutate_if(
    is.numeric
    , round
    , digits = 2
  ) %>% 
  mutate(
    `95% CI` = paste0(
      '['
      , asymp.LCL
      , ', '
      , asymp.UCL
      , ']'
    )
  ) %>% 
  select(
    -starts_with('asymp')
  ) %>% 
  gt()

# ----lang-indicator-gmean-marg----
gmean.marginaleffects <- data.frame(
  predictions(
    fit.lang.indicator
    # without the next 2 lines
    # it returns the marginal avg
    # with the weights in the dataset
    , variables = 'L'
    , by = T
    , re.form = NA
  )
)


gmean.marginaleffects %>% 
  mutate_if(
    is.numeric
    , round
    , digits = 2
  ) %>% 
  mutate(
    `95% CI` = paste0(
      '['
      , conf.low
      , ', '
      , conf.high
      , ']'
    )
  ) %>% 
  select(
    , estimate
    , `95% CI`
  ) %>% 
  gt()
