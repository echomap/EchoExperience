--[[ Settings GUI ]]-- 
 
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
 
  if EchoExperience.savedVariables.guildsettings == nil then
    EchoExperience.savedVariables.guildsettings = {}
  end
  
  local elem = {}
  elem["window"]=window
  elem["tab"]=tab
  elem["color"]=color
  local gs = {}
  if(EchoExperience.view.settingstemp.guild1) then
    gs[EchoExperience:GetGuildId(1)] = true
  end
  if(EchoExperience.view.settingstemp.guild2) then
    gs[EchoExperience:GetGuildId(2)] = true
  end
  if(EchoExperience.view.settingstemp.guild3) then
    gs[EchoExperience:GetGuildId(3)] = true
  end
  if(EchoExperience.view.settingstemp.guild4) then
    gs[EchoExperience:GetGuildId(4)] = true
  end
  if(EchoExperience.view.settingstemp.guild5) then
    gs[EchoExperience:GetGuildId(5)] = true
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
--
function EchoExperience:DoDeleteQuestTab()
  local exptab = EchoExperience.view.selected.questtab 
  if(exptab~=nil)then
    --d(EchoExperience.name .. " exptab=" .. exptab) 
    for k,v in pairs(EchoExperience.savedVariables.questsettings) do
      local vCD = ZO_ColorDef:New(v.color.r, v.color.g, v.color.b, v.color.a)
      local vtext = vCD:Colorize("COLOR")      
      local valV = zo_strformat( "<<1>>/<<2>>/<<3>>", v.window,v.tab, vtext )
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
-- Setup Events Related
function EchoExperience:DoRefreshDropdowns()
	EchoExperience.SetupExpGainsEvents()
	EchoExperience.SetupLootGainsEvents()
  EchoExperience.SetupGuildEvents()
  EchoExperience.SetupMiscEvents()  
end

--EOF