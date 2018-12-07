EchoExperience = {
    name            = "EchoExperience",           -- Matches folder and Manifest file names.
    version         = "0.0.14",                    -- A nuisance to match to the Manifest.
    author          = "Echomap",
    menuName        = "EchoExperience_Options",   -- Unique identifier for menu object.
    menuDisplayName = "EchoExperience",
    view            = {},
    -- Saved settings.
    savedVariables = {},
    rgbaBase   = {
      ["r"] = 1,
      ["g"] = 1,
      ["b"] = 1,
      ["a"] = 0.9,
    },
}
local msgTypeSYS     = 1
local msgTypeEXP     = 2
local msgTypeLOOT    = 4
local msgTypeGUILD   = 6

local defaultSettings = {
  sversion   = EchoExperience.version,
  debug      = false,
  showExp    = true,
  verboseExp = true,
  messageFmt = 1,
	showLoot    = false,
	groupLoot   = false,  
  showGuildLogin = false,
  showGuildLogout= false,
    rgba    = {
      ["r"] = 1,
      ["g"] = 1,
      ["b"] = 1,
      ["a"] = 0.9,
	},
  rgba2   = {
      ["r"] = 1,
      ["g"] = 1,
      ["b"] = 1,
      ["a"] = 0.9,
	},
}

function EchoExperience.debugMsg(text)
	if EchoExperience.savedVariables.debug then
    local val = zo_strformat( "(EchoExp) <<1>>",text)
    d(val)
	end
end
function EchoExperience.outputMsg(text)
  if text ~= nil then
    local val = zo_strformat( "[EchoExp] <<1>>",text)
    d(val)
  end
end

function EchoExperience:ShowOutputs()
  --Exp
  if EchoExperience.savedVariables. expsettings ~= nil then
    EchoExperience.outputMsg("EXP outputs")
    for k, v in pairs(EchoExperience.savedVariables.expsettings) do
      local c = ZO_ColorDef:New(v.color.r, v.color.g, v.color.b, v.color.a)
      local ctext = c:Colorize("COLOR")
      local val = zo_strformat( "window=<<1>>, tab=<<2>>, color=<<3>>", v.window,v.tab,ctext )
      EchoExperience.outputMsg(val)
    end
  else
    EchoExperience.outputMsg("No EXP outputs configured")
  end 
  --Loot
  if EchoExperience.savedVariables.lootsettings ~= nil then
    d("[EchoExp] LOOT outputs:")
    for k, v in pairs(EchoExperience.savedVariables.lootsettings) do
      local c = ZO_ColorDef:New(v.color.r, v.color.g, v.color.b, v.color.a)
      local ctext = c:Colorize("COLOR")
      local val = zo_strformat( "window=<<1>>, tab=<<2>>, color=<<3>>", v.window,v.tab,ctext )
      EchoExperience.outputMsg(val)
    end
  else
    EchoExperience.outputMsg("No LOOT outputs configured")
  end   
  --Guild
  if EchoExperience.savedVariables.guildsettings ~= nil then
    EchoExperience.outputMsg("GUILD outputs:")
    for k, v in pairs(EchoExperience.savedVariables.guildsettings) do
      local c = ZO_ColorDef:New(v.color.r, v.color.g, v.color.b, v.color.a)
      local ctext = c:Colorize("COLOR")
      local val = zo_strformat( "window=<<1>>, tab=<<2>>, color=<<3>>", v.window,v.tab,ctext )
      EchoExperience.outputMsg(val)
    end
  else
    EchoExperience.outputMsg("No GUILD outputs configured")
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
    EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.expsettings )
    return
	elseif msgType == msgTypeLOOT then
    EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.lootsettings)
    return
	elseif msgType == msgTypeGUILD then
    EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.guildsettings)
    return
	else
		--
  end
end

function EchoExperience:outputToChanelSub(text,outputSettings)  
  if(text==nil) then return end
  if outputSettings == nil then return end
  for k, v in pairs(outputSettings) do
    if(v.window~=nil and v.tab~=nil and v.window>0 and v.tab>0 ) then
      local cCD = ZO_ColorDef:New(v.color.r,v.color.g,v.color.b,v.color.a)
      local text2 = cCD:Colorize(text)
      if(text2~=nil) then 
        CHAT_SYSTEM.containers[v.window].windows[v.tab].buffer:AddMessage(text2)
      end
    else
      EchoExperience.outputMsg("error in tab="..tostring(v.tab).."/window="..tostring(v.window).."/color of setting");
    end
  end
