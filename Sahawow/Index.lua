-- Sahawow 2024-7-25

local AddonName, AddonTable = ...
local Name, Title, Description = C_AddOns.GetAddOnInfo(AddonName)
local Version = C_AddOns.GetAddOnMetadata(AddonName, "Version")
local SoundPack = SuperDuperSoundPackEngine.Register(Name, Title, Description, Version)
if not SoundPack then return end
local PRIEST = "Interface\\AddOns\\"..AddonName.."\\Sounds\\Priest\\"
local SOUND = "Interface\\AddOns\\"..AddonName.."\\Sounds\\"
local MUSIC = "Interface\\AddOns\\"..AddonName.."\\Music\\"
local BOSS = "Interface\\AddOns\\"..AddonName.."\\Music\\01\\"
local SWIMMING = "Interface\\AddOns\\"..AddonName.."\\Music\\02\\"
local FLYING = "Interface\\AddOns\\"..AddonName.."\\Music\\03\\"
local VEHICLE = "Interface\\AddOns\\"..AddonName.."\\Music\\04\\"
local DUNGEON = "Interface\\AddOns\\"..AddonName.."\\Music\\05\\"
local DB = "Interface\\AddOns\\"..AddonName.."\\Music\\06\\"
local BATTLE = "Interface\\AddOns\\"..AddonName.."\\Music\\07\\"
local RESTING = "Interface\\AddOns\\"..AddonName.."\\Music\\08\\"
local MOUNTED = "Interface\\AddOns\\"..AddonName.."\\Music\\09\\"
local OVERWORLD = "Interface\\AddOns\\"..AddonName.."\\Music\\10\\"



SoundPack.start_up = {
	SOUND.."001_1開機GT_welcome.mp3",
	SOUND.."001_2開機GT_welcome.mp3",
	SOUND.."001_3開機GT_welcome.mp3",
	SOUND.."001_Goodmorning.mp3",
	SOUND.."001_MissGT_welcomeSAHAWOW.ogg",
	SOUND.."001_PS開機GT_welcome.mp3",
	SOUND.."001_點點和朵朵_welcome.mp3"
}


SoundPack.enter_or_leave_pve_instance = {
	SOUND.."002_10kwai.mp3",
	SOUND.."002_meijian_dendenden.mp3",
	SOUND.."002_this.mp3",
	SOUND.."002_小妹妹這裡有很多好東西.mp3"
}


SoundPack.toggle_game_or_options_menu = SOUND.."005_001.ogg"


SoundPack.slash_command_or_option_save = SOUND.."006_001.ogg"


SoundPack.mount = SOUND.."007_se_maoudamashii_se_car05.ogg"


SoundPack.dismount = {
	SOUND.."008_cgmon00b.mp3",
	SOUND.."008_cgmon00b.mp3",
	SOUND.."008_cgmon00b.mp3",
	SOUND.."008_cgmon00b.mp3",
	SOUND.."008_廣志停車.mp3"
}


SoundPack.kill_shot = SOUND.."009_cgbtl06.ogg"


SoundPack.shape_shift = SOUND.."010_R_change.ogg"


SoundPack.buff_on_self = {
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_powerup_cgefc34.ogg",
	SOUND.."011_GetBuffSoHappy.ogg"
}


SoundPack.debuff_on_self = SOUND.."012_powerdown07.mp3"


SoundPack.target_spell_damage_from_self = {
	SOUND.."013_cgefc12.ogg",
	SOUND.."013_cgefc13.ogg",
	SOUND.."013_cgefc15.ogg",
	SOUND.."013_cgefc17.ogg"
}


SoundPack.target_swing_damage_from_self = {
	SOUND.."014_cgmon_bh1.mp3",
	SOUND.."014_cgmon_bh2.mp3",
	SOUND.."014_cgmon_bh3.mp3",
	SOUND.."014_cgmon_bh4.mp3",
	SOUND.."014_cgmon_bs1.mp3",
	SOUND.."014_cgmon_bs2.mp3",
	SOUND.."014_cgmon_bs3.mp3",
	SOUND.."014_cgmon_bs4.mp3"
}


SoundPack.target_range_damage_from_self = SOUND.."015_cgply06a2.mp3"


SoundPack.honor_or_xp_gained = SOUND.."016_cgefc00.mp3"


SoundPack.skill_increase = SOUND.."017_cgsys12.mp3"


SoundPack.level_up_ding = SOUND.."018_38make_gild.mp3"


SoundPack.swim = SOUND.."021_cgmon50a.mp3"
SoundPack.swim_repeat_time = 0.8

SoundPack.jump_max_repeat_time = 0.6

SoundPack.regular_jump = {
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_MissGT_Jump_01.ogg",
	SOUND.."022_MissGT_Jump_02.ogg",
	SOUND.."022_MissGT_Jump_03.ogg",
	SOUND.."022_MissGT_Jump_05.ogg",
	SOUND.."022_wululu.mp3"
}


SoundPack.mounted_jump = SOUND.."023_彈簧音02.mp3"


SoundPack.gnome_jump = {
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_MissGT_Jump_01.ogg",
	SOUND.."022_MissGT_Jump_02.ogg",
	SOUND.."022_MissGT_Jump_03.ogg",
	SOUND.."022_MissGT_Jump_05.ogg",
	SOUND.."022_wululu.mp3"
}

SoundPack.elf_jump = {
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_jump12.mp3",
	SOUND.."022_MissGT_Jump_01.ogg",
	SOUND.."022_MissGT_Jump_02.ogg",
	SOUND.."022_MissGT_Jump_03.ogg",
	SOUND.."022_MissGT_Jump_05.ogg",
	SOUND.."022_wululu.mp3"
}

SoundPack.group_wipe = SOUND.."026_v2bgm_ex.mp3"
SoundPack.group_wipe_play_time = 6
SoundPack.group_wipe_delay_time = 0


SoundPack.helped_kill_a_player = SOUND.."028_se_maoudamashii_voice_human01.ogg"
SoundPack.helped_kill_a_player_delay_time = 1


SoundPack.self_died = {
	SOUND.."029_Consequence.mp3",
	SOUND.."029_Dysfunction.mp3",
	SOUND.."029_Gameover.mp3",
	SOUND.."029_holyshit.mp3",
	SOUND.."029_R_die.ogg",
	SOUND.."029_什麼意思.mp3",
	SOUND.."029_哭哭音效01.mp3"
}
SoundPack.self_died_delay_time = 0


SoundPack.achievement_earned = SOUND.."033_puk3_orgel.mp3"
SoundPack.achievement_earned_play_time = 3
SoundPack.achievement_earned_delay_time = 0

--牧師


SoundPack.my_spell_cast["121536"] = PRIEST.."001_天使之羽121536.mp3"

SoundPack.my_spell_cast["2006"] = PRIEST.."002_復活術2006.mp3"

SoundPack.my_spell_cast["212036"] = PRIEST.."003_群體復活212036.mp3"

SoundPack.my_spell_cast["2096"] = PRIEST.."004_心靈幻象2096.mp3"

SoundPack.my_spell_cast["1706"] = PRIEST.."005_漂浮術1706.mp3"

SoundPack.my_spell_cast["586"] = PRIEST.."006_漸隱術586.mp3"

SoundPack.my_spell_cast["605"] = PRIEST.."007_精神控制605.mp3"

SoundPack.my_spell_cast["73325"] = PRIEST.."008_虔信之躍73325.mp3"

SoundPack.my_spell_cast["528"] = PRIEST.."009_驅散魔法528.mp3"

SoundPack.my_spell_cast["527"] = PRIEST.."010_驅淨術527.mp3"

SoundPack.my_spell_cast["32375"] = PRIEST.."011_群體驅魔32375.mp3"

SoundPack.my_spell_cast["8122"] = PRIEST.."012_心靈尖嘯8122.mp3"

SoundPack.my_spell_cast["19236"] = PRIEST.."013_絕望禱言19236.mp3"

SoundPack.my_spell_cast["204263"] = PRIEST.."014_閃耀聖力204263.mp3"

SoundPack.my_spell_cast["9484"] = PRIEST.."015_束縛不死生物9484.mp3"

