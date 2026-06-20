; Copyright 2003-2026 Free Software Foundation, Inc
;
; This file is part of the GNU MP Library
;
; The GNU MP Library is free software; you can redistribute it and/or modify
; it under the terms of either:
;
;   * the GNU Lesser General Public License as published by the Free
;     Software Foundation; either version 3 of the License, or (at your
;     option) any later version
;
; or
;
;   * the GNU General Public License as published by the Free Software
;     Foundation; either version 2 of the License, or (at your option) any
;     later version
;
; or both in parallel, as here
;
; The GNU MP Library is distributed in the hope that it will be useful, but
; WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
; or FITNESS FOR A PARTICULAR PURPOSE  See the GNU General Public License
; for more details
;
; You should have received copies of the GNU General Public License and the
; GNU Lesser General Public License along with the GNU MP Library  If not,
; see https://wwwgnuorg/licenses/
;
; 's' GNU AS files converted by Ingo A Kubbilun <ingokubbilun@gmailcom>
; to armasm64 format (much lesser effort than for x86-64 - no ABI conversion
; necessary)
;
; PLEASE DO NOTE that the 'long' type is 32bit on MS Windows for 
; -------------- Aarch64/ARM64, too But: Because ARM64 has a lot of Xn
;                registers for parameter passing, we always get 'for free' 
;                the zero-extented 64bit Xn-register even if only the 
;                Wn-registers (lower 32bit) is written to
;

            AREA    |.drectve|, DRECTVE

            EXPORT  __gmpn_invert_limb

            AREA    |text|, CODE, ARM64, READONLY, ALIGN=4

            ALIGN   16


__gmpn_invert_limb
            lsr     x2, x0, #54
            adrp    x1, approx_tab
            and     x2, x2, #0x1fe
            add     x1, x1, #0x0
            ldrh    w3, [x1,x2]
            lsr     x4, x0, #24
            add     x4, x4, #1
            ubfiz   x2, x3, #11, #16
            umull   x3, w3, w3
            mul     x3, x3, x4
            sub     x2, x2, #1
            sub     x2, x2, x3, lsr #40
            lsl     x3, x2, #60
            mul     x1, x2, x2
            msub    x1, x1, x4, x3
            lsl     x2, x2, #13
            add     x1, x2, x1, lsr #47
            and     x2, x0, #1
            neg     x3, x2
            and     x3, x3, x1, lsr #1
            add     x2, x2, x0, lsr #1
            msub    x2, x1, x2, x3
            umulh   x2, x2, x1
            lsl     x1, x1, #31
            add     x1, x1, x2, lsr #1
            mul     x3, x1, x0
            umulh   x2, x1, x0
            adds    x4, x3, x0
            adc     x0, x2, x0
            sub     x0, x1, x0
            ret

            AREA  |rdata|, DATA, READONLY, ALIGN=4

            ALIGN   16

