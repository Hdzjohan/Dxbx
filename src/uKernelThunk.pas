unit uKernelThunk;

interface

uses
  Types;

var
  KernelThunkTable : packed array[0..366] of DWord = (
    $0000,                          // $0000 (0)
    $0001,                          // $0001 (1)
    $0002,                          // $0002 (2)
    $0003,                          // $0003 (3)
    $0004,                          // $0004 (4)
    $0005,                          // $0005 (5)
    $0006,                          // $0006 (6)
    $0007,                          // $0007 (7)
    $0008,                          // $0008 (8)
    $0009,                          // $0009 (9)
    $000A,                          // $000A (10)
    $000B,                          // $000B (11)
    $000C,                          // $000C (12)
    $000D,                          // $000D (13)
    $000E,                          // $000E (14)
    $000F,                          // $000F (15)
    $0010,                          // $0010 (16)
    $0011,                          // $0011 (17)
    $0012,                          // $0012 (18)
    $0013,                          // $0013 (19)
    $0014,                          // $0014 (20)
    $0015,                          // $0015 (21)
    $0016,                          // $0016 (22)
    $0017,                          // $0017 (23)
    $0018,                          // $0018 (24)
    $0019,                          // $0019 (25)
    $001A,                          // $001A (26)
    $001B,                          // $001B (27)
    $001C,                          // $001C (28)
    $001D,                          // $001D (29)
    $001E,                          // $001E (30)
    $001F,                          // $001F (31)
    $0020,                          // $0020 (32)
    $0021,                          // $0021 (33)
    $0022,                          // $0022 (34)
    $0023,                          // $0023 (35)
    $0024,                          // $0024 (36)
    $0025,                          // $0025 (37)
    $0026,                          // $0026 (38)
    $0027,                          // $0027 (39)
    $0028,                          // $0028 (40)
    $0029,                          // $0029 (41)
    $002A,                          // $002A (42)
    $002B,                          // $002B (43)
    $002C,                          // $002C (44)
    $002D,                          // $002D (45)
    $002E,                          // $002E (46)
    $002F,                          // $002F (47)
    $0030,                          // $0030 (48)
    $0031,                          // $0031 (49)
    $0032,                          // $0032 (50)
    $0033,                          // $0033 (51)
    $0034,                          // $0034 (52)
    $0035,                          // $0035 (53)
    $0036,                          // $0036 (54)
    $0037,                          // $0037 (55)
    $0038,                          // $0038 (56)
    $0039,                          // $0039 (57)
    $003A,                          // $003A (58)
    $003B,                          // $003B (59)
    $003C,                          // $003C (60)
    $003D,                          // $003D (61)
    $003E,                          // $003E (62)
    $003F,                          // $003F (63)
    $0040,                          // $0040 (64)
    $0041,                          // $0041 (65)
    $0042,                          // $0042 (66)
    $0043,                          // $0043 (67)
    $0044,                          // $0044 (68)
    $0045,                          // $0045 (69)
    $0046,                          // $0046 (70)
    $0047,                          // $0047 (71)
    $0048,                          // $0048 (72)
    $0049,                          // $0049 (73)
    $004A,                          // $004A (74)
    $004B,                          // $004B (75)
    $004C,                          // $004C (76)
    $004D,                          // $004D (77)
    $004E,                          // $004E (78)
    $004F,                          // $004F (79)
    $0050,                          // $0050 (80)
    $0051,                          // $0051 (81)
    $0052,                          // $0052 (82)
    $0053,                          // $0053 (83)
    $0054,                          // $0054 (84)
    $0055,                          // $0055 (85)
    $0056,                          // $0056 (86)
    $0057,                          // $0057 (87)
    $0058,                          // $0058 (88)
    $0059,                          // $0059 (89)
    $005A,                          // $005A (90)
    $005B,                          // $005B (91)
    $005C,                          // $005C (92)
    $005D,                          // $005D (93)
    $005E,                          // $005E (94)
    $005F,                          // $005F (95)
    $0060,                          // $0060 (96)
    $0061,                          // $0061 (97)
    $0062,                          // $0062 (98)
    $0063,                          // $0063 (99)
    $0064,                          // $0064 (100)
    $0065,                          // $0065 (101)
    $0066,                          // $0066 (102)
    $0067,                          // $0067 (103)
    $0068,                          // $0068 (104)
    $0069,                          // $0069 (105)
    $006A,                          // $006A (106)
    $006B,                          // $006B (107)
    $006C,                          // $006C (108)
    $006D,                          // $006D (109)
    $006E,                          // $006E (110)
    $006F,                          // $006F (111)
    $0070,                          // $0070 (112)
    $0071,                          // $0071 (113)
    $0072,                          // $0072 (114)
    $0073,                          // $0073 (115)
    $0074,                          // $0074 (116)
    $0075,                          // $0075 (117)
    $0076,                          // $0076 (118)
    $0077,                          // $0077 (119)
    $0078,                          // $0078 (120)
    $0079,                          // $0079 (121)
    $007A,                          // $007A (122)
    $007B,                          // $007B (123)
    $007C,                          // $007C (124)
    $007D,                          // $007D (125)
    $007E,                          // $007E (126)
    $007F,                          // $007F (127)
    $0080,                          // $0080 (128)
    $0081,                          // $0081 (129)
    $0082,                          // $0082 (130)
    $0083,                          // $0083 (131)
    $0084,                          // $0084 (132)
    $0085,                          // $0085 (133)
    $0086,                          // $0086 (134)
    $0087,                          // $0087 (135)
    $0088,                          // $0088 (136)
    $0089,                          // $0089 (137)
    $008A,                          // $008A (138)
    $008B,                          // $008B (139)
    $008C,                          // $008C (140)
    $008D,                          // $008D (141)
    $008E,                          // $008E (142)
    $008F,                          // $008F (143)
    $0090,                          // $0090 (144)
    $0091,                          // $0091 (145)
    $0092,                          // $0092 (146)
    $0093,                          // $0093 (147)
    $0094,                          // $0094 (148)
    $0095,                          // $0095 (149)
    $0096,                          // $0096 (150)
    $0097,                          // $0097 (151)
    $0098,                          // $0098 (152)
    $0099,                          // $0099 (153)
    $009A,                          // $009A (154)
    $009B,                          // $009B (155)
    $009B,                          // $009C (156)
    $009D,                          // $009D (157)
    $009E,                          // $009E (158)
    $009F,                          // $009F (159)
    $00A0,                          // $00A0 (160)
    $00A1,                          // $00A1 (161)
    $00A2,                          // $00A2 (162)
    $00A3,                          // $00A3 (163)
    $00A4,                          // $00A4 (164)
    $00A5,                          // $00A5 (165)
    $00A6,                          // $00A6 (166)
    $00A7,                          // $00A7 (167)
    $00A8,                          // $00A8 (168)
    $00A9,                          // $00A9 (169)
    $00AA,                          // $00AA (170)
    $00AB,                          // $00AB (171)
    $00AC,                          // $00AC (172)
    $00AD,                          // $00AD (173)
    $00AE,                          // $00AE (174)
    $00AF,                          // $00AF (175)
    $00B0,                          // $00B0 (176)
    $00B1,                          // $00B1 (177)
    $00B2,                          // $00B2 (178)
    $00B3,                          // $00B3 (179)
    $00B4,                          // $00B4 (180)
    $00B5,                          // $00B5 (181)
    $00B6,                          // $00B6 (182)
    $00B7,                          // $00B7 (183)
    $00B8,                          // $00B8 (184)
    $00B9,                          // $00B9 (185)
    $00BA,                          // $00BA (186)
    $00BB,                          // $00BB (187)
    $00BC,                          // $00BC (188)
    $00BD,                          // $00BD (189)
    $00BE,                          // $00BE (190)
    $00BF,                          // $00BF (191)
    $00C0,                          // $00C0 (192)
    $00C1,                          // $00C1 (193)
    $00C2,                          // $00C2 (194)
    $00C3,                          // $00C3 (195)
    $00C4,                          // $00C4 (196)
    $00C5,                          // $00C5 (197)
    $00C6,                          // $00C6 (198)
    $00C7,                          // $00C7 (199)
    $00C8,                          // $00C8 (200)
    $00C9,                          // $00C9 (201)
    $00CA,                          // $00CA (202)
    $00CB,                          // $00CB (203)
    $00CC,                          // $00CC (204)
    $00CD,                          // $00CD (205)
    $00CE,                          // $00CE (206)
    $00CF,                          // $00CF (207)
    $00D0,                          // $00D0 (208)
    $00D1,                          // $00D1 (209)
    $00D2,                          // $00D2 (210)
    $00D3,                          // $00D3 (211)
    $00D4,                          // $00D4 (212)
    $00D5,                          // $00D5 (213)
    $00D6,                          // $00D6 (214)
    $00D7,                          // $00D7 (215)
    $00D8,                          // $00D8 (216)
    $00D9,                          // $00D9 (217)
    $00DA,                          // $00DA (218)
    $00DB,                          // $00DB (219)
    $00DC,                          // $00DC (220)
    $00DD,                          // $00DD (221)
    $00DE,                          // $00DE (222)
    $00DF,                          // $00DF (223)
    $00E0,                          // $00E0 (224)
    $00E1,                          // $00E1 (225)
    $00E2,                          // $00E2 (226)
    $00E3,                          // $00E3 (227)
    $00E4,                          // $00E4 (228)
    $00E5,                          // $00E5 (229)
    $00E6,                          // $00E6 (230)
    $00E7,                          // $00E7 (231)
    $00E8,                          // $00E8 (232)
    $00E9,                          // $00E9 (233)
    $00EA,                          // $00EA (234)
    $00EB,                          // $00EB (235)
    $00EC,                          // $00EC (236)
    $00ED,                          // $00ED (237)
    $00EE,                          // $00EE (238)
    $00EF,                          // $00EF (239)
    $00F0,                          // $00F0 (240)
    $00F1,                          // $00F1 (241)
    $00F2,                          // $00F2 (242)
    $00F3,                          // $00F3 (243)
    $00F4,                          // $00F4 (244)
    $00F5,                          // $00F5 (245)
    $00F6,                          // $00F6 (246)
    $00F7,                          // $00F7 (247)
    $00F8,                          // $00F8 (248)
    $00F9,                          // $00F9 (249)
    $00FA,                          // $00FA (250)
    $00FB,                          // $00FB (251)
    $00FC,                          // $00FC (252)
    $00FD,                          // $00FD (253)
    $00FE,                          // $00FE (254)
    $00FF,                          // $00FF (255)
    $0100,                          // $0100 (256)
    $0101,                          // $0101 (257)
    $0102,                          // $0102 (258)
    $0103,                          // $0103 (259)
    $0104,                          // $0104 (260)
    $0105,                          // $0105 (261)
    $0106,                          // $0106 (262)
    $0107,                          // $0107 (263)
    $0108,                          // $0108 (264)
    $0109,                          // $0109 (265)
    $010A,                          // $010A (266)
    $010B,                          // $010B (267)
    $010C,                          // $010C (268)
    $010D,                          // $010D (269)
    $010E,                          // $010E (270)
    $010F,                          // $010F (271)
    $0110,                          // $0110 (272)
    $0111,                          // $0111 (273)
    $0112,                          // $0112 (274)
    $0113,                          // $0113 (275)
    $0114,                          // $0114 (276)
    $0115,                          // $0115 (277)
    $0116,                          // $0116 (278)
    $0117,                          // $0117 (279)
    $0118,                          // $0118 (280)
    $0119,                          // $0119 (281)
    $011A,                          // $011A (282)
    $011B,                          // $011B (283)
    $011C,                          // $011C (284)
    $011D,                          // $011D (285)
    $011E,                          // $011E (286)
    $011F,                          // $011F (287)
    $0120,                          // $0120 (288)
    $0121,                          // $0121 (289)
    $0122,                          // $0122 (290)
    $0123,                          // $0123 (291)
    $0124,                          // $0124 (292)
    $0125,                          // $0125 (293)
    $0126,                          // $0126 (294)
    $0127,                          // $0127 (295)
    $0128,                          // $0128 (296)
    $0129,                          // $0129 (297)
    $012A,                          // $012A (298)
    $012B,                          // $012B (299)
    $012C,                          // $012C (300)
    $012D,                          // $012D (301)
    $012E,                          // $012E (302)
    $012F,                          // $012F (303)
    $0130,                          // $0130 (304)
    $0131,                          // $0131 (305)
    $0132,                          // $0132 (306)
    $0133,                          // $0133 (307)
    $0134,                          // $0134 (308)
    $0135,                          // $0135 (309)
    $0136,                          // $0136 (310)
    $0137,                          // $0137 (311)
    $0138,                          // $0138 (312)
    $0139,                          // $0139 (313)
    $013A,                          // $013A (314)
    $013B,                          // $013B (315)
    $013C,                          // $013C (316)
    $013D,                          // $013D (317)
    $013E,                          // $013E (318)
    $013F,                          // $013F (319)
    $0140,                          // $0140 (320)
    $0141,                          // $0141 (321)
    $0142,                          // $0142 (322)
    $0143,                          // $0143 (323)
    $0144,                          // $0144 (324)
    $0145,                          // $0145 (325)
    $0146,                          // $0146 (326)
    $0147,                          // $0147 (327)
    $0148,                          // $0148 (328)
    $0149,                          // $0149 (329)
    $014A,                          // $014A (330)
    $014B,                          // $014B (331)
    $014C,                          // $014C (332)
    $014D,                          // $014D (333)
    $014E,                          // $014E (334)
    $014F,                          // $014F (335)
    $0150,                          // $0150 (336)
    $0151,                          // $0151 (337)
    $0152,                          // $0152 (338)
    $0153,                          // $0153 (339)
    $0154,                          // $0154 (340)
    $0155,                          // $0155 (341)
    $0156,                          // $0156 (342)
    $0157,                          // $0157 (343)
    $0158,                          // $0158 (344)
    $0159,                          // $0159 (345)
    $015A,                          // $015A (346)
    $015B,                          // $015B (347)
    $015C,                          // $015C (348)
    $015D,                          // $015D (349)
    $015E,                          // $015E (350)
    $015F,                          // $015F (351)
    $0160,                          // $0160 (352)
    $0161,                          // $0161 (353)
    $0162,                          // $0162 (354)
    $0163,                          // $0163 (355)
    $0164,                          // $0164 (356)
    $0165,                          // $0165 (357)
    $0166,                          // $0166 (358)
    $0167,                          // $0167 (359)
    $0168,                          // $0168 (360)
    $0169,                          // $0169 (361)
    $016A,                          // $016A (362)
    $016B,                          // $016B (363)
    $016C,                          // $016C (364)
    $016D,                          // $016D (365)
    $016E                           // $016E (366)
  );

implementation

end.