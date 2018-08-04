EchoExperience = {
    name            = "EchoExperience",           -- Matches folder and Manifest file names.
    version         = "0.0.8",                    -- A nuisance to match to the Manifest.
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

-- Main Output Function used by addon to control output and style
function EchoExperience.outputToChanel(text,msgType)
	--EchoExperience.debugMsg("EEOTC: text='"..text.."' msgType='"..msgType.."'")
	--Output to where
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
	--EchoExperience.debugMsg("EE. lTab="..tostring(lTab) .." lWin="..tostring(lWin) .." msgType="..tostring(msgType) )

	--Output what
	if( text == nil or text == "" ) then
		return
	end
	if (lTab == nil or lTab < 1) then
		d(text)
	else
		--CHAT_SYSTEM:AddMessage(<message String>)' --container 1-10
		local text2 = EchoExperience:ColorizeText(text,msgType)
		CHAT_SYSTEM.containers[lWin].windows[lTab].buffer:AddMessage(text2)
	end
end

-- Helper that Wraps text with a color.
function EchoExperience.Colorize(text, color)
    if  color == nil then return text end
    text = "|c" .. color .. text .. "|r"
    return text
end

-- Helper that Wraps text with a color.
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
	if rgba == nil then
		return text
	end

	local c = ZO_ColorDef:New(rgba.r,rgba.g,rgba.b,rgba.a)
	text = c:Colorize(text)
    return text
end

-- SLASH
function EchoExperience.SlashCommandHandler(text)
	--EchoExperience.debugMsg("SlashCommandHandler: " .. text)
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

-----------------------------
-- ON EVENT Functions here --
-----------------------------

--ONEvent  shows skill exp gains
--EVENT:   EVENT_SKILL_XP_UPDATE
--RETURNS:(num eventCode, SkillType skillType, num skillIndex, num reason, num rank, num previousXP, num currentXP)
--NOTES:  XX
function EchoExperience.OnSkillExperienceUpdate(eventCode, skillType, skillIndex, reason, rank, previousXP, currentXP)

	local skillLineName, currentSkillRank, available = GetSkillLineInfo(skillType, skillIndex)

	local lastRankXP, nextRankXP, currentXP = GetSkillLineXPInfo(skillType, skillIndex)
	--if available then
		--EchoExperience.debugMsg(" name="..skillLineName .." lastRankXP="..lastRankXP .." nextRankXP=".. nextRankXP .." currentXP=".. currentXP)
	--end

	-- Output
	local diff = nextRankXP - currentXP
	if skillLineName ~= nil and available and EchoExperience.savedVariables.verboseExp then
		local XPgain  = currentXP - previousXP
		local curCur  = currentXP - lastRankXP
		local curNext = nextRankXP - lastRankXP
		--EchoExperience.outputToChanel("You gained [" .. XPgain .. "] experience in [" .. skillLineName .."]")
		--EchoExperience.outputToChanel("    at "..curCur.."/"..curNext..", need [" .. diff .. "] more, experience")
		--FORMAT
		local strI = GetString(SI_ECHOEXP_XP_SKILL_GAIN)
		local strL = zo_strformat(strI, XPgain, skillLineName, curCur, curNext, diff )
		EchoExperience.outputToChanel(strL,msgTypeEXP)
		--EchoExperience.outputToChanel("Gained "..XPgain.."xp in [" ..skillLineName.."] ("..curCur.."/"..curNext..") need " .. diff .. "xp",msgTypeEXP)
	end
end

--ONEvent  TODO
--EVENT:   xx
--RETURNS: (number eventCode, SkillType skillType, number skillIndex, boolean advised)
--NOTES:  XX
function EchoExperience.OnSkillLineAdded(eventCode, skillType, skillIndex)
	--EchoExperience.debugMsg("OnSkillLineAdded. skillType="..tostring(skillType) .. " skillIndex="..tostring(skillIndex))
	EchoExperience.debugMsg("echoexp test osla: skillType="..tostring(skillType) .. " skillIndex="..tostring(skillIndex))
	--learn clothing, skillType=3 skillIndex=false
	if skillType ~= nil then
		local name, rank, discovered, skillLineId, advised, unlockText = GetSkillLineInfo(skillType, skillIndex)
		EchoExperience.debugMsg("echoexp test osla: name="..tostring(name) .. " discovered="..tostring(discovered))
		--GetSkillLineInfo(number SkillType skillType, number skillIndex)
        --Returns: string name, number rank, boolean discovered, number skillLineId, boolean advised, string unlockText
		if name ~= nil then --TODO discovered and ??
			--local strI = "You learned the skillline, <<1>>"
			local strI = GetString(SI_ECHOEXP_SKILLINE)
			local strL = zo_strformat(strI, name)
			EchoExperience.outputToChanel(strL,msgTypeEXP)
		end
	end
end

--ONEvent  TODO
--EVENT:   xx
--RETURNS:(num eventCode, xx)
function EchoExperience.OnChampionUnlocked(eventCode)
	--EchoExperience.debugMsg("OnChampionUnlocked")
	--FORMAT
	local strI = GetString(SI_ECHOEXP_CP_UNLOCKED)
	EchoExperience.outputToChanel(strI.." eventcode="..tostring(eventCode),msgTypeEXP)
	--EchoExperience.outputToChanel("You unlocked Champion points!".." eventcode="..tostring(eventCode),msgTypeEXP)
end

--ONEvent  NOT NEEDED
--EVENT:   EVENT_ABILITY_PROGRESSION_XP_UPDATE
--RETURNS:(number eventCode, number progressionIndex, number lastRankXP, number nextRankXP, number currentXP, boolean atMorph)
--NOTES:  currentXP is new total xp, last is all the way back.
function EchoExperience.OnAbilityExperienceUpdate(eventCode, progressionIndex, lastRankXP, nextRankXP, currentXP, atMorph)
	--EchoExperience.debugMsg("OnAbilityExperienceUpdate Called")
	--EchoExperience.debugMsg("OnAbilityExperienceUpdate eventCode="..eventCode.." progressionIndex="..progressionIndex .." lastRankXP="..lastRankXP
	--.." nextRankXP="..nextRankXP
	--.." currentXP="..currentXP
	--.." atMorph="..tostring(atMorph)
	--)
	local name, morph, rank = GetAbilityProgressionInfo(progressionIndex)
	--EchoExperience.outputToChanel("You gained exp in "..name.."." )
	--EchoExperience.debugMsg("OnAbilityExperienceUpdate Done")
end

--ONEvent  shows that you discovered something/somewhere
--EVENT:   EVENT_DISCOVERY_EXPERIENCE
--RETURNS:(num eventCode, str areaName, num level, num previousExperience, num currentExperience, num championPoints)
--NOTES:  XX
function EchoExperience.OnDiscoveryExperienceGain(event, eventCode, areaName, level, previousExperience, currentExperience, championPoints)
	--EchoExperience.debugMsg("OnDiscoveryExperienceGain Called")
	--local XPgain = currentExperience - previousExperience -
	--EchoExperience.outputToChanel("You gained " .. XPgain .. " experience.",msgTypeEXP)
	--[[
	if EchoExperience.savedVariables.debug then
		d(EchoExperience.name .. " OnDiscovery: "
		.. " previousExperience=" .. previousExperience
		.. " currentExperience="  .. currentExperience
		.. " eventCode=" .. eventCode
		.. " reason=" .. areaName
		.. " level="  .. level
		.. " areaName="  .. areaName
		.. " champ="  .. tostring(championPoints)
		)
	end
	]]
	local strI = GetString(SI_ECHOEXP_DISCOVERY)
	local strL = zo_strformat(strI, eventCode )
	EchoExperience.outputToChanel(strL,msgTypeEXP)
	--TODO championPoints??
	--EchoExperience.debugMsg("OnDiscoveryExperienceGain Done")
end

--ONEvent  TODO   WORKING ON
--EVENT:   EVENT_SKILL_POINTS_CHANGED
--RETURNS:(num eventCode, num pointsBefore, num pointsNow, num partialPointsBefore, num partialPointsNow)
--NOTES:  Hopefully Skyshards are the only thing that gives partial points
function EchoExperience.OnSkillPtChange(eventCode, pointsBefore, pointsNow, partialPointsBefore, partialPointsNow)
	--EchoExperience.debugMsg("OnSkillPtChange Called")
	EchoExperience.debugMsg("EE skptchange: eventCode="..tostring(eventCode) .." pointsBefore="..tostring(pointsBefore).." pointsNow="..tostring(pointsNow)
	.." partialPointsBefore="..tostring(partialPointsBefore).." partialPointsNow="..tostring(partialPointsNow)
	)
	local skyShardSkillUP = false
	if partialPointsBefore~=nil and partialPointsNow~=nil and partialPointsBefore==2 and partialPointsNow==0 then
		skyShardSkillUP = true
	end
	if pointsBefore > pointsNow then
		EchoExperience.debugMsg("Returned since probably just spend points")
		return
	end
	if partialPointsBefore~=nil and partialPointsNow~=nil and partialPointsNow > partialPointsBefore then
		EchoExperience.debugMsg("echoexp(ospc test): eventCode="..tostring(eventCode))
		local strI = GetString(SI_ECHOEXP_SKY_1)
		--local strI = "You absorbed a skyshard! (<<1>> of <<2>>)."
		local strL = zo_strformat(strI, partialPointsNow, 3 )
		EchoExperience.outputToChanel(strL,msgTypeEXP)
	end
	if pointsBefore~=nil and partialPointsNow~=nil and pointsNow > pointsBefore then
		EchoExperience.debugMsg("echoexp(ospc test): eventCode="..tostring(eventCode))
		local diff =  pointsNow - pointsBefore
		local strI = GetString(SI_ECHOEXP_SKY_2)
		--local strI = "You gained a skill point! (<<1>>)."
		local strL = zo_strformat(strI, diff )
		EchoExperience.outputToChanel(strL,msgTypeEXP)
	end
	--[[
	if partialPointsBefore~=nil and partialPointsNow~=nil and partialPointsBefore==2 and partialPointsNow=0 then
		--local strI = GetString(SI_ECHOEXP_SKILL_GAIN)
		local strI = "You absorbed a skyshard <<1>> of <<2>>."
		local strL = zo_strformat(strI,pointsBefore, pointsNow )
		--EchoExperience.outputToChanel(strL,msgTypeEXP)
	end
	]]
	--EchoExperience.debugMsg("OnSkillPtChange Done")
end

--ONEvent  shows alliance point gains
--EVENT:   EVENT_ALLIANCE_POINT_UPDATE
--RETURNS:(num eventCode, num alliancePoints, bool playSound, num difference, CurrencyChangeReason reason)
--NOTES:  XX
function EchoExperience.OnAlliancePtGain(eventCode,  alliancePoints,  playSound,  difference,  reason)
	EchoExperience.debugMsg("OnAlliancePtGain Called. eventCode=".. eventCode..", reason="..reason..".")
	if difference < 0 then
		local Ldifference = difference*-1.0
		--FORMAT
		local strI = GetString(SI_ECHOEXP_AP_LOSS)
		local strL = zo_strformat(strI, Ldifference )
		EchoExperience.outputToChanel(strL,msgTypeEXP)
		--EchoExperience.outputToChanel("You subtracted " .. Ldifference .. " AP.",msgTypeEXP)
	else
		--FORMAT
		local strI = GetString(SI_ECHOEXP_AP_GAIN)
		local strL = zo_strformat(strI, difference )
		EchoExperience.outputToChanel(strL,msgTypeEXP)
		--EchoExperience.outputToChanel("You gained " .. difference .. " AP.",msgTypeEXP)
	end
	--EchoExperience.debugMsg("OnAlliancePtGain Done")
end

--ONEvent  shows skill exp gains and CP gains
--EVENT:   EVENT_EXPERIENCE_GAIN
--RETURNS:(num eventCode, ProgressReason reason, num level, num previousExperience, num currentExperience, num championPoints)
--NOTES:  XX
function EchoExperience.OnExperienceGain(event, eventCode, reason, level, previousExperience, currentExperience, championPoints)
	--EchoExperience.debugMsg("OnExperienceGain Called")
	--if ( unitTag ~= 'player' ) then return end
	--local xpPrev = previousExperience;
	--[[
	EchoExperience.debugMsg(EchoExperience.name .. " previousExperience=" .. previousExperience
		.. " currentExperience="  .. currentExperience
		.. " eventCode=" .. eventCode
		.. " reason=" .. reason
		.. " level="  .. level
		.. " champ="  .. tostring(championPoints)) --allways nil?
	]]
	local XPgain = previousExperience - level
	--FORMAT
	local strI = GetString(SI_ECHOEXP_XP_GAIN)
	local strL = zo_strformat(strI, XPgain )
	EchoExperience.outputToChanel(strL,msgTypeEXP)
	--EchoExperience.outputToChanel("You gained " .. XPgain .. " experience.",msgTypeEXP)
	if(championPoints) then
		local strI = GetString(SI_ECHOEXP_CP_EARNED)
		local strL = zo_strformat(strI, championPoints)
		EchoExperience.outputToChanel(strL,msgTypeEXP)
		--EchoExperience.outputToChanel("You gained " .. tostring(championPoints) .. " CP(3).",msgTypeEXP)
	end
	--EchoExperience.debugMsg("OnExperienceGain Done")
end

--ONEvent  shows loot gains
--EVENT:   EVENT_LOOT_RECEIVED
--RETURNS:(num eventCode, str receivedBy, str itemName, num quantity,
--			ItemUISoundCategory soundCategory, LootItemType lootType,
--			bool self, bool isPickpocketLoot, str questItemIcon, num itemId, bool isStolen)
--NOTES:  XX
--LOOTTPE=LOOT_TYPE_ANY,LOOT_TYPE_CHAOTIC_CREATIA, LOOT_TYPE_COLLECTIBLE, LOOT_TYPE_ITEM, LOOT_TYPE_MONEY,
--				LOOT_TYPE_QUEST_ITEM, LOOT_TYPE_STYLE_STONES, LOOT_TYPE_TELVAR_STONES,LOOT_TYPE_WRIT_VOUCHERS
function EchoExperience.OnLootReceived(eventCode,receivedBy,itemName,quantity,soundCategory,lootType,isSelf,isPickpocketLoot,questItemIcon,itemId,isStolen)
	--Search on ESOUI Source Code GetItemLinkQuality(string itemLink)
	--Returns: number ItemQuality quality

	local traitIS = nil
	if lootType ~= nil then
		--if itemType ~= ITEMTYPE_ARMOR_TRAIT and itemType ~= ITEMTYPE_WEAPON_TRAIT then
		traitIS = EchoExperience:GetTraitInfo(itemName)
		--end
		EchoExperience.debugMsg(EchoExperience.name
			.." lootType=" .. tostring(lootType)
			.." traitIS="  .. tostring(traitIS)
		)
	end

	if(isSelf) then
		--<<1>> is itemname
		--<<2>> is quantity
		local qualifier = 1
		if(quantity>1 and traitIS ~=nil) then
			qualifier = 4
		elseif(quantity>1) then
			qualifier = 2
		elseif traitIS ~=nil then
			qualifier = 3
		end
		local sentence = GetString("SI_ECHOLOOT_YOU_GAIN_",qualifier)
		if(isPickpocketLoot) then
			sentence = GetString("SI_ECHOLOOT_YOU_PICK_",qualifier)
		elseif(lootType==LOOT_TYPE_QUEST_ITEM)then
			sentence = GetString("SI_ECHOLOOT_YOU_QUEST_",qualifier)
		end
		--local strL = string.format(verb,tostring(itemName),tostring(quantity))
		local strL = zo_strformat(sentence, tostring(itemName), tostring(quantity), tostring(traitIS) )
		EchoExperience.outputToChanel(strL,msgTypeLOOT)
	elseif (EchoExperience.savedVariables.groupLoot and receivedBy~=nil) then
		--<<1>> is who looted
		--<<2>> is itemname
		--<<3>> is quantity
		local qualifier = 1
		if(quantity>1) then qualifier = 2 end
		local sentence = GetString("SI_ECHOLOOT_OTHER_GAIN_",qualifier)
		if(isPickpocketLoot) then
			sentence = GetString("SI_ECHOLOOT_OTHER_PICK_",qualifier)
		elseif(lootType==LOOT_TYPE_QUEST_ITEM) then
			sentence = GetString("SI_ECHOLOOT_OTHER_QUEST_",qualifier)
		end
		--local strL = string.format(sentence,receivedBy,tostring(itemName))
		local strL = zo_strformat(sentence, receivedBy, tostring(itemName), tostring(quantity), tostring(traitIS) )
		EchoExperience.outputToChanel(strL,msgTypeLOOT)
	end
end

function EchoExperience:GetTraitInfo(itemName)
	local traitName = nil
	local traitType, traitDescription = GetItemLinkTraitInfo(itemName)
	if (traitType ~= ITEM_TRAIT_TYPE_NONE) then
		traitName = GetString("SI_ITEMTRAITTYPE", traitType)
	end
    --Returns: number ItemTraitType traitType, string traitDescription
	--lootType ~= LOOT_TYPE_COLLECTIBLE
	--	local traitType = GetItemLinkTraitInfo(itemName);
	return traitName
end

-----------------------------
-- SETUP Functions here --
-----------------------------

--https://wiki.esoui.com/Events
--EVENT_CLAIM_LEVEL_UP_REWARD_RESULT
--EVENT_DISCOVERY_EXPERIENCE (
--EVENT_LEVEL_UPDATE
function EchoExperience.SetupExpGainsEvents(reportMe)
	if (EchoExperience.savedVariables.showExp) then
		if(reportMe) then
			EchoExperience.outputToChanel(GetString(SI_ECHOEXP_EXPGAINS_SHOW),msgTypeSYS)
			--EchoExperience.outputToChanel("EchoExp is showing Experience Gains",msgTypeSYS)
		end
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."SkillXPGain",	    EVENT_SKILL_XP_UPDATE,          EchoExperience.OnSkillExperienceUpdate)
		--EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnCombatState",	EVENT_PLAYER_COMBAT_STATE,      EchoExperience.OnCombatState )
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."SkillLineAdded",	EVENT_SKILL_LINE_ADDED,         EchoExperience.OnSkillLineAdded)
		--TODO dont need sometimes?
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."ChampionUnlocked", EVENT_CHAMPION_SYSTEM_UNLOCKED, EchoExperience.OnChampionUnlocked)
		--EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."XPUpdate",		EVENT_EXPERIENCE_UPDATE,        EchoExperience.OnExperienceUpdate)
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."XPGain",		    EVENT_EXPERIENCE_GAIN,          EchoExperience.OnExperienceGain)
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnAlliancePtGain",	EVENT_ALLIANCE_POINT_UPDATE,    EchoExperience.OnAlliancePtGain)
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnSkillPtChange",	EVENT_SKILL_POINTS_CHANGED,     EchoExperience.OnSkillPtChange)
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnDiscoveryExp",	EVENT_DISCOVERY_EXPERIENCE,     EchoExperience.OnDiscoveryExperienceGain)
		--not really needed
		--EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."AbilityProgression",EVENT_ABILITY_PROGRESSION_XP_UPDATE, EchoExperience.OnAbilityExperienceUpdate)
		--
	else
		if(reportMe) then
			EchoExperience.outputToChanel(SI_ECHOEXP_EXPGAINS_HIDE,msgTypeSYS)
			--EchoExperience.outputToChanel("EchoExp is no longer showing Experience Gains",msgTypeSYS)
		end
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."SkillXPGain",	EVENT_SKILL_XP_UPDATE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."SkillLineAdded",	EVENT_SKILL_LINE_ADDED)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."ChampionUnlocked", EVENT_CHAMPION_SYSTEM_UNLOCKED)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."XPGain",		EVENT_EXPERIENCE_GAIN)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnAlliancePtGain",		EVENT_ALLIANCE_POINT_UPDATE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnSkillPtChange",		EVENT_SKILL_POINTS_CHANGED)

		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnDiscoveryExp",		EVENT_DISCOVERY_EXPERIENCE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."AbilityProgression",EVENT_ABILITY_PROGRESSION_XP_UPDATE)
	end
