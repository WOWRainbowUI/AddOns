local _,db = ...
local function tn(arg) return arg and 1 or 0 end
local userFrames = {}
local lastUserFrameSelected = nil
local colors = {
	none = {1,1,1,0},
  white = {1,1,1,1},
  gold = {1,0.7529,0,1},
	green = {ITEM_QUALITY_COLORS[2].color:GetRGBA()}
}
local ci = {
  4638724,1508519,4696085,
  135453,132858,133784,
  135441,135263,2065578,
  236570,4638431,4549242,
  4549287,4615906,4549111,
  4632799,463487,236697,
  4554372,4555553,4555554,
  4555555,4555556,4555557,
  4559245,1387373,3586015,
  3586022,133786,133788,
  134388,1693994,463562,
  876371,3386337,1686583,
  1064188,4559256,3015740,
  458224
}
local scroll = 0
--215745,"Kun-Lai Summit, Isle of Giants, Isle of Thunder, Timeless Isle"
--216450,"NOTHING",
--216452,"NOTHING",
--216454,"NOTHING",
--216457,"NOTHING",
--216456,"NOTHING",
--216455,"NOTHING",
--215903,"NOTHING",
local src = {
  JADE = "翡玉林",
  VALLEY = "四風峽",
  VALE = "恆春谷",
  KUNLAI = "崑崙峰",
  TOWNLONG = "螳螂荒原",
  KRASARANG = "喀薩朗蠻荒",
  DREAD = "悚然荒野",
  THUNDER = "雷神島",
  GIANTS = "巨獸島",
  TIMELESS = "永恆之島",
  SCENARIOS_N = "事件 (普通)",
  SCENARIOS_NH = "事件 (普通/英雄)",
  SCENARIOS_H = "事件 (英雄)",
  DUNGEONS_N = "地城 (普通)",
  DUNGEONS_H = "地城 (英雄)",
  SIEGE_LFR = "圍攻奧格瑪 (團隊搜尋器)",
  SIEGE_N = "圍攻奧格瑪 (普通)",
  SIEGE_H = "圍攻奧格瑪 (英雄)",
  SIEGE_M = "圍攻奧格瑪 (史詩)",
  THRONE_LFR = "雷霆王座 (團隊搜尋器)",
  THRONE_N = "雷霆王座 (普通)",
  THRONE_H = "雷霆王座 (英雄)",
  T14_LFR = "T14套裝團隊副本 (團隊搜尋器)",
  T14_N = "T14套裝團隊副本 (普通)",
  T14_H = "T14套裝團隊副本 (英雄)",
  PYTHAGORUS = "畢達哥拉斯",
  DURUS = "杜魯斯",
  AEONICUS = "埃歐尼克斯",
  ARTUROS = "亞特魯斯",
  LARAH = "拉拉·樹彎者",
  JAKKUS = "宗師賈克斯",
  HEMET = "赫米特·奈辛瓦里十七世",
  HOROS = "霍魯斯",
  ERUS = "艾魯斯",
  AMUUL = "追憶者阿穆爾",
  BONUS = "獎勵目標 (等級 < 70)"
}
local function srcs(...) return table.concat({...},", ") end
local data = {
  216558,src.SIEGE_M,
  215527,src.SIEGE_M,
  215472,src.SIEGE_M,
  215476,src.SIEGE_M,
  215580,src.SIEGE_M,
  215718,src.SIEGE_M,
  215670,src.SIEGE_M,
  215830,src.SIEGE_M,
  215826,src.SIEGE_M,
  215920,src.SIEGE_M,
  215912,src.SIEGE_M,
  215480,src.SIEGE_M,
  215996,src.SIEGE_M,
  215522,src.SIEGE_H,
  215691,src.SIEGE_H,
  215915,src.SIEGE_H,
  215995,src.SIEGE_H,
  215994,src.SIEGE_N,
  215554,src.SIEGE_N,
  215629,src.SIEGE_N,
  215712,src.SIEGE_N,
  215922,src.SIEGE_N,
  215836,src.SIEGE_N,
  215818,src.SIEGE_N,
  215501,src.SIEGE_LFR,
  215572,src.SIEGE_LFR,
  215663,src.SIEGE_LFR,
  215971,src.SIEGE_LFR,
  215835,src.SIEGE_LFR,
  215831,src.SIEGE_LFR,
  210643,src.SIEGE_LFR,

  215710,src.THRONE_H,
  216402,src.THRONE_H,
  215898,src.THRONE_H,
  216468,src.THRONE_H,
  216432,src.THRONE_H,
  216436,src.THRONE_H,
  215789,src.THRONE_H,
  215497,src.THRONE_H,
  215624,src.THRONE_H,
  216585,src.THRONE_H,
  215653,src.THRONE_N,
  215547,src.THRONE_N,
  215562,src.THRONE_N,
  215626,src.THRONE_N,
  216596,src.THRONE_N,
  215499,src.THRONE_N,
  216015,src.THRONE_N,
  216413,src.THRONE_N,
  216405,src.THRONE_N,
  215767,src.THRONE_N,
  215770,src.THRONE_N,
  215688,src.THRONE_N,
  215887,src.THRONE_N,
  216459,src.THRONE_N,
  216464,src.THRONE_N,
  216435,src.THRONE_N,
  215788,src.THRONE_N,
  215966,src.THRONE_N,
  216447,src.THRONE_N,
  216011,src.THRONE_N,
  215774,src.THRONE_N,
  215625,src.THRONE_LFR,
  215517,src.THRONE_LFR,
  215542,src.THRONE_LFR,
  215627,src.THRONE_LFR,
  216425,src.THRONE_LFR,
  215766,src.THRONE_LFR,
  216437,src.THRONE_LFR,
  215814,src.THRONE_LFR,
  215768,src.THRONE_LFR,
  215964,src.THRONE_LFR,
  216434,src.THRONE_LFR,
  216412,src.THRONE_LFR,
  215787,src.THRONE_LFR,
  215500,src.THRONE_LFR,
  215965,src.THRONE_LFR,
  216446,src.THRONE_LFR,
  216449,src.THRONE_LFR,

  215695,src.T14_H,
  215530,src.T14_H,
  215557,src.T14_H,
  215589,src.T14_H,
  215841,src.T14_H,
  215849,src.T14_H,
  215845,src.T14_H,
  215933,src.T14_H,
  215800,src.T14_H,
  215977,src.T14_H,
  215999,src.T14_H,
  215848,src.T14_N,
  215844,src.T14_N,
  215976,src.T14_N,
  215791,src.T14_N,
  215840,src.T14_N,
  215506,src.T14_N,
  215556,src.T14_N,
  215998,src.T14_N,
  215588,src.T14_LFR,
  215584,src.T14_LFR,
  215798,src.T14_LFR,
  216566,src.T14_LFR,
  215636,src.T14_LFR,
  215857,src.T14_LFR,
  215975,src.T14_LFR,
  216562,src.T14_LFR,
  216000,src.T14_LFR,
  215839,src.T14_LFR,
  215842,src.T14_LFR,
  215843,src.T14_LFR,
  215850,src.T14_LFR,
  215730,src.T14_LFR,
  215847,src.T14_LFR,

  215684,src.DUNGEONS_H,
  215646,src.DUNGEONS_H,
  215878,src.DUNGEONS_H,
  215983,src.DUNGEONS_H,
  216006,src.DUNGEONS_H,
  215612,src.DUNGEONS_N,
  215604,src.DUNGEONS_N,
  215609,src.DUNGEONS_N,
  215682,src.DUNGEONS_N,
  215874,src.DUNGEONS_N,
  215645,src.DUNGEONS_N,
  216581,src.DUNGEONS_N,
  215783,src.DUNGEONS_N,

  215615,src.SCENARIOS_H,
  215611,src.SCENARIOS_H,
  215757,src.SCENARIOS_H,
  215809,src.SCENARIOS_H,
  215986,src.SCENARIOS_H,
  216008,src.SCENARIOS_H,
  215648,src.SCENARIOS_H,
  215607,src.SCENARIOS_NH,
  215537,src.SCENARIOS_N,
  215614,src.SCENARIOS_N,
  215610,src.SCENARIOS_N,
  215808,src.SCENARIOS_N,
  216583,src.SCENARIOS_N,
  216007,src.SCENARIOS_N,
  215706,src.SCENARIOS_N,

  216540,srcs(src.THUNDER,src.GIANTS,src.TIMELESS),
  215761,srcs(src.THUNDER,src.GIANTS,src.TIMELESS),
  216601,srcs(src.THUNDER,src.GIANTS,src.TIMELESS),
  216530,srcs(src.THUNDER,src.GIANTS,src.TIMELESS),
  215897,srcs(src.THUNDER,src.GIANTS,src.TIMELESS),
  215960,srcs(src.THUNDER,src.GIANTS,src.TIMELESS),
  215515,srcs(src.THUNDER,src.GIANTS,src.TIMELESS),
  215550,srcs(src.THUNDER,src.GIANTS,src.TIMELESS),
  215623,srcs(src.THUNDER,src.GIANTS,src.TIMELESS),
  215619,srcs(src.THUNDER,src.GIANTS,src.TIMELESS),
  215893,srcs(src.THUNDER,src.GIANTS,src.TIMELESS),
  215776,srcs(src.THUNDER,src.GIANTS,src.TIMELESS),
  216535,srcs(src.THUNDER,src.GIANTS,src.TIMELESS),
  215908,srcs(src.THUNDER,src.GIANTS,src.TIMELESS),
  216600,srcs(src.THUNDER,src.TIMELESS),
  215970,srcs(src.THUNDER,src.TIMELESS),
  215496,src.DREAD,
  215513,src.DREAD,
  215541,src.DREAD,
  215622,src.DREAD,
  215617,src.DREAD,
  215649,src.DREAD,
  215762,src.DREAD,
  215759,src.DREAD,
  216536,src.DREAD,
  216538,src.DREAD,
  215895,src.DREAD,
  215958,src.DREAD,
  215988,src.DREAD,
  216439,src.KRASARANG,
  216541,src.KRASARANG,
  215495,src.TOWNLONG,
  215512,src.TOWNLONG,
  215540,src.TOWNLONG,
  215621,src.TOWNLONG,
  215616,src.TOWNLONG,
  215650,src.TOWNLONG,
  215763,src.TOWNLONG,
  215758,src.TOWNLONG,
  215657,src.TOWNLONG,
  216537,src.TOWNLONG,
  215894,src.TOWNLONG,
  215957,src.TOWNLONG,
  215987,src.TOWNLONG,
  216534,src.TOWNLONG,
  215890,src.TOWNLONG,
  215644,srcs(src.KUNLAI,src.THUNDER,src.GIANTS,src.TIMELESS),
  215703,srcs(src.KUNLAI,src.THUNDER,src.GIANTS,src.TIMELESS),
  215678,srcs(src.KUNLAI,src.THUNDER,src.TIMELESS),
  216482,src.KUNLAI,
  216473,src.KUNLAI,
  216440,src.KUNLAI,
  216445,src.KUNLAI,
  216021,src.KUNLAI,
  216022,src.KUNLAI,
  216614,src.KUNLAI,
  216421,src.KUNLAI,
  215872,srcs(src.VALE,src.KRASARANG),
  215865,srcs(src.VALE,src.KRASARANG),
  215602,srcs(src.VALE,src.KRASARANG),
  215680,srcs(src.VALE,src.KRASARANG),
  216533,src.VALE,
  215494,src.VALE,
  215514,src.VALE,
  215539,src.VALE,
  215620,src.VALE,
  215618,src.VALE,
  215651,src.VALE,
  215764,src.VALE,
  216539,src.VALE,
  215896,src.VALE,
  215959,src.VALE,
  215989,src.VALE,
  215760,src.VALE,
  215892,src.VALE,
  216002,srcs(src.VALLEY,src.DREAD),
  216480,src.VALLEY,
  216476,src.VALLEY,
  216025,src.VALLEY,
  216443,src.VALLEY,
  216001,srcs(src.JADE,src.TOWNLONG),
  215871,srcs(src.JADE,src.TOWNLONG),
  215738,srcs(src.JADE,src.TOWNLONG),
  215679,srcs(src.JADE,src.TOWNLONG),
  215658,srcs(src.JADE,src.VALE),
  216024,src.JADE,
  216423,src.JADE,
  216542,src.JADE,
  216475,src.JADE,
  216438,src.JADE,
  216442,src.JADE,
  216611,src.JADE
}
local data2 = {
  215345,{src.PYTHAGORUS,"5,000",ci[1]},
  215336,{src.PYTHAGORUS,"5,000",ci[1]},
  215328,{src.PYTHAGORUS,"5,000",ci[1]},
  215305,{src.PYTHAGORUS,"5,000",ci[1]},
  215296,{src.PYTHAGORUS,"5,000",ci[1]},
  215268,{src.PYTHAGORUS,"5,000",ci[1]},
  215259,{src.PYTHAGORUS,"5,000",ci[1]},
  215248,{src.PYTHAGORUS,"5,000",ci[1]},
  215213,{src.PYTHAGORUS,"5,000",ci[1]},
  215205,{src.PYTHAGORUS,"5,000",ci[1]},
  215195,{src.PYTHAGORUS,"5,000",ci[1]},
  215342,{src.PYTHAGORUS,"5,000",ci[1]},
  215340,{src.PYTHAGORUS,"5,000",ci[1]},
  215333,{src.PYTHAGORUS,"5,000",ci[1]},
  215331,{src.PYTHAGORUS,"5,000",ci[1]},
  215323,{src.PYTHAGORUS,"5,000",ci[1]},
  215322,{src.PYTHAGORUS,"5,000",ci[1]},
  215301,{src.PYTHAGORUS,"5,000",ci[1]},
  215299,{src.PYTHAGORUS,"5,000",ci[1]},
  215291,{src.PYTHAGORUS,"5,000",ci[1]},
  215290,{src.PYTHAGORUS,"5,000",ci[1]},
  215265,{src.PYTHAGORUS,"5,000",ci[1]},
  215262,{src.PYTHAGORUS,"5,000",ci[1]},
  215254,{src.PYTHAGORUS,"5,000",ci[1]},
  215250,{src.PYTHAGORUS,"5,000",ci[1]},
  215244,{src.PYTHAGORUS,"5,000",ci[1]},
  215242,{src.PYTHAGORUS,"5,000",ci[1]},
  215211,{src.PYTHAGORUS,"5,000",ci[1]},
  215207,{src.PYTHAGORUS,"5,000",ci[1]},
  215203,{src.PYTHAGORUS,"5,000",ci[1]},
  215200,{src.PYTHAGORUS,"5,000",ci[1]},
  215192,{src.PYTHAGORUS,"5,000",ci[1]},
  215190,{src.PYTHAGORUS,"5,000",ci[1]},

  215347,{src.DURUS,"5,000",ci[1]},
  215344,{src.DURUS,"5,000",ci[1]},
  215338,{src.DURUS,"5,000",ci[1]},
  215341,{src.DURUS,"5,000",ci[1]},
  215337,{src.DURUS,"5,000",ci[1]},
  215332,{src.DURUS,"5,000",ci[1]},
  215329,{src.DURUS,"5,000",ci[1]},
  215326,{src.DURUS,"5,000",ci[1]},
  215325,{src.DURUS,"5,000",ci[1]},
  215321,{src.DURUS,"5,000",ci[1]},
  215303,{src.DURUS,"5,000",ci[1]},
  215300,{src.DURUS,"5,000",ci[1]},
  215297,{src.DURUS,"5,000",ci[1]},
  215294,{src.DURUS,"5,000",ci[1]},
  215292,{src.DURUS,"5,000",ci[1]},
  215288,{src.DURUS,"5,000",ci[1]},
  215266,{src.DURUS,"5,000",ci[1]},
  215263,{src.DURUS,"5,000",ci[1]},
  215260,{src.DURUS,"5,000",ci[1]},
  215258,{src.DURUS,"5,000",ci[1]},
  215253,{src.DURUS,"5,000",ci[1]},
  215251,{src.DURUS,"5,000",ci[1]},
  215249,{src.DURUS,"5,000",ci[1]},
  215246,{src.DURUS,"5,000",ci[1]},
  215243,{src.DURUS,"5,000",ci[1]},
  215215,{src.DURUS,"5,000",ci[1]},
  215212,{src.DURUS,"5,000",ci[1]},
  215209,{src.DURUS,"5,000",ci[1]},
  215206,{src.DURUS,"5,000",ci[1]},
  215202,{src.DURUS,"5,000",ci[1]},
  215198,{src.DURUS,"5,000",ci[1]},
  215197,{src.DURUS,"5,000",ci[1]},
  215194,{src.DURUS,"5,000",ci[1]},
  215191,{src.DURUS,"5,000",ci[1]},

  215346,{src.AEONICUS,"5,000",ci[1]},
  215343,{src.AEONICUS,"5,000",ci[1]},
  215339,{src.AEONICUS,"5,000",ci[1]},
  215335,{src.AEONICUS,"5,000",ci[1]},
  215334,{src.AEONICUS,"5,000",ci[1]},
  215330,{src.AEONICUS,"5,000",ci[1]},
  215327,{src.AEONICUS,"5,000",ci[1]},
  215324,{src.AEONICUS,"5,000",ci[1]},
  215320,{src.AEONICUS,"5,000",ci[1]},
  215304,{src.AEONICUS,"5,000",ci[1]},
  215302,{src.AEONICUS,"5,000",ci[1]},
  215298,{src.AEONICUS,"5,000",ci[1]},
  215295,{src.AEONICUS,"5,000",ci[1]},
  215293,{src.AEONICUS,"5,000",ci[1]},
  215289,{src.AEONICUS,"5,000",ci[1]},
  215267,{src.AEONICUS,"5,000",ci[1]},
  215264,{src.AEONICUS,"5,000",ci[1]},
  215261,{src.AEONICUS,"5,000",ci[1]},
  215255,{src.AEONICUS,"5,000",ci[1]},
  215256,{src.AEONICUS,"5,000",ci[1]},
  215252,{src.AEONICUS,"5,000",ci[1]},
  215247,{src.AEONICUS,"5,000",ci[1]},
  215245,{src.AEONICUS,"5,000",ci[1]},
  215241,{src.AEONICUS,"5,000",ci[1]},
  215214,{src.AEONICUS,"5,000",ci[1]},
  215210,{src.AEONICUS,"5,000",ci[1]},
  215208,{src.AEONICUS,"5,000",ci[1]},
  215204,{src.AEONICUS,"5,000",ci[1]},
  215201,{src.AEONICUS,"5,000",ci[1]},
  215199,{src.AEONICUS,"5,000",ci[1]},
  215196,{src.AEONICUS,"5,000",ci[1]},
  215193,{src.AEONICUS,"5,000",ci[1]},
  215189,{src.AEONICUS,"5,000",ci[1]},

  215312,{src.ARTUROS,"2,500",ci[1]},
  215311,{src.ARTUROS,"2,500",ci[1]},
  215310,{src.ARTUROS,"2,500",ci[1]},
  215274,{src.ARTUROS,"2,500",ci[1]},
  215273,{src.ARTUROS,"2,500",ci[1]},
  215272,{src.ARTUROS,"2,500",ci[1]},
  215224,{src.ARTUROS,"2,500",ci[1]},
  215223,{src.ARTUROS,"2,500",ci[1]},
  215222,{src.ARTUROS,"2,500",ci[1]},
  215221,{src.ARTUROS,"2,500",ci[1]},
  215182,{src.ARTUROS,"2,500",ci[1]},
  215181,{src.ARTUROS,"2,500",ci[1]},
  215176,{src.ARTUROS,"2,500",ci[1]},

  215351,{src.LARAH,"2,000",ci[1]},
  215350,{src.LARAH,"2,000",ci[1]},
  215349,{src.LARAH,"2,000",ci[1]},
  215348,{src.LARAH,"2,000",ci[1]},
  215309,{src.LARAH,"2,000",ci[1]},
  215308,{src.LARAH,"2,000",ci[1]},
  215307,{src.LARAH,"2,000",ci[1]},
  215306,{src.LARAH,"2,000",ci[1]},
  215271,{src.LARAH,"2,000",ci[1]},
  215270,{src.LARAH,"2,000",ci[1]},
  215269,{src.LARAH,"2,000",ci[1]},
  215218,{src.LARAH,"2,000",ci[1]},
  215217,{src.LARAH,"2,000",ci[1]},
  215216,{src.LARAH,"2,000",ci[1]},
  215319,{src.LARAH,"750",ci[1]},
  215318,{src.LARAH,"750",ci[1]},
  215317,{src.LARAH,"750",ci[1]},
  215316,{src.LARAH,"750",ci[1]},
  215284,{src.LARAH,"750",ci[1]},
  215283,{src.LARAH,"750",ci[1]},
  215282,{src.LARAH,"750",ci[1]},
  215232,{src.LARAH,"750",ci[1]},
  215231,{src.LARAH,"750",ci[1]},
  215230,{src.LARAH,"750",ci[1]},
  215229,{src.LARAH,"750",ci[1]},
  215188,{src.LARAH,"750",ci[1]},
  215187,{src.LARAH,"750",ci[1]},
  215186,{src.LARAH,"750",ci[1]},
  215315,{src.LARAH,"750",ci[1]},
  215314,{src.LARAH,"750",ci[1]},
  215313,{src.LARAH,"750",ci[1]},
  215281,{src.LARAH,"750",ci[1]},
  215280,{src.LARAH,"750",ci[1]},
  215279,{src.LARAH,"750",ci[1]},
  215278,{src.LARAH,"750",ci[1]},
  215228,{src.LARAH,"750",ci[1]},
  215227,{src.LARAH,"750",ci[1]},
  215226,{src.LARAH,"750",ci[1]},
  215225,{src.LARAH,"750",ci[1]},
  215185,{src.LARAH,"750",ci[1]},
  215184,{src.LARAH,"750",ci[1]},
  215183,{src.LARAH,"750",ci[1]},
  215358,{src.LARAH,"1,250",ci[1]},
  215357,{src.LARAH,"1,250",ci[1]},
  215356,{src.LARAH,"1,250",ci[1]},
  215287,{src.LARAH,"1,250",ci[1]},
  215286,{src.LARAH,"1,250",ci[1]},
  215285,{src.LARAH,"1,250",ci[1]},
  215240,{src.LARAH,"1,250",ci[1]},
  215239,{src.LARAH,"1,250",ci[1]},
  215238,{src.LARAH,"1,250",ci[1]},
  215355,{src.LARAH,"1,250",ci[1]},
  215354,{src.LARAH,"1,250",ci[1]},
  215353,{src.LARAH,"1,250",ci[1]},
  215352,{src.LARAH,"1,250",ci[1]},
  215277,{src.LARAH,"2,500",ci[1]},
  215276,{src.LARAH,"2,500",ci[1]},
  215275,{src.LARAH,"2,500",ci[1]},
  215220,{src.LARAH,"2,500",ci[1]},
  215219,{src.LARAH,"2,500",ci[1]},

  217838,{src.JAKKUS,"4,000",ci[1]},
  217839,{src.JAKKUS,"4,000",ci[1]},
  217833,{src.JAKKUS,"4,000",ci[1]},
  217844,{src.JAKKUS,"4,000",ci[1]},
  217845,{src.JAKKUS,"4,000",ci[1]},
  217846,{src.JAKKUS,"4,000",ci[1]},
  217841,{src.JAKKUS,"4,000",ci[1]},
  217836,{src.JAKKUS,"4,000",ci[1]},
  217834,{src.JAKKUS,"4,000",ci[1]},
  217835,{src.JAKKUS,"4,000",ci[1]},
  217842,{src.JAKKUS,"4,000",ci[1]},
  217843,{src.JAKKUS,"4,000",ci[1]},
  217837,{src.JAKKUS,"4,000",ci[1]},
  217825,{src.JAKKUS,"3,000",ci[1]},
  217826,{src.JAKKUS,"3,000",ci[1]},
  217819,{src.JAKKUS,"3,000",ci[1]},
  217830,{src.JAKKUS,"3,000",ci[1]},
  217831,{src.JAKKUS,"3,000",ci[1]},
  217832,{src.JAKKUS,"3,000",ci[1]},
  217827,{src.JAKKUS,"3,000",ci[1]},
  217823,{src.JAKKUS,"3,000",ci[1]},
  217820,{src.JAKKUS,"3,000",ci[1]},
  217821,{src.JAKKUS,"3,000",ci[1]},
  217829,{src.JAKKUS,"3,000",ci[1]},
  217828,{src.JAKKUS,"3,000",ci[1]},
  217824,{src.JAKKUS,"3,000",ci[1]}
}
local data3 = {
  104253,{src.HEMET,"38,500",ci[1]},
  224374,{src.HEMET,"38,500",ci[1]},
  95057,{src.HEMET,"38,500",ci[1]},
  87771,{src.HEMET,"38,500",ci[1]},
  104269,{src.HEMET,"38,500",ci[1]},
  87777,{src.HEMET,"18,700",ci[1]},
  95059,{src.HEMET,"38,500",ci[1]},
  93666,{src.HEMET,"38,500",ci[1]},
  89783,{src.HEMET,"38,500",ci[1]},
  94228,{src.HEMET,"38,500",ci[1]},
  94229,{src.HEMET,"18,700",ci[1]},
  94231,{src.HEMET,"18,700",ci[1]},
  94230,{src.HEMET,"18,700",ci[1]},
  213596,{src.HEMET,"6,600",ci[1]},
  213597,{src.HEMET,"6,600",ci[1]},
  213598,{src.HEMET,"6,600",ci[1]},
  213601,{src.HEMET,"6,600",ci[1]},
  213600,{src.HEMET,"6,600",ci[1]},
  218111,{src.HEMET,"4,400",ci[1]},
  213621,{src.HEMET,"4,400",ci[1]},
  213622,{src.HEMET,"4,400",ci[1]},
  213623,{src.HEMET,"4,400",ci[1]},
  213625,{src.HEMET,"4,400",ci[1]},
  213624,{src.HEMET,"4,400",ci[1]},
  213626,{src.HEMET,"4,400",ci[1]},
  84753,{src.HEMET,"2,200",ci[1]},
  87787,{src.HEMET,"2,200",ci[1]},
  87786,{src.HEMET,"2,200",ci[1]},
  213627,{src.HEMET,"2,200",ci[1]},
  213628,{src.HEMET,"2,200",ci[1]},
  213609,{src.HEMET,"2,200",ci[1]},
  213608,{src.HEMET,"2,200",ci[1]},
  213604,{src.HEMET,"2,200",ci[1]},
  213607,{src.HEMET,"2,200",ci[1]},
  213606,{src.HEMET,"2,200",ci[1]},
  213605,{src.HEMET,"2,200",ci[1]},
  213603,{src.HEMET,"2,200",ci[1]},
  213602,{src.HEMET,"2,200",ci[1]},
  87784,{src.HEMET,"2,200",ci[1]},
  213595,{src.HEMET,"2,200",ci[1]},
  213584,{src.HEMET,"2,200",ci[1]},
  213576,{src.HEMET,"2,200",ci[1]},
  213582,{src.HEMET,"2,200",ci[1]}
}
local data4 = {
  104309,{src.HOROS,"50,000",ci[1]},
  98136,{src.HOROS,"50,000",ci[1]},
  104331,{src.HOROS,"38,500",ci[1]},
  104302,{src.HOROS,"38,500",ci[1]},
  86588,{src.HOROS,"7,700",ci[1]},
  86568,{src.HOROS,"7,700",ci[1]},
  86582,{src.HOROS,"7,700",ci[1]},
  86573,{src.HOROS,"4,950",ci[1]},
  86583,{src.HOROS,"4,950",ci[1]},
  86586,{src.HOROS,"4,950",ci[1]},
  86593,{src.HOROS,"4,950",ci[1]},
  86581,{src.HOROS,"4,950",ci[1]},
  86578,{src.HOROS,"4,950",ci[1]},
  86589,{src.HOROS,"4,950",ci[1]},
  86571,{src.HOROS,"3,850",ci[1]},
  86594,{src.HOROS,"3,850",ci[1]},
  86590,{src.HOROS,"3,850",ci[1]},
  86575,{src.HOROS,"3,850",ci[1]},
  134023,{src.HOROS,"3,850",ci[1]},
  86565,{src.HOROS,"3,850",ci[1]},
  104262,{src.HOROS,"2,200",ci[1]},
  89205,{src.HOROS,"500",ci[1]}
}
local data5 = {
  89196,{src.HOROS,"500",ci[1]},
  226127,{src.LARAH,"5",ci[1]},
  224459,{src.PYTHAGORUS,"38,500",ci[1],"20",ci[2]},
  104404,{src.PYTHAGORUS,"8,000",ci[1],"2",ci[2]},
  104402,{src.PYTHAGORUS,"8,000",ci[1],"2",ci[2]},
  104401,{src.PYTHAGORUS,"8,000",ci[1],"2",ci[2]},
  104400,{src.PYTHAGORUS,"8,000",ci[1],"2",ci[2]},
  104409,{src.PYTHAGORUS,"8,000",ci[1],"2",ci[2]},
  104407,{src.PYTHAGORUS,"8,000",ci[1],"2",ci[2]},
  104399,{src.PYTHAGORUS,"8,000",ci[1],"2",ci[2]},
  104408,{src.PYTHAGORUS,"8,000",ci[1],"2",ci[2]},
  104406,{src.PYTHAGORUS,"8,000",ci[1],"2",ci[2]},
  104405,{src.PYTHAGORUS,"8,000",ci[1],"2",ci[2]},
  104403,{src.PYTHAGORUS,"8,000",ci[1],"2",ci[2]},
  224081,{src.ERUS,"20",ci[1]},
  224078,{src.ERUS,"20",ci[1]},
  224077,{src.ERUS,"20",ci[1]},
  224076,{src.ERUS,"20",ci[1]},
  224075,{src.ERUS,"20",ci[1]},
  224080,{src.ERUS,"20",ci[1]},
  224079,{src.ERUS,"20",ci[1]}
}

