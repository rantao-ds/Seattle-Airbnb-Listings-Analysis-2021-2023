# Overall Trend 

# computing the overall proportion of stay type
prop_stay_type <- lc %>%
count(stay_type) %>%
mutate(prop = n/sum(n))

custom_colors_stay_type <- c(
  "short_term" = "#1976D2", 
"long_term"  = "#FF61CC"   
 )

# plot
ggplot(prop_stay_type, aes(x = 2, y = prop, fill = stay_type)) +
    geom_bar(stat = "identity", color = "white", linewidth = 1.5) +
    coord_polar(theta = "y", start = 0) +
    scale_fill_manual(
        values = c("short_term" = "#1976D2", "long_term" = "#d11141"),
        labels = c("short_term" = "Short term", "long_term" = "Long term")
    ) +
    geom_text(aes(label = scales::percent(prop, accuracy = 0.1)),
              position = position_stack(vjust = 0.5),
              color = "white",
              size = 7,
              fontface = "bold") +
    xlim(0.7, 2.5) +
    theme_void() +
    labs(title = "Seattle Airbnb: Stay Type Distribution",
         subtitle = "Aggregate Listings Data (2021 - 2023)",
         fill = "Stay Type") +
    theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 18,
                                  margin = margin(t = 40, b = 2)),
        plot.subtitle = element_text(hjust = 0.5, size = 14, color = "gray30",
                                     margin = margin(b = 10)),
        legend.position = "right",
        legend.title = element_text(face = "bold", size = 12),
        legend.text = element_text(size = 11)
    )

# saving the plot image
ggsave("stay_type_distribution.png",
 width = 11,
 height = 6,
 dpi = 300)

# computing the overall proportion of room type
prop_room_type <- lc %>%
count(room_type) %>%
mutate(prop =n/sum(n))

# setting the color and plot
custom_colors_room <- c(
"Entire home/apt" = "#1E4160",  
"Private room"    = "#AD002A99")

prop_room_type %>%
  filter(room_type != "Shared room") %>%
  ggplot(aes(x = 2, y = prop, fill = room_type)) +
  
  geom_bar(stat = "identity", color = "white", linewidth = 1.5) +
  
  coord_polar(theta = "y", start = 0) +
  
  scale_fill_manual(
    values = custom_colors_room,
    labels = c("Entire home/apt" = "Entire Home/Apt",
               "Private room"    = "Private Room")
  ) +
  
  geom_text(aes(label = scales::percent(prop, accuracy = 0.1)),
            position = position_stack(vjust = 0.5),
            color = "white",
            size = 7,
            fontface = "bold") +
  
  xlim(0.7, 2.5) +
  
  theme_void() +
  
  labs(title = "Seattle Airbnb: Room Type Distribution",
       subtitle = "Aggregate Listings Data (2021 - 2023)\nNote: Shared Room excluded from chart (n=6, 0.1%)",
       fill = "Room Type") +
  
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 18,
                              margin = margin(t = 40, b = 2)),
    plot.subtitle = element_text(hjust = 0.5, size = 14, color = "gray30",
                                 margin = margin(b = 10)),
    legend.position = "right",
    legend.title = element_text(face = "bold", size = 12),
    legend.text = element_text(size = 11)
  )


# saving the plot image
ggsave("room_type_distribution.png",
width = 11,
height = 6,
dpi = 300)


# computing the proportion of room type by stay type 

rm_lt_st <- lc %>%
group_by(stay_type) %>%
count(room_type) %>%
mutate(prop = n/sum(n))

