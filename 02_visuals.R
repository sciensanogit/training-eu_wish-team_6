############################################################################### #
# Aim ----
#| produce visuals
# NOTES:
#| git cheat: git status, git add -A, git commit -m "", git push, git pull, git restore
#| list of things to do...
############################################################################### #

# Load packages ----
# select packages
pkgs <- c("dplyr", "tidyr", "zoo", "writexl", "ggplot2","slider")
# install packages
install.packages(setdiff(pkgs, rownames(installed.packages())))
invisible(lapply(pkgs, FUN = library, character.only = TRUE))

# load data
bg_nat <- read.csv2("Belgium_export-nation.csv")
# create folder if not existing
if (!dir.exists("plot")) {
  dir.create("plot")
}

#ggsave("plot/graph", width = 8, height = 5)


# graph at national level
bg_nat$date <- as.Date(bg_nat$date)

bg_nat$value_pmmv <- as.numeric(bg_nat$value_pmmv)




df_nat_date <- bg_nat %>%
  group_by(date) %>%
  summarise(value_pmmv = mean(value_pmmv, na.rm = TRUE))

df_nat_date <- df_nat_date |> 
  filter(!is.nan(value_pmmv))


df_nat_date <- df_nat_date %>%
  arrange(date) %>% 
  mutate(
    value_pmmv_avg14d_past = slide_dbl(
      value_pmmv,
      mean,
      .before = 14,
      .after = 1,
      .complete = TRUE,
      na.rm = TRUE
    )
  )



p <- ggplot(df_nat_date, aes(x = date)) +
  
  geom_line(aes(y = value_pmmv), 
            color = "#0072B2", linewidth = 1.2) +
  
  geom_line(aes(y = value_pmmv_avg14d_past), 
            color = "#D55E00", linewidth = 1.1) +
  
  labs(
    title = "Viral ratio (PMMoV-normalized) – National level",
    x = "Date",
    y = "Viral ratio"
  ) +
  
  scale_x_date(
    date_breaks = "1 month",
    date_labels = "%b %Y"
  ) +
  
  scale_y_continuous(
    labels = scales::comma_format(accuracy = 0.0001)
  ) +
  
  theme_minimal(base_size = 14) +
  theme(
    axis.line = element_line(color = "black", linewidth = 0.6)
    axis.ticks = element_line(color = "black", linewidth = 0.6),
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank()                          
  )



print(p)
# save graph
ggsave("plot/graph-viral_ratio-nation.png", width = 8, height = 5)
# display msg
cat("- Success : visuals saved \n")
