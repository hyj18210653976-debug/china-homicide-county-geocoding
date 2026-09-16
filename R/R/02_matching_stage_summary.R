# ============================================================
# MATCHING STAGE SUMMARY
# ============================================================

total_n <- 18840L


matching_stage_summary <-
    data.frame(
        stage = c(
            "Direct county/district extraction",
            "Administrative-name standardization",
            "Historical administrative correction",
            "Secondary recovery and adjudication",
            "Multi-location killing-site review"
        ),

        matched = c(
            11047L,
            15176L,
            15411L,
            18719L,
            18720L
        ),

        stringsAsFactors = FALSE
    )


matching_stage_summary$rate <-
    matching_stage_summary$matched /
    total_n


matching_stage_summary$new_matches <-
    c(
        NA_integer_,
        diff(
            matching_stage_summary$matched
        )
    )


matching_stage_summary$increase_pp <-
    c(
        NA_real_,
        diff(
            matching_stage_summary$rate
        ) * 100
    )


matching_stage_summary$rate_percent <-
    matching_stage_summary$rate * 100


print(
    matching_stage_summary,
    row.names = FALSE
)


stopifnot(
    tail(
        matching_stage_summary$matched,
        1
    ) == 18720L
)