end

-- Helper that Wraps text with a color.
function EchoExperience.Colorize(text, color)
    if  color == nil then return text end
    text = "|c" .. color .. text .. "|r"
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
		EchoExperience.outputMsg("commands include: 'outputs', 'textexp', 'testloot', 'testfull', 'debug' ")
	elseif #options == 0 or options[1] == "outputs" then
		EchoExperience.ShowOutputs()
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
		EchoExperience.outputMsg("Debug = " .. tostring(EchoExperience.savedVariables.debug) )
	end

end

-----------------------------
-- SELECT/TABS/WINDOWS/COLORS Functions here --
-----------------------------
function EchoExperience:UpdateUIExpTabs()
  --need to update dropdown I guess?
  local myFpsLabelControl = WINDOW_MANAGER:GetControlByName("EchoExpDDExpOutput", "")
  if(myFpsLabelControl~=nil) then
    local vals = EchoExperience:ListOfExpTabs()
    myFpsLabelControl:UpdateChoices(vals )
  else
    EchoExperience.outputMsg("Exp dropdown not found, changes will not be reflected until /reloadui")
  end
end

function EchoExperience:UpdateUILootTabs()
  --need to update dropdown I guess?
  local myFpsLabelControl = WINDOW_MANAGER:GetControlByName("EchoExpDDLootOutput", "")
  if(myFpsLabelControl~=nil) then
    local vals = EchoExperience:ListOfLootTabs()
    myFpsLabelControl:UpdateChoices(vals )
  end
end

function EchoExperience:UpdateUIGuildTabs()
  --need to update dropdown I guess?
  local myFpsLabelControl = WINDOW_MANAGER:GetControlByName("EchoExpDDGuildOutput", "")
  if(myFpsLabelControl~=nil) then
    local vals = EchoExperience:ListOfGuildTabs()
    myFpsLabelControl:UpdateChoices(vals )
  end
end

function EchoExperience:ListOfExpTabs()
  local validChoices =  {}  
	table.insert(validChoices, "Select")
  if EchoExperience.savedVariables.expsettings ~= nil then
    for k, v in pairs(EchoExperience.savedVariables.expsettings) do
      if( v.color==nil) then
        v.color = EchoExperience.rgbaBase
      end      
      local c = ZO_ColorDef:New(v.color.r, v.color.g, v.color.b, v.color.a)
      local ctext = c:Colorize("COLOR")
      local val = zo_strformat( "<<1>>/<<2>>/<<3>>", v.window,v.tab,ctext )
      --d(EchoExperience.name .. " val " .. val)      
      table.insert(validChoices, val )
    end
  end
  return validChoices 
end

function EchoExperience:SelectExpTab(choiceText)
  ElderScrollsOfAlts.view.selected.exptab = choiceText
end

function EchoExperience:DoDeleteExpTab()
  local exptab = ElderScrollsOfAlts.view.selected.exptab 
  if(exptab~=nil)then
    --d(EchoExperience.name .. " exptab=" .. exptab) 
    for k,v in pairs(EchoExperience.savedVariables.expsettings) do
      local vCD = ZO_ColorDef:New(v.color.r, v.color.g, v.color.b, v.color.a)
      local vtext = vCD:Colorize("COLOR")      
      local valV = zo_strformat( "<<1>>/<<2>>/<<3>>", v.window,v.tab, vtext )
      --d(EchoExperience.name .. " valV=" .. valV) 
      if( exptab==valV ) then
        EchoExperience.savedVariables.expsettings[k] = nil
        break
      end
    end
  end
  EchoExperience:UpdateUIExpTabs()
end

function EchoExperience:DoSaveExpTab()
  local window = EchoExperience.view.settingstemp.windowExp
  local tab    = EchoExperience.view.settingstemp.tabExp
  local color  = EchoExperience.view.settingstemp.colorExp
 
  if EchoExperience.savedVariables.expsettings == nil then
    EchoExperience.savedVariables.expsettings = {}
  end
  
  local elem = {}
  elem["window"]=window
  elem["tab"]   =tab
  elem["color"] =color
  table.insert(EchoExperience.savedVariables.expsettings, elem)
 
  EchoExperience:UpdateUIExpTabs()
end