local data6 = {
  212525,"?", --ok
  170197,"Keg Leg's Crew (Renown 16)", --ok
  200116,"Siege on Dragonbane Keep", --ok
  208704,"Promotion", --ok
  208883,"Promotion", --ok
  210467,"In-Game Shop", --ok
  218128,"WoW Esports: Dragonflight Season 4", --ok (event)
  211424,"WoW Esports: Dragonflight Season 3", --ok (event)
  208057,"WoW Esports: Dragonflight Season 2", --ok (event)
  203716,"WoW Esports: Dragonflight Season 1", --ok (event)
  210042,"BlizzCon 2023", --ok (event)
  192443,"Engineering", --ok
  192495,"Engineering", --ok
  198156,"Engineering", --ok
  198173,"Engineering", --ok
  198206,"Engineering", --ok
  198227,"Engineering", --ok
  198264,"Engineering", --ok
  199554,"Engineering", --ok
  201930,"Engineering", --ok
  202309,"Engineering", --ok
  202360,"Engineering", --ok
  204818,"Engineering", --ok
  207092,"Engineering", --ok
  193032,"Jewelcrafting", --ok
  193033,"Jewelcrafting", --ok
  205045,"Jewelcrafting", --ok
  193476,"Leatherworking", --ok
  193478,"Leatherworking", --ok
  197719,"Leatherworking", --ok
  194052,"Tailoring", --ok
  194056,"Tailoring", --ok
  194057,"Tailoring", --ok
  194058,"Tailoring", --ok
  194059,"Tailoring", --ok
  194060,"Tailoring", --ok
  200469,"Enchanting", --ok
  200636,"Primal Invocation Extract", --ok (right-click to use)
  201931,"Rumble Prize Box", --ok (right-click to use)
  202261,"Rumble Prize Box", --ok (right-click to use)
  202851,"Rumble Prize Box", --ok (right-click to use)
  202856,"Rumble Prize Box", --ok (right-click to use)
  202859,"Rumble Prize Box", --ok (right-click to use)
  202862,"Rumble Prize Box", --ok (right-click to use)
  202865,"Rumble Prize Box", --ok (right-click to use)
  201815,"Twilight Cache, Twilight Strongbox", --ok (right-click to open)
  202042,"Immaculate Sac of Swog Treasures", --ok (right-click to open)
  208825,"Winter Veil Gift", --ok (right-click to open)
  209859,"Stolen Present", --ok (right-click to open)
  210656,"Gently Shaken Gift", --ok (right-click to open)
  200869,"Centaur Horn", --ok (treasure)
  201927,"Forgotten Jewel Box", --ok (treasure)
  201933,"Lost Obsidian Cache", --ok (treasure)
  202019,"Golden Dragon Goblet", --ok (treasure)
  202022,"Yennu's Kite", --ok (treasure)
  202711,"Lost Compass", --ok (treasure)
  203757,"Brazier of Madness", --ok (treasure)
  203852,"Spore-bound Essence", --ok (treasure)
  204256,"Opera Chest", --ok (treasure)
  204257,"Opera Chest", --ok (treasure)
  204262,"Opera Chest", --ok (treasure)
  204687,"Zskera Vaults", --ok (treasure)
  205418,"Blazing Shadowflame Chest", --ok (treasure)
  208096,"Familiar Journal", --ok (treasure)
  210411,"Pineshrew Pile", --ok (treasure)
  210725,"Hidden Moonkin Stash", --ok (treasure)
  211788,"Memorial Bouquet", --ok (treasure)
  200148,"Rares (Thaldraszus)", --ok (drop)
  198409,"Rares", --ok (drop)
  200198,"Rares", --ok (drop)
  200249,"Rares", --ok (drop)
  199337,"Gaelzion, Karantun, Pipspark Thundersnap, Voraazka", --ok (drop)
  200160,"Gutrot Slime", --ok (drop)
  200178,"Blightfur, Blightpaw the Depraved, High Shaman Rotknuckle", --ok (drop)
  200857,"Obsidian Citadel", --ok (drop)
  200999,"The Great Shellkhan", --ok (drop)
  205419,"Dinn", --ok (drop)
  205463,"Moltenbinder's Disciple", --ok (drop)
  205796,"Invoq", --ok (drop)
  206008,"Treasure Goblin", --ok (drop)
  206043,"Kretchenwrath, Shadeisethal", --ok (drop)
  206993,"Temporal Investi-gator", --ok (drop)
  209035,"Larodar, Keeper of the Flame", --ok (drop)
  212337,"Dr. Boom", --ok (drop)
  198402,{"Quartermaster Huseng","100",ci[9],"2",ci[14]}, --ok
  200550,{"Quartermaster Huseng","100",ci[9],"2",ci[38]}, --ok
  200551,{"Quartermaster Huseng","100",ci[9],"2",ci[38]}, --ok
  198646,{"Emilia Bellocq","200",ci[6]}, --ok
  199900,{"Emilia Bellocq","5",ci[6]}, --ok
  198720,{"Merchants","100",ci[9],"20",ci[12],"2",ci[13]}, --ok
  198721,{"Merchants","100",ci[9],"20",ci[12],"2",ci[13]}, --ok
  198722,{"Merchants","100",ci[9],"20",ci[12],"2",ci[13]}, --ok
  200640,{"Merchants","100",ci[9],"1",ci[35],"1",ci[27]}, --ok
  198728,{"Cataloger Jakes","150",ci[9],"20",ci[12]}, --ok
  198729,{"Cataloger Jakes","150",ci[9],"20",ci[12]}, --ok
  198827,{"Kiopo, Murik","400",ci[9],"5",ci[15],"5",ci[16]}, --ok
  199899,{"Kiopo, Murik","400",ci[9],"5",ci[16],"2",ci[18]}, --ok
  199649,{"Erugosa, Unatos","100",ci[9],"3",ci[14]}, --ok
  199650,{"Lil Ki, Murik","100",ci[9],"1",ci[17]}, --ok
  199892,{"Lil Ki, Murik","100",ci[9],"2",ci[14]}, --ok
  199767,{"Unatos","150",ci[9],"20",ci[12],"1",ci[24]}, --ok
  199768,{"Unatos","150",ci[9],"20",ci[12],"1",ci[20]}, --ok
  199769,{"Unatos","150",ci[9],"20",ci[12],"1",ci[21]}, --ok
  199770,{"Unatos","150",ci[9],"20",ci[12],"1",ci[22]}, --ok
  199771,{"Unatos","150",ci[9],"20",ci[12],"1",ci[23]}, --ok
  199894,{"Murik, Nunvuq","400",ci[9],"10",ci[26],"5",ci[28]}, --ok
  199896,{"Murik, Nunvuq","400",ci[9],"10",ci[34],"5",ci[19]}, --ok
  199897,{"Lontupit, Murik","100",ci[9],"10",ci[25],"10",ci[34]}, --ok
  200707,{"Atticus Belle, Lorena Belle","100",ci[9],"20",ci[12]}, --ok
  201435,{"Usodormu","3",ci[6],"75",ci[29]}, --ok
  202020,{"Brendormi","1,200",ci[31],"75",ci[33]}, --ok
  202021,{"Warkeeper Gresh","1,500",ci[11]}, --ok
  203734,{"Kazzi","200",ci[9]}, --ok
  204675,{"Noblegarden Merchant, Noblegarden Vendor","200",ci[10]}, --ok
  205936,{"Boragg, Bottles, Chigoe, Floressa, Lyssa","1",ci[30]}, --ok
  205963,{"Harlowe Marl","200",ci[9]}, --ok
  206038,{"Midsummer Merchant, Midsummer Supplier","500",ci[8]}, --ok
  206195,{"Gaal","900",ci[37],"90",ci[32],"90",ci[36]}, --ok
  206268,{"Trading Post","500",ci[3]}, --ok
  206347,{"Trading Post","10",ci[3]}, --ok
  212500,{"Trading Post","200",ci[3]}, --ok
  212523,{"Trading Post","200",ci[3]}, --ok
  212524,{"Trading Post","200",ci[3]}, --ok
  218112,{"Trading Post","200",ci[3]}, --ok
  220692,{"Trading Post","350",ci[3]}, --ok
  206565,{"Zackett Skullsmash","15",ci[7]}, --ok
  209052,{"Belbi Quikswitch, Blix Fixwidget, Bragdur Battlebrew","200",ci[6]}, --ok
  209858,{"Celestine of the Harvest","500",ci[5]}, --ok
  209944,{"Celestine of the Harvest","500",ci[5]}, --ok
  210974,{"Kiera Torres, Lythianne Morningspear","40",ci[4]}, --ok
  210975,{"Kiera Torres, Lythianne Morningspear","100",ci[4]}, --ok
  211864,{"Kiera Torres, Lythianne Morningspear","270",ci[4]}, --ok
  212518,{"Dathendrash, Maztha","40",ci[1]}, --ok
  197961,"Achievement: Daycare Derby", --ok
  197986,"Achievement: The Joy of Toy", --ok
  198428,"Achievement: River Rapids Wrangler", --ok
  200630,"Achievement: Honor Our Ancestors", --ok
  200631,"Achievement: The Vegetarian Diet", --ok
  202207,"Achievement: Discombobberlated", --ok
  205904,"Achievement: Cavern Clawbbering", --ok
  211869,"Achievement: Legend: Dragonflight Season 4", --ok
  210497,"Achievement: Legend: Dragonflight Season 3", --ok
  206267,"Achievement: Legend: Dragonflight Season 2", --ok
  206343,"Achievement: Legend: Dragonflight Season 1", --ok
  207099,"Achievement: Many Boxes, Many Rockses", --ok
  208186,"Achievement: Temporal Acquisitions Specialist", --ok
  208421,"Achievement: Best Stellar", --ok
  208433,"Achievement: Dragonriding Challenge: Dragon Isles: Bronze", --ok
  211946,"Achievement: Hearthstone Beginner", --ok
  217723,"Achievement: Infinite Power XII", --ok
  217724,"Achievement: Infinite Power XII", --ok
  217725,"Achievement: Infinite Power XII", --ok
  217726,"Achievement: Infinite Power XII", --ok
  220777,"Achievement: The Jade Forest", --ok
  191891,"Quest: The Awaited Egg-splosion", --ok
  194885,"Quest: Befriending Wings and Wind", --ok
  198039,"Quest: Emotional Support Companions", --ok
  198090,"Quest: One Bad Apple", --ok
  198474,"Quest: Happy Little Accidents", --ok
  198537,"Quest: Taivan's Purpose", --ok
  198857,"Quest: Friend on the Mend", --ok
  199830,"Quest: Testing the Tuskarrsenal", --ok
  199902,"Quest: Wayfinder's Compass", --ok
  200597,"Quest: After My Ohn Heart", --ok
  200628,"Quest: A Helping Claw", --ok
  200878,"Quest: Return Yennu's Toy Boat", --ok
  200926,"Quest: For The Love of Others", --ok
  200960,"Quest: Shapes Beyond the Veil", --ok
  202253,"Quest: Champion of the Winterpelt", --ok
  202283,"Quest: Break Him", --ok
  203725,"Quest: A Final Word", --ok
  204170,"Quest: Aka'magosh", --ok
  204220,"Quest: Hraxian's Unbreakable Will", --ok
  204389,"Quest: The Patience of Princes", --ok
  204686,"Quest: A Sliver of Silver", --ok
  205255,"Quest: Like the Niffen Do", --ok
  205688,"Quest: All That Glitter", --ok
  205908,"Quest: A Peaceful Farewell", --ok
  206696,"Quest: Unfinished Thinking Cap", --ok
  207730,"Quest: An Idol in Hand", --ok
  208058,"Quest: A Foreseeable Friendship", --ok
  208092,"Quest: Artifact Secured", --ok
  208415,"Quest: Dawn of the Infinite: Chrono-Lord Deios", --ok
  208658,"Quest: Proof and Promise", --ok
  208798,"Quest: Disc Delivery", --ok
  210455,"Quest: Our Path Forward", --ok
  210864,"Quest: Sleepy Druid in Emerald Dream", --ok
  216881,"Quest: Just a Waddle Away", --ok
  223146,"Quest: Sins of the Sister" --ok
}

