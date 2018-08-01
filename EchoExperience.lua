EchoExperience = {
    name            = "EchoExperience",           -- Matches folder and Manifest file names.
    version         = "0.0.6",                    -- A nuisance to match to the Manifest.
    author          = "Echomap",
    menuName        = "EchoExperience_Options",   -- Unique identifier for menu object.
    menuDisplayName = "EchoExperience",
    -- Saved settings.
    savedVariables = {},
}
local 	msgTypeSYS     = 1
local	msgTypeEXP     = 2
local   msgTypeLOOT    = 3

local defaultSettings = {
	sversion   = EchoExperience.version,
    debug      = false,
	showExp    = true,
	verboseExp = true,
    tab        = 1,
    window     = 1,
	rgba    = {
      ["r"] = 1,
      ["g"] = 1,
      ["b"] = 1,
      ["a"] = 0.9,
	},
	showLoot   = false,
	groupLoot  = false,
	tabloot    = 1,
    windowloot = 1,
	rgba2   = {
      ["r"] = 1,
      ["g"] = 1,
      ["b"] = 1,
      ["a"] = 0.9,
	},
}

function EchoExperience.debugMsg(text)
	if EchoExperience.savedVariables.debug then
		d("(" .. EchoExperience.name .. ") " .. text);
	end
end
function EchoExperience.outputToChanel(text,msgType)
	local lTab = 0
	local lWin = 0
	if msgType == msgTypeSYS then
		--
	elseif msgType == msgTypeEXP then
		lTab = EchoExperience.savedVariables.tab
		lWin  = EchoExperience.savedVariables.window
	elseif msgType == msgTypeLOOT then
		lTab = EchoExperience.savedVariables.tabloot
		lWin  = EchoExperience.savedVariables.windowloot
	else
		--
	end
	EchoExperience.debugMsg("EE. lTab="..tostring(lTab) .." lWin="..tostring(lWin) .." msgType="..tostring(msgType) )

	if (lTab == nil or lTab < 1) then
		d(text);
	else
		--CHAT_SYSTEM:AddMessage(<message String>)' --container 1-10
		local text2 = EchoExperience:ColorizeText(text,msgType)
		CHAT_SYSTEM.containers[lWin].windows[lTab].buffer:AddMessage(text2)
	end
end

-- Wraps text with a color.
function EchoExperience.Colorize(text, color)
    if  color == nil then return text end
    text = "|c" .. color .. text .. "|r"
    return text
end

-- Wraps text with a color.
function EchoExperience:ColorizeText(text,msgType)
	local rgba = EchoExperience.savedVariables.rgba
	if msgType == msgTypeSYS then
		return text
	elseif msgType == msgTypeEXP then
		rgba = EchoExperience.savedVariables.rgba
	elseif msgType == msgTypeLOOT then
		rgba = EchoExperience.savedVariables.rgba2
	else
		return text
	end
	if rgba == nil then return text end
	--d("ct: text="..text)
	--if EchoExperience.savedVariables.rgba == nil then return text end
	--local rgba = EchoExperience.savedVariables.rgba
	--if(msgType~=nil and msgType==2) then
	--	rgba = EchoExperience.savedVariables.rgba2
	--end
	local c = ZO_ColorDef:New(rgba.r,rgba.g,rgba.b,rgba.a)
	text = c:Colorize(text)
    return text
end