SoundPack.my_spell_cast["132157"] = {
	PRIEST.."103MS_01.mp3",
	PRIEST.."103MS_02.mp3",
	PRIEST.."103MS_03.mp3",
	PRIEST.."103MS_04.mp3",
	PRIEST.."103MS_05.mp3",
	PRIEST.."103MS_06.mp3",
	PRIEST.."103MS_07.mp3",
	PRIEST.."103MS_08.mp3",
	PRIEST.."103MS_09.mp3",
	PRIEST.."103MS_10.mp3",
	PRIEST.."103MS_11.mp3",
	PRIEST.."103MS_12.mp3",
	PRIEST.."103MS_13.mp3",
	PRIEST.."103MS_14.mp3",
	PRIEST.."103MS_15.mp3",
	PRIEST.."103MS_16.mp3",
	PRIEST.."103MS_17.mp3",
	PRIEST.."103MS_18.mp3"
}

SoundPack.my_spell_cast["110744"] = PRIEST.."017_神性之星110744.mp3"

SoundPack.my_spell_cast["122121"] = PRIEST.."017a_神性之星122121.mp3"

SoundPack.my_spell_cast["120517"] = PRIEST.."018_輝環120517.mp3"

SoundPack.my_spell_cast["120644"] = PRIEST.."018a_輝環120644.mp3"

SoundPack.my_spell_cast["375901"] = PRIEST.."019_玩弄心智375901.mp3"

SoundPack.my_spell_cast["108920"] = PRIEST.."020_虛無觸鬚108920.mp3"

SoundPack.my_spell_cast["108968"] = PRIEST.."021_虛空移形108968.mp3"

SoundPack.my_spell_cast["373481"] = PRIEST.."022_真言術：命373481.mp3"

SoundPack.my_spell_cast["205364"] = PRIEST.."023_支配心智205364.mp3"

SoundPack.my_spell_cast["453"] = PRIEST.."024_安撫心靈453.mp3"





SoundPack.my_spell_cast["47788"] = PRIEST.."101_守護聖靈47788.mp3"

SoundPack.my_spell_cast["64901"] = PRIEST.."102_希望象徵64901.mp3"

SoundPack.my_spell_cast["2061"] = {
	PRIEST.."103MS_01.mp3",
	PRIEST.."103MS_02.mp3",
	PRIEST.."103MS_03.mp3",
	PRIEST.."103MS_04.mp3",
	PRIEST.."103MS_05.mp3",
	PRIEST.."103MS_06.mp3",
	PRIEST.."103MS_07.mp3",
	PRIEST.."103MS_08.mp3",
	PRIEST.."103MS_09.mp3",
	PRIEST.."103MS_10.mp3",
	PRIEST.."103MS_11.mp3",
	PRIEST.."103MS_12.mp3",
	PRIEST.."103MS_13.mp3",
	PRIEST.."103MS_14.mp3",
	PRIEST.."103MS_15.mp3",
	PRIEST.."103MS_16.mp3",
	PRIEST.."103MS_17.mp3",
	PRIEST.."103MS_18.mp3"
}

SoundPack.my_spell_cast["32546"] = {
	PRIEST.."103MS_01.mp3",
	PRIEST.."103MS_02.mp3",
	PRIEST.."103MS_03.mp3",
	PRIEST.."103MS_04.mp3",
	PRIEST.."103MS_05.mp3",
	PRIEST.."103MS_06.mp3",
	PRIEST.."103MS_07.mp3",
	PRIEST.."103MS_08.mp3",
	PRIEST.."103MS_09.mp3",
	PRIEST.."103MS_10.mp3",
	PRIEST.."103MS_11.mp3",
	PRIEST.."103MS_12.mp3",
	PRIEST.."103MS_13.mp3",
	PRIEST.."103MS_14.mp3",
	PRIEST.."103MS_15.mp3",
	PRIEST.."103MS_16.mp3",
	PRIEST.."103MS_17.mp3",
	PRIEST.."103MS_18.mp3"
}

SoundPack.my_spell_cast["139"] = {
	PRIEST.."103MS_01.mp3",
	PRIEST.."103MS_02.mp3",
	PRIEST.."103MS_03.mp3",
	PRIEST.."103MS_04.mp3",
	PRIEST.."103MS_05.mp3",
	PRIEST.."103MS_06.mp3",
	PRIEST.."103MS_07.mp3",
	PRIEST.."103MS_08.mp3",
	PRIEST.."103MS_09.mp3",
	PRIEST.."103MS_10.mp3",
	PRIEST.."103MS_11.mp3",
	PRIEST.."103MS_12.mp3",
	PRIEST.."103MS_13.mp3",
	PRIEST.."103MS_14.mp3",
	PRIEST.."103MS_15.mp3",
	PRIEST.."103MS_16.mp3",
	PRIEST.."103MS_17.mp3",
	PRIEST.."103MS_18.mp3"
}

SoundPack.my_spell_cast["585"] = {
	PRIEST.."103MS_01.mp3",
	PRIEST.."103MS_02.mp3",
	PRIEST.."103MS_03.mp3",
	PRIEST.."103MS_04.mp3",
	PRIEST.."103MS_05.mp3",
	PRIEST.."103MS_06.mp3",
	PRIEST.."103MS_07.mp3",
	PRIEST.."103MS_10.mp3",
	PRIEST.."103MS_11.mp3",
	PRIEST.."103MS_17.mp3",
	PRIEST.."103MS_18.mp3"
}

SoundPack.my_spell_cast["204883"] = PRIEST.."107_治療之環204883.mp3"

SoundPack.my_spell_cast["596"] = PRIEST.."108_治療禱言596.mp3"

SoundPack.my_spell_cast["2060"] = {
	PRIEST.."109_治療術2060.mp3",
	PRIEST.."103MS_08.mp3",
	PRIEST.."103MS_09.mp3",
	PRIEST.."103MS_12.mp3",
	PRIEST.."103MS_13.mp3",
	PRIEST.."103MS_14.mp3",
	PRIEST.."103MS_15.mp3",
	PRIEST.."103MS_16.mp3"
}

SoundPack.my_spell_cast["33076"] = PRIEST.."110_癒合禱言33076.mp3"

SoundPack.my_spell_cast["21562"] = PRIEST.."111_真言術：韌21562.mp3"

SoundPack.my_spell_cast["14914"] = PRIEST.."112_神聖之火14914.mp3"

SoundPack.my_spell_cast["64843"] = PRIEST.."113_神聖禮頌64843.mp3"

SoundPack.my_spell_cast["2050"] = PRIEST.."114_聖言術：寧2050.mp3"

SoundPack.my_spell_cast["34861"] = PRIEST.."115_聖言術：庇34861.mp3"

SoundPack.my_spell_cast["88625"] = PRIEST.."116_聖言術：譴88625.mp3"

SoundPack.my_spell_cast["265202"] = PRIEST.."117_聖言術：贖265202.mp3"

SoundPack.my_spell_cast["200183"] = PRIEST.."118_神化200183.mp3"

SoundPack.my_spell_cast["372835"] = PRIEST.."119_光束泉372835.mp3"

SoundPack.my_spell_cast["372760"] = PRIEST.."120_神言術372760.mp3"

SoundPack.my_spell_cast["372616"] = PRIEST.."121_至高烈焰372616.mp3"




SoundPack.my_spell_cast["214621"] = PRIEST.."201_暗影分裂214621.mp3"


SoundPack.my_spell_cast["47540"] = PRIEST.."203_懺悟47540.mp3"

SoundPack.my_spell_cast["47536"] = PRIEST.."204_狂喜47536.mp3"

SoundPack.my_spell_cast["33206"] = PRIEST.."205_痛苦鎮壓33206.mp3"

SoundPack.my_spell_cast["62618"] = PRIEST.."206_真言術：壁62618.mp3"

SoundPack.my_spell_cast["271466"] = PRIEST.."206_真言術：壁62618.mp3"

SoundPack.my_spell_cast["129250"] = PRIEST.."208_真言術：慰129250.mp3"

SoundPack.my_spell_cast["17"] = {
	PRIEST.."103MS_01.mp3",
	PRIEST.."103MS_02.mp3",
	PRIEST.."103MS_03.mp3",
	PRIEST.."103MS_04.mp3",
	PRIEST.."103MS_05.mp3",
	PRIEST.."103MS_06.mp3",
	PRIEST.."103MS_07.mp3",
	PRIEST.."103MS_10.mp3",
	PRIEST.."103MS_11.mp3",
	PRIEST.."103MS_17.mp3",
	PRIEST.."103MS_18.mp3"
}

