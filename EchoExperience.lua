EchoExperience = {
    name            = "EchoExperience",           -- Matches folder and Manifest file names.
    version         = "0.0.16",                    -- A nuisance to match to the Manifest.
    author          = "Echomap",
    menuName        = "EchoExperience_Options",   -- Unique identifier for menu object.
    menuDisplayName = "EchoExperience",
    defaultMaxLines = 10,
    view            = {},
    -- Saved settings.
    savedVariables = {},
    accountVariables = {},
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

--local PCHAT = LibStub("PCHAT")

local defaultSettings = {
  sversion   = EchoExperience.version,
  debug      = false,
  showExp    = true,
  verboseExp = true,
  messageFmt = 1,
	showLoot    = false,
	groupLoot   = false,  
  extendedLoot = false,
  showGuildLogin = false,
  showGuildLogout= false,
  showtracking = false,
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
  EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.expsettings,   "EXP outputs")
  EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.lootsettings,  "LOOT outputs", msgTypeLOOT)
  EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.guildsettings, "GUILD outputs",msgTypeGUILD)
end

function EchoExperience:ShowDefaults()
  EchoExperience:ShowOutputsSub(EchoExperience.accountVariables.defaults.expsettings,   "EXP defaults")
  EchoExperience:ShowOutputsSub(EchoExperience.accountVariables.defaults.lootsettings,  "LOOT defaults",msgTypeLOOT)
  EchoExperience:ShowOutputsSub(EchoExperience.accountVariables.defaults.guildsettings, "GUILD defaults",msgTypeGUILD)
end

function EchoExperience:ShowTracking()
  d ( zo_strformat( "<<1>> (<<2>>) <<3>>","Session Tracked ", tostring(EchoExperience.savedVariables.showtracking), "Start==>") )
  for k, v in pairs(EchoExperience.savedVariables.tracking.items) do
    if(v~=nil and v.quantity~=nil)then
      d ( zo_strformat( "<<3>>=<<2>>",k, v.quantity, v.itemlink) )
    end
  end
  for k, v in pairs(EchoExperience.savedVariables.tracking.currency) do
    if(v~=nil and v.quantity~=nil)then
      local currname = GetCurrencyName(k, true, false)
      d ( zo_strformat( "<<1>>=<<2>>", currname, v.quantity) )
      d ( zo_strformat( "--plus=<<2>>", currname, v.plus) )
      d ( zo_strformat( "--minus=<<2>>", currname, v.minus) )
    end
  end  
  for k, v in pairs(EchoExperience.savedVariables.tracking.mobs) do
    if(v~=nil and v.quantity~=nil)then
      local ctype = EchoExperience:GetCombatUnitType(v.targetType)
      d ( zo_strformat( "<<1>>=<<2>> (<<4>>)", k, v.quantity, v.itemlink, ctype)  )
    end
  end
  d("<==Session Tracked Done")
  --EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.expsettings,   "EXP outputs")
  --EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.lootsettings,  "LOOT outputs", msgTypeLOOT)
  --EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.guildsettings, "GUILD outputs",msgTypeGUILD)
end

function EchoExperience:ShowLifetimeTracking()
  d ( zo_strformat( "<<1>> (<<2>>) <<3>>","Lifetime Tracked ", tostring(EchoExperience.savedVariables.showtracking), "Start==>") )
  for k, v in pairs(EchoExperience.savedVariables.lifetime.items) do
    if(v~=nil and v.quantity~=nil)then
      d ( zo_strformat( "<<3>>=<<2>>",k, v.quantity, v.itemlink) )
    end
  end
  for k, v in pairs(EchoExperience.savedVariables.lifetime.currency) do
    if(v~=nil and v.quantity~=nil)then
      local currname = GetCurrencyName(k, true, false)
      d ( zo_strformat( "<<1>>=<<2>>", currname, v.quantity) )
      d ( zo_strformat( "--plus=<<2>>", currname, v.plus) )
      d ( zo_strformat( "--minus=<<2>>", currname, v.minus) )
    end
  end  
  for k, v in pairs(EchoExperience.savedVariables.lifetime.mobs) do
    if(v~=nil and v.quantity~=nil)then
      local ctype = EchoExperience:GetCombatUnitType(v.targetType)
      d ( zo_strformat( "<<1>>=<<2>> (<<4>>)", k, v.quantity, v.itemlink, ctype)  )
    end
  end
  d("<==Lifetime Tracked Done")
  --EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.expsettings,   "EXP outputs")
  --EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.lootsettings,  "LOOT outputs", msgTypeLOOT)
  --EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.guildsettings, "GUILD outputs",msgTypeGUILD)
end

function EchoExperience:GetCombatUnitType(gnum)
  --EchoExperience.debugMsg("GetGuildName:=".. gnum.. " name='"..GetGuildName(gnum).."'")  
  local ret = nil
  if(gnum==nil) then return ret end
  if(gnum==COMBAT_UNIT_TYPE_GROUP) then return "Group" end
  if(gnum==COMBAT_UNIT_TYPE_NONE) then return "None" end
  if(gnum==COMBAT_UNIT_TYPE_OTHER) then return "Other" end
  if(gnum==COMBAT_UNIT_TYPE_PLAYER) then return "Player" end
  if(gnum==COMBAT_UNIT_TYPE_PLAYER_PET) then return "Pet" end
  if(gnum==COMBAT_UNIT_TYPE_TARGET_DUMMY) then return "Dummy" end
end

    
function EchoExperience:GetGuildName(gnum)
  EchoExperience.debugMsg("GetGuildName:=".. gnum.. " name='"..GetGuildName(gnum).."'")  
  return GetGuildName(gnum)
end

-- Main Output Function used by addon to control output and style
function EchoExperience.outputToChanel(text,msgType,filter)
	--Output to where
	if msgType == msgTypeSYS then
		d(text)
	elseif msgType == msgTypeEXP then
    EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.expsettings,filter )
    return
	elseif msgType == msgTypeLOOT then
    EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.lootsettings,filter)
    return
	elseif msgType == msgTypeGUILD then
    EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.guildsettings,filter)
    if(EchoExperience.error)then
      EchoExperience.error = false
      EchoExperience.savedVariables.showGuildLogin  = false
      EchoExperience.savedVariables.showGuildLogout = false
      EchoExperience.outputMsg("Guild notifications are turned off")
    end
    return
	else
		--
  end
end

function EchoExperience:ShowOutputsSub(dataSettings, headerText, msgType)
  if dataSettings ~= nil then
    EchoExperience.outputMsg(headerText)
    for k, v in pairs(dataSettings) do
      local c = ZO_ColorDef:New(v.color.r, v.color.g, v.color.b, v.color.a)
      local ctext = c:Colorize("COLOR")
      local cVals = zo_strformat( "r=<<1>>/g=<<2>>/b=<<3>>/a=<<4>>",
          string.format("%.3d",( (255*v.color.r) ) ),
          string.format("%.3d",( (255*v.color.g) ) ),
          string.format("%.3d",( (255*v.color.b) ) ),
          string.format("%.3d",( (255*v.color.a) ) )  )
      local gval = ""
      if(msgType==msgTypeLOOT)then
        gval=""
        --"itemLoot" "groupLoot"
      end      
      if(msgType==msgTypeGUILD) then
        gval = "[Show all]"
        if(v.guilds~=nil) then
          gval = zo_strformat( "[g1=<<1>>/g2=<<2>>/g3=<<3>>/g4=<<4>>/g5=<<5>>]", tostring(v.guilds.guild1),tostring(v.guilds.guild2),tostring(v.guilds.guild3),tostring(v.guilds.guild4),tostring(v.guilds.guild5) )
        end            
      end
      local val = zo_strformat( "win=<<1>>, tab=<<2>>, color=<<3>> (<<4>>) <<5>>", v.window,v.tab,ctext,cVals,gval )
      EchoExperience.outputMsg(val)
    end
  else
    EchoExperience.outputMsg("No "..headerText.." configured")
  end 
end

function EchoExperience:outputToChanelSub(text,outputSettings,filter)
  if(text==nil) then return end
  if outputSettings == nil then return end
  for k, v in pairs(outputSettings) do
    if(v.window~=nil and v.tab~=nil and v.window>0 and v.tab>0 and v.color~=nil and v.color.r~=nil) then
      local skip = false
      --filter
      if(filter~=nil and filter.type == msgTypeGUILD and v.guilds~=nil) then
        EchoExperience.debugMsg("filter.guildID="..filter.guildID)
        skip = true
        local gkey = "guild"..filter.guildID
        if(v.guilds[gkey]==nil) then skip = false
        elseif(v.guilds[gkey]==true)then
          skip = false
          EchoExperience.debugMsg("Found guildid in show list")
        end
      end
      if(not skip) then
        --colorized text and write it out
        local cCD = ZO_ColorDef:New(v.color.r,v.color.g,v.color.b,v.color.a)
        local text2 = cCD:Colorize(text)
        if(text2~=nil) then 
          --TODO timestamp
          --EchoExperience.savedVariables.showTimeStamp
          --EchoExperience.savedVariables.timeStampFormat
          CHAT_SYSTEM.containers[v.window].windows[v.tab].buffer:AddMessage(text2)
        end
      end
    else
      --ERROR
      EchoExperience.error = true
      if( v.color~=nil) then
        local cVals = zo_strformat( "r=<<1>>/g=<<2>>/b=<<3>>/a=<<4>>", tostring(v.color.r),tostring(v.color.g),tostring(v.color.b),tostring(v.color.a) )
         local cText = zo_strformat( "Error in config: tab=<<1>>/win=<<2>>/color=<<3>>",tostring(v.tab),tostring(v.window),cVals )
        EchoExperience.outputMsg(cText);
      else
         local cText = zo_strformat( "Error in config: tab=<<1>>/win=<<2>>/color of setting",tostring(v.tab),tostring(v.window) )
        EchoExperience.outputMsg(cText);
      end
    end
  end
end

