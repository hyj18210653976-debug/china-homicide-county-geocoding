# ------------------------------------------------------------
> # 7. F346A MULTI-LOCATION AUDIT
> # ------------------------------------------------------------
> 
> expected_multi_rows_final_audit <-
+     c(
+         1055L,
+         2227L,
+         2276L,
+         2907L,
+         3222L,
+         3680L,
+         4045L,
+         7401L,
+         8066L,
+         11116L,
+         13112L,
+         13384L,
+         13733L,
+         14693L,
+         15055L
+     )
> 
> 
> stopifnot(
+     length(
+         expected_multi_rows_final_audit
+     ) == 15L
+ )
> 
> 
> if (
+     exists("event_summary_v36f346a")
+ ) {
+     
+     cat("\n========================================\n")
+     cat("F346A MULTI-LOCATION AUDIT\n")
+     cat("========================================\n")
+     
+     cat(
+         "reviewed cases =",
+         nrow(
+             event_summary_v36f346a
+         ),
+         "\n"
+     )
+     
+     
+     stopifnot(
+         nrow(
+             event_summary_v36f346a
+         ) == 15L
+     )
+     
+ } else {
+     
+     cat(
+         "\nF346A object not loaded.\n",
+         "Run archive/F346A_multilocation_event_role.R first.\n"
+     )
+ }

========================================
F346A MULTI-LOCATION AUDIT
========================================
reviewed cases = 15 
> event_summary_v36f346a
   row_index                           case       date
1       1055     (2014) 昆刑一初字第 174 号 2014-05-26
2       2227      (2015) 曲中刑初字第 78 号 2014-10-19
3       2276      (2015) 哈刑一初字第 61 号 2014-10-26
4       2907 (2015) 鄂三峡刑初字第 00045 号 2015-01-26
5       3222    (2015) 辽阳刑一初字第 32 号 2015-03-09
6       3680     (2015) 浙温刑初字第 167 号 2015-05-06
7       4045     (2016) 粤 0106 刑初 348 号 2015-06-20
8       7401       (2017) 川 01 刑初 122 号 2016-07-19
9       8066        (2017) 闽 06 刑初 33 号 2016-09-26
10     11116        (2018) 辽 14 刑初 33 号 2017-09-14
11     13112     (2018) 苏 0724 刑初 381 号 2018-05-24
12     13384     (2018) 渝 0109 刑初 591 号 2018-06-25
13     13733        (2019) 黑 01 刑初 13 号 2018-08-05
14     14693        (2019) 内 01 刑初 16 号 2018-12-16
15     15055     (2019) 津 0106 刑初 186 号 2019-02-04
                          court
1      云南省昆明市中级人民法院
2      云南省曲靖市中级人民法院
3  黑龙江省哈尔滨市中级人民法院
4  湖北省宜昌市三峡坝区人民法院
5      辽宁省辽阳市中级人民法院
6      浙江省温州市中级人民法院
7    广东省广州市天河区人民法院
8      四川省成都市中级人民法院
9      福建省漳州市中级人民法院
10   辽宁省葫芦岛市中级人民法院
11         江苏省灌南县人民法院
12         重庆市北碚区人民法院
13 黑龙江省哈尔滨市中级人民法院
14 内蒙古呼和浩特市中级人民法院
15         天津市红桥区人民法院
                                                                                                       location
1                                              昆明市官渡区大板桥镇天水路南侧铁塔下及嵩明县杨林镇八家村水库西侧
2                                                                宣威市北苑小区、曲靖市麒麟区、陆良县大田蓄水池
3                                                哈尔滨市道外区太古街 587-1 号 A 栋 1 单元 701 室及松北区抛尸地
4  宜昌市高新技术产业开发区发展大道半山酒店 12 号楼旁、山西省水产育种养殖科学实验现场、清徐县孔村村东干渠东坝堰
5                                                       辽阳市 XX 区 XX 镇 XX 五金店、黄 X 平经营的农联百货超市
6                               苍南县龙港镇通港路 382 号宾馆 301 房间、平阳县鳌江镇江滨西路 107 号后面堤坝附近
7                                                                      广州市白云区、天河区天河北苑及弘阳舞蹈室
8                                                                                    成都市青白江区、金堂县等地
9                                                                                  漳州市龙文区、龙海市西溪大桥
10                                   葫芦岛市连山区刘台子龙泽苑小区内、龙港区连湾街道西苑小学南侧五百米的空地上
11       江苏省灌南县新安镇河滨路凌某经营的足疗店、连云港市赣榆区抗日山附近、赣榆区厉庄镇西斗岭村西斗岭水库附近
12                                                         重庆市北碚区第九人民医院病房、合川区汽车零配件制造厂
13                                                                   哈尔滨市南岗区闽江小区、道里区安宁街烧烤摊
14                                             呼和浩特市金川开发区水业公司、新城区呼铁佳园、玉泉区天骄花园小区
15                                                                       天津市和平区张某家中、红桥区子牙河南路
   kill_evidence_n kill_distinct_text_n dump_evidence_n
1                0                    0               0
2                0                    0               0
3                0                    0              60
4                0                    0               0
5                0                    0               0
6                0                    0               0
7                0                    0               0
8                0                    0               0
9                0                    0               0
10               0                    0               0
11               0                    0               0
12               0                    0               0
13               0                    0               0
14               0                    0               0
15               0                    0               0
   discovery_evidence_n transport_evidence_n
