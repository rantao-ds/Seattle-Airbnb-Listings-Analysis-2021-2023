# note: Please download the dataset from Kaggle and update the file path accordingly
# dataset: https://www.kaggle.com/datasets/konradb/inside-airbnb-usa

library(tidyverse)

# loading the datasets
listing<- read_csv("data/listings.csv")

# adding a new column labeled "stay_type" to distinguish "short-term" and "long-term" listings
listing$stay_type <- ifelse(listing$minimum_nights < 30, "short_term","long_term")

# checking and removing hotel-room listing
table(listing$room_type)
listing <- listing %>%
filter(!room_type == "Hotel room")

# checking whether listing names contain "hotel"
listing %>%
filter(str_detect(name, "(?i)hotel")) %>%
view()

# removing listings that contain "hotel" in the name and have license marked as "Exempt"
listing <- listing %>%
filter(!(str_detect(name, "(?i)hotel") & license == "Exempt"))

# checking for zero value
colSums(listing == 0)

# removing listings with both zero availability_365 and zero number_of_reviews_ltm
listing <- listing %>%
filter(! (availability_365==0 & number_of_reviews_ltm == 0))

# checking for NA value 
 colSums(is.na(listing))

# removing the listings with NA in last_review and reviews_per_month
listing <- listing %>%
filter(!(is.na(last_review) & is.na(reviews_per_month)))

colSums(is.na(listing))
colSums(listing == 0)

# checking listing with no reviews but positive availability 
listing %>%
filter(number_of_reviews_ltm == 0 & availability_365 > 0) %>%
summarise(mean = mean(availability_365), min = min(availability_365), max = max(availability_365))

# checking and removing the possible duplicate listings with the same lat and lng under the same host
dp <- listing %>%
group_by(latitude, longitude, host_id) %>%
summarise(n_listings = n()) %>%
filter(n_listings > 1) %>%
arrange(desc(n_listings)) 

listing <- listing  %>%
filter(!(id %in% c(48708466,48727590,48727595,48801916,48801924,48821508,48842246,48842347,54044862)))

listing <- listing  %>%
filter(!(id %in% c(36202177,36235581,36235813,36235984,36236107,36236176,594301734799789568,594866010398837632,594885723900572544,594893250456080512,594896459738671104,594898940591323008,620897318573479040,620913160565746432)))

# cheking the range of last_review of listing and retaining only the most recent three years
range(listing$last_review)

listing_1 <- listing %>%
mutate(year = year(last_review)) %>%
filter(year %in% c(2021, 2022, 2023))

# Short-Term 

# creating a separate dataset for "short_term"
st <- listing_1 %>%
filter(stay_type == "short_term")

saveRDS(st,"st.rds") 


# checking listings with license marked as "Exempt" and room type as "Shared room" to identify possible hotel or motel units that are not considered residential living
st %>%
filter(license == "Exempt" ) %>%
view()

# removing hotel, motel, inn, and hostel listings
st <- st %>%
filter(!(host_id %in% c(458906403,294393857,	
                         266083019,219526255,98049500,31751507,5899487,190880343)))

# checking listings with missing license values
st %>%
filter(is.na(license)) %>%
view()

# double-checking and removing listings identified as hotel, motel, inn, or hostel units
st %>%
filter(str_detect(name,"(?i)inn")) %>%
view()

st %>%
filter(str_detect(name,"(?i)motel")) %>%
view()

st %>%
filter(str_detect(name,"(?i)hotel")) %>%
view()

st %>%
filter(str_detect(name,"(?i)hostel")) %>%
view()

st <- st %>%
filter(!(host_id %in% c(802398,108049935,361224830,425937581,55668955,130470547)))

st <- st %>%
filter(!(host_name == "Level Seattle"))


# labeling listings that may violate the law, including short-term licenses associated with more than two listings or listings with no license / exempt status
st <- st %>%
group_by(license) %>%
mutate(compliance = case_when(
license %in% c("Exempt", NA) ~ "no_license",
n() > 2                      ~ "violation",
n() <= 2                     ~ "legal"
  )) %>%
ungroup()


# Long-Term 

# creating a separate dataset for "long_term"
lt <- listing_1 %>%
filter(stay_type == "long_term")

saveRDS(lt,"lt.rds")

# checking and removing listings that are not residential or corporate based, such as hotel, inn, motel, or hostel units
lt %>%
filter(str_detect(name,"(?i)motel")) %>%
view()

lt %>%
filter(str_detect(name,"(?i)hotel")) %>%
view()

lt %>%
filter(str_detect(name,"(?i)inn")) %>%
view()

lt %>%
filter(str_detect(name,"(?i)hostel")) %>%
view()

lt  %>%
filter(host_name == "Level Seattle") %>%
view()

lt <- lt %>%
filter(!(host_name == "Level Seattle"))


# labeling host type as corporate or residential
corporate_hosts <- c("Blueground","Seattle Vacation Home", "Vacasa Washington", "Mercer Furnished Apartments", "Seattle Property Management", "One Fine BNB LLC", "Vacation Rental LLC","PNW Homestays", "SeattleStays - Seth Gordon","Zeus","NOLA LuXury", "Evolve")

lt <- lt %>%
mutate(host_type = case_when(
host_name %in% corporate_hosts ~ "corporate",
TRUE                           ~ "residential"
 ))

saveRDS(lt,"lt.rds")


# combining the long-term and short-term datasets
lc <- bind_rows(st, lt)

saveRDS(lc,"lc.rds")