-- Helper that Wraps text with a color.
function EchoExperience.Colorize(text, color)
    if  color == nil then return text end
    text = "|c" .. color .. text .. "|r"
    return text
end

function EchoExperience:deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[EchoExperience:deepcopy(orig_key)] = EchoExperience:deepcopy(orig_value)
        end
        setmetatable(copy, EchoExperience:deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
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
		EchoExperience.outputMsg("commands include: 'outputs', 'textexp', 'testloot', 'testfull', 'debug', 'toggletracking', 'showtracking', 'showlifetime'")
  elseif #options == 0 or options[1] == "testgui" then
    EchoExperience:ToggleTrackingFrame()
  elseif #options == 0 or options[1] == "testevents" then
    EchoExperience.savedVariables.showGuildMisc  = not EchoExperience.savedVariables.showGuildMisc
    EchoExperience.outputMsg("ShowGuildMisc = " .. tostring(EchoExperience.savedVariables.showGuildMisc) )
    EchoExperience.SetupGuildEvents()
	elseif #options == 0 or options[1] == "outputs" then
		EchoExperience.ShowOutputs()
	elseif #options == 0 or options[1] == "defaults" then
		EchoExperience.ShowDefaults()
	elseif #options == 0 or options[1] == "showtracking" then
		EchoExperience.ShowTracking()
	elseif #options == 0 or options[1] == "showtrackinggui" then
		EchoExperience:ToggleTrackingFrame()
  elseif #options == 0 or options[1] == "showlifetime" then
    EchoExperience.ShowLifetimeTracking()
	elseif #options == 0 or options[1] == "cleartracking" then
		EchoExperience.savedVariables.tracking = {}
    EchoExperience.savedVariables.tracking.items = {}
    EchoExperience.savedVariables.tracking.currency = {}
    EchoExperience.savedVariables.tracking.mobs = {}
    EchoExperience.savedVariables.tracking.bg = {}
    EchoExperience.outputMsg("Tracking data reset")
	elseif #options == 0 or options[1] == "toggletracking" then
		EchoExperience.savedVariables.showtracking = not EchoExperience.savedVariables.showtracking
    EchoExperience.outputMsg("Showtracking = " .. tostring(EchoExperience.savedVariables.showtracking) )
    EchoExperience:SetupLootGainsEvents(true)
	elseif #options == 0 or options[1] == "testexp" then
		EchoExperience.outputToChanel("Gained 0 xp in [Test] (1000/10000) need 9000xp",msgTypeEXP)
	elseif #options == 0 or options[1] == "testloot" then
		EchoExperience.outputToChanel("You looted TESTITEM.",msgTypeLOOT)
	elseif #options == 0 or options[1] == "testfull" then		--eventCode,receivedBy,itemName,quantity,soundCategory,lootType,isSelf,isPickpocketLoot,questItemIcon,itemId,isStolen)
		EchoExperience.OnLootReceived(0,"testuser","testitem",1,nil,nil,true,false,false,0,false)
		EchoExperience.OnLootReceived(0,"testuser","testitem",2,nil,nil,true,false,false,0,false)
		EchoExperience.OnLootReceived(0,"testuser","testitem",2,nil,nil,false,false,false,0,false)
	elseif #options == 0 or options[1] == "debug" then
		local dg = EchoExperience.savedVariables.debug
		EchoExperience.savedVariables.debug = not dg
		EchoExperience.outputMsg("Debug = " .. tostring(EchoExperience.savedVariables.debug) )
	end

end


function EchoExperience:ToggleTrackingFrame()
	EOL_GUI:SetHidden(not EOL_GUI:IsControlHidden())
  --EOL_GUI:SetHidden( not EOL_GUI:IsHidden() )
  --
  EEXPTooltip:SetParent(PopupTooltipTopLevel)
  EOL_GUI_Header_Dropdown_Main.comboBox = EOL_GUI_Header_Dropdown_Main.comboBox or ZO_ComboBox_ObjectFromContainer(EOL_GUI_Header_Dropdown_Main)
  local comboBox = EOL_GUI_Header_Dropdown_Main.comboBox
  comboBox:ClearItems()  
  comboBox:SetSortsItems(false)
  local function OnItemSelect1(_, choiceText, choice)
    --TODO
    --EchoesOfLore:debugMsg(" choiceText=" .. choiceText .. " choice=" .. tostring(choice) )  
    --EchoesOfLore:clearView()
    EchoExperience.view.trackingSelection = choiceText
    --EchoesOfLore:showViewTips2(choiceText)
    EchoExperience:UpdateScrollDataLinesData()
		EchoExperience:GuiResizeScroll()
		EchoExperience:RefreshInventoryScroll()
    PlaySound(SOUNDS.POSITIVE_CLICK)    
  end
  local validChoices = {}  
  table.insert(validChoices, "Session")
  table.insert(validChoices, "Lifetime")
  for i = 1, #validChoices do
    local entry = comboBox:CreateItemEntry(validChoices[i], OnItemSelect1)
    comboBox:AddItem(entry)
  end
  
   
	if not EOL_GUI:IsControlHidden() then
		--SetGameCameraUIMode(true)
		EchoExperience:GuiResizeScroll()
		EchoExperience:RefreshInventoryScroll()
	end
	--if not EchoExperience.data.dontFocusSearch then
		--EOL_GUI_SearchBox:TakeFocus()
	--end
  --EOL_GUI_Header_Dropdown_Main:TakeFocus()
  comboBox:SelectFirstItem()
	EchoExperience:SaveFrameInfo("ToggleInventoryFrame")
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

--ONEvent  EVENT_SKILL_LINE_ADDED
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

--EVENT_LOOT_ITEM_FAILED (number eventCode, LootItemResult reason, string itemName) 
function EchoExperience.OnLootFailed(eventCode, reason, itemName)
		EchoExperience.debugMsg("OnLootFailed: "
			.." eventCode="  .. tostring(eventCode)
			.." reason="     .. tostring(reason)
			.." itemName="   .. tostring(itemName)
		)
end

--EVENT_BANKED_CURRENCY_UPDATE (number eventCode, CurrencyType currency, number newValue, number oldValue) 
function EchoExperience.OnBankedCurrency(eventCode, currency, newValue, oldValue) 
  EchoExperience.debugMsg("OnBankedCurrency: "
    .." eventCode="  .. tostring(eventCode)
    .." currency="   .. tostring(currency)
    .." newValue="   .. tostring(newValue)
    .." oldValue="   .. tostring(oldValue)      
  )
  --Tracking
  if(EchoExperience.savedVariables.showtracking) then
    if(EchoExperience.savedVariables.tracking.currency[currency]==nil)then
      EchoExperience.savedVariables.tracking.currency[currency] = {}
      EchoExperience.savedVariables.tracking.currency[currency].quantity=0
    end
    EchoExperience.savedVariables.tracking.currency[currency].quantity=EchoExperience.savedVariables.tracking.currency[currency].quantity+ (oldValue - newValue)
  end--Tracking
end
--EVENT_CURRENCY_UPDATE (number eventCode, CurrencyType currencyType, CurrencyLocation currencyLocation, number newAmount, number oldAmount, CurrencyChangeReason reason) 
function EchoExperience.OnCurrencyUpdate(eventCode, currencyType, currencyLocation, newAmount, oldAmount, reason) 
  EchoExperience.debugMsg("OnCurrencyUpdate: "
    .." eventCode="  .. tostring(eventCode)
    .." currencyType="     .. tostring(currencyType)
    .." currencyLocation="   .. tostring(currencyLocation)
    .." newAmount="     .. tostring(newAmount)
    .." oldAmount="   .. tostring(oldAmount)
    .." reason="   .. tostring(reason)      
  )
  if(reason==35) then
    return --Just a UI refresh
  end
  
  local qualifier = 1
  local entryQuantity = oldAmount - newAmount
  local isSingular = true
  if(entryQuantity>1) then isSingular = false end
  if(newAmount>oldAmount) then 
    qualifier = 2
    entryQuantity = newAmount - oldAmount
  end
  --Tracking
  if(EchoExperience.savedVariables.showtracking) then
    if(EchoExperience.savedVariables.tracking.currency[currencyType]==nil)then
      EchoExperience.savedVariables.tracking.currency[currencyType] = {}
      EchoExperience.savedVariables.tracking.currency[currencyType].quantity=0
      EchoExperience.savedVariables.tracking.currency[currencyType].plus=0
      EchoExperience.savedVariables.tracking.currency[currencyType].minus=0
    end
    EchoExperience.savedVariables.tracking.currency[currencyType].quantity=EchoExperience.savedVariables.tracking.currency[currencyType].quantity+ (newAmount - oldAmount)
    if( qualifier == 2 ) then
      EchoExperience.savedVariables.tracking.currency[currencyType].plus=EchoExperience.savedVariables.tracking.currency[currencyType].plus+ (newAmount - oldAmount)
    else
      EchoExperience.savedVariables.tracking.currency[currencyType].minus=EchoExperience.savedVariables.tracking.currency[currencyType].minus+ (newAmount - oldAmount)
    end
  end--Tracking

  local icon = GetCurrencyKeyboardIcon(currencyType) 
  --local icon = GetCurrencyLootKeyboardIcon(currencyType) 
  local entryName = GetCurrencyName(currencyType, isSingular, false )
  local sentence = GetString("SI_ECHOLOOT_CURRENCY_",qualifier)
  local strL = zo_strformat(sentence, icon, entryName, entryQuantity )
	EchoExperience.outputToChanel(strL,msgTypeLOOT)
end


--EVENT_SELL_RECEIPT (eventCode, itemName, itemQuantity, money)
function EchoExperience.OnSellReceipt(eventCode, itemName, itemQuantity, money) 
  EchoExperience.debugMsg("OnSellReceipt: "
    .." eventCode="  .. tostring(eventCode)
    .." itemName="     .. tostring(itemName)
    .." itemQuantity=" .. tostring(itemQuantity)
    .." money="   .. tostring(money)      
  )
  local qualifier = 1
  if(itemQuantity>1) then qualifier = 2 end
  local icon, sellPrice, meetsUsageRequirement, equipType, itemStyleId = GetItemLinkInfo(itemName)
  --local curricon = GetCurrencyKeyboardIcon(currencyType) 
  local sentence = GetString("SI_ECHOLOOT_SELL_",qualifier)
  local strL = zo_strformat(sentence, icon, itemName, itemQuantity, money )
	EchoExperience.outputToChanel(strL,msgTypeLOOT)
end

--EVENT_BUYBACK_RECEIPT (number eventCode, string itemLink, number itemQuantity, number money, ItemUISoundCategory itemSoundCategory)
function EchoExperience.OnBuybackReceipt(eventCode, itemLink, itemQuantity, money, itemSoundCategory) 
  EchoExperience.debugMsg("OnBuybackReceipt: "
    .." eventCode="  .. tostring(eventCode)
    .." itemLink="     .. tostring(itemLink)
    .." itemQuantity="   .. tostring(itemQuantity)
    .." money="   .. tostring(money)      
    .." itemSoundCategory="   .. tostring(itemSoundCategory)          
  )
  local qualifier = 1
  if(itemQuantity>1) then qualifier = 2 end
  --local icon, sellPrice, meetsUsageRequirement, equipType, itemStyleId = GetItemLinkInfo(itemLink)
  local icon = GetItemLinkIcon(itemLink) 
  --local curricon = GetCurrencyKeyboardIcon(currencyType) 
  local sentence = GetString("SI_ECHOLOOT_BUYBACK_",qualifier)
  local strL = zo_strformat(sentence, icon, itemLink, itemQuantity, money )
	EchoExperience.outputToChanel(strL,msgTypeLOOT)
end


--EVENT_BUY_RECEIPT (number eventCode, string entryName, StoreEntryType entryType, number entryQuantity, number money, CurrencyType specialCurrencyType1, string specialCurrencyInfo1, number specialCurrencyQuantity1, CurrencyType specialCurrencyType2, string specialCurrencyInfo2, number specialCurrencyQuantity2, ItemUISoundCategory itemSoundCategory) 
function EchoExperience.OnBuyReceipt(eventCode, entryName, entryType, entryQuantity, money, specialCurrencyType1, specialCurrencyInfo1, specialCurrencyQuantity1, specialCurrencyType2, specialCurrencyInfo2, specialCurrencyQuantity2, itemSoundCategory) 
		EchoExperience.debugMsg("OnBuyReceipt: "
			.." eventCode="  .. tostring(eventCode)
			.." entryName="  .. tostring(entryName)
			.." entryType="  .. tostring(entryType)
      .." entryQuantity="  .. tostring(entryQuantity)
      .." money="  .. tostring(money)
      .." specialCurrencyType1="  .. tostring(specialCurrencyType1)
      .." specialCurrencyInfo1="  .. tostring(specialCurrencyInfo1)
      .." specialCurrencyQuantity1="  .. tostring(specialCurrencyQuantity1)
      .." specialCurrencyType2="  .. tostring(specialCurrencyType2)
      .." specialCurrencyInfo2="  .. tostring(specialCurrencyInfo2)
      .." specialCurrencyQuantity2="  .. tostring(specialCurrencyQuantity2)
      .." itemSoundCategory="  .. tostring(itemSoundCategory)      
		)
  local qualifier = 1
  if(entryQuantity>1) then qualifier = 2 end
  local icon, sellPrice, meetsUsageRequirement, equipType, itemStyleId = GetItemLinkInfo(entryName)  
  --local icon = GetItemLinkIcon(itemLink) 
  local sentence = GetString("SI_ECHOLOOT_BUY_",qualifier)
  local strL = zo_strformat(sentence, icon, entryName, entryQuantity, money )
	EchoExperience.outputToChanel(strL,msgTypeLOOT)
end

-- EVENT_ALLIANCE_POINT_UPDATE (number eventCode, number alliancePoints, boolean playSound, number difference, CurrencyChangeReason reason) 
function EchoExperience.OnAlliancePointUpdate(eventCode, alliancePoints, playSound, difference, reason) 
		EchoExperience.debugMsg("OnAlliancePointUpdate: "
			.." eventCode="  .. tostring(eventCode)
			.." alliancePoints="     .. tostring(alliancePoints)
      .." playSound="   .. tostring(playSound)            
			.." difference=" .. tostring(difference)
			.." reason="   .. tostring(reason)      
		)
end

--EVENT_INVENTORY_ITEM_DESTROYED (number eventCode, ItemUISoundCategory itemSoundCategory) 
function EchoExperience.OnInventoryItemDestroyed(eventCode, ItemUISoundCategory, itemSoundCategory) 
		EchoExperience.debugMsg("OnInventoryItemDestroyed: "
			.." eventCode="  .. tostring(eventCode)
			.." ItemUISoundCategory="     .. tostring(ItemUISoundCategory)
      .." itemSoundCategory="   .. tostring(itemSoundCategory)            
		)
end

--EVENT_INVENTORY_ITEM_USED (number eventCode, ItemUISoundCategory itemSoundCategory) 
function EchoExperience.OnInventoryItemUsed(eventCode, ItemUISoundCategory, itemSoundCategory) 
		EchoExperience.debugMsg("OnInventoryItemUsed: "
			.." eventCode="  .. tostring(eventCode)
			.." ItemUISoundCategory="     .. tostring(ItemUISoundCategory)
      .." itemSoundCategory="   .. tostring(itemSoundCategory)            
		)
end

--EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS (number eventCode, id64 mailId)
function EchoExperience.OnMailItemRecieved(eventCode,mailId)
--        ZO_MailInboxShared_PopulateMailData(self:GetMailData(self.mailId), mailId)
--GetAttachedItemLink(id64 mailId, number attachIndex, number LinkStyle linkStyle)
  --  Returns: string link 
end

--EVENT_MAIL_TAKE_ATTACHED_MONEY_SUCCESS (number eventCode, id64 mailId) 
function EchoExperience.OnMailMoneyRecieved(eventCode,mailId)
  --
end

--EVENT_INVENTORY_SINGLE_SLOT_UPDATE (number eventCode, Bag bagId, number slotId, boolean isNewItem, ItemUISoundCategory itemSoundCategory, number inventoryUpdateReason, number stackCountChange) 
function EchoExperience.OnInventorySingleSlotUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    if(not isNewItem) then
      return
    end
		EchoExperience.debugMsg("OnInventorySingleSlotUpdate: "
			.." eventCode="  .. tostring(eventCode)
      .." bagId="   .. tostring(bagId)
      .." slotId="   .. tostring(slotId)
      .." isNewItem="   .. tostring(isNewItem)
			.." ItemUISoundCategory="     .. tostring(ItemUISoundCategory)
      .." inventoryUpdateReason="   .. tostring(inventoryUpdateReason)            
      .." stackCountChange="   .. tostring(stackCountChange)
		)    
    --local icon, stack, sellPrice, meetsUsageRequirement, locked, equipType, itemStyleId, quality = GetItemInfo(bagId, slotId)
    --local itemName = GetItemName(bagId, slotId)
    local itemLink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)	
		EchoExperience.debugMsg("GetItemInfo: "
      .." itemLink="  .. tostring(itemLink)      
		)
    --[[
		EchoExperience.debugMsg("GetItemInfo: "
      .." itemName="  .. tostring(itemName)      
			.." stack="     .. tostring(stack)
      .." equipType=" .. tostring(equipType)
      .." quality="   .. tostring(quality)
		)
    131219 mail? from?
    queue up messages?
    -]]
    
    local qualifier = 1
    if(stackCountChange>1) then qualifier = 2 end
    local icon = GetItemLinkIcon(itemLink) 
    local itemName = GetItemLinkName(itemLink) 
    if(isNewItem and itemLink~=nil) then
      --local curricon = GetCurrencyKeyboardIcon(currencyType) 
      local sentence = GetString("SI_ECHOLOOT_RECEIVE_",qualifier)
      local strL = zo_strformat(sentence, icon, itemLink, stackCountChange )
      EchoExperience.outputToChanel(strL,msgTypeLOOT)
    --elseif( itemLink~=nil and icon~=nil ) then
    --  local sentence = GetString("SI_ECHOLOOT_LOSE_",qualifier)
    --  local strL = zo_strformat(sentence, icon, itemLink, stackCountChange )
    --  EchoExperience.outputToChanel(strL,msgTypeLOOT)      
        --Tracking
        if(EchoExperience.savedVariables.showtracking) then
          if(EchoExperience.savedVariables.tracking.items[itemName]==nil)then
            EchoExperience.savedVariables.tracking.items[itemName] = {}
            EchoExperience.savedVariables.tracking.items[itemName].quantity=0
          end
          EchoExperience.savedVariables.tracking.items[itemName].quantity=EchoExperience.savedVariables.tracking.items[itemName].quantity+ (stackCountChange)
          --if(itemLink==nil) then itemLink = itemName
          EchoExperience.savedVariables.tracking.items[itemName].itemlink=itemLink
        end--Tracking
    else
      --
    end
    
