-- Settings menu.
function EchoExperience.LoadSettings()
  local LAM = LibStub("LibAddonMenu-2.0")

  local panelData = {
      type = "panel",
      name = EchoExperience.menuDisplayName,
      displayName = EchoExperience.Colorize(EchoExperience.menuName),
      author  = EchoExperience.Colorize(EchoExperience.author, "AAF0BB"),
      version = EchoExperience.Colorize(EchoExperience.version, "AA00FF"),
      slashCommand = "/EchoExperience",
      registerForRefresh = true,
      registerForDefaults = true,
  }
  LAM:RegisterAddonPanel(EchoExperience.menuName, panelData)

  local optionsTable = { }
  optionsTable[1] = {
    type = "header",
    name = "",
    width = "full",	--or "half" (optional)
  }
  ---EXP
  optionsTable[#optionsTable+1] = {
    type = "header",
    title = nil,	--(optional)
    text = "Experience Options",
    name = "Experience Options",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name = "Experience",
    tooltip = "Report? on or off.",
    getFunc = function() return EchoExperience.savedVariables.showExp end,
    setFunc = function(value)
      EchoExperience.savedVariables.showExp = value
      EchoExperience.SetupExpGainsEvents(false)
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name = "Verbose Experience",
    tooltip = "Verbose reporting if experience is on?",
    getFunc = function() return EchoExperience.savedVariables.verboseExp end,
    setFunc = function(value)
      EchoExperience.savedVariables.verboseExp = value
      --EchoExperience.SetupExpGainsEvents(false)
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name = "Exp Output Tabs",
    tooltip = "Tab(s) for Exp output.",
    choices = EchoExperience:ListOfExpTabs(),
    getFunc = function() return "Select" end,
    setFunc = function(var) EchoExperience:SelectExpTab(var) end,
    width = "half",	--or "half" (optional)
    reference = "EchoExpDDExpOutput", -- unique global reference to control (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = "Delete",
    tooltip = "Delete selected Character's Data!",
    func = function()  EchoExperience:DoDeleteExpTab() end,
    width = "full",	--or "half" (optional)
    warning = "No confirmation if you do this!",	--(optional)
  } 
  optionsTable[#optionsTable+1] = {
    type = "header",
    title = nil,	--(optional)
    text = "Add new Experience output:",
    name = "Add Experience Output",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name = "Exp Output to Window",
    tooltip = "Window for Exp output.",
    choices = {"1","2","3","4","5"},
    getFunc = function() return 0 end,
    setFunc = function(var) EchoExperience.view.settingstemp.windowExp = tonumber(var) end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name = "Exp Output Tab",
    tooltip = "Tab for Exp output.",
    choices = {"1", "2", "3", "4", "5", "6"},
    getFunc = function() return 0 end,
    setFunc = function(var) EchoExperience.view.settingstemp.tabExp = tonumber(var) end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "colorpicker",
    name = "EXP Output Color",
    tooltip = "What Color to use for Exp text.",
    getFunc = function() return              
      EchoExperience.rgbaBase.r,
      EchoExperience.rgbaBase.g,
      EchoExperience.rgbaBase.b,
      EchoExperience.rgbaBase.a
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
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = "Save",
    tooltip = "Save selected Exp chat Data!",
    func = function()  EchoExperience:DoSaveExpTab() end,
    width = "full",	--or "half" (optional)
    warning = "No confirmation if you do this!",	--(optional)
  }
  
  ---LOOT
  optionsTable[#optionsTable+1] = {        
    type = "header",
    name = "",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "header",
    --title = "My Title",	--(optional)
    text = "Loot Options",
    name = "Loot Options",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "checkbox",
    name = "Looted Items",
    tooltip = "Report? on or off.",
    getFunc = function() return EchoExperience.savedVariables.showLoot end,
    setFunc = function(value)
      EchoExperience.savedVariables.showLoot = value
      EchoExperience.SetupLootGainsEvents(false)
    end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {		
            type = "checkbox",
            name = "Show other group member's Looted items?",
            tooltip = "Verbose reporting if experience is on?",
            getFunc = function() return EchoExperience.savedVariables.groupLoot end,
            setFunc = function(value)
						EchoExperience.savedVariables.groupLoot = value
					end,
            width = "half",	--or "half" (optional)
  }
  
  
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name = "Loot Output Tabs",
    tooltip = "Tab(s) for Loot output.",
    choices = EchoExperience:ListOfLootTabs(),
    getFunc = function() return "Select" end,
    setFunc = function(var) EchoExperience:SelectLootTab(var) end,
    width = "half",	--or "half" (optional)
    reference = "EchoExpDDLootOutput", -- unique global reference to control (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = "Delete",
    tooltip = "Delete selected Character's Data!",
    func = function()  EchoExperience:DoDeleteLootTab() end,
    width = "full",	--or "half" (optional)
    warning = "No confirmation if you do this!",	--(optional)
  } 
  optionsTable[#optionsTable+1] = {
    type = "header",
    title = nil,	--(optional)
    text = "Add new Loot output:",
    name = "Add Loot Output",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name = "Loot Output to Window",
    tooltip = "Window for Loot output.",
    choices = {"1","2","3","4","5"},
    getFunc = function() return 0 end,
    setFunc = function(var) EchoExperience.view.settingstemp.windowLoot = tonumber(var) end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "dropdown",
    name = "Loot Output Tab",
    tooltip = "Tab for Loot output.",
    choices = {"1", "2", "3", "4", "5", "6"},
    getFunc = function() return 0 end,
    setFunc = function(var) EchoExperience.view.settingstemp.tabLoot = tonumber(var) end,
    width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "colorpicker",
    name = "Loot Output Color",
    tooltip = "What Color to use for Loot text.",
    getFunc = function() return              
      EchoExperience.rgbaBase.r,
      EchoExperience.rgbaBase.g,
      EchoExperience.rgbaBase.b,
      EchoExperience.rgbaBase.a
    end,	--(alpha is optional)
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
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "button",
    name = "Save",
    tooltip = "Save selected Loot chat Data!",
    func = function()  EchoExperience:DoSaveLootTab() end,
    width = "full",	--or "half" (optional)
    warning = "No confirmation if you do this!",	--(optional)
  }
  
  ---GUILD
  optionsTable[#optionsTable+1] = {
            type = "header",
            name = "",
            width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
            type = "header",
            --title = "My Title",	--(optional)
            text = "Guild Options",
            name = "Guild Options",
            width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
            type = "checkbox",
            name = "Show Guild LogOns?",
            tooltip = "Report? on or off.",
            getFunc = function() return EchoExperience.savedVariables.showGuildLogin end,
            setFunc = function(value)
              EchoExperience.savedVariables.showGuildLogin = value
              EchoExperience.SetupMiscEvents()
            end,
            width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
            type = "checkbox",
            name = "Show Guild LogOffs?",
            tooltip = "Report? on or off.",
            getFunc = function() return EchoExperience.savedVariables.showGuildLogout end,
            setFunc = function(value)
              EchoExperience.savedVariables.showGuildLogout = value
              EchoExperience.SetupMiscEvents()
            end,
            width = "half",	--or "half" (optional)
  }

  optionsTable[#optionsTable+1] = {
            type = "dropdown",
            name = "Guild Output Tabs",
            tooltip = "Tab(s) for Guild output.",
            choices = EchoExperience:ListOfGuildTabs(),
            getFunc = function() return "Select" end,
            setFunc = function(var) EchoExperience:SelectGuildTab(var) end,
            width = "half",	--or "half" (optional)
            reference = "EchoExpDDGuildOutput", -- unique global reference to control (optional)
  }
  optionsTable[#optionsTable+1] = {
            type = "button",
            name = "Delete",
            tooltip = "Delete selected Character's Data!",
            func = function()  EchoExperience:DoDeleteGuildTab() end,
            width = "full",	--or "half" (optional)
            warning = "No confirmation if you do this!",	--(optional)
  }
  optionsTable[#optionsTable+1] = {
    type = "header",
    title = nil,	--(optional)
    text = "Add new Guild output:",
    name = "Add Guild Output",
    width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
            type = "dropdown",
            name = "Guild Output to Window",
            tooltip = "Window for Guild output. (Zero will disable)",
            choices = {"1","2","3","4","5"},
            getFunc = function() return 0 end,
            setFunc = function(var) EchoExperience.view.settingstemp.windowGuild = tonumber(var) end,
            width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
            type = "dropdown",
            name = "Guild Output Tab #1",
            tooltip = "Tab for Guild output.",
            choices = {"1", "2", "3", "4", "5", "6"},
            getFunc = function() return 0 end,
            setFunc = function(var) EchoExperience.view.settingstemp.tabGuild = tonumber(var) end,
            width = "half",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
            type = "colorpicker",
            name = "GUILD Output Color",
            tooltip = "What Color to use for GUILD text.",
            getFunc = function() return              
							EchoExperience.rgbaBase.r,
							EchoExperience.rgbaBase.g,
							EchoExperience.rgbaBase.b,
							EchoExperience.rgbaBase.a
						end,	--(alpha is optional)
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
            width = "full",	--or "half" (optional)
  }
  optionsTable[#optionsTable+1] = {
            type = "button",
            name = "Save",
            tooltip = "Save selected Guild chat Data!",
            func = function()  EchoExperience:DoSaveGuildTab() end,
            width = "full",	--or "half" (optional)
            warning = "No confirmation if you do this!",	--(optional)
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
    
  LAM:RegisterOptionControls(EchoExperience.menuName, optionsTable)
end