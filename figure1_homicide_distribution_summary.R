# ============================================================
# FIGURE 1 — HOMICIDE DISTRIBUTION SUMMARY
#
# PURPOSE:
# Summarise the county-level distribution of cumulative
# homicide counts used in Figure 1.
#
# STUDY PERIOD:
# 2014–2023
#
# OUTPUTS:
# 1. Number and percentage of county-level polygons in each
#    homicide-count category.
# 2. Number and percentage of mapped homicide cases represented
#    by each category.
# 3. Total number of mapped county polygons and homicide cases.
#
# FIGURE 1 CATEGORIES:
# 0
# 1–10
# 11–20
# 21–30
# 31–40
# 41–50
# 51–60
# 61–100
# 101–119
#
# VERIFIED FIGURE 1 BASELINE:
# County-level polygons = 2,841
# Mapped homicide cases = 18,665
# Total geocoded cases  = 18,720
# Cartographic coverage = 99.71%
#
# NOTE:
# The 61–100 category contains no county-level observations.
# This is an observed gap in the distribution, not missing data.
#
# IMPORTANT:
# This script is descriptive only and does not modify homicide
# counts, county identifiers, or polygon geometries.
# ============================================================




figure1_distribution_table <-
+     figure1_final_sf %>%
+     st_drop_geometry() %>%
+     group_by(
+         homicide_category,
+         .drop = FALSE
+     ) %>%
+     summarise(
+         counties = n(),
+         homicide_cases = sum(homicide_count),
+         .groups = "drop"
+     ) %>%
+     mutate(
+         county_percent =
+             100 * counties / sum(counties),
+         
+         homicide_percent =
+             100 * homicide_cases / sum(homicide_cases)
+     )
> 
> print(
+     as.data.frame(figure1_distribution_table),
+     row.names = FALSE
+ )
 homicide_category counties homicide_cases county_percent homicide_percent
                 0      301              0    10.59486096        0.0000000
              1–10     1988           9057    69.97536079       48.5239754
             11–20      435           6120    15.31151003       32.7886418
             21–30       78           1882     2.74551214       10.0830431
             31–40       25            848     0.87997184        4.5432628
             41–50        8            361     0.28159099        1.9341013
             51–60        5            278     0.17599437        1.4894187
            61–100        0              0     0.00000000        0.0000000
           101–119        1            119     0.03519887        0.6375569
> 
> cat(
+     "\nTotal counties =",
+     sum(figure1_distribution_table$counties)
+ )

Total counties = 2841> 
> cat(
+     "\nTotal mapped homicide cases =",
+     sum(figure1_distribution_table$homicide_cases),
+     "\n"
+ )

Total mapped homicide cases = 18665 
> 
