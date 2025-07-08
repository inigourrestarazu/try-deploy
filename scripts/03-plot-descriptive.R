source('scripts/02-read-data.R')

# ----fig-descriptive-empirical----

salig.df %>% 
  # create a variable named combination
  # for the discrete positions in the y axis
  mutate(
    combination = paste(L, currtrial)
  ) %>% 
  # plot start
  ggplot(
    aes(
      y = combination
      , x = log(T)
      , fill = L
      , color = L
    )
  ) +
  # jitter of means of participants
  geom_jitter(
    data = . %>% 
      group_by(
        S, combination, L
      ) %>% 
      summarise(
        x = mean(log(T))
      )
    , aes(
      x = x
    )
    , width = 0
    , height = .06
    , alpha = .3
    , size = .8
    # rings
    , shape = 1
  ) +
  # shade of the observations
  geom_point(
    shape = 95
    , size = 40
    , alpha = 0.01
    , show.legend = F
    , color = 'gray'
  ) +
  # point interval of distribution
  stat_pointinterval(
    , fill = NA
    , .width = c(.5, .75, .95)
  ) +
  # density
  stat_slab(
    fill = NA
  ) +
  # line separating EN & ES
  geom_hline(
    yintercept = 2.93
    , linetype = 'dashed'
    , color = 'lightgray'
  ) +
  # theming
  # labs
  labs(
    x = 'Reading time (log-ms)'
    , fill = NULL
  ) +
  # scales
  scale_y_discrete(
    name = NULL
    , expand = c(0.0,0)
  ) +
  scale_x_continuous(
    breaks = seq(5, 11, 1.5)
  ) +
  # theme
  theme(
    axis.line.y = element_blank()
    , axis.ticks.y = element_blank()
    , axis.text.y = element_blank()
    , legend.position = 'none'
  ) +
  # colour
  viridis::scale_fill_viridis(
    discrete = T
    , option = 'H'
  ) +
  viridis::scale_color_viridis(
    discrete = T
    , option = 'H'
    , name = NULL
  ) +
  # text of condition
  geom_text(
    inherit.aes = F
    , data = . %>% 
      group_by(
        combination, currtrial
      ) %>% 
      summarise(
        T = median(log(T))
      )
    , aes(
      x = T
      , y = combination
      , label = currtrial
    )
    , color = 'black'
    , vjust = -1
    , size = 5
    , family = 'Carlito'
  ) +
  # language text
  geom_text(
    inherit.aes = F
    , data = . %>% 
      mutate(
        y = ifelse(
          L == 'English'
          , 2
          , 4
        )
      )
    , aes(
      x = 5
      , y = y
      , label = L
    )
    , angle = 90
    , hjust = 0.5
    , color = 'gray'
    , size = 6
    , family = 'Carlito'
  )