end

--EVENT_ITEM_SLOT_CHANGED (number eventCode, ItemUISoundCategory itemSoundCategory)
--EVENT_MONEY_UPDATE (number eventCode, number newMoney, number oldMoney, CurrencyChangeReason reason) 


--ONEvent  shows loot gains
--EVENT:   EVENT_LOOT_RECEIVED
--RETURNS:(num eventCode, str receivedBy, str itemName, num quantity,
--			ItemUISoundCategory soundCategory, LootItemType lootType,
--			bool self, bool isPickpocketLoot, str questItemIcon, num itemId, bool isStolen)
--NOTES:  XX
--LOOTTPE=LOOT_TYPE_ANY,LOOT_TYPE_CHAOTIC_CREATIA, LOOT_TYPE_COLLECTIBLE, LOOT_TYPE_ITEM, LOOT_TYPE_MONEY,
--				LOOT_TYPE_QUEST_ITEM, LOOT_TYPE_STYLE_STONES, LOOT_TYPE_TELVAR_STONES,LOOT_TYPE_WRIT_VOUCHERS
function EchoExperience.OnLootReceived(eventCode,receivedBy,itemName,quantity,soundCategory,lootType,isSelf,isPickpocketLoot,questItemIcon,itemId,isStolen)
  -- Get Extra Info for types that have it
	local extraInfo = nill  
	if lootType ~= nil and lootType ~= LOOT_TYPE_MONEY and lootType ~= LOOT_TYPE_QUEST_ITEM then
		--if itemType ~= ITEMTYPE_ARMOR_TRAIT and itemType ~= ITEMTYPE_WEAPON_TRAIT -- lootType ~= LOOT_TYPE_COLLECTIBLE
		local traitName, setName = EchoExperience:GetExtraInfo(itemName)
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
  --[[Tracking
  if(EchoExperience.savedVariables.showtracking) then
    local itemNameR = GetItemLinkName(itemLink) 
    if(EchoExperience.savedVariables.tracking.items[itemNameR]==nil)then
      EchoExperience.savedVariables.tracking.items[itemNameR] = {}
      EchoExperience.savedVariables.tracking.items[itemNameR].quantity=0
    end
    EchoExperience.savedVariables.tracking.items[itemNameR].quantity=EchoExperience.savedVariables.tracking.items[itemNameR].quantity+1
  end--Tracking
  --]]
  
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

