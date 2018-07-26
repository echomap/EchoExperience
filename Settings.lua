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
            type = "description",
            --title = "My Title",	--(optional)
            title = nil,	--(optional)
            text = "Output Experience gains as text to a specified chat window/tab."..
					"  Slashcommands are: /echoexp [debug/testoutput/tab #/window $]",
            width = "full",	--or "half" (optional)
        },
        [3] = {
            type = "dropdown",
            name = "Window Dropdown",
            tooltip = "Dropdown's tooltip text.",
            choices = {"1", "2", "3","4"},
            getFunc = function() return tostring(EchoExperience.window) end,
            setFunc = function(var) EchoExperience.window = tonumber(var) end,
            width = "half",	--or "half" (optional)
        },
        [4] = {
            type = "dropdown",
            name = "Tab Dropdown",
            tooltip = "Dropdown's tooltip text.",
            choices = {"1", "2", "3", "4", "5", "6"},
            getFunc = function() return tostring(EchoExperience.tab)   end,
            setFunc = function(var) EchoExperience.tab = tonumber(var) end,
            width = "half",	--or "half" (optional)
        },
        [5] = {
            type = "colorpicker",
            name = "EXP Chat Color",
            tooltip = "What Color to use for EXP text.",
            getFunc = function() return
							EchoExperience.rgba.r,
							EchoExperience.rgba.g,
							EchoExperience.rgba.b,
							EchoExperience.rgba.a
						end,	--(alpha is optional)
            setFunc = 	function(r,g,b,a)
							--(alpha is optional)
							--d(r, g, b, a)
							local c = ZO_ColorDef:New(r,g,b,a)
							--c:Colorize(text)
							EchoExperience.rgba = {}
							EchoExperience.rgba.r = r
							EchoExperience.rgba.g = g
							EchoExperience.rgba.b = b
							EchoExperience.rgba.a = a
						end,

            width = "half",	--or "half" (optional)
        },
        [6] = {
            type = "colorpicker",
            name = "LOOT Chat Color",
            tooltip = "What Color to use for LOOT text.",
            getFunc = function() return
							EchoExperience.rgba2.r,
							EchoExperience.rgba2.g,
							EchoExperience.rgba2.b,
							EchoExperience.rgba2.a
						end,	--(alpha is optional)
            setFunc = 	function(r,g,b,a)
							--(alpha is optional)
							--d(r, g, b, a)
							local c = ZO_ColorDef:New(r,g,b,a)
							--c:Colorize(text)
							EchoExperience.rgba2 = {}
							EchoExperience.rgba2.r = r
							EchoExperience.rgba2.g = g
							EchoExperience.rgba2.b = b
							EchoExperience.rgba2.a = a
						end,

            width = "half",	--or "half" (optional)
        },
		[7] = {
            type = "checkbox",
            name = "Experience",
            tooltip = "Report? on or off.",
            getFunc = function() return EchoExperience.showExp end,
            setFunc = function(value) EchoExperience.showExp = value end,
            width = "half",	--or "half" (optional)
        },
		[8] = {
            type = "checkbox",
            name = "Looted Items",
            tooltip = "Report? on or off.",
            getFunc = function() return EchoExperience.showLoot end,
            setFunc = function(value)
						EchoExperience.showLoot = value
						if (EchoExperience.showLoot) then
							EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."LootReceived",	EVENT_LOOT_RECEIVED, EchoExperience.OnLootReceived)
						else
							EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."LootReceived",	EVENT_LOOT_RECEIVED, EchoExperience.OnLootReceived)
						end
					end,
            width = "half",	--or "half" (optional)
        },
		[9] = {
            type = "checkbox",
            name = "Debug",
            tooltip = "Debug on or off.",
            getFunc = function() return EchoExperience.debug end,
            setFunc = function(value) EchoExperience.debug = value end,
            width = "half",	--or "half" (optional)
        },

    }
    LAM:RegisterOptionControls(EchoExperience.menuName, optionsTable)
end