function EchoExperience.SlashCommandHandler(text)
	EchoExperience.debugMsg("SlashCommandHandler: " .. text)
	local options = {}
	local searchResult = { string.match(text,"^(%S*)%s*(.-)$") }
	for i,v in pairs(searchResult) do
		if (v ~= nil and v ~= "") then
		    options[i] = string.lower(v)
		end
	end

	if #options == 0 or options[1] == "help" then
		-- Display help
	elseif #options == 0 or options[1] == "testexp" then
		EchoExperience.outputToChanel("Gained 0 xp in [Test] (1000/10000) need 9000xp",msgTypeEXP)
	elseif #options == 0 or options[1] == "testloot" then
		EchoExperience.outputToChanel("You looted TESTITEM.",msgTypeLOOT)
	elseif #options == 0 or options[1] == "testfull" then
		--eventCode,receivedBy,itemName,quantity,soundCategory,lootType,isSelf,isPickpocketLoot,questItemIcon,itemId,isStolen)
		EchoExperience.OnLootReceived(0,"testuser","testitem",1,nil,nil,true,false,false,0,false)
		EchoExperience.OnLootReceived(0,"testuser","testitem",2,nil,nil,true,false,false,0,false)
		EchoExperience.OnLootReceived(0,"testuser","testitem",2,nil,nil,false,false,false,0,false)
	elseif #options == 0 or options[1] == "debug" then
		local dg = EchoExperience.savedVariables.debug
		EchoExperience.savedVariables.debug = not dg
		d("EchoExperience: Debug = " .. tostring(EchoExperience.savedVariables.debug) )
	elseif (#options == 0 or options[1] == "tab") and options[2] ~= nil then
		d("EchoExperience: tab = " .. tostring(options[2]) )
		EchoExperience.savedVariables.tab = tonumber(options[2])
	elseif (#options == 0 or options[1] == "window") and options[2] ~= nil then
		d("EchoExperience: window = " .. tostring(options[2]) )
		EchoExperience.savedVariables.window = tonumber(options[2])
	end

end

function EchoExperience.OnSkillExperienceUpdate(eventCode, skillType, skillIndex, reason, rank, previousXP, currentXP)
	EchoExperience.debugMsg("OnSkillExperienceUpdate")
	--[[
	if EchoExperience.savedVariables.debug then
		d(EchoExperience.name .. " eventCode="  .. eventCode
		.. " eventCode="  .. eventCode
		.. " skillType="  .. skillType
		.. " skillIndex=" .. skillIndex
		.. " reason="     .. reason
		.. " rank="       .. rank
		.. " previousXP=" .. previousXP
		.. " currentXP="  .. currentXP)
	end
	]]
	local skillLineName, currentSkillRank, available = GetSkillLineInfo(skillType, skillIndex)
	--if EchoExperience.savedVariables.debug then
		--d(EchoExperience.name .. " skillLineName="     .. skillLineName
		--.. " currentSkillRank="  .. currentSkillRank
		--.. " available="         .. tostring(available) )
	--end
	--[[
	if not available then
		if EchoExperience.savedVariables.debug then
		d(EchoExperience.name .. "(CANT USE)"
		.." name=".. skillLineName
		.." eventCode=".. eventCode
		.." skillType="  .. skillType
		.." skillIndex=" .. skillIndex
		)
		end
	end
	]]
	local lastRankXP, nextRankXP, currentXP = GetSkillLineXPInfo(skillType, skillIndex)
	if EchoExperience.savedVariables.debug and available then
		d(EchoExperience.name .."name="..skillLineName .." lastRankXP="..lastRankXP .." nextRankXP=".. nextRankXP .." currentXP=".. currentXP)
	end

	-- Output
	local diff = nextRankXP - currentXP
	if skillLineName ~= nil and available and EchoExperience.savedVariables.verboseExp then
		local XPgain  = currentXP - previousXP
		local curCur  = currentXP - lastRankXP
		local curNext = nextRankXP - lastRankXP
		--EchoExperience.outputToChanel("You gained [" .. XPgain .. "] experience in [" .. skillLineName .."]")
		--EchoExperience.outputToChanel("    at "..curCur.."/"..curNext..", need [" .. diff .. "] more, experience")
		EchoExperience.outputToChanel("Gained "..XPgain.."xp in [" ..skillLineName.."] ("..curCur.."/"..curNext..") need " .. diff .. "xp",msgTypeEXP)
	end
end

function EchoExperience.OnSkillLineAdded(event, eventCode, skillType, skillIndex)
	EchoExperience.debugMsg("OnSkillLineAdded. skillType="..tostring(skillType) .. " skillIndex="..tostring(skillIndex))
	--EchoExperience.outputToChanel("Gained "..XPgain.."xp in [" ..skillLineName.."] ("..curCur.."/"..curNext..") need " .. diff .. "xp",msgTypeEXP)
end

function EchoExperience.OnChampionUnlocked(eventCode)
	EchoExperience.debugMsg("OnChampionUnlocked")
	EchoExperience.outputToChanel("You unlocked Champion points!".." eventcode="..tostring(eventCode),msgTypeEXP)
end


--EVENT_DISCOVERY_EXPERIENCE
-- (num eventCode, str areaName, num level, num previousExperience, num currentExperience, num championPoints)
function EchoExperience.OnDiscoveryExperienceGain(event, eventCode, areaName, level, previousExperience, currentExperience, championPoints)
	EchoExperience.debugMsg("OnDiscoveryExperienceGain Called")
	--local XPgain = currentExperience - previousExperience -
	--EchoExperience.outputToChanel("You gained " .. XPgain .. " experience.",msgTypeEXP)
	if EchoExperience.savedVariables.debug then
		d(EchoExperience.name .. " previousExperience=" .. previousExperience
		.. " currentExperience="  .. currentExperience
		.. " eventCode=" .. eventCode
		.. " reason=" .. areaName
		.. "level="  .. level
		.. " champ="  .. tostring(championPoints) )
	end

	--TODO championPoints
	EchoExperience.debugMsg("OnDiscoveryExperienceGain Done")
end

--EVENT_ALLIANCE_POINT_UPDATE OnAlliancePtGain
-- (number eventCode, number alliancePoints, boolean playSound, number difference, CurrencyChangeReason reason)
function EchoExperience.OnAlliancePtGain(eventCode,  alliancePoints,  playSound,  difference,  reason)
	EchoExperience.debugMsg("OnAlliancePtGain Called")
	if difference < 0 then
		local Ldifference = difference*-1.0
		EchoExperience.outputToChanel("You subtracted " .. Ldifference .. " AP.",msgTypeEXP)
	else
		EchoExperience.outputToChanel("You gained " .. difference .. " AP.",msgTypeEXP)
	end
	EchoExperience.debugMsg("OnAlliancePtGain Done")
end

--(number eventCode, ProgressReason reason, number level, number previousExperience, number currentExperience, number championPoints)
--_, _, _, prevXp, curXp, championPoints)
function EchoExperience.OnExperienceGain(event, eventCode, reason, level, previousExperience, currentExperience, championPoints)
	EchoExperience.debugMsg("OnExperienceGain Called")
	--if ( unitTag ~= 'player' ) then return end
	--local xpPrev = previousExperience;
	if EchoExperience.savedVariables.debug then
		d(EchoExperience.name .. " previousExperience=" .. previousExperience
		.. " currentExperience="  .. currentExperience
		.. " eventCode=" .. eventCode
		.. " reason=" .. reason
		.. " level="  .. level
		.. " champ="  .. tostring(championPoints)) --allways nil?
	end
	local XPgain = previousExperience - level
	EchoExperience.outputToChanel("You gained " .. XPgain .. " experience.",msgTypeEXP)

	--TODO championPoints
	EchoExperience.debugMsg("OnExperienceGain Done")
end

--EVENT_LOOT_RECEIVED
--(num eventCode, str receivedBy, str itemName, num quantity,
--ItemUISoundCategory soundCategory, LootItemType lootType,
--bool self, bool isPickpocketLoot, str questItemIcon, num itemId, bool isStolen)
--LOOTTPE=    LOOT_TYPE_ANY,    LOOT_TYPE_CHAOTIC_CREATIA, ,    LOOT_TYPE_COLLECTIBLE,     LOOT_TYPE_ITEM,     LOOT_TYPE_MONEY,     LOOT_TYPE_QUEST_ITEM,     LOOT_TYPE_STYLE_STONES,     LOOT_TYPE_TELVAR_STONES,    LOOT_TYPE_WRIT_VOUCHERS
function EchoExperience.OnLootReceived(eventCode,receivedBy,itemName,quantity,soundCategory,lootType,isSelf,isPickpocketLoot,questItemIcon,itemId,isStolen)
	if(isSelf) then
		local verb2 = 1
		if(quantity>1) then verb2 = 2 end
		local verb = GetString("SI_ECHOLOOT_YOU_GAIN_",verb2)

		if(isPickpocketLoot) then
			verb = GetString("SI_ECHOLOOT_YOU_PICK_",verb2)
		elseif(lootType==LOOT_TYPE_QUEST_ITEM)then
			verb = GetString("SI_ECHOLOOT_YOU_QUEST_",verb2)
		end
		local strL = string.format(verb,tostring(itemName),tostring(quantity))
		EchoExperience.outputToChanel(strL,msgTypeLOOT)
	elseif (EchoExperience.savedVariables.groupLoot and receivedBy~=nil) then
		local verb2 = 1
		if(quantity>1) then verb2 = 2 end
		local verb = GetString(SI_ECHOLOOT_OTHER_GAIN)

		if(isPickpocketLoot) then
			verb = GetString(SI_ECHOLOOT_OTHER_PICK)
		elseif(lootType==LOOT_TYPE_QUEST_ITEM) then
			verb = GetString(SI_ECHOLOOT_OTHER_QUEST)
		end
		local strL = string.format(verb,receivedBy,tostring(itemName))
		EchoExperience.outputToChanel(strL,msgTypeLOOT)
	end
end

--https://wiki.esoui.com/Events
--EVENT_CLAIM_LEVEL_UP_REWARD_RESULT
--EVENT_DISCOVERY_EXPERIENCE (
--EVENT_LEVEL_UPDATE
function EchoExperience.SetupExpGainsEvents(reportMe)
	if (EchoExperience.savedVariables.showExp) then
		if(reportMe) then
			EchoExperience.outputToChanel("EchoExp is showing Experience Gains",msgTypeSYS)
		end
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."SkillXPGain",	EVENT_SKILL_XP_UPDATE,     EchoExperience.OnSkillExperienceUpdate)
		--EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnCombatState",	EVENT_PLAYER_COMBAT_STATE, EchoExperience.OnCombatState )
		--EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."AbilityProgression",EVENT_ABILITY_PROGRESSION_XP_UPDATE, EchoExperience.OnAbitilyExperienceUpdate)
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."SkillLineAdded",	EVENT_SKILL_LINE_ADDED,  EchoExperience.OnSkillLineAdded)
		--TODO dont need sometimes
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."ChampionUnlocked", EVENT_CHAMPION_SYSTEM_UNLOCKED, EchoExperience.OnChampionUnlocked)
		--EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."XPUpdate",		EVENT_EXPERIENCE_UPDATE, EchoExperience.OnExperienceUpdate)
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."XPGain",		EVENT_EXPERIENCE_GAIN,   EchoExperience.OnExperienceGain)
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnAlliancePtGain",		EVENT_ALLIANCE_POINT_UPDATE,   EchoExperience.OnAlliancePtGain)
		--
	else
		if(reportMe) then
			EchoExperience.outputToChanel("EchoExp is no longer showing Experience Gains",msgTypeSYS)
		end
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."SkillXPGain",	EVENT_SKILL_XP_UPDATE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."SkillLineAdded",	EVENT_SKILL_LINE_ADDED)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."ChampionUnlocked", EVENT_CHAMPION_SYSTEM_UNLOCKED)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."XPGain",		EVENT_EXPERIENCE_GAIN)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnAlliancePtGain",		EVENT_ALLIANCE_POINT_UPDATE)
	end
