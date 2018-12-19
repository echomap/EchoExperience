-- Every variable must start with this addon's unique ID, as each is a global.
local localization_strings = {
    SI_ECHOEXP_MESSAGE = " is active!",

	SI_ECHOEXP_EXPGAINS_SHOW   = "EchoExp is showing Experience Gains",
	SI_ECHOEXP_EXPGAINS_HIDE   = "EchoExp is no longer showing Experience Gains",
	SI_ECHOEXP_LOOTGAINS_SHOW  = "EchoExp is showing Loot Gains",
	SI_ECHOEXP_LOOTGAINS_HIDE  = "EchoExp is not showing Loot Gains",
  SI_ECHOEXP_LOOTGAINSE_SHOW = "EchoExp is showing Extended Loot Gains",
  SI_ECHOEXP_LOOTGAINSE_HIDE = "EchoExp is not showing Extended Loot Gains",

  SI_ECHOEXP_GUILD_EVENT_REG   = "Registered for Guild events",
  SI_ECHOEXP_GUILD_EVENT_UNREG = "Unregistered for Guild events",

  SI_ECHOEXP_KILL_MOB = "You killed a <<1>>",
  
	--SKILL
	--SI_ECHOEXP_SKILL_SKY  = "You absorbed a skyshard <<1>> of <<2>>."
	--SI_ECHOEXP_SKILL_GAIN = "You gained a skill point!"
	--SI_ECHOEXP_SKILL_GAIN = "You gained a skill point!"

	--EXP
	SI_ECHOEXP_XP_GAIN       = "You gained <<1>> experience.",
	SI_ECHOEXP_XP_SKILL_GAIN = "Gained <<1>>xp in [<<2>>] (<<3>>/<<4>>) need <<5>>xp",
	SI_ECHOEXP_CP_UNLOCKED   = "You unlocked Champion points!",
	SI_ECHOEXP_CP_EARNED     = "You gained <<1>>cp.",
	SI_ECHOEXP_DISCOVERY     = "You discovered: <<1>>.",
	SI_ECHOEXP_SKILLINE      = "You learned the skillline: <<1>>",

	SI_ECHOEXP_AP_GAIN       = "You gained <<1>> AP.",
	SI_ECHOEXP_AP_LOSS       = "You spent <<1>> AP.",

	--WORKING ON TODO
	SI_ECHOEXP_SKY_1         = "You absorbed a skyshard! (<<1>> of <<2>>).",
	SI_ECHOEXP_SKY_2         = "You gained a skill point! (<<1>>).",

  SI_ECHOEXP_GUILD_1       = "eventCode: <<1>>, guildID: <<2>>, playerName: <<3>>, prevStatus: <<4>>, curStatus: <<5>> .",
  SI_ECHOEXP_GUILD_2       = "<<2>> Logged IN at <<5>> (<<6>>)",
  SI_ECHOEXP_GUILD_3       = "<<2>> Logged OUT at <<5>> (<<6>>)",
  
	--LOOT
	--<<1>> is itemname
	--<<2>> is quantity
	--<<3>> is traitname
  SI_ECHOLOOT_YOU_GAIN_1  = "You looted: <<1>>.",
	SI_ECHOLOOT_YOU_PICK_1  = "You acquired: <<1>>.",
	SI_ECHOLOOT_YOU_QUEST_1 = "You looted: <<1>> (quest item).",
  
  SI_ECHOLOOT_YOU_GAIN_3  = "You looted: <<1>> (*<<3>>*).",
	SI_ECHOLOOT_YOU_PICK_3  = "You acquired: <<1>> (*<<3>>*).",
	SI_ECHOLOOT_YOU_QUEST_3 = "You looted: <<1>> (*<<3>>*) (quest item).",

  SI_ECHOLOOT_YOU_GAIN_2  = "You looted: <<2>>x <<1>>.",
	SI_ECHOLOOT_YOU_PICK_2  = "You acquired: <<2>>x <<1>>.",
	SI_ECHOLOOT_YOU_QUEST_2 = "You looted: <<1>> (quest item).",
  
  SI_ECHOLOOT_YOU_GAIN_4  = "You looted: <<2>>x <<1>> (*<<3>>*).",
	SI_ECHOLOOT_YOU_PICK_4  = "You acquired: <<2>>x <<1>> (*<<3>>*).",
	SI_ECHOLOOT_YOU_QUEST_4 = "You looted: <<2>>x <<1>> (*<<3>>*) (quest item).",
  --TEST2
  SI_ECHOLOOT2_YOU_GAIN_1   = "[Recieved] <<1>>.",
  SI_ECHOLOOT2_YOU_QUEST_1  = "[Recieved] quest-item: <<1>>.",
  SI_ECHOLOOT2_YOU_GAIN_2   = "[Recieved] <<2>>x <<1>>.",
  SI_ECHOLOOT2_YOU_QUEST_2  = "[Recieved] quest-item: <<2>>x <<1>>.",  
  SI_ECHOLOOT2_YOU_GAIN_3   = "[Recieved] <<1>> (*<<3>>*).",
  SI_ECHOLOOT2_YOU_QUEST_3  = "[Recieved] quest-item: <<1>> (*<<3>>*).",  
  SI_ECHOLOOT2_YOU_GAIN_4   = "[Recieved] <<2>>x <<1>> (*<<3>>*).",
  SI_ECHOLOOT2_YOU_QUEST_4  = "[Recieved] quest-item: <<2>>x <<1>> (*<<3>>*).",    
  --TEST2
	--<<1>> is who looted
	--<<2>> is itemname
  SI_ECHOLOOT_OTHER_GAIN_1  = "<<1>> looted: <<2>>.",
	SI_ECHOLOOT_OTHER_PICK_1  = "<<1>> acquired: <<2>>.",
	SI_ECHOLOOT_OTHER_QUEST_1 = "<<1>> looted: <<2>> (quest item).",
	--<<1>> is who looted
	--<<2>> is itemname
	--<<3>> is quantity
  SI_ECHOLOOT_OTHER_GAIN_2  = "<<1>> looted: <<3>>x <<2>>.",
	SI_ECHOLOOT_OTHER_PICK_2  = "<<1>> acquired: <<3>>x <<2>>.",
	SI_ECHOLOOT_OTHER_QUEST_2 = "<<1>> looted: <<2>> (quest item).",

  --Extended Loot info
  --TODO use GetChatFontSize()  to get size
  SI_ECHOLOOT_BUYBACK_1 = "You buyback |t14:14:<<1>>|t <<2>>",
  SI_ECHOLOOT_BUYBACK_2 = "You buyback |t14:14:<<1>>|t <<2>> x<<3>>",
  SI_ECHOLOOT_SELL_1 = "You sell |t14:14:<<1>>|t <<2>>",
  SI_ECHOLOOT_SELL_2 = "You sell |t14:14:<<1>>|t <<2>> x<<3>>",
  SI_ECHOLOOT_BUY_1 = "You buy |t12:12:<<1>>|t <<2>>",
  SI_ECHOLOOT_BUY_2 = "You buy |t12:12:<<1>>|t <<2>> x<<3>>",
  SI_ECHOLOOT_CURRENCY_1 = "You spend <<3>> |t12:12:<<1>>|t <<2>>", 
  SI_ECHOLOOT_CURRENCY_2 = "You gain <<3>> |t12:12:<<1>>|t <<2>>", 
  
  SI_ECHOLOOT_RECEIVE_1 = "You receive |t12:12:<<1>>|t <<2>>",
  SI_ECHOLOOT_RECEIVE_2 = "You receive |t12:12:<<1>>|t <<2>> x<<3>>",
  SI_ECHOLOOT_LOSE_1 = "You lose |t12:12:<<1>>|t <<2>>",
  SI_ECHOLOOT_LOSE_2 = "You lose|t12:12:<<1>>|t <<2>> x<<3>>",
}

for stringId, stringValue in pairs(localization_strings) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end