function EchoExperience:ListOfLootTabs()
  local validChoices =  {}  
	table.insert(validChoices, "Select")
  if EchoExperience.savedVariables.lootsettings ~= nil then
    for k, v in pairs(EchoExperience.savedVariables.lootsettings) do
      if( v.color==nil) then
        v.color = EchoExperience.rgbaBase
      end
      local c = ZO_ColorDef:New(v.color.r, v.color.g, v.color.b, v.color.a)
      local ctext = c:Colorize("COLOR")
      local val = zo_strformat( "<<1>>/<<2>>/<<3>>", v.window,v.tab,ctext )
      --d(EchoExperience.name .. " val " .. val)      
      table.insert(validChoices, val )
    end
  end
  return validChoices 
end

function EchoExperience:SelectLootTab(choiceText)
  ElderScrollsOfAlts.view.selected.loottab = choiceText
end

function EchoExperience:DoDeleteLootTab()
  local loottab = ElderScrollsOfAlts.view.selected.loottab 
  if(loottab~=nil)then
    --d(EchoExperience.name .. " loottab=" .. loottab) 
    for k,v in pairs(EchoExperience.savedVariables.lootsettings) do
      local vCD = ZO_ColorDef:New(v.color.r, v.color.g, v.color.b, v.color.a)
      local vtext = vCD:Colorize("COLOR")      
      local valV = zo_strformat( "<<1>>/<<2>>/<<3>>", v.window,v.tab, vtext )
      --d(EchoExperience.name .. " valV=" .. valV) 
      if( loottab==valV ) then
        EchoExperience.savedVariables.lootsettings[k] = nil
        break
      end
    end
  end
  EchoExperience:UpdateUILootTabs()
end

function EchoExperience:DoSaveLootTab()
  local window = EchoExperience.view.settingstemp.windowLoot
  local tab    = EchoExperience.view.settingstemp.tabLoot
  local color  = EchoExperience.view.settingstemp.colorLoot
 
  if EchoExperience.savedVariables.lootsettings == nil then
    EchoExperience.savedVariables.lootsettings = {}
  end
  
  local elem = {}
  elem["window"]=window
  elem["tab"]=tab
  elem["color"]=color
  table.insert(EchoExperience.savedVariables.lootsettings, elem)
 
  EchoExperience:UpdateUILootTabs()
end

function EchoExperience:ListOfGuildTabs()
  local validChoices =  {}  
	table.insert(validChoices, "Select")
  if EchoExperience.savedVariables.guildsettings ~= nil then
    for k, v in pairs(EchoExperience.savedVariables.guildsettings) do
      local c = ZO_ColorDef:New(v.color.r, v.color.g, v.color.b, v.color.a)
      local ctext = c:Colorize("COLOR")
      local val = zo_strformat( "<<1>>/<<2>>/<<3>>", v.window,v.tab,ctext )
      --d(EchoExperience.name .. " val " .. val)      
      table.insert(validChoices, val )
    end
  end
  return validChoices 
end

function EchoExperience:SelectGuildTab(choiceText)
  ElderScrollsOfAlts.view.selected.guildtab = choiceText
end

function EchoExperience:DoDeleteGuildTab()
  local guildtab = ElderScrollsOfAlts.view.selected.guildtab 
  if(guildtab~=nil)then
    --d(EchoExperience.name .. " guildtab=" .. guildtab) 
    for k,v in pairs(EchoExperience.savedVariables.guildsettings) do
      local vCD = ZO_ColorDef:New(v.color.r, v.color.g, v.color.b, v.color.a)
      local vtext = vCD:Colorize("COLOR")      
      local valV = zo_strformat( "<<1>>/<<2>>/<<3>>", v.window,v.tab, vtext )
      --d(EchoExperience.name .. " valV=" .. valV) 
      if( guildtab==valV ) then
        EchoExperience.savedVariables.guildsettings[k] = nil
        break
      end
    end
  end
  EchoExperience:UpdateUIGuildTabs()
end

