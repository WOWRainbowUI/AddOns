local MinBuild, OverBuild, Build = 50000, 0, select(4, GetBuildInfo())
if Build < (MinBuild or 0) or ( (OverBuild or 0) > 0 and Build >= OverBuild ) then return end
local AddonName, a = ...
a.AddonName = AddonName
local L = a.Localize
LibStub:GetLibrary("BigLibTimer6"):Register(a)

if not SuperDuperSoundPackEngineAddonConfig then
	SuperDuperSoundPackEngineAddonConfig = {}
end

SuperDuperSoundPackEngine = {}

local SoundPacks = {}
local SoundPacksName = {}

local DefaultSoundPack = "SAHAWOW"


local CLASS = select(2, UnitClass("player"))
local RACE = select(2, UnitRace("player")):upper():gsub("[^A-Z]", ""):gsub("SCOURGE", "UNDEAD")

local VARIABLES_CHECKED = nil
local SOUND_SUSPENDED = nil
local CHECKS_DISABLED = nil
local parent = nil
local LOADING = true
local FIRSTLOAD = true
local SoundPacksLoaded = nil
local SOUNDPACK = DefaultSoundPack
local IMMUNITYMUSIC = nil
local SPEEDMUISIC = nil
local MUSIC_DELAYED = nil
local CURRENT_MUSIC_TYPE = nil
local InCombat = InCombatLockdown()
local MOUNTED = nil
local CURRENTMONEY = 0
local GROUPWIPED = nil
local BATTLEFIELDWINNER = nil
local WASINPVEINSTANCE = nil
local LAST_HIT_ENEMY_PLAYER_TARGET_GUID = nil
local LAST_ENEMY_PLAYER_TARGET_GUID = nil
local BOSSID = {}
local MAX_COMBO_POINTS = 5
local SHIELDBUFFS = {
	[GetSpellInfo(17--[[Power Word: Shield]]) or ""] = true,
	[GetSpellInfo(642--[[Divine Shield]]) or ""] = true,
	[GetSpellInfo(1463--[[Mana Shield]]) or ""] = true,
	[GetSpellInfo(11426--[[Ice Barrier]]) or ""] = true,
	[GetSpellInfo(7812--[[Sacrifice]]) or ""] = true,
}
SHIELDBUFFS[""] = nil
local FORMBUFFS = {
	[GetSpellInfo(1066--[[Aquatic Form]]) or ""] = true,
	[GetSpellInfo(5487--[[Bear Form]]) or ""] = true,
	[GetSpellInfo(768--[[Cat Form]]) or ""] = true,
	[GetSpellInfo(9634--[[Dire Bear Form]]) or ""] = true,
	[GetSpellInfo(33943--[[Flight Form]]) or ""] = true,
	[GetSpellInfo(24858--[[Moonkin Form]]) or ""] = true,
	[GetSpellInfo(40120--[[Swift Flight Form]]) or ""] = true,
	[GetSpellInfo(783--[[Travel Form]]) or ""] = true,
	[GetSpellInfo(65139--[[Tree of Life]]) or ""] = true,
	[GetSpellInfo(2645--[[Ghost Wolf]]) or ""] = true,
	[GetSpellInfo(59672--[[Metamorphosis]]) or ""] = true,
}
FORMBUFFS[""] = nil

local SoundPackTables = {
	my_spell_cast = {},
	pet_spell_cast = {},
	emote = {},
}

function SuperDuperSoundPackEngine.Register(Name, Title, Description, Version)
	if type(Name) == "string" and Name ~= "" and Name:lower() ~= "sdspe_template" and Name:lower() ~= "sdsp_template" then
		if type(SoundPacks[Name]) ~= "table" then
			SoundPacks[Name] = {}
		end
		for k in pairs(SoundPackTables) do
			if type(SoundPacks[Name][k]) ~= "table" then
				SoundPacks[Name][k] = {}
			end
		end
		SoundPacks[Name].Title = Title
		SoundPacks[Name].Description = Description
		SoundPacks[Name].Version = Version
		local v = Version or ""
		if v ~= "" then
			v = " "..ORANGE_FONT_COLOR_CODE..v..FONT_COLOR_CODE_CLOSE
		end
		SoundPacks[Name].DisplayTitle = (Title or "")..v.."   "..GRAY_FONT_COLOR_CODE.."("..Name..")"..FONT_COLOR_CODE_CLOSE
		SoundPacksName[SoundPacks[Name].DisplayTitle] = Name
		return SoundPacks[Name]
	end
	return nil
end
Register_SuperDuperSoundPackEngine_SoundPack = SuperDuperSoundPackEngine.Register

function SuperDuperSoundPackEngine.Get(Name)
	if type(Name) == "string" and type(SoundPacks[Name]) == "table" then
		return SoundPacks[Name], SoundPacks[Name].Title, SoundPacks[Name].Description, SoundPacks[Name].Version
	end
	return nil
end

local function SoundPackValue(Key)
	if SoundPacksLoaded then
			return SoundPacks[SOUNDPACK][Key]
	end
	return SoundPackTables[Key]
end

local function HealthPercent(unit)
	local Max = UnitHealthMax(unit or "target")
	if Max > 0 then
		return ( UnitHealth(unit or "target") / Max ) * 100
	end
	return 0
end

local function IsShield(buff)
	if buff then
		return SHIELDBUFFS[buff]
	else
		for i=1,40 do
			local name = UnitBuff("player",i)
			if name then
				for n in pairs(SHIELDBUFFS) do
					if name == n then
						return true
					end
				end
			end
		end
	end
	return false
end

local function IsForm(buff)
	if CLASS == "DRUID" or CLASS == "WARLOCK" or CLASS == "SHAMAN" then
		if buff then
			return FORMBUFFS[buff]
		end
		return GetShapeshiftForm() ~= 0
	end
	return false
end


local function DisableMusic()
	a:ClearTimer("ResetMusic")
	CURRENT_MUSIC_TYPE = nil
	StopMusic()
end

local function SilenceMusic()
--	if not SoundPacksLoaded then return end
--	a:ClearTimer("ResetMusic")
--	CURRENT_MUSIC_TYPE = nil
--	if not SOUND_SUSPENDED and not SuperDuperSoundPackEngineAddonConfig.MUSIC_DISABLED then
--		PlayMusic("Interface\\AddOns\\"..AddonName.."\\silence.ogg")
--	else
--		DisableMusic()
--	end
end

