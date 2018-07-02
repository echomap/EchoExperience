-- Every variable must start with this addon's unique ID, as each is a global.
local localization_strings = {
    SI_ECHOEXP_MESSAGE = " is active!",
    SI_ECHOEXP_GAIN    ="You gained ",
    -- Keybindings.
    SI_BINDING_NAME_NEWADDON_DISPLAY = "Display EchoExperience",
}

for stringId, stringValue in pairs(localization_strings) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end