# china-homicide-county-geocoding
County-level geocoding, administrative matching, and quality-control workflow for Chinese homicide cases (2014–2023), supporting downstream ERA5 and DLNM analyses.

# China Homicide County-Level Geocoding

homicide-county-geocoding/
├── README.md
├── R/
│   ├── 01_match_status.R
│   ├── 02_matching_stage_summary.R
│   ├── 03_multilocation_killsite_review.R
│   └── 04_freeze_final_matching.R
├── data/
│   └── README.md
└── output/
    └── README.md



## Overview

This repository documents the geographic data-cleaning and county-level matching procedure used to assign Chinese homicide cases to unique county-level geographic identifiers.

The final county identifier is used to link homicide records with county-day environmental exposure data, including ERA5 precipitation and meteorological variables, for subsequent county-day and distributed lag nonlinear model (DLNM) analyses.

The primary matching principle was:

> Assign a county-level ID only when the homicide location could be determined with sufficient confidence. Ambiguous cases were retained as unmatched rather than being assigned probabilistically.

---

## Final dataset

Total homicide records:

**18,840**

Final authoritative geographic identifier:

`authoritative_id_cp`

Final matching result:

| Status     |  Cases | Percentage |
| ---------- | -----: | ---------: |
| Matched    | 18,720 | 99.363057% |
| Unresolved |    120 |  0.636943% |
| Total      | 18,840 |       100% |

The final R-verified baseline is:

```text
rows          = 18840
matched       = 18720
unresolved    = 120
matching rate = 99.363057%
```

---

## Matching workflow

### Stage 1. Direct administrative-name extraction

County/district names were initially extracted directly from `Crime_Location`.

Primary fields:

* `county`
* `county2`

Matched cases:

**11,047 / 18,840 = 58.64%**

These cases contained recognizable county-, district-, or county-level city names in the original location text.

---

### Stage 2. Administrative-name standardization

The initial administrative names were further cleaned and standardized using:

* `county`
* `county2`
* `county_final`
* `county_name_admin`
* standardized administrative lookup tables

This step addressed:

* alternative spellings;
* abbreviations;
* redundant address strings;
* non-standard administrative names;
* text-parsing inconsistencies.

Cumulative matched cases:

**15,176 / 18,840 = 80.55%**

Newly resolved cases:

**4,129**

Increase in matching rate:

**+21.92 percentage points**

---

### Stage 3. Historical administrative changes

Historical administrative changes were handled using explicit replacement/crosswalk rules such as `replace_map`.

Examples included:

* county-to-district conversions;
* renamed administrative units;
* merged or abolished urban districts;
* historical county names that differed from the modern administrative lookup.

Cumulative matched cases:

**15,411 / 18,840 = 81.80%**

Newly resolved cases:

**235**

Increase in matching rate:

**+1.25 percentage points**

The first three stages are collectively referred to as:

**rule-based administrative matching**

---

### Stage 4. Secondary geographic recovery

Cases unresolved after rule-based matching underwent enhanced geographic recovery.

Evidence included:

* historical county boundaries;
* township and street information;
* village and community names;
* development zones and functional zones;
* POIs;
* roads, bridges, reservoirs, companies and other landmarks;
* spatial evidence;
* court and case-code information as supporting evidence;
* multi-source consistency;
* manual case-level adjudication.

Cases were classified as:

* `ACCEPT`
* `HOLD`
* `REJECT`

Only `ACCEPT` cases were written to the authoritative county ID.

Cumulative matched cases before the final multi-location review:

**18,719 / 18,840 = 99.357749%**

Cases recovered during this stage:

**3,308**

Increase in matching rate relative to Stage 3:

**+17.56 percentage points**

---

### Stage 5. Multi-location homicide-site review

A separate review was conducted for cases in which `Crime_Location` contained multiple geographic locations.

The environmental exposure location was defined as the **actual killing site**, rather than:

* transport location;
* body disposal location;
* body discovery location;
* crime preparation location.

Fifteen unresolved cases were identified as structural multi-location cases.

A dedicated event-role review found:

* 1 case with a recoverable killing location;
* 14 cases that remained unresolved.

The successfully recovered case was:

`(2014) 昆刑一初字第174号`

The victim was ultimately killed at:

**嵩明县杨林镇八家村水库西侧**

Final county ID:

`530127`

This increased the final matched count from:

**18,719 → 18,720**

and the final matching rate from:

**99.357749% → 99.363057%**

---

## Matching-stage summary