function EchoExperience:DoSaveGuildTab()
  local window = EchoExperience.view.settingstemp.windowGuild
  local tab    = EchoExperience.view.settingstemp.tabGuild
  local color  = EchoExperience.view.settingstemp.colorGuild
 
  if EchoExperience.savedVariables.guildsettings == nil then
    EchoExperience.savedVariables.guildsettings = {}
  end
  
  local elem = {}
  elem["window"]=window
  elem["tab"]=tab
  elem["color"]=color
  table.insert(EchoExperience.savedVariables.guildsettings, elem)
 
  EchoExperience:UpdateUIGuildTabs()
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
	local extraInfo = nill
	if lootType ~= nil and lootType ~= LOOT_TYPE_MONEY and lootType ~= LOOT_TYPE_QUEST_ITEM then
		--if itemType ~= ITEMTYPE_ARMOR_TRAIT and itemType ~= ITEMTYPE_WEAPON_TRAIT -- lootType ~= LOOT_TYPE_COLLECTIBLE
		local traitName, setName = EchoExperience:GetExtraInfo(itemName)
		--end
		--
		if( traitName ~=nil and setName ~= nil) then
			extraInfo = string.format("%s, %s set",traitName, setName)
		elseif( traitName ~= nil) then
			extraInfo = string.format("%s",traitName)
		elseif( setName ~= nil) then
			extraInfo = string.format("%s set",setName)
		end
		EchoExperience.debugMsg("OnLootReceived: "
			.." lootType="  .. tostring(lootType)
			.." traitName=" .. tostring(traitName)
			.." setName="   .. tostring(setName)
			.." extraInfo=" .. tostring(extraInfo)
		)
	end

   if(isSelf) then
    --<<1>> is itemname
    --<<2>> is quantity
    local qualifier = 1
    if(quantity==1) then
      if(extraInfo ~= nil) then
        qualifier = 3
      else
        qualifier = 1 --**1 item, no extra info
      end
    else
      if(extraInfo ~=nil) then
        qualifier = 4
      else
        qualifier = 2 --**2+ item, no extra info
      end
    end
    EchoExperience.debugMsg("qualifier=" ..tostring(qualifier) )

    if(messageFmt==2) then
      local sentence = GetString("SI_ECHOLOOT2_YOU_GAIN_",qualifier)
      if(lootType==LOOT_TYPE_QUEST_ITEM)then
        sentence = GetString("SI_ECHOLOOT2_YOU_QUEST_",qualifier)
      end
      local strL = zo_strformat(sentence, tostring(itemName), tostring(quantity), tostring(extraInfo) )
      EchoExperience.outputToChanel(strL,msgTypeLOOT)
    else  
      local sentence = GetString("SI_ECHOLOOT_YOU_GAIN_",qualifier)
      if(isPickpocketLoot) then
        sentence = GetString("SI_ECHOLOOT_YOU_PICK_",qualifier)
      elseif(lootType==LOOT_TYPE_QUEST_ITEM)then
        sentence = GetString("SI_ECHOLOOT_YOU_QUEST_",qualifier)
      end
      --local strL = string.format(verb,tostring(itemName),tostring(quantity))
      local strL = zo_strformat(sentence, tostring(itemName), tostring(quantity), tostring(extraInfo) )
      EchoExperience.outputToChanel(strL,msgTypeLOOT)
    end
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
    local strL = zo_strformat(sentence, receivedBy, tostring(itemName), tostring(quantity), tostring(extraInfo) )
    EchoExperience.outputToChanel(strL,msgTypeLOOT)
  end
end

function EchoExperience:GetExtraInfo(itemName)
	local traitName = nil
	local traitType, traitDescription = GetItemLinkTraitInfo(itemName)
	--
	EchoExperience.debugMsg(" traitType=" .. tostring(traitType)
			.." traitDescription="  .. tostring(traitDescription)
		)
	if (traitType ~= ITEM_TRAIT_TYPE_NONE) then
		traitName = GetString("SI_ITEMTRAITTYPE", traitType)
	end
	--bool hasSet, str setName, num numBonuses, num numEquipped, num maxEquipped, num setId
	local hasSet, setName, numBonuses, numEquipped, maxEquipped, setId = GetItemLinkSetInfo(itemName)
	EchoExperience.debugMsg("GetExtraInfo:"
			.." hasSet="  ..tostring(hasSet)
			.." setName=" ..tostring(setName)
			.." setId="   ..tostring(setId)
		)
	if( hasSet and setId > 0 ) then
		return traitName, setName
	end
	return trainName, nil
end