end
-- SETUP
function EchoExperience.SetupLootGainsEvents(reportMe)
	if (EchoExperience.savedVariables.showLoot) then
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."LootReceived",	EVENT_LOOT_RECEIVED, EchoExperience.OnLootReceived)
		if(reportMe) then
			EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINS_SHOW),msgTypeSYS)
			--EchoExperience.outputToChanel("EchoExp is showing Loot Gains",msgTypeSYS)
		end
	else
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."LootReceived",	EVENT_LOOT_RECEIVED, EchoExperience.OnLootReceived)
		if(reportMe) then
			EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINS_HIDE),msgTypeSYS)
			--EchoExperience.outputToChanel("EchoExp is no longer showing Loot Gains",msgTypeSYS)
		end
	end

end

-- SETUP  setup event handling
function EchoExperience.DelayedStart()
	-- Experience Related
	EchoExperience.SetupExpGainsEvents()
	-- Loot Related
	EchoExperience.SetupLootGainsEvents()
end

-- SETUP
function EchoExperience.OnAddOnUnloaded(event)
  --EchoExperience.debugMsg("OnAddOnUnloaded called") -- Prints to chat.
  --EchoExperience:Savesettings()
  --EchoExperience.debugMsg("OnAddOnUnloaded done") -- Prints to chat.
end

-- SETUP on player activated called delayed start
function EchoExperience.Activated(e)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name, EVENT_PLAYER_ACTIVATED)
    --d(EchoExperience.name .. GetString(SI_ECHOEXP_MESSAGE)) -- Prints to chat.
    --ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil,
    --    EchoExperience.name .. GetString(SI_NEW_ADDON_MESSAGE)) -- Top-right alert.
    zo_callLater(EchoExperience.DelayedStart, 3000)
end

-- SETUP
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

-- SETUP When player is ready, after everything has been loaded.
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_PLAYER_ACTIVATED, EchoExperience.Activated)
-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_ADD_ON_LOADED, EchoExperience.OnAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_PLAYER_DEACTIVATED, EchoExperience.OnAddOnUnloaded)
