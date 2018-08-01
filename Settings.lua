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

    local optionsTable = {
        [1] = {
            type = "header",
            name = "",
            width = "full",	--or "half" (optional)
        },
        [2] = {
            type = "header",
            title = nil,	--(optional)
            text = "Experience Options",
			name = "Experience Options",
            width = "full",	--or "half" (optional)
        },
        [3] = {
            type = "dropdown",
            name = "Window Dropdown",
            tooltip = "Dropdown's tooltip text.",
            choices = {"1", "2", "3","4"},
            getFunc = function() return tostring(EchoExperience.savedVariables.window) end,
            setFunc = function(var) EchoExperience.savedVariables.window = tonumber(var) end,
            width = "half",	--or "half" (optional)
        },
        [4] = {
            type = "dropdown",
            name = "Tab Dropdown",
            tooltip = "Dropdown's tooltip text.",
            choices = {"1", "2", "3", "4", "5", "6"},
            getFunc = function() return tostring(EchoExperience.savedVariables.tab)   end,
            setFunc = function(var) EchoExperience.savedVariables.tab = tonumber(var) end,
            width = "half",	--or "half" (optional)
        },
        [5] = {
            type = "colorpicker",
            name = "EXP Chat Color",
            tooltip = "What Color to use for EXP text.",
            getFunc = function() return
							EchoExperience.savedVariables.rgba.r,
							EchoExperience.savedVariables.rgba.g,
							EchoExperience.savedVariables.rgba.b,
							EchoExperience.savedVariables.rgba.a
						end,	--(alpha is optional)
            setFunc = 	function(r,g,b,a)
							--(alpha is optional)
							--d(r, g, b, a)
							local c = ZO_ColorDef:New(r,g,b,a)
							--c:Colorize(text)
							EchoExperience.savedVariables.rgba = {}
							EchoExperience.savedVariables.rgba.r = r
							EchoExperience.savedVariables.rgba.g = g
							EchoExperience.savedVariables.rgba.b = b
							EchoExperience.savedVariables.rgba.a = a
						end,

            width = "half",	--or "half" (optional)
        },
		[6] = {
            type = "checkbox",
            name = "Experience",
            tooltip = "Report? on or off.",
            getFunc = function() return EchoExperience.savedVariables.showExp end,
            setFunc = function(value)
						EchoExperience.savedVariables.showExp = value
						EchoExperience.SetupExpGainsEvents(false)
					end,
            width = "half",	--or "half" (optional)
        },
		[7] = {
            type = "checkbox",
            name = "Verbose Experience",
            tooltip = "Verbose reporting if experience is on?",
            getFunc = function() return EchoExperience.savedVariables.verboseExp end,
            setFunc = function(value)
						EchoExperience.savedVariables.verboseExp = value
						--EchoExperience.SetupExpGainsEvents(false)
					end,
            width = "half",	--or "half" (optional)
        },
        [8] = {
            type = "header",
            name = "",
            width = "full",	--or "half" (optional)
        },
        [9] = {
            type = "header",
            --title = "My Title",	--(optional)
            text = "Loot Options",
			name = "Loot Options",
            width = "full",	--or "half" (optional)
        },
        [10] = {
            type = "dropdown",
            name = "Window Dropdown",
            tooltip = "Dropdown's tooltip text.",
            choices = {"1", "2", "3","4"},
            getFunc = function() return tostring(EchoExperience.savedVariables.windowloot) end,
            setFunc = function(var) EchoExperience.savedVariables.windowloot = tonumber(var) end,
            width = "half",	--or "half" (optional)
        },
        [11] = {
            type = "dropdown",
            name = "Tab Dropdown",
            tooltip = "Dropdown's tooltip text.",
            choices = {"1", "2", "3", "4", "5", "6"},
            getFunc = function() return tostring(EchoExperience.savedVariables.tabloot)   end,
            setFunc = function(var) EchoExperience.savedVariables.tabloot = tonumber(var) end,
            width = "half",	--or "half" (optional)
        },
        [12] = {
            type = "colorpicker",
            name = "LOOT Chat Color",
            tooltip = "What Color to use for LOOT text.",
            getFunc = function() return
							EchoExperience.savedVariables.rgba2.r,
							EchoExperience.savedVariables.rgba2.g,
							EchoExperience.savedVariables.rgba2.b,
							EchoExperience.savedVariables.rgba2.a
						end,	--(alpha is optional)
            setFunc = 	function(r,g,b,a)
							--(alpha is optional)
							--d(r, g, b, a)
							local c = ZO_ColorDef:New(r,g,b,a)
							--c:Colorize(text)
							EchoExperience.savedVariables.rgba2 = {}
							EchoExperience.savedVariables.rgba2.r = r
							EchoExperience.savedVariables.rgba2.g = g
							EchoExperience.savedVariables.rgba2.b = b
							EchoExperience.savedVariables.rgba2.a = a
						end,

            width = "half",	--or "half" (optional)
        },
		[13] = {
            type = "checkbox",
            name = "Looted Items",
            tooltip = "Report? on or off.",
            getFunc = function() return EchoExperience.savedVariables.showLoot end,
            setFunc = function(value)
						EchoExperience.savedVariables.showLoot = value
						EchoExperience.SetupLootGainsEvents(false)
					end,
            width = "half",	--or "half" (optional)
        },
		[14] = {
            type = "checkbox",
            name = "Show other group member's Looted items?",
            tooltip = "Verbose reporting if experience is on?",
            getFunc = function() return EchoExperience.savedVariables.groupLoot end,
            setFunc = function(value)
						EchoExperience.savedVariables.groupLoot = value
					end,
            width = "half",	--or "half" (optional)
        },
		[15] = {
            type = "header",
            --title = "My Title",	--(optional)
            text = "Dev. Options",
            width = "full",	--or "half" (optional)
        },
		[16] = {
            type = "checkbox",
            name = "Debug",
            tooltip = "Debug on or off.",
            getFunc = function() return EchoExperience.savedVariables.debug end,
            setFunc = function(value) EchoExperience.savedVariables.debug = value end,
            width = "half",	--or "half" (optional)
        },
    }
    LAM:RegisterOptionControls(EchoExperience.menuName, optionsTable)
end