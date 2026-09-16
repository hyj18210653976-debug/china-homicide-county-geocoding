# ============================================================
# v36-F347A
# KILL-SITE VERIFIED RECOVERY
#
# row 1055
# (2014) 昆刑一初字第174号
#
# VERIFIED KILL SITE:
#   嵩明县杨林镇八家村水库西侧
#
# TARGET:
#   嵩明县
#   530127
#
# PURPOSE:
#   Reproduce / audit the verified recovery safely.
#
# BEHAVIOR:
#   - if row 1055 is NA: write 530127
#   - if row 1055 is already 530127: verify and keep unchanged
#   - if row 1055 contains another ID: stop with error
# ============================================================


# ------------------------------------------------------------
# 0. START STATUS
# ------------------------------------------------------------

status_v36f347a_start <-
    print_match_status(
        "v36-F347A START"
    )


# ------------------------------------------------------------
# 1. TARGET
# ------------------------------------------------------------

rr_v36f347a <- 1055L
target_id_v36f347a <- "530127"


cat("\n==============================\n")
cat("F347A TARGET\n")
cat("==============================\n")

cat(
    "row      =", rr_v36f347a, "\n",
    "case     =", case_cp[rr_v36f347a], "\n",
    "date     =", date_cp[rr_v36f347a], "\n",
    "court    =", court_cp[rr_v36f347a], "\n",
    "location =", location_cp[rr_v36f347a], "\n",
    "target   = 嵩明县 / 530127\n"
)


# ------------------------------------------------------------
# 2. CASE SANITY CHECK
# ------------------------------------------------------------

stopifnot(
    grepl(
        "昆刑一初字第.*174",
        case_cp[
            rr_v36f347a
        ]
    )
)


# ------------------------------------------------------------
# 3. SAFE / IDEMPOTENT WRITE-BACK
# ------------------------------------------------------------

current_id_v36f347a <-
    as.character(
        authoritative_id_cp[
            rr_v36f347a
        ]
    )


if (
    is.na(
        authoritative_id_cp[
            rr_v36f347a
        ]
    )
) {

    authoritative_id_cp[
        rr_v36f347a
    ] <-
        target_id_v36f347a

    cat(
        "\nF347A WRITE-BACK PERFORMED:",
        "row 1055 -> 530127\n"
    )

} else if (
    current_id_v36f347a ==
        target_id_v36f347a
) {

    cat(
        "\nF347A ALREADY APPLIED:",
        "row 1055 is already 530127; no change made.\n"
    )

} else {

    stop(
        paste0(
            "F347A CONFLICT: row 1055 currently contains ID ",
            current_id_v36f347a,
            ", expected 530127."
        )
    )
}


# ------------------------------------------------------------
# 4. VERIFY FINAL TARGET
# ------------------------------------------------------------

stopifnot(
    !is.na(
        authoritative_id_cp[
            rr_v36f347a
        ]
    ),

    as.character(
        authoritative_id_cp[
            rr_v36f347a
        ]
    ) ==
        target_id_v36f347a
)


# ------------------------------------------------------------
# 5. AFTER STATUS
# ------------------------------------------------------------

status_v36f347a_after <-
    print_match_status(
        "v36-F347A AFTER APPLY / VERIFY"
    )


# ------------------------------------------------------------
# 6. FINAL EXPECTED STATE
# ------------------------------------------------------------

stopifnot(
    status_v36f347a_after$rows == 18840L,
    status_v36f347a_after$matched == 18720L,
    status_v36f347a_after$unresolved == 120L
)


cat("\n==============================\n")
cat("F347A VERIFIED\n")
cat("==============================\n")

cat(
    "row 1055 -> 嵩明县 / 530127\n"
)

- F347A: verified killing-site recovery for row 1055; safely reproducible as an idempotent audit/write-back script.

F347A
row 1055
current ID = 530127
status = already applied and verified
final matched = 18,720
final unresolved = 120
final rate = 99.363057%