# plot
rm_lt_st %>%
    filter(!(stay_type == "long_term" & room_type == "Shared room")) %>%
    mutate(
        stay_type = recode(stay_type,
                           "long_term"  = "Long term",
                           "short_term" = "Short Term")
    ) %>%
    ggplot(aes(x = stay_type, y = prop, fill = room_type)) +
    geom_col(width = 0.45) +
    geom_text(aes(label = scales::percent(prop, accuracy = 0.1)),
              position = position_stack(vjust = 0.5),
              color = "white",
              size = 5,
              fontface = "bold") +
    scale_fill_manual(values = c(
        "Entire home/apt" = "#1E4160",
        "Private room"    = "#AD002A99"
    )) +
    scale_y_continuous(labels = scales::percent_format()) +
    labs(
        x = "Stay Type",
        y = "Proportion of Listings",
        fill = "Room Type",
        title = "Room Type Composition by Stay Type",
        subtitle = "Note: Shared Room from Long-term excluded from chart (n = 6, 0.58%)"
    ) +
    theme_minimal(base_size = 14)


# saving the plot image
ggsave("room_type_LT&ST.png",
 width = 11,
 height = 6,
 dpi = 300)

# computing the overall proportion of neighbourhood group

prop_nb <- lc %>%
count(neighbourhood_group) %>%
mutate(prop = n/sum(n)) %>%
slice_max(order_by = n, n=5)

#plot
	ggplot(prop_nb, aes(x = prop, y = reorder(neighbourhood_group, prop))) +
	    geom_col(width = 0.75, fill = "#00BFC4", show.legend = FALSE) +
	    geom_text(aes(label = scales::percent(prop, accuracy = 0.1)),
	              hjust = -0.2,
	              fontface = "bold",
	              size = 4.5) +
	    scale_x_continuous(labels = scales::percent_format(), limits = c(0, 0.28)) +
	    labs(title = "Seattle Airbnb: Top 5 Neighbourhoods",
	         subtitle = "Aggregate Listings Data (2021 - 2023)",
	         x = "Proportion of Total Listings",
	         y = NULL) +
	    theme_minimal() +
	    theme(
	        plot.title = element_text(face = "bold", size = 18,
	                                  margin = margin(t = 25, b = 5), hjust = 0),
	        plot.subtitle = element_text(size = 14, color = "gray30",
	                                     margin = margin(b = 20), hjust = 0),
	        axis.text.y = element_text(face = "bold", size = 12, color = "black"),
	        axis.text.x = element_text(color = "gray50"),
	        panel.grid.minor = element_blank(),
	        panel.grid.major.y = element_blank()
	    )
	
# saving the plot imagine
ggsave("top_5_neighborhood.png",
width = 11,
height = 6,
dpi = 300)

# computing the proportion of neighbourhood group by stay type
top_nb_lt_st <- lc %>%
group_by(stay_type) %>%
count(neighbourhood_group) %>%
mutate(prop = n/sum(n)) %>%
slice_max(order_by = n, n=5)

# plot
library(ggplot2)
library(dplyr)
library(tidytext)

plot_data <- top_nb_lt_st %>%
mutate(stay_type = ifelse(stay_type == "short_term", "Short term", "Long term"))
ggplot(plot_data, aes(x = prop, 
	                      y = reorder_within(neighbourhood_group, prop, stay_type), 
	                      fill = stay_type)) +
	  
	  geom_col(width = 0.75, show.legend = FALSE) +
	  
	  geom_text(aes(label = scales::percent(prop, accuracy = 0.1)),
	            hjust = -0.2,
	            fontface = "bold",
	            size = 4.5) +
 facet_wrap(~ stay_type, scales = "free_y") + 
	  scale_y_reordered() + # Cleans up the Y-axis names from the reorder_within function
	  scale_x_continuous(labels = scales::percent_format(), 
	                     expand = expansion(mult = c(0, 0.20))) + 
	  
	  # Apply your specific custom colors!
	  scale_fill_manual(values = c("Short term" = "#1976D2", 
	                               "Long term" = "#d11141")) + 
	  
	  labs(title = "Seattle Airbnb: Top 5 Neighbourhoods by Stay Type",
	       subtitle = "Aggregate Listings Data (2021 - 2023)",
	       x = "Proportion of Total Listings",
	       y = NULL) +
	  
	  theme_minimal() +
	  theme(
	    plot.title = element_text(face = "bold", size = 18,
	                              margin = margin(t = 25, b = 5), hjust = 0),
	    plot.subtitle = element_text(size = 14, color = "gray30",
	                                 margin = margin(b = 20), hjust = 0),
	    axis.text.y = element_text(face = "bold", size = 12, color = "black"),
	    axis.text.x = element_text(color = "gray50"),
	    panel.grid.minor = element_blank(),
	    panel.grid.major.y = element_blank(),
	    
	    # Formats the "Long term" and "Short term" panel titles at the top
	    strip.text = element_text(face = "bold", size = 15) 
	  )