local data7 = {
  219229,{src.AMUUL,"4,000",ci[39]},
  219230,{src.AMUUL,"5,000",ci[39]},
  219231,{src.AMUUL,"4,000",ci[39]},
  219232,{src.AMUUL,"8,000",ci[39]},
  219234,{src.AMUUL,"5,000",ci[39]},
  219235,{src.AMUUL,"4,000",ci[39]},
  219236,{src.AMUUL,"3,000",ci[39]},
  219237,{src.AMUUL,"8,000",ci[39]},
  219238,{src.AMUUL,"8,000",ci[39]},
  219239,{src.AMUUL,"8,000",ci[39]},
  219240,{src.AMUUL,"8,000",ci[39]},
  219241,{src.AMUUL,"8,000",ci[39]},
  219242,{src.AMUUL,"8,000",ci[39]},
  219244,{src.AMUUL,"3,000",ci[39]},
  219245,{src.AMUUL,"8,000",ci[39]},
  219246,{src.AMUUL,"8,000",ci[39]},
  219247,{src.AMUUL,"5,000",ci[39]},
  219248,{src.AMUUL,"4,000",ci[39]},
  219249,{src.AMUUL,"4,000",ci[39]},
  219250,{src.AMUUL,"5,000",ci[39]},
  219251,{src.AMUUL,"4,000",ci[39]},
  219252,{src.AMUUL,"5,000",ci[39]},
  219253,{src.AMUUL,"4,000",ci[39]},
  218057,{src.AMUUL,"5,000",ci[39]},
  218050,{src.AMUUL,"5,000",ci[39]},
  218073,{src.AMUUL,"5,000",ci[39]},
  218063,{src.AMUUL,"5,000",ci[39]},
  218075,{src.AMUUL,"3,500",ci[39]},
  218067,{src.AMUUL,"3,500",ci[39]},
  218062,{src.AMUUL,"3,500",ci[39]},
  218054,{src.AMUUL,"3,500",ci[39]},
  218047,{src.AMUUL,"5,000",ci[39]},
  218061,{src.AMUUL,"5,000",ci[39]},
  218070,{src.AMUUL,"5,000",ci[39]},
  218064,{src.AMUUL,"5,000",ci[39]},
  218051,{src.AMUUL,"5,000",ci[39]},
  218058,{src.AMUUL,"5,000",ci[39]},
  218074,{src.AMUUL,"5,000",ci[39]},
  218006,{src.AMUUL,"5,000",ci[39]},
  218071,{src.AMUUL,"3,500",ci[39]},
  218055,{src.AMUUL,"3,500",ci[39]},
  218048,{src.AMUUL,"3,500",ci[39]},
  218065,{src.AMUUL,"3,500",ci[39]},
  218066,{src.AMUUL,"3,500",ci[39]},
  218049,{src.AMUUL,"3,500",ci[39]},
  218072,{src.AMUUL,"3,500",ci[39]},
  218056,{src.AMUUL,"3,500",ci[39]},
  218077,{src.AMUUL,"2,000",ci[39]},
  218053,{src.AMUUL,"2,000",ci[39]},
  218060,{src.AMUUL,"2,000",ci[39]},
  218069,{src.AMUUL,"2,000",ci[39]},
  218076,{src.AMUUL,"3,500",ci[39]},
  218059,{src.AMUUL,"3,500",ci[39]},
  218052,{src.AMUUL,"3,500",ci[39]},
  218068,{src.AMUUL,"3,500",ci[39]},
  218078,{src.AMUUL,"2,000",ci[39]},
  218080,{src.AMUUL,"2,000",ci[39]},
  218081,{src.AMUUL,"2,000",ci[39]},
  218079,{src.AMUUL,"2,000",ci[39]},
  218086,{src.AMUUL,"10,000",ci[39]},
  218245,{src.AMUUL,"10,000",ci[39]},
  218246,{src.AMUUL,"10,000",ci[39]},
  217987,{src.AMUUL,"20,000",ci[39]},
  217985,{src.AMUUL,"20,000",ci[39]},
  219325,"Lifeless Stone Ring"
}
local data8 = {
  218330,src.BONUS,
  218318,src.BONUS,
  218324,src.BONUS,
  218312,src.BONUS,
  218313,src.BONUS,
  218325,src.BONUS,
  218329,src.BONUS,
  218317,src.BONUS,
  218327,src.BONUS,
  218315,src.BONUS,
  218332,src.BONUS,
  218320,src.BONUS,
  218334,src.BONUS,
  218322,src.BONUS,
  218328,src.BONUS,
  218316,src.BONUS,
  218331,src.BONUS,
  218319,src.BONUS,
  218333,src.BONUS,
  218321,src.BONUS,
  218335,src.BONUS,
  218323,src.BONUS,
  218326,src.BONUS,
  218314,src.BONUS,
  218035,src.BONUS,
  218026,src.BONUS,
  218260,src.BONUS,
  218251,src.BONUS,
  218281,src.BONUS,
  218272,src.BONUS,
  218299,src.BONUS,
  218290,src.BONUS,
  217991,src.BONUS,
  218024,src.BONUS,
  218263,src.BONUS,
  218254,src.BONUS,
  218284,src.BONUS,
  218275,src.BONUS,
  218302,src.BONUS,
  218293,src.BONUS,
  218039,src.BONUS,
  218030,src.BONUS,
  218265,src.BONUS,
  218256,src.BONUS,
  218286,src.BONUS,
  218277,src.BONUS,
  218304,src.BONUS,
  218295,src.BONUS,
  218036,src.BONUS,
  218027,src.BONUS,
  218261,src.BONUS,
  218252,src.BONUS,
  218282,src.BONUS,
  218273,src.BONUS,
  218300,src.BONUS,
  218291,src.BONUS,
  218040,src.BONUS,
  218031,src.BONUS,
  218266,src.BONUS,
  218257,src.BONUS,
  218287,src.BONUS,
  218278,src.BONUS,
  218305,src.BONUS,
  218296,src.BONUS,
  218034,src.BONUS,
  218025,src.BONUS,
  218259,src.BONUS,
  218250,src.BONUS,
  218280,src.BONUS,
  218271,src.BONUS,
  218298,src.BONUS,
  218289,src.BONUS,
  218306,src.BONUS,
  218297,src.BONUS,
  218267,src.BONUS,
  218258,src.BONUS,
  218288,src.BONUS,
  218279,src.BONUS,
  218041,src.BONUS,
  218032,src.BONUS,
  218038,src.BONUS,
  218029,src.BONUS,
  218264,src.BONUS,
  218255,src.BONUS,
  218285,src.BONUS,
  218276,src.BONUS,
  218303,src.BONUS,
  218294,src.BONUS,
  218037,src.BONUS,
  218028,src.BONUS,
  218262,src.BONUS,
  218253,src.BONUS,
  218283,src.BONUS,
  218274,src.BONUS,
  218301,src.BONUS,
  218292,src.BONUS
}

