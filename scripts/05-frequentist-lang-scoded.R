source('scripts/02-read-data.R')

# ----lang-scode----
salig.df$s1_l <- ifelse(
  salig.df$L == 'English'
  , -1
  , 1
)

salig.df$s.5_l <- ifelse(
  salig.df$L == 'English'
  , -.5
  , .5
)

# ----lang-scoded----
fit.lang.sum.1 <- lmer(
  log(T) ~ s1_l + (1 | S) + (1 | I)
  , data = salig.df
)

fit.lang.sum.05 <- lmer(
  log(T) ~ s.5_l + (1 | S) + (1 | I)
  , data = salig.df
)


# ----options-ctr-sum----

# change default contrast method
# to sum-coding
# R handles it under the hood
options(contrasts = c('contr.sum','contr.sum'))

# ----lang-scoded-coefs----

scoded.lang.coef.5 <- broom.mixed::tidy(
  fit.lang.sum.05
  , conf.int = T
)

scoded.lang.coef.5 <- 
  scoded.lang.coef.5[
    scoded.lang.coef.5$effect == 'fixed'
    # cols inherited from the indicator model
    , cols[3:ncol(scoded.lang.coef.5)]
  ]

scoded.lang.coef.1 <- broom.mixed::tidy(
  fit.lang.sum.1
  , conf.int = T
)

scoded.lang.coef.1 <- 
  scoded.lang.coef.1[
    scoded.lang.coef.1$effect == 'fixed'
    , cols[3:ncol(scoded.lang.coef.1)]
  ]

# ----lang-scoded-cmeans-emm----

cmeans.scoded.indicator.5.emm <- data.frame(
  emmeans(
    fit.lang.sum.05
    , ~ s.5_l
  )
)

cmeans.scoded.indicator.1.emm <- data.frame(
  emmeans(
    fit.lang.sum.1
    , ~ s1_l
  )
)

# ----lang-scoded-cmeans-marg----

cmeans.scoded.indicator.5.marg <- data.frame(
  predictions(
    fit.lang.sum.05
    , by = 's.5_l'
    , re.form = NA
  )
)

cmeans.scoded.indicator.1.marg <- data.frame(
  predictions(
    fit.lang.sum.1
    , by = 's1_l'
    , re.form = NA
  )
)
