
# ----grateful----

# grateful to create a text
# with the packages used directly
# dependencies are not cited
# because some are creating a problem
# with R4.5
grateful::cite_packages(
  output = 'paragraph'
  , out.dir = ('.')
  , pkgs = 'All'
  , cite.tidyverse = F
  , omit = NULL # include grateful
  , include.RStudio = F
  , dependencies = F
)

# ----sessioninfo----
# obtain session info
sessionInfo()