local function SilenceMusic2()
	if not SoundPacksLoaded then return end
	a:ClearTimer("ResetMusic")
	CURRENT_MUSIC_TYPE = nil
	if not SOUND_SUSPENDED and not SuperDuperSoundPackEngineAddonConfig.MUSIC_DISABLED then
		PlayMusic("Interface\\AddOns\\"..AddonName.."\\silence.ogg")
	else
		DisableMusic()
	end
end


local function ContinueSound(...)
	local File = ...
	local count = select("#", ...)
	if count > 1 then
		File = select(math.random(1, count), ...)
	end
	if type(File) == "string" then
		PlaySoundFile(File, "SFX")
	end
end

function a.Sound(...)
	if not SoundPacksLoaded then return end
	if not SOUND_SUSPENDED and not SuperDuperSoundPackEngineAddonConfig.SOUNDS_DISABLED then
		local First = ...
		if type(First) == "table" then
			ContinueSound(unpack(First))
		else
			ContinueSound(...)
		end
	end
end


local LAST_MULTI_MUSIC_FILE_USED = nil

-- 支援每首音樂可以設定不同時間長度
local function ContinueMusic(...)
	local Files = ...
	local File
	local Time
	local count = 0
	if type(Files) == "table" then
		count = #Files
	end
	if count > 1 then
		local number = math.random(1, count)
		File = Files[number].File or Files[number]
		if type(File) ~= "string" or LAST_MULTI_MUSIC_FILE_USED == File then
			tremove(Files, number)
			number = math.random(1, count - 1)
			File = Files[number].File or Files[number]
		end
		Time = Files[number].Time or SoundPackValue("reset_multi_track_music_delay_time") or 300
		LAST_MULTI_MUSIC_FILE_USED = File
		a:SetTimer("ResetMusic", Time, nil, a.Music, ...)
	elseif count == 1 then
		a:ClearTimer("ResetMusic")
		File = Files[1].File or Files[1]
	else
		File = Files
	end
	if type(File) == "string" then
		PlayMusic(File)
	end
end

function a.Music(...)
	if not SoundPacksLoaded then return end
	if not SOUND_SUSPENDED and not SuperDuperSoundPackEngineAddonConfig.MUSIC_DISABLED then
			ContinueMusic(...)
	else
		DisableMusic()
	end
end

local function SetMusic(reset)
	if not SoundPacksLoaded then return end
	if a:GetTimer("Delay") <= 0 or not MUSIC_DELAYED then
		MUSIC_DELAYED = nil
		if UnitIsDead("player") and not UnitIsGhost("player") then
			SilenceMusic()
			a:ReplaceTimer("immunity", nil, 0, 0)
		elseif a:IsRepeatTimer("immunity") and IMMUNITYMUSIC and not SuperDuperSoundPackEngineAddonConfig.IMMUNITY_DISABLED and SoundPackValue("immunity_buff_on_self") then
			SilenceMusic()
		elseif a:GetTimer("Reloading") <= 0 then
			if IMMUNITYMUSIC and not SuperDuperSoundPackEngineAddonConfig.IMMUNITY_DISABLED and SoundPackValue("immunity_buff_on_self") then
				SilenceMusic()
				if not a:IsRepeatTimer("immunity") then
					a:SetTimer("immunity", a:GetTimer("immunity"), SoundPackValue("immunity_buff_on_self_repeat_time"), a.Sound, SoundPackValue("immunity_buff_on_self"))
				end
			else
				a:ReplaceTimer("immunity", nil, 0, 0)
				if SOUND_SUSPENDED or SuperDuperSoundPackEngineAddonConfig.MUSIC_DISABLED then
					DisableMusic()
				elseif SPEEDMUISIC and SoundPackValue("music_targeted_boss_with_low_health") then
					if reset or CURRENT_MUSIC_TYPE ~= "music_targeted_boss_with_low_health" then
						CURRENT_MUSIC_TYPE = "music_targeted_boss_with_low_health"
						a.Music(SoundPackValue("music_targeted_boss_with_low_health"))
					end
				elseif InCombat and SoundPackValue("music_pve_instance_in_combat") and ( select(2, IsInInstance()) == "party" or select(2, IsInInstance()) == "raid" ) then
					if reset or CURRENT_MUSIC_TYPE ~= "music_pve_instance_in_combat" then
						CURRENT_MUSIC_TYPE = "music_pve_instance_in_combat"
						a.Music(SoundPackValue("music_pve_instance_in_combat"))
					end
				elseif InCombat and SoundPackValue("music_in_combat") and ( (not IsInInstance()) or select(2, IsInInstance()) == "none" ) then
					if reset or CURRENT_MUSIC_TYPE ~= "music_in_combat" then
						CURRENT_MUSIC_TYPE = "music_in_combat"
						a.Music(SoundPackValue("music_in_combat"))
					end
				elseif IsSwimming() and SoundPackValue("music_swimming") then
					if reset or CURRENT_MUSIC_TYPE ~= "music_swimming" then
						CURRENT_MUSIC_TYPE = "music_swimming"
						a.Music(SoundPackValue("music_swimming"))
					end
				elseif ( IsFlying() or UnitOnTaxi("player") ) and SoundPackValue("music_flying") then
					if reset or CURRENT_MUSIC_TYPE ~= "music_flying" then
						CURRENT_MUSIC_TYPE = "music_flying"
						a.Music(SoundPackValue("music_flying"))
					end
				elseif UnitInVehicle("player") and SoundPackValue("music_in_vehicle") then
					if reset or CURRENT_MUSIC_TYPE ~= "music_in_vehicle" then
						CURRENT_MUSIC_TYPE = "music_in_vehicle"
						a.Music(SoundPackValue("music_in_vehicle"))
					end
				elseif SoundPackValue("music_pve_instance") and ( select(2, IsInInstance()) == "party" or select(2, IsInInstance()) == "raid" ) then
					if reset or CURRENT_MUSIC_TYPE ~= "music_pve_instance" then
						CURRENT_MUSIC_TYPE = "music_pve_instance"
						a.Music(SoundPackValue("music_pve_instance"))
					end
				elseif IsResting() and SoundPackValue("music_resting") then
					if reset or CURRENT_MUSIC_TYPE ~= "music_resting" then
						CURRENT_MUSIC_TYPE = "music_resting"
						a.Music(SoundPackValue("music_resting"))
					end
				elseif IsMounted() and SoundPackValue("music_mounted") then
					if reset or CURRENT_MUSIC_TYPE ~= "music_mounted" then
						CURRENT_MUSIC_TYPE = "music_mounted"
						a.Music(SoundPackValue("music_mounted"))
					end
				elseif SoundPackValue("music_regular") then
					if reset or CURRENT_MUSIC_TYPE ~= "music_regular" then
						CURRENT_MUSIC_TYPE = "music_regular"
						a.Music(SoundPackValue("music_regular"))
					end
				else
					DisableMusic()
				end
			end
		else
			SilenceMusic()
			a:ReplaceTimer("immunity", nil, 0, 0)
		end
	else
		SilenceMusic()
	end
