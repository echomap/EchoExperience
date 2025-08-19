---------------------------------
--[[ EchoExp : Settings      ]]-- 
---------------------------------

----------------------------------------
-- Functions to Show/Configure Settings data --
----------------------------------------

------------------------------
-- ProfileSettings, from settings
function EchoExperience:DoSaveProfileSettings()
  local pName = GetUnitName("player")
  EchoExperience.accountVariables.useAsDefault = 	pName
  EchoExperience.accountVariables.defaults = {}
  --
  EchoExperience.accountVariables.defaults.immersive        = EchoExperience.savedVariables.immersive
  EchoExperience.accountVariables.defaults.showmdk          = EchoExperience.savedVariables.showmdk
  EchoExperience.accountVariables.defaults.showdiscovery    = EchoExperience.savedVariables.showdiscovery
  EchoExperience.accountVariables.defaults.sessiontracking  = EchoExperience.savedVariables.sessiontracking
  EchoExperience.accountVariables.defaults.lifetimetracking = EchoExperience.savedVariables.lifetimetracking
  EchoExperience.accountVariables.defaults.showcompanions   = EchoExperience.savedVariables.showcompanions

  --
  EchoExperience.accountVariables.defaults.groupLoot       = EchoExperience.savedVariables.groupLoot
  EchoExperience.accountVariables.defaults.showGuildLogin  = EchoExperience.savedVariables.showGuildLogin
  EchoExperience.accountVariables.defaults.showGuildLogout = EchoExperience.savedVariables.showGuildLogout
  EchoExperience.accountVariables.defaults.showGuildJoinLeave = EchoExperience.savedVariables.showGuildJoinLeave
  EchoExperience.accountVariables.defaults.showExp         = EchoExperience.savedVariables.showExp
  EchoExperience.accountVariables.defaults.showExpT1       = EchoExperience.savedVariables.showExpT1
  EchoExperience.accountVariables.defaults.showExpT2       = EchoExperience.savedVariables.showExpT2
  EchoExperience.accountVariables.defaults.verboseExp      = EchoExperience.savedVariables.verboseExp
  EchoExperience.accountVariables.defaults.useaccountnamepref      = EchoExperience.savedVariables.useaccountnamepref
  
  --
  EchoExperience.accountVariables.defaults.showSkillExp    = EchoExperience.savedVariables.showSkillExp
  EchoExperience.accountVariables.defaults.showAllSkillExp = EchoExperience.savedVariables.showAllSkillExp
  --
  EchoExperience.accountVariables.defaults.showLoot           = EchoExperience.savedVariables.showLoot
  EchoExperience.accountVariables.defaults.extendedLoot       = EchoExperience.savedVariables.extendedLoot
  EchoExperience.accountVariables.defaults.showquests         = EchoExperience.savedVariables.showquests
  EchoExperience.accountVariables.defaults.showquestsadvanced = EchoExperience.savedVariables.showquestsadvanced
  
  EchoExperience.accountVariables.defaults.showachievements       = EchoExperience.savedVariables.showachievements
  EchoExperience.accountVariables.defaults.showachievementdetails = EchoExperience.savedVariables.showachievementdetails
  EchoExperience.accountVariables.defaults.lorebooktracking       = EchoExperience.savedVariables.lorebooktracking
  EchoExperience.accountVariables.defaults.endeavortracking       = EchoExperience.savedVariables.endeavortracking
  
  --
  --Copy table Settings
  EchoExperience.accountVariables.defaults.guildsettings   = EchoExperience:deepcopy(EchoExperience.savedVariables.guildsettings)
  EchoExperience.accountVariables.defaults.lootsettings    = EchoExperience:deepcopy(EchoExperience.savedVariables.lootsettings)
  EchoExperience.accountVariables.defaults.expsettings     = EchoExperience:deepcopy(EchoExperience.savedVariables.expsettings)
  EchoExperience.accountVariables.defaults.questsettings   = EchoExperience:deepcopy(EchoExperience.savedVariables.questsettings)
end