# saving the plot imagine
ggsave("lt&st_top_5_neighborhood.png",
width = 11,
height = 6,
dpi = 300)


# Short-Term

# retaining only "Entire home/apt" listings for analysis
eh_st <- st %>%
filter(room_type == "Entire home/apt")

saveRDS(eh_st,"eh_st.rds")

# computing the overall proportion of compliance status
prop_st_legal <- eh_st %>%
count(compliance) %>%
mutate(prop = n/sum(n)) 

# plot

prop_st_legal %>%
    filter(compliance != "no_license") %>%
    ggplot(aes(x = 2, y = prop, fill = compliance)) +
    geom_bar(stat = "identity", color = "white", linewidth = 1.5) +
    coord_polar(theta = "y", start = 0) +
    scale_fill_manual(
        values = c("legal"     = "#025766",
                   "violation" = "#888888"),
        labels = c("legal"     = "Legal",
                   "violation" = "Violation")
    ) +
    geom_text(aes(label = scales::percent(prop, accuracy = 0.1)),
              position = position_stack(vjust = 0.5),
              color = "white",
              size = 7,
              fontface = "bold") +
    xlim(0.7, 2.5) +
    theme_void() +
    labs(title = "Seattle Airbnb: Short-term Compliance Distribution",
         subtitle = "Short-Term Entire Home/Apartment Listings Only, (2021 - 2023)\nNote: No License excluded from chart (n = 30, 0.9%)",
         fill = "Compliance") +
    theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 18,
                                  margin = margin(t = 40, b = 2)),
        plot.subtitle = element_text(hjust = 0.5, size = 14, color = "gray30",
                                     margin = margin(b = 10)),
        legend.position = "right",
        legend.title = element_text(face = "bold", size = 12),
        legend.text = element_text(size = 11)
    )

# saving the plot imagine
ggsave("st_compliance_distribution.png",
width = 11,
height = 6,
dpi = 300)


# computing the proportion of top 5 neighborhoods by compliance type
prop_top5_nb_comp <- eh_st %>%
filter(!compliance == "no_license") %>%
group_by(compliance) %>%
count(neighbourhood_group) %>%
mutate(prop = n/sum(n))  %>%
slice_max(order_by = n, n=5)

# plot
prop_top5_nb_comp <- eh_st %>%
filter(!compliance == "no_license") %>%
group_by(compliance) %>%
count(neighbourhood_group) %>%
mutate(prop = n/sum(n)) %>%
slice_max(order_by = n, n = 5) %>%
mutate(compliance = case_when(
compliance == "legal"     ~ "Legal",
compliance == "violation" ~ "Violation"
  ))

