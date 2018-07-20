EchoExperience = {
    name            = "EchoExperience",           -- Matches folder and Manifest file names.
    version         = "0.0.4",                    -- A nuisance to match to the Manifest.
    author          = "Echomap",
    menuName        = "EchoExperience_Options",   -- Unique identifier for menu object.
    menuDisplayName = "EchoExperience",
    debug           = false,
    tab             = 2,
    window          = 1,
	rgba            = nil,
    -- Saved settings.
    savedVariables = {},
}

function EchoExperience.debugMsg(text)
	if EchoExperience.debug then
		d("(" .. EchoExperience.name .. ") " .. text);
	end
end
function EchoExperience.outputToChanel(text)
	if (EchoExperience.tab == nil or EchoExperience.tab < 1) then
		d(text);
	else
		--CHAT_SYSTEM:AddMessage(<message String>)' --container 1-10
		local text2 = EchoExperience:ColorizeText(text)
		CHAT_SYSTEM.containers[EchoExperience.window].windows[EchoExperience.tab].buffer:AddMessage(text2)
	end
end

function EchoExperience:Savesettings()
	EchoExperience.savedVariables.debug  = EchoExperience.debug
	EchoExperience.savedVariables.tab    = EchoExperience.tab
	EchoExperience.savedVariables.window = EchoExperience.window
	EchoExperience.savedVariables.rgba   = EchoExperience.rgba
end
function EchoExperience.RestoreSettings()
	--todo check
	EchoExperience.debug  = EchoExperience.savedVariables.debug
	EchoExperience.tab    = tonumber(EchoExperience.savedVariables.tab)
	EchoExperience.window = tonumber(EchoExperience.savedVariables.window)

	if EchoExperience.tab == nil then
		EchoExperience.tab = 1
	end
	if EchoExperience.window == nil then
		EchoExperience.window = 1
	end

	if EchoExperience.savedVariables.rgba == nil then
		EchoExperience.rgba   = {}
		--EchoExperience.rgba   = {255,255,255, 0.9}
		EchoExperience.rgba.r = 1
		EchoExperience.rgba.g = 1
		EchoExperience.rgba.b = 1
		EchoExperience.rgba.a = 0.9
	else
		EchoExperience.rgba   = EchoExperience.savedVariables.rgba
	end
end

-- Wraps text with a color.
function EchoExperience.Colorize(text, color)
    if  color == nil then return text end
    text = "|c" .. color .. text .. "|r"
    return text
end

-- Wraps text with a color.
function EchoExperience:ColorizeText(text)
	--d("ct: text="..text)
	if EchoExperience.rgba == nil then return text end
	local rgba = EchoExperience.rgba
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
	elseif #options == 0 or options[1] == "testoutput" then
		EchoExperience.outputToChanel("Gained 0 xp in [Test] (1000/10000) need 9000xp")
	elseif #options == 0 or options[1] == "debug" then
		local dg = EchoExperience.debug
		EchoExperience.debug = not dg
		d("EchoExperience: Debug = " .. tostring(EchoExperience.debug) )
		EchoExperience.savedVariables.debug = EchoExperience.debug
	elseif (#options == 0 or options[1] == "tab") and options[2] ~= nil then
		d("EchoExperience: tab = " .. tostring(options[2]) )
		EchoExperience.tab = tonumber(options[2])
		EchoExperience.savedVariables.tab = EchoExperience.tab
	elseif (#options == 0 or options[1] == "window") and options[2] ~= nil then
		d("EchoExperience: window = " .. tostring(options[2]) )
		EchoExperience.window = tonumber(options[2])
		EchoExperience.savedVariables.window = EchoExperience.window
	end

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
function EchoExperience.OnSkillLineAdded(event, eventCode, skillType, skillIndex)
	EchoExperience.debugMsg("OnSkillLineAdded")
end
function EchoExperience.OnChampionUnlocked(...)
	EchoExperience.debugMsg("OnChampionUnlocked")
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
	--EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnCombatState",	EVENT_PLAYER_COMBAT_STATE, EchoExperience.OnCombatState )
	--EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."AbilityProgression",EVENT_ABILITY_PROGRESSION_XP_UPDATE, EchoExperience.OnAbitilyExperienceUpdate)
	EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."SkillLineAdded",	EVENT_SKILL_LINE_ADDED,  EchoExperience.OnSkillLineAdded)
	EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."ChampionUnlocked", EVENT_CHAMPION_SYSTEM_UNLOCKED, EchoExperience.OnChampionUnlocked)
	--EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."XPUpdate",		EVENT_EXPERIENCE_UPDATE, EchoExperience.OnExperienceUpdate)
	EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."XPGain",		EVENT_EXPERIENCE_GAIN,   EchoExperience.OnExperienceGain)
	--EVENT_CLAIM_LEVEL_UP_REWARD_RESULT
	--EVENT_DISCOVERY_EXPERIENCE (
	--EVENT_LEVEL_UPDATE
end

function EchoExperience.OnAddOnUnloaded(event)
  --EchoExperience.debugMsg("OnAddOnUnloaded called") -- Prints to chat.
  EchoExperience:Savesettings()
  --EchoExperience.debugMsg("OnAddOnUnloaded done") -- Prints to chat.
end

function EchoExperience.Activated(e)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name, EVENT_PLAYER_ACTIVATED)
    d(EchoExperience.name .. GetString(SI_NEW_ADDON_MESSAGE)) -- Prints to chat.
    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil,
        EchoExperience.name .. GetString(SI_NEW_ADDON_MESSAGE)) -- Top-right alert.
    zo_callLater(EchoExperience.DelayedStart, 3000)
end
-- When player is ready, after everything has been loaded.
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_PLAYER_ACTIVATED, EchoExperience.Activated)

function EchoExperience.OnAddOnLoaded(event, addonName)
    if addonName ~= EchoExperience.name then return end
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name, EVENT_ADD_ON_LOADED)

    EchoExperience.savedVariables = ZO_SavedVars:New("EchoExperienceSavedVariables", 1, nil, EchoExperience.savedVariables)

    -- Settings menu in Settings.lua.
    EchoExperience:RestoreSettings()
    EchoExperience.LoadSettings()


    -- Slash commands must be lowercase. Set to nil to disable.
    SLASH_COMMANDS["/echoexp"] = EchoExperience.SlashCommandHandler
    -- Reset autocomplete cache to update it.
    SLASH_COMMAND_AUTO_COMPLETE:InvalidateSlashCommandCache()
end
-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_ADD_ON_LOADED, EchoExperience.OnAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_PLAYER_DEACTIVATED, EchoExperience.OnAddOnUnloaded)