end


local function StopAllMusic(DELAY)
	if DELAY == 0 then return end
	SilenceMusic2()
	a:ReplaceTimer("immunity", nil, 0, 0)
	if DELAY then
		MUSIC_DELAYED = 1
		a:SetTimer("Delay", DELAY, nil, SetMusic)
	else
		MUSIC_DELAYED = nil
		a:ClearTimer("Delay")
	end
end

local SetMusicVariables = {
	"ENABLE_SOUND",
	"ENABLE_MUSIC",
	"ENABLE_MUSIC_LOOPING",
}
local DelayMusicVariables = {
	"Sound_NumChannels",
	"Sound_OutputDriverIndex",
	"Sound_OutputQuality",
	"ENABLE_REVERB",
	"ENABLE_SOFTWARE_HRTF",
	"ENABLE_DSP_EFFECTS",
	"ENABLE_HARDWARE",
}
local function SetCVar(cvar, value, scriptCVar)
	for _, v in ipairs(SetMusicVariables) do
		if cvar == v or scriptCVar == v then
			if value == "1" then
				SetMusic(1)
			end
			return
		end
	end
	for _, v in ipairs(DelayMusicVariables) do
		if cvar == v or scriptCVar == v then
			StopAllMusic(math.max(3, a:GetTimer("Delay")))
			return
		end
	end
end
hooksecurefunc("SetCVar", SetCVar)

local function OnEmote(token)
	a.Sound(SoundPackValue("emote")[token])
end
hooksecurefunc("DoEmote", OnEmote)


local function GroupWiped()
	if not GROUPWIPED and SoundPackValue("group_wipe") and ( CHECKS_DISABLED or GetNumGroupMembers() > 1 ) then
		if not UnitIsDeadOrGhost("player") then
			return
		elseif not CHECKS_DISABLED then
			local group, members
			if IsInRaid() then
				members = GetNumGroupMembers()
				group = "raid"
			else
				members = GetNumSubgroupMembers()
				group = "party"
			end
			for i = 1, members do
				if not UnitIsDeadOrGhost(group..i) and UnitIsConnected(group..i) then
					return
				end
			end
		end
		GROUPWIPED = 1
		a:SetTimer("GroupWiped"..GetTime(), (SoundPackValue("group_wipe_delay_time") or 0) + a:GetTimer("Delay"), nil, a.Sound, SoundPackValue("group_wipe"))
		StopAllMusic((SoundPackValue("group_wipe_play_time") or 0) + (SoundPackValue("group_wipe_delay_time") or 0) + a:GetTimer("Delay"))
	end
end


local function TestGroupWipe()
	if not GROUPWIPED and SoundPackValue("group_wipe") and ( CHECKS_DISABLED or GetNumGroupMembers() > 1 ) then
		a:SetTimer("TestGroupWipe", 0.5, nil, GroupWiped)
	end
end



local function TestPower(play)
	-- 8.0 暫時修正
	if not SuperDuperSoundPackEngineAddonConfig.FULLPOWER_DISABLED and SoundPackValue("full_combo_points_or_rage") and UnitCanAttack("player", "target") and CheckInteractDistance("target", 3) and ( not UnitIsDeadOrGhost("target") or UnitExists("targettarget") or UnitAffectingCombat("target") ) and (
		UnitPower("player",4) >= MAX_COMBO_POINTS
		or
		(
			UnitPowerType("player") == SPELL_POWER_RAGE
			and UnitPowerMax("player", SPELL_POWER_RAGE) > 0
			and UnitPower("player", SPELL_POWER_RAGE) == UnitPowerMax("player", SPELL_POWER_RAGE)
		)
	) then
		local RepeatTime = SoundPackValue("full_combo_points_or_rage_repeat_time") or 0
		if a:IsRepeatTimer("FULLPOWER") then
			a:ReplaceTimer("FULLPOWER", nil, RepeatTime, TestPower, true)
			if play then
				a.Sound(SoundPackValue("full_combo_points_or_rage"))
			end
		else
			if a:IsTimer("FULLPOWER") then
				a:SetTimer("FULLPOWER", a:GetTimer("FULLPOWER"), RepeatTime, TestPower, true)
			else
				a.Sound(SoundPackValue("full_combo_points_or_rage"))
				if RepeatTime > 0 then
					a:SetTimer("FULLPOWER", RepeatTime, RepeatTime, TestPower, true)
				end
			end
		end
	else
		a:ReplaceTimer("FULLPOWER", nil, 0, 0)
	end
end

local function CheckVariables()
	if not SuperDuperSoundPackEngineAddonConfig then
		SuperDuperSoundPackEngineAddonConfig = {}
	end
	VARIABLES_CHECKED = 1
end

local function UpdateSoundPackDescription(Description)
	-- 8.0 暫時修正
	-- if SoundPacksLoaded then
	--	_G[parent.."SoundPackDescriptionLabel"]:SetText(SoundPacks[SoundPacksName[UIDropDownMenu_GetText(_G[parent.."SoundPackDropDownMenu"])]].Description or "")
		_G[parent.."SoundPackDescriptionLabel"]:SetText(Description)
	-- end
end