local canLearn = {
  {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[11]=1,[12]=1,[13]=1,[14]=1,[16]=1,[20]=1,[21]=1}, --WARRIOR
  {[1]=1,[2]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[16]=1,[20]=1,[21]=1}, --PALADIN
  {[1]=1,[2]=1,[3]=1,[4]=1,[7]=1,[8]=1,[9]=1,[11]=1,[12]=1,[13]=1,[14]=1,[16]=1,[19]=1}, --HUNTER
  {[1]=1,[3]=1,[4]=1,[5]=1,[8]=1,[12]=1,[13]=1,[14]=1,[16]=1,[18]=1}, --ROGUE
  {[5]=1,[11]=1,[13]=1,[15]=1,[16]=1,[17]=1}, --PRIEST
  {[1]=1,[2]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[16]=1,[20]=1}, --DEATHKNIGHT
  {[1]=1,[2]=1,[5]=1,[6]=1,[11]=1,[13]=1,[16]=1,[19]=1,[21]=1}, --SHAMAN
  {[8]=1,[11]=1,[13]=1,[15]=1,[16]=1,[17]=1}, --MAGE
  {[8]=1,[11]=1,[13]=1,[15]=1,[16]=1,[17]=1}, --WARLOCK
  {[1]=1,[5]=1,[7]=1,[8]=1,[11]=1,[12]=1,[16]=1,[18]=1}, --MONK
  {[5]=1,[6]=1,[7]=1,[11]=1,[12]=1,[13]=1,[16]=1,[18]=1}, --DRUID
  {[1]=1,[8]=1,[10]=1,[12]=1,[16]=1,[18]=1}, --DEMONHUNTER
  {[1]=1,[2]=1,[5]=1,[6]=1,[8]=1,[9]=1,[11]=1,[12]=1,[13]=1,[16]=1,[19]=1}, --EVOKER
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1} --WARBAND
}

local iconButton = CreateFrame("Button","LibDBIcon10_TroveTally",Minimap)
iconButton:SetFrameStrata("MEDIUM")
iconButton:SetSize(34,34)
iconButton:SetFrameLevel(8)
iconButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
iconButton.texture = iconButton:CreateTexture(nil,"BACKGROUND")
iconButton.texture:SetTexture("Interface\\AddOns\\TroveTally\\Assets\\icon")
iconButton.texture:SetSize(34,34)
iconButton.texture:SetTexCoord(0,0.625,0,0.625)
iconButton.texture:SetPoint("CENTER")

local function setIconPos(degrees)
  local posX = 102 * cos(degrees)
  local posY = 102 * sin(degrees)
  iconButton:SetPoint("CENTER",Minimap,"CENTER",-posX,-posY)
  iconDegrees = degrees
end

local canDrag = false
local function calculateAngle()
  if canDrag then
      local pX,pY = GetCursorPosition()
      local scale = Minimap:GetEffectiveScale()
      pX = pX / scale
      pY = pY / scale
      local mapX,mapY = Minimap:GetCenter()
      local dX = mapX - pX
      local dY = mapY - pY
      local degrees = math.deg(math.atan2(dY,dX))
      setIconPos(degrees)
    end