------------------------------
-- ProfileSettings, from settings
function EchoExperience:DoLoadProfileSettings()
  if(EchoExperience.accountVariables.useAsDefault~=nil and EchoExperience.accountVariables.defaults~=nil )then
    --
    EchoExperience.savedVariables.immersive        = EchoExperience.accountVariables.defaults.immersive
    EchoExperience.savedVariables.showmdk          = EchoExperience.accountVariables.defaults.showmdk
    EchoExperience.savedVariables.showdiscovery    = EchoExperience.accountVariables.defaults.showdiscovery
    EchoExperience.savedVariables.sessiontracking  = EchoExperience.accountVariables.defaults.sessiontracking
    EchoExperience.savedVariables.lifetimetracking = EchoExperience.accountVariables.defaults.lifetimetracking
    EchoExperience.savedVariables.showcompanions   = EchoExperience.accountVariables.defaults.showcompanions
    --
    EchoExperience.savedVariables.verboseExp      = EchoExperience.accountVariables.defaults.verboseExp
    EchoExperience.savedVariables.showAllSkillExp = EchoExperience.accountVariables.defaults.showAllSkillExp	
    EchoExperience.savedVariables.showSkillExp    = EchoExperience.accountVariables.defaults.showSkillExp	
    --
    EchoExperience.savedVariables.groupLoot       = EchoExperience.accountVariables.defaults.groupLoot       
    EchoExperience.savedVariables.showGuildLogin  = EchoExperience.accountVariables.defaults.showGuildLogin
    EchoExperience.savedVariables.showGuildLogout = EchoExperience.accountVariables.defaults.showGuildLogout
	EchoExperience.savedVariables.showGuildJoinLeave = EchoExperience.accountVariables.defaults.showGuildJoinLeave
    EchoExperience.savedVariables.showExp         = EchoExperience.accountVariables.defaults.showExp
    EchoExperience.savedVariables.showExpT1       = EchoExperience.accountVariables.defaults.showExpT1
    EchoExperience.savedVariables.showExpT2       = EchoExperience.accountVariables.defaults.showExpT2
    EchoExperience.savedVariables.showLoot        = EchoExperience.accountVariables.defaults.showLoot
    EchoExperience.savedVariables.extendedLoot    = EchoExperience.accountVariables.defaults.extendedLoot
    EchoExperience.savedVariables.showquests      = EchoExperience.accountVariables.defaults.showquests
    EchoExperience.savedVariables.showquestsadvanced = EchoExperience.accountVariables.defaults.showquestsadvanced
    
    EchoExperience.savedVariables.showachievements       = EchoExperience.accountVariables.defaults.showachievements
    EchoExperience.savedVariables.showachievementdetails = EchoExperience.accountVariables.defaults.showachievementdetails
    EchoExperience.savedVariables.lorebooktracking       = EchoExperience.accountVariables.defaults.lorebooktracking
	EchoExperience.savedVariables.endeavortracking       = EchoExperience.accountVariables.defaults.endeavortracking
	EchoExperience.savedVariables.useaccountnamepref	 = EchoExperience.accountVariables.defaults.useaccountnamepref
    --
    --Copy table Settings
    EchoExperience.savedVariables.guildsettings   = EchoExperience:deepcopy(EchoExperience.accountVariables.defaults.guildsettings)
    EchoExperience.savedVariables.lootsettings    = EchoExperience:deepcopy(EchoExperience.accountVariables.defaults.lootsettings)
    EchoExperience.savedVariables.expsettings     = EchoExperience:deepcopy(EchoExperience.accountVariables.defaults.expsettings)
    EchoExperience.savedVariables.questsettings   = EchoExperience:deepcopy(EchoExperience.accountVariables.defaults.questsettings)
    
    EchoExperience:RefreshTabs()
  end
end

 
-----------------------------
-- SELECT/TABS/WINDOWS/COLORS Functions here --
-----------------------------

------------------------------
--Todo generalized and use this
function EchoExperience:ListOfTabs(valSettings)
	local validChoices =  {}  
	table.insert(validChoices, "Select")
	if valSettings ~= nil then
		for k, v in pairs(valSettings) do
			if( v.color==nil) then
				v.color = EchoExperience.staticdata.rgbaBase
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

------------------------------
--
function EchoExperience:SelectExpTab(choiceText)
  EchoExperience.view.selected.exptab = choiceText
end

------------------------------
--
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

------------------------------
--
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

------------------------------
--
function EchoExperience:ListOfLootTabs()
  local validChoices = EchoExperience:ListOfTabs(EchoExperience.savedVariables.lootsettings)
  return validChoices 
end