ggplot(prop_top5_nb_comp, aes(x = prop,
                               y = reorder_within(neighbourhood_group, prop, compliance),
                               fill = compliance)) +
  
  geom_col(width = 0.75, show.legend = FALSE) +
  
  geom_text(aes(label = scales::percent(prop, accuracy = 0.1)),
            hjust = -0.2,
            fontface = "bold",
            size = 4.5) +
  
  facet_wrap(~ compliance, scales = "free_y") +
  scale_y_reordered() +
  
  scale_x_continuous(labels = scales::percent_format(),
                     expand = expansion(mult = c(0, 0.20))) +
  
  scale_fill_manual(values = c("Legal"     = "#025766",
                                "Violation" = "#888888")) +
  
  labs(title = "Seattle Airbnb: Top 5 Neighbourhoods by Compliance",
       subtitle =  "Short-Term Entire Home/Apartment Listings Only, (2021 - 2023)\nNote: No License excluded from chart (n = 30, 0.9%), focused on Legal vs Violation comparison",
       x = "Proportion of Listings",
       y = NULL) +
  
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 18,
                              margin = margin(t = 25, b = 5), hjust = 0),
    plot.subtitle = element_text(size = 14, color = "gray30",
                                 margin = margin(b = 20), hjust = 0),
    axis.text.y = element_text(face = "bold", size = 12, color = "black"),
    axis.text.x = element_text(color = "gray50"),
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_blank(),
    strip.text = element_text(face = "bold", size = 15)
  )


# saving the plot imagine
ggsave("top5_nb_compliance_type.png",
width = 11,
height = 6,
dpi = 300)

# computing the median/mean/skew by compliance type 
eh_st %>%
filter(!compliance == "no_license") %>%
group_by(compliance) %>%
summarise(
median = median(price),
mean = mean(price),
skew = mean(price) - median(price)
)

# plot 
 eh_st %>%
  filter(compliance != "no_license") %>%
  mutate(compliance = case_when(
    compliance == "legal"     ~ "Legal",
    compliance == "violation" ~ "Violation"
  )) %>%
  ggplot(aes(x = compliance, y = price, fill = compliance)) +
  
  geom_boxplot(width = 0.5, alpha = 0.7,
               outlier.colour = "gray50",
               outlier.alpha = 0.5, outlier.size = 1.5) +
  
  scale_fill_manual(values = c("Legal"     = "#025766",
                                "Violation" = "#888888")) +
  
  scale_y_continuous(labels = scales::dollar_format()) +
  
  coord_cartesian(ylim = c(0, 500)) +
  
  labs(title = "Seattle Airbnb: Short-term Nightly Rate by Compliance",
       subtitle = "Short-Term Entire Home/Apartment Listings Only, (2021 - 2023)\nNote: No License excluded from chart (n = 30, 0.9%)",
       x = NULL,
       y = "Nightly Rate (USD)") +
  
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 18,
                              margin = margin(t = 25, b = 5), hjust = 0),
    plot.subtitle = element_text(size = 14, color = "gray30",
                                 margin = margin(b = 20), hjust = 0),
    axis.text.x = element_text(face = "bold", size = 12, color = "black"),
    axis.text.y = element_text(color = "gray50"),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    legend.position = "none"
  )

# saving the plot imagine
ggsave("boxplot_compliance_type.png",
   width = 11,
   height = 6,
   dpi = 300)


# computing the median/mean/skew by top 5 neighborhoods
eh_st %>%
filter(compliance != "no_license",
neighbourhood_group %in% c("Other neighborhoods", "Downtown", 
                                       "Central Area", "West Seattle",
                                       "Capitol Hill")) %>%
group_by(neighbourhood_group) %>%
summarise(
         median = median(price),
         mean   = mean(price),
         skew   = mean(price) - median(price)
     )