SoundPack.my_spell_cast["194509"] = PRIEST.."210_真言術：輝194509.mp3"

SoundPack.my_spell_cast["34433"] = PRIEST.."211_暗影惡魔34433.mp3"

SoundPack.my_spell_cast["123040"] = PRIEST.."212_屈心魔－戒律用123040.mp3"

SoundPack.my_spell_cast["589"] = {
	PRIEST.."103MS_01.mp3",
	PRIEST.."103MS_02.mp3",
	PRIEST.."103MS_03.mp3",
	PRIEST.."103MS_04.mp3",
	PRIEST.."103MS_05.mp3",
	PRIEST.."103MS_06.mp3",
	PRIEST.."103MS_07.mp3",
	PRIEST.."103MS_10.mp3",
	PRIEST.."103MS_11.mp3",
	PRIEST.."103MS_17.mp3",
	PRIEST.."103MS_18.mp3"
}

SoundPack.my_spell_cast["204065"] = {
	PRIEST.."103MS_01.mp3",
	PRIEST.."103MS_02.mp3",
	PRIEST.."103MS_03.mp3",
	PRIEST.."103MS_04.mp3",
	PRIEST.."103MS_05.mp3",
	PRIEST.."103MS_06.mp3",
	PRIEST.."103MS_07.mp3",
	PRIEST.."103MS_08.mp3",
	PRIEST.."103MS_09.mp3",
	PRIEST.."103MS_10.mp3",
	PRIEST.."103MS_11.mp3",
	PRIEST.."103MS_12.mp3",
	PRIEST.."103MS_13.mp3",
	PRIEST.."103MS_14.mp3",
	PRIEST.."103MS_15.mp3",
	PRIEST.."103MS_16.mp3",
	PRIEST.."103MS_17.mp3",
	PRIEST.."103MS_18.mp3"
}

SoundPack.my_spell_cast["314867"] = PRIEST.."214a_暗影聖約314867.mp3"

SoundPack.my_spell_cast["246287"] = PRIEST.."215_佈道246287.mp3"

SoundPack.my_spell_cast["254224"] = PRIEST.."211_暗影惡魔34433.mp3"

SoundPack.my_spell_cast["186263"] = {
	PRIEST.."103MS_01.mp3",
	PRIEST.."103MS_02.mp3",
	PRIEST.."103MS_03.mp3",
	PRIEST.."103MS_04.mp3",
	PRIEST.."103MS_05.mp3",
	PRIEST.."103MS_06.mp3",
	PRIEST.."103MS_07.mp3",
	PRIEST.."103MS_08.mp3",
	PRIEST.."103MS_09.mp3",
	PRIEST.."103MS_10.mp3",
	PRIEST.."103MS_11.mp3",
	PRIEST.."103MS_12.mp3",
	PRIEST.."103MS_13.mp3",
	PRIEST.."103MS_14.mp3",
	PRIEST.."103MS_15.mp3",
	PRIEST.."103MS_16.mp3",
	PRIEST.."103MS_17.mp3",
	PRIEST.."103MS_18.mp3"
}

SoundPack.my_spell_cast["400169"] = PRIEST.."218_黑暗責罰400169.mp3"

SoundPack.my_spell_cast["271466"] = PRIEST.."219_光輝屏障271466.mp3"

SoundPack.my_spell_cast["373178"] = PRIEST.."220_聖光之怒373178.mp3"

SoundPack.my_spell_cast["421453"] = PRIEST.."221_終極懺罪421453.mp3"




SoundPack.my_spell_cast["34914"] = {
	PRIEST.."103MS_01.mp3",
	PRIEST.."103MS_02.mp3",
	PRIEST.."103MS_03.mp3",
	PRIEST.."103MS_04.mp3",
	PRIEST.."103MS_05.mp3",
	PRIEST.."103MS_06.mp3",
	PRIEST.."103MS_07.mp3",
	PRIEST.."103MS_10.mp3",
	PRIEST.."103MS_11.mp3",
	PRIEST.."103MS_17.mp3",
	PRIEST.."103MS_18.mp3"
}

SoundPack.my_spell_cast["15286"] = PRIEST.."302_吸血鬼的擁抱15286.mp3"

SoundPack.my_spell_cast["47585"] = PRIEST.."302_吸血鬼的擁抱15286.mp3"

SoundPack.my_spell_cast["48045"] = {
	PRIEST.."103MS_01.mp3",
	PRIEST.."103MS_02.mp3",
	PRIEST.."103MS_03.mp3",
	PRIEST.."103MS_04.mp3",
	PRIEST.."103MS_05.mp3",
	PRIEST.."103MS_06.mp3",
	PRIEST.."103MS_07.mp3",
	PRIEST.."103MS_10.mp3",
	PRIEST.."103MS_11.mp3",
	PRIEST.."103MS_17.mp3",
	PRIEST.."103MS_18.mp3"
}

SoundPack.my_spell_cast["8092"] = PRIEST.."305_心靈震爆8092.mp3"

SoundPack.my_spell_cast["205351"] = PRIEST.."306_暗言術：無205351.mp3"

SoundPack.my_spell_cast["205369"] = PRIEST.."307_心靈炸彈205369.mp3"

SoundPack.my_spell_cast["232698"] = PRIEST.."308_暗影型態232698.mp3"

SoundPack.my_spell_cast["200174"] = PRIEST.."212_屈心魔－戒律用123040.mp3"

SoundPack.my_spell_cast["263165"] = PRIEST.."310_虛無洪流263165.mp3"

SoundPack.my_spell_cast["589"] = {
	PRIEST.."103MS_01.mp3",
	PRIEST.."103MS_02.mp3",
	PRIEST.."103MS_03.mp3",
	PRIEST.."103MS_04.mp3",
	PRIEST.."103MS_05.mp3",
	PRIEST.."103MS_06.mp3",
	PRIEST.."103MS_07.mp3",
	PRIEST.."103MS_10.mp3",
	PRIEST.."103MS_11.mp3",
	PRIEST.."103MS_17.mp3",
	PRIEST.."103MS_18.mp3"
}

SoundPack.my_spell_cast["32379"] = PRIEST.."312_暗言術：死32379.mp3"

SoundPack.my_spell_cast["205385"] = PRIEST.."313_暗影暴擊205385.mp3"

SoundPack.my_spell_cast["15487"] = PRIEST.."314_沉默15487.mp3"

SoundPack.my_spell_cast["15407"] = PRIEST.."315_精神鞭笞15407.mp3"

SoundPack.my_spell_cast["391403"] = PRIEST.."315_精神鞭笞15407.mp3"

SoundPack.my_spell_cast["263346"] = PRIEST.."316_虛無暗爆263346.mp3"

SoundPack.my_spell_cast["228260"] = PRIEST.."317_虛無爆發228260.mp3"

SoundPack.my_spell_cast["205448"] = PRIEST.."318_虛無箭205448.mp3"

SoundPack.my_spell_cast["213634"] = PRIEST.."319_驅淨疾病213634.mp3"

SoundPack.my_spell_cast["280711"] = PRIEST.."320_黑暗異變280711.mp3"

SoundPack.my_spell_cast["391109"] = PRIEST.."320_黑暗異變280711.mp3"

SoundPack.my_spell_cast["193223"] = PRIEST.."321_獻身瘋狂193223.mp3"

SoundPack.my_spell_cast["64044"] = PRIEST.."322_心靈恐慌64044.mp3"

SoundPack.my_spell_cast["73510"] = PRIEST.."315_精神鞭笞15407.mp3"

SoundPack.my_spell_cast["407466"] = PRIEST.."315_精神鞭笞15407.mp3"

SoundPack.my_spell_cast["335467"] = PRIEST.."323_噬靈瘟疫335467.mp3"

--
--SoundPack.my_spell_cast[""] = SOUND..".mp3"
--
--SoundPack.my_spell_cast[""] = PRIEST..".mp3"