local function LoadOptionsFrameSettings()
	_G[parent.."_AllSoundsEnabled"]:SetChecked(not SOUND_SUSPENDED)
	_G[parent.."_Music"]:SetChecked(not SuperDuperSoundPackEngineAddonConfig.MUSIC_DISABLED)
	_G[parent.."_Sounds"]:SetChecked(not SuperDuperSoundPackEngineAddonConfig.SOUNDS_DISABLED)
	_G[parent.."_Jumping"]:SetChecked(not SuperDuperSoundPackEngineAddonConfig.JUMP_DISABLED)
	_G[parent.."_Swimming"]:SetChecked(not SuperDuperSoundPackEngineAddonConfig.SWIM_DISABLED)
	_G[parent.."_Dmg"]:SetChecked(not SuperDuperSoundPackEngineAddonConfig.DAMAGE_DISABLED)
	_G[parent.."_XP"]:SetChecked(not SuperDuperSoundPackEngineAddonConfig.XP_DISABLED)
	_G[parent.."_OnBuff"]:SetChecked(not SuperDuperSoundPackEngineAddonConfig.BUFF_DISABLED)
	_G[parent.."_OnDebuff"]:SetChecked(not SuperDuperSoundPackEngineAddonConfig.DEBUFF_DISABLED)
	_G[parent.."_BossDieing"]:SetChecked(not SuperDuperSoundPackEngineAddonConfig.BOSSDIEING_DISABLED)
	_G[parent.."_FullPower"]:SetChecked(not SuperDuperSoundPackEngineAddonConfig.FULLPOWER_DISABLED)
	_G[parent.."_DamageImmunityBuff"]:SetChecked(not SuperDuperSoundPackEngineAddonConfig.IMMUNITY_DISABLED)
	_G[parent.."_Checks"]:SetChecked(not CHECKS_DISABLED)
	if SoundPacksLoaded then
		UIDropDownMenu_SetSelectedName(_G[parent.."SoundPackDropDownMenu"], SoundPacks[SuperDuperSoundPackEngineAddonConfig.SoundPack].DisplayTitle)
		UIDropDownMenu_SetText(_G[parent.."SoundPackDropDownMenu"], SoundPacks[SuperDuperSoundPackEngineAddonConfig.SoundPack].DisplayTitle)
		UIDropDownMenu_SetText(_G[parent.."SoundPackDropDownMenu"], SoundPacks[SuperDuperSoundPackEngineAddonConfig.SoundPack].DisplayTitle)
		UpdateSoundPackDescription(SoundPacks[SuperDuperSoundPackEngineAddonConfig.SoundPack].Description)
	end
end


local function ResetDefaults()
	local SoundPack = SuperDuperSoundPackEngineAddonConfig.SoundPack
	wipe(SuperDuperSoundPackEngineAddonConfig)
	SuperDuperSoundPackEngineAddonConfig.SoundPack = SoundPack
	SOUND_SUSPENDED = nil
	CHECKS_DISABLED = nil
	if SOUNDPACK ~= SuperDuperSoundPackEngineAddonConfig.SoundPack then
		SOUNDPACK = SuperDuperSoundPackEngineAddonConfig.SoundPack
		IMMUNITYMUSIC = IsShield()
		SetMusic(1)
		TestPower()
	end
	a.Sound(SoundPackValue("slash_command_or_option_save"))
end


local function SlashHandler(msg)
	local msg = msg:lower()
	if msg:match("v") then
		print(select(2, C_AddOns.GetAddOnInfo(AddonName)).." "..C_AddOns.GetAddOnMetadata(AddonName, "Version"))
	elseif msg:match("check") then
		if CHECKS_DISABLED then
			wipe(BOSSID)
			CHECKS_DISABLED = nil
			print(select(2, C_AddOns.GetAddOnInfo(AddonName)).." "..C_AddOns.GetAddOnMetadata(AddonName, "Version")..":  "..L["Checks enabled."])
		else
			CHECKS_DISABLED = true
			print(select(2, C_AddOns.GetAddOnInfo(AddonName)).." "..C_AddOns.GetAddOnMetadata(AddonName, "Version")..":  "..L["Checks disabled for this session!"])
		end
		LoadOptionsFrameSettings()
		a.Sound(SoundPackValue("slash_command_or_option_save"))
	elseif msg:match("sou") or msg:match("aud") or msg:match("mus") then
		if SOUND_SUSPENDED then
			SOUND_SUSPENDED = nil
			SetMusic(1)
			print(select(2, C_AddOns.GetAddOnInfo(AddonName)).." "..C_AddOns.GetAddOnMetadata(AddonName, "Version")..":  "..L["Sound enabled."])
		else
			SOUND_SUSPENDED = true
			DisableMusic()
			print(select(2, C_AddOns.GetAddOnInfo(AddonName)).." "..C_AddOns.GetAddOnMetadata(AddonName, "Version")..":  "..L["Sound disabled for this session!"])
		end
		LoadOptionsFrameSettings()
		a.Sound(SoundPackValue("slash_command_or_option_save"))
	elseif msg:match("reset") or msg:match("clear") or msg:match("delete") or msg:match("erase") then
		ResetDefaults()
		LoadOptionsFrameSettings()
		print(select(2, C_AddOns.GetAddOnInfo(AddonName)).." "..C_AddOns.GetAddOnMetadata(AddonName, "Version")..": "..L["Settings have been reset!"])
	else
		Settings.OpenToCategory(L["Music"])
	end
end
SlashCmdList.SuperDuperSoundPackEngineAddon = SlashHandler
SLASH_SuperDuperSoundPackEngineAddon1 = "/soundpack"
SLASH_SuperDuperSoundPackEngineAddon2 = "/superduper"
SLASH_SuperDuperSoundPackEngineAddon3 = "/sdspe"
SLASH_SuperDuperSoundPackEngineAddon4 = "/supermariowow"
SLASH_SuperDuperSoundPackEngineAddon5 = "/mariowow"
SLASH_SuperDuperSoundPackEngineAddon6 = "/smwow"
SLASH_SuperDuperSoundPackEngineAddon7 = "/mario"
SLASH_SuperDuperSoundPackEngineAddon8 = "/smw"



local function OnUpdateRun()
	if not LOADING then
		if IsMounted() then
			if not MOUNTED then
				MOUNTED = 1
				a.Sound(SoundPackValue("mount"))
			end
		elseif MOUNTED then
			MOUNTED = nil
			a.Sound(SoundPackValue("dismount"))
		end
		if IsSwimming() then
			if not SuperDuperSoundPackEngineAddonConfig.SWIM_DISABLED and SoundPackValue("swim") and GetUnitSpeed("player") > 0 and HasFullControl() then
				if not a:IsTimer("swim") then
					a:SetTimer("swim", 0, SoundPackValue("swim_repeat_time") or 0, a.Sound, SoundPackValue("swim"))
				end
			else
				a:ClearTimer("swim")
			end
		else
			a:ClearTimer("swim")
		end
		SetMusic()
	end
end
local UpdateFrame = CreateFrame("Frame")
UpdateFrame.UpdateInterval = 0.05
UpdateFrame.TimeSinceLastUpdate = 0
local function OnUpdate(self, elapsed)
	self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed
	if self.TimeSinceLastUpdate >= self.UpdateInterval and not self.Running then
		self.Running = true
		self.TimeSinceLastUpdate = 0
		OnUpdateRun()
		self.Running = false
	end
