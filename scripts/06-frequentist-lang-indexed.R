source('scripts/02-read-data.R')

# ----lang-index----

fit.lang.index <- lmer(
  log(T) ~ 0 + L + (1 | S) + (1 | I)
  , data = salig.df
)

# ----index-lang-coefs----

# extract population-level estimates
# from the model
index.lang.coef <- broom.mixed::tidy(
  fit.lang.index
  , conf.int = T
)

index.lang.coef <- index.lang.coef[
  index.lang.coef$effect == 'fixed'
  ,
  grepl(
    'term|^est|^conf'
    , cols
  )
]

index.lang.coef %>% 
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

# ----lang-index-difference----

index.dif.emm <- data.frame(
  emmeans(
    fit.lang.index, pairwise ~ L
  )$contrasts
)

# ----lang-index-gmean-emm----

gmean.emmeans <- data.frame(
  emmeans(fit.lang.index, ~ 1)
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

# ----lang-index-gmean-marg----

gmean.marginaleffects <- data.frame(
  predictions(
    fit.lang.index
    , re.form = NA
    , variables = 'L'
    , by = T
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