SoundPack.my_spell_cast["688"] = {
	SOUND.."051術士-召喚小鬼.mp3",
	SOUND.."051術士-召喚小鬼-2.mp3"
}
SoundPack.my_spell_cast["697"] = {
	SOUND.."051術士-召喚虛無行者-01.mp3",
	SOUND.."051術士-召喚虛無行者-02.mp3",
	SOUND.."051術士-召喚虛無行者-03.mp3"
}
SoundPack.my_spell_cast["712"] = {
	SOUND.."051術士-召喚魅魔-01.mp3",
	SOUND.."051術士-召喚魅魔-02.mp3",
	SOUND.."051術士-召喚魅魔-03.mp3"
}
SoundPack.my_spell_cast["30146"] = {
	SOUND.."051術士-召喚惡魔守衛-01.mp3",
	SOUND.."051術士-召喚惡魔守衛-02.mp3",
	SOUND.."051術士-召喚惡魔守衛-03.mp3"
}
SoundPack.my_spell_cast["265187"] = {
	SOUND.."051術士-召喚惡魔暴君-01.mp3",
	SOUND.."051術士-召喚惡魔暴君-02.mp3"
}
SoundPack.my_spell_cast["205180"] = SOUND.."051術士-召喚暗凝.mp3"
SoundPack.my_spell_cast["1122"] = SOUND.."051術士-召喚煉獄火.mp3"

SoundPack.my_spell_cast["105174"] = {
	SOUND.."051術士-古爾丹之手-01.mp3",
	SOUND.."051術士-古爾丹之手-02.mp3"
}

SoundPack.my_spell_cast["267217"] = SOUND.."051術士-虛空傳送門.mp3"

SoundPack.reset_multi_track_music_delay_time = 300
SoundPack.targeted_boss_low_health_percent = 100





SoundPack.music_targeted_boss_with_low_health = {
	{
		File = BOSS.."FE Dragon Castle.mp3",
		Time = 300,
	},
	{
		File = BOSS.."NightWish Last Ride Of The Day C_DanVasc.mp3",
		Time = 300,
	},
	{
		File = BOSS.."Shimatani Hitomi 深紅 C_Keith.mp3",
		Time = 300,
	},
	{
		File = BOSS.."ToS_10.0Boss.mp3",
		Time = 300,
	},
	{
		File = BOSS.."ToS_B.Duck.mp3",
		Time = 300,
	},
	{
		File = BOSS.."ToS_Boss.mp3",
		Time = 300,
	},
	{
		File = BOSS.."ToS_FinalBattle+2.mp3",
		Time = 300,
	},
	{
		File = BOSS.."ToS_Monster Strike.mp3",
		Time = 300,
	},
	{
		File = BOSS.."Vanessa Mae Contradanza C_DavidLuis77.mp3",
		Time = 300,
	},
	{
		File = BOSS.."一拳超人 正義執行 C_HoonjinPARK.mp3",
		Time = 300,
	},
	{
		File = BOSS.."七龍珠 Batalla de Freezer.mp3",
		Time = 300,
	},
	{
		File = BOSS.."七龍珠超 極限突破×倖存者 C_MattyyyM.mp3",
		Time = 300,
	},
	{
		File = BOSS.."不死者之王 HOLLOW HUNGER C_MattyyyM.mp3",
		Time = 300,
	},
	{
		File = BOSS.."火影忍者 Blue Bird C_MattyyyM.mp3",
		Time = 300,
	},
	{
		File = BOSS.."石器時代 Boss.mp3",
		Time = 300,
	},
	{
		File = BOSS.."吞食天地 Boss.mp3",
		Time = 300,
	},
	{
		File = BOSS.."我推的孩子 Idol C_MattyyyM.mp3",
		Time = 300,
	},
	{
		File = BOSS.."秀逗魔導士 Breeze C_KY.mp3",
		Time = 300,
	},
	{
		File = BOSS.."秀逗魔導士 Breeze+2 C_HoonjinPARK.mp3",
		Time = 300,
	},
	{
		File = BOSS.."秀逗魔導士 Get along C_Gunbard.mp3",
		Time = 300,
	},
	{
		File = BOSS.."幽遊白書 Monster Suite.mp3",
		Time = 300,
	},
	{
		File = BOSS.."洛克人 Boss Battle 3 & C_MaximZhuravlev.mp3",
		Time = 300,
	},
	{
		File = BOSS.."洛克人 Boss Battle 3 & C_MaximZhuravlev.mp3",
		Time = 300,
	},
	{
		File = BOSS.."洛克人 Boss Battle 4.mp3",
		Time = 300,
	},
	{
		File = BOSS.."洛克人 Boss Battle X4 ＆ C_LennyLederman.mp3",
		Time = 300,
	},
	{
		File = BOSS.."洛克人 打不倒的空氣人 C_HoonjinPARK.mp3",
		Time = 300,
	},
	{
		File = BOSS.."盾之勇者成名錄 RISE C_MattyyyM.mp3",
		Time = 300,
	},
	{
		File = BOSS.."科學超電磁砲 Only my railgun C_SPIRITSOULX.mp3",
		Time = 300,
	},
	{
		File = BOSS.."鬥球兒彈平 嵐 C_Guitar_tab_master.mp3",
		Time = 300,
	},
	{
		File = BOSS.."鳥人戰隊 Boss Battle C_Eliseev Mikhail.mp3",
		Time = 300,
	},
	{
		File = BOSS.."鳥人戰隊 Final Boss C_DJ KAMEYA.mp3",
		Time = 300,
	},
	{
		File = BOSS.."最終幻想9 Battle 2.mp3",
		Time = 300,
	},
	{
		File = BOSS.."最終幻想13-2 Last Hunter C_RetroDrummer.mp3",
		Time = 300,
	},
	{
		File = BOSS.."最終幻想13-2 Last Hunter C_ToxicxEternity.mp3",
		Time = 300,
	},
	{
		File = BOSS.."最終幻想14 The Diablo Armament's Theme C_HuskybytheGeek.mp3",
		Time = 300,
	},
	{
		File = BOSS.."最終幻想14 The Diablo Armament's Theme C_月島真季.mp3",
		Time = 300,
	},
	{
		File = BOSS.."超級瑪利歐RPG BOSS Axem Rangers 危險的戶愚呂兄.mp3",
		Time = 300,
	},
	{
		File = BOSS.."超級瑪利歐RPG BOSS Axem Rangers.mp3",
		Time = 300,
	},
	{
		File = BOSS.."進擊的巨人 My War C_MattyyyM.mp3",
		Time = 300,
	},
	{
		File = BOSS.."聖鬥士星矢 天馬座幻想 C_Guitar_tab_master.mp3",
		Time = 300,
	},
	{
		File = BOSS.."遊戲王Forbidden Memories Free Duel Theme.mp3",
		Time = 300,
	},
	{
		File = BOSS.."夢幻模擬戰2 Last Battle.mp3",
		Time = 300,
	},
	{
		File = BOSS.."機戰 Armageddon F.mp3",
		Time = 300,
	},
	{
		File = BOSS.."機戰 Awake Zeorymer.mp3",
		Time = 300,
	},
	{
		File = BOSS.."機戰 Char C_leinamovie.mp3",
		Time = 300,
	},
	{
		File = BOSS.."﻿機戰 Dark Prison OGs.mp3",
		Time = 300,
	},
	{
		File = BOSS.."機戰 Desire OG2nd.mp3",
		Time = 300,
	},
	{
		File = BOSS.."機戰 Genocide machine II OG2nd.mp3",
		Time = 300,
	},
	{
		File = BOSS.."機戰 LOST CHILDREN OG2nd.mp3",
		Time = 300,
	},
	{
		File = BOSS.."機戰 Marionette Messiah Alpha.mp3",
		Time = 300,
	},
	{
		File = BOSS.."機戰 Marionette Messiah OG C_kattyasooo.mp3",
		Time = 300,
	},
	{
		File = BOSS.."機戰 Marionette Messiah OGs.mp3",
		Time = 300,
	},
	{
		File = BOSS.."機戰 Over time OG2nd.mp3",
		Time = 300,
	},
	{
		File = BOSS.."機戰 Violent Battle OGs.mp3",
		Time = 300,
	},
	{
		File = BOSS.."獵人 Departure C_MattyyyM.mp3",
		Time = 300,
	},
	{
		File = BOSS.."獵人 Hunting For Your Dream C_MattyyyM.mp3",
		Time = 300,
	},
	{
		File = BOSS.."獵人 表裏一体 C_MattyyyM.mp3",
		Time = 300,
	},
	{
		File = BOSS.."鏈鋸人 KICK BACK C_MattyyyM.mp3",
		Time = 300,
	},
	{
		File = BOSS.."魔力寶貝 Boss Urgent.mp3",
		Time = 300,
	},
	{
		File = BOSS.."魔力寶貝 李貝留斯.mp3",
		Time = 300,
	},
}


