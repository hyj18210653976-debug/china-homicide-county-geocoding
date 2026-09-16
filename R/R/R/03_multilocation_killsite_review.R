# ============================================================
# MULTI-LOCATION KILL-SITE REVIEW
#
# Target exposure location:
#   actual killing site
#
# Do NOT substitute:
#   dump site
#   transport site
#   body discovery site
# ============================================================


multi_location_review <-
    data.frame(
        row_index = c(
            1055L,
            2227L,
            2276L,
            2907L,
            3222L,
            3680L,
            4045L,
            7401L,
            8066L,
            11116L,
            13112L,
            13384L,
            13733L,
            14693L,
            15055L
        ),

        status = c(
            "ACCEPT",
            "HOLD",
            "HOLD",
            "HOLD",
            "HOLD",
            "HOLD",
            "HOLD",
            "HOLD",
            "HOLD",
            "HOLD",
            "HOLD",
            "HOLD",
            "HOLD",
            "HOLD",
            "HOLD"
        ),

        stringsAsFactors = FALSE
    )


multi_location_review$target_id <-
    NA_character_


multi_location_review$target_id[
    multi_location_review$row_index ==
        1055L
] <-
    "530127"


multi_location_review$reason <-
    "Actual killing-site county could not be uniquely established."


multi_location_review$reason[
    multi_location_review$row_index ==
        1055L
] <-
    paste0(
        "Public judgment evidence identifies ",
        "Songming County, Yanglin Town, ",
        "Bajia Village reservoir west side ",
        "as the killing site."
    )


multi_location_review$reason[
    multi_location_review$row_index ==
        2276L
] <-
    paste0(
        "Songbei District is explicitly described ",
        "as the body-disposal site; ",
        "the killing site remains insufficiently verified."
    )


print(
    multi_location_review,
    row.names = FALSE
)


stopifnot(
    sum(
        multi_location_review$status ==
            "ACCEPT"
    ) == 1L
)