# setting the color and plot
nb_green_colors <- c(
  "Other neighborhoods" = "#1B5E20",
  "Downtown"            = "#2E7D32",
  "Central Area"        = "#388E3C",
  "West Seattle"        = "#66BB6A",
  "Capitol Hill"        = "#A5D6A7"
)

 eh_st %>%
  filter(neighbourhood_group %in% c("Other neighborhoods", "Downtown",
                                     "Central Area", "West Seattle",
                                     "Capitol Hill")) %>%
  mutate(neighbourhood_group = factor(neighbourhood_group,
                                      levels = c("Other neighborhoods", "Downtown",
                                                 "Central Area", "West Seattle",
                                                 "Capitol Hill"))) %>%
  ggplot(aes(x = neighbourhood_group, y = price, fill = neighbourhood_group)) +
  
  geom_boxplot(width = 0.5, alpha = 0.7,
               outlier.colour = "gray50",
               outlier.alpha = 0.5, outlier.size = 1.5) +
  
  scale_fill_manual(values = nb_green_colors) +
  
  scale_y_continuous(labels = scales::dollar_format()) +
  
  coord_cartesian(ylim = c(0, 500)) +
  
  labs(title = "Seattle Airbnb: Short-term Nightly Rate by Neighbourhood",
       subtitle = "Short-Term Entire Home/Apartment Listings Only, (2021 - 2023)",
       x = NULL,
       y = "Nightly Rate (USD)") +
  
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 18,
                              margin = margin(t = 25, b = 5), hjust = 0),
    plot.subtitle = element_text(size = 14, color = "gray30",
                                 margin = margin(b = 20), hjust = 0),
    axis.text.x = element_text(face = "bold", size = 12, color = "black"),
    axis.text.y = element_text(color = "gray50"),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    legend.position = "none"
  )

# saving the plot imagine
ggsave("st_boxplot_top5_nb.png",
width = 11,
height = 6,
dpi = 300)


#Long-Term 

# retaining only "Entire home/apt" listings for analysis
eh_lt <- lt %>%
filter(room_type == "Entire home/apt") 

saveRDS(eh_lt,"eh_lt.rds")

# computing the overall proportion of host type
prop_lt_comp <- eh_lt  %>%
count(host_type) %>%
mutate(prop = n/sum(n)) 

# plot
ggplot(prop_lt_comp, aes(x = 2, y = prop, fill = host_type)) +
    geom_bar(stat = "identity", color = "white", linewidth = 1.5) +
    coord_polar(theta = "y", start = 0) +
    scale_fill_manual(
        values = c("corporate"   = "#E67E22",
                   "residential" = "#332288"),
        labels = c("corporate"   = "Corporate",
                   "residential" = "Residential")
    ) +
    geom_text(aes(label = scales::percent(prop, accuracy = 0.1)),
              position = position_stack(vjust = 0.5),
              color = "white",
              size = 7,
              fontface = "bold") +
    xlim(0.7, 2.5) +
    theme_void() +
    labs(title = "Seattle Airbnb: Long-term Host Type Distribution",
        subtitle = "Long-Term Entire Home/Apartment Listings Only, (2021–2023)",
         fill = "Host Type") +
    theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 18,
                                  margin = margin(t = 40, b = 2)),
        plot.subtitle = element_text(hjust = 0.5, size = 14, color = "gray30",
                                     margin = margin(b = 10)),
        legend.position = "right",
        legend.title = element_text(face = "bold", size = 12),
        legend.text = element_text(size = 11)
    )

# saving the plot imagine
ggsave("prop_lt_host_type.png",
width = 11,
height = 6,
dpi = 300)


# computing the proportion of top 5 neighborhoods by host type
prop_nb_host_type <- eh_lt %>%
group_by(host_type) %>%
count(neighbourhood_group) %>%
mutate(prop = n/sum(n)) %>%
slice_max(order_by = n, n = 5)

#plot
library(tidytext)

prop_nb_host_type <- prop_nb_host_type %>%
mutate(host_type = ifelse(host_type == "corporate", "Corporate", "Residential"))