end

local _uid = 0
local function uid()
  _uid = _uid + 1
  return _uid
end
local dataI = 1
local mI = 2
local orig = {mop = 1,ens = 5,inf = 6,mou = 7,toy = 8,oth = 9,dto = 10,rad = 11,rew = 12,rec = 13}
local keys = {"mop","ens","inf","mou","toy","oth","dto","rad","rew","rec"}
local origI = 1
local memory = {{},{},{},{},{},{},{},{},{},{},{},{},{}}
local playerClass = {}
playerClass.name,_,playerClass.index = UnitClass("player")
local playerSpecs = {}
local myGUID = nil
local lists = {
  [1] = " |cffFFC000| |r混搭再造: 潘達利亞",
  [2] = "",
  [4] = " |cffFFC000| |r設定",
  [5] = " |cffFFC000| |r武器庫與塑形套裝",
  [6] = " |cffFFC000| |r無限市集",
  [7] = " |cffFFC000| |r坐騎",
  [8] = " |cffFFC000| |r玩具",
  [9] = " |cffFFC000| |r其他",
  [10] = " |cffFFC000| |r巨龍崛起玩具",
  [11] = " |cffFFC000| |r璀燦回音",
  [12] = " |cffFFC000| |r獎勵",
  [13] = " |cffFFC000| |r新兵裝備"
}

local region = GetCurrentRegion()
local regionTime = {
  1722279640, --US
  1722470440, --KR
  1722290440, --EU
  1722488440, --TW
  1722488440 --CN
}

local function getTime()
  local time = date("*t",GetServerTime() - regionTime[region])
  local sec = time.hour * 3600 + time.min * 60 + time.sec
  local secLeft = math.ceil(sec / 3600) * 3600 - sec
  local hourNum = math.floor(secLeft / 3600)
  secLeft = secLeft % 3600
  local minNum = math.floor(secLeft / 60)
  local secNum = secLeft % 60
  return (hourNum > 0 and hourNum..":" or "")..string.format("%02d:%02d",minNum,secNum)
end

local state = {[false] = "已停用",[true] = "已啟用",[1] = "戰隊",[2] = playerClass.name}

local bigFrame = CreateFrame("Frame",nil,UIParent)
bigFrame:SetSize(516+24,336+34+26)
bigFrame:SetPoint("CENTER",0,0)
bigFrame:SetFrameStrata("DIALOG")
bigFrame:SetMovable(true)
bigFrame:SetScript("OnMouseDown",bigFrame.StartMoving)
bigFrame:SetScript("OnMouseUp",bigFrame.StopMovingOrSizing)
bigFrame:Hide()

local exFrame = CreateFrame("Frame",nil,bigFrame,"BackdropTemplate")
exFrame:SetBackdrop({
  bgFile = "Interface\\Buttons\\WHITE8x8"
})
exFrame:SetBackdropColor(0,0,0)
exFrame:SetClipsChildren(true)
exFrame:Hide()
exFrame:SetScript("OnHide",function(self) self:SetScript("OnUpdate",nil) end) --IF

local exIcons = {}
local function createExIcon(i)
  local exIcon = CreateFrame("Frame",nil,exFrame)
  exIcon:SetSize(20,20)
  exIcon:SetPoint("TOPLEFT",2,-2 - (i - 1) * 24)
  local exBg = exIcon:CreateTexture(nil,"ARTWORK")
  exBg:SetTexCoord(0.0625,0.9375,0.0625,0.9375)
  exBg:SetSize(17,17)
  exBg:SetPoint("CENTER")
  local exBorder = exIcon:CreateTexture(nil,"OVERLAY")
  exBorder:SetTexture("Interface\\AddOns\\TroveTally\\Assets\\ex")
  exBorder:SetTexCoord(0,0.625,0,0.625)
  exBorder:SetAllPoints()
  local exText = exIcon:CreateFontString(nil,"OVERLAY","GameFontHighlight")
  exText:SetTextColor(1,0.7529,0)
  exText:SetHeight(24)
  exText:SetPoint("LEFT",exIcon,"RIGHT",6,0)

  table.insert(exIcons,{icon = exIcon,bg = exBg,text = exText})
end
for i = 1,3 do createExIcon(i) end

local function resizeEx(userFrame)
  local width = 0
  local height = 0
  for _,exIcon in ipairs(exIcons) do
    if not exIcon.icon:IsShown() then break end
    local textWidth = exIcon.text:GetStringWidth()
    width = math.max(width,textWidth)
    height = height + 24
  end
  exFrame:SetSize(34 + width,height)
  exFrame:SetPoint("TOPLEFT",userFrame,"TOPRIGHT",24,0)
  exFrame:Show()
end

local itemIcon = CreateFrame("Frame",nil,bigFrame)
itemIcon:SetSize(60,60)
itemIcon:SetPoint("TOPLEFT",-64,0)
itemIcon:SetClipsChildren(true)
itemIcon.texture = itemIcon:CreateTexture(nil,"OVERLAY")
itemIcon.texture:SetTexture(133001)
itemIcon.texture:SetTexCoord(0.0625,0.9375,0.0625,0.9375)
itemIcon.texture:SetSize(56,56)
itemIcon.texture:SetPoint("CENTER")
itemIcon.mask = itemIcon:CreateMaskTexture()
itemIcon.mask:SetTexture("Interface\\AddOns\\TroveTally\\Assets\\mask","CLAMPTOBLACKADDITIVE","CLAMPTOBLACKADDITIVE")
itemIcon.mask:SetAllPoints(itemIcon.texture)
itemIcon.texture:AddMaskTexture(itemIcon.mask)
itemIcon.shadow = itemIcon:CreateTexture(nil,"OVERLAY")
itemIcon.shadow:SetTexture("Interface\\AddOns\\TroveTally\\Assets\\bg")
itemIcon.shadow:SetTexCoord(0,0.9375,0,0.9375)
itemIcon.shadow:SetAllPoints()
itemIcon:Hide()

iconButton:SetScript("OnEnter",function()
  if not canDrag then
    GameTooltip:SetOwner(iconButton,"ANCHOR_BOTTOMLEFT",34+3.4,0)
    GameTooltip:AddLine("|cffffffff混搭收藏單")
    GameTooltip:AddLine("|cff1eff00<點左鍵打開>")
    GameTooltip:Show()
  end
end)
iconButton:SetScript("OnLeave",function()
  GameTooltip:Hide()
end)
iconButton:SetScript("OnMouseDown",function(self,button)
  if button == "LeftButton" then
    self:SetScript("OnUpdate",function() calculateAngle() end)
  end
end)
iconButton:SetScript("OnMouseUp",function(self,button)
  if button == "LeftButton" then
    if not canDrag then SlashCmdList["TROVE"]() end
    self:SetScript("OnUpdate",nil)
  end
end)
iconButton:RegisterForDrag("LeftButton")
iconButton:SetScript("OnDragStart",function()
  canDrag = true
  GameTooltip:Hide()
end)
iconButton:SetScript("OnDragStop",function() canDrag = false end)

local function createRect(parent,w,h,color,x,y,c)
  local f = CreateFrame("Frame",nil,parent,"BackdropTemplate")
  f:SetSize(w,h)
  f:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8"})
  f:SetBackdropColor(unpack(color))
  f:SetPoint("TOPLEFT",x,y)
  if c then f:SetClipsChildren(true) end
  return f
end

local header = createRect(bigFrame,540,34,{0,0,0},0,0,true)
header:SetFrameLevel(20)
local headerLine = createRect(header,540,2,{1,0.7529,0},0,-32)
local mainFrame = createRect(bigFrame,540,336,{0,0,0},0,-34,true)
local footer = createRect(bigFrame,540,26,{0,0,0},0,-370,true)
footer:SetFrameLevel(20)
local footerLine = createRect(footer,540,2,{1,0.7529,0},0,0)

local mainFrameHeaderTitle = header:CreateFontString(nil,"OVERLAY","GameFontHighlightMedium")
mainFrameHeaderTitle:SetHeight(32)
mainFrameHeaderTitle:SetPoint("TOPLEFT",6,0)
mainFrameHeaderTitle:SetJustifyH("LEFT")
mainFrameHeaderTitle:SetJustifyV("MIDDLE")
mainFrameHeaderTitle:SetText("Trove Tally")

local mainFrameEdit = CreateFrame("EditBox",nil,mainFrame)
mainFrameEdit:SetSize(240,24)
mainFrameEdit:SetFrameLevel(11)
mainFrameEdit:SetHighlightColor(0,0,0,0)
mainFrameEdit:SetFontObject(GameFontHighlight)
mainFrameEdit.block = CreateFrame("Frame",nil,mainFrameEdit)
mainFrameEdit.block:EnableMouse(true)
mainFrameEdit:Hide()

hooksecurefunc(mainFrameEdit,"ClearFocus",function()
  settings.custom = mainFrameEdit.custom or false
  local text = (settings.custom == false) and "Disabled" or settings.custom
  memory[4][1].text = text
  mainFrameEdit.parent.userNote:SetText(text)
  mainFrameEdit:Hide()
end)
mainFrameEdit:SetScript("OnEscapePressed",function() mainFrameEdit:ClearFocus() end)
mainFrameEdit:SetScript("OnEnterPressed",function()
  mainFrameEdit.custom = mainFrameEdit:GetText()
  mainFrameEdit:ClearFocus()
end)

mainFrameEdit.block:SetScript("OnEnter",function()
  mainFrameEdit.parent:GetScript("OnEnter")()
end)
mainFrameEdit.block:SetScript("OnLeave",function()
  if lastUserFrameSelected ~= nil then
    lastUserFrameSelected.onLeave()
    lastUserFrameSelected = nil
  end
end)
mainFrameEdit.block:SetScript("OnMouseDown",function(self,button)
  mainFrameEdit.parent:GetScript("OnMouseDown")(self,button)
end)

local canInfo = true
local headerInfo = CreateFrame("Frame",nil,header)
headerInfo:SetAllPoints()
headerInfo.text = headerInfo:CreateFontString(nil,"OVERLAY","GameFontHighlight")
headerInfo.text:SetHeight(32)
headerInfo.text:SetPoint("TOPRIGHT",-2-28-2-8-7.875-8,0)
headerInfo.text:SetJustifyH("RIGHT")
headerInfo.text:SetJustifyV("MIDDLE")
headerInfo.text:SetText("點右鍵返回")
headerInfo.texture = headerInfo:CreateTexture(nil,"OVERLAY")
headerInfo.texture:SetTexture("Interface\\AddOns\\TroveTally\\Assets\\i")
headerInfo.texture:SetTexCoord(0,0.5625,0,1)
headerInfo.texture:SetVertexColor(1,0.7529,0)
headerInfo.texture:SetSize(7.875,28)
headerInfo.texture:SetPoint("TOPLEFT",516-28-2+24-7.875-2-8,-2)
headerInfo.anim = headerInfo:CreateAnimationGroup()
headerInfo.animAlpha = headerInfo.anim:CreateAnimation("Alpha")
headerInfo.animAlpha:SetFromAlpha(1)
headerInfo.animAlpha:SetToAlpha(0)
headerInfo.animAlpha:SetStartDelay(4)
headerInfo.animAlpha:SetDuration(2)
headerInfo.animAlpha:SetSmoothing("IN_OUT")
headerInfo.anim:SetScript("OnFinished",function() headerInfo:Hide() end)
headerInfo:Hide()

local mainFrameExit = CreateFrame("Button",nil,header)
mainFrameExit:SetSize(28,28)
mainFrameExit:SetPoint("TOPLEFT",516-28-2+24,-2)
local mainFrameExitTexture = mainFrameExit:CreateTexture(nil,"OVERLAY")
mainFrameExitTexture:SetTexture("Interface\\AddOns\\TroveTally\\Assets\\tools")
mainFrameExitTexture:SetTexCoord(0.5,1,0.5,1)
mainFrameExitTexture:SetVertexColor(0.9569,0.2627,0.2118)--RED
mainFrameExitTexture:SetAllPoints()
mainFrameExit:SetScript("OnEnter",function()
  mainFrameExitTexture:SetVertexColor(1,1,1)
end)
mainFrameExit:SetScript("OnLeave",function()
  mainFrameExitTexture:SetVertexColor(0.9569,0.2627,0.2118)--RED
end)
mainFrameExit:SetScript("OnClick",function()
  bigFrame:Hide()
end)

local mainFrameScrollHit = CreateFrame("Frame",nil,bigFrame,"BackdropTemplate")
mainFrameScrollHit:SetSize(24,336)
mainFrameScrollHit:SetBackdrop({
  bgFile = "Interface\\Buttons\\WHITE8x8"
})
local lastScrollPos = -1
local register = false
local mainFrameScrollHand,mainFrameScrollHandTexture
local function scrollDown()
  if #memory[mI] > 14 then
    register = true
    mainFrameScrollHandTexture:SetVertexColor(1,1,1)
  end