| Stage                                | Cumulative matched | Cumulative rate | New matches |       Increase |
| ------------------------------------ | -----------------: | --------------: | ----------: | -------------: |
| Direct county/district extraction    |             11,047 |          58.64% |           — |              — |
| Administrative-name standardization  |             15,176 |          80.55% |       4,129 |      +21.92 pp |
| Historical administrative correction |             15,411 |          81.80% |         235 |       +1.25 pp |
| Secondary recovery and adjudication  |             18,719 |      99.357749% |       3,308 |      +17.56 pp |
| Multi-location killing-site review   |         **18,720** |  **99.363057%** |       **1** | **+0.0053 pp** |

---

## Final composition of matched cases

### Rule-based administrative matching

**15,411 cases**

Approximately:

**81.80% of all records**

These cases were resolved through:

* direct administrative names;
* standardized county names;
* administrative lookup tables;
* documented historical administrative changes.

### Secondary recovery and manual adjudication

**3,309 cases**

Approximately:

**17.56% of all records**

These cases required one or more of:

* historical geographic interpretation;
* township/street evidence;
* functional-zone adjudication;
* POI evidence;
* spatial evidence;
* case-specific manual review.

### Final unresolved cases

**120 cases**

Approximately:

**0.64% of all records**

---

## Why cases remained unresolved

The remaining cases were retained as unmatched when a unique killing-site county could not be established confidently.

Main reasons included:

1. Severe address anonymization.
2. Multiple locations with unclear event roles.
3. Cross-county or cross-district locations.
4. Functional zones spanning multiple legal county-level units.
5. Historical administrative ambiguity.
6. Overseas or offshore locations.
7. Conflicting or clearly erroneous spatial matches.
8. Parser or dictionary contamination.
9. POI truncation.
10. Prefecture-level city names incorrectly mapped to subordinate county IDs.
11. Court jurisdiction that did not uniquely identify the killing location.

---

## Important data-quality rules

### Candidate IDs are not authoritative IDs

The following fields may contain intermediate or diagnostic candidates:

* `candidate_id`
* `court_target_id`
* `spatial_id`
* `recovery_id`
* `target_id`
* `consensus_candidate_id`

They must not be used as final county IDs without adjudication.

The only final county identifier is:

`authoritative_id_cp`

---

### Spatial matching is supporting evidence only

Spatial matches were not automatically accepted because several historical spatial results were found to be geographically implausible or cross-province.

Spatial information was therefore used only when consistent with independent geographic evidence.

---

### Court information is supporting evidence only

Court names and case codes were not treated as sufficient evidence of the homicide location.

Court jurisdiction may differ from the actual crime location.

---

### POI truncation

Some complete administrative or functional-zone names were incorrectly truncated into strings resembling independent POIs.

For example:

`苏州工业园区`

could be truncated to:

`苏州工业园`

and subsequently matched as if it were an independent POI.

Such matches were treated as false POI evidence and rejected.

---

### Multi-location cases

A multi-location record does not necessarily mean that the killing site is absent.

It means that the structured `Crime_Location` field contains multiple crime-related locations and may not preserve the role of each location.

Where possible, original judgment information was reviewed to identify the actual killing location.

---

## Reproducibility rule

After every diagnostic or write-back step, matching status must be calculated directly in R.

No matching percentages should be calculated manually during the recovery workflow.

Each recovery script should print:

* total rows;
* matched rows;
* unresolved rows;
* matching rate.

Recommended checkpoints:

* `START`
* `AFTER DIAGNOSTIC` or `AFTER WRITE-BACK`
* `END`

---

## Final analysis rule

The primary analysis dataset should use:

```r
!is.na(authoritative_id_cp)
```

The 120 unresolved cases should not receive county-level environmental exposure assignments.

Final analysis sample:

**18,720 homicide records**

Final geographic matching rate:

**99.363057%**

---

## Next analytical step

The final matched homicide data can now be aggregated by:

`authoritative_id_cp + crime_date`

to construct:

**county-day homicide counts**

These data can subsequently be merged with:

* ERA5 county-day precipitation;
* temperature;
* relative humidity;
* wind;
* other meteorological variables;

for downstream DLNM and related regression analyses.


# Data

Raw homicide case-level data are not included in this public repository.

The working dataset contains 18,840 homicide records from 2014–2023.

Final geographic matching:
- Total: 18,840
- Matched: 18,720
- Unresolved: 120
- Matching rate: 99.363057%

The final authoritative county-level identifier is:

`authoritative_id_cp`

Sensitive case-level data are stored separately and are not publicly distributed.





# Output

This directory documents the expected outputs of the county-level geocoding workflow.

Recommended outputs include:

- `matching_stage_summary.csv`
- `multilocation_review.csv`
- `unresolved_cases.csv`
- `final_homicide_county_match.csv`

The final analysis dataset should include only records with a non-missing:

`authoritative_id_cp`

Final matched sample:
- Matched: 18,720
- Unresolved: 120
- Matching rate: 99.363057%

