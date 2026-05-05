# Seattle-Airbnb-Listings-Analysis-2021-2023
Exploratory and spatial analysis of Seattle Airbnb short-term and long-term rental patterns (2021–2023) using R and ArcGIS.

## Why This Project 
Seattle was the first city I arrived in when I came to the United States for school. I also lived in Bellevue for two months in an apartment booked through Airbnb, where the entire unit was managed by Zeus, a professional property management company. During that stay, I noticed that the monthly rate was only about $300 higher than comparable units in the same building. When I booked the accommodation, I also compared the unit I stayed in with similar long-term listings offered by individual residential hosts and found that those residential options were often priced even higher. Given that Seattle is both a major tourism destination and a hub for large corporations, demand for both short-term and long-term rentals is likely to be strong. So it would be interesting to dive into Airbnb rental patterns in Seattle for my second project.

## Data
The dataset **Listings** was downloaded from Kaggle:[Inside AirBnB - USA](https://www.kaggle.com/datasets/konradb/inside-airbnb-usa) (originally sourced from Inside Airbnb Seattle). It was created on July 2, 2023, and retrieved in January 2026. It is currently unavailable on Inside Airbnb due to seasonal dataset updates.

The dataset originally contained 5,113 listings and 19 variables describing listing characteristics, including price, location, neighbourhood, host information, and reviews. After removing hotel rooms, inactive listings, missing and zero values, and filtering listings by last review date to the most recent three years (2021, 2022, and 2023), 4,891 observations remained for exploration and analysis. To better distinguish between short-term and long-term rentals, a new variable "stay_type" was created and the data was then divided into two separate datasets.

**Short-Term** dataset focused on Seattle's short-term rental regulation, which requires operators running short-term rentals to obtain a license valid for up to two units. Of those two units, one must be the operator's primary residency. In other words, Seattle enforces strict regulations on the short-term rental market, allowing only up to two units under one license to prevent commercialization. So, I created a variable "compliance" to flag licenses associated with more than two units as "violation", those with two or fewer listings as "legal", and listings with no license as "no_license". 

**Long-Term** dataset also looked at operators but from a different perspective. Seattle does not set any specific requirements for long-term rental operation licenses, and the market is largely commercialized as there are many professional management companies running vacation and corporate housing. So, I created a variable "host_type" to mark units run by professional companies as "corporate" and other units as "residential".


## Exploratory Data Analysis (EDA)
The primary goal of the EDA is to understand how operators from different stay types affect the median rental price of the Seattle Airbnb rental market. The first part takes a glance at the overall composition of the Seattle Airbnb market. The second and third parts specifically analyze the long-term and short-term markets, focusing on entire home/apartment listings only. The fourth part of the EDA explores whether longer stays are associated with lower prices by comparing monthly rates across short-term and long-term entire home/apartment stays.

### At a Glance

With 78.9% of stay types being "short-term" and 87.2% of room types being "Entire Home/Apt", these plots clearly indicate that entire home/apt short-term rentals absolutely dominate the Seattle Airbnb market. Especially, the room type "Entire Home/Apt" takes the majority of the market in both long-term and short-term, at 86.2% and 87.5% respectively. This suggests that Airbnb users in Seattle are likely to take short trips with a strong preference for large and private accommodations, which reinforces the previously mentioned idea that Seattle's visitors are likely traveling for business or family tourism purposes.


<img width="495" alt="stay_type_distribution" src="https://github.com/user-attachments/assets/4b15795b-31b2-4544-b396-b28f476355d3" />


<img width="505" alt="room_type_distribution" src="https://github.com/user-attachments/assets/9d03f2e7-332e-40f8-a6f4-47eff7274164" />


Interestingly, the top neighbourhoods for Airbnb stays, both overall and across stay types, are concentrated in ***Other Neighbourhoods***, ***Capitol Hill***, ***Downtown***, and ***Central Area***. Among these, ***Downtown***, ***Capitol Hill***, and ***Central Area*** together account for around 30% of total stays and are located in Seattle’s urban core, which functions as the city’s primary tourism and business hub. By contrast, ***Other Neighbourhoods*** account for approximately 21% of total stays and consist of numerous residential districts located farther from Seattle’s urban core, representing a segment focused on local accommodation.

Apart from these top stay neighbourhoods, ***West Seattle*** accounts for approximately 8.1% of stays among the top five short-term neighbourhoods, whereas the ***University District*** accounts for 7% of stays among the top five long-term neighbourhoods. These two neighbourhoods represent fundamentally different market segments: ***West Seattle*** functions as an alternative to the urban core with a more suburban character, while the concentration of student populations in the ***University District*** corresponds to a higher share of long-term listings.


<img width="480" alt="top_5_neighborhood" src="https://github.com/user-attachments/assets/1ed867e9-735f-4ca1-8686-c1695d424a71" />


<img width="520" alt="lt st_top_5_neighborhood" src="https://github.com/user-attachments/assets/a02bfedd-59b6-41f1-8f74-299728fe6cbd" />



### Short-Term


With 86% of stays classified as legal, most short-term entire home/apartment listings appear to hold a valid license and comply with the regulation limiting each license to no more than two listings. Indeed, the structure and distribution of the top five short-term neighbourhoods with the highest share of legal listings are identical to those of the overall top five short-term neighbourhoods, largely because legal listings make up the majority of the short-term market. Similarly, the top neighbourhoods with the largest share of violation listings also closely mirror the overall short-term distribution, suggesting that violation listings are not concentrated in a single part of Seattle but are distributed across neighbourhoods. One exception is ***Queen Anne***, which is spotted among the top neighbourhoods for violation listings, implying that violation listings may be relatively more concentrated in this neighbourhood.


<img width="500" alt="st_compliance_distribution" src="https://github.com/user-attachments/assets/5197dede-d710-4037-896a-090fed324ca2" />


<img width="500" alt="top5_nb_compliance_type" src="https://github.com/user-attachments/assets/1a9ecd27-d69e-4d14-85ac-20000c129cc3" />



In terms of nightly pricing, violation listings have a slightly lower median nightly rate than legal listings, at $134 compared with $141. However, violation listings also have a substantially higher mean nightly rate, at $192 compared with $170, along with much stronger right-skewness (+$58.2 vs. +$29.1). As shown in the boxplot, the two groups have fairly similar interquartile ranges, median nightly rates, and upper-whisker lengths. 

However, legal listings show a much denser cluster of upper-end outliers, while violation listings display a more uneven upper-tail pattern despite representing a smaller share of the short-term market. Although the two boxplots appear broadly similar in their central range, the more irregular spacing of outliers among violation listings is consistent with their stronger right-skewness. Overall, the boxplot suggests that the two groups share similar central pricing patterns, but differ in the structure of their upper-tail pricing distribution.


<img width="350" alt="st_cr" src="https://github.com/user-attachments/assets/24a25c36-a0b0-4dfd-a3c2-a3d570b19053" />


<img width="700" alt="boxplot_compliance_type" src="https://github.com/user-attachments/assets/4eba5ce5-dab1-4a01-b9a3-a3c7a5ddc6a6" />


Comparing pricing across the top five short-term entire home/apartment neighbourhoods, the median nightly rates in ***Other Neighbourhoods***, ***West Seattle***, ***Capitol Hill***, and ***Central Area*** are relatively similar, ranging from about $129 to $136 per night. ***Downtown*** records the highest median nightly rate at $157, while also showing the weakest right-skewness (+$19). By contrast, ***Other Neighbourhoods*** have the lowest median nightly rate at $129 but the strongest right-skewness (+$40), followed by ***West Seattle*** (+$32), ***Capitol Hill*** (+$31), and ***Central Area*** (+$22).


Overall, the boxplots suggest that the top five short-term neighbourhoods display similar nightly pricing patterns, particularly in terms of interquartile range and upper-whisker length. Although ***Downtown*** is positioned slightly higher, the remaining neighbourhoods show very similar price levels and median values. Among these top neighbourhoods, ***Central Area*** has fewer extreme outliers, most of which remain below $400 per night. A similar pattern is observed in ***West Seattle***, where no extreme outliers are visible and all outliers remain below $400 per night. The outlier patterns in ***Downtown*** and ***Capitol Hill*** are also quite similar, as both neighbourhoods show one extreme outlier above $500 per night, while the remaining outliers are more sparsely distributed and remain below that level. By contrast, ***Other Neighbourhoods*** show the largest number of upper-end outliers, many of which are tightly grouped above the upper whisker, with several extending beyond the chart’s visible limit of $500 per night. 

<img width="350" alt="st_nb_cr" src="https://github.com/user-attachments/assets/871803d2-8edf-4622-9d4a-ad1331ee1c1a" />


<img width="700" alt="st_boxplot_top5_nb" src="https://github.com/user-attachments/assets/86209cff-6c54-48bf-b9ad-ff4bfdca1aad" />





### Long-Term

With 76.2% of total long-term stays operated by residential hosts and 23.8% managed by professional companies such as Blueground, Seattle’s long-term entire home/apartment Airbnb market is dominated by residential host listings. Interestingly, listings operated by professional management companies are concentrated in and around Seattle’s urban core, including ***Downtown***, ***Capitol Hill***, ***Cascade***, ***Interbay***, and ***Central Area***. In contrast, listings operated by residential hosts are more concentrated in residential districts, such as ***Other Neighbourhoods***, ***University District***, and ***West Seattle***, while also appearing in urban areas, including ***Capitol Hill***, ***Downtown***, and ***Queen Anne***.


<img width="500" alt="prop_lt_host_type" src="https://github.com/user-attachments/assets/5b32a8e1-605b-4d33-a761-4357da7f8ae3" />


<img width="500" alt="top5_nb_host_type" src="https://github.com/user-attachments/assets/08df23ad-0efe-4711-b2a4-82b6e0d1149b" />



In terms of pricing, corporate/vacation listings managed by professional companies have higher average and median monthly rates than residential listings. However, residential listings exhibit greater right-skewness (+$852) than corporate/vacation listings (+$630), indicating a wider price spread and more extreme outliers.

Consistent with this pattern, the boxplot shows a denser and larger number of high-value outliers at the upper end among residential listings, while the two boxes appear nearly identical in overall range, with corporate listings positioned slightly higher in terms of median monthly rate. In other words, it is still possible to expect corporate listings above $7,500 per month, but much less likely to see prices above $10,000. By contrast, residential listings are more likely to show both upper-end price ranges.


<img width="350" alt="lt_cr" src="https://github.com/user-attachments/assets/6b80fed0-5dc9-4bf1-8a13-a75420868deb" />


<img width="700" alt="lt_boxplot_host_type" src="https://github.com/user-attachments/assets/b947a01c-91f8-473b-94fd-a48c2c1ae233" />




Among the top long-term stay neighbourhoods, ***University District*** has the lowest median and mean monthly rates, with only minor right-skewness (+$404). By contrast, ***Central Area*** records the highest median and mean monthly rates and the strongest right-skewness (+$1,377), followed by ***Capitol Hill*** (+$1,262), ***Other Neighbourhoods*** (+$928), and ***Downtown*** (+$631). 


Compared with the short-term market, where the boxplots are broadly similar across neighbourhoods, the long-term boxplots display much greater variation in overall shape, including differences in overall range, upper-whisker length, and outlier patterns. First, ***Capitol Hill***, ***Downtown***, and the ***University District*** show fewer extreme outliers despite differences in their median monthly rates and interquartile ranges, suggesting relatively more stable pricing. Second, ***Central Area*** appears relatively stable in the short-term market but shows a highly unusual pattern in the long-term market, with not only the highest median monthly rate and the widest interquartile range, but also an upper whisker that reaches the chart’s limit of $10,000 per month. Finally, whereas ***Other Neighbourhoods*** show a denser and larger cluster of high-value and extreme outliers in the short-term market, the long-term market shows only a relatively small cluster of outliers below $10,000 per month.


<img width="350" alt="lt_nb_cr" src="https://github.com/user-attachments/assets/9390aed8-8945-4141-83b6-b44dec94087c" />


<img width="700" alt="lt_boxplot_top5_nb" src="https://github.com/user-attachments/assets/f67b3329-6e2b-498f-aaf7-5eb656fa39ea" />




### Monthly Rate Comparison: Short-Term vs. Long-Term


The final part of the EDA makes a simple and more practical comparison between short-term and long-term monthly rates for entire home/apartment listings. As shown in the grouped bar chart, the estimated monthly cost of staying in a short-term listing is higher than a long-term listing across all four neighbourhoods. However, this gap may not be as large in practice as the chart suggests, because short-term hosts often offer discounts for longer stays, especially for bookings around two to four weeks. Based on hosts’ own discussions and reported experiences, discounts of around 10% to 30% are not uncommon when guests communicate directly with hosts about longer stays. I would still not conclude that staying longer in a short-term listing will necessarily become cheaper than renting a long-term unit, since the final price depends on booking timing, the host’s decision, and the specific discount offered. Even so, the chart suggests that the difference between short-term and long-term monthly pricing may be smaller than expected in some neighbourhoods. This is especially true in ***Central Area***, where the two monthly rates are nearly identical. Under these conditions, guests with stronger bargaining power may be more likely to secure relatively lower prices for longer stays in short-term accommodations.


<img width="600" alt="monthly_rate_ltst_comparison" src="https://github.com/user-attachments/assets/c2c6077f-d25c-4235-961e-98102386dc3d" />




### Summary


Overall, pricing patterns differ substantially between long-term and short-term entire home/apartment listings, especially across neighbourhoods. For **long-term** listings, the logic of “location, location, location” does not appear to be strongly associated with pricing patterns. Specifically, ***Downtown***, Seattle’s urban core and primary destination for both tourism and business travel, presents a more stable pricing structure than both nearby urban neighbourhoods and more suburban districts, which tend to show more outliers. In addition, while corporate listings managed by professional companies have higher monthly rates than those operated by local residential hosts, they also exhibit fewer outliers and weaker right-skewness. This suggests that prime location alone may not be the central driver of long-term pricing; instead, amenities, listing characteristics, and the local living environment may play a more important role.


For **short-term** listings, the logic of “location, location, location” appears to apply more clearly than it does in the long-term market. Unlike long-term pricing, where ***Downtown*** shows a more stable structure than surrounding neighbourhoods, higher-priced short-term listings can be found in both the urban core and suburban residential districts. This suggests that short-term pricing may reflect at least two different groups of customers. One group likely prioritizes prime location and especially values proximity to business districts, tourist destinations, and transit to maximize convenience during a brief stay. Another group may place greater value on amenities, neighbourhood character, and local experience, particularly if they are staying slightly longer or traveling by car. Under this pattern, higher short-term prices are not driven by location alone, but also by the appeal of distinctive neighbourhood settings and host-specific amenities. Additionally, legal and violation listings do not show clear differences in their central pricing patterns, suggesting that compliance status plays only a limited role in shaping short-term prices.



## Modeling


### Objective

In the previous section, the EDA explored how neighbourhoods and host types shape pricing patterns and market structure across short-term and long-term listings. In the modeling section, the analysis shifts toward the estimated turnover rate, which serves as a indicator for booking frequency, to examine which factors may influence listing activity. Given the limited listing-specific information available in the dataset, particularly details on rooms and amenities, price prediction models are likely to have limited explanatory power. Therefore, multiple linear regression is applied to examine the relationship between turnover rate and potential factors to better understand and articulate the market structure explored in the EDA.



### Methodology 


According to Inside Airbnb, the “San Francisco Model” adopts 50% of monthly reviews as the estimated turnover rate for short-term listings, taking the midpoint between 72% and 30.5%, as referenced in San Francisco policy analysis and the New York Attorney General’s report([Inside AirBnB - Data Assumptions](https://insideairbnb.com/data-assumptions/)). Following this approach, this analysis applies a 50% turnover rate to short-term listings. For long-term listings, a more conservative turnover rate of 35% is used as my own modeling choice. Therefore, separate variables are created for short-term and long-term listings to calculate estimated turnover rates. Additionally, to examine how host professionalization affects estimated turnover rate, a new variable is created to classify hosts with only one listing as casual, hosts with two to three listings as typical, and hosts with more than three listings as professional. Since 87.2% of listings are classified as Entire home/apt, the modeling focuses only on this room type. 


- **Dependent Variable:**

  short-term: est_tvr

  long-term: est_tvr_con
  

- **Independent Variables:**


  short-term: compliance, price, neighbourhood_group, host_level, number_of_reviews, availability_365, year, minimum_nights, number_of_reviews_ltm


  long-term: host_type, price, neighbourhood_group, host_level, number_of_reviews, availability_365, year, number_of_reviews_ltm


**1. Mutiple Linear Regression**


The first step was to run two multiple linear regression models using the prepared datasets for short-term and long-term listings, respectively. With estimated turnover rate as the dependent variable, the models examine whether and how the selected independent variables are statistically associated with estimated turnover rate, as well as the overall explanatory power of each model.


**2.VIF**


The second step was to assess multicollinearity using VIF (Variance Inflation Factor), as more than five independent variables were selected and potential correlations among them could affect the explanatory power of the models.



**3.Robust SE**


The last step was to test for heteroskedasticity and use robust standard errors to improve the reliability of coefficient inference under potential non-constant error variance.


### Results


**1. Mutiple Linear Regression**



***Short-Term***




<img width="600" alt="ST_MODELING" src="https://github.com/user-attachments/assets/2cdc5d16-ac14-465e-bb16-d38bd766add7" />


This multiple linear regression model explains a substantial share of the variation in estimated turnover rate, with an R² of 0.722. Among the selected predictors, ****price**** is negatively associated with turnover rate, suggesting that higher-priced listings tend to book less frequently. Meanwhile, higher ****minimum-night**** requirements and greater ****availability**** are also associated with lower turnover. By contrast, both ****number of reviews**** and ****number of reviews in the last 12 months**** are strongly and positively associated with turnover rate, indicating that review activity is closely related to booking frequency. The positive coefficient on ****year**** also suggests that estimated turnover rate increased over time between 2021 and 2023. However, the model suggests that neither ****compliance status**** nor ****host professional level**** plays a major role in shaping estimated turnover rate. In terms of ****neighbourhood group****, only a limited number of neighbourhoods show statistically significant differences, and all of these effects are negative. Overall, the model suggests that turnover rate is more strongly associated with listing-level activity measures, such as price and reviews, than with compliance status or broad neighbourhood location.


***Long-Term***



<img width="600" alt="LT_MODELING" src="https://github.com/user-attachments/assets/11e212ad-6c6e-4a28-be3c-496fb4c5054b" />



This multiple linear regression model explains a substantial share of the variation in estimated turnover rate, with an R² of 0.830. Compared with corporate hosts, ****residential hosts**** show a strong and positive association with turnover rate, indicating that locally operated long-term listings may turn over more frequently than corporate-managed ones. In contrast to the short-term model, ****price**** has only a limited impact on turnover, even though pricing is a key factor in the short-term market. Similarly, ****availability**** and ****year**** appear to have only limited effects in the long-term model. However, both ****number of reviews**** and ****number of reviews in the last 12 months**** remain strongly and positively associated with turnover rate, highlighting the close relationship between review activity and listing turnover in both short-term and long-term listings. In terms of ****neighbourhood group****, only one neighbourhood is statistically significant, and the effect is negative, which implies that neighbourhood location may play a more limited role in the long-term market once other listing characteristics are taken into account. While host ****professional level**** plays only a limited role in the short-term model, ****professional hosts**** show a positive and statistically significant association with estimated turnover rate in the long-term model.



**2.VIF**



***Short-Term***


<img width="1000" alt="ST_VIF" src="https://github.com/user-attachments/assets/5da249d0-9b20-434b-88d6-9a671d7b761c" />




***Long-Term***


<img width="1000" alt="LT_VIF" src="https://github.com/user-attachments/assets/f6b3638b-96c9-409f-9259-79c723e34972" />



The VIF test confirms that no serious multicollinearity issues are present in either the short-term or long-term model, as all values are below 5. Specifically, VIF values range from 1.04 to 3.28 in the short-term model and from 1.20 to 4.30 in the long-term model, suggesting that multicollinearity is unlikely to affect coefficient reliability.


**3.SE Robust**



***Short-Term***


<img width="600" alt="ST_ROBUST" src="https://github.com/user-attachments/assets/64803d68-d80c-495b-b8b2-93a03c249439" />




***Long-Term***


<img width="600" alt="LT_ROBUST" src="https://github.com/user-attachments/assets/7a51d153-6fa8-49aa-a336-cabaf192e496" />


Comparing the robust standard error results with the original regression models shows that the standard errors and significance levels remain largely similar in both the short-term and long-term regressions, while the coefficient estimates are essentially unchanged. This suggests that potential heteroskedasticity does not meaningfully affect the main conclusions, and the results for both models remain reasonably stable.



### Summary 


Overall, the two multiple linear regression models indicate that review activity is one of the core drivers of estimated turnover rate. In the short-term model, the regression coefficients confirm that compliance status has only a limited impact on turnover, which is consistent with the EDA finding that compliance status also plays a limited role in shaping pricing patterns. In addition, price and minimum nights are negatively associated with turnover, while year shows a strong positive association, suggesting that both affordability and flexibility matter for brief stays, and that short-term booking activity gradually increased during the post-pandemic recovery period. From the long-term model, year and price, which appear to have stronger effects on short-term turnover, play only limited roles, suggesting that booking frequency in the long-term market remained relatively stable during the post-pandemic period and that affordability may not be the main driver of long stays. What appears to matter more in the long-term market is who operates the accommodation. In particular, residential host type shows a strong and positive association with turnover, indicating that locally operated long-term listings may turn over more frequently than professionally managed listings. Interestingly, the turnover results do not move in the same direction as the pricing patterns observed in the EDA, as corporate listings show more stable pricing but lower turnover, while residential listings show more varied pricing and higher turnover.




## Spatial Analysis (ArcGIS)

The spatial analysis explores how short-term and long-term listings are distributed across Seattle’s neighbourhoods. Specifically, it examines the spatial distribution of compliance status within short-term listings, host type within long-term listings, and separate pricing heatmaps for short-term and long-term listings.

All spatial visualizations were completed in ArcGIS Online based on datasets prepared during the EDA process, with all room types retained, including Entire home/apt, Private room, and Shared room. Since each listing in the original dataset contains latitude and longitude coordinates, the aggregated data could be directly imported into ArcGIS Online for spatial mapping.



**Distribution of short-term and long-term listing**


<img width="1000" alt="st_lt_overall_com" src="https://github.com/user-attachments/assets/ba9f7972-6c38-470d-98e4-ad9fa53f76ac" />


As shown in the map, the red dots representing short-term listings are visibly denser and more widely distributed across Seattle’s neighbourhoods. In particular, they are more heavily concentrated in the northern neighbourhoods of Seattle, both within and around the urban core as well as in nearby neighbourhoods beyond it. The yellow dots representing long-term listings display a broadly similar distribution, with stronger concentration in the urban core and the northern neighbourhoods of Seattle, but with visibly lower overall density.


### Short-Term 


**Distribution of Compliance Status**

<img width="1000" alt="st_compliance _com" src="https://github.com/user-attachments/assets/1d650880-eaf8-48da-ae78-a23e4146b356" />



This compliance-status map attempts to highlight the spatial distribution of violation and no_license listings. With red point markers representing violation listings, the map shows that these listings are most heavily concentrated in the northern part of the Other Neighbourhoods group adjacent to the urban core, as well as in central Seattle, including Downtown, Capitol Hill, and Central Area. However, they are also distributed more broadly across Seattle’s neighbourhoods rather than being limited to those areas. With black point markers representing no_license listings, very few such listings are visibly noticeable on the map, although a small cluster can be observed in Downtown, with a few additional points appearing around the edges of the mapped area. The map also shows that legal listings, represented by yellow dots, make up the majority and are widely distributed across Seattle’s neighbourhoods, consistent with the EDA findings.


**Distribution of Pricing**


<img width="1000" alt="st_heatmap" src="https://github.com/user-attachments/assets/cc2b6429-b666-4fdd-bc5b-3c79a1f9bf02" />



The pricing heatmap shows that the highest nightly rates are concentrated most heavily in Downtown, although high-priced listings can also be found around Seattle’s urban core, including Capitol Hill, Central Area, Queen Anne, Interbay, and the northern part of the Other Neighbourhoods group.


### Long-Term 



**Distribution of Host Type**



<img width="1000" alt="lt_host_type_com" src="https://github.com/user-attachments/assets/9bb994d5-568d-47f2-ad67-cfa922762ff5" />



The map attempts to highlight the distribution of corporate listings managed by professional companies, represented by red house markers. As shown in the map, corporate listings are significantly concentrated in Seattle’s urban core, including Downtown, Capitol Hill, and Central Area, as well as in the northern part of the Other Neighbourhoods group adjacent to the urban core. With yellow dots representing residential listings, the map also shows that these listings are more sparsely distributed across Seattle’s neighbourhoods, although small clusters can be observed in the University District and Capitol Hill.


**Distribution of Pricing**


<img width="1000" alt="lt_heatmap" src="https://github.com/user-attachments/assets/501e3927-b91d-421b-aaca-201f09b7d277" />



This heatmap presents a very different spatial distribution of pricing from the short-term market, with the highest monthly rates concentrated throughout central Seattle and its urban-core neighbourhoods, as well as in the University District and the northern part of the Other Neighbourhoods group near the urban core. Visually, the map shows that high monthly rates are not limited to northern Seattle, but also appear in several clusters in the southern part of the neighbourhoods, including West Seattle and Beacon Hill.



## Conclusion


Honestly, this is not an easy or perfect analysis because the dataset provides only limited information on listing-specific amenities and room details. From a regulatory perspective, however, the findings suggest that Seattle’s short-term operating license system functions relatively well, as most short-term listings appear to be legal and properly licensed, and overall pricing patterns do not seem to be strongly affected by compliance status. For long-term listings, I initially expected corporate listings to exhibit more outliers and stronger right-skewness. However, the results show that corporate listings have a more stable pricing pattern than residential listings, even though residential listings are more strongly associated with turnover rate. Overall, the analysis suggests that Seattle’s Airbnb market is highly segmented, as short-term and long-term listings follow different regulations, pricing patterns, turnover dynamics, and spatial structures.