end
local function scrollUp()
  register = false
  lastScrollPos = -1
  if not MouseIsOver(mainFrameScrollHand) then
    mainFrameScrollHandTexture:SetVertexColor(1,0.7529,0)
  end
end
mainFrameScrollHit:SetPoint("TOPLEFT",492+24,-34)
mainFrameScrollHit:SetFrameLevel(mainFrame:GetFrameLevel() + 1)
mainFrameScrollHit:SetScript("OnMouseDown",scrollDown)
mainFrameScrollHit:SetScript("OnMouseUp",scrollUp)
mainFrameScrollHit:SetAlpha(0)

local mainFrameScrollBackground = CreateFrame("Frame",nil,bigFrame,"BackdropTemplate")
mainFrameScrollBackground:SetSize(4,336-8-8)
mainFrameScrollBackground:SetBackdrop({
  bgFile = "Interface\\Buttons\\WHITE8x8"
})
mainFrameScrollBackground:SetBackdropColor(0.3,0.3,0.3)
mainFrameScrollBackground:SetPoint("TOPLEFT",492+2+8+24,-8-34)

mainFrameScrollHand = CreateFrame("Button",nil,bigFrame)
mainFrameScrollHand:SetSize(12.25,21)
mainFrameScrollHand:SetPoint("TOPLEFT",492+5.875+24,-5.875-34)
--mainFrameScrollHand:SetPoint("TOPLEFT",492+5.875,-309.125)
mainFrameScrollHandTexture = mainFrameScrollHand:CreateTexture(nil,"OVERLAY")
mainFrameScrollHandTexture:SetTexture("Interface\\AddOns\\TroveTally\\Assets\\hand")
mainFrameScrollHandTexture:SetTexCoord(0,0.875,0,0.75)
mainFrameScrollHandTexture:SetVertexColor(1,0.7529,0)
mainFrameScrollHandTexture:SetAllPoints()
mainFrameScrollHand:SetFrameLevel(mainFrameScrollHit:GetFrameLevel() + 1)
mainFrameScrollHand:SetScript("OnEnter",function()
  if #memory[mI] > 14 then
    mainFrameScrollHandTexture:SetVertexColor(1,1,1)
  end
end)
mainFrameScrollHand:SetScript("OnLeave",function()
  if not register then
    mainFrameScrollHandTexture:SetVertexColor(1,0.7529,0)
  end
end)
mainFrameScrollHand:SetScript("OnMouseDown",scrollDown)
mainFrameScrollHand:SetScript("OnMouseUp",scrollUp)

