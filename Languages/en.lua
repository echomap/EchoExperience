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
  
  SI_ECHOEXP_QUEST_ACCEPT   = "You accepted the quest [<<1>>]",
  SI_ECHOEXP_QUEST_COMPLETE = "You completed the quest [<<1>>]",
  
	--EXP
	SI_ECHOEXP_XP_GAIN         = "You gained <<1>> experience.",
	SI_ECHOEXP_XP_SKILL_GAIN_1 = "Gained <<1>>xp in [<<2>>] (<<3>>/<<4>>) need <<5>>xp",
	SI_ECHOEXP_XP_SKILL_GAIN_2 = "Gained <<1>>xp in [<<2>>]",
	SI_ECHOEXP_CP_UNLOCKED     = "You unlocked Champion points!",
	SI_ECHOEXP_CP_EARNED       = "You gained <<1>>cp.",
	SI_ECHOEXP_DISCOVERY       = "You discovered: <<1>>.",
	SI_ECHOEXP_SKILLINE        = "You learned the skillline: <<1>>",

	SI_ECHOEXP_AP_GAIN       = "You gained <<1>> AP.",
	SI_ECHOEXP_AP_LOSS       = "You spent <<1>> AP.",

	SI_ECHOEXP_SKY_1         = "You absorbed a skyshard! (<<1>> of <<2>>).",
	SI_ECHOEXP_SKY_2         = "You gained a skill point! (<<1>>).",

	SI_ECHOEXP_GUILD_1       = "eventCode: <<1>>, guildID: <<2>>, playerName: <<3>>, prevStatus: <<4>>, curStatus: <<5>> .",
	SI_ECHOEXP_GUILD_2       = "<<4>> Login at <<2>> (<<3>>)",
	SI_ECHOEXP_GUILD_3       = "<<4>> Logout at <<2>> (<<3>>)",
    
  -- <<1>>(guildID), <<2>>GuildName, <<3>>playerName, <<4>>ZO_FormatClockTime(), <<5>>pLink )
	SI_ECHOEXP_GUILDADD_1    = "[<<5>>] Joined (<<2>>) at <<4>>!",
  --<<1>> guildID, <<2>>guild, <<3>>characterName, <<4>>ZO_FormatClockTime() , <<5>>pLink
	SI_ECHOEXP_GUILDREM_1    = "[<<5>>] Left (<<2>) at <<4>>!",  
  
	--LOOT
	--<<1>>icon, <<2>>itemName, <<3>>quantity, <<4>>traitName 
  SI_ECHOLOOT_YOU_GAIN_1  = "You looted |t14:14:<<1>>|t <<2>> <<4>>",
	SI_ECHOLOOT_YOU_PICK_1  = "You acquired |t14:14:<<1>>|t <<2>>.",
	SI_ECHOLOOT_YOU_QUEST_1 = "You looted |t14:14:<<1>>|t <<2>> (QuestItem)",
	
	SI_ECHOLOOT_YOU_GAIN_2  = "You looted |t14:14:<<1>>|t <<2>> x<<3>>",
	SI_ECHOLOOT_YOU_PICK_2  = "You acquired |t14:14:<<1>>|t <<2>>  x<<3>>.",
	SI_ECHOLOOT_YOU_QUEST_2 = "You looted |t14:14:<<1>>|t <<2>> (quest item).",

	SI_ECHOLOOT_YOU_GAIN_3  = "You looted |t14:14:<<1>>|t <<2>> (*<<4>>*)*<<5>>*.",
	SI_ECHOLOOT_YOU_PICK_3  = "You acquired |t14:14:<<1>>|t <<2>>(*<<4>>*).",
	SI_ECHOLOOT_YOU_QUEST_3 = "You looted |t14:14:<<1>>|t <<2>> (*<<4>>*) (quest item).",
		
	SI_ECHOLOOT_YOU_GAIN_4  = "You looted: <<3>>x |t14:14:<<1>>|t <<2>> (*<<4>>*).",
	SI_ECHOLOOT_YOU_PICK_4  = "You acquired: <<3>>x |t14:14:<<1>>|t <<2>> (*<<4>>*).",
	SI_ECHOLOOT_YOU_QUEST_4 = "You looted: <<3>>x |t14:14:<<1>>|t <<2>> (*<<4>>*) (quest item).",

	--<<1>>receivedBy, <<2>>icon, <<3>>itemName, <<4>>quantity, <<5>>extraInfo 
  SI_ECHOLOOT_OTHER_GAIN_1  = "<<1>> looted |t14:14:<<2>>|t <<3>> <<5>>",
	SI_ECHOLOOT_OTHER_PICK_1  = "<<1>> acquired |t14:14:<<2>>|t <<3>> <<5>>",
	SI_ECHOLOOT_OTHER_QUEST_1 = "<<1>> acquired |t14:14:<<2>>|t <<3>> (quest item).",
		
	--<<1>>receivedBy, <<2>>icon, <<3>>itemName, <<4>>quantity, <<5>>traitName 
	SI_ECHOLOOT_OTHER_GAIN_2  = "<<1>> looted |t14:14:<<2>>|t <<3>> x<<4>> <<5>>",
	SI_ECHOLOOT_OTHER_PICK_2  = "<<1>> acquired |t14:14:<<2>>|t <<3>> x<<4>> <<5>>",
	SI_ECHOLOOT_OTHER_QUEST_2 = "<<1>> looted |t14:14:<<2>>|t <<3>> (quest item).",
	
	--Extended Loot info
	SI_ECHOLOOT_BUYBACK_1  = "You buyback |t14:14:<<1>>|t <<2>>",
	SI_ECHOLOOT_BUYBACK_2  = "You buyback |t14:14:<<1>>|t <<2>> x<<3>>",
	SI_ECHOLOOT_SELL_1     = "You sell |t14:14:<<1>>|t <<2>>",
	SI_ECHOLOOT_SELL_2     = "You sell |t14:14:<<1>>|t <<2>> x<<3>>",
	SI_ECHOLOOT_BUY_1      = "You buy |t12:12:<<1>>|t <<2>>",
	SI_ECHOLOOT_BUY_2      = "You buy |t12:12:<<1>>|t <<2>> x<<3>>",
	SI_ECHOLOOT_CURRENCY_1 = "You spend <<3>> |t12:12:<<1>>|t <<2>>", 
	SI_ECHOLOOT_CURRENCY_2 = "You gain <<3>> |t12:12:<<1>>|t <<2>>", 
  SI_ECHOLOOT_CURRENCY_BANK_1 = "Bank withdrawl: <<3>> |t12:12:<<1>>|t <<2>>", 
  SI_ECHOLOOT_CURRENCY_BANK_2 = "You banked: <<3>> |t12:12:<<1>>|t <<2>>", 

  --1 icon, 2 itemLink, 3 stackCountChange, 4 traitName )
	SI_ECHOLOOT_RECEIVE_1 = "You receive |t14:14:<<1>>|t <<2>>",
	SI_ECHOLOOT_RECEIVE_2 = "You receive |t14:14:<<1>>|t <<2>> x<<3>>",
	SI_ECHOLOOT_RECEIVE_3 = "You receive |t14:14:<<1>>|t <<2>> (<<4>>)",
	SI_ECHOLOOT_RECEIVE_4 = "You receive |t14:14:<<1>>|t <<2>> x<<3>> (<<4>>)",
	SI_ECHOLOOT_LOSE_1    = "You lose |t14:14:<<1>>|t <<2>>",
	SI_ECHOLOOT_LOSE_2    = "You lose|t14:14:<<1>>|t <<2>> x<<3>>",
}

--TODO use GetChatFontSize()  to get size
--https://wiki.esoui.com/Text_Formatting
  
for stringId, stringValue in pairs(localization_strings) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end