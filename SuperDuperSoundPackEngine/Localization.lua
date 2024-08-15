-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/superdupersoundpackengine/localization/

local AddonName, a = ...
a.Localize = setmetatable({}, {__index = function(_, key) return key end})
local L = a.Localize

-- Example:
L["English text goes here."] = "Translated text goes here."

if GetLocale() == "zhTW" then -- Traditional Chinese
L["All Sounds and Music  ( changes only saved per session )"] = "所有【音樂和音效】" -- Needs review
L["Checking for Boss or Party  ( changes only saved per session )"] = "此選項無效" -- Needs review
-- L["Checks disabled for this session!"] = ""
-- L["Checks enabled."] = ""
L["Jumping Sound"] = "【跳躍】音效" -- Needs review
L["Music"] = "【音樂】" -- Needs review
--L["Options"] = "選項" -- Needs review
L["Selected Sound Pack:"] = "選擇使用的聲音取代插件" -- Needs review
--L["Settings have been reset!"] = "設定已經重置" -- Needs review
--L["Sound disabled for this session!"] = "關閉音效" -- Needs review
--L["Sound enabled."] = "開啟音效" -- Needs review
L["Sound on Buff"] = "獲得【增益】音效" -- Needs review
L["Sound on Debuff"] = "獲得【減益】音效" -- Needs review
L["Sound on Direct Damage"] = "【傷害及攻擊】音效" -- Needs review
L["Sound on XP, Honor or Rep. Gain"] = "獲得【經驗、榮譽或聲望】音效" -- Needs review
L["Sounds"] = "【音效】"
L["Sound when at Max Combo Points or Rage"] = "此選項無效" -- Needs review
L["Sound when Boss Reaches Low Health"] = "此選項無效" -- Needs review
L["Sound while Damage Immunity Buffed"] = "此選項無效" -- Needs review
L["Swimming Sound"] = "【游泳踢水】音效"

end