--EVENT_GUILD_MEMBER_ADDED (number eventCode, number guildId, string displayName) 
function EchoExperience.OnGuildMemberAdded(eventCode,guildID,playerName)
  --EchoExperience.debugMsg
  d("OnGuildMemberAdded: "
    .." eventCode="   .. tostring(eventCode)
    .." guildID="     .. tostring(guildID)      
    .." guild="       .. tostring(EchoExperience:GetGuildName(guildID))      
    .." playerName="     .. tostring(playerName)
  )
  local sentence = GetString("SI_ECHOEXP_GUILDADD_",1)
  local strL = zo_strformat(sentence, eventCode, tostring(guildID), EchoExperience:GetGuildName(guildID), tostring(playerName), ZO_FormatClockTime() )
  --TODO guild icon? color? player LINK?
  --TODO if check?
      local filter = {}
      filter.type = msgTypeGUILD
      filter.guildID = guildID
      EchoExperience.outputToChanel(strL,msgTypeGUILD,filter) 

end

--EVENT_GUILD_MEMBER_REMOVED (number eventCode, number guildId, string displayName, string characterName) 
function EchoExperience.OnGuildMemberRemoved(eventCode,guildID,displayName,characterName)
  --EchoExperience.debugMsg
  d("OnGuildMemberRemoved: "
    .." eventCode="      .. tostring(eventCode)
    .." guildID="     .. tostring(guildID)      
    .." guild="       .. tostring(EchoExperience:GetGuildName(guildID))      
    .." displayName="     .. tostring(displayName)
    .." characterName="     .. tostring(characterName)
  )
  local sentence = GetString("SI_ECHOEXP_GUILDREM_",1)
  local strL = zo_strformat(sentence, eventCode, tostring(guildID), EchoExperience:GetGuildName(guildID), tostring(playerName), ZO_FormatClockTime() )
  --TODO if check?
      local filter = {}
      filter.type = msgTypeGUILD
      filter.guildID = guildID
      EchoExperience.outputToChanel(strL,msgTypeGUILD,filter) 

end
--[20:01] OnGuildMemberRemoved:  eventCode=327707 guildID=4 displayName=@luda9400 characterName=I Heal Tanks^Fx
--TODO
--EVENT_GUILD_MEMBER_RANK_CHANGED (number eventCode, number guildId, string displayName, number rankIndex) 
--EVENT_GUILD_MEMBER_NOTE_CHANGED (number eventCode, number guildId, string displayName, string note) 
--EVENT_GUILD_MEMBER_RANK_CHANGED (number eventCode, number guildId, string displayName, number rankIndex) 
--EVENT_GUILD_SELF_JOINED_GUILD (number eventCode, number guildServerId, string characterName, number guildId)
--EVENT_GUILD_SELF_LEFT_GUILD (number eventCode, number guildServerId, string characterName, number guildId) 


--EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED (integer GuildID,string PlayerName,luaindex prevStatus,luaindex curStatus)
--["PLAYER_STATUS_AWAY"] = 2 ["PLAYER_STATUS_DO_NOT_DISTURB"] = 3
--["PLAYER_STATUS_OFFLINE"] = 4 ["PLAYER_STATUS_ONLINE"] = 1 
function EchoExperience.OnGuildMemberStatusChanged(eventCode,guildID,playerName,prevStatus,curStatus)
  EchoExperience.debugMsg("OnGuildMemberStatusChanged called") -- Prints to chat.    
  local sentence = GetString("SI_ECHOEXP_GUILD_",1)
  --"eventCode: <<1>>, guildID: <<2>>, playerName: <<3>>, prevStatus: <<4>>, curStatus: <<5>> ."  
  local strL = zo_strformat(sentence, eventCode, tostring(guildID), tostring(playerName), tostring(prevStatus), tostring(curStatus) )
  EchoExperience.debugMsg(strL)
  local gName = EchoExperience:GetGuildName(guildID)
  EchoExperience.debugMsg("gName='"..gName.."'")
  if(curStatus == 1) then
    --online
    if (EchoExperience.savedVariables.showGuildLogin) then
      --local sentence2 = "[EchoExp] <<3>> Logged IN at <<6>>"  
      local sentence2 = GetString("SI_ECHOEXP_GUILD_",2)
      local strL2 = zo_strformat(sentence2, tostring(guildID), (playerName), tostring(prevStatus), tostring(curStatus), ZO_FormatClockTime(), gName )
      local filter = {}
      filter.type = msgTypeGUILD
      filter.guildID = guildID
      EchoExperience.outputToChanel(strL2,msgTypeGUILD,filter)  
    end
  elseif(curStatus == 4) then
    --offline
    if (EchoExperience.savedVariables.showGuildLogout) then
      local sentence2 = GetString("SI_ECHOEXP_GUILD_",3)
      --local sentence2 = "[EchoExp] <<3>> Logged OUT at <<6>>"  
      local strL2 = zo_strformat(sentence2, tostring(guildID), (playerName), tostring(prevStatus), tostring(curStatus), ZO_FormatClockTime(), gName )
      local filter = {}
      filter.type = msgTypeGUILD
      filter.guildID = guildID
      EchoExperience.outputToChanel(strL2,msgTypeGUILD,filter)  
    end
  end
end

--EVENT_BATTLEGROUND_KILL (number eventCode, string killedPlayerCharacterName, string killedPlayerDisplayName, BattlegroundAlliance killedPlayerBattlegroundAlliance, string killingPlayerCharacterName, string killingPlayerDisplayName, BattlegroundAlliance killingPlayerBattlegroundAlliance, BattlegroundKillType battlegroundKillType, number killingAbilityId) 
function EchoExperience.OnBattlegroundKill(eventCode, killedPlayerCharacterName, killedPlayerDisplayName, killedPlayerBattlegroundAlliance, killingPlayerCharacterName, killingPlayerDisplayName, killingPlayerBattlegroundAlliance, battlegroundKillType, killingAbilityId)
  --
end

--EVENT_UNIT_DESTROYED (number eventCode, string unitTag) 
function EchoExperience.OnUnitDestroyed(eventCode, unitTag)
  d("OnUnitDestroyed: "
			.." eventCode="  .. tostring(eventCode)
			.." unitTag="     .. tostring(unitTag)
		)
end

--EVENT_COMBAT_EVENT (number eventCode, ActionResult result, boolean isError, string abilityName, number abilityGraphic, ActionSlotType abilityActionSlotType, string sourceName, CombatUnitType sourceType, string targetName, CombatUnitType targetType, number hitValue, CombatMechanicType powerType, DamageType damageType, boolean log, number sourceUnitId, number targetUnitId, number abilityId) 
function EchoExperience.OnCombatSomethingDied(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
  if(isError)then
    return
  end
  if(result==ACTION_RESULT_IN_COMBAT ) then  
  EchoExperience.debugMsg("OnCombatSomethingDied: "
    .." eventCode="      .. tostring(eventCode)
    .." sourceName="     .. tostring(sourceName)      
    .." targetName="     .. tostring(targetName)
    .." targetType="     .. tostring(targetType)
    .." result="         .. tostring(result)
    .." isError="        .. tostring(isError)      
    .." abilityName="    .. tostring(abilityName)      
    .." sourceUnitId="    .. tostring(sourceUnitId)     
    .." targetUnitId="    .. tostring(targetUnitId)
  )
  end
  --]]
  --ACTION_RESULT_DIED_XP ???
  --ACTION_RESULT_TARGET_DEAD 
  if(result~=ACTION_RESULT_DIED and result~=ACTION_RESULT_DIED_XP)then
    --EchoExperience.debugMsg("OnCombatSomethingDied: not dead event")
    return
  end

  --sourceName==nil or sourceName=="" or
  if(isError or targetName==nil or targetName=="") then
    EchoExperience.debugMsg("OnCombatSomethingDied: no good data")
    EchoExperience.debugMsg("OnCombatSomethingDied: "
    .." eventCode="      .. tostring(eventCode)
    .." sourceName="     .. tostring(sourceName)      
    .." targetName="     .. tostring(targetName)
    .." targetType="     .. tostring(targetType)
    .." result="         .. tostring(result)
    .." isError="        .. tostring(isError)      
    .." abilityName="    .. tostring(abilityName)     
    .." sourceUnitId="    .. tostring(sourceUnitId)     
    .." targetUnitId="    .. tostring(targetUnitId)
  )
    return
  else
    EchoExperience.debugMsg("OnCombatSomethingDied: "
    .." sourceUnitId="      .. tostring(sourceUnitId)
    .." targetUnitId="     .. tostring(targetUnitId) 
    .." result="     .. tostring(result) 
    )
  end
  -- Check if just got this target death notification
  if(EchoExperience.view.lastKilledTargetId ~= nil and 
        EchoExperience.view.lastKilledTargetId == targetUnitId) then
    EchoExperience.view.lastKilledTargetId = nil
    return
  end
  
  EchoExperience.view.lastKilledTargetId = targetUnitId
  
 --Tracking
  if(EchoExperience.savedVariables.showtracking) then
    if(EchoExperience.savedVariables.tracking.mobs[targetName]==nil)then
      EchoExperience.savedVariables.tracking.mobs[targetName] = {}
      EchoExperience.savedVariables.tracking.mobs[targetName].quantity=0
    end    
    EchoExperience.savedVariables.tracking.mobs[targetName].quantity=EchoExperience.savedVariables.tracking.mobs[targetName].quantity+ 1
    EchoExperience.savedVariables.tracking.mobs[targetName].targetType=targetType
  end--Tracking
  --TODO localize etc  
  local sentence = GetString(SI_ECHOEXP_KILL_MOB)
  local strL = zo_strformat(sentence, targetName )
  EchoExperience.outputToChanel(strL,msgTypeSYS)
  --d("You killed a "..targetName)
