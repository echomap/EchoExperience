--[[ Settings GUI ]]-- 
 
----------------------------------------
-- Functions to SHOW Settings data --
----------------------------------------

------------------------------
-- 
function EchoExperience.LoadSettings()
  --local LAM = LibStub("LibAddonMenu-2.0")
  local LAM = LibAddonMenu2
  local panelData = {
    type = "panel",
    name = EchoExperience.menuDisplayName,
    displayName = EchoExperience.Colorize(EchoExperience.menuDisplayName),
    author  = EchoExperience.Colorize(EchoExperience.author, "AAF0BB"),
    version = EchoExperience.Colorize(EchoExperience.version, "AA00FF"),
    slashCommand = "/EchoExperience",
    registerForRefresh  = true,
    registerForDefaults = true,
  }
  LAM:RegisterAddonPanel(EchoExperience.menuName, panelData)

  local optionsTable = { }
  optionsTable[1] = {
    type = "header",
    name = "",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "header",
    title = nil,	--(optional)
    text = "Options",
    name = "Options",
    width = "full",	--or "half" (optional)
  } 
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = GetString(SI_ECHOEXP_SETTINGS_REFRESH_TEXT), --"Refresh dropdowns",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_REFRESH_TOOLTIP), --"Refresh dropdown Data. (Use in case things just don't look right, or on first use)",
    func = function()  EchoExperience:DoRefreshDropdowns() end,
    width = "half",	--or "half" (optional)
  } 
  
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_IMMERSIVE),   --"Immersive",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_BEIMMERSIVE), --"Be immersive? on or off.",
    getFunc = function() return EchoExperience.savedVariables.immersive end,
    setFunc = function(value)
      EchoExperience.savedVariables.immersive = value
    end,
    width = "half",	--or "half" (optional)
  }
  
  -- TRACKING
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_SESSIONTRACK_NAME),
    tooltip = GetString(SI_ECHOEXP_SETTINGS_SESSIONTRACK_TT), 
    getFunc = function() return EchoExperience.savedVariables.sessiontracking end,
    setFunc = function(value)
      EchoExperience.savedVariables.sessiontracking = value
      EchoExperience.SetupMiscEvents(true)
    end,
    width = "half",	--or "half" (optional)
  }
  -- Save/Load Settings
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = GetString(SI_ECHOEXP_SETTINGS_SAVE_TITLE),  --"Save these settings",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_SAVE_MSG), --"Save these as settings so they can be used later?",
    func = function()  EchoExperience:DoSaveProfileSettings() end,
    width = "full",	--or "half" (optional)
    warning = GetString(SI_ECHOEXP_SETTINGS_NOCONFIRM),
  }
  -- Save/Load Settings
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = GetString(SI_ECHOEXP_SETTINGS_LOAD_TITLE), --"Load saved settings",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_LOAD_MSG), --"Load settings from saved profile?",
    func = function()  EchoExperience:DoLoadProfileSettings() end,
    width = "full",	--or "half" (optional)
    warning = GetString(SI_ECHOEXP_SETTINGS_NOCONFIRM),
  }
  
  --SECTION: QUEST
  optionsTable[#optionsTable+1] = {
    type = "header",
    name = "",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "header",
    title = nil,	--(optional)
    text = GetString(SI_ECHOEXP_SETTINGS_QUEST_SECTIONTITLE), --"Quest Options",
    name = GetString(SI_ECHOEXP_SETTINGS_QUEST_SECTIONNAME),  --"Quest Options",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name = GetString(SI_ECHOEXP_SETTINGS_QUEST_TITLE), --"Quest",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_QUEST_TOOLTIP), --"Show Quests accept/complete? on or off.",
    getFunc = function() return EchoExperience.savedVariables.showquests end,
    setFunc = function(value)
      EchoExperience.savedVariables.showquests = value
      EchoExperience.SetupEventsQuest(true)
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name = GetString(SI_ECHOEXP_SETTINGS_QUESTADV_TITLE), --"Quest",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_QUESTADV_TOOLTIP), --"Show Quests accept/complete? on or off.",
    getFunc = function() return EchoExperience.savedVariables.showquestsadvanced end,
    setFunc = function(value)
      EchoExperience.savedVariables.showquestsadvanced = value
      EchoExperience.SetupEventsQuest(true)
    end,
    width = "half",	--or "half" (optional)
  }
  
  --
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_KILLS_SHOW),
    tooltip = GetString(SI_ECHOEXP_SETTINGS_KILLS_SHOW_TT), 
    getFunc = function() return EchoExperience.savedVariables.showmdk end,
    setFunc = function(value)
      EchoExperience.savedVariables.showmdk = value
      EchoExperience.SetupMiscEvents(true)
    end,
    width = "half",	--or "half" (optional)
  }
  --
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_DISCOVERY_SHOW),
    tooltip = GetString(SI_ECHOEXP_SETTINGS_DISCOVERY_SHOW_TT), 
    getFunc = function() return EchoExperience.savedVariables.showdiscovery end,
    setFunc = function(value)
      EchoExperience.savedVariables.showdiscovery = value
      EchoExperience:SetupDiscoveryEvents(true)
    end,
    width = "half",	--or "half" (optional)
  }
  --
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_ACHIEVEMENT_SHOW),
    tooltip = GetString(SI_ECHOEXP_SETTINGS_ACHIEVEMENT_SHOW_TT), 
    getFunc = function() return EchoExperience.savedVariables.showachievements end,
    setFunc = function(value)
      EchoExperience.savedVariables.showachievements = value
      EchoExperience:SetupAchievmentEvents(true)
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_ACHIEVEMENTDETAIL_SHOW),
    tooltip = GetString(SI_ECHOEXP_SETTINGS_ACHIEVEMENTDETAIL_SHOW_TT), 
    getFunc = function() return EchoExperience.savedVariables.showachievementdetails end,
    setFunc = function(value)
      EchoExperience.savedVariables.showachievementdetails = value
      EchoExperience:SetupAchievmentEvents(true)
    end,
    width = "half",	--or "half" (optional)
  }
  --
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name = GetString(SI_ECHOEXP_SETTINGS_QUEST_OUTPUTS_NAME), --"Quest Output Tabs",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_QUEST_OUTPUTS_TOOLTIP), --"Tab(s) for Quest output.",
    choices = EchoExperience:ListOfQuestTabs(),
    getFunc = function() return "Select" end,
    setFunc = function(var) EchoExperience:SelectQuestTab(var) end,
    width = "half",	--or "half" (optional)
    reference = "EchoExpDDQuestOutput", -- unique global reference to control (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = GetString(SI_ECHOEXP_SETTINGS_BTN_DELETE), --"Delete",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_QUEST_OUTPUTS_DELETE), --"Delete selected Quest's Data!",
    func = function()  EchoExperience:DoDeleteQuestTab() end,
    width = "half",	--or "half" (optional)
    warning = GetString(SI_ECHOEXP_SETTINGS_NOCONFIRM),
  } 
  optionsTable[#optionsTable+1] = {
    type = "header",
    title = nil,	--(optional)
    text = GetString(SI_ECHOEXP_SETTINGS_QUEST_NEWOUTPUTS_TEXT), --"Add new Quest output:",
    name = GetString(SI_ECHOEXP_SETTINGS_QUEST_NEWOUTPUTS_NAME), --"Add Quest Output",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name = GetString(SI_ECHOEXP_SETTINGS_QUEST_WINDOW_NAME), --"Quest Output to Window",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_QUEST_WINDOW_TOOLTIP), --"Window for Quest output.",
    choices = {"1","2","3","4","5"},
    getFunc = function() return tostring(EchoExperience.view.settingstemp.windowQuest) end,
    setFunc = function(var) EchoExperience.view.settingstemp.windowQuest = tonumber(var) end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name = GetString(SI_ECHOEXP_SETTINGS_QUEST_TAB_NAME), --"Quest Output Tab",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_QUEST_TAB_TOOLTIP), --"Tab for Quest output.",
    choices = {"1", "2", "3", "4", "5", "6"},
    getFunc = function() return tostring(EchoExperience.view.settingstemp.tabQuest) end,
    setFunc = function(var) EchoExperience.view.settingstemp.tabQuest = tonumber(var) end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "colorpicker",
    name = GetString(SI_ECHOEXP_SETTINGS_QUEST_COLOR_TEXT), --"Quest Output Color",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_QUEST_COLOR_TOOLTIP), --"What Color to use for Quest text.",
    getFunc = function() 
        if(EchoExperience.view.settingstemp==nil or EchoExperience.view.settingstemp.colorQuest==nil) then
          EchoExperience.SetupDefaultColors()
      end
      return              
      EchoExperience.view.settingstemp.colorQuest.r,
      EchoExperience.view.settingstemp.colorQuest.g,
      EchoExperience.view.settingstemp.colorQuest.b,
      EchoExperience.view.settingstemp.colorQuest.a
    end,	--(alpha is optional)    
    setFunc = 	function(r,g,b,a)
      --(alpha is optional)
      --d(r, g, b, a)
      --local c = ZO_ColorDef:New(r,g,b,a)
      --c:Colorize(text)
      EchoExperience.view.settingstemp.colorQuest = {}
      EchoExperience.view.settingstemp.colorQuest.r = r
      EchoExperience.view.settingstemp.colorQuest.g = g
      EchoExperience.view.settingstemp.colorQuest.b = b
      EchoExperience.view.settingstemp.colorQuest.a = a
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = GetString(SI_ECHOEXP_SETTINGS_BTN_SAVE), --"Save",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_QUEST_NEWOUTPUTS_SAVE), --"Save selected Quest chat Data!",
    func = function()  EchoExperience:DoSaveQuestTab() end,
    width = "half",	--or "half" (optional)
    warning = GetString(SI_ECHOEXP_SETTINGS_NOCONFIRM),
  }
  --QUEST
  
  --SECTION: EXP
  optionsTable[#optionsTable+1] = {
    type = "header",
    name = "",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "header",
    title = nil,	--(optional)
    text = GetString(SI_ECHOEXP_SETTINGS_EXP_SECTIONTITLE), --"Experience Options",
    name =  GetString(SI_ECHOEXP_SETTINGS_EXP_SECTIONNAME), --"Experience Options",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name = GetString(SI_ECHOEXP_SETTINGS_EXP_TITLE), --"Experience",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_EXP_TOOLTIP), --"Report? on or off.",
    getFunc = function() return EchoExperience.savedVariables.showExp end,
    setFunc = function(value)
      EchoExperience.savedVariables.showExp = value
      EchoExperience.SetupExpGainsEvents(true)
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "description",
    text = GetString(SI_ECHOEXP_SETTINGS_EXP_TY12_TEXT),
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name = GetString(SI_ECHOEXP_SETTINGS_EXP_TY1_TITLE), 
    tooltip = GetString(SI_ECHOEXP_SETTINGS_EXP_TY1_TOOLTIP),
    getFunc = function() return EchoExperience.savedVariables.showExpT1 end,
    setFunc = function(value)
      EchoExperience.savedVariables.showExpT1 = value
      EchoExperience.SetupExpGainsEvents(true)
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name = GetString(SI_ECHOEXP_SETTINGS_EXP_TY2_TITLE), 
    tooltip = GetString(SI_ECHOEXP_SETTINGS_EXP_TY2_TOOLTIP),
    getFunc = function() return EchoExperience.savedVariables.showExpT2 end,
    setFunc = function(value)
      EchoExperience.savedVariables.showExpT2 = value
      EchoExperience.SetupExpGainsEvents(true)
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name = GetString(SI_ECHOEXP_SETTINGS_EXP_VERB_NAME), --"Verbose Experience",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_EXP_VERB_TOOLTIP), --"Verbose reporting if experience is on?",
    getFunc = function() return EchoExperience.savedVariables.verboseExp end,
    setFunc = function(value)
      EchoExperience.savedVariables.verboseExp = value
      --EchoExperience.SetupExpGainsEvents(false)
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "description",
    text = "",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_EXP_SKILLLINE_TITLE), --"" Skill Experience",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_EXP_SKILLLINE_TOOLTIP), --""Verbose reporting if experience is on?",
    getFunc = function() return EchoExperience.savedVariables.showSkillExp end,
    setFunc = function(value)
      EchoExperience.savedVariables.showSkillExp = value
      --EchoExperience.SetupExpGainsEvents(false)
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_EXP_VERBSKILLLINE_TITLE), --""Verbose Skill Experience",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_EXP_VERBSKILLLINE_TOOLTIP), --""Verbose reporting if experience is on?",
    getFunc = function() return EchoExperience.savedVariables.showAllSkillExp end,
    setFunc = function(value)
      EchoExperience.savedVariables.showAllSkillExp = value
      --EchoExperience.SetupExpGainsEvents(false)
    end,
    width = "half",	--or "half" (optional)
  }
  
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name = GetString(SI_ECHOEXP_SETTINGS_EXP_OUTPUTS_NAME), --"Exp Output Tabs",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_EXP_OUTPUTS_TOOLTIP), --"Tab(s) for Exp output.",
    choices = EchoExperience:ListOfExpTabs(),
    getFunc = function() return "Select" end,
    setFunc = function(var) EchoExperience:SelectExpTab(var) end,
    width = "half",	--or "half" (optional)
    reference = "EchoExpDDExpOutput", -- unique global reference to control (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = GetString(SI_ECHOEXP_SETTINGS_BTN_DELETE), --"Delete",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_EXP_OUTPUTS_DELETE), --"Delete selected Character's Data!",
    func = function()  EchoExperience:DoDeleteExpTab() end,
    width = "half",	--or "half" (optional)
    warning = GetString(SI_ECHOEXP_SETTINGS_NOCONFIRM),
  } 
  optionsTable[#optionsTable+1] = {
    type = "header",
    title = nil,	--(optional)
    text = GetString(SI_ECHOEXP_SETTINGS_EXP_NEWOUTPUTS_TEXT), --"Add new Experience output:",
    name = GetString(SI_ECHOEXP_SETTINGS_EXP_NEWOUTPUTS_NAME), --"Add Experience Output",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name = GetString(SI_ECHOEXP_SETTINGS_EXP_WINDOW_NAME), --"Exp Output to Window",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_EXP_WINDOW_TOOLTIP), --"Window for Exp output.",
    choices = {"1","2","3","4","5"},
    getFunc = function() return tostring(EchoExperience.view.settingstemp.windowExp) end,
    setFunc = function(var) EchoExperience.view.settingstemp.windowExp = tonumber(var) end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name = GetString(SI_ECHOEXP_SETTINGS_EXP_TAB_NAME), --"Exp Output Tab",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_EXP_TAB_NAME), --"Tab for Exp output.",
    choices = {"1", "2", "3", "4", "5", "6"},
    getFunc = function() return tostring(EchoExperience.view.settingstemp.tabExp) end,
    setFunc = function(var) EchoExperience.view.settingstemp.tabExp = tonumber(var) end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "colorpicker",
    name = GetString(SI_ECHOEXP_SETTINGS_EXP_COLOR_TEXT), --"EXP Output Color",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_EXP_COLOR_TOOLTIP), --"What Color to use for Exp text.",
    getFunc = function() 
        if(EchoExperience.view.settingstemp==nil or EchoExperience.view.settingstemp.colorExp==nil) then
          EchoExperience.SetupDefaultColors()
      end
      return              
      EchoExperience.view.settingstemp.colorExp.r,
      EchoExperience.view.settingstemp.colorExp.g,
      EchoExperience.view.settingstemp.colorExp.b,
      EchoExperience.view.settingstemp.colorExp.a
    end,	--(alpha is optional)    
    setFunc = 	function(r,g,b,a)
      --(alpha is optional)
      --d(r, g, b, a)
      --local c = ZO_ColorDef:New(r,g,b,a)
      --c:Colorize(text)
      EchoExperience.view.settingstemp.colorExp = {}
      EchoExperience.view.settingstemp.colorExp.r = r
      EchoExperience.view.settingstemp.colorExp.g = g
      EchoExperience.view.settingstemp.colorExp.b = b
      EchoExperience.view.settingstemp.colorExp.a = a
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = GetString(SI_ECHOEXP_SETTINGS_BTN_SAVE), --"Save",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_EXP_NEWOUTPUTS_SAVE), --"Save selected Exp chat Data!",
    func = function()  EchoExperience:DoSaveExpTab() end,
    width = "half",	--or "half" (optional)
    warning = GetString(SI_ECHOEXP_SETTINGS_NOCONFIRM),
  }
  
  --SECTION: LOOT
  optionsTable[#optionsTable+1] = {        
    type = "header",
    name = "",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "header",
    --title = "My Title",	--(optional)
    text = GetString(SI_ECHOEXP_SETTINGS_LOOT_SECTIONTITLE), -- "Loot Options",
    name = GetString(SI_ECHOEXP_SETTINGS_LOOT_SECTIONNAME), -- "Loot Options",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_LOOT_TITLE), -- "Looted Items",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_LOOT_TOOLTIP), -- "Report? on or off.",
    getFunc = function() return EchoExperience.savedVariables.showLoot end,
    setFunc = function(value)
      EchoExperience.savedVariables.showLoot = value
      EchoExperience.SetupLootGainsEvents(false)
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {		
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_LOOT_VERB_NAME), -- "Show other types of item events? (researched/trashed/etc)",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_LOOT_VERB_TOOLTIP), -- "Verbose reporting of Looted items?",
    getFunc = function() return EchoExperience.savedVariables.extendedLoot end,
    setFunc = function(value)
      EchoExperience.savedVariables.extendedLoot = value
      EchoExperience.SetupLootGainsEvents(false)
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {		
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_LOOT_GROUP_TITLE), -- "Show other group member's Looted items?",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_LOOT_GROUP_TOOLTIP), -- "Verbose reporting if Looted is on?",
    getFunc = function() return EchoExperience.savedVariables.groupLoot end,
    setFunc = function(value)
      EchoExperience.savedVariables.groupLoot = value
      EchoExperience.SetupLootGainsEvents(false)
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "description",
    text = "",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name    = GetString(SI_ECHOEXP_SETTINGS_LOOT_OUTPUTS_NAME), -- "Loot Output Tabs",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_LOOT_OUTPUTS_TOOLTIP), -- "Tab(s) for Loot output.",
    choices = EchoExperience:ListOfLootTabs(),
    getFunc = function() return "Select" end,
    setFunc = function(var) EchoExperience:SelectLootTab(var) end,
    width = "half",	--or "half" (optional)
    reference = "EchoExpDDLootOutput", -- unique global reference to control (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "button",
    name    = GetString(SI_ECHOEXP_SETTINGS_BTN_DELETE), --"Delete",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_LOOT_OUTPUTS_DELETE), -- "Delete selected Character's Data!",
    func = function()  EchoExperience:DoDeleteLootTab() end,
    width = "half",	--or "half" (optional)
    warning = GetString(SI_ECHOEXP_SETTINGS_NOCONFIRM),
  } 
  optionsTable[#optionsTable+1] = {
    type = "header",
    title = nil,	--(optional)
    text = GetString(SI_ECHOEXP_SETTINGS_LOOT_NEWOUTPUTS_TEXT), -- "Add new Loot output:",
    name = GetString(SI_ECHOEXP_SETTINGS_LOOT_NEWOUTPUTS_NAME), -- "Add Loot Output",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name    = GetString(SI_ECHOEXP_SETTINGS_LOOT_WINDOW_NAME), --"Loot Output to Window",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_LOOT_WINDOW_TOOLTIP), --"Window for Loot output.",
    choices = {"1","2","3","4","5"},
    getFunc = function() return tostring(EchoExperience.view.settingstemp.windowLoot) end,
    setFunc = function(var) EchoExperience.view.settingstemp.windowLoot = tonumber(var) end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name    = GetString(SI_ECHOEXP_SETTINGS_LOOT_TAB_NAME), -- "Loot Output Tab",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_LOOT_TAB_TOOLTIP), --"Tab for Loot output.",
    choices = {"1", "2", "3", "4", "5", "6"},
    getFunc = function() return tostring(EchoExperience.view.settingstemp.tabLoot) end,
    setFunc = function(var) EchoExperience.view.settingstemp.tabLoot = tonumber(var) end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "colorpicker",
    name    = GetString(SI_ECHOEXP_SETTINGS_LOOT_COLOR_TEXT), --"Loot Output Color",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_LOOT_COLOR_TOOLTIP), --"What Color to use for Loot text.",
    getFunc = function()               
        if(EchoExperience.view.settingstemp==nil or EchoExperience.view.settingstemp.colorLoot==nil) then
          EchoExperience.SetupDefaultColors()
      end
      return              
      EchoExperience.view.settingstemp.colorLoot.r,
      EchoExperience.view.settingstemp.colorLoot.g,
      EchoExperience.view.settingstemp.colorLoot.b,
      EchoExperience.view.settingstemp.colorLoot.a      
    end,
    setFunc = 	function(r,g,b,a)
      --(alpha is optional)
      --d(r, g, b, a)
      --local c = ZO_ColorDef:New(r,g,b,a)
      --c:Colorize(text)
      EchoExperience.view.settingstemp.colorLoot = {}
      EchoExperience.view.settingstemp.colorLoot.r = r
      EchoExperience.view.settingstemp.colorLoot.g = g
      EchoExperience.view.settingstemp.colorLoot.b = b
      EchoExperience.view.settingstemp.colorLoot.a = a
    end,
    width = "half",	--or "half" (optional)
  }
  
  --[[ ALPHA maybe to let this happen channel by channel?
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_LOOT_TITLE), --"Looted Items",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_LOOT_TOOLTIP), --"Report? on or off.",
    getFunc = function() return EchoExperience.view.settingstemp.showItemLoot end,
    setFunc = function(value)
      EchoExperience.view.settingstemp.showItemLoot = value
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {		
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_LOOT_GROUP_TITLE), --"Show other group member's Looted items?",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_LOOT_GROUP_TOOLTIP), --"Verbose reporting if Looted is on?",
    getFunc = function() return EchoExperience.view.settingstemp.showGroupLoot end,
    setFunc = function(value)
      EchoExperience.view.settingstemp.showGroupLoot = value
    end,
    width = "half",	--or "half" (optional)
  }
  --]]
  
  optionsTable[#optionsTable+1] = {
    type = "button",
    name    = GetString(SI_ECHOEXP_SETTINGS_BTN_SAVE), --"Save",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_LOOT_NEWOUTPUTS_SAVE), --"Save selected Loot chat Data!",
    func = function()  EchoExperience:DoSaveLootTab() end,
    width = "half",	--or "half" (optional)
    warning = GetString(SI_ECHOEXP_SETTINGS_NOCONFIRM),
  }
  
  --SECTION: GUILD
  optionsTable[#optionsTable+1] = {
    type = "header",
    name = "",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "header",
    --title = "My Title",	--(optional)
    text = GetString(SI_ECHOEXP_SETTINGS_GUILD_SECTIONTITLE),-- "Guild Options",
    name = GetString(SI_ECHOEXP_SETTINGS_GUILD_SECTIONNAME),-- "Guild Options",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_GUILD_LOGON_NAME),-- "Show Guild LogOns?",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_GUILD_LOGON_TOOLTIP),-- "Report? on or off.",
    getFunc = function() return EchoExperience.savedVariables.showGuildLogin end,
    setFunc = function(value)
      EchoExperience.savedVariables.showGuildLogin = value
      EchoExperience.SetupGuildEvents()
      --EchoExperience.SetupMiscEvents()
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_GUILD_LOGOFF_NAME),-- "Show Guild LogOffs?",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_GUILD_LOGOFF_TOOLTIP),-- "Report? on or off.",
    getFunc = function() return EchoExperience.savedVariables.showGuildLogout end,
    setFunc = function(value)
      EchoExperience.savedVariables.showGuildLogout = value
      --EchoExperience.SetupMiscEvents()
      EchoExperience.SetupGuildEvents()
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name    = GetString(SI_ECHOEXP_SETTINGS_GUILD_OUTPUTS_NAME),-- "Guild Output Tabs",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_GUILD_OUTPUTS_TOOLTIP),-- "Tab(s) for Guild output.",
    choices = EchoExperience:ListOfGuildTabs(),
    getFunc = function() return "Select" end,
    setFunc = function(var) EchoExperience:SelectGuildTab(var) end,
    width = "half",	--or "half" (optional)
    reference = "EchoExpDDGuildOutput", -- unique global reference to control (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = GetString(SI_ECHOEXP_SETTINGS_BTN_DELETE), --"Delete",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_GUILD_OUTPUTS_DELETE),-- "Delete selected Character's Data!",
    func = function()  EchoExperience:DoDeleteGuildTab() end,
    width = "half",	--or "half" (optional)
    warning = GetString(SI_ECHOEXP_SETTINGS_NOCONFIRM),
  }
  
  optionsTable[#optionsTable+1] = {
    type = "header",
    title = nil,	--(optional)
    text = GetString(XX),-- "Add new Guild output:",
    name = GetString(XX),-- "Add Guild Output",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name    = GetString(SI_ECHOEXP_SETTINGS_GUILD_WINDOW_NAME),-- "Select Guild Output to Window",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_GUILD_WINDOW_TOOLTIP),-- "Window for Guild output. (Zero will disable)",
    choices = {"1","2","3","4","5"},
    getFunc = function() return tostring(EchoExperience.view.settingstemp.windowGuild) end,
    setFunc = function(var) EchoExperience.view.settingstemp.windowGuild = tonumber(var) end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name    = GetString(SI_ECHOEXP_SETTINGS_GUILD_TAB_NAME),-- "Select Guild Output Tab",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_GUILD_TAB_TOOLTIP),-- "Tab for Guild output.",
    choices = {"1", "2", "3", "4", "5", "6"},
    getFunc = function() return tostring(EchoExperience.view.settingstemp.tabGuild) end,
    setFunc = function(var) EchoExperience.view.settingstemp.tabGuild = tonumber(var) end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "colorpicker",
    name    = GetString(SI_ECHOEXP_SETTINGS_GUILD_COLOR_TEXT),--"GUILD Output Color",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_GUILD_COLOR_TOOLTIP),--"What Color to use for GUILD text.",
    getFunc = function()               
        if(EchoExperience.view.settingstemp==nil or EchoExperience.view.settingstemp.colorGuild==nil) then
          EchoExperience.SetupDefaultColors()
      end
      return              
      EchoExperience.view.settingstemp.colorGuild.r,
      EchoExperience.view.settingstemp.colorGuild.g,
      EchoExperience.view.settingstemp.colorGuild.b,
      EchoExperience.view.settingstemp.colorGuild.a      
    end,
    setFunc = 	function(r,g,b,a)
      --(alpha is optional)
      --d(r, g, b, a)
      local c = ZO_ColorDef:New(r,g,b,a)
      --c:Colorize(text)
      EchoExperience.view.settingstemp.colorGuild = {}
      EchoExperience.view.settingstemp.colorGuild.r = r
      EchoExperience.view.settingstemp.colorGuild.g = g
      EchoExperience.view.settingstemp.colorGuild.b = b
      EchoExperience.view.settingstemp.colorGuild.a = a
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name = GetString(SI_ECHOEXP_SETTINGS_GUILD_G1), --"G1", -- or string id or function returning a string
    getFunc = function() 
      return EchoExperience.view.settingstemp.guild1 
    end,
    setFunc = function(var) EchoExperience.view.settingstemp.guild1 = (var)  end,
    tooltip = EchoExperience:GetGuildName(1),
    width = "half", -- or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name = GetString(SI_ECHOEXP_SETTINGS_GUILD_G2), --"G2", -- or string id or function returning a string
    getFunc = function() return EchoExperience.view.settingstemp.guild2 end,
    setFunc = function(var) EchoExperience.view.settingstemp.guild2 = (var) end,
    tooltip = EchoExperience:GetGuildName(2) ,
    width = "half", -- or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name = GetString(SI_ECHOEXP_SETTINGS_GUILD_G3), --"G3", -- or string id or function returning a string
    getFunc = function() return EchoExperience.view.settingstemp.guild3 end,
    setFunc = function(var) EchoExperience.view.settingstemp.guild3 = (var) end,
    tooltip = EchoExperience:GetGuildName(3),
    width = "half", -- or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name = GetString(SI_ECHOEXP_SETTINGS_GUILD_G4), --"G4", -- or string id or function returning a string
    getFunc = function() return EchoExperience.view.settingstemp.guild4 end,
    setFunc = function(var) EchoExperience.view.settingstemp.guild4 = (var) end,
    tooltip = EchoExperience:GetGuildName(4),
    width = "half", -- or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name = GetString(SI_ECHOEXP_SETTINGS_GUILD_G5), --"G5", -- or string id or function returning a string
    getFunc = function() return EchoExperience.view.settingstemp.guild5 end,
    setFunc = function(var) EchoExperience.view.settingstemp.guild5 = (var) end,
    tooltip = EchoExperience:GetGuildName(5),
    width = "half", -- or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "button",
    name    = GetString(SI_ECHOEXP_SETTINGS_BTN_SAVE), --"Save",
    tooltip = GetString(SI_ECHOEXP_SETTINGS_GUILD_NEWOUTPUTS_SAVE), --"Save selected Guild chat Data!",
    func = function()  EchoExperience:DoSaveGuildTab() end,
    width = "full",	--or "half" (optional)
    warning = GetString(SI_ECHOEXP_SETTINGS_NOCONFIRM),
  }
  
  --SECTION: DEVs
  optionsTable[#optionsTable+1] = {
    type = "header",
    name = "",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "header",
    --title = "My Title",	--(optional)
    text = "Dev. Options",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name = "Debug",
    tooltip = "Debug on or off.",
    getFunc = function() return EchoExperience.savedVariables.debug end,
    setFunc = function(value) EchoExperience.savedVariables.debug = value end,
    width = "half",	--or "half" (optional)
  }
    
  --
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_ALPHA_NAME),
    tooltip = GetString(SI_ECHOEXP_SETTINGS_ALPHA_NAME_TT), 
    getFunc = function() return EchoExperience.savedVariables.showalpha end,
    setFunc = function(value)
      EchoExperience.savedVariables.showalpha = value
      EchoExperience:SetupAlphaEvents(true)
    end,
    width = "half",	--or "half" (optional)
  }
    -- TRACKING
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name    = GetString(SI_ECHOEXP_SETTINGS_LIFETIMETRACK_NAME),
    tooltip = GetString(SI_ECHOEXP_SETTINGS_LIFETIMETRACK_TT), 
    getFunc = function() return EchoExperience.savedVariables.lifetimetracking end,
    setFunc = function(value)
      EchoExperience.savedVariables.lifetimetracking = value
      EchoExperience.lifetimetracking(true)
    end,
    width = "half",	--or "half" (optional)
  }

  LAM:RegisterOptionControls(EchoExperience.menuName, optionsTable)
end

--EOF