end
UpdateFrame:SetScript("OnUpdate", OnUpdate)
UpdateFrame:Show()

local function UnitIsBossUnit(unit)
	for i = 1, 4 do
		if UnitExists("boss"..i) and UnitIsUnit(unit, "boss"..i) then
			return true
		end
	end
	return false
end

local function IsBoss(unit)
	local unit = unit or "target"
	return UnitExists(unit) and not UnitPlayerControlled(unit) and ( tostring(UnitClassification(unit)):lower():match("boss") or UnitLevel(unit) == -1 or UnitIsBossUnit(unit) )
end

local function OnEvent(self, event, ...)
	if event == "PLAYER_REGEN_DISABLED" then
			
			GROUPWIPED = nil
			InCombat = 1
			SetMusic()
			
	elseif event == "PLAYER_REGEN_ENABLED" then
			
			SPEEDMUISIC = nil
			InCombat = nil
			SetMusic()
			
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
			
			-- 8.0 暫時修正
			local _, Event, _, sourceGUID, _, _, _, GUID, _, _, _, _, SpellName, _, EventType = CombatLogGetCurrentEventInfo()
			if Event == "PARTY_KILL" and ( sourceGUID == UnitGUID("player") or sourceGUID == UnitGUID("pet") ) then
				a.Sound(SoundPackValue("kill_shot"))
			elseif Event == "UNIT_DIED" then
				if BOSSID[GUID] then
					BOSSID[GUID] = nil
					a:SetTimer("BossDied"..GetTime(), (SoundPackValue("boss_died_delay_time") or 0) + a:GetTimer("Delay"), nil, a.Sound, SoundPackValue("boss_died"))
					StopAllMusic((SoundPackValue("boss_died_play_time") or 0) + (SoundPackValue("boss_died_delay_time") or 0) + a:GetTimer("Delay"))
				elseif LAST_HIT_ENEMY_PLAYER_TARGET_GUID == GUID then
					if a:GetTimer("Delay") <= 3 then
						a:SetTimer("player_kill"..GetTime(), (SoundPackValue("helped_kill_a_player_delay_time") or 0) + a:GetTimer("Delay"), nil, a.Sound, SoundPackValue("helped_kill_a_player"))
						if not a:ReplaceTimer("Delay", (SoundPackValue("helped_kill_a_player_play_time") or 0) + (SoundPackValue("helped_kill_a_player_delay_time") or 0) + a:GetTimer("Delay")) then
							a:SetTimer("Delay", (SoundPackValue("helped_kill_a_player_play_time") or 0) + (SoundPackValue("helped_kill_a_player_delay_time") or 0) + a:GetTimer("Delay"))
						end
					end
				else
					if GUID == UnitGUID("player") then
						if a:GetTimer("Delay") <= 3 then
							a:SetTimer("PlayerDied"..GetTime(), (SoundPackValue("self_died_delay_time") or 0) + a:GetTimer("Delay"), nil, a.Sound, SoundPackValue("self_died"))
							StopAllMusic((SoundPackValue("self_died_play_time") or 0) + (SoundPackValue("self_died_delay_time") or 0) + a:GetTimer("Delay"))
						end
						IMMUNITYMUSIC = nil
						SPEEDMUISIC = nil
					end
					TestGroupWipe()
				end
			elseif Event == "SPELL_AURA_APPLIED" and GUID == UnitGUID("player") then
				if EventType == "BUFF" then
					if IsForm(SpellName) then
						if not LOADING and not a:IsTimer("buffup") then
							a:SetTimer("buffup", 1)
							a.Sound(SoundPackValue("shape_shift"))
						end
					else
						if not SuperDuperSoundPackEngineAddonConfig.BUFF_DISABLED and not a:IsTimer("buffup") then
							a:SetTimer("buffup", 1)
							a.Sound(SoundPackValue("buff_on_self"))
						end
						if not SuperDuperSoundPackEngineAddonConfig.IMMUNITY_DISABLED and not IMMUNITYMUSIC and SoundPackValue("immunity_buff_on_self") and IsShield(SpellName) then
							IMMUNITYMUSIC = 1
							if not MUSIC_DELAYED then
								SilenceMusic()
								if not a:IsRepeatTimer("immunity") then
									a:SetTimer("immunity", math.max(a:GetTimer("buffup"), a:GetTimer("immunity")), SoundPackValue("immunity_buff_on_self_repeat_time"), a.Sound, SoundPackValue("immunity_buff_on_self"))
								end
							elseif a:GetTimer("Delay") <= a:GetTimer("buffup") then
								StopAllMusic(a:GetTimer("buffup"))
							end
						end
					end
				elseif EventType == "DEBUFF" and not SuperDuperSoundPackEngineAddonConfig.DEBUFF_DISABLED and not a:IsTimer("powerdown") then
					a:SetTimer("powerdown", 1)
					a.Sound(SoundPackValue("debuff_on_self"))
				end
			elseif Event == "SPELL_AURA_REMOVED" and EventType == "BUFF" and GUID == UnitGUID("player") and IMMUNITYMUSIC and IsShield(SpellName) then
				IMMUNITYMUSIC = IsShield()
				if not IMMUNITYMUSIC then
					SetMusic()
				end
			else
				if ( sourceGUID == UnitGUID("player") or sourceGUID == UnitGUID("pet") ) and ( ( GUID == UnitGUID("target") and UnitIsPlayer("target") and UnitFactionGroup("target") ~= UnitFactionGroup("player") ) or ( not UnitExists("target") and GUID == LAST_ENEMY_PLAYER_TARGET_GUID ) ) then
					LAST_HIT_ENEMY_PLAYER_TARGET_GUID = GUID
				end
				if not SuperDuperSoundPackEngineAddonConfig.DAMAGE_DISABLED and sourceGUID == UnitGUID("player") and GUID == UnitGUID("target") and UnitCanAttack("player", "target") then
					if Event == "SPELL_DAMAGE" then
						a.Sound(SoundPackValue("target_spell_damage_from_self"))
					elseif Event == "SWING_DAMAGE" then
						a.Sound(SoundPackValue("target_swing_damage_from_self"))
					elseif Event == "RANGE_DAMAGE" then
						a.Sound(SoundPackValue("target_range_damage_from_self"))
					end
				end
			end
			
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
			
			-- 8.0 暫時修正，法術名稱改為法術ID
			local unit, spell, spellID = ...
			if UnitIsUnit(unit, "player") then
				a.Sound(SoundPackValue("my_spell_cast")[tostring(spellID)])
			elseif UnitIsUnit(unit, "pet") then
				a.Sound(SoundPackValue("pet_spell_cast")[tostring(spellID)])
			end
			
	elseif event == "PLAYER_TARGET_CHANGED" then
			
			if UnitIsPlayer("target") and UnitFactionGroup("target") ~= UnitFactionGroup("player") then
				LAST_ENEMY_PLAYER_TARGET_GUID = UnitGUID("target")
			elseif UnitExists("target") then
				LAST_ENEMY_PLAYER_TARGET_GUID = nil
			end
			
	elseif event == "PLAYER_XP_UPDATE" then
			
			if not SuperDuperSoundPackEngineAddonConfig.XP_DISABLED then
				a.Sound(SoundPackValue("honor_or_xp_gained"))
			end
			
	elseif event == "COMBAT_TEXT_UPDATE" then
			
			if not SuperDuperSoundPackEngineAddonConfig.XP_DISABLED then
				if ((select(1, ...) and (select(1, ...) == "HONOR_GAINED")) and (select(2, ...) and select(2, ...) > 0)) or ((select(1, ...) and (select(1, ...) == "FACTION")) and (select(3, ...) and (select(3, ...) > 0))) then
					a.Sound(SoundPackValue("honor_or_xp_gained"))
				end
			end
			
	elseif event == "PLAYER_ALIVE" then
			
			a:SetTimer("Reloading", 2, nil,
				function()
					if LOADING then
						MOUNTED = IsMounted()
						LOADING = nil
					end
					IMMUNITYMUSIC = IsShield()
					SetMusic(1)
				end
			)
			TestGroupWipe()
			
	elseif event == "PLAYER_ENTERING_WORLD" then
			LoadOptionsFrameSettings()
			wipe(BOSSID)
			local inInstance, instanceType = IsInInstance()
			if instanceType ~= "party" and instanceType ~= "raid" then
				inInstance = nil
			end
			if FIRSTLOAD then
				FIRSTLOAD = nil
				if not SuperDuperSoundPackEngineAddonConfig.SoundPack or not SoundPacks[SuperDuperSoundPackEngineAddonConfig.SoundPack] then
					if SoundPacks[DefaultSoundPack] then
						SuperDuperSoundPackEngineAddonConfig.SoundPack = DefaultSoundPack
					else
						SuperDuperSoundPackEngineAddonConfig.SoundPack = next(SoundPacks)
					end
				end
				SOUNDPACK = SuperDuperSoundPackEngineAddonConfig.SoundPack
				SoundPacksLoaded = not not SuperDuperSoundPackEngineAddonConfig.SoundPack
				local function Initialize(frame, level)
					for _, v in pairs(SoundPacks) do
						local info = UIDropDownMenu_CreateInfo()
						info.text = v.DisplayTitle
						-- 8.0 暫時修正，加入下面那行
						info.value = SoundPacksName[v.DisplayTitle]
						info.func = function(self)
							UIDropDownMenu_SetSelectedID(frame, self:GetID())
							UpdateSoundPackDescription(SoundPacks[self.value].Description)
							-- 8.0 暫時修正
							-- local selection = SoundPacksName[UIDropDownMenu_GetText(_G[parent.."SoundPackDropDownMenu"])]
							local selection = self.value
							if SOUNDPACK ~= selection then
								SOUNDPACK = selection
								IMMUNITYMUSIC = IsShield()
								SetMusic(1)
								TestPower()
							end
						end
						UIDropDownMenu_AddButton(info, level)
					end
				end
				UIDropDownMenu_Initialize(_G[parent.."SoundPackDropDownMenu"], Initialize)
				if SoundPacksLoaded then
					UIDropDownMenu_SetSelectedName(_G[parent.."SoundPackDropDownMenu"], SoundPacks[SuperDuperSoundPackEngineAddonConfig.SoundPack].DisplayTitle)
					UIDropDownMenu_SetText(_G[parent.."SoundPackDropDownMenu"], SoundPacks[SuperDuperSoundPackEngineAddonConfig.SoundPack].DisplayTitle)
					UpdateSoundPackDescription(SoundPacks[SuperDuperSoundPackEngineAddonConfig.SoundPack].Description)
				end
				a.Sound(SoundPackValue("start_up"))
			elseif not UnitIsDeadOrGhost("player") then
				if instanceType == "pvp" or instanceType == "arena" then
					a.Sound(SoundPackValue("enter_pvp_instance"))
				elseif inInstance ~= WASINPVEINSTANCE then
					a.Sound(SoundPackValue("enter_or_leave_pve_instance"))
				end
			end
			SilenceMusic()
			WASINPVEINSTANCE = inInstance
			if BATTLEFIELDWINNER then
				if BATTLEFIELDWINNER == 1 then
					a:SetTimer("arena_victory"..GetTime(), (SoundPackValue("arena_victory_delay_time") or 0) + a:GetTimer("Delay"), nil, a.Sound, SoundPackValue("arena_victory"))
					StopAllMusic((SoundPackValue("arena_victory_play_time") or 0) + (SoundPackValue("arena_victory_delay_time") or 0) + a:GetTimer("Delay"))
				elseif BATTLEFIELDWINNER == UnitFactionGroup("player") then
					a:SetTimer("battleground_victory"..GetTime(), (SoundPackValue("battleground_victory_delay_time") or 0) + a:GetTimer("Delay"), nil, a.Sound, SoundPackValue("battleground_victory"))
					StopAllMusic((SoundPackValue("battleground_victory_play_time") or 0) + (SoundPackValue("battleground_victory_delay_time") or 0) + a:GetTimer("Delay"))
				elseif BATTLEFIELDWINNER ~= 0 then
					a:SetTimer("lost_battleground"..GetTime(), (SoundPackValue("lost_battleground_delay_time") or 0) + a:GetTimer("Delay"), nil, a.Sound, SoundPackValue("lost_battleground"))
					StopAllMusic((SoundPackValue("lost_battleground_play_time") or 0) + (SoundPackValue("lost_battleground_delay_time") or 0) + a:GetTimer("Delay"))
				end
				BATTLEFIELDWINNER = nil
			end
			a:SetTimer("Reloading", 2, nil,
				function()
					if LOADING then
						LOADING = nil
						MOUNTED = IsMounted()
						CURRENTMONEY = GetMoney()
					end
					IMMUNITYMUSIC = IsShield()
					SetMusic(1)
				end
			)
			TestGroupWipe()
			
	elseif event == "UPDATE_BATTLEFIELD_SCORE" then
			
			if not BATTLEFIELDWINNER and GetBattlefieldWinner() then
				if select(2, IsInInstance()) == "pvp" then
					BATTLEFIELDWINNER = PLAYER_FACTION_GROUP[GetBattlefieldWinner()]
				elseif select(2, IsInInstance()) == "arena" then
					for i=1,GetNumBattlefieldScores() do
						if GetBattlefieldScore(i) == UnitName("player") then
							if select(6, GetBattlefieldScore(i)) == GetBattlefieldWinner() then
								BATTLEFIELDWINNER = 1
							else
								BATTLEFIELDWINNER = 0
							end
							break
						end
					end
				end
			end
			
	elseif event == "QUEST_ACCEPTED" then
			
			a:SetTimer("quest_accepted"..GetTime(), (SoundPackValue("quest_accepted_delay_time") or 0) + a:GetTimer("Delay"), nil, a.Sound, SoundPackValue("quest_accepted"))
			StopAllMusic((SoundPackValue("quest_accepted_play_time") or 0) + (SoundPackValue("quest_accepted_delay_time") or 0) + a:GetTimer("Delay"))
			
	elseif event == "QUEST_COMPLETED" then
			
			a:SetTimer("quest_completed"..GetTime(), (SoundPackValue("quest_completed_delay_time") or 0) + a:GetTimer("Delay"), nil, a.Sound, SoundPackValue("quest_completed"))
			StopAllMusic((SoundPackValue("quest_completed_play_time") or 0) + (SoundPackValue("quest_completed_delay_time") or 0) + a:GetTimer("Delay"))
			
	elseif event == "ACHIEVEMENT_EARNED" then
			
			a:SetTimer("achievement_earned"..GetTime(), (SoundPackValue("achievement_earned_delay_time") or 0) + a:GetTimer("Delay"), nil, a.Sound, SoundPackValue("achievement_earned"))
			StopAllMusic((SoundPackValue("achievement_earned_play_time") or 0) + (SoundPackValue("achievement_earned_delay_time") or 0) + a:GetTimer("Delay"))
			
	elseif event == "CHAT_MSG_SKILL" then
			
			a.Sound(SoundPackValue("skill_increase"))
			
	elseif event == "CONFIRM_SUMMON" then
			
			a.Sound(SoundPackValue("summoned"))
			
	elseif event == "PLAYER_MONEY" then
			
			local money = GetMoney()
			if money > CURRENTMONEY then
				a.Sound(SoundPackValue("money_gain"))
			elseif money < CURRENTMONEY then
				a.Sound(SoundPackValue("money_loss"))
			end
			CURRENTMONEY = money
			
	elseif event == "PLAYER_LEVEL_UP" then
			
			a.Sound(SoundPackValue("level_up_ding"))
			a:SetTimer("PLAYER_LEVEL_UP"..GetTime(), (SoundPackValue("level_up_chime_delay_time") or 0) + a:GetTimer("Delay"), nil, a.Sound, SoundPackValue("level_up_chime"))
			StopAllMusic((SoundPackValue("level_up_chime_play_time") or 0) + (SoundPackValue("level_up_chime_delay_time") or 0) + a:GetTimer("Delay"))
			
	elseif event == "ADDON_LOADED" then
			
			if select(1, ...) == AddonName then
				CheckVariables()
			end
			
	end
	
	TestPower()
	
	if not UnitIsDeadOrGhost("target") and ( ( not CHECKS_DISABLED and IsBoss("target") ) or ( CHECKS_DISABLED and UnitCanAttack("player", "target") and not UnitPlayerControlled("target") ) ) then
		BOSSID[UnitGUID("target")] = true
		if UnitAffectingCombat("target") then
			if not SPEEDMUISIC and InCombat and HealthPercent() <= (SoundPackValue("targeted_boss_low_health_percent") or 25) and not UnitIsDeadOrGhost("player") then
				SPEEDMUISIC = 1
				if SuperDuperSoundPackEngineAddonConfig.BOSSDIEING_DISABLED or not SoundPackValue("targeted_boss_reached_low_health") then
					if SoundPackValue("music_targeted_boss_with_low_health") then
						SetMusic()
					end
				elseif not a:IsTimer("Delay") then
					a.Sound(SoundPackValue("targeted_boss_reached_low_health"))
					StopAllMusic((SoundPackValue("targeted_boss_reached_low_health_play_time") or 0))
				end
			end
		end
		if SPEEDMUISIC and ( not InCombat or not UnitAffectingCombat("target") or HealthPercent() > (SoundPackValue("targeted_boss_low_health_percent") or 25) ) then
			SPEEDMUISIC = nil
			if SoundPackValue("music_targeted_boss_with_low_health") then
				SetMusic()
			end
		end
	end
	
