-- Every variable must start with this addon's unique ID, as each is a global.
local localization_strings = {
    SI_ECHOEXP_MESSAGE = " is active!",
	SI_ECHOEXP_EXPGAINS_SHOW = "EchoExp is showing Experience Gains",
	SI_ECHOEXP_EXPGAINS_HIDE = "EchoExp is no longer showing Experience Gains",
	SI_ECHOEXP_LOOTGAINS_SHOW = "EchoExp is showing Loot Gains",
	SI_ECHOEXP_LOOTGAINS_HIDE = "EchoExp is no longer showing Loot Gains",

	--SKILL
	--SI_ECHOEXP_SKILL_SKY  = "You absorbed a skyshard <<1>> of <<2>>."
	--SI_ECHOEXP_SKILL_GAIN = "You gained a skill point!"
	--SI_ECHOEXP_SKILL_GAIN = "You gained a skill point!"

	--EXP
	SI_ECHOEXP_XP_GAIN       = "You gained <<1>> experience.",
	SI_ECHOEXP_XP_SKILL_GAIN = "Gained <<1>>xp in [<<2>>] (<<3>>/<<4>>) need <<5>>xp",
	SI_ECHOEXP_CP_UNLOCKED   = "You unlocked Champion points!",
	SI_ECHOEXP_DISCOVERY     = "You discovered, <<1>>.",

	SI_ECHOEXP_AP_GAIN       = "You gained <<1>> AP.",
	SI_ECHOEXP_AP_LOSS       = "You spent <<1>> AP.",

	--WORKING ON TODO
	SI_ECHOEXP_SKY_1         = "You absorbed a skyshard! (<<1>> of <<2>>).",
	SI_ECHOEXP_SKY_2         = "You gained a skill point! (<<1>>).",

	--LOOT
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