end

--Sample Events
--[20:44] OnCombatSomethingDied:  eventCode=131102 sourceName=Hannaya^Fx targetName=Wolf targetType=0 result=2260 isError=false abilityName=Mages' Wrath
--[21:27] OnCombatSomethingDied:  eventCode=131102 sourceName= targetName= targetType=0 result=2260 isError=false abilityName=

 
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
    EchoExperience.outputMsg("WARN: Dropdown not found, changes will not be reflected until /reloadui")
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

--Todo generalized and use this
function EchoExperience:ListOfTabs(valSettings)
  local validChoices =  {}  
	table.insert(validChoices, "Select")
  if valSettings ~= nil then
    for k, v in pairs(valSettings) do
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

function EchoExperience:ListOfExpTabs()
  local validChoices = EchoExperience:ListOfTabs(EchoExperience.savedVariables.expsettings)
  return validChoices 
end

function EchoExperience:SelectExpTab(choiceText)
  EchoExperience.view.selected.exptab = choiceText
end

function EchoExperience:DoDeleteExpTab()
  local exptab = EchoExperience.view.selected.exptab 
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
 
  --reset
  EchoExperience.view.settingstemp.windowExp = 0
  EchoExperience.view.settingstemp.tabExp    = 0
  
  EchoExperience:UpdateUIExpTabs()
end

function EchoExperience:ListOfLootTabs()
  local validChoices = EchoExperience:ListOfTabs(EchoExperience.savedVariables.lootsettings)
  return validChoices 
end

function EchoExperience:SelectLootTab(choiceText)
  EchoExperience.view.selected.loottab = choiceText
end

function EchoExperience:DoDeleteLootTab()
  local loottab = EchoExperience.view.selected.loottab 
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
  if EchoExperience.savedVariables.lootsettings == nil then
    EchoExperience.savedVariables.lootsettings = {}
  end
  
  local elem = {}
  elem["window"]    = EchoExperience.view.settingstemp.windowLoot
  elem["tab"]       = EchoExperience.view.settingstemp.tabLoot
  elem["color"]     = EchoExperience.view.settingstemp.colorLoot
  elem["itemLoot"]  = EchoExperience.view.settingstemp.showItemLoot
  elem["groupLoot"] = EchoExperience.view.settingstemp.showGroupLoot
  
  table.insert(EchoExperience.savedVariables.lootsettings, elem)
 
  --reset
  EchoExperience.view.settingstemp.windowLoot = 0
  EchoExperience.view.settingstemp.tabLoot    = 0
  EchoExperience:SetupDefaultColors()
  EchoExperience:UpdateUILootTabs()
end

function EchoExperience:ListOfGuildTabs()
  local validChoices = EchoExperience:ListOfTabs(EchoExperience.savedVariables.guildsettings)
  return validChoices 
end

function EchoExperience:SelectGuildTab(choiceText)
  EchoExperience.view.selected.guildtab = choiceText
end

function EchoExperience:DoDeleteGuildTab()
  local guildtab = EchoExperience.view.selected.guildtab 
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
  local gs = {}
  gs["guild1"]=EchoExperience.view.settingstemp.guild1
  gs["guild2"]=EchoExperience.view.settingstemp.guild2
  gs["guild3"]=EchoExperience.view.settingstemp.guild3
  gs["guild4"]=EchoExperience.view.settingstemp.guild4
  gs["guild5"]=EchoExperience.view.settingstemp.guild5
  elem["guilds"] = gs
  table.insert(EchoExperience.savedVariables.guildsettings, elem)
 
 --Reset values
  EchoExperience.view.settingstemp.guild1 = true
  EchoExperience.view.settingstemp.guild2 = true
  EchoExperience.view.settingstemp.guild3 = true
  EchoExperience.view.settingstemp.guild4 = true
  EchoExperience.view.settingstemp.guild5 = true
  
  EchoExperience:UpdateUIGuildTabs()
end

	--Setup Events Related
function EchoExperience:DoRefreshDropdowns()
	EchoExperience.SetupExpGainsEvents()
	EchoExperience.SetupLootGainsEvents()
  EchoExperience.SetupGuildEvents()
  EchoExperience.SetupMiscEvents()  
end

function EchoExperience:DoSetDefaults()
  local pName = GetUnitName("player")
  EchoExperience.accountVariables.useAsDefault = 	pName
  EchoExperience.accountVariables.defaults = {}
  EchoExperience.accountVariables.defaults.verboseExp      = EchoExperience.savedVariables.verboseExp
  EchoExperience.accountVariables.defaults.groupLoot       = EchoExperience.savedVariables.groupLoot
  EchoExperience.accountVariables.defaults.showGuildLogin  = EchoExperience.savedVariables.showGuildLogin
  EchoExperience.accountVariables.defaults.showGuildLogout = EchoExperience.savedVariables.showGuildLogout
  EchoExperience.accountVariables.defaults.showExp         = EchoExperience.savedVariables.showExp
  EchoExperience.accountVariables.defaults.showLoot        = EchoExperience.savedVariables.showLoot
  EchoExperience.accountVariables.defaults.extendedLoot    = EchoExperience.savedVariables.extendedLoot
  
  EchoExperience.accountVariables.defaults.guildsettings   = EchoExperience:deepcopy(EchoExperience.savedVariables.guildsettings)
  EchoExperience.accountVariables.defaults.lootsettings    = EchoExperience:deepcopy(EchoExperience.savedVariables.lootsettings)
  EchoExperience.accountVariables.defaults.expsettings     = EchoExperience:deepcopy(EchoExperience.savedVariables.expsettings)
end

function EchoExperience:DoLoadSetDefaults()
  if(EchoExperience.accountVariables.useAsDefault~=nil and EchoExperience.accountVariables.defaults~=nil )then
    EchoExperience.savedVariables.verboseExp      = EchoExperience.accountVariables.defaults.verboseExp
    EchoExperience.savedVariables.groupLoot       = EchoExperience.accountVariables.defaults.groupLoot       
    EchoExperience.savedVariables.showGuildLogin  = EchoExperience.accountVariables.defaults.showGuildLogin
    EchoExperience.savedVariables.showGuildLogout = EchoExperience.accountVariables.defaults.showGuildLogout
    EchoExperience.savedVariables.showExp         = EchoExperience.accountVariables.defaults.showExp
    EchoExperience.savedVariables.showLoot        = EchoExperience.accountVariables.defaults.showLoot
    EchoExperience.savedVariables.extendedLoot    = EchoExperience.accountVariables.defaults.extendedLoot
    
    EchoExperience.savedVariables.guildsettings   = EchoExperience:deepcopy(EchoExperience.accountVariables.defaults.guildsettings)
    EchoExperience.savedVariables.lootsettings    = EchoExperience:deepcopy(EchoExperience.accountVariables.defaults.lootsettings)
    EchoExperience.savedVariables.expsettings     = EchoExperience:deepcopy(EchoExperience.accountVariables.defaults.expsettings)
    
    EchoExperience:RefreshTabs()
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

-----------------------------
-- SETUP Functions here --
-----------------------------