SoundPack.music_swimming = {
	{
		File = SWIMMING.."Gachi-Natsu 02 Calm Night.mp3",
		Time = 125,
	},
	{
		File = SWIMMING.."Gachi-Natsu 05 Beach and Sound of Waves.mp3",
		Time = 132,
	},
	{
		File = SWIMMING.."幽遊白書 Choice C_Niche.mp3",
		Time = 40,
	},
	{
		File = SWIMMING.."幽遊白書 Choice.mp3",
		Time = 136,
	},
	{
		File = SWIMMING.."郃樂章 tHe.mp3",
		Time = 90,
	},
	{
		File = SWIMMING.."惡靈古堡 Separate Ways - Ada's Theme.mp3",
		Time = 76,
	},
	{
		File = SWIMMING.."夢幻模擬戰4 2.mp3",
		Time = 151,
	},
	{
		File = SWIMMING.."夢幻模擬戰4 29.mp3",
		Time = 127,
	},
	{
		File = SWIMMING.."夢幻模擬戰5 兄貴.mp3",
		Time = 45,
	},
	{
		File = SWIMMING.."魔力寶貝 準備.mp3",
		Time = 48,
	},
	{
		File = SWIMMING.."魔力寶貝2 角色選擇.mp3",
		Time = 103,
	},
}


SoundPack.music_flying = {
	{
		File = FLYING.."FE Capozio Inspire.mp3",
		Time = 156,
	},
	{
		File = FLYING.."FE Positive Corporate.mp3",
		Time = 150,
	},
	{
		File = FLYING.."FE you8me.mp3",
		Time = 300,
	},
	{
		File = FLYING.."Gachi-Natsu 03 Under the Sun.mp3",
		Time = 133,
	},
	{
		File = FLYING.."Gachi-Natsu 10 Starts here.mp3",
		Time = 178,
	},
	{
		File = FLYING.."Gachi-Natsu 12 Because the summer wind blew.mp3",
		Time = 246,
	},
	{
		File = FLYING.."Pianoboy The truth that you leave C_pianotunnel7588.mp3",
		Time = 150,
	},
	{
		File = FLYING.."七龍珠GT Dan Dan Kokoro Hikareteku C_Vichede.mp3",
		Time = 210,
	},
	{
		File = FLYING.."千本櫻 C_kuyamagix.mp3",
		Time = 300,
	},
	{
		File = FLYING.."中華一番 I can't breathe C_Vichede.mp3",
		Time = 92,
	},
	{
		File = FLYING.."古老的大鐘 C_Guitar_tab_master.mp3",
		Time = 236,
	},
	{
		File = FLYING.."冰雪奇緣 Let it go C_BoShenPlayNow.mp3",
		Time = 213,
	},
	{
		File = FLYING.."名偵探柯南 Main Theme C_HoonjinPARK.mp3",
		Time = 86,
	},
	{
		File = FLYING.."哆啦A夢 Yume Wo Kanaete C_entamerise.mp3",
		Time = 241,
	},
	{
		File = FLYING.."珍珠美人魚 Rainbow Notes C_kfmm1454.mp3",
		Time = 262,
	},
	{
		File = FLYING.."珍珠美人魚 Rainbow Notes C_kfmm1454.mp3",
		Time = 262,
	},
	{
		File = FLYING.."音速小子 Flying Battery Zone C_HoonjinPARK.mp3",
		Time = 113,
	},
	{
		File = FLYING.."音速小子 Flying Battery Zone.mp3",
		Time = 80,
	},
	{
		File = FLYING.."鬼滅之刃 紅蓮華 C_MattyyyM.mp3",
		Time = 233,
	},
	{
		File = FLYING.."超時空之鑰 Wind Scene 600AD C_Malcolm.mp3",
		Time = 210,
	},
	{
		File = FLYING.."黑人抬棺 C_HoonjinPARK.mp3",
		Time = 108,
	},
	{
		File = FLYING.."頭文字D Deja Vu C_Dave Rodgers.mp3",
		Time = 247,
	},
	{
		File = FLYING.."魔動王 C_The HOOT.mp3",
		Time = 207,
	},
}


SoundPack.music_in_vehicle = {
	{
		File = VEHICLE.."FE Look Both Ways Nathan Moore.mp3",
		Time = 121,
	},
	{
		File = VEHICLE.."FE Two of Us - Saidbysed.mp3",
		Time = 101,
	},
	{
		File = VEHICLE.."Gachi-Natsu 06 Ahhh.mp3",
		Time = 93,
	},
	{
		File = VEHICLE.."ToS_Disney Villains4.mp3",
		Time = 60,
	},
	{
		File = VEHICLE.."七龍珠 Gravity Machine C_Niche.mp3",
		Time = 70,
	},
	{
		File = VEHICLE.."三國志3 Heavenly Bodies.mp3",
		Time = 165,
	},
	{
		File = VEHICLE.."哆啦A夢 minor C_kbtiest.mp3",
		Time = 40,
	},
	{
		File = VEHICLE.."幽遊白書 微笑炸彈快板.mp3",
		Time = 104,
	},
	{
		File = VEHICLE.."郃樂章 Ho-Light+4.mp3",
		Time = 124,
	},
	{
		File = VEHICLE.."夢幻模擬戰4 01.mp3",
		Time = 186,
	},
}


