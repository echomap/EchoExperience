EchoExperience = {
    name            = "EchoExperience",           -- Matches folder and Manifest file names.
    -- version         = "1.0",                -- A nuisance to match to the Manifest.
    author          = "Echomap",
    color           = "DDFFEE",             -- Used in menu titles and so on.
    menuName        = "EchoExperience_Options",   -- Unique identifier for menu object.
    menuDisplayName = "EchoExperience",
    debug           = false,
    tab		    = 2,
    window          = 1,
    color           = nil,
    -- Default settings.
    savedVariables = {},
}

function EchoExperience.debugMsg(text)
	if EchoExperience.debug then
		d("(" .. EchoExperience.name .. ") " .. text);
	end
end
function EchoExperience.outputToChanel(text)
	--Todo options/color/etc
	if (EchoExperience.tab == nil or EchoExperience.tab < 1) then
		d(text);
	else
		--CHAT_SYSTEM:AddMessage(<message String>)'
		--container 1-10
		local text2 = EchoExperience.Colorize(text)
		CHAT_SYSTEM.containers[1].windows[EchoExperience.tab].buffer:AddMessage(text2)
	end
end

-- Wraps text with a color.
function EchoExperience.Colorize(text, color)
    -- Default to addon's .color.
    if  color == nil then return text end
    if not color then color = EchoExperience.color end
    text = "|c" .. color .. text .. "|r"
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
	elseif #options == 0 or options[1] == "debug" then
		local dg = EchoExperience.debug
		EchoExperience.debug = not dg
		d("EchoExperience: Debug = " .. tostring(EchoExperience.debug) )
	elseif (#options == 0 or options[1] == "tab") and options[2] ~= nil then
		d("EchoExperience: tab = " .. tostring(options[2]) )
	elseif (#options == 0 or options[1] == "window") and options[2] ~= nil then
		d("EchoExperience: window = " .. tostring(options[2]) )
	end

end

function EchoExperience.OnCombatState(eventCode, inCombat)
	--if inCombat and not EchoExperienceActive:IsHidden() and self.sv.closeInCombat then
		--self:CloseStatusWindow()
	--elseif not inCombat and self.showStatusWindowLater then
		--self:TryShowStatusWindow()
	--end
end
function EchoExperience.OnSkillExperienceUpdate(eventCode, skillType, skillIndex, reason, rank, previousXP, currentXP)
	EchoExperience.debugMsg("OnSkillExperienceUpdate")

	if EchoExperience.debug then
		d(EchoExperience.name .. " eventCode="  .. eventCode) -- Prints to chat.
		d(EchoExperience.name .. " skillType="  .. skillType) -- Prints to chat.
		d(EchoExperience.name .. " skillIndex=" .. skillIndex) -- Prints to chat.
		d(EchoExperience.name .. " reason="     .. reason) -- Prints to chat.
		d(EchoExperience.name .. " rank="       .. rank) -- Prints to chat.
		d(EchoExperience.name .. " previousXP=" .. previousXP) -- Prints to chat.
		d(EchoExperience.name .. " currentXP="  .. currentXP) -- Prints to chat.
	end

	local skillLineName, currentSkillRank, available = GetSkillLineInfo(skillType, skillIndex)
	if EchoExperience.debug then
		d(EchoExperience.name .. " skillLineName="     .. skillLineName ) -- Prints to chat.
		d(EchoExperience.name .. " currentSkillRank="  .. currentSkillRank ) -- Prints to chat.
		d(EchoExperience.name .. " available="         .. tostring(available) ) -- Prints to chat.
	end

	local lastRankXP, nextRankXP, currentXP = GetSkillLineXPInfo(skillType, skillIndex)
	if EchoExperience.debug then
		d(EchoExperience.name .. " lastRankXP="  .. lastRankXP ) -- Prints to chat.
		d(EchoExperience.name .. " nextRankXP="  .. nextRankXP ) -- Prints to chat.
		d(EchoExperience.name .. " currentXP="   .. currentXP ) -- Prints to chat.
	end

	-- Output

	local diff = nextRankXP - currentXP
	if skillLineName ~= nil and available then
		local XPgain  = currentXP - previousXP
		local curCur  = currentXP - lastRankXP
		local curNext = nextRankXP - lastRankXP
		--EchoExperience.outputToChanel("You gained [" .. XPgain .. "] experience in [" .. skillLineName .."]")
		--EchoExperience.outputToChanel("    at "..curCur.."/"..curNext..", need [" .. diff .. "] more, experience")
		EchoExperience.outputToChanel("Gained "..XPgain.."xp in [" ..skillLineName.."] ("..curCur.."/"..curNext..") need " .. diff .. "xp")
	end
end
function EchoExperience.OnAbitilyExperienceUpdate(eventCode, pIndex, lastRankXP, nextRankXP, currentXP, atmorph)
	if not nextRankXP or nextRankXP <= 0 then
		return
	end
	EchoExperience.debugMsg("OnAbitilyExperienceUpdate Called")
	if EchoExperience.debug then
		d(EchoExperience.name .. " eventCode="  .. eventCode) -- Prints to chat.
		d(EchoExperience.name .. " pIndex="     .. pIndex) -- Prints to chat.
		d(EchoExperience.name .. " lastRankXP=" .. lastRankXP) -- Prints to chat.
		d(EchoExperience.name .. " nextRankXP=" .. tostring(nextRankXP) ) -- Prints to chat.
		d(EchoExperience.name .. " currentXP="  .. tostring(currentXP)  ) -- Prints to chat.
		d(EchoExperience.name .. " atmorph="    .. tostring(atmorph)    ) -- Prints to chat.
	end

	--string _name_, integer _morph_, integer _rank_
	local name, morph, rank = GetAbilityProgressionInfo(pIndex)
	local morphName = GetAbilityProgressionAbilityInfo(pIndex, rank, morph)
	if EchoExperience.debug then
		d(EchoExperience.name .. " name="  .. name ) -- Prints to chat.
		d(EchoExperience.name .. " morph=" .. morph) -- Prints to chat.
		d(EchoExperience.name .. " rank="  .. rank ) -- Prints to chat.
		d(EchoExperience.name .. " morphName="  .. morphName ) -- Prints to chat.
	end
	EchoExperience.debugMsg("OnAbitilyExperienceUpdate Done")
end
function EchoExperience.OnSkillLineAdded(event, eventCode, skillType, skillIndex)
	EchoExperience.debugMsg("OnSkillLineAdded")
end
function EchoExperience.OnChampionUnlocked(...)
	EchoExperience.debugMsg("OnChampionUnlocked")
end
-- (string unitTag, integer currentExp, integer maxExp, integer reason)
--(eventCode, tag, exp, maxExp, reason, ...)
function EchoExperience.OnExperienceUpdate(event,  unitTag, currentExp, maxExp, reason)
	if ( unitTag ~= 'player' ) then return end
	if EchoExperience.debug then
		--d(EchoExperience.name .. " currentExp=" .. currentExp) -- Prints to chat.
		--d(EchoExperience.name .. " maxExp=" .. maxExp) -- Prints to chat.
		--d(EchoExperience.name .. " reason=" .. reason) -- Prints to chat.
	end
	--EchoExperience.outputToChanel("You gained experience.")
end

--(number eventCode, ProgressReason reason, number level, number previousExperience, number currentExperience, number championPoints)
--_, _, _, prevXp, curXp, championPoints)
function EchoExperience.OnExperienceGain(event, eventCode, reason, level, previousExperience, currentExperience, championPoints)
	EchoExperience.debugMsg("OnExperienceGain Called")
	--if ( unitTag ~= 'player' ) then return end
	--local xpPrev = previousExperience;
	if EchoExperience.debug then
		d(EchoExperience.name .. " previousExperience=" .. previousExperience) -- Prints to chat.
		d(EchoExperience.name .. " currentExperience="  .. currentExperience) -- Prints to chat.
		d(EchoExperience.name .. " eventCode=" .. eventCode) -- Prints to chat.
		d(EchoExperience.name .. " reason=" .. reason) -- Prints to chat.
		d(EchoExperience.name .. " level="  .. level) -- Prints to chat.
	end
	local XPgain = previousExperience - level
	EchoExperience.outputToChanel("You gained " .. XPgain .. " experience.")
	EchoExperience.debugMsg("OnExperienceGain Done")
end

function EchoExperience.DelayedStart()
	--https://wiki.esoui.com/Events
	EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."SkillXPGain",	EVENT_SKILL_XP_UPDATE,     EchoExperience.OnSkillExperienceUpdate)
	EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnCombatState",	EVENT_PLAYER_COMBAT_STATE, EchoExperience.OnCombatState )
	EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."AbilityProgression",EVENT_ABILITY_PROGRESSION_XP_UPDATE, EchoExperience.OnAbitilyExperienceUpdate)
	EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."SkillLineAdded",	EVENT_SKILL_LINE_ADDED,  EchoExperience.OnSkillLineAdded)
	EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."ChampionUnlocked", EVENT_CHAMPION_SYSTEM_UNLOCKED, EchoExperience.OnChampionUnlocked)
	EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."XPUpdate",		EVENT_EXPERIENCE_UPDATE, EchoExperience.OnExperienceUpdate)
	EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."XPGain",		EVENT_EXPERIENCE_GAIN,   EchoExperience.OnExperienceGain)
	--EVENT_CLAIM_LEVEL_UP_REWARD_RESULT
	--EVENT_DISCOVERY_EXPERIENCE (
	--EVENT_LEVEL_UPDATE
end

function EchoExperience.Activated(e)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name, EVENT_PLAYER_ACTIVATED)

    d(EchoExperience.name .. GetString(SI_NEW_ADDON_MESSAGE)) -- Prints to chat.

    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil,
        EchoExperience.name .. GetString(SI_NEW_ADDON_MESSAGE)) -- Top-right alert.

    -- Animate the xml UI center text, after a delay.
    --zo_callLater(EchoExperience.AnimateText, 3000)
    zo_callLater(EchoExperience.DelayedStart, 3000)
end
-- When player is ready, after everything has been loaded.
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_PLAYER_ACTIVATED, EchoExperience.Activated)

function EchoExperience.OnAddOnLoaded(event, addonName)
    if addonName ~= EchoExperience.name then return end
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name, EVENT_ADD_ON_LOADED)

    EchoExperience.savedVariables = ZO_SavedVars:New("EchoExperienceSavedVariables", 1, nil, EchoExperience.savedVariables)

    -- Settings menu in Settings.lua.
    EchoExperience.LoadSettings()

    -- Slash commands must be lowercase. Set to nil to disable.
    SLASH_COMMANDS["/echoexp"] = EchoExperience.SlashCommandHandler
    -- Reset autocomplete cache to update it.
    SLASH_COMMAND_AUTO_COMPLETE:InvalidateSlashCommandCache()
end
-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_ADD_ON_LOADED, EchoExperience.OnAddOnLoaded)