--https://wiki.esoui.com/Events
--EVENT_CLAIM_LEVEL_UP_REWARD_RESULT
--EVENT_DISCOVERY_EXPERIENCE (
--EVENT_LEVEL_UPDATE
function EchoExperience.SetupExpGainsEvents(reportMe)
	if (EchoExperience.savedVariables.showExp) then
		if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_EXPGAINS_SHOW),msgTypeSYS) end
    --
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
		if(reportMe) then EchoExperience.outputToChanel(SI_ECHOEXP_EXPGAINS_HIDE,msgTypeSYS) end
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
		if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINS_SHOW),msgTypeSYS) end
    --extendedLoot xxxxx    
    if (EchoExperience.savedVariables.extendedLoot) then
      if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINSE_SHOW),msgTypeSYS) end
      --
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnLootFailed",	EVENT_LOOT_ITEM_FAILED, EchoExperience.OnLootFailed)
      
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnBankedCurrency",	EVENT_BANKED_CURRENCY_UPDATE, EchoExperience.OnBankedCurrency)
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnCurrencyUpdate",	EVENT_CURRENCY_UPDATE, EchoExperience.OnCurrencyUpdate)
      
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnSellReceipt",	EVENT_SELL_RECEIPT, EchoExperience.OnSellReceipt)
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnBuybackReceipt",	EVENT_BUYBACK_RECEIPT, EchoExperience.OnBuybackReceipt)
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnBuyReceipt",	EVENT_BUY_RECEIPT, EchoExperience.OnBuyReceipt)

      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnAlliancePointUpdate",	EVENT_ALLIANCE_POINT_UPDATE, EchoExperience.OnAlliancePointUpdate)
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnInventoryItemDestroyed",	EVENT_INVENTORY_ITEM_DESTROYED, EchoExperience.OnInventoryItemDestroyed)
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnInventoryItemUsed",	EVENT_INVENTORY_ITEM_USED, EchoExperience.OnInventoryItemUsed)
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnInventorySingleSlotUpdate",	EVENT_INVENTORY_SINGLE_SLOT_UPDATE, EchoExperience.OnInventorySingleSlotUpdate)
      --Extended loot
    else
      if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINSE_HIDE),msgTypeSYS) end
    end
	else
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."LootReceived",	EVENT_LOOT_RECEIVED, EchoExperience.OnLootReceived)
    
    if (not EchoExperience.savedVariables.extendedLoot) then
      if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINSE_HIDE),msgTypeSYS) end
    end
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnLootFailed",	EVENT_LOOT_ITEM_FAILED, EchoExperience.OnLootFailed)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnBankedCurrency",	EVENT_BANKED_CURRENCY_UPDATE, EchoExperience.OnBankedCurrency)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnCurrencyUpdate",	EVENT_CURRENCY_UPDATE, EchoExperience.OnCurrencyUpdate)

    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnSellReceipt",	EVENT_SELL_RECEIPT, EchoExperience.OnBankedCurrency)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnBuybackReceipt",	EVENT_BUYBACK_RECEIPT, EchoExperience.OnCurrencyUpdate)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnBuyReceipt",	EVENT_BUY_RECEIPT, EchoExperience.OnCurrencyUpdate)
  
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnAlliancePointUpdate",	EVENT_ALLIANCE_POINT_UPDATE, EchoExperience.OnBankedCurrency)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnInventoryItemDestroyed",	EVENT_INVENTORY_ITEM_DESTROYED, EchoExperience.OnCurrencyUpdate)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnInventoryItemUsed",	EVENT_INVENTORY_ITEM_USED, EchoExperience.OnCurrencyUpdate)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnInventorySingleSlotUpdate",	EVENT_INVENTORY_SINGLE_SLOT_UPDATE, EchoExperience.OnInventorySingleSlotUpdate)
      
		if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINS_HIDE),msgTypeSYS) end
	end
end

--
function EchoExperience.SetupGuildEvents()
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
  if (EchoExperience.savedVariables.showGuildMisc ) then
      EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_ADDED",	EVENT_GUILD_MEMBER_ADDED, EchoExperience.OnGuildMemberAdded)
      EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_REMOVED",	EVENT_GUILD_MEMBER_REMOVED, EchoExperience.OnGuildMemberRemoved)
  else
    EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_ADDED",	EVENT_GUILD_MEMBER_ADDED, EchoExperience.OnGuildMemberAdded)
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_REMOVED",	EVENT_GUILD_MEMBER_REMOVED, EchoExperience.OnGuildMemberRemoved)    
  end
end

function EchoExperience.SetupMiscEvents(reportMe)
  if( EchoExperience.savedVariables.showtracking ) then
    --if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_XXX_HIDE),msgTypeSYS) end
    local eventNamespace = EchoExperience.name.."EVENT_COMBAT_EVENT"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_COMBAT_EVENT, EchoExperience.OnCombatSomethingDied)
    --EVENT_MANAGER:AddFilterForEvent(eventNamespace, eventId, filterType, varying filterParameter)
    --EVENT_MANAGER:AddFilterForEvent(eventNamespace, EVENT_COMBAT_EVENT, REGISTER_FILTER_COMBAT_RESULT, ACTION_RESULT_DIED)
    --EVENT_MANAGER:AddFilterForEvent(eventNamespace, EVENT_COMBAT_EVENT, REGISTER_FILTER_IS_ERROR, false)
     --ACTION_RESULT_TARGET_DEAD 
    --EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_UNIT_DESTROYED",	EVENT_UNIT_DESTROYED, EchoExperience.OnUnitDestroyed)
  else
    --if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_XXX_HIDE),msgTypeSYS) end
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_COMBAT_EVENT",	EVENT_COMBAT_EVENT, EchoExperience.OnCombatSomethingDied)

    --EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_UNIT_DESTROYED",	EVENT_UNIT_DESTROYED, EchoExperience.OnUnitDestroyed)
  end
  --EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_UNIT_DESTROYED",	EVENT_UNIT_DESTROYED, EchoExperience.OnUnitDestroyed)

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
  EchoExperience.savedVariables.guildignore = nil
  if(upgraded) then
    EchoExperience.savedVariables.oldversion = EchoExperience.savedVariables.sversion
    EchoExperience.savedVariables.sversion   = EchoExperience.version
    EchoExperience:UpdateUIExpTabs()
    EchoExperience:UpdateUILootTabs()
    EchoExperience:UpdateUIGuildTabs()
    zo_callLater(EchoExperience.RefreshTabs, 12000)
  end
end

function EchoExperience:RefreshTabs()
  local myFpsLabelControl = WINDOW_MANAGER:GetControlByName("EchoExpDDExpOutput", "")
  if(myFpsLabelControl~=nil) then
    EchoExperience.UpdateUIExpTabs()
    EchoExperience.UpdateUILootTabs()
    EchoExperience.UpdateUIGuildTabs()
  else
    zo_callLater(EchoExperience.RefreshTabs, 12000)
  end  
end

------
---GUI

--TOOLTIP
function EchoExperience:Misc2HeaderTipEnter(sender,key)
  InitializeTooltip(EEXPTooltip, sender, TOPLEFT, 5, -56, TOPRIGHT)
  EOLTooltip:AddLine(key, "ZoFontHeader3")
end
function EchoExperience:Misc2HeaderTipExit(sender)
  --ClearTooltip(InformationTooltip)
  ClearTooltip(EEXPTooltip)
end

function EchoExperience:SetGuiFilter(self, button, filterType, subFilter)
  EchoExperience.view.filterType = filterType
  --if(filterType=="All")then
  --end
  EchoExperience:UpdateScrollDataLinesData()
  EchoExperience:GuiResizeScroll()
  EchoExperience:RefreshInventoryScroll()
end

function EchoExperience:CloseUI()
  EOL_GUI:SetHidden( not EOL_GUI:IsHidden() )
end

function EchoExperience:onResizeStart()
	EVENT_MANAGER:RegisterForUpdate(EchoExperience.name.."OnWindowResize", 50, 
    function()
      EchoExperience:UpdateScrollDataLinesData()
      EchoExperience:GuiResizeScroll()
      EchoExperience:UpdateInventoryScroll()
    end)
end

function EchoExperience:SaveFrameInfo(calledFrom)
	if (calledFrom == "onHide") then return end
  if(EchoExperience.savedVariables.frame2==null)then
    EchoExperience.savedVariables.frame2 = {}
  end
	--local sceneName = EchoExperience:GetCurrentSceneName()
	--if not QUICKSLOT_FRAGMENT:IsHidden() then
	--	sceneName = sceneName .. "_quickslots"
	--end

	--local settings = IIfA:GetSceneSettings(sceneName)
	--settings.hidden = IIFA_GUI:IsControlHidden()

	--if (not settings.docked and (calledFrom == "onMoveStop" or calledFrom == "onResizeStop")) then
		EchoExperience.savedVariables.frame2.lastX	= EOL_GUI:GetLeft()
		EchoExperience.savedVariables.frame2.lastY	= EOL_GUI:GetTop()
		--if not settings.minimized then
			EchoExperience.savedVariables.frame2.width	= EOL_GUI:GetWidth()
			EchoExperience.savedVariables.frame2.height	= EOL_GUI:GetHeight()
		--end
	--end
end

function EchoExperience:SaveFramePosition(calledFrom)
  if(EchoExperience.savedVariables.frame2==null)then
    EchoExperience.savedVariables.frame2 = {}
  end
  EchoExperience.savedVariables.frame2.lastX	= EOL_GUI:GetLeft()
  EchoExperience.savedVariables.frame2.lastY	= EOL_GUI:GetTop()
end

function EchoExperience:onResizeStop()
	EVENT_MANAGER:UnregisterForUpdate(EchoExperience.name.."OnWindowResize")
	EchoExperience:SaveFrameInfo("onResizeStop")
	EchoExperience:GuiResizeScroll()	
  EchoExperience:UpdateInventoryScroll()
end

function EchoExperience:UpdateInventoryScroll()
	local index = 0
	if EOL_GUI_ListHolder.dataOffset < 0 then EOL_GUI_ListHolder.dataOffset = 0 end
	if EOL_GUI_ListHolder.maxLines == nil then
		EOL_GUI_ListHolder.maxLines = EchoExperience.defaultMaxLines
	end
  --d("UpdateInventoryScroll: offset="..EOL_GUI_ListHolder.dataOffset.." maxLines="..EOL_GUI_ListHolder.maxLines )  
	EchoExperience:SetDataLinesData()

	local total = #EOL_GUI_ListHolder.dataLines - EOL_GUI_ListHolder.maxLines
	EOL_GUI_ListHolder_Slider:SetMinMax(0, total)
end

--??
function EchoExperience:SetDataLinesData()
	local curLine, curData
	for i = 1, EOL_GUI_ListHolder.maxLines do
		curLine = EOL_GUI_ListHolder.lines[i]
		curData = EOL_GUI_ListHolder.dataLines[EOL_GUI_ListHolder.dataOffset + i]
		EOL_GUI_ListHolder.lines[i] = curLine

		if( curData ~= nil) then
			EchoExperience:fillLine(curLine, curData)
		else
			EchoExperience:fillLine(curLine, nil)
		end
	end
end