ggplot(prop_nb_host_type, aes(x = prop,
                               y = reorder_within(neighbourhood_group, prop, host_type),
                               fill = host_type)) +
  
  geom_col(width = 0.75, show.legend = FALSE) +
  
  geom_text(aes(label = scales::percent(prop, accuracy = 0.1)),
            hjust = -0.2,
            fontface = "bold",
            size = 4.5) +
  
  facet_wrap(~ host_type, scales = "free_y") +
  scale_y_reordered() +
  
  scale_x_continuous(labels = scales::percent_format(),
                     expand = expansion(mult = c(0, 0.20))) +
  
  scale_fill_manual(values = c("Corporate"   = "#E67E22",
                                "Residential" = "#332288")) +
  
  labs(title = "Seattle Airbnb: Top 5 Neighbourhoods by Host Type",
       subtitle = "Long-Term Entire Home/Apartment Listings Only, (2021–2023)",
       x = "Proportion of Listings",
       y = NULL) +
  
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 18,
                              margin = margin(t = 25, b = 5), hjust = 0),
    plot.subtitle = element_text(size = 14, color = "gray30",
                                 margin = margin(b = 20), hjust = 0),
    axis.text.y = element_text(face = "bold", size = 12, color = "black"),
    axis.text.x = element_text(color = "gray50"),
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_blank(),
    strip.text = element_text(face = "bold", size = 15)
  )

# saving the plot imagine
ggsave("top5_nb_host_type.png",
width = 11,
height = 6,
dpi = 300)


# adding monthly_rate column
eh_lt <-eh_lt %>%  
mutate(Monthly_rate = price * 30) 

# computing the median/mean/skew by compliance type 
eh_lt %>%
group_by(host_type) %>%
summarise(
median = median(Monthly_rate),
mean = mean(Monthly_rate),
skew = mean(Monthly_rate) - median(Monthly_rate)
 )

#plot 
ggplot(eh_lt, aes(x = host_type, y = Monthly_rate, fill = host_type)) +
    
    geom_boxplot(width = 0.5, alpha = 0.7,
                 outlier.colour = "gray50",
                 outlier.alpha = 0.5, outlier.size = 1.5) +
    
    scale_fill_manual(values = c("corporate"   = "#E67E22",
                                 "residential" = "#332288")) +
    
    scale_y_continuous(labels = scales::dollar_format()) +
    
    coord_cartesian(ylim = c(0, 10000)) +
    
    labs(title = "Seattle Airbnb: Long-term Monthly Rate by Host Type",
         subtitle = "Long-Term Entire Home/Apartment Listings Only, (2021–2023)",
         x = NULL,
         y = "Monthly Rate (USD)") +
    
    theme_minimal() +
    theme(
        plot.title = element_text(face = "bold", size = 18,
                                  margin = margin(t = 25, b = 5), hjust = 0),
        plot.subtitle = element_text(size = 14, color = "gray30",
                                     margin = margin(b = 20), hjust = 0),
        axis.text.x = element_text(face = "bold", size = 12, color = "black"),
        axis.text.y = element_text(color = "gray50"),
        panel.grid.minor = element_blank(),
        panel.grid.major.x = element_blank(),
        legend.position = "none"
    )

# saving the plot imagine
ggsave("lt_boxplot_host_type.png",
  width = 11,
  height = 6,
  dpi = 300)


# computing the median/mean/skew by top 5 neighborhoods
eh_lt %>%
filter(neighbourhood_group %in% c("Other neighborhoods", "Capitol Hill", "Downtown", "Central Area",
         "University District")) %>% 
 group_by(neighbourhood_group) %>%
 summarise(
 median = median(Monthly_rate),
 mean   = mean(Monthly_rate),
 skew   = mean(Monthly_rate) - median(Monthly_rate)
  )

#setting the color and plot
nb_green_colors <- c(
  "Other neighborhoods" = "#1B5E20",
  "Capitol Hill"        = "#2E7D32",
  "Downtown"            = "#388E3C",
  "Central Area"        = "#66BB6A",
  "University District" = "#A5D6A7"
)

