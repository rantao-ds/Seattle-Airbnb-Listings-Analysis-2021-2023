# adding host professional level column
eh_st <- eh_st %>%
mutate(host_level = case_when(
calculated_host_listings_count == 1 ~ "casual",
calculated_host_listings_count <= 3 ~ "typical",
calculated_host_listings_count > 3  ~ "professional"
))

eh_lt <- eh_lt %>%
mutate(host_level = case_when(
calculated_host_listings_count == 1 ~ "casual",
calculated_host_listings_count <= 3 ~ "typical",
calculated_host_listings_count > 3  ~ "professional"
))

# computing estimated turnover rates (35% for long-term and 50% for short-term)
short_term_modeling <- eh_st %>%
mutate(est_tvr = reviews_per_month / 0.50)

long_term_modeling <- eh_lt %>%
mutate(est_tvr_con = reviews_per_month / 0.35)

saveRDS(short_term_modeling,"short_term_modeling.rds")
saveRDS(long_term_modeling,"long_term_modeling.rds")

# running the multiple linear regression model for short-term listings
lr_st <- lm(est_tvr ~ compliance + price + neighbourhood_group + 
    host_level + number_of_reviews + availability_365 + year + 
    minimum_nights + number_of_reviews_ltm, data = short_term_modeling)

summary(lr_st)


# running the multiple linear regression model for long-term listings
lr_lt <- lm(est_tvr_con ~ host_type + price + neighbourhood_group + 
                  host_level + number_of_reviews + availability_365 + year+ 
		 number_of_reviews_ltm, data = long_term_modeling)

summary(lr_lt)

# running vif to check multicollinearity
library(faraway)

vif(lr_st)
vif(lr_lt)

# running robust standard errors to check for heteroskedasticity
library(lmtest)
library(sandwich)

coeftest(lr_st, vcov = vcovHC(lr_st, type = "HC1"))
coeftest(lr_lt, vcov = vcovHC(lr_lt, type = "HC1"))


