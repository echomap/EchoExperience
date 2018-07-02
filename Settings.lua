-- Settings menu.
function EchoExperience.LoadSettings()
    local LAM = LibStub("LibAddonMenu-2.0")

    local panelData = {
        type = "panel",
        name = EchoExperience.menuDisplayName,
        displayName = EchoExperience.Colorize(EchoExperience.menuName),
        author = EchoExperience.Colorize(EchoExperience.author, "AAF0BB"),
        -- version = EchoExperience.Colorize(EchoExperience.version, "AA00FF"),
        slashCommand = "/EchoExperience",
        registerForRefresh = true,
        registerForDefaults = true,
    }
    LAM:RegisterAddonPanel(EchoExperience.menuName, panelData)

    local optionsTable = {
        [1] = {
            type = "header",
            name = "My Header",
            width = "full",	--or "half" (optional)
        },
        [2] = {
            type = "description",
            --title = "My Title",	--(optional)
            title = nil,	--(optional)
            text = "My description text to display.",
            width = "full",	--or "half" (optional)
        },
        [3] = {
            type = "dropdown",
            name = "Window Dropdown",
            tooltip = "Dropdown's tooltip text.",
            choices = {"1", "2", "3"},
            getFunc = function() return "1" end,
            setFunc = function(var) print(var) end,
            width = "half",	--or "half" (optional)
            warning = "Will need to reload the UI.",	--(optional)
        },
        [4] = {
            type = "dropdown",
            name = "Tab Dropdown",
            tooltip = "Dropdown's tooltip text.",
            choices = {"1", "2", "3"},
            getFunc = function() return "1" end,
            setFunc = function(var) print(var) end,
            width = "half",	--or "half" (optional)
        },
	[5] = {
                    type = "checkbox",
                    name = "Debug",
                    tooltip = "Debug on or off.",
                    getFunc = function() return true end,
                    setFunc = function(value) d(value) end,
                    width = "half",	--or "half" (optional)
        },
        [6] = {
                    type = "colorpicker",
                    name = "My Color Picker",
                    tooltip = "Color Picker's tooltip text.",
                    getFunc = function() return 1, 0, 0, 1 end,	--(alpha is optional)
                    setFunc = function(r,g,b,a) print(r, g, b, a) end,	--(alpha is optional)
                    width = "half",	--or "half" (optional)
                    warning = "warning text",
        },
        [7] = {
            type = "texture",
            image = "EsoUI\\Art\\ActionBar\\abilityframe64_up.dds",
            imageWidth = 64,	--max of 250 for half width, 510 for full
            imageHeight = 64,	--max of 100
            tooltip = "Image's tooltip text.",	--(optional)
            width = "half",	--or "half" (optional)
        },
    }
    LAM:RegisterOptionControls(EchoExperience.menuName, optionsTable)
end