1                     0                    0
2                     0                    0
3                     0                    0
4                     0                    0
5                     0                    0
6                     0                    0
7                     0                    0
8                     0                    0
9                     0                    0
10                    0                    0
11                    0                    0
12                    0                    0
13                    0                    0
14                    0                    0
15                    0                    0
                   review_class
1      C_NO_EVENT_ROLE_EVIDENCE
2      C_NO_EVENT_ROLE_EVIDENCE
3  B_ONLY_NONKILL_ROLE_EVIDENCE
4      C_NO_EVENT_ROLE_EVIDENCE
5      C_NO_EVENT_ROLE_EVIDENCE
6      C_NO_EVENT_ROLE_EVIDENCE
7      C_NO_EVENT_ROLE_EVIDENCE
8      C_NO_EVENT_ROLE_EVIDENCE
9      C_NO_EVENT_ROLE_EVIDENCE
10     C_NO_EVENT_ROLE_EVIDENCE
11     C_NO_EVENT_ROLE_EVIDENCE
12     C_NO_EVENT_ROLE_EVIDENCE
13     C_NO_EVENT_ROLE_EVIDENCE
14     C_NO_EVENT_ROLE_EVIDENCE
15     C_NO_EVENT_ROLE_EVIDENCE
> # ------------------------------------------------------------
> # 8. FINAL MULTI-LOCATION DECISION
> # ------------------------------------------------------------
> 
> if (
+     exists("multi_location_review")
+ ) {
+     
+     accept_n_final_audit <-
+         sum(
+             multi_location_review$
+                 status ==
+                 "ACCEPT"
+         )
+     
+     
+     hold_n_final_audit <-
+         sum(
+             multi_location_review$
+                 status ==
+                 "HOLD"
+         )
+     
+     
+     cat("\n========================================\n")
+     cat("FINAL MULTI-LOCATION DECISION\n")
+     cat("========================================\n")
+     
+     cat(
+         "ACCEPT =", accept_n_final_audit, "\n",
+         "HOLD   =", hold_n_final_audit, "\n"
+     )
+     
+     
+     stopifnot(
+         nrow(
+             multi_location_review
+         ) == 15L,
+         
+         accept_n_final_audit == 1L,
+         
+         hold_n_final_audit == 14L
+     )
+     
+     
+     row1055_review <-
+         multi_location_review[
+             multi_location_review$
+                 row_index ==
+                 1055L,
+             ,
+             drop = FALSE
+         ]
+     
+     
+     stopifnot(
+         nrow(
+             row1055_review
+         ) == 1L,
+         
+         row1055_review$status ==
+             "ACCEPT",
+         
+         as.character(
+             row1055_review$
+                 target_id
+         ) ==
+             "530127"
+     )
+     
+ } else {
+     
+     cat(
+         "\nmulti_location_review not loaded.\n",
+         "Run R/03_multilocation_killsite_review.R first.\n"
+     )
+ }

========================================
FINAL MULTI-LOCATION DECISION
========================================
ACCEPT = 1 
 HOLD   = 14 
> # ------------------------------------------------------------
> # 9. VERIFY AUDIT DID NOT MODIFY FINAL IDS
> # ------------------------------------------------------------
> 
> stopifnot(
+     identical(
+         authoritative_id_cp,
+         id_before_final_audit
+     )
+ )
> # ------------------------------------------------------------
> # 10. FINAL RESULT
> # ------------------------------------------------------------
> 
> cat("\n========================================\n")

========================================
> cat("FINAL ARCHIVE AUDIT PASSED\n")
FINAL ARCHIVE AUDIT PASSED
> cat("========================================\n")
========================================
> 
> cat(
+     "rows       =", rows_final_audit, "\n",
+     "matched    =", matched_final_audit, "\n",
+     "unresolved =", unresolved_final_audit, "\n",
+     "match rate =", sprintf("%.6f%%", rate_final_audit), "\n",
+     "row 1055   = 530127\n",
+     "F24D       = 4 / 4 verified\n",
+     "F26A       = 7 / 7 verified\n",
+     "F339A      = 28 / 28 verified\n",
+     "F339B-R1   = 1 legitimate + 27 strict leaks verified\n",
+     "NO authoritative IDs modified.\n"
+ )
rows       = 18840 
 matched    = 18720 
 unresolved = 120 
 match rate = 99.363057% 
 row 1055   = 530127
 F24D       = 4 / 4 verified
 F26A       = 7 / 7 verified
 F339A      = 28 / 28 verified
 F339B-R1   = 1 legitimate + 27 strict leaks verified
 NO authoritative IDs modified.
> 如果这段代码正确的话是不是可以存为final audit 的内容了



cat(
    "rows       =", rows_final_audit, "\n",
    "matched    =", matched_final_audit, "\n",
    "unresolved =", unresolved_final_audit, "\n",
    "match rate =", sprintf("%.6f%%", rate_final_audit), "\n",
    "row 1055   = 530127\n",
    "F24D       = 4 / 4 verified\n",
    "F26A       = 7 / 7 verified\n",
    "F339A      = 28 / 28 verified\n",
    "F339B-R1   = 1 legitimate + 27 strict leaks verified\n",
    "F346A      = 15 cases reviewed; 1 non-kill-role case; 14 no-role-evidence cases\n",
    "Multi-site = 1 ACCEPT + 14 HOLD\n",
    "NO authoritative IDs modified.\n"
)
