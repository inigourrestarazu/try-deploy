source('scripts/00-setup-packages.R')

# ----create-design-grid----

# create vectors of the variables
language <- c('English', 'Spanish')
switching <- c('+ switch', '- switch')

# create grid combining the variables
design.grid <- expand.grid(language = language, switching = switching)

# create combinations of variables
design.grid$combination <- paste(
  design.grid$language
  , design.grid$switching
)

# create table in gt
design.tb <- design.grid %>% 
  # pivot to wider
  # to have combinations in 2x2
  tidyr::pivot_wider(
    names_from = switching
    , values_from = combination
  )
 