SoundPack.music_pve_instance = {
	{
		File = DUNGEON.."Bad Style Time Back C_kbtiest.mp3",
		Time = 151,
	},
	{
		File = DUNGEON.."FE 19th Floor - Bobby Richards.mp3",
		Time = 300,
	},
	{
		File = DUNGEON.."FE Beside Me - Patrick Patrikios.mp3",
		Time = 300,
	},
	{
		File = DUNGEON.."FE Forget Me Not.mp3",
		Time = 195,
	},
	{
		File = DUNGEON.."FE On The Hunt.mp3",
		Time = 300,
	},
	{
		File = DUNGEON.."FE Stage1.mp3",
		Time = 300,
	},
	{
		File = DUNGEON.."Pianoboy The truth that you leave C_DeLTa.mp3",
		Time = 300,
	},
	{
		File = DUNGEON.."PUBG Theme C_HoonjinPARK.mp3",
		Time = 236,
	},
	{
		File = DUNGEON.."ToS_Amazing Journey_a.mp3",
		Time = 156,
	},
	{
		File = DUNGEON.."ToS_BaFong_a.mp3",
		Time = 168,
	},
	{
		File = DUNGEON.."ToS_BIGBANG Conjurers.mp3",
		Time = 178,
	},
	{
		File = DUNGEON.."ToS_Cyborg+1.mp3",
		Time = 162,
	},
	{
		File = DUNGEON.."ToS_Disney Villains.mp3",
		Time = 174,
	},
	{
		File = DUNGEON.."ToS_Eternal Discipline.mp3",
		Time = 188,
	},
	{
		File = DUNGEON.."ToS_Investiture of Heavenly Kingdom.mp3",
		Time = 150,
	},
	{
		File = DUNGEON.."ToS_Legacy of Glory.mp3",
		Time = 203,
	},
	{
		File = DUNGEON.."ToS_Legacy of Glory1.mp3",
		Time = 206,
	},
	{
		File = DUNGEON.."ToS_Lost Relic.mp3",
		Time = 198,
	},
	{
		File = DUNGEON.."ToS_Rise of the Core.mp3",
		Time = 161,
	},
	{
		File = DUNGEON.."ToS_Strains of Glory.mp3",
		Time = 190,
	},
	{
		File = DUNGEON.."ToS_Zodiacs.mp3",
		Time = 192,
	},
	{
		File = DUNGEON.."Vanessa Mae Contradanza C_snbtvstudi.mp3",
		Time = 224,
	},
	{
		File = DUNGEON.."七龍珠 18號 超武鬥傳.mp3",
		Time = 150,
	},
	{
		File = DUNGEON.."七龍珠 Frieza 超武鬥傳 C_takabosoft.mp3",
		Time = 151,
	},
	{
		File = DUNGEON.."七龍珠 Piccolo 超武鬥傳 C_takabosoft.mp3",
		Time = 179,
	},
	{
		File = DUNGEON.."七寶奇謀 The Goodies.mp3",
		Time = 184,
	},
	{
		File = DUNGEON.."天堂 Castle battle.mp3",
		Time = 178,
	},
	{
		File = DUNGEON.."孔明傳 01.mp3",
		Time = 166,
	},
	{
		File = DUNGEON.."孔明傳 03.mp3",
		Time = 217,
	},
	{
		File = DUNGEON.."孔明傳 05.mp3",
		Time = 166,
	},
	{
		File = DUNGEON.."火影忍者 The Rising Fighting Spirit C_HoonjinPARK.mp3",
		Time = 152,
	},
	{
		File = DUNGEON.."妖精尾巴 FAIRY TAIL Main Theme 2014 C_Dryante.mp3",
		Time = 164,
	},
	{
		File = DUNGEON.."狂飆騎士 A dignified battle.mp3",
		Time = 310,
	},
	{
		File = DUNGEON.."狂飆騎士 Kiss of Jealousy C_gh0ulydee.mp3",
		Time = 150,
	},
	{
		File = DUNGEON.."秀逗魔導士 Give a reason C_sono.mp3",
		Time = 267,
	},
	{
		File = DUNGEON.."初音 朧月 C_Vichede.mp3",
		Time = 181,
	},
	{
		File = DUNGEON.."幽遊白書 Current Status＆Dark Dome 特別篇 C_Niche.mp3",
		Time = 209,
	},
	{
		File = DUNGEON.."幽遊白書 Forest＆Battle 特別篇 C_Niche.mp3",
		Time = 215,
	},
	{
		File = DUNGEON.."幽遊白書 kktu-04.mp3",
		Time = 153,
	},
	{
		File = DUNGEON.."幽遊白書 kktu-06.mp3",
		Time = 158,
	},
	{
		File = DUNGEON.."幽遊白書 kktu-09.mp3",
		Time = 187,
	},
	{
		File = DUNGEON.."幽遊白書 kktu-12.mp3",
		Time = 150,
	},
	{
		File = DUNGEON.."幽遊白書 Kuronue.mp3",
		Time = 135,
	},
	{
		File = DUNGEON.."幽遊白書 st-01.mp3",
		Time = 164,
	},
	{
		File = DUNGEON.."幽遊白書 The First Arena C_Niche.mp3",
		Time = 167,
	},
	{
		File = DUNGEON.."幽遊白書 The First Arena st.mp3",
		Time = 217,
	},
	{
		File = DUNGEON.."幽遊白書 tkbt-03.mp3",
		Time = 211,
	},
	{
		File = DUNGEON.."幽遊白書 tkbt-04.mp3",
		Time = 159,
	},
	{
		File = DUNGEON.."幽遊白書 tkbt-05.mp3",
		Time = 290,
	},
	{
		File = DUNGEON.."幽遊白書 tkbt-06.mp3",
		Time = 215,
	},
	{
		File = DUNGEON.."幽遊白書 Yusuke's Power Up.mp3",
		Time = 224,
	},
	{
		File = DUNGEON.."幽遊白書 藏馬之歌.mp3",
		Time = 249,
	},
	{
		File = DUNGEON.."洛克人 Dr.Willie C_GameBGM-Toyo.mp3",
		Time = 150,
	},
	{
		File = DUNGEON.."洛克人 Flash Man C_MasahikoKonno.mp3",
		Time = 153,
	},
	{
		File = DUNGEON.."洛克人 Flash Man 任天堂明星大亂鬥.mp3",
		Time = 300,
	},
	{
		File = DUNGEON.."洛克人 Metal Man C_GameBGM-Toyo.mp3",
		Time = 150,
	},
	{
		File = DUNGEON.."洛克人 Metal Man Stage 任天堂明星大亂鬥.mp3",
		Time = 274,
	},
	{
		File = DUNGEON.."惡靈古堡 Ada Wong Mayhem Theme.mp3",
		Time = 179,
	},
	{
		File = DUNGEON.."惡靈古堡 Ada Wong Theme.mp3",
		Time = 212,
	},
	{
		File = DUNGEON.."惡靈古堡 The Mercenaries - Leon Theme.mp3",
		Time = 82,
	},
	{
		File = DUNGEON.."最終幻想13 Blinded By Light C_LaceyJohnson.mp3",
		Time = 153,
	},
	{
		File = DUNGEON.."最終幻想13 Blinded By Light C_ToxicxEternity.mp3",
		Time = 195,
	},
	{
		File = DUNGEON.."超級瑪利歐 Super Mario Bros Theme C_HoonjinPARK.mp3",
		Time = 234,
	},
	{
		File = DUNGEON.."亂馬 五寸丁.mp3",
		Time = 170,
	},
	{
		File = DUNGEON.."楓之谷 墮落城市 C_HoonjinPARK.mp3",
		Time = 195,
	},
	{
		File = DUNGEON.."夢幻模擬戰2 Dark Princes.mp3",
		Time = 199,
	},
	{
		File = DUNGEON.."夢幻模擬戰2 Fight It Out.mp3",
		Time = 154,
	},
	{
		File = DUNGEON.."夢幻模擬戰2 Imelda.mp3",
		Time = 169,
	},
	{
		File = DUNGEON.."夢幻模擬戰2 Knights Errant.mp3",
		Time = 178,
	},
	{
		File = DUNGEON.."夢幻模擬戰2 Neo-Holy War.mp3",
		Time = 219,
	},
	{
		File = DUNGEON.."夢幻模擬戰2 No Surrender.mp3",
		Time = 153,
	},
	{
		File = DUNGEON.."夢幻模擬戰2 One's Side.mp3",
		Time = 152,
	},
	{
		File = DUNGEON.."夢幻模擬戰2 Soldier.mp3",
		Time = 177,
	},
	{
		File = DUNGEON.."夢幻模擬戰4 06.mp3",
		Time = 159,
	},
	{
		File = DUNGEON.."夢幻模擬戰4 10.mp3",
		Time = 172,
	},
	{
		File = DUNGEON.."夢幻模擬戰4 15.mp3",
		Time = 186,
	},
	{
		File = DUNGEON.."夢幻模擬戰4 16.mp3",
		Time = 158,
	},
	{
		File = DUNGEON.."夢幻模擬戰4 17.mp3",
		Time = 200,
	},
	{
		File = DUNGEON.."夢幻模擬戰4 19.mp3",
		Time = 150,
	},
	{
		File = DUNGEON.."夢幻模擬戰4 22.mp3",
		Time = 179,
	},
	{
		File = DUNGEON.."夢幻模擬戰4 23.mp3",
		Time = 155,
	},
	{
		File = DUNGEON.."夢幻模擬戰4 26.mp3",
		Time = 158,
	},
	{
		File = DUNGEON.."夢幻模擬戰4 31.mp3",
		Time = 161,
	},
	{
		File = DUNGEON.."夢幻模擬戰4 33.mp3",
		Time = 179,
	},
	{
		File = DUNGEON.."夢幻模擬戰4 Scenario 1 Courage M.mp3",
		Time = 170,
	},
	{
		File = DUNGEON.."夢幻模擬戰4 Scenario 1 Courage.mp3",
		Time = 169,
	},
	{
		File = DUNGEON.."夢幻模擬戰5 Alfred.mp3",
		Time = 149,
	},
	{
		File = DUNGEON.."夢幻模擬戰5 Brenda.mp3",
		Time = 184,
	},
	{
		File = DUNGEON.."夢幻模擬戰5 Claret.mp3",
		Time = 172,
	},
	{
		File = DUNGEON.."夢幻模擬戰5 Splendid Cmdr.mp3",
		Time = 165,
	},
	{
		File = DUNGEON.."夢幻模擬戰5 Σ-066.mp3",
		Time = 150,
	},
	{
		File = DUNGEON.."夢幻模擬戰5 Ω-133.mp3",
		Time = 172,
	},
	{
		File = DUNGEON.."碧藍幻想 Licht - Ferry's theme.mp3",
		Time = 205,
	},
	{
		File = DUNGEON.."數碼寶貝 Brave heart C_AndrewT.mp3",
		Time = 165,
	},
	{
		File = DUNGEON.."輪迴七次的惡役千金，在前敵國享受隨心所欲的新婚生活 Another Birthday C_AsianMusicBox.mp3",
		Time = 212,
	},
	{
		File = DUNGEON.."機動戰艦 You Get To Buming C_Gin&Yoshitune.mp3",
		Time = 216,
	},
	{
		File = DUNGEON.."機械女神 SuccessfulMission C_Gin＆Yoshitune.mp3",
		Time = 246,
	},
	{
		File = DUNGEON.."機械女神_Successful Mission C_sono.mp3",
		Time = 245,
	},
	{
		File = DUNGEON.."機戰 ACE ATTACKER VerW Alpha.mp3",
		Time = 300,
	},
	{
		File = DUNGEON.."機戰 Aura Battler Dunbine F.mp3",
		Time = 299,
	},
	{
		File = DUNGEON.."機戰 Fly high F.mp3",
		Time = 181,
	},
	{
		File = DUNGEON.."機戰 Heartful mechanic OG.mp3",
		Time = 300,
	},
	{
		File = DUNGEON.."機戰 It's not anime Impact.mp3",
		Time = 186,
	},
	{
		File = DUNGEON.."機戰 Just communication F＆新.mp3",
		Time = 300,
	},
	{
		File = DUNGEON.."機戰 Kurayami de Bikkuri 新.mp3",
		Time = 181,
	},
	{
		File = DUNGEON.."機戰 Lonely Way 新.mp3",
		Time = 173,
	},
	{
		File = DUNGEON.."機戰 Love is Far Away 新.mp3",
		Time = 172,
	},
	{
		File = DUNGEON.."機戰 Men of Destiny Alpha.mp3",
		Time = 176,
	},
	{
		File = DUNGEON.."機戰 Meteor tearing through the night OG2nd.mp3",
		Time = 300,
	},
	{
		File = DUNGEON.."機戰 Over the Rainbow MX.mp3",
		Time = 189,
	},
	{
		File = DUNGEON.."機戰 Psychic Energy 新.mp3",
		Time = 174,
	},
	{
		File = DUNGEON.."機戰 Silent voice F＆Alpha外傳.mp3",
		Time = 300,
	},
	{
		File = DUNGEON.."機戰 Soul's Refrain Alpha.mp3",
		Time = 154,
	},
	{
		File = DUNGEON.."機戰 Star Emblem 新.mp3",
		Time = 151,
	},
	{
		File = DUNGEON.."機戰 The winner F＆Alpha外傳.mp3",
		Time = 300,
	},
	{
		File = DUNGEON.."機戰 TIME FOR L-GAIM F.mp3",
		Time = 150,
	},
	{
		File = DUNGEON.."獵人 Reason C_MattyyyM.mp3",
		Time = 296,
	},
	{
		File = DUNGEON.."轉生就是劍 more STRONGLY.mp3",
		Time = 297,
	},
	{
		File = DUNGEON.."爆走獵人 Mask C_Gin＆Yoshitune.mp3",
		Time = 260,
	},
	{
		File = DUNGEON.."爆走獵人 Mask C_zm4lu2iw6g.mp3",
		Time = 247,
	},
	{
		File = DUNGEON.."爆走獵人 What'sUpGuys C_Gin＆Yoshitune.mp3",
		Time = 244,
	},
	{
		File = DUNGEON.."魔力寶貝 Dungeon.mp3",
		Time = 166,
	},
	{
		File = DUNGEON.."魔力寶貝 The Frozen City.mp3",
		Time = 154,
	},
	{
		File = DUNGEON.."魔力寶貝 Tower.mp3",
		Time = 160,
	},
	{
		File = DUNGEON.."魔力寶貝 Treacherous.mp3",
		Time = 150,
	},
	{
		File = DUNGEON.."魔力寶貝 雪山.mp3",
		Time = 182,
	},
}


