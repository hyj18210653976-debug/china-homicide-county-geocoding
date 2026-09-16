# ============================================================
# MATCH STATUS HELPER
# ============================================================

print_match_status <- function(
    label,
    id_vector = authoritative_id_cp
) {

    rows_n <-
        length(id_vector)

    matched_n <-
        sum(
            !is.na(id_vector)
        )

    unresolved_n <-
        sum(
            is.na(id_vector)
        )

    match_rate <-
        matched_n / rows_n


    cat("\n==============================\n")
    cat(label, "\n")
    cat("==============================\n")

    cat(
        "rows          =",
        rows_n,
        "\n"
    )

    cat(
        "matched       =",
        matched_n,
        "\n"
    )

    cat(
        "unresolved    =",
        unresolved_n,
        "\n"
    )

    cat(
        "matching rate =",
        sprintf(
            "%.6f%%",
            match_rate * 100
        ),
        "\n"
    )


    invisible(
        list(
            rows = rows_n,
            matched = matched_n,
            unresolved = unresolved_n,
            rate = match_rate
        )
    )
}