end
local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:RegisterEvent("PLAYER_ALIVE")
EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
EventFrame:RegisterEvent("PLAYER_LEVEL_UP")
EventFrame:RegisterEvent("PLAYER_XP_UPDATE")
EventFrame:RegisterEvent("COMBAT_TEXT_UPDATE")
EventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
EventFrame:RegisterEvent("UPDATE_BATTLEFIELD_SCORE")
-- 8.0 暫時修正
-- EventFrame:RegisterEvent("UNIT_COMBO_POINTS")
EventFrame:RegisterEvent("UNIT_POWER_UPDATE")
EventFrame:RegisterEvent("CHAT_MSG_SKILL")
EventFrame:RegisterEvent("ACHIEVEMENT_EARNED")
EventFrame:RegisterEvent("QUEST_ACCEPTED")
-- 8.0 暫時修正
EventFrame:RegisterEvent("QUEST_FINISHED")
EventFrame:RegisterEvent("PLAYER_MONEY")
EventFrame:RegisterEvent("CONFIRM_SUMMON")
EventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
EventFrame:SetScript("OnEvent", OnEvent)


local function OnToggleGameMenu()
	a.Sound(SoundPackValue("toggle_game_or_options_menu"))
end
GameMenuFrame:HookScript("OnShow", OnToggleGameMenu)
GameMenuFrame:HookScript("OnHide", OnToggleGameMenu)
SettingsPanel:HookScript("OnShow", OnToggleGameMenu)

local function OnJump()
	if IsSwimming() then
		if not SuperDuperSoundPackEngineAddonConfig.SWIM_DISABLED and SoundPackValue("swim") and HasFullControl() and not a:IsTimer("swim") then
			a:SetTimer("swim", SoundPackValue("swim_repeat_time") or 0)
			a.Sound(SoundPackValue("swim"))
		end
	elseif not SuperDuperSoundPackEngineAddonConfig.JUMP_DISABLED and HasFullControl() and not IsFlying() and not UnitInVehicle("player") and not a:IsTimer("jump") then
		a:SetTimer("jump", SoundPackValue("jump_max_repeat_time") or 0)
		if SoundPackValue("mounted_jump") and IsMounted() then
			a.Sound(SoundPackValue("mounted_jump"))
		elseif SoundPackValue("gnome_jump") and RACE == "GNOME" then
			a.Sound(SoundPackValue("gnome_jump"))
		elseif SoundPackValue("elf_jump") and ( RACE == "BLOODELF" or ( RACE == "NIGHTELF" and not UnitIsDeadOrGhost("player") ) ) and not IsForm() then
			a.Sound(SoundPackValue("elf_jump"))
		else
			a.Sound(SoundPackValue("regular_jump"))
		end
	end
end
hooksecurefunc("JumpOrAscendStart", OnJump)

function SuperDuperSoundPackEngine_SaveOptionsFrameSettings()
	if _G[parent.."_AllSoundsEnabled"]:GetChecked() then
		if SOUND_SUSPENDED then
			SOUND_SUSPENDED = nil
			SetMusic()
		end
	elseif not SOUND_SUSPENDED then
		SOUND_SUSPENDED = true
		DisableMusic()
	end
	if _G[parent.."_Music"]:GetChecked() then
		if SuperDuperSoundPackEngineAddonConfig.MUSIC_DISABLED then
			SuperDuperSoundPackEngineAddonConfig.MUSIC_DISABLED = nil
			SetMusic()
		end
	elseif not SuperDuperSoundPackEngineAddonConfig.MUSIC_DISABLED then
		SuperDuperSoundPackEngineAddonConfig.MUSIC_DISABLED = true
		DisableMusic()
	end
	IMMUNITYMUSIC = IsShield()
	if _G[parent.."_DamageImmunityBuff"]:GetChecked() then
		if SuperDuperSoundPackEngineAddonConfig.IMMUNITY_DISABLED and IMMUNITYMUSIC and SoundPackValue("immunity_buff_on_self") then
			SuperDuperSoundPackEngineAddonConfig.IMMUNITY_DISABLED = nil
			if not a:IsRepeatTimer("immunity") then
				SetMusic()
			end
		else
			SuperDuperSoundPackEngineAddonConfig.IMMUNITY_DISABLED = nil
		end
	else
		SuperDuperSoundPackEngineAddonConfig.IMMUNITY_DISABLED = true
		if a:IsRepeatTimer("immunity") then
			SetMusic()
		end
	end
	if _G[parent.."_Checks"]:GetChecked() then
		if CHECKS_DISABLED then
			wipe(BOSSID)
			CHECKS_DISABLED = nil
		end
	else
		CHECKS_DISABLED = true
	end
	SuperDuperSoundPackEngineAddonConfig.SOUNDS_DISABLED = not _G[parent.."_Sounds"]:GetChecked() or nil
	SuperDuperSoundPackEngineAddonConfig.JUMP_DISABLED = not _G[parent.."_Jumping"]:GetChecked() or nil
	SuperDuperSoundPackEngineAddonConfig.SWIM_DISABLED = not _G[parent.."_Swimming"]:GetChecked() or nil
	SuperDuperSoundPackEngineAddonConfig.DAMAGE_DISABLED = not _G[parent.."_Dmg"]:GetChecked() or nil
	SuperDuperSoundPackEngineAddonConfig.XP_DISABLED = not _G[parent.."_XP"]:GetChecked() or nil
	SuperDuperSoundPackEngineAddonConfig.BUFF_DISABLED = not _G[parent.."_OnBuff"]:GetChecked() or nil
	SuperDuperSoundPackEngineAddonConfig.DEBUFF_DISABLED = not _G[parent.."_OnDebuff"]:GetChecked() or nil
	SuperDuperSoundPackEngineAddonConfig.BOSSDIEING_DISABLED = not _G[parent.."_BossDieing"]:GetChecked() or nil
	SuperDuperSoundPackEngineAddonConfig.FULLPOWER_DISABLED = not _G[parent.."_FullPower"]:GetChecked() or nil
	TestPower()
	if SoundPacksLoaded then
		-- 8.0 暫時修正
		-- SuperDuperSoundPackEngineAddonConfig.SoundPack = SoundPacksName[UIDropDownMenu_GetText(_G[parent.."SoundPackDropDownMenu"])]
		if  SuperDuperSoundPackEngineAddonConfig.SoundPack ~= SOUNDPACK then
			SuperDuperSoundPackEngineAddonConfig.SoundPack = SOUNDPACK
			SetMusic(1)
		end
	end
	a.Sound(SoundPackValue("slash_command_or_option_save"))
end

local function LocalizeFontStrings(frame)
	for _, f in next, {frame:GetChildren()} do
		if f:GetObjectType() == "FontString" then
			f:SetText(L[f:GetText()])
		else
			for _, f in next, {f:GetRegions()} do
				if f:GetObjectType() == "FontString" then
					f:SetText(L[f:GetText()])
				end
			end
		end
	end
end

function SuperDuperSoundPackEngine.OptionsFrame_OnLoad(self)
	parent = self:GetName()
	LocalizeFontStrings(self)
	_G[parent.."TitleString"]:SetText(select(2, C_AddOns.GetAddOnInfo(AddonName)).." "..C_AddOns.GetAddOnMetadata(AddonName, "Version"))
	self.name = L["Music"]
	-- self.okay = SaveOptionsFrameSettings
	self.cancel = function(self)
		if SOUNDPACK ~= SuperDuperSoundPackEngineAddonConfig.SoundPack then
			SOUNDPACK = SuperDuperSoundPackEngineAddonConfig.SoundPack
			SetMusic(1)
			TestPower()
		end
		a.Sound(SoundPackValue("toggle_game_or_options_menu"))
	end
	self.refresh = LoadOptionsFrameSettings
	self.default = ResetDefaults
	local category = Settings.RegisterCanvasLayoutCategory(self, self.name)
	category.ID = self.name
	Settings.RegisterAddOnCategory(category)
end