--
function EchoExperience.OnGuildMemberStatusChanged(eventCode,guildID,playerName,prevStatus,curStatus)
  EchoExperience.debugMsg("OnGuildMemberStatusChanged called") -- Prints to chat.    
  local sentence = GetString("SI_ECHOEXP_GUILD_",1)
  --"eventCode: <<1>>, guildID: <<2>>, playerName: <<3>>, prevStatus: <<4>>, curStatus: <<5>> ."  
  local strL = zo_strformat(sentence, eventCode, tostring(guildID), tostring(playerName), tostring(prevStatus), tostring(curStatus) )
  EchoExperience.debugMsg(strL)
  if(curStatus == 1) then
    --online
    if (EchoExperience.savedVariables.showGuildLogin) then
      --local sentence2 = "[EchoExp] <<3>> Logged IN at <<6>>"  
      local sentence2 = GetString("SI_ECHOEXP_GUILD_",2)
      local strL2 = zo_strformat(sentence2, eventCode, tostring(guildID), tostring(playerName), tostring(prevStatus), tostring(curStatus), ZO_FormatClockTime() )
      EchoExperience.outputToChanel(strL2,msgTypeGUILD)  
    end
  elseif(curStatus == 4) then
    --offline
    if (EchoExperience.savedVariables.showGuildLogout) then
      local sentence2 = GetString("SI_ECHOEXP_GUILD_",3)
      --local sentence2 = "[EchoExp] <<3>> Logged OUT at <<6>>"  
      local strL2 = zo_strformat(sentence2, eventCode, tostring(guildID), tostring(playerName), tostring(prevStatus), tostring(curStatus), ZO_FormatClockTime() )
      EchoExperience.outputToChanel(strL2,msgTypeGUILD)  
    end
  end
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

--
function EchoExperience.SetupMiscEvents()
  if( EchoExperience.view.GuildEventsReg == true) then
    if ( not EchoExperience.savedVariables.showGuildLogin and not EchoExperience.savedVariables.showGuildLogout ) then
    	EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED",	EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED, EchoExperience.OnLootReceived)
      EchoExperience.view.GuildEventsReg = false
      EchoExperience.debugMsg(GetString(SI_ECHOEXP_GUILD_EVENT_UNREG))--"Unregistered for Guild events")
    end
  else
    if (EchoExperience.savedVariables.showGuildLogin or EchoExperience.savedVariables.showGuildLogout ) then
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED",	EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED, EchoExperience.OnGuildMemberStatusChanged)
      EchoExperience.view.GuildEventsReg = true
      EchoExperience.debugMsg(GetString(SI_ECHOEXP_GUILD_EVENT_REG))--"Registered for Guild events")
    end
  end
end

function EchoExperience:UpgradeSettings()
  local upgraded = false
  --
  if(EchoExperience.savedVariables.windowGuild~=nil and EchoExperience.savedVariables.tabGuild~=nil )then
    local elem = {}
    elem["window"]= EchoExperience.savedVariables.windowGuild
    elem["tab"]   = EchoExperience.savedVariables.tabGuild
    elem["color"] = EchoExperience.savedVariables.rgbaGuild
    if(elem.window>0 and elem.tab>0) then
      table.insert(EchoExperience.savedVariables.guildsettings, elem)    
    end
    upgraded=true
  end
  if(EchoExperience.savedVariables.rgbaGuild~=nil)then
    EchoExperience.savedVariables.rgbaGuild = nil
  end
  if(EchoExperience.savedVariables.windowGuild~=nil)then
    EchoExperience.savedVariables.windowGuild = nil
  end
  if(EchoExperience.savedVariables.tabGuild~=nil)then
    EchoExperience.savedVariables.tabGuild = nil
  end
  
  --
  if(EchoExperience.savedVariables.window~=nil and EchoExperience.savedVariables.tab~=nil )then
    local elem = {}
    elem["window"]= EchoExperience.savedVariables.window
    elem["tab"]   = EchoExperience.savedVariables.tab
    elem["color"] = EchoExperience.savedVariables.rgba
    if(elem.window>0 and elem.tab>0) then
      table.insert(EchoExperience.savedVariables.expsettings, elem)    
    end
    upgraded=true
  end
  if(EchoExperience.savedVariables.windowexp2~=nil and EchoExperience.savedVariables.tabexp2~=nil )then
    local elem = {}
    elem["window"]= EchoExperience.savedVariables.windowexp2
    elem["tab"]   = EchoExperience.savedVariables.tabexp2
    elem["color"] = EchoExperience.savedVariables.rgba2
    if(elem.window>0 and elem.tab>0) then
      table.insert(EchoExperience.savedVariables.expsettings, elem)
    end
    upgraded=true
  end
  
  --
  if(EchoExperience.savedVariables.windowloot~=nil and EchoExperience.savedVariables.tabloot~=nil )then
    local elem = {}
    elem["window"]= EchoExperience.savedVariables.windowloot
    elem["tab"]   = EchoExperience.savedVariables.tabloot
    elem["color"] = EchoExperience.savedVariables.rgba
    if(elem.window>0 and elem.tab>0) then
      table.insert(EchoExperience.savedVariables.lootsettings, elem)
    end
    upgraded=true
  end
  if(EchoExperience.savedVariables.windowloot2~=nil and EchoExperience.savedVariables.tabloot2~=nil )then
    local elem = {}
    elem["window"]= EchoExperience.savedVariables.windowloot2
    elem["tab"]   = EchoExperience.savedVariables.tabloot2
    elem["color"] = EchoExperience.savedVariables.rgba2
    if(elem.window>0 and elem.tab>0) then
      table.insert(EchoExperience.savedVariables.lootsettings, elem)
    end
    upgraded=true
  end
  if(EchoExperience.savedVariables.window~=nil)then
    EchoExperience.savedVariables.window = nil
  end
  if(EchoExperience.savedVariables.tab~=nil)then
    EchoExperience.savedVariables.tab = nil
  end
  if(EchoExperience.savedVariables.rgba~=nil)then
    EchoExperience.savedVariables.rgba = nil
  end
  if(EchoExperience.savedVariables.windowexp2~=nil)then
    EchoExperience.savedVariables.windowexp2 = nil
  end
  if(EchoExperience.savedVariables.tabexp2~=nil)then
    EchoExperience.savedVariables.tabexp2 = nil
  end
  if(EchoExperience.savedVariables.rgba2~=nil)then
    EchoExperience.savedVariables.rgba2 = nil
  end  
  if(EchoExperience.savedVariables.windowloot~=nil)then
    EchoExperience.savedVariables.windowloot = nil
  end
  if(EchoExperience.savedVariables.tabloot~=nil)then
    EchoExperience.savedVariables.tabloot = nil
  end  
  if(EchoExperience.savedVariables.windowloot2~=nil)then
    EchoExperience.savedVariables.windowloot2 = nil
  end
  if(EchoExperience.savedVariables.tabloot2~=nil)then
    EchoExperience.savedVariables.tabloot2 = nil
  end
  
  EchoExperience.savedVariables.lootoutput = nil
  EchoExperience.savedVariables.expoutput = nil
  
  if(upgraded) then
    EchoExperience:UpdateUIExpTabs()
    EchoExperience:UpdateUILootTabs()
    EchoExperience:UpdateUIGuildTabs()
    zo_callLater(EchoExperience.UpdateUIExpTabs, 12000)
    zo_callLater(EchoExperience.UpdateUILootTabs, 12000)
    zo_callLater(EchoExperience.UpdateUIGuildTabs, 12000)
  end