eh_lt%>%
  filter(neighbourhood_group %in% c("Other neighborhoods", "Capitol Hill",
                                     "Downtown", "Central Area",
                                     "University District")) %>%
  mutate(neighbourhood_group = factor(neighbourhood_group,
                                      levels = c("Other neighborhoods", "Capitol Hill",
                                                 "Downtown", "Central Area",
                                                 "University District"))) %>%
  ggplot(aes(x = neighbourhood_group, y = Monthly_rate, fill = neighbourhood_group)) +
  
  geom_boxplot(width = 0.5, alpha = 0.7,
               outlier.colour = "gray50",
               outlier.alpha = 0.5, outlier.size = 1.5) +
  
  scale_fill_manual(values = nb_green_colors) +
  
  scale_y_continuous(labels = scales::dollar_format()) +
  
  coord_cartesian(ylim = c(0, 10000)) +
  
  labs(title = "Seattle Airbnb: Long-term Monthly Rate by Neighbourhood",
       subtitle = "Long-Term Entire Home/Apartment Listings Only, (2021–2023)",
       x = NULL,
       y = "Monthly Rate (USD)") +
  
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 18,
                              margin = margin(t = 25, b = 5), hjust = 0),
    plot.subtitle = element_text(size = 14, color = "gray30",
                                 margin = margin(b = 20), hjust = 0),
    axis.text.x = element_text(face = "bold", size = 12, color = "black"),
    axis.text.y = element_text(color = "gray50"),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    legend.position = "none"
  )

# saving the plot imagine 
ggsave("lt_boxplot_top5_nb.png",
   width = 11,
   height = 6,
   dpi = 300)


# Short-Term vs Long-Term Price Comparison

# estimating monthly rate for comparison
mr <- lc %>%
mutate(Monthly_rate = price * 30)

saveRDS(mr,"mr.rds")

# Computing median monthly rates for "Entire home/apt" listings in the overall top 5 neighbourhoods
mr %>%
filter(room_type == "Entire home/apt",
            neighbourhood_group %in% c("Other neighborhoods", 
                                       "Capitol Hill", "Downtown", 
                                       "Central Area")) %>%
     group_by(stay_type, neighbourhood_group) %>%
     summarise(median_monthly = median(Monthly_rate))

# plot
mr %>%
  filter(room_type == "Entire home/apt",
         neighbourhood_group %in% c("Other neighborhoods",
                                    "Capitol Hill",
                                    "Downtown",
                                    "Central Area")) %>%
  group_by(stay_type, neighbourhood_group) %>%
  summarise(median_monthly = median(Monthly_rate), .groups = "drop") %>%
  mutate(
    stay_type = ifelse(stay_type == "short_term", "Short-term", "Long-term"),
    neighbourhood_group = factor(
      neighbourhood_group,
      levels = c("Other neighborhoods", "Capitol Hill", "Downtown", "Central Area")
    )
  ) %>%
  ggplot(aes(x = neighbourhood_group, y = median_monthly, fill = stay_type)) +
  geom_col(position = position_dodge(width = 0.75), width = 0.45) +
  geom_text(aes(label = scales::dollar(median_monthly)),
            position = position_dodge(width = 0.75),
            vjust = -0.45,
            fontface = "bold",
            size = 3.8) +
  scale_fill_manual(values = c("Short-term" = "#1976D2",
                               "Long-term"  = "#d11141")) +
  scale_y_continuous(labels = scales::dollar_format(),
                     expand = expansion(mult = c(0, 0.12))) +
  labs(title = "Seattle Airbnb: Median Monthly Rate Comparison",
       subtitle = "Entire Home/Apartment Listings Only, (2021 - 2023)\nNote: Short-term monthly rate is estimated as nightly price × 30",
       x = NULL,
       y = "Median Monthly Rate (USD)",
       fill = "Stay Type") +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 18,
                              margin = margin(t = 25, b = 5), hjust = 0),
    plot.subtitle = element_text(size = 13, color = "gray30",
                                 margin = margin(b = 18), hjust = 0),
    axis.text.x = element_text(face = "bold", size = 11, color = "black"),
    axis.text.y = element_text(color = "gray50"),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    legend.position = "top",
    legend.title = element_text(face = "bold", size = 12),
    legend.text = element_text(size = 11)
  )


# saving the plot imagine 
ggsave("monthly_rate_ltst_comparison.png",
 width = 11,
 height = 6,
 dpi = 300)


