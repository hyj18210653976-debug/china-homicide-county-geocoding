# ============================================================
# F402 — ERA5 COUNTY-DAY PRECIPITATION COVERAGE
# AND MISSINGNESS AUDIT
#
# STUDY PERIOD:
# 2014-01-01 to 2023-12-31
#
# PURPOSE:
# 1. Verify completeness of the population-weighted ERA5
#    county-day panel.
# 2. Calculate county-day precipitation coverage.
# 3. Identify the structure of meteorological missingness.
#
# IMPORTANT:
# This is a COUNTY-DAY coverage metric.
# It is NOT the homicide case-level linkage rate.
#
# NO DATA MODIFICATION.
# NO POPULATION WEIGHTING IS REDONE.
# ============================================================

library(data.table)


# ------------------------------------------------------------
# 1. REQUIRE VERIFIED ERA5 OBJECT
# ------------------------------------------------------------

stopifnot(
    exists(
        "era5_2014_2023"
    )
)


# ------------------------------------------------------------
# 2. BASIC PANEL QC
# ------------------------------------------------------------

total_county_days <-
    nrow(
        era5_2014_2023
    )


county_n <-
    uniqueN(
        era5_2014_2023$uni_loc_id
    )


date_n <-
    uniqueN(
        era5_2014_2023$date
    )


cat("\n============================================================\n")
cat("ERA5 COUNTY-DAY PANEL QC\n")
cat("============================================================\n")

cat(
    "County IDs =",
    county_n,
    "\n"
)

cat(
    "Dates =",
    date_n,
    "\n"
)

cat(
    "County-day observations =",
    total_county_days,
    "\n"
)

cat(
    "Date range =",
    as.character(
        min(
            era5_2014_2023$date
        )
    ),
    "to",
    as.character(
        max(
            era5_2014_2023$date
        )
    ),
    "\n"
)


# ------------------------------------------------------------
# 3. VERIFY EXPECTED PANEL DIMENSIONS
# ------------------------------------------------------------

stopifnot(
    county_n == 2856L,
    date_n == 3652L,
    total_county_days == 10430112L
)

stopifnot(
    county_n *
        date_n ==
        total_county_days
)


# ------------------------------------------------------------
# 4. DUPLICATE COUNTY-DAY CHECK
# ------------------------------------------------------------

era5_duplicate_check <-
    era5_2014_2023[
        ,
        .N,
        by = .(
            uni_loc_id,
            date
        )
    ][
        N > 1
    ]


cat(
    "\nDuplicate county-day records =",
    nrow(
        era5_duplicate_check
    ),
    "\n"
)


stopifnot(
    nrow(
        era5_duplicate_check
    ) ==
        0L
)


# ------------------------------------------------------------
# 5. DAILY COUNTY COVERAGE
# ------------------------------------------------------------

daily_count_check <-
    era5_2014_2023[
        ,
        .(
            county_n =
                uniqueN(
                    uni_loc_id
                )
        ),
        by = date
    ]


cat(
    "Minimum counties per day =",
    min(
        daily_count_check$county_n
    ),
    "\n"
)

cat(
    "Maximum counties per day =",
    max(
        daily_count_check$county_n
    ),
    "\n"
)


stopifnot(
    min(
        daily_count_check$county_n
    ) ==
        2856L,

    max(
        daily_count_check$county_n
    ) ==
        2856L
)


# ------------------------------------------------------------
# 6. PRECIPITATION COVERAGE
#
# NOTE:
# Original variable name is intentionally retained:
# perticipation_mm
# ------------------------------------------------------------

nonmissing_precipitation <-
    sum(
        !is.na(
            era5_2014_2023$
                perticipation_mm
        )
    )


missing_precipitation <-
    sum(
        is.na(
            era5_2014_2023$
                perticipation_mm
        )
    )


county_day_precipitation_coverage <-
    100 *
    nonmissing_precipitation /
    total_county_days


cat("\n==============================\n")
cat("PRECIPITATION COVERAGE\n")
cat("==============================\n")

cat(
    "Total county-days =",
    total_county_days,
    "\n"
)

cat(
    "Non-missing precipitation =",
    nonmissing_precipitation,
    "\n"
)

cat(
    "Missing precipitation =",
    missing_precipitation,
    "\n"
)

cat(
    "County-day precipitation coverage =",
    sprintf(
        "%.4f%%",
        county_day_precipitation_coverage
    ),
    "\n"
)