function EchoExperience:fillLine(curLine, curItem)
  if(curLine==nil) then return end--??????? TODO
	local color
	if curItem == nil then
		curLine.itemLink = ""
		curLine.icon:SetTexture(nil)
		curLine.icon:SetAlpha(0)
		curLine.text:SetText("")
		curLine.qty:SetText("")
		--curLine.worn:SetHidden(true)
		--curLine.stolen:SetHidden(true)
		--Hide the FCOIS marker icons at the line (do not create them if not needed) -> File plugins/FCOIS/IIfA_FCOIS.lua
	--	if IIfA.UpdateFCOISMarkerIcons ~= nil then
	--		IIfA:UpdateFCOISMarkerIcons(curLine, false, false, -1)
	--	end
	else
		local r, g, b, a = 255, 255, 255, 1
		--if (curItem.quality) then
		--	color = GetItemQualityColor(curItem.quality)
		--	r, g, b, a = color:UnpackRGBA()
		--end
		curLine.itemLink = curItem.link
    --d("curLine.icon = " ..tostring(curLine.icon))
    --if(curLine.icon:SetTexture(_
		curLine.icon:SetTexture(curItem.icon)
    --curLine.icon = curItem.icon
    curLine.icon:SetAlpha(1)
		local text = zo_strformat(SI_TOOLTIP_ITEM_NAME, curItem.name)
		curLine.text:SetText(text)
		curLine.text:SetColor(r, g, b, a)
		curLine.qty:SetText(curItem.qty)
		--curLine.worn:SetHidden(not curItem.worn)
		--curLine.stolen:SetHidden(not IsItemLinkStolen(curItem.link))
		--Show the FCOIS marker icons at the line, if enabled in the settings (create them if needed)  -> File plugins/FCOIS/IIfA_FCOIS.lua
		--if IIfA.UpdateFCOISMarkerIcons ~= nil then
		--	local showFCOISMarkerIcons = IIfA:GetSettings().FCOISshowMarkerIcons
		--	IIfA:UpdateFCOISMarkerIcons(curLine, showFCOISMarkerIcons, false, -1)
		--end
	end
end


function EchoExperience:RefreshInventoryScroll()
	EchoExperience:UpdateScrollDataLinesData()
	EchoExperience:UpdateInventoryScroll()
end

function EchoExperience:UpdateScrollDataLinesData()
  --
  --TODO mode, tracking vs lifetime
  local tempDataLine = nil
	local dataLines = {}
  local itemCount = 0
	local totItems = 0
  
  local elemListP = nil
  local elemListS = nil
  if(EchoExperience.view.trackingSelection=="Lifetime") then
    elemListP = EchoExperience.savedVariables.lifetime
  else
    elemListP = EchoExperience.savedVariables.tracking
  end
  if(EchoExperience.view.filterType=="Items")then
    elemListS = elemListP.items
  elseif(EchoExperience.view.filterType=="Mobs")then
    elemListS = elemListP.mobs
  elseif(EchoExperience.view.filterType=="Currency")then
    elemListS = elemListP.currency
  elseif(EchoExperience.view.filterType=="BG")then
    elemListS = elemListP.bg
  else
    elemListS = nil
  end
  
  if(elemListS~=nil) then
    for itemKey, dbItem in pairs(elemListS) do
      --k, v.quantity, v.itemlink
      local iName = itemKey
      if(EchoExperience.view.filterType=="Currency") then
        iName = GetCurrencyName(itemKey, true, false)
      end
      tempDataLine = {
        link = dbItem.itemLink,
        qty  = dbItem.quantity,
        icon = GetItemLinkIcon(dbItem.itemLink),
        name = iName,
        --quality = dbItem.itemQuality,
        --filter = itemTypeFilter,
        --worn = bWorn
      }
      d("iName="..iName.." icon: " .. GetItemLinkIcon(dbItem.itemLink) )
      table.insert(dataLines, tempDataLine)
      totItems = totItems + (itemCount or 0)
    end 
  elseif(elemListP~=nil) then
    for itemKey, dbItem in pairs(elemListP.currency) do
      --k, v.quantity, v.itemlink
      tempDataLine = {
        link = dbItem.itemLink,
        qty  = dbItem.quantity,
        icon = GetItemLinkIcon(dbItem.itemLink),
        name = GetCurrencyName(itemKey, true, false),
        --quality = dbItem.itemQuality,
        --filter = itemTypeFilter,
        --worn = bWorn
      }
      if(dbItem.itemLink~=nil)then
        d("iName="..iName.." icon: " .. GetItemLinkIcon(dbItem.itemLink) )
      end
      table.insert(dataLines, tempDataLine)
      totItems = totItems + (itemCount or 0)
    end 
    for itemKey, dbItem in pairs(elemListP.items) do
      --k, v.quantity, v.itemlink
      tempDataLine = {
        link = dbItem.itemLink,
        qty  = dbItem.quantity,
        icon = GetItemLinkIcon(dbItem.itemLink),
        name = itemKey,
        --quality = dbItem.itemQuality,
        --filter = itemTypeFilter,
        --worn = bWorn
      }
      if(dbItem.itemLink~=nil)then
        d("iName="..iName.." icon: " .. GetItemLinkIcon(dbItem.itemLink) )
      end
      table.insert(dataLines, tempDataLine)
      totItems = totItems + (itemCount or 0)
    end 
    for itemKey, dbItem in pairs(elemListP.mobs) do
      --k, v.quantity, v.itemlink
      tempDataLine = {
        link = dbItem.itemLink,
        qty  = dbItem.quantity,
        icon = GetItemLinkIcon(dbItem.itemLink),
        name = itemKey,
        --quality = dbItem.itemQuality,
        --filter = itemTypeFilter,
        --worn = bWorn
      }
      if(dbItem.itemLink~=nil)then
        d("iName="..iName.." icon: " .. GetItemLinkIcon(dbItem.itemLink) )
      end
      table.insert(dataLines, tempDataLine)
      totItems = totItems + (itemCount or 0)
    end 
  end
  
  
  if(EchoExperience.view.trackingSelection=="Lifetime2") then
    for itemKey, dbItem in pairs(EchoExperience.savedVariables.lifetime.items) do
      --k, v.quantity, v.itemlink
      tempDataLine = {
        link = dbItem.itemLink,
        qty  = dbItem.quantity,
        icon = GetItemLinkIcon(dbItem.itemLink),
        name = itemKey,
        --quality = dbItem.itemQuality,
        --filter = itemTypeFilter,
        --worn = bWorn
      }
      d("iName="..iName.." icon: " .. GetItemLinkIcon(dbItem.itemLink) )
      table.insert(dataLines, tempDataLine)
      totItems = totItems + (itemCount or 0)
    end
  elseif(EchoExperience.view.trackingSelection=="Session2") then
    for itemKey, dbItem in pairs(EchoExperience.savedVariables.tracking.items) do
      --k, v.quantity, v.itemlink
      tempDataLine = {
        link = dbItem.itemLink,
        qty  = dbItem.quantity,
        icon = GetItemLinkIcon(dbItem.itemLink),
        name = itemKey,
        --quality = dbItem.itemQuality,
        --filter = itemTypeFilter,
        --worn = bWorn
      }
      d("iName="..iName.." icon: " .. GetItemLinkIcon(dbItem.itemLink) )
      table.insert(dataLines, tempDataLine)
      totItems = totItems + (itemCount or 0)
    end 
  end
  
	EOL_GUI_ListHolder.dataLines = dataLines
	EchoExperience:sort(EOL_GUI_ListHolder.dataLines)
	EOL_GUI_ListHolder.dataOffset = 0

	--EOL_GUI_ListHolder_Counts_Items:SetText("Item Count: " .. totItems)
	--EOL_GUI_ListHolder_Counts_Slots:SetText("Appx. Slots Used: " .. #dataLines)
end

function EchoExperience:sort(dataLines)
	if dataLines == nil then dataLines = EOL_GUI_ListHolder.dataLines end

	--if (ScrollSortUp) then
  --TODO dataLines = table.sort(dataLines, IIfA_FilterCompareUp)
  --dataLines = table.sort(dataLines, IIfA_FilterCompareDown)
	--end
end

-- returns true if it had to be resized, otherwise false
function EchoExperience:GuiResizeScroll()
	local regionHeight = EOL_GUI_ListHolder:GetHeight()
  local rowHeight    = EOL_GUI_ListHolder.rowHeight
	local newLines = math.floor(regionHeight / rowHeight)
	if EOL_GUI_ListHolder.maxLines == nil or EOL_GUI_ListHolder.maxLines ~= newLines then
		EOL_GUI_ListHolder.maxLines = newLines
		EchoExperience:GuiResizeLines()
	end
end

function EchoExperience:GuiResizeLines()
	local lines

	if not EOL_GUI_ListHolder.lines then
		lines = EchoExperience:CreateInventoryScroll()
	end
	if EOL_GUI_ListHolder.lines ~= {} then
		lines = EOL_GUI_ListHolder.lines
	end

	for index, line in ipairs(lines) do
--		line.text:SetWidth(textwidth)
--		line:SetWidth(linewidth)
		line:SetHidden(index > EOL_GUI_ListHolder.maxLines)
	end
end

function EchoExperience:CreateInventoryScroll()
	EOL_GUI_ListHolder.dataOffset = 0

	EOL_GUI_ListHolder.dataLines = {}
	EOL_GUI_ListHolder.lines = {}
	EOL_GUI_Header_SortBar.Icon = EOL_GUI_Header_SortBar:GetNamedChild("_Sort"):GetNamedChild("_Icon")

	local text = "       No Collected Data"
	-- we set those to 35 because that's the amount of lines we can show within the dimension constraints
	EOL_GUI_ListHolder.maxLines = EchoExperience.defaultMaxLines
	local predecessor = nil
	for i=1, EOL_GUI_ListHolder.maxLines do
		EOL_GUI_ListHolder.lines[i] = EchoExperience:CreateLine(i, predecessor, EOL_GUI_ListHolder)
		predecessor = EOL_GUI_ListHolder.lines[i]
	end

  --
	EchoExperience:SetItemCountPosition()
	-- setup slider
	EOL_GUI_ListHolder_Slider:SetMinMax(0, #EOL_GUI_ListHolder.dataLines - EOL_GUI_ListHolder.maxLines)
  --
	return EOL_GUI_ListHolder.lines
end

function EchoExperience:CreateLine(i, predecessor, parent)
	local line = WINDOW_MANAGER:CreateControlFromVirtual("EOL_ListItem_".. i, parent, "EOL_SlotTemplate")

	line.icon = line:GetNamedChild("Button"):GetNamedChild("Icon")
	line.text = line:GetNamedChild("Name")
	line.qty  = line:GetNamedChild("Qty")
	--line.worn = line:GetNamedChild("IconWorn")
	--line.stolen = line:GetNamedChild("IconStolen")

	line:SetHidden(false)
	line:SetMouseEnabled(true)
	line:SetHeight(EOL_GUI_ListHolder.rowHeight)

	if i == 1 then
		line:SetAnchor(TOPLEFT, EOL_GUI_ListHolder, TOPLEFT, 0, 0)
		line:SetAnchor(TOPRIGHT, EOL_GUI_ListHolder, TOPRIGHT, 0, 0)
	else
		line:SetAnchor(TOPLEFT, predecessor, BOTTOMLEFT, 0, 0)
		line:SetAnchor(TOPRIGHT, predecessor, BOTTOMRIGHT, 0, 0)
	end

	--line:SetHandler("OnMouseEnter", function(self) IIfA:GuiLineOnMouseEnter(self) end )
	--line:SetHandler("OnMouseExit", function(self) IIfA:GuiLineOnMouseExit(self) end )
	--line:SetHandler("OnMouseDoubleClick", function(...) IIfA:GUIDoubleClick(...) end )

	return line
end

function EchoExperience:SetItemCountPosition()
	for i=1, EOL_GUI_ListHolder.maxLines do
		local line = EOL_GUI_ListHolder.lines[i]
		line.text:ClearAnchors()
		line.qty:ClearAnchors()
		--if EchoExperience:GetSettings().showItemCountOnRight then
			line.qty:SetAnchor(TOPRIGHT, line, TOPRIGHT, 0, 0)
			line.text:SetAnchor(TOPLEFT, line:GetNamedChild("Button"), TOPRIGHT, 18, 0)
			line.text:SetAnchor(TOPRIGHT, line.qty, TOPLEFT, -10, 0)
		--[[else
			line.qty:SetAnchor(TOPLEFT, line:GetNamedChild("Button"), TOPRIGHT, 8, -3)
			line.text:SetAnchor(TOPLEFT, line.qty, TOPRIGHT, 18, 0)
			line.text:SetAnchor(TOPRIGHT, line, TOPLEFT, 0, 0)
		end--]]
	end
end

---GUI
------


--EchoExperience.savedVariables.lifetime.currency,EchoExperience.savedVariables.tracking.currency)
function EchoExperience:MoveToLifetime(mode)
  EchoExperience.debugMsg("MoveToLifetime: Called mode="..tostring(mode) )
  local session = nil
  local lifetime = nil
  if(mode==1) then    
    for k, v in pairs(EchoExperience.savedVariables.tracking.items) do
      if(EchoExperience.savedVariables.lifetime.items[k]~=nil)then
        EchoExperience.savedVariables.lifetime.items[k].quantity = EchoExperience.savedVariables.lifetime.items[k].quantity + v.quantity
      else
        EchoExperience.savedVariables.lifetime.items[k] = v
      end
    end
    EchoExperience.savedVariables.tracking.items = {}
  elseif(mode==2) then
    for k, v in pairs(EchoExperience.savedVariables.tracking.currency) do
      local elemL = EchoExperience.savedVariables.lifetime.currency[k]
      if(elemL~=nil)then
        EchoExperience.savedVariables.lifetime.currency[k].quantity = EchoExperience.savedVariables.lifetime.currency[k].quantity + v.quantity
      else
        EchoExperience.savedVariables.lifetime.currency[k] = v
      end
    end
    EchoExperience.savedVariables.tracking.currency = {}
  elseif(mode==3) then
    for k, v in pairs(EchoExperience.savedVariables.tracking.mobs) do
      local elemL = EchoExperience.savedVariables.lifetime.mobs[k]
      if(elemL~=nil)then
        EchoExperience.savedVariables.lifetime.mobs[k].quantity = EchoExperience.savedVariables.lifetime.mobs[k].quantity + v.quantity
      else
        EchoExperience.savedVariables.lifetime.mobs[k] = v
      end
    end
    EchoExperience.savedVariables.tracking.mobs = {}
  elseif(mode==4) then
    for k, v in pairs(EchoExperience.savedVariables.tracking.bg) do
      local elemL = EchoExperience.savedVariables.lifetime.bg[k]
      if(elemL~=nil)then
        EchoExperience.savedVariables.lifetime.bg[k].quantity = EchoExperience.savedVariables.lifetime.bg[k].quantity + v.quantity
      else
        EchoExperience.savedVariables.lifetime.bg[k] = v
      end
    end
    EchoExperience.savedVariables.tracking.bg = {}
  else
    --
  end
end

function EchoExperience.InitializeGui()
  EOL_GUI_ListHolder.rowHeight = 24
	EOL_GUI_ListHolder:SetDrawLayer(0)
end

function EchoExperience.SetupDefaultColors()
  EchoExperience.view.settingstemp = {}
  EchoExperience.view.settingstemp.colorExp = {}
  EchoExperience.view.settingstemp.colorExp.r = EchoExperience.rgbaBase.r
  EchoExperience.view.settingstemp.colorExp.g = EchoExperience.rgbaBase.g
  EchoExperience.view.settingstemp.colorExp.b = EchoExperience.rgbaBase.b
  EchoExperience.view.settingstemp.colorExp.a = EchoExperience.rgbaBase.a  
  EchoExperience.view.settingstemp.colorLoot = {}
  EchoExperience.view.settingstemp.colorLoot.r = EchoExperience.rgbaBase.r
  EchoExperience.view.settingstemp.colorLoot.g = EchoExperience.rgbaBase.g
  EchoExperience.view.settingstemp.colorLoot.b = EchoExperience.rgbaBase.b
  EchoExperience.view.settingstemp.colorLoot.a = EchoExperience.rgbaBase.a
  EchoExperience.view.settingstemp.colorGuild = {}
  EchoExperience.view.settingstemp.colorGuild.r = EchoExperience.rgbaBase.r
  EchoExperience.view.settingstemp.colorGuild.g = EchoExperience.rgbaBase.g
  EchoExperience.view.settingstemp.colorGuild.b = EchoExperience.rgbaBase.b
  EchoExperience.view.settingstemp.colorGuild.a = EchoExperience.rgbaBase.a
end

-- SETUP  setup event handling
function EchoExperience.DelayedStart()
  --d("EchoExp DelayedStart Called")
  
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
  
  EchoExperience.view.settingstemp.guild1 = true
  EchoExperience.view.settingstemp.guild2 = true
  EchoExperience.view.settingstemp.guild3 = true
  EchoExperience.view.settingstemp.guild4 = true
  EchoExperience.view.settingstemp.guild5 = true
  
  EchoExperience.view.selected = {}
  EchoExperience.view.selected.guildtab = nil
  EchoExperience.view.selected.loottab = nil
  EchoExperience.view.selected.exptab = nil
  
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
  
  if(EchoExperience.accountVariables.defaults==nil)then
    EchoExperience.accountVariables.defaults = {}
  end
  -- Clear for session?
  -- Save Tracking data to Lifetime 
  --if(EchoExperience.savedVariables.showtracking session vs all?
  if(EchoExperience.savedVariables.lifetime==nil)then
    EchoExperience.savedVariables.lifetime = {}
    if(EchoExperience.savedVariables.lifetime.items==nil)then
      EchoExperience.savedVariables.lifetime.items = {}
    end
    if(EchoExperience.savedVariables.lifetime.currency==nil)then
      EchoExperience.savedVariables.lifetime.currency = {}
    end
    if(EchoExperience.savedVariables.lifetime.mobs==nil)then
      EchoExperience.savedVariables.lifetime.mobs = {}
    end
    if(EchoExperience.savedVariables.lifetime.bg==nil)then
      EchoExperience.savedVariables.lifetime.bg = {}
    end
  end
  
  if(EchoExperience.savedVariables.tracking==nil)then
    EchoExperience.savedVariables.tracking = {}
  end    
  if(EchoExperience.savedVariables.tracking.items==nil)then
    EchoExperience.savedVariables.tracking.items = {}
  else
    EchoExperience:MoveToLifetime( 1 )
  end
  if(EchoExperience.savedVariables.tracking.currency==nil)then
    EchoExperience.savedVariables.tracking.currency = {}
  else
    EchoExperience:MoveToLifetime( 2 )
  end
  if(EchoExperience.savedVariables.tracking.mobs==nil)then
    EchoExperience.savedVariables.tracking.mobs = {}
else    
    EchoExperience:MoveToLifetime( 3 )
  end
  if(EchoExperience.savedVariables.tracking.bg==nil)then
    EchoExperience.savedVariables.tracking.bg = {}
else
    EchoExperience:MoveToLifetime( 4 )
  end
  if(EchoExperience.savedVariables.showtracking==nil)then
    EchoExperience.savedVariables.showtracking = false
  end
  
  EchoExperience:UpgradeSettings()
  
	--Setup Events Related
	EchoExperience.SetupExpGainsEvents()
	EchoExperience.SetupLootGainsEvents()
  EchoExperience.SetupGuildEvents()
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
    EchoExperience.SetupDefaultColors()
    EchoExperience.InitializeGui()
    zo_callLater(EchoExperience.DelayedStart, 3000)
end

-- SETUP
function EchoExperience.OnAddOnLoaded(event, addonName)
    if addonName ~= EchoExperience.name then return end
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name, EVENT_ADD_ON_LOADED)

    EchoExperience.savedVariables   = ZO_SavedVars:New("EchoExperienceSavedVariables", 1, nil, defaultSettings)
    EchoExperience.accountVariables = ZO_SavedVars:NewAccountWide("EchoExperienceAccountSavedVariables", 1, nil, nil)

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