------------------------------
--TODO: Colors causing troubles with translating to ID
function EchoExperience:ListOfItemQualitySettings()
  local validChoices =  {}
  --local c = ZO_ColorDef:New(0, 1, v.color.b, v.color.a)
  --local red   = ZO_ColorDef:New(1, 0, 0, 1)
  --local green = ZO_ColorDef:New(0, 1, 0, 1)
  --local blue  = ZO_ColorDef:New(0, 1, 1, 1)
  table.insert(validChoices, "Trash")
  table.insert(validChoices, "Normal")
  table.insert(validChoices, "Magic" )
  table.insert(validChoices, "Legendary" )
  --table.insert(validChoices, green:Colorize("Magic") )
  --table.insert(validChoices, blue:Colorize("Legendary") )
  table.insert(validChoices, "Artifact")
  table.insert(validChoices, "Arcane")
  return validChoices 
end

------------------------------
--
function EchoExperience:ListOfItemQualitySettingsXalte(qualitynameIn)
  local qualityname = tostring(qualitynameIn)
  EchoExperience.debugMsg2("ListOfItemQualitySettingsXalte: "
    , "qualityname=" , qualityname
  )  
  if(qualityname==nil) then 
    return ITEM_QUALITY_TRASH 
  elseif(qualityname=="Trash") then 
    return ITEM_QUALITY_TRASH
  elseif(qualityname=="Normal") then 
    return ITEM_QUALITY_NORMAL
  elseif(qualityname=="Magic") then 
    return ITEM_QUALITY_MAGIC
  elseif(qualityname=="Legendary") then 
    return ITEM_QUALITY_LEGENDARY
  elseif(qualityname=="Artifact") then 
    return ITEM_QUALITY_ARTIFACT
  elseif(qualityname=="Arcane") then 
    return ITEM_QUALITY_ARCANE
  end
end

------------------------------
--
function EchoExperience:SelectLootTab(choiceText)
  EchoExperience.view.selected.loottab = choiceText
end

------------------------------
--
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

------------------------------
--
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

------------------------------
--
function EchoExperience:ListOfGuildTabs()
  local validChoices = EchoExperience:ListOfTabs(EchoExperience.savedVariables.guildsettings)
  return validChoices 
end

------------------------------
--
function EchoExperience:SelectGuildTab(choiceText)
  EchoExperience.view.selected.guildtab = choiceText
end

------------------------------
--
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

------------------------------
--
function EchoExperience:DoSaveGuildTab()
  local window = EchoExperience.view.settingstemp.windowGuild
  local tab    = EchoExperience.view.settingstemp.tabGuild
  local color  = EchoExperience.view.settingstemp.colorGuild
  --
  if EchoExperience.savedVariables.guildsettings == nil then
    EchoExperience.savedVariables.guildsettings = {}
  end
  --
  local elem = {}
  elem["window"]=window
  elem["tab"]=tab
  elem["color"]=color
  local gs = {}
  if(EchoExperience.view.settingstemp.guild1) then
    gs[EchoExperience:GetGuildId(1)] = true
  else
	gs[EchoExperience:GetGuildId(1)] = false
  end
  if(EchoExperience.view.settingstemp.guild2) then
    gs[EchoExperience:GetGuildId(2)] = true
  else
	gs[EchoExperience:GetGuildId(2)] = false
  end
  if(EchoExperience.view.settingstemp.guild3) then
    gs[EchoExperience:GetGuildId(3)] = true
  else
	gs[EchoExperience:GetGuildId(3)] = false
  end
  if(EchoExperience.view.settingstemp.guild4) then
    gs[EchoExperience:GetGuildId(4)] = true
  else
	gs[EchoExperience:GetGuildId(4)] = false
  end
  if(EchoExperience.view.settingstemp.guild5) then
    gs[EchoExperience:GetGuildId(5)] = true
  else
	gs[EchoExperience:GetGuildId(5)] = false
  end
  --[[
  gs["guild1"]=EchoExperience.view.settingstemp.guild1
  gs["guild2"]=EchoExperience.view.settingstemp.guild2
  gs["guild3"]=EchoExperience.view.settingstemp.guild3
  gs["guild4"]=EchoExperience.view.settingstemp.guild4
  gs["guild5"]=EchoExperience.view.settingstemp.guild5
  --]]
  elem["guilds"] = gs
  table.insert(EchoExperience.savedVariables.guildsettings, elem)
 
 --Reset values
  EchoExperience.view.settingstemp.guild1 = true
  EchoExperience.view.settingstemp.guild2 = true
  EchoExperience.view.settingstemp.guild3 = true
  EchoExperience.view.settingstemp.guild4 = true
  EchoExperience.view.settingstemp.guild5 = true
  
	--[[
	for index, data in ipairs(EchoExperience.savedVariables.guildsettings) do
		print(index)
		for key, value in pairs(data) do
			print('\t', key, value)
		end
	end
	--]]
  EchoExperience:UpdateUIGuildTabs()
