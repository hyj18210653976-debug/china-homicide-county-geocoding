# ============================================================
# FREEZE FINAL COUNTY-ID MATCHING
#
# FINAL BASELINE:
#   rows       = 18840
#   matched    = 18720
#   unresolved = 120
#   rate       = 99.363057%
#
# authoritative field:
#   authoritative_id_cp
# ============================================================


# ------------------------------------------------------------
# 1. VERIFY FINAL STATE
# ------------------------------------------------------------

final_status <-
    print_match_status(
        "FINAL FROZEN MATCHING STATUS"
    )


stopifnot(
    final_status$rows == 18840L,
    final_status$matched == 18720L,
    final_status$unresolved == 120L
)


# ------------------------------------------------------------
# 2. VERIFY FINAL KILL-SITE RECOVERY
# ------------------------------------------------------------

stopifnot(
    !is.na(
        authoritative_id_cp[
            1055L
        ]
    ),

    as.character(
        authoritative_id_cp[
            1055L
        ]
    ) ==
        "530127"
)


# ------------------------------------------------------------
# 3. CREATE FINAL MATCH FLAG
# ------------------------------------------------------------

final_match_flag <-
    !is.na(
        authoritative_id_cp
    )


stopifnot(
    sum(
        final_match_flag
    ) == 18720L
)


# ------------------------------------------------------------
# 4. OPTIONAL FINAL ANALYSIS INDEX
# ------------------------------------------------------------

analysis_rows <-
    which(
        final_match_flag
    )


unresolved_rows <-
    which(
        !final_match_flag
    )


stopifnot(
    length(
        analysis_rows
    ) == 18720L,

    length(
        unresolved_rows
    ) == 120L
)


cat("\nFINAL COUNTY MATCHING FROZEN.\n")