stopifnot(
    nonmissing_precipitation ==
        10404548L,

    missing_precipitation ==
        25564L,

    nonmissing_precipitation +
        missing_precipitation ==
        total_county_days
)


# ------------------------------------------------------------
# 7. IDENTIFY MISSING COUNTY-DAYS
# ------------------------------------------------------------

precip_missing <-
    era5_2014_2023[
        is.na(
            perticipation_mm
        )
    ]


cat("\n==============================\n")
cat("MISSINGNESS STRUCTURE\n")
cat("==============================\n")

cat(
    "Missing meteorological county-days =",
    nrow(
        precip_missing
    ),
    "\n"
)

cat(
    "Affected county IDs =",
    uniqueN(
        precip_missing$
            uni_loc_id
    ),
    "\n"
)

cat(
    "Affected dates =",
    uniqueN(
        precip_missing$
            date
    ),
    "\n"
)


# ------------------------------------------------------------
# 8. MISSINGNESS BY COUNTY
# ------------------------------------------------------------

missing_by_county <-
    precip_missing[
        ,
        .(
            missing_days =
                .N,

            first_missing =
                min(
                    date
                ),

            last_missing =
                max(
                    date
                )
        ),
        by = uni_loc_id
    ][
        order(
            -missing_days
        )
    ]


print(
    as.data.frame(
        missing_by_county
    ),
    row.names = FALSE
)


# ------------------------------------------------------------
# 9. VERIFY SEVEN FULLY MISSING IDs
# ------------------------------------------------------------

expected_missing_ids <-
    c(
        "210224",
        "330922",
        "350527",
        "370634",
        "440523",
        "460300",
        "820000"
    )


stopifnot(
    uniqueN(
        precip_missing$
            uni_loc_id
    ) ==
        7L
)

stopifnot(
    setequal(
        as.character(
            missing_by_county$
                uni_loc_id
        ),
        expected_missing_ids
    )
)

stopifnot(
    all(
        missing_by_county$
            missing_days ==
            3652L
    )
)


# ------------------------------------------------------------
# 10. CHECK OTHER METEOROLOGICAL VARIABLES
# ------------------------------------------------------------

missing_weather_pattern <-
    precip_missing[
        ,
        .(
            precipitation_NA =
                sum(
                    is.na(
                        perticipation_mm
                    )
                ),

            temp_NA =
                sum(
                    is.na(
                        temp_C
                    )
                ),

            humidity_NA =
                sum(
                    is.na(
                        relative_humidity
                    )
                ),

            pressure_NA =
                sum(
                    is.na(
                        pressure_hp
                    )
                ),

            dew_temp_NA =
                sum(
                    is.na(
                        dew_temp
                    )
                ),

            solar_NA =
                sum(
                    is.na(
                        surface_solar_radiation_downwards
                    )
                ),

            wind_u_NA =
                sum(
                    is.na(
                        wind_u
                    )
                ),

            wind_v_NA =
                sum(
                    is.na(
                        wind_v
                    )
                )
        )
    ]


cat("\n==============================\n")
cat("METEOROLOGICAL MISSINGNESS PATTERN\n")
cat("==============================\n")

print(
    missing_weather_pattern
)


# ------------------------------------------------------------
# 11. SPECIAL ID 0 CHECK
# ------------------------------------------------------------

id0_check <-
    era5_2014_2023[
        as.character(
            uni_loc_id
        ) ==
            "0",
        .(
            total_days =
                .N,

            precipitation_available =
                sum(
                    !is.na(
                        perticipation_mm
                    )
                ),

            precipitation_missing =
                sum(
                    is.na(
                        perticipation_mm
                    )
                )
        )
    ]


cat("\n==============================\n")
cat("SPECIAL ID 0 CHECK\n")
cat("==============================\n")

print(
    id0_check
)


# ------------------------------------------------------------
# 12. FINAL CONSERVATION CHECK
# ------------------------------------------------------------

stopifnot(
    nrow(
        precip_missing
    ) ==
        25564L
)

stopifnot(
    nonmissing_precipitation +
        nrow(
            precip_missing
        ) ==
        total_county_days
)


cat("\n============================================================\n")
cat("F402 COMPLETE\n")
cat("COUNTY-DAY PRECIPITATION COVERAGE = 99.7549%\n")
cat("NO DATA MODIFIED\n")
cat("============================================================\n")