--SoundPack.music_pve_instance_in_combat = {


SoundPack.music_in_combat = {
	{
		File = BATTLE.."FE Our Construction.mp3",
		Time = 101,
	},
	{
		File = BATTLE.."FE the lead was taken.mp3",
		Time = 64,
	},
	{
		File = BATTLE.."ToS_Trove.mp3",
		Time = 71,
	},
	{
		File = BATTLE.."七龍珠 battle FC C_YAODY i.mp3",
		Time = 169,
	},
	{
		File = BATTLE.."七龍珠 Battle Legend of the Super Saiyan C_Takabo.mp3",
		Time = 110,
	},
	{
		File = BATTLE.."七龍珠 Tenka ichi Budokai C_Niche.mp3",
		Time = 64,
	},
	{
		File = BATTLE.."千本櫻 C_RavenTerran.mp3",
		Time = 148,
	},
	{
		File = BATTLE.."石器時代 Battle.mp3",
		Time = 47,
	},
	{
		File = BATTLE.."吞食天地 Battle C_GameBGM-Toyo.mp3",
		Time = 69,
	},
	{
		File = BATTLE.."遊戲王 3D Duel.mp3",
		Time = 180,
	},
	{
		File = BATTLE.."機戰 Chinese PE teacher in flames OG2nd.mp3",
		Time = 47,
	},
	{
		File = BATTLE.."機戰 Get the Funk Out 新.mp3",
		Time = 181,
	},
	{
		File = BATTLE.."魔力寶貝 Encounter.mp3",
		Time = 65,
	},
	{
		File = BATTLE.."魔力寶貝 Encounter2.mp3",
		Time = 99,
	},
	{
		File = BATTLE.."魔力寶貝 Encounter3.mp3",
		Time = 99,
	},
	{
		File = BATTLE.."魔力寶貝 Encounter4.mp3",
		Time = 178,
	},
	{
		File = BATTLE.."魔力寶貝 不分軒輊.mp3",
		Time = 72,
	},
}


SoundPack.music_resting = {
	{
		File = RESTING.."FE Blue Dream - Cheel.mp3",
		Time = 163,
	},	
	{
		File = RESTING.."FE Caballero - Ofshane.mp3",
		Time = 152,
	},	
	{
		File = RESTING.."FE Marked.mp3",
		Time = 150,
	},	
	{
		File = RESTING.."Gachi-Natsu 01 Everyday Life.mp3",
		Time = 262,
	},	
	{
		File = RESTING.."Gachi-Natsu 08 Snuggle.mp3",
		Time = 270,
	},	
	{
		File = RESTING.."Gachi-Natsu 09 Regret.mp3",
		Time = 173,
	},	
	{
		File = RESTING.."Gachi-Natsu 11 Sweet time between men.mp3",
		Time = 260,
	},	
	{
		File = RESTING.."LHW All the things you never knew C_kbtiest.mp3",
		Time = 300,
	},	
	{
		File = RESTING.."Pianoboy 絮雨.mp3",
		Time = 196,
	},	
	{
		File = RESTING.."Raujika City of Twilight.mp3",
		Time = 212,
	},	
	{
		File = RESTING.."Rose.mp3",
		Time = 278,
	},	
	{
		File = RESTING.."Rose+6.mp3",
		Time = 196,
	},	
	{
		File = RESTING.."To the Moon-Main Theme.mp3",
		Time = 279,
	},	
	{
		File = RESTING.."Wild Sea.mp3",
		Time = 159,
	},
	{
		File = RESTING.."ZARD Kimi ni Aitaku Nattara C_Ai_Everyone.mp3",
		Time = 225,
	},
	{
		File = RESTING.."七龍珠GT Dan Dan Kokoro Hikareteku C_isopiano7008.mp3",
		Time = 173,
	},
	{
		File = RESTING.."大盜五右衛門 安樂村.mp3",
		Time = 173,
	},	
	{
		File = RESTING.."天之痕 昔影 C_Oao.mp3",
		Time = 212,
	},
	{
		File = RESTING.."天堂 登出.mp3",
		Time = 224,
	},
	{
		File = RESTING.."仙境傳說 Theme of Prontera.mp3",
		Time = 273,
	},	
	{
		File = RESTING.."石器時代 07.mp3",
		Time = 180,
	},	
	{
		File = RESTING.."石器時代 08.mp3",
		Time = 213,
	},	
	{
		File = RESTING.."石器時代 09.mp3",
		Time = 201,
	},	
	{
		File = RESTING.."希望 Avec Le TeMPs.mp3",
		Time = 292,
	},	
	{
		File = RESTING.."秀逗魔導士 Get along C_AGMS.mp3",
		Time = 216,
	},	
	{
		File = RESTING.."初音 Uta ni Katachi wa Nai Keredo C_Vichede.mp3",
		Time = 327,
	},	
	{
		File = RESTING.."被贈與的未來 Given C_ameagarinohana.mp3",
		Time = 233,
	},	
	{
		File = RESTING.."被贈與的未來 Given C_MrLopez2112.mp3",
		Time = 195,
	},
	{
		File = RESTING.."最終幻想10 to Zanarkand theme C_davidpicheviolin.mp3",
		Time = 116,
	},	
	{
		File = RESTING.."楓之谷 Leafre C_SLS.mp3",
		Time = 300,
	},	
	{
		File = RESTING.."楓之谷 Maplestory Original Login Theme Title C_kbtiest.mp3",
		Time = 300,
	},	
	{
		File = RESTING.."楓之谷 When The Morning Comes C_SLS.mp3",
		Time = 300,
	},
	{
		File = RESTING.."楓之谷 弓箭手村 C_HoonjinPARK.mp3",
		Time = 160,
	},
	{
		File = RESTING.."楓之谷 登入畫面 C_HoonjinPARK.mp3",
		Time = 160,
	},
	{
		File = RESTING.."楓之谷 維多利亞港 C_HoonjinPARK.mp3",
		Time = 154,
	},
	{
		File = RESTING.."遊戲王Forbidden Memories Build Deck.mp3",
		Time = 288,
	},
	{
		File = RESTING.."遊戲王Forbidden Memories Library Menu.mp3",
		Time = 300,
	},	
	{
		File = RESTING.."夢幻模擬戰2 Shop.mp3",
		Time = 212,
	},
	{
		File = RESTING.."夢幻模擬戰4 Shop.mp3",
		Time = 258,
	},	
	{
		File = RESTING.."夢幻模擬戰5 Monotonous.mp3",
		Time = 160,
	},	
	{
		File = RESTING.."夢幻模擬戰5 Shop.mp3",
		Time = 156,
	},	
	{
		File = RESTING.."盧廣仲 刻在我心底的名字 C_piano.mp3",
		Time = 300,
	},
	{
		File = RESTING.."藥師少女的獨語 愛的咒語 C_SLSMusic.mp3",
		Time = 300,
	},
	{
		File = RESTING.."灌籃高手 直到世界的盡頭 C_RusPiano.mp3",
		Time = 300,
	},	
	{
		File = RESTING.."魔力寶貝 v2bgm_m0.mp3",
		Time = 274,
	},
	{
		File = RESTING.."魔力寶貝 里謝里雅堡 C_YijunGT.mp3",
		Time = 158,
	},
	{
		File = RESTING.."魔力寶貝 法蘭城.mp3",
		Time = 226,
	},
	{
		File = RESTING.."魔力寶貝 魔法大學 C_YijunGT.mp3",
		Time = 270,
	},
	{
		File = RESTING.."魔力寶貝2 法蘭城.mp3",
		Time = 178,
	},
}


SoundPack.music_mounted = {
	{
		File = MOUNTED.."Gachi-Natsu 07 What the hell.mp3",
		Time = 74,
	},
	{
		File = MOUNTED.."Gachi-Natsu 07 What the hell.mp3",
		Time = 100,
	},
	{
		File = MOUNTED.."Gachi-Natsu 07 What the hell.mp3",
		Time = 93,
	},
	{
		File = MOUNTED.."七龍珠 The Long Journey To Planet Namek C_Niche.mp3",
		Time = 166,
	},
	{
		File = MOUNTED.."陸行鳥賽車 01.mp3",
		Time = 90,
	},
	{
		File = MOUNTED.."陸行鳥賽車 02.mp3",
		Time = 141,
	},
	{
		File = MOUNTED.."陸行鳥賽車 03.mp3",
		Time = 107,
	},
	{
		File = MOUNTED.."陸行鳥賽車 04.mp3",
		Time = 108,
	},
	{
		File = MOUNTED.."陸行鳥賽車 05.mp3",
		Time = 122,
	},
	{
		File = MOUNTED.."陸行鳥賽車 06.mp3",
		Time = 127,
	},
	{
		File = MOUNTED.."陸行鳥賽車 07.mp3",
		Time = 114,
	},
	{
		File = MOUNTED.."陸行鳥賽車 08.mp3",
		Time = 117,
	},
	{
		File = MOUNTED.."陸行鳥賽車 09.mp3",
		Time = 175,
	},
	{
		File = MOUNTED.."陸行鳥賽車 10.mp3",
		Time = 183,
	},
	{
		File = MOUNTED.."機戰 Soldiers of Sorrow C_leinamovie.mp3",
		Time = 199,
	},
	{
		File = MOUNTED.."爆走兄弟 GET THE WORLD C_2dscoreworks.mp3",
		Time = 220,
	},
	{
		File = MOUNTED.."爆走兄弟 GET THE WORLD C_Vichede.mp3",
		Time = 153,
	},
	{
		File = MOUNTED.."爆走兄弟 Winning Run！Kaze ni Naritai C_immanuelbear.mp3",
		Time = 92,
	},
}


SoundPack.music_regular = {
	{
		File = OVERWORLD.."FE Half Measures - Craig MacArthur.mp3",
		Time = 262,
	},
	{
		File = OVERWORLD.."FE Zmey.mp3",
		Time = 300,
	},
	{
		File = OVERWORLD.."Gachi-Natsu 04 Let's go out.mp3",
		Time = 246,
	},
	{
		File = OVERWORLD.."ToS_Bathtub.mp3",
		Time = 220,
	},
	{
		File = OVERWORLD.."ToS_BIGBANG Legacy of Glory-2.mp3",
		Time = 274,
	},
	{
		File = OVERWORLD.."七龍珠GT Blue Velvet Synthesia C_TheHungarian.mp3",
		Time = 225,
	},
	{
		File = OVERWORLD.."大盜五右衛門 日落man男.mp3",
		Time = 177,
	},
	{
		File = OVERWORLD.."大盜五右衛門 來到妖怪街道.mp3",
		Time = 174,
	},
	{
		File = OVERWORLD.."大盜五右衛門 混怒der男生.mp3",
		Time = 179,
	},
	{
		File = OVERWORLD.."大盜五右衛門 暑假歸來.mp3",
		Time = 170,
	},
	{
		File = OVERWORLD.."天堂 古魯丁.mp3",
		Time = 248,
	},
	{
		File = OVERWORLD.."石器時代 05.mp3",
		Time = 192,
	},
	{
		File = OVERWORLD.."石器時代 06.mp3",
		Time = 219,
	},
	{
		File = OVERWORLD.."狂飆騎士 Kiss of Jealousy C_Rar.mp3",
		Time = 300,
	},
	{
		File = OVERWORLD.."楓之谷 Moonlight Shadow C_SLS.mp3",
		Time = 300,
	},
	{
		File = OVERWORLD.."熱血進行曲 像一匹馬車.mp3",
		Time = 180,
	},
	{
		File = OVERWORLD.."機戰 Power and skill OG2nd.mp3",
		Time = 300,
	},
	{
		File = OVERWORLD.."機戰 The Opened Door 新.mp3",
		Time = 172,
	},
	{
		File = OVERWORLD.."魔力寶貝 exbgm_m0.mp3",
		Time = 162,
	},
	{
		File = OVERWORLD.."魔力寶貝 exbgm_s0.mp3",
		Time = 264,
	},
	{
		File = OVERWORLD.."魔力寶貝 北方大陸.mp3",
		Time = 220,
	},
	{
		File = OVERWORLD.."魔力寶貝 米內葛爾島.mp3",
		Time = 186,
	},
	{
		File = OVERWORLD.."魔力寶貝 芙蕾亞.mp3",
		Time = 200,
	},
	{
		File = OVERWORLD.."魔力寶貝 綠洲沙漠.mp3",
		Time = 192,
	},
	{
		File = OVERWORLD.."魔力寶貝2 芙蕾亞.mp3",
		Time = 226,
	},
}