end

------------------------------
--QUEST
function EchoExperience:ListOfQuestTabs()
  local validChoices = EchoExperience:ListOfTabs(EchoExperience.savedVariables.questsettings)
  return validChoices 
end

------------------------------
--
function EchoExperience:SelectQuestTab(choiceText)
  EchoExperience.view.selected.questtab = choiceText
end

------------------------------
-- Uses "EchoExperience.view.selected.questtab" to know which to delete
function EchoExperience:DoDeleteQuestTab()
  local exptab = EchoExperience.view.selected.questtab
  if(exptab~=nil)then
    --d(EchoExperience.name .. " exptab=" .. exptab) 
    for k,v in pairs(EchoExperience.savedVariables.questsettings) do
      local vCD   = ZO_ColorDef:New(v.color.r, v.color.g, v.color.b, v.color.a)
      local vtext = vCD:Colorize("COLOR")
      local valV  = zo_strformat( "<<1>>/<<2>>/<<3>>", v.window,v.tab, vtext )
      --d(EchoExperience.name .. " valV=" .. valV) 
      if( exptab==valV ) then
        EchoExperience.savedVariables.questsettings[k] = nil
        break
      end
    end
  end
  EchoExperience:UpdateUIQuestTabs()
end

------------------------------
-- 
function EchoExperience:DoDeleteQuestTabByIndex(idx)
  local exptab = EchoExperience.view.selected.questtab
  if(idx~=nil)then
	EchoExperience.savedVariables.questsettings[idx] = nil
  end
  EchoExperience:UpdateUIQuestTabs()
end

------------------------------
--
function EchoExperience:DoSaveQuestTab()
  local window = EchoExperience.view.settingstemp.windowQuest
  local tab    = EchoExperience.view.settingstemp.tabQuest
  local color  = EchoExperience.view.settingstemp.colorQuest
 
  if EchoExperience.savedVariables.questsettings == nil then
    EchoExperience.savedVariables.questsettings = {}
  end
  
  local elem     = {}
  elem["window"] = window
  elem["tab"]    = tab
  elem["color"]  = color
  table.insert(EchoExperience.savedVariables.questsettings, elem)
 
  --reset
  EchoExperience.view.settingstemp.windowQuest = 0
  EchoExperience.view.settingstemp.tabQuest    = 0
  
  EchoExperience:UpdateUIQuestTabs()
end
--QUEST

------------------------------
-- Settings
function EchoExperience:UpdateUIQuestTabs()
  --need to update dropdown I guess?
  local myFpsLabelControl = WINDOW_MANAGER:GetControlByName("EchoExpDDQuestOutput", "")
  if(myFpsLabelControl~=nil) then
    local vals = EchoExperience:ListOfQuestTabs()
    myFpsLabelControl:UpdateChoices(vals)
  end
end

------------------------------
-- Settings
-- Setup Events Related
function EchoExperience:DoRefreshDropdowns()
	--
	EchoExperience.SetupEventsQuest()
	EchoExperience.SetupExpGainsEvents()
	EchoExperience.SetupLootGainsEvents()
	EchoExperience.SetupGuildEvents()
	EchoExperience.SetupMiscEvents()
	--
	EchoExperience:UpdateUIQuestTabs()
	--
	--EchoExperience.BuildSettings()
	--
	--[[
	EchoExpDDQuestOutput.dropdown:ClearItems() --remove previous choices --(need to call :SetSelectedItem()?)
    ZO_ClearTable(EchoExpDDQuestOutput.choices)	
	local qchoices = EchoExperience:ListOfQuestTabs()
    EchoExpDDQuestOutput:UpdateChoices(qchoices, qchoices)
	]]--
end

---------------------------------
--[[ EchoExp : Settings      ]]-- 
---------------------------------