approx_tab  DCW     2045
            DCW     2037
            DCW     2029
            DCW     2021
            DCW     2013
            DCW     2005
            DCW     1998
            DCW     1990
            DCW     1983
            DCW     1975
            DCW     1968
            DCW     1960
            DCW     1953
            DCW     1946
            DCW     1938
            DCW     1931
            DCW     1924
            DCW     1917
            DCW     1910
            DCW     1903
            DCW     1896
            DCW     1889
            DCW     1883
            DCW     1876
            DCW     1869
            DCW     1863
            DCW     1856
            DCW     1849
            DCW     1843
            DCW     1836
            DCW     1830
            DCW     1824
            DCW     1817
            DCW     1811
            DCW     1805
            DCW     1799
            DCW     1792
            DCW     1786
            DCW     1780
            DCW     1774
            DCW     1768
            DCW     1762
            DCW     1756
            DCW     1750
            DCW     1745
            DCW     1739
            DCW     1733
            DCW     1727
            DCW     1722
            DCW     1716
            DCW     1710
            DCW     1705
            DCW     1699
            DCW     1694
            DCW     1688
            DCW     1683
            DCW     1677
            DCW     1672
            DCW     1667
            DCW     1661
            DCW     1656
            DCW     1651
            DCW     1646
            DCW     1641
            DCW     1636
            DCW     1630
            DCW     1625
            DCW     1620
            DCW     1615
            DCW     1610
            DCW     1605
            DCW     1600
            DCW     1596
            DCW     1591
            DCW     1586
            DCW     1581
            DCW     1576
            DCW     1572
            DCW     1567
            DCW     1562
            DCW     1558
            DCW     1553
            DCW     1548
            DCW     1544
            DCW     1539
            DCW     1535
            DCW     1530
            DCW     1526
            DCW     1521
            DCW     1517
            DCW     1513
            DCW     1508
            DCW     1504
            DCW     1500
            DCW     1495
            DCW     1491
            DCW     1487
            DCW     1483
            DCW     1478
            DCW     1474
            DCW     1470
            DCW     1466
            DCW     1462
            DCW     1458
            DCW     1454
            DCW     1450
            DCW     1446
            DCW     1442
            DCW     1438
            DCW     1434
            DCW     1430
            DCW     1426
            DCW     1422
            DCW     1418
            DCW     1414
            DCW     1411
            DCW     1407
            DCW     1403
            DCW     1399
            DCW     1396
            DCW     1392
            DCW     1388
            DCW     1384
            DCW     1381
            DCW     1377
            DCW     1374
            DCW     1370
            DCW     1366
            DCW     1363
            DCW     1359
            DCW     1356
            DCW     1352
            DCW     1349
            DCW     1345
            DCW     1342
            DCW     1338
            DCW     1335
            DCW     1332
            DCW     1328
            DCW     1325
            DCW     1322
            DCW     1318
            DCW     1315
            DCW     1312
            DCW     1308
            DCW     1305
            DCW     1302
            DCW     1299
            DCW     1295
            DCW     1292
            DCW     1289
            DCW     1286
            DCW     1283
            DCW     1280
            DCW     1276
            DCW     1273
            DCW     1270
            DCW     1267
            DCW     1264
            DCW     1261
            DCW     1258
            DCW     1255
            DCW     1252
            DCW     1249
            DCW     1246
            DCW     1243
            DCW     1240
            DCW     1237
            DCW     1234
            DCW     1231
            DCW     1228
            DCW     1226
            DCW     1223
            DCW     1220
            DCW     1217
            DCW     1214
            DCW     1211
            DCW     1209
            DCW     1206
            DCW     1203
            DCW     1200
            DCW     1197
            DCW     1195
            DCW     1192
            DCW     1189
            DCW     1187
            DCW     1184
            DCW     1181
            DCW     1179
            DCW     1176
            DCW     1173
            DCW     1171
            DCW     1168
            DCW     1165
            DCW     1163
            DCW     1160
            DCW     1158
            DCW     1155
            DCW     1153
            DCW     1150
            DCW     1148
            DCW     1145
            DCW     1143
            DCW     1140
            DCW     1138
            DCW     1135
            DCW     1133
            DCW     1130
            DCW     1128
            DCW     1125
            DCW     1123
            DCW     1121
            DCW     1118
            DCW     1116
            DCW     1113
            DCW     1111
            DCW     1109
            DCW     1106
            DCW     1104
            DCW     1102
            DCW     1099
            DCW     1097
            DCW     1095
            DCW     1092
            DCW     1090
            DCW     1088
            DCW     1086
            DCW     1083
            DCW     1081
            DCW     1079
            DCW     1077
            DCW     1074
            DCW     1072
            DCW     1070
            DCW     1068
            DCW     1066
            DCW     1064
            DCW     1061
            DCW     1059
            DCW     1057
            DCW     1055
            DCW     1053
            DCW     1051
            DCW     1049
            DCW     1047
            DCW     1044
            DCW     1042
            DCW     1040
            DCW     1038
            DCW     1036
            DCW     1034
            DCW     1032
            DCW     1030
            DCW     1028
            DCW     1026
            DCW     1024

            END
