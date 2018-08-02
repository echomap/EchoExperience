-- Every variable must start with this addon's unique ID, as each is a global.
local localization_strings = {

    SI_ECHOEXP_MESSAGE = " c'est actif!",
	SI_ECHOEXP_GAIN    = "You gained ",

	--<<1>> is itemname
    SI_ECHOLOOT_YOU_GAIN_1  = "You looted <<1>>.",
	SI_ECHOLOOT_YOU_PICK_1  = "You acquired <<1>>.",
	SI_ECHOLOOT_YOU_QUEST_1 = "You looted(quest) <<1>>.",

	--<<1>> is itemname
	--<<2>> is quantity
    SI_ECHOLOOT_YOU_GAIN_2  = "You looted <<2>>x <<1>>.",
	SI_ECHOLOOT_YOU_PICK_2  = "You acquired <<2>>x <<1>>.",
	SI_ECHOLOOT_YOU_QUEST_2 = "You looted(quest) <<1>>.",

	--<<1>> is who looted
	--<<2>> is itemname
    SI_ECHOLOOT_OTHER_GAIN_1  = "<<1>> looted <<2>>.",
	SI_ECHOLOOT_OTHER_PICK_1  = "<<1>> acquired <<2>>.",
	SI_ECHOLOOT_OTHER_QUEST_1 = "<<1>> looted(quest) <<2>>.",

	--<<1>> is who looted
	--<<2>> is itemname
	--<<3>> is quantity
    SI_ECHOLOOT_OTHER_GAIN_2  = "<<1>> looted <<3>>x <<2>>.",
	SI_ECHOLOOT_OTHER_PICK_2  = "<<1>> acquired <<3>>x <<2>>.",
	SI_ECHOLOOT_OTHER_QUEST_2 = "<<1>> looted(quest) <<2>>.",

    -- Keybindings.
    SI_BINDING_NAME_NEWADDON_DISPLAY = "Display EchoExperience",

}

for stringId, stringValue in pairs(localization_strings) do
	ZO_CreateStringId(stringId, stringValue)
	SafeAddVersion(stringId, 1)
end