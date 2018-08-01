-- Every variable must start with this addon's unique ID, as each is a global.
local localization_strings = {
    SI_ECHOEXP_MESSAGE = " is active!",
	SI_ECHOEXP_GAIN    = "You gained ",

    SI_ECHOLOOT_YOU_GAIN_1  = "You looted %s.",
	SI_ECHOLOOT_YOU_PICK_1  = "You acquired %s.",
	SI_ECHOLOOT_YOU_QUEST_1 = "You looted(quest) %s.",

    SI_ECHOLOOT_YOU_GAIN_2  = "You looted %s x%s.",
	SI_ECHOLOOT_YOU_PICK_2  = "You acquired %s x%s.",
	SI_ECHOLOOT_YOU_QUEST_2 = "You looted(quest) %s.",

    SI_ECHOLOOT_OTHER_GAIN  = "%s looted %s.",
	SI_ECHOLOOT_OTHER_PICK  = "%s acquired %s.",
	SI_ECHOLOOT_OTHER_QUEST = "%s looted(quest) %s.",

    SI_ECHOLOOT_OTHER_GAIN_2  = "%s looted %sx %s.",
	SI_ECHOLOOT_OTHER_PICK_2  = "%s acquired %sx %s.",
	SI_ECHOLOOT_OTHER_QUEST_2 = "%s looted(quest) %s.",

    -- Keybindings.
    SI_BINDING_NAME_NEWADDON_DISPLAY = "Display EchoExperience",
}

for stringId, stringValue in pairs(localization_strings) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end