end
function EchoExperience.SetupLootGainsEvents(reportMe)
	if (EchoExperience.savedVariables.showLoot) then
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."LootReceived",	EVENT_LOOT_RECEIVED, EchoExperience.OnLootReceived)
		if(reportMe) then
			EchoExperience.outputToChanel("EchoExp is showing Loot Gains",msgTypeSYS)
		end
	else
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."LootReceived",	EVENT_LOOT_RECEIVED, EchoExperience.OnLootReceived)
		if(reportMe) then
			EchoExperience.outputToChanel("EchoExp is no longer showing Loot Gains",msgTypeSYS)
		end
	end

end

function EchoExperience.DelayedStart()
	-- Experience Related
	EchoExperience.SetupExpGainsEvents()
	-- Loot Related
	EchoExperience.SetupLootGainsEvents()
end

function EchoExperience.OnAddOnUnloaded(event)
  --EchoExperience.debugMsg("OnAddOnUnloaded called") -- Prints to chat.
  --EchoExperience:Savesettings()
  --EchoExperience.debugMsg("OnAddOnUnloaded done") -- Prints to chat.
end

function EchoExperience.Activated(e)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name, EVENT_PLAYER_ACTIVATED)
    --d(EchoExperience.name .. GetString(SI_ECHOEXP_MESSAGE)) -- Prints to chat.
    --ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil,
    --    EchoExperience.name .. GetString(SI_NEW_ADDON_MESSAGE)) -- Top-right alert.
    zo_callLater(EchoExperience.DelayedStart, 3000)
end
-- When player is ready, after everything has been loaded.
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_PLAYER_ACTIVATED, EchoExperience.Activated)

function EchoExperience.OnAddOnLoaded(event, addonName)
    if addonName ~= EchoExperience.name then return end
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name, EVENT_ADD_ON_LOADED)

    EchoExperience.savedVariables = ZO_SavedVars:New("EchoExperienceSavedVariables", 1, nil, defaultSettings)

    -- Settings menu in Settings.lua.
    --EchoExperience:RestoreSettings()
    EchoExperience.LoadSettings() --Setup Addon Settings MENU

    -- Slash commands must be lowercase. Set to nil to disable.
    SLASH_COMMANDS["/echoexp"] = EchoExperience.SlashCommandHandler
    -- Reset autocomplete cache to update it.
    SLASH_COMMAND_AUTO_COMPLETE:InvalidateSlashCommandCache()
end
-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_ADD_ON_LOADED, EchoExperience.OnAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_PLAYER_DEACTIVATED, EchoExperience.OnAddOnUnloaded)