end

-- SETUP  setup event handling
function EchoExperience.DelayedStart()
  --Setup VIEW
  EchoExperience.view = {}
  EchoExperience.view.GuildEventsReg = false
  EchoExperience.view.settingstemp = {}
  EchoExperience.view.settingstemp.windowGuild = nil
  EchoExperience.view.settingstemp.tabGuild = nil
  EchoExperience.view.settingstemp.colorGuild = rgbaBase  
  EchoExperience.view.settingstemp.windowLoot = nil
  EchoExperience.view.settingstemp.tabLoot = nil
  EchoExperience.view.settingstemp.colorLoot = rgbaBase
  EchoExperience.view.settingstemp.windowExp = nil
  EchoExperience.view.settingstemp.tabExp = nil
  EchoExperience.view.settingstemp.colorExp = rgbaBase
  ElderScrollsOfAlts.view.selected = {}
  ElderScrollsOfAlts.view.selected.guildtab = nil
  ElderScrollsOfAlts.view.selected.loottab = nil
  ElderScrollsOfAlts.view.selected.exptab = nil
  
  --Setup Basic Options
  if(EchoExperience.savedVariables.guildsettings==nil)then
    EchoExperience.savedVariables.guildsettings = {}
  end
  if(EchoExperience.savedVariables.lootsettings==nil)then
    EchoExperience.savedVariables.lootsettings = {}
  end
  if(EchoExperience.savedVariables.expsettings==nil)then
    EchoExperience.savedVariables.expsettings = {}
  end
  
  EchoExperience:UpgradeSettings()
  
	--Setup Events Related
	EchoExperience.SetupExpGainsEvents()
	EchoExperience.SetupLootGainsEvents()
  EchoExperience.SetupMiscEvents()  
  
end

-- SETUP-- and is only called on reloadui, not quit?
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
    
    --[[
    if( EchoExperience.savedVariables.sversion == "0.0.6" ) then
      --EchoExperience:UpgradeSettings()
    end
    --sversion = EchoExperience.version
    ]]

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