local function mainFrameScroll(adjustedValue,setScroll,update)
  local firstItem = floor(adjustedValue)
  local shift = adjustedValue - firstItem
  for i = 1,15 do
    local userFrame = userFrames[i]
    local offset = (shift * 24) + ((i - 1) * -24)
    userFrame:SetPoint("TOPLEFT",0,offset)
    
    if update and memory[mI][#memory[mI] - (firstItem + (i-1))] ~= nil then
      userFrame.update(firstItem + (i-1))
    end
  end
  if setScroll then scroll = firstItem * 24 + shift * 24 end
  local newHandPos
  if #memory[mI] < 15 then
    newHandPos = -5.875-34
  else
    newHandPos = -5.875-34 + (adjustedValue / (#memory[mI] - 14)) * -303.25
  end
  --mainFrameScrollHand:SetSize(12.25,21)
  --mainFrameScrollHand:SetPoint("TOPLEFT",492+5.875,-5.875)
  --mainFrameScrollHand:SetPoint("TOPLEFT",492+5.875,-309.125)

  mainFrameScrollHand:SetPoint("TOPLEFT",492+24+5.875,newHandPos)
end

mainFrame:SetScript("OnMouseWheel",function(_,delta)
  local maxUsers = #memory[mI] - 14
  if maxUsers > 0 then
    local maxScroll = maxUsers * 24
    scroll = scroll + delta * -32
    if scroll < 0 then
      scroll = 0
    elseif scroll > maxScroll then
      scroll = maxScroll
    end
    local adjustedValue = scroll / maxScroll * maxUsers
    mainFrameScroll(adjustedValue,false,true)
  end
end)

local history = {}
local titleH = {}
local function clean(index,ignore,alt,total,collected)
  if ignore == nil then table.insert(history,mI) end
  mI = index
  scroll = 0
  mainFrameScroll(0,false,false)
  for i = 1,15 do
    local userFrame = userFrames[i]
    if i == min(#memory[mI],i) then
      userFrame.update(i - 1)
      userFrame:Show()
    else userFrame:Hide() end
  end
  if alt ~= nil then index = alt end
  local title = string.format("Trove Tally%s",lists[index])
  if total ~= nil then
    titleH = {title,collected,total}
    title = string.format("%s (%d/%d)",title,collected,total)
  end
  mainFrameHeaderTitle:SetText(title)
  if canInfo then
    headerInfo:Show()
    headerInfo.anim:Play()
    canInfo = false
  end
end

local selGroup
local function goBack()
  if #history > 0 then
    if mainFrameEdit:IsVisible() then
      userFrames[9].userNote:SetText("Disabled")
      mainFrameEdit:Hide()
    end
    if GameTooltip:IsVisible() then
      itemIcon:Hide()
      GameTooltip:Hide()
    end
    if exFrame:IsVisible() then exFrame:Hide() end
    clean(history[#history],true)
    history[#history] = nil
    selGroup = nil
  end
end

mainFrame:SetScript("OnMouseDown",function(_,button)
  if button == "RightButton" then goBack() end
end)

local flags = {item = {},mount = {},spell = {},pet = {}}
local flagType = {
  [1] = flags.mount,
  [2] = flags.spell,
  [5] = flags.pet
}

local function classLoot(specs)
  for i = 1,GetNumSpecializations() do
    local specID = GetSpecializationInfo(i)
    if specs[specID] ~= nil then return true end
  end
  return false
end

local function filter(filterID,key,ignore)
  memory[3] = {}
  local total,collected = 0,0
  for _,sel in ipairs(memory[key]) do
    local canLoot = true
    if sel.itemSpecs.s > 0 and sel.itemSpecs[-1] == nil then
      if filterID == -1 then canLoot = classLoot(sel.itemSpecs)
      elseif filterID >= 0 and sel.itemSpecs[filterID] == nil then canLoot = false end
    end
    --
    if canLoot then
      total = total + 1
      if sel.owned or settings.hideKnown and sel.known then collected = collected + 1 end
      if not (settings.hideOwned and (sel.owned or settings.hideKnown and sel.known) or settings.hideUnobt and sel.un) then
        table.insert(memory[3],{
          itemID = sel.itemID,
          text = sel.text,
          name = sel.name,
          owned = sel.owned,
          known = sel.known,
          spellID = sel.spellID,
          itemLink = sel.itemLink,
          t = sel.t,
          un = sel.un,
          s = sel.s,
          uid = sel.uid
        })
      end
    end
  end
  clean(3,ignore,key,total,collected)
end

local selSpecID = -2
local selBtn
local function createBtn(str,specID,offset,sel)
  local text = footer:CreateFontString(nil,"OVERLAY","GameFontHighlight")
  text:SetText(str)
  local w = text:GetWidth() + 12
  local btn = createRect(footer,w,24,{0,0,0},offset or 0,-2)
  text:SetParent(btn); text:SetAllPoints()
  if sel then text:SetTextColor(1,0.7529,0); selBtn = text end
  btn:SetScript("OnEnter",function(self)
    self:SetBackdropColor(0.125,0.125,0.125)
    text:SetTextColor(1,0.7529,0)
  end)
  btn:SetScript("OnLeave",function(self)
    self:SetBackdropColor(0,0,0)
    if selSpecID ~= specID then text:SetTextColor(1,1,1) end
  end)
  btn:SetScript("OnMouseDown",function(self)
    if selBtn ~= text then
      selBtn:SetTextColor(1,1,1); selBtn = text
      selSpecID = specID
      if selGroup then filter(selSpecID,selGroup,true) end
    end
  end)
  return w
end

local function populateSpec()
  memory[2][1] = {itemID = nil,text = "打開設定選項",name = "設定",specID = -3,uid = uid()}
  memory[2][2] = {itemID = nil,text = {"打開璀燦回音群組","rad",ci[40]},name = "璀燦回音",specID = -18,uid = uid()}
  memory[2][3] = {itemID = nil,text = "只顯示巨龍崛起玩具",name = "巨龍崛起玩具",specID = -15,uid = uid()}
  memory[2][4] = {itemID = nil,text = "打開無限市集群組",name = "無限市集",specID = -6,uid = uid()}
  memory[2][5] = {itemID = nil,text = "只顯示混搭再造: 潘達利亞物品",name = "混搭再造: 潘達利亞",specID = -19,uid = uid()}
  local w = createBtn(playerClass.name,-1)
  for i = 1,GetNumSpecializations() do
    local specID, specName = GetSpecializationInfo(i)
    table.insert(playerSpecs,specID)
    w = w + createBtn(specName,specID,w)
  end
  w = w + createBtn("全部",-2,w,true)
  memory[6][1] = {itemID = nil,text = "過濾其他所有內容",name = "其他",specID = -14,uid = uid()}
  memory[6][2] = {itemID = nil,text = "只顯示玩具",name = "玩具",specID = -11,uid = uid()}
  memory[6][3] = {itemID = nil,text = "只顯示坐騎",name = "坐騎",specID = -10,uid = uid()}
  memory[6][4] = {itemID = nil,text = "只顯示武器庫與塑形套裝",name = "武器庫與塑形套裝",specID = -9,uid = uid()}
  memory[11][1] = {itemID = nil,text = "只顯示新兵裝備",name = "新兵裝備",specID = -21,uid = uid()}
  memory[11][2] = {itemID = nil,text = "只顯示獎勵",name = "獎勵",specID = -20,uid = uid()}
end

local function checkShopID(id)
  if id == nil or id == 226127 then return false end
  local m = flags.item[id]
  return m and m.owned or false
end

local function updateMerchantBtn(btn,i)
  local merchantButton = _G["MerchantItem"..btn]
  local itemName = _G["MerchantItem"..btn.."Name"]
  local itemButton = _G["MerchantItem"..btn.."ItemButton"]
  local altCurrency = _G["MerchantItem"..btn.."AltCurrencyFrame"]
  local function popItem()
    itemName:SetText("")
    itemButton:Hide()
    altCurrency:Hide()
    SetItemButtonSlotVertexColor(merchantButton,0.4,0.4,0.4)
  end
  if i == nil then popItem(); return end
  local name,texture,_,_,_,isPurchasable = GetMerchantItemInfo(i)
  if name == nil then popItem(); return end

  itemName:SetText(name)
  SetItemButtonTexture(itemButton,texture)
  MerchantFrame_UpdateAltCurrency(i,btn,CanAffordMerchantItem(i))
  altCurrency:Show()--test if needed
  local itemLink = GetMerchantItemLink(i)
  MerchantFrameItem_UpdateQuality(merchantButton,itemLink)
  local merchantItemID = GetMerchantItemID(i)
  local isHeirloom = merchantItemID and C_Heirloom.IsItemHeirloom(merchantItemID)
  local isKnownHeirloom = isHeirloom and C_Heirloom.PlayerHasHeirloom(merchantItemID)
  itemButton:SetID(i)
  itemButton:Show()
  itemButton.link = itemLink
  itemButton.texture = texture
  SetItemButtonDesaturated(itemButton,isKnownHeirloom)
  
  if isKnownHeirloom then
    SetItemButtonSlotVertexColor(merchantButton,0.5,0.5,0.5)
    SetItemButtonTextureVertexColor(itemButton,0.5,0.5,0.5)
    SetItemButtonNormalTextureVertexColor(itemButton,0.5,0.5,0.5)
  elseif not isPurchasable then
    SetItemButtonSlotVertexColor(merchantButton,1.0,0,0)
    SetItemButtonTextureVertexColor(itemButton,0.9,0,0)
    SetItemButtonNormalTextureVertexColor(itemButton,0.9,0,0)
  else
    SetItemButtonSlotVertexColor(merchantButton,1.0,1.0,1.0)
    SetItemButtonTextureVertexColor(itemButton,1.0,1.0,1.0)
    SetItemButtonNormalTextureVertexColor(itemButton,1.0,1.0,1.0)
  end
end

local vendor = {}

local validMerchants = {
  [219027] = true, --PYTHAGORUS
  [219028] = true, --DURUS
  [225269] = true, --DURUS2
  [219031] = true, --AEONICUS
  [219030] = true, --ARTUROS
  [219025] = true, --LARAH
  [220618] = true, --JAKKUS
  [220895] = true, --JAKKUS2
  [219032] = true, --HEMET
  [219331] = true, --HEMET2
  [217051] = true, --HOROS
  [219013] = true --HOROS2
}
local function isValidMerchant()
  if UnitGUID("npc") == nil then return false end
  local npcID = select(6,strsplit("-",UnitGUID("npc")))
  return validMerchants[tonumber(npcID)] or false
end

local function updateMerchant()
  if not settings.hideMerchant or not isValidMerchant() then return end
  local size = MERCHANT_ITEMS_PER_PAGE
  MerchantPageText:SetFormattedText(MERCHANT_PAGE_NUMBER,MerchantFrame.page,math.ceil(#vendor / size))
  if #vendor <= size then
    MerchantPageText:Hide()
		MerchantPrevPageButton:Hide()
		MerchantNextPageButton:Hide()
  elseif MerchantFrame.page == math.ceil(#vendor / size) then MerchantNextPageButton:Disable() end
  for i = 1,size do
    local index = (MerchantFrame.page - 1) * size + i
    updateMerchantBtn(i,vendor[index])
  end
end

local function openMerchant(force)
  if not settings.hideMerchant or not isValidMerchant() then return end
  vendor = {}
  for i = 1,GetMerchantNumItems() do
    local itemID = GetMerchantItemID(i)
    if not checkShopID(itemID) then table.insert(vendor,i) end
  end
  if force ~= nil then
    MerchantFrame.page = 1
    MerchantPrevPageButton:Disable()
    MerchantNextPageButton:Enable()
    updateMerchant()
  end
end

local function updateNote(arg,new1,new2)
  for i,u in ipairs(userFrames) do
    if not u:IsShown() then break end
    if arg.uid == u.uid then
      if new1 ~= nil then u.userNote:SetText(arg.text) end
      if new2 ~= nil then
        u.userMood.color(colors.green)
        u.userMood:SetTexCoord(0,0.5,0,0.5)
      end
      break
    end
  end
end

local default = "Hi! 你是否需要剛拿到的 $? 如果不要的話，可不可以給我?"
local function openEdit(arg)
  for _,u in ipairs(userFrames) do
    if arg.uid == u.uid then
      mainFrameEdit.parent = u
      u.userNote:SetText("")
      mainFrameEdit:SetPoint("RIGHT",u,-24,0)
      mainFrameEdit.block:SetAllPoints(u)
      break
    end
  end
end

local options = {
  default = {[false] = true,[true] = false},
  special = {[false] = 1,[1] = 2,[2] = false}
}
local function switch(var,i,opt)
  settings[var] = options[opt or "default"][settings[var]]
  memory[4][i].text = state[settings[var]]
  updateNote(memory[4][i],true)
end

local actions = {
  [-3] = function() clean(4) end, --SETTINGS
  [-4] = function() switch("hideOwned",9) end,
  [-5] = function()
    switch("hideIcon",5)
    if settings.hideIcon then iconButton:Hide() else iconButton:Show() end
  end,
  [-6] = function() clean(orig["inf"]) end,--filter(-1,orig["inf"]) end, --ENSEMBLES
  [-7] = function()
    switch("hideMerchant",6)
    if MerchantFrame:IsVisible() then
      if settings.hideMerchant then openMerchant(true)
      else
        MerchantFrame.page = 1
        MerchantFrame_UpdateMerchantInfo()
      end
    end
  end,
  [-8] = function() switch("trade",4,"special") end,
  [-9] = function() filter(-1,orig["ens"]) end,
  [-10] = function() filter(-1,orig["mou"]) end,
  [-11] = function() filter(-1,orig["toy"]) end,
  [-12] = function() switch("instant",2) end,
  [-13] = function()
    if settings.custom == false then
      mainFrameEdit:Show()
      mainFrameEdit:SetText(default)
      mainFrameEdit:HighlightText()
      mainFrameEdit:SetCursorPosition(0)
      openEdit(memory[4][1])
    else
      settings.custom = false
      memory[4][1].text = "Disabled"
      updateNote(memory[4][1],true)
      mainFrameEdit.custom = nil
    end
  end,
  [-14] = function() filter(-1,orig["oth"]) end,
  [-15] = function() filter(-1,orig["dto"]) end,
  [-16] = function() switch("hideUnobt",7) end,
  [-17] = function() switch("unlisted",3) end,
  [-18] = function() clean(orig["rad"]) end,
  [-19] = function() filter(selSpecID,orig["mop"]); selGroup = 1 end,
  [-20] = function() filter(-1,orig["rew"]) end,
  [-21] = function() filter(selSpecID,orig["rec"]); selGroup = 13 end,
  [-22] = function() switch("hideKnown",8) end
}

local function userFrameOnClick(button,parent)
  if button == "LeftButton" then
    if parent.itemID == nil then actions[parent.specID]()
    else
      if ACTIVE_CHAT_EDIT_BOX ~= nil and IsShiftKeyDown() then ChatEdit_InsertLink(parent.itemLink)
      elseif IsControlKeyDown() then
        if parent.t == 1 then DressUpMount(parent.spellID)
        elseif parent.t == 3 then C_ToyBox.PickupToyBoxItem(parent.itemID)
        elseif parent.t == 5 then
          local displayID = C_PetJournal.GetDisplayIDByIndex(parent.spellID,1)
          DressUpBattlePet(nil,displayID,parent.spellID)
        elseif parent.t ~= 4 then DressUpItemLink("item:"..parent.itemID) end
      end
    end
  elseif button == "RightButton" then goBack() end
end

local function createUserFrame(offset)
local userFrame = CreateFrame("Frame",nil,mainFrame,"BackdropTemplate")
userFrame:SetClipsChildren(true)
userFrame:SetSize(492+24,24)
userFrame:SetBackdrop({
  bgFile = "Interface\\Buttons\\WHITE8x8"
})
userFrame:SetBackdropColor(0,0,0)
userFrame:SetPoint("TOPLEFT",0,offset)
if #userFrames > 0 then
  userFrame:SetFrameLevel(userFrames[#userFrames]:GetFrameLevel() + 1)
end

local userName
userFrame.userMood = nil
userFrame.userNote = nil

userFrame.id = nil
userFrame.uid = 0
userFrame.name = ""
userFrame.text = ""
userFrame.itemID = nil
userFrame.specID = nil
userFrame.spellID = nil
userFrame.itemLink = nil
userFrame.t = nil
userFrame.un = nil
userFrame.s = nil

userFrame.onEnter = function()
  --print(userFrame.uid)
  if lastUserFrameSelected ~= nil then
    lastUserFrameSelected.onLeave()
  end
  lastUserFrameSelected = userFrame
  userName:SetTextColor(1,0.7529,0)
  userFrame.userNote:SetTextColor(1,0.7529,0)
  if userFrame.color == colors.white then
    userFrame.userMood.color(colors.gold)
  end
  userFrame:SetBackdropColor(0.125,0.125,0.125)

  userName:SetWordWrap(true)
  userFrame.userNote:SetWordWrap(true)
  if userFrame.itemID ~= nil then
    itemIcon.texture:SetTexture(GetItemIcon(userFrame.itemID))
    itemIcon:Show()
    GameTooltip:SetOwner(bigFrame,"ANCHOR_BOTTOMLEFT",-4,336+34-60-4+26)
    GameTooltip:SetHyperlink("item:"..userFrame.itemID)
    GameTooltip:Show()
  end

  if userFrame.cost then
    for i = 2,7,2 do
      local amount = userFrame.cost[i]
      if amount ~= nil then
        local text = exIcons[i / 2].text
        if amount == "rad" then
          amount = getTime()
          exFrame:SetScript("OnUpdate",function() text:SetText(getTime()) end)
        end
        exIcons[i / 2].bg:SetTexture(userFrame.cost[i + 1])
        text:SetText(amount)
        exIcons[i / 2].icon:Show()
      else exIcons[i / 2].icon:Hide() end
    end
    resizeEx(userFrame)
  end
end

userFrame.update = function(shift)
  userFrame.id = shift
  local memoryItem = memory[mI][#memory[mI] - shift]
  userFrame.uid = memoryItem.uid
  if userFrame.needUpdate ~= userFrame.uid then
    userFrame.needUpdate = userFrame.uid

    local moodColor = colors.none
    local moodIcon = {0,0.5,0,0.5}
    if memoryItem.owned or settings.hideKnown and memoryItem.known then moodColor = colors.green end
    if type(memoryItem.text) ~= "table" then
      userFrame.cost = nil
      userFrame.text = memoryItem.text
      if userFrame.uid == 10 then
        moodColor = colors.white
        moodIcon = {0,0.5,0.5,1}
      end
    else
      userFrame.cost = memoryItem.text
      userFrame.text = memoryItem.text[1]
      if moodColor[4] == 0 then
        moodColor = colors.white
        moodIcon = {0.5,1,0,0.5}
      end
    end

    userFrame.itemID = memoryItem.itemID
    userFrame.name = memoryItem.name
    userFrame.t = memoryItem.t
    userFrame.un = memoryItem.un
    userFrame.s = memoryItem.s
    if memoryItem.specID == nil then
      userFrame.specID = nil
    else
      userFrame.specID = memoryItem.specID
    end
    if memoryItem.spellID == nil then
      userFrame.spellID = nil
    else
      userFrame.spellID = memoryItem.spellID
    end
    if memoryItem.itemLink == nil then
      userFrame.itemLink = nil
    else
      userFrame.itemLink = memoryItem.itemLink
    end

    userName:SetText(userFrame.name)
    userFrame.userNote:SetText(userFrame.text)
    userFrame.userMood.color(moodColor)
    userFrame.userMood:SetTexCoord(unpack(moodIcon))

    if MouseIsOver(userFrame) and not selGroup then userFrame.onEnter() end
  end
end

userFrame:SetScript("OnEnter",userFrame.onEnter)
userFrame.onLeave = function()
  lastUserFrameSelected = nil
  userName:SetTextColor(1,1,1)
  userFrame.userNote:SetTextColor(1,1,1)
  if userFrame.color == colors.gold then
    userFrame.userMood.color(colors.white)
  end
  userFrame:SetBackdropColor(0,0,0)

  userName:SetWordWrap(false)
  userFrame.userNote:SetWordWrap(false)
  if userFrame.itemID ~= nil then
    itemIcon:Hide()
    GameTooltip:Hide()
  end
  if exFrame:IsVisible() then exFrame:Hide() end --userFrame.cost
end
userFrame:SetScript("OnMouseDown",function(self,button) userFrameOnClick(button,userFrame) end)
userFrame:SetScript("OnLeave",userFrame.onLeave)

local function createText(parent,w,h,x,y)
  local t = parent:CreateFontString(nil,"OVERLAY","GameFontHighlight")
  t:SetSize(w,h)
  t:SetPoint("TOPLEFT",x,y)
  t:SetJustifyH("LEFT")
  t:SetWordWrap(false)
  return t
end

userName = createText(userFrame,240,26,6,1)
userName:SetText("z")
userFrame.userNote = createText(userFrame,240,26,6+240+6,1)
userFrame.userNote:SetText("y")

userFrame.userMood = userFrame:CreateTexture(nil,"OVERLAY")
userFrame.userMood:SetSize(14,14)
userFrame.userMood:SetTexture("Interface\\AddOns\\TroveTally\\Assets\\done")
userFrame.userMood:SetPoint("TOPLEFT",492-14-5+24,-5)
userFrame.userMood.color = function(arg1)
  userFrame.color = arg1
  userFrame.userMood:SetVertexColor(unpack(arg1))
end

table.insert(userFrames,userFrame)
return userFrame
end

local main = CreateFrame("Frame")
main:SetScript('OnUpdate',function()
  if register then
    local x,y = GetCursorPosition()
    x = x / UIParent:GetEffectiveScale()
    y = y / UIParent:GetEffectiveScale()
    local cursorPosX,cursorPosY = mainFrameScrollHit:GetCenter()
    cursorPosX = x - cursorPosX
    cursorPosY = y - cursorPosY
    local scrollPos = abs(min(max(cursorPosY,-151.625),151.625) / 303.25 - 0.5)
    --print(scrollPos)
    if scrollPos ~= lastScrollPos then
      lastScrollPos = scrollPos
      local newHandPos = -5.875-34 + scrollPos * -303.25
      mainFrameScrollHand:SetPoint("TOPLEFT",492+5.875+24,newHandPos)

      local maxUsers = #memory[mI] - 14
      if maxUsers > 0 then
        local adjustedValue = maxUsers * scrollPos
        mainFrameScroll(adjustedValue,true,true)
      end
    end
  end
end)

SLASH_TROVE1 = "/trove"
SLASH_TROVE2 = "/tally"
SLASH_TROVE3 = "/trovetally"
SlashCmdList["TROVE"] = function() bigFrame:SetShown(not bigFrame:IsVisible()) end

local loading = {id = nil,i = 1}

local sets = {
  439,488,573,
  422,540,472,507,558,456,332,524,443,445,
  491,494,577,580,425,338,544,547,475,477,
  511,514,561,564,460,463,334,429,527,530,
  --PYTHAGORUS

  438,441,444,3440,
  487,490,493,572,575,578,421,424,427,539,
  542,545,471,474,478,506,510,513,557,560,
  563,455,458,461,331,310,336,523,526,529,
  --DURUS

  440,442,446,
  489,492,495,574,576,579,423,426,428,541,
  543,546,473,476,479,512,508,515,559,562,
  565,457,459,462,333,335,337,525,528,531,
  --AEONICUS

  3422,3421,3420,
  3402,3401,3400,3385,3384,3383,3382,3370,3369,3365,
  --ARTUROS

  3433,3432,
  3431,3430,3419,3418,3417,3416,3399,3398,3397,3379,
  3378,3377,3429,3428,3427,3426,3412,3411,3410,3393,
  3392,3391,3390,3376,3375,3374,3425,3424,3423,3409,
  3408,3407,3406,3389,3388,3387,3386,3373,3372,3371,
  3368,3438,3439,3415,3414,3413,3396,3395,3394,3437,
  3436,3435,3434,3405,3404,3403,3381,3380,
  --LARAH

  3500,3502,3490,3509,3510,3514,
  3504,3496,3492,3494,3506,3508,3498,3499,3501,3489,
  3511,3512,3513,3503,3495,3491,3493,3507,3505,3497
  --JAKKUS
}
local setI = 1

local function setOwned()
  local ids = C_TransmogSets.GetAllSourceIDs(sets[setI])
  setI = setI + 1
  for _,sourceID in ipairs(ids) do
    local info = C_TransmogCollection.GetSourceInfo(sourceID)
    if not info.isCollected then return false end
  end
  return true
end

local function addToList(page,id,text,t,un,s,n,q,specs,spell,link)
  local hex = ITEM_QUALITY_COLORS[q].hex
  local owned = nil
  local known = nil
  if t == 1 then owned = select(11,C_MountJournal.GetMountInfoByID(spell)) --MOUNT
  elseif t == 3 then owned = PlayerHasToy(id) --TOY
  elseif t == 4 then owned = C_Heirloom.PlayerHasHeirloom(id) --HEIRLOOM
  elseif t == 5 then owned = C_PetJournal.GetNumCollectedInfo(spell) > 0 --PET
  elseif specs.s > 0 then
    owned = C_TransmogCollection.PlayerHasTransmog(id)
    if q == 7 then elseif owned then known = owned else
      local transmogID = C_TransmogCollection.GetItemInfo(id)
      local sources = C_TransmogCollection.GetAllAppearanceSources(transmogID)
      if #sources > 1 then
        known = false
        for _,src in ipairs(sources) do
          if C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(src) then
            known = true; break
          end
        end
      end
    end
  else owned = setOwned() end
  table.insert(memory[page],{
    itemID = id,
    spellID = spell,
    text = text,
    name = hex.."["..n.."]",
    itemSpecs = specs,
    owned = owned,
    known = known,
    itemLink = hex.."|Hitem:"..id..link.."|h["..n.."]|h|r",
    t = t,
    un = un,
    s = s,
    uid = uid()
  })
  flags.item[id] = memory[page][#memory[page]]
  if flagType[t] then flagType[t][spell] = flags.item[id] end
end

local lang = 1
if GetLocale() == "esES" or GetLocale() == "esMX" then lang = 2
elseif GetLocale() == "ptBR" then lang = 3
elseif GetLocale() == "deDE" then lang = 4
elseif GetLocale() == "frFR" then lang = 5
elseif GetLocale() == "itIT" then lang = 6
elseif GetLocale() == "ruRU" then lang = 7
elseif GetLocale() == "koKR" then lang = 8
elseif GetLocale() == "zhCN" or GetLocale() == "zhTW" then lang = 9 end

local function loadDB(array,page,src)
  for i = 1,#array,2 do
    local id = array[i]
    local text = array[i + 1]
    local item = type(src[id]) == "table" and src[id] or src[src[id]]
    item.specs.s = -1 --COUNTS AS 0
    for _ in pairs(item.specs) do item.specs.s = item.specs.s + 1 end
    addToList(page,id,text,item.t,item.un,item.s,item.n[lang],item.q,item.specs,item.spell,item.link)
  end
end

local function removeAt(j)
  table.remove(memory[mI],j)
  local maxUsers = #memory[mI] - 14
  local maxScroll = maxUsers * 24
  if maxUsers <= 0 then
    scroll = 0
    mainFrameScroll(0,false,false)
    for i = 1,15 do
      local userFrame = userFrames[i]
      if i == min(#memory[mI],i) then
        userFrame.update(i - 1)
      else userFrame:Hide(); break end
    end
  else
    scroll = max(0,scroll - 24)
    local adjustedValue = scroll / maxScroll * maxUsers
    mainFrameScroll(adjustedValue,true,true)
  end
end

local function checkID(m)
  if m then
    m.owned = true
    if mI == 3 then
      for j,child in ipairs(memory[3]) do
        if child.uid == m.uid then
          if settings.hideOwned then removeAt(j)
          else child.owned = m.owned; updateNote(child,nil,true) end
          titleH[2] = titleH[2] + 1
          local title = string.format("%s (%d/%d)",titleH[1],titleH[2],titleH[3])
          mainFrameHeaderTitle:SetText(title)
          break
        end
      end
    end
    print("|cffFFC000Trove Tally: |cffFFFFFFYou've collected "..m.itemLink)
    PlaySoundFile("Interface\\AddOns\\TroveTally\\Assets\\done.ogg","Master")
  end
end

local links = {}
links.i = 1
local function addLink(link)
  links[links.i] = link
  local i = links.i
  links.i = (links.i % 20) + 1
  return i
end

local firstTime = true
local main = CreateFrame("Frame")

local lootTimer = nil
local lootItems = {}
local function lootUpdate()
  local time = GetServerTime()
  if time >= lootTimer then
    for _,item in ipairs(lootItems) do print(item) end
    lootTimer = nil
    lootItems = {}
    main:SetScript("OnUpdate",nil)
  end
end

local needToLoad = {}
for i = 1,C_AddOns.GetNumAddOns() do
  local loaded,finished = C_AddOns.IsAddOnLoaded(i)
  if loaded and not finished then
    needToLoad[C_AddOns.GetAddOnInfo(i)] = true
  end
end

local function startLoading()
  myGUID = UnitGUID("player")
  populateSpec()
  loadDB(data,1,db.a)
  loadDB(data2,5,db.b)
  loadDB(data3,7,db.c)
  loadDB(data4,8,db.d)
  loadDB(data5,9,db.e)
  loadDB(data6,10,db.f)
  loadDB(data7,12,db.g)
  loadDB(data8,13,db.h)

  for i = 1,15 do
    local userFrame = createUserFrame((i - 1) * -24)
    if i <= #memory[mI] then
      userFrame.update(i - 1)
    else
      userFrame:Hide()
    end
  end
  MerchantFrame:HookScript("OnShow",openMerchant)
  hooksecurefunc("SetMerchantFilter",openMerchant)
  hooksecurefunc("MerchantFrame_UpdateMerchantInfo",updateMerchant)
end

local typeMap = {
  [2] = {
    [0]=1,[1]=2,[2]=3,[3]=4,[4]=5,[5]=6,[6]=7,[7]=8,[8]=9,[9]=10,
    [10]=11,[13]=12,[15]=13,[18]=14,[19]=15
  },
  [4] = {
    [0]=16,[1]=17,[2]=18,[3]=19,[4]=20,[6]=21
  }
}
local function getType(itemType,itemSubType)
  local check = typeMap[itemType]
  if check then return check[itemSubType] end
  return nil
end

local function addNotification(arg1,arg2,m,id)
  local check = true
  local color = arg1:match("|c(.-)|")
  local link = arg1:match("|c.-|r")
  local sub,owned
  if m then sub = m.s; owned = m.owned
  else
    sub = C_TransmogCollection.GetItemInfo(id) and getType(select(12,C_Item.GetItemInfo(id))) or nil
    owned = C_TransmogCollection.PlayerHasTransmog(id)
  end
  if canLearn[settings.trade == 1 and 14 or playerClass.index][sub] ~= nil and not owned and (color == "ff0070dd" or color == "ffa335ee") then
    local whisper = "|cffFF80FF|Haddon:TroveTally:"..addLink(link)..":"..arg2.."|h[密語詢問是否願意交易?]|h|r"
    local message = "|cffFFC000Trove Tally: |cffFFFFFF"..(arg2:match("(.-)%-") or arg2).." 收集了未知的外觀 "..link..". "..whisper
    if settings.instant then print(message)
    else
      if lootTimer == nil then
        lootTimer = GetServerTime() + 5
        check = false
        main:SetScript("OnUpdate",lootUpdate)
      end
      table.insert(lootItems,message)
    end
  end
  if check and lootTimer ~= nil then lootTimer = GetServerTime() + 5 end
end

main:RegisterEvent("ADDON_LOADED")
main:RegisterEvent("FIRST_FRAME_RENDERED")
main:RegisterEvent("TRANSMOG_COLLECTION_SOURCE_ADDED")
main:RegisterEvent("GET_ITEM_INFO_RECEIVED")
main:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
main:RegisterEvent("NEW_MOUNT_ADDED")
main:RegisterEvent("NEW_TOY_ADDED")
main:RegisterEvent("HEIRLOOMS_UPDATED")
main:RegisterEvent("NEW_PET_ADDED")
main:RegisterEvent("CHAT_MSG_LOOT")
main:SetScript("OnEvent",function(self,event,arg1,arg2,arg3,...)
  if event == "ADDON_LOADED" and needToLoad[arg1] then
    if arg1 == "TroveTally" then
      iconDegrees = iconDegrees or 45
      settings = settings or {hideOwned = false,hideIcon = false,hideMerchant = true}
      if settings.hideMerchant == nil then settings.hideMerchant = true end
      if settings.trade == nil or settings.trade == true then settings.trade = 1 end
      if settings.instant == nil then settings.instant = false end
      if settings.custom == nil then settings.custom = false end
      if settings.hideUnobt == nil then settings.hideUnobt = false end
      if settings.unlisted == nil then settings.unlisted = false end
      if settings.hideKnown == nil then settings.hideKnown = false end
      if settings.hideIcon then iconButton:Hide() end
      memory[4][1] = {itemID = nil,text = (settings.custom == false) and "已停用" or settings.custom,name = "自訂訊息",specID = -13,uid = uid()}
      memory[4][2] = {itemID = nil,text = state[settings.instant],name = "即時通知",specID = -12,uid = uid()}
      memory[4][3] = {itemID = nil,text = state[settings.unlisted],name = "通知未列出物品",specID = -17,uid = uid()}
      memory[4][4] = {itemID = nil,text = state[settings.trade],name = "可交易掉落物通知",specID = -8,uid = uid()}
      memory[4][5] = {itemID = nil,text = state[settings.hideIcon],name = "隱藏小地圖按鈕",specID = -5,uid = uid()}
      memory[4][6] = {itemID = nil,text = state[settings.hideMerchant],name = "隱藏商人處收集的物品",specID = -7,uid = uid()}
      memory[4][7] = {itemID = nil,text = state[settings.hideUnobt],name = "隱藏無法獲得的物品",specID = -16,uid = uid()}
      memory[4][8] = {itemID = nil,text = state[settings.hideKnown],name = "隱藏已收集的塑形",specID = -22,uid = uid()}
      memory[4][9] = {itemID = nil,text = state[settings.hideOwned],name = "隱藏已收集的物品",specID = -4,uid = uid()}
      setIconPos(iconDegrees)
    end
    needToLoad[arg1] = nil
    if #needToLoad == 0 and not firstTime then startLoading() end
  elseif event == "FIRST_FRAME_RENDERED" and firstTime then
    firstTime = false
    if #needToLoad == 0 then startLoading() end
  elseif event == "TRANSMOG_COLLECTION_SOURCE_ADDED" then
    local sourceInfo = C_TransmogCollection.GetSourceInfo(arg1)
    if sourceInfo then checkID(flags.item[sourceInfo.itemID]) end
  --elseif event == "GET_ITEM_INFO_RECEIVED" then gotdata(arg1)
  elseif event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" then checkID(flags.spell[arg3])
  elseif event == "NEW_MOUNT_ADDED" then checkID(flags.mount[arg1])
  elseif event == "NEW_TOY_ADDED" then checkID(flags.item[arg1])
  elseif event == "HEIRLOOMS_UPDATED" and arg2 == "NEW" then checkID(flags.item[arg1])
  elseif event == "NEW_PET_ADDED" then
    local speciesID = C_PetJournal.GetPetInfoByPetID(arg1)
    if C_PetJournal.GetNumCollectedInfo(speciesID) == 1 then checkID(flags.pet[speciesID]) end
  elseif event == "CHAT_MSG_LOOT" then
    if settings.trade and select(9,...) ~= myGUID then
      local id = tonumber(arg1:match("item:(%d+):"))
      local m = flags.item[id]
      if m and m.s then addNotification(arg1,arg2,m); return end
      if not settings.unlisted then if lootTimer ~= nil then lootTimer = GetServerTime() + 5 end return end
      local item = Item:CreateFromItemID(id)
      item:ContinueOnItemLoad(function() addNotification(arg1,arg2,nil,id) end)
    end
  end
end)

hooksecurefunc("SetItemRef",function(link)
	local linkType,addon,i,player = strsplit(":",link)
	if linkType == "addon" and addon == "TroveTally" then
    local message = (settings.custom == false) and default or settings.custom
    SendChatMessage(string.gsub(message,"%$",links[tonumber(i)]),"WHISPER",nil,player)
	end
end)