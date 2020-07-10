-- Every variable must start with this addon's unique ID, as each is a global.
local localization_strings = {
  SI_ECHOEXP_MESSAGE = " is active!",

  ------------------------------
  -- 
	SI_ECHOEXP_EXPGAINS_SHOW   = "EchoExp is showing Experience Gains",
	SI_ECHOEXP_EXPGAINS_HIDE   = "EchoExp is no longer showing Experience Gains",
	SI_ECHOEXP_LOOTGAINS_SHOW  = "EchoExp is showing Loot Gains",
	SI_ECHOEXP_LOOTGAINS_HIDE  = "EchoExp is not showing Loot Gains",
	SI_ECHOEXP_LOOTGAINSE_SHOW = "EchoExp is showing Extended Loot Gains",
	SI_ECHOEXP_LOOTGAINSE_HIDE = "EchoExp is not showing Extended Loot Gains",

  ------------------------------
  -- 
	SI_ECHOEXP_GUILD_EVENT_REG   = "Registered for Guild events",
	SI_ECHOEXP_GUILD_EVENT_UNREG = "Unregistered for Guild events",
  
  ------------------------------
  -- 
  SI_ECHOEXP_SETTINGS_REFRESH_TEXT    = "Refresh dropdowns",
  SI_ECHOEXP_SETTINGS_REFRESH_TOOLTIP = "Refresh dropdown Data. (Use in case things just don't look right, or on first use)",
  SI_ECHOEXP_SETTINGS_NOCONFIRM       = "No confirmation if you do this!",
  SI_ECHOEXP_SETTINGS_BTN_DELETE      = "Delete",
  SI_ECHOEXP_SETTINGS_BTN_SAVE        = "Save",
  SI_ECHOEXP_SETTINGS_TEXT_SELECT     = "Select",
  SI_ECHOEXP_SETTINGS_SAVE_TITLE      = "Save these settings",
  SI_ECHOEXP_SETTINGS_SAVE_MSG        = "Save these as settings so they can be used later?",  
  SI_ECHOEXP_SETTINGS_LOAD_TITLE      = "Load saved settings",
  SI_ECHOEXP_SETTINGS_LOAD_MSG        = "Load settings from saved profile?",
  SI_ECHOEXP_SETTINGS_IMMERSIVE       = "Immersive",
  SI_ECHOEXP_SETTINGS_BEIMMERSIVE     = "Be immersive? on or off.",
  
  SI_ECHOEXP_SETTINGS_KILLS_SHOW        = "Show kills/deaths?",
  SI_ECHOEXP_SETTINGS_KILLS_SHOW_TT     = "Show kills/deaths?",
  SI_ECHOEXP_SETTINGS_DISCOVERY_SHOW    = "Show discovered?",
  SI_ECHOEXP_SETTINGS_DISCOVERY_SHOW_TT = "Show discovered locations?",
  SI_ECHOEXP_SETTINGS_ACHIEVEMENT_SHOW    = "Show Achievments?",
  SI_ECHOEXP_SETTINGS_ACHIEVEMENT_SHOW_TT = "Show Achievments?",
  SI_ECHOEXP_SETTINGS_ACHIEVEMENTDETAIL_SHOW    = "Detailed Achievments?",
  SI_ECHOEXP_SETTINGS_ACHIEVEMENTDETAIL_SHOW_TT = "Show detailed Achievment messages?",
  
  
  SI_ECHOEXP_SETTINGS_ALPHA_NAME    = "Show Alpha events?",
  SI_ECHOEXP_SETTINGS_ALPHA_TT = "Dev Alpha?",
  
  SI_ECHOEXP_SETTINGS_SESSIONTRACK_NAME = "Keep track of data in session?",
  SI_ECHOEXP_SETTINGS_SESSIONTRACK_TT   = "Keep track of looted/kills data in session?",
  SI_ECHOEXP_SETTINGS_LIFETIMETRACK_NAME= "Keep track of data in lifetime?",
  SI_ECHOEXP_SETTINGS_LIFETIMETRACK_TT  = "Keep track of looted/kills data in lifetime?",
  
  --
  SI_ECHOEXP_SETTINGS_QUEST_SECTIONTITLE    = "Quest Options",
  SI_ECHOEXP_SETTINGS_QUEST_SECTIONNAME     = "Quest Options",
  SI_ECHOEXP_SETTINGS_QUEST_TITLE           = "Show Quest",
  SI_ECHOEXP_SETTINGS_QUEST_TOOLTIP         = "Show Quests accept/complete? on or off.",
  SI_ECHOEXP_SETTINGS_QUESTADV_TITLE        = "Quest Steps done? ",
  SI_ECHOEXP_SETTINGS_QUESTADV_TOOLTIP      = "Show Quests steps completed?",
  SI_ECHOEXP_SETTINGS_QUEST_OUTPUTS_NAME    = "Quest Output Tabs",
  SI_ECHOEXP_SETTINGS_QUEST_OUTPUTS_TOOLTIP = "Tab(s) for Quest output.",
  SI_ECHOEXP_SETTINGS_QUEST_OUTPUTS_DELETE  = "Delete selected Quest's Data!",
  
  SI_ECHOEXP_SETTINGS_QUEST_NEWOUTPUTS_TEXT = "Add new Quest output:",
  SI_ECHOEXP_SETTINGS_QUEST_NEWOUTPUTS_NAME = "Add Quest Output",
  SI_ECHOEXP_SETTINGS_QUEST_WINDOW_NAME     = "Quest Output to Window",
  SI_ECHOEXP_SETTINGS_QUEST_WINDOW_TOOLTIP  = "Window for Quest output.",
  SI_ECHOEXP_SETTINGS_QUEST_TAB_NAME        = "Quest Output Tab",
  SI_ECHOEXP_SETTINGS_QUEST_TAB_TOOLTIP     = "Tab for Quest output.",
  SI_ECHOEXP_SETTINGS_QUEST_COLOR_TEXT      = "Quest Output Color",
  SI_ECHOEXP_SETTINGS_QUEST_COLOR_TOOLTIP   = "What Color to use for Quest text.",
  SI_ECHOEXP_SETTINGS_QUEST_NEWOUTPUTS_SAVE = "Save selected Quest chat Data!",
  --
  SI_ECHOEXP_SETTINGS_EXP_SECTIONTITLE      = "Experience Options",
  SI_ECHOEXP_SETTINGS_EXP_SECTIONNAME       = "Experience Options",
  SI_ECHOEXP_SETTINGS_EXP_TITLE             = "Experience",
  SI_ECHOEXP_SETTINGS_EXP_TOOLTIP           = "Report? on or off.",
  
  SI_ECHOEXP_SETTINGS_EXP_TY12_TEXT         = "Pick one or more of these Views or nothing will print for exp (where the 'on off' above shuts every exp option off)",
  SI_ECHOEXP_SETTINGS_EXP_TY1_TITLE         = "a) Use Plain View?",
  SI_ECHOEXP_SETTINGS_EXP_TY1_TOOLTIP       = "Use the reporting where it just prints the experience earned without source",
  SI_ECHOEXP_SETTINGS_EXP_TY2_TITLE         = "b) Use Combined View?",
  SI_ECHOEXP_SETTINGS_EXP_TY2_TOOLTIP       = "Use the reporting where it says the type of the action it is reporting on? (ie: You killed something - 10 exp.) instead of the general way: (ie: You gained 10 experience.)",
  SI_ECHOEXP_SETTINGS_EXP_VERB_NAME             = "Verbose Experience",
  SI_ECHOEXP_SETTINGS_EXP_VERB_TOOLTIP          = "Show more Verbose reporting, if experience is on? (Show % have and need)",
  SI_ECHOEXP_SETTINGS_EXP_SKILLLINE_TITLE       = "Show Skill Experience",
  SI_ECHOEXP_SETTINGS_EXP_SKILLLINE_TOOLTIP     = "Report on skill lines Rank Gains? (if experience is on)",
  SI_ECHOEXP_SETTINGS_EXP_VERBSKILLLINE_TITLE   = "Show Verbose Skill Experience",
  SI_ECHOEXP_SETTINGS_EXP_VERBSKILLLINE_TOOLTIP = "Report on all skill lines gains? (if experience is on)",
  SI_ECHOEXP_SETTINGS_EXP_OUTPUTS_NAME    = "Exp Output Tabs",
  SI_ECHOEXP_SETTINGS_EXP_OUTPUTS_TOOLTIP = "Tab(s) for Exp output.",
  SI_ECHOEXP_SETTINGS_EXP_OUTPUTS_DELETE  = "Delete selected Exp's Data!",
  
  SI_ECHOEXP_SETTINGS_EXP_NEWOUTPUTS_TEXT = "Add new Experience output:",
  SI_ECHOEXP_SETTINGS_EXP_NEWOUTPUTS_NAME = "Add Experience Output",
  SI_ECHOEXP_SETTINGS_EXP_WINDOW_NAME     = "Exp Output to Window",
  SI_ECHOEXP_SETTINGS_EXP_WINDOW_TOOLTIP  = "Window for Exp output.",
  SI_ECHOEXP_SETTINGS_EXP_TAB_NAME        = "Exp Output Tab",
  SI_ECHOEXP_SETTINGS_EXP_TAB_TOOLTIP     = "Tab for Exp output.",
  SI_ECHOEXP_SETTINGS_EXP_COLOR_TEXT      = "Exp Output Color",
  SI_ECHOEXP_SETTINGS_EXP_COLOR_TOOLTIP   = "What Color to use for Exp text.",
  SI_ECHOEXP_SETTINGS_EXP_NEWOUTPUTS_SAVE = "Save selected Exp chat Data!",
  --
  SI_ECHOEXP_SETTINGS_LOOT_SECTIONTITLE    = "Loot Options",
  SI_ECHOEXP_SETTINGS_LOOT_SECTIONNAME     = "Loot Options",
  SI_ECHOEXP_SETTINGS_LOOT_TITLE           = "Looted Items",
  SI_ECHOEXP_SETTINGS_LOOT_TOOLTIP         = "Report? on or off.",
  SI_ECHOEXP_SETTINGS_LOOT_VERB_NAME       = "Verbose reporting of Looted items?",
  SI_ECHOEXP_SETTINGS_LOOT_VERB_TOOLTIP    = "Show other types of item events? (researched/trashed/etc)",
  SI_ECHOEXP_SETTINGS_LOOT_GROUP_TITLE     = "Show other group member's Looted items?",
  SI_ECHOEXP_SETTINGS_LOOT_GROUP_TOOLTIP   = "Verbose reporting if Looted is on?",
  SI_ECHOEXP_SETTINGS_LOOT_OUTPUTS_NAME    = "Loot Output Tabs",
  SI_ECHOEXP_SETTINGS_LOOT_OUTPUTS_TOOLTIP = "Tab(s) for Loot output.",
  SI_ECHOEXP_SETTINGS_LOOT_OUTPUTS_DELETE  = "Delete selected Loot's Data!",
  
  SI_ECHOEXP_SETTINGS_LOOT_NEWOUTPUTS_TEXT = "Add new Loot output:",
  SI_ECHOEXP_SETTINGS_LOOT_NEWOUTPUTS_NAME = "Add Loot Output",
  SI_ECHOEXP_SETTINGS_LOOT_WINDOW_NAME     = "Loot Output to Window",
  SI_ECHOEXP_SETTINGS_LOOT_WINDOW_TOOLTIP  = "Window for Loot output.",
  SI_ECHOEXP_SETTINGS_LOOT_TAB_NAME        = "Loot Output Tab",
  SI_ECHOEXP_SETTINGS_LOOT_TAB_TOOLTIP     = "Tab for Loot output.",
  SI_ECHOEXP_SETTINGS_LOOT_COLOR_TEXT      = "Loot Output Color",
  SI_ECHOEXP_SETTINGS_LOOT_COLOR_TOOLTIP   = "What Color to use for Loot text.",
  SI_ECHOEXP_SETTINGS_LOOT_NEWOUTPUTS_SAVE = "Save selected Loot chat Data!",
  --
  SI_ECHOEXP_SETTINGS_GUILD_SECTIONTITLE    = "Guild Options",
  SI_ECHOEXP_SETTINGS_GUILD_SECTIONNAME     = "Guild Options",
  SI_ECHOEXP_SETTINGS_GUILD_LOGON_NAME      = "Show Guild LogOns?",
  SI_ECHOEXP_SETTINGS_GUILD_LOGON_TOOLTIP   = "Report? on or off.",
  SI_ECHOEXP_SETTINGS_GUILD_LOGOFF_NAME     = "Show Guild LogOffs?",
  SI_ECHOEXP_SETTINGS_GUILD_LOGOFF_TOOLTIP  = "Report? on or off.",
  SI_ECHOEXP_SETTINGS_GUILD_G1 = "G1",
  SI_ECHOEXP_SETTINGS_GUILD_G2 = "G2",
  SI_ECHOEXP_SETTINGS_GUILD_G3 = "G3",
  SI_ECHOEXP_SETTINGS_GUILD_G4 = "G4",
  SI_ECHOEXP_SETTINGS_GUILD_G5 = "G5",
  SI_ECHOEXP_SETTINGS_GUILD_OUTPUTS_NAME    = "Guild Output Tabs",
  SI_ECHOEXP_SETTINGS_GUILD_OUTPUTS_TOOLTIP = "Tab(s) for Guild output.",
  SI_ECHOEXP_SETTINGS_GUILD_OUTPUTS_DELETE  = "Delete selected Guild's Data!",
  
  SI_ECHOEXP_SETTINGS_GUILD_NEWOUTPUTS_TEXT = "Add new Guild output:",
  SI_ECHOEXP_SETTINGS_GUILD_NEWOUTPUTS_NAME = "Add Guild Output",
  SI_ECHOEXP_SETTINGS_GUILD_WINDOW_NAME     = "Guild Output to Window",
  SI_ECHOEXP_SETTINGS_GUILD_WINDOW_TOOLTIP  = "Window for Guild output.",
  SI_ECHOEXP_SETTINGS_GUILD_TAB_NAME        = "Guild Output Tab",
  SI_ECHOEXP_SETTINGS_GUILD_TAB_TOOLTIP     = "Tab for Guild output.",
  SI_ECHOEXP_SETTINGS_GUILD_COLOR_TEXT      = "Guild Output Color",
  SI_ECHOEXP_SETTINGS_GUILD_COLOR_TOOLTIP   = "What Color to use for Guild text.",
  SI_ECHOEXP_SETTINGS_GUILD_NEWOUTPUTS_SAVE = "Save selected Guild chat Data!",
  --
  
  ------------------------------
  -- 
	SI_ECHOEXP_KILL_MOB = "You killed a <<1>>",
  SI_ECHOEXP_KILL_LB1 = "You have killed someone listed in the Litany of Blood!",
  SI_ECHOEXP_KILL_LB0 = "You have killed someone.",
  
  --lookupExpSourceText
  SI_ECHOEXP_LEST_GAIN = "gained exp",
  SI_ECHOEXP_LEST_ACHIEVE = "earned an achievement",
  SI_ECHOEXP_LEST_ACTION = "completed something",
  SI_ECHOEXP_LEST_AP = "gained ap",
  SI_ECHOEXP_LEST_AVA = "did AVA",
  SI_ECHOEXP_LEST_BG = "did BG",
  SI_ECHOEXP_LEST_COLLECTION = "completed a collection",
  SI_ECHOEXP_LEST_BOSSKILL = "kill a boss",
  SI_ECHOEXP_LEST_COLLECTBOOK = "collected a book",
  SI_ECHOEXP_LEST_COMMAND = "command(?)",
  SI_ECHOEXP_LEST_COMPLETEPOI = "completed a poi",
  SI_ECHOEXP_LEST_DARKANCHOR = "closed a darkanchor",
  SI_ECHOEXP_LEST_FISSURE = "closed a fissure",
  SI_ECHOEXP_LEST_DISCOVERPOI = "discovered a poi",
  SI_ECHOEXP_LEST_DRAGONKILL = "killed a dragon",
  SI_ECHOEXP_LEST_DUNGEONCHALLENGE = "dungeon challenge",
  SI_ECHOEXP_LEST_EVENT = "event",
  SI_ECHOEXP_LEST_FINESSE = "got finesse(?)",
  SI_ECHOEXP_LEST_REPUTATION = "got reputation",
  SI_ECHOEXP_LEST_GUILDREP = "got guild rep",
  SI_ECHOEXP_LEST_JUSTICESKILL = "got a justice reward",
  SI_ECHOEXP_LEST_KEEPREWARD = "got a keep reward",  
  SI_ECHOEXP_LEST_KILL = "killed something",  
  SI_ECHOEXP_LEST_LFG = "got a lfg reward",  
  SI_ECHOEXP_LEST_LOCKPICK = "sucessfuly pick a lock",  
  SI_ECHOEXP_LEST_MEDAL = "got a medal",  
  SI_ECHOEXP_LEST_NONE = "did something",  
  SI_ECHOEXP_LEST_OTHER = "did something",  
  SI_ECHOEXP_LEST_WBKILL ="kiled a boss",  
  SI_ECHOEXP_LEST_EMPEROR = "became emperor",  
  SI_ECHOEXP_LEST_COMPLETEQUEST = "completed a quest",  
  SI_ECHOEXP_LEST_REWARD = "got a reward",  
  SI_ECHOEXP_LEST_SCRIPTEVENT = "did an event",
  SI_ECHOEXP_LEST_SKILLBOOK = "used a skill book",
  SI_ECHOEXP_LEST_TRADESKILL = "used a trade skill",
  SI_ECHOEXP_LEST_TRADEACHIEVE = "got an achievement",
  SI_ECHOEXP_LEST_TRADECONSUME = "used a tradeskil consumable",  
  SI_ECHOEXP_LEST_HARVEST = "harvested",  
  SI_ECHOEXP_LEST_TRADEQUEST = "tradeskill quest",
  SI_ECHOEXP_LEST_RECIPE = "learned a recipe",
  SI_ECHOEXP_LEST_TRAIT = "learned a trait",
  SI_ECHOEXP_LEST_WORLDEVENT = "did a world event",
  
  --questName, count, 25
  SI_ECHOEXP_QUEST_ACCEPT   = "You accepted the quest [<<1>>] (<<2>>/<<3>>)",
  SI_ECHOEXP_QUEST_COMPLETE = "You completed the quest [<<1>>] (<<2>>/<<3>>)",
  SI_ECHOEXP_QUEST_REMOVED  = "The quest [<<1>>] was removed from your log. (<<2>>/<<3>>)",
  SI_ECHOEXP_QUEST_STEPDONE1 = "You finished a step of the quest [<<1>>]",
  -- name, points, id, link)
  SI_ECHOEXP_ACHIEVEMENT_AWARDED = "You have earned the achievment [<<4>>] !!!",
  SI_ECHOEXP_LEVEL_GAIN = "*** You feel more powerful! *** You have reached the level [<<1>>] ! ***",
  --questName, shareTargetCharacterName, shareTargetDisplayName, resultString)
  SI_ECHOEXP_QUEST_SHARE_RESULT = "<<2>>@<<3>> <<4>> quest [<<1>>].",  
  --name, achievementID, description, numCompleted, numRequired
  SI_ECHOEXP_ACHIEVEMENT_UPDATED = "Achievement <<1>> progressed (<<4>>/<<5>>).",
  
	------------------------------
  -- EXP
	SI_ECHOEXP_XP_GAIN         = "You gained <<1>> experience.",
  --You discovered <whateverplace> - 42 xp
  SI_ECHOEXP_XP_GAIN_SOURCE  = "You <<1>> <<2>> - <<3>> xp.",
	SI_ECHOEXP_XP_SKILL_GAIN_1 = "Gained <<1>>xp in [<<2>>] (<<3>>/<<4>>) need <<5>>xp",

	SI_ECHOEXP_XP_SKILL_GAIN_2 = "Gained <<1>>xp in [<<2>>] need <<5>>xp",
  -- <<1>>name, <<2>> currentXP, <<3>> nextXP <<4>> diff, <<5>> thisGain, <<6>> icon
  -- Qualifier: (1) non verb, (2) non verb w/currXP, (3) verb, (4) verb w/currXP
  SI_ECHOEXP_XP_SKILLLINE_1      = "Gained xp in [<<1>>] need <<4>>xp",
  SI_ECHOEXP_XP_SKILLLINE_2      = "Gained <<5>>xp in [<<1>>] need <<4>>xp",
  SI_ECHOEXP_XP_SKILLLINE_3      = "Gained xp in [<<1>>] (<<2>>/<<3>>) need <<4>>xp",
  SI_ECHOEXP_XP_SKILLLINE_4      = "Gained <<5>>xp in [<<1>>] (<<2>>/<<3>>) need <<4>>xp",
  SI_ECHOEXP_XP_SKILLLINE_ICON_1 = "Gained xp in [|t14:14:<<6>>|t<<1>>] need <<4>>xp",
  SI_ECHOEXP_XP_SKILLLINE_ICON_2 = "Gained <<5>>xp in [|t14:14:<<6>>|t<<1>>] need <<4>>xp",
  SI_ECHOEXP_XP_SKILLLINE_ICON_3 = "Gained xp in [|t14:14:<<6>>|t<<1>>]  (<<2>>/<<3>>) need <<4>>xp",
  SI_ECHOEXP_XP_SKILLLINE_ICON_4 = "Gained <<5>>xp in [|t14:14:<<6>>|t<<1>>] (<<2>>/<<3>>) need <<4>>xp",
  SI_ECHOEXP_XP_SKILLLINE_UP     = "Upgraded rank of [<<2>>] to rank <<3>>!!!",
  SI_ECHOEXP_XP_SKILLLINE_GAIN   = "Gained skill [<<1>>] !!!",
  
  -- eventCode, sourceWord, trainingTypeWord, previous, current )
  SI_ECHOEXP_RIDING_UP      = "Upgraded [Riding <<3>>] from rank <<4>> to <<5>>!!!",
  SI_ECHOEXP_RIDING_SPEED   = "Speed",
  SI_ECHOEXP_RIDING_STAMINA = "Stamina",
  SI_ECHOEXP_RIDING_CARRY   = "Carry Capacity",
  SI_ECHOEXP_RIDING_INIT    = "Initial",
  SI_ECHOEXP_RIDING_ITEM    = "Item",
  SI_ECHOEXP_RIDING_STABLE  = "Stable Master",
  
  --
	SI_ECHOEXP_CP_UNLOCKED     = "****You unlocked Champion points!****",
	SI_ECHOEXP_CP_EARNED       = "****You gained a Champion point!****",  
	SI_ECHOEXP_DISCOVERY       = "You discovered: <<1>>.",
	SI_ECHOEXP_SKILLINE        = "You learned the skillline: [<<1>>] !!",

	SI_ECHOEXP_AP_GAIN       = "You gained <<1>> AP.",
	SI_ECHOEXP_AP_LOSS       = "You spent <<1>> AP.",

	SI_ECHOEXP_SKY_1         = "You absorbed a skyshard! (<<1>> of <<2>>).",
	SI_ECHOEXP_SKY_2         = "****You gained a skill point! (<<1>>).****",

	SI_ECHOEXP_GUILD_1       = "eventCode: <<1>>, guildID: <<2>>, playerName: <<3>>, prevStatus: <<4>>, curStatus: <<5>> .",
	SI_ECHOEXP_GUILD_2       = "<<4>> Login at <<2>> (<<3>>)",
	SI_ECHOEXP_GUILD_3       = "<<4>> Logout at <<2>> (<<3>>)",
    
  -- <<1>>(guildID), <<2>>GuildName, <<3>>playerName, <<4>>ZO_FormatClockTime(), <<5>>pLink )
	SI_ECHOEXP_GUILDADD_1    = "<<5>> *Joined* (<<2>>) at <<4>>!",
  --<<1>> guildID, <<2>>guild, <<3>>characterName, <<4>>ZO_FormatClockTime() , <<5>>pLink
	SI_ECHOEXP_GUILDREM_1    = "<<5>> *Left* (<<2>) at <<4>>!",  
  
	------------------------------
  -- LOOT
	--<<1>>icon, <<2>>itemName, <<3>>quantity, <<4>>extraInfo
  SI_ECHOLOOT_YOU_GAIN_1  = "You looted |t14:14:<<1>>|t [<<2>>] <<4>>",
	SI_ECHOLOOT_YOU_PICK_1  = "You acquired |t14:14:<<1>>|t <<2>>.",
	SI_ECHOLOOT_YOU_QUEST_1 = "You looted |t14:14:<<1>>|t <<2>> (QuestItem)",
	
	SI_ECHOLOOT_YOU_GAIN_2  = "You looted |t14:14:<<1>>|t [<<2>>] x<<3>>",
	SI_ECHOLOOT_YOU_PICK_2  = "You acquired |t14:14:<<1>>|t <<2>>  x<<3>>.",
	SI_ECHOLOOT_YOU_QUEST_2 = "You looted |t14:14:<<1>>|t <<2>> (quest item).",

	SI_ECHOLOOT_YOU_GAIN_3  = "You looted |t14:14:<<1>>|t [<<2>>] (<<4>>).",
	SI_ECHOLOOT_YOU_PICK_3  = "You acquired |t14:14:<<1>>|t [<<2>>] (<<4>>).",
	SI_ECHOLOOT_YOU_QUEST_3 = "You looted |t14:14:<<1>>|t [<<2>>] (<<4>>) (quest item).",
		
	SI_ECHOLOOT_YOU_GAIN_4  = "You looted: <<3>>x |t14:14:<<1>>|t [<<2>>] (<<4>>).",
	SI_ECHOLOOT_YOU_PICK_4  = "You acquired: <<3>>x |t14:14:<<1>>|t [<<2>>] (<<4>>).",
	SI_ECHOLOOT_YOU_QUEST_4 = "You looted: <<3>>x |t14:14:<<1>>|t [<<2>>] (<<4>>) (quest item).",

	--<<1>>receivedBy, <<2>>icon, <<3>>itemName, <<4>>quantity, <<5>>extraInfo 
  SI_ECHOLOOT_OTHER_GAIN_1  = "<<1>> looted |t14:14:<<2>>|t [<<3>>] <<5>>",
	SI_ECHOLOOT_OTHER_PICK_1  = "<<1>> acquired |t14:14:<<2>>|t [<<3>>] <<5>>",
	SI_ECHOLOOT_OTHER_QUEST_1 = "<<1>> acquired |t14:14:<<2>>|t [<<3>>] (quest item).",
		
	--<<1>>receivedBy, <<2>>icon, <<3>>itemName, <<4>>quantity, <<5>>traitName 
	SI_ECHOLOOT_OTHER_GAIN_2  = "<<1>> looted |t14:14:<<2>>|t [<<3>>] x<<4>> <<5>>",
	SI_ECHOLOOT_OTHER_PICK_2  = "<<1>> acquired |t14:14:<<2>>|t [<<3>>] x<<4>> <<5>>",
	SI_ECHOLOOT_OTHER_QUEST_2 = "<<1>> looted |t14:14:<<2>>|t [<<3>>] (quest item).",
	
	------------------------------
  -- Extended Loot info
	SI_ECHOLOOT_BUYBACK_1  = "You buyback [|t14:14:<<1>>|t <<2>>]",
	SI_ECHOLOOT_BUYBACK_2  = "You buyback [|t14:14:<<1>>|t <<2>>] x<<3>>",
	SI_ECHOLOOT_SELL_1     = "You sell [|t14:14:<<1>>|t <<2>>]",
	SI_ECHOLOOT_SELL_2     = "You sell [|t14:14:<<1>>|t <<2>>] x<<3>>",
	SI_ECHOLOOT_BUY_1      = "You buy [|t14:14:<<1>>|t <<2>>]",
	SI_ECHOLOOT_BUY_2      = "You buy [|t14:14:<<1>>|t <<2>>] x<<3>>",
  --icon, entryName, (entryQuantity), (totalAmount) )
	SI_ECHOLOOT_CURRENCY_1 = "You spend <<3>> |t14:14:<<1>>|t <<2>> (Total: <<4>>)", 
	SI_ECHOLOOT_CURRENCY_2 = "You gain <<3>> |t14:14:<<1>>|t <<2>> (Total: <<4>>)", 
  SI_ECHOLOOT_CURRENCY_BANK_1 = "Bank withdrawl: <<3>> |t14:14:<<1>>|t <<2>>", 
  SI_ECHOLOOT_CURRENCY_BANK_2 = "You banked: <<3>> |t14:14:<<1>>|t <<2>>", 

  --1 icon, 2 itemLink, 3 stackCountChange, 4 traitName )
	SI_ECHOLOOT_RECEIVE_1 = "You receive |t14:14:<<1>>|t <<2>>",
	SI_ECHOLOOT_RECEIVE_2 = "You receive |t14:14:<<1>>|t <<2>> x<<3>>",
	SI_ECHOLOOT_RECEIVE_3 = "You receive |t14:14:<<1>>|t <<2>> (<<4>>)",
	SI_ECHOLOOT_RECEIVE_4 = "You receive |t14:14:<<1>>|t <<2>> x<<3>> (<<4>>)",
  
  SI_ECHOLOOT_RECEIVE_5 = "You receive |t14:14:<<1>>|t <<2>>  (Total: <<5>>)",
	SI_ECHOLOOT_RECEIVE_6 = "You receive |t14:14:<<1>>|t <<2>> x<<3>>   (Total: <<5>>)",

  --
	SI_ECHOLOOT_LOSE_1    = "You lose |t14:14:<<1>>|t <<2>>",
	SI_ECHOLOOT_LOSE_2    = "You lose|t14:14:<<1>>|t <<2>> x<<3>>",
  --texture, iconFileIndex, name
  SI_ECHOANTIQ_RECEIVE  = "You found the lead [|t14:14:<<1>>|t <<3>>] !!",  
  
  --icon, itemLink, stackCountChange
  SI_ECHOLOOT_BANK_GET = "You withdrawl [|t14:14:<<1>>|t <<2>>] x<<3>>", 
  SI_ECHOLOOT_BANK_DEP = "You deposit [|t14:14:<<1>>|t <<2>>] x<<3>> ", 

}
------------------------------
-- 
--TODO use GetChatFontSize()  to get size
--https://wiki.esoui.com/Text_Formatting
for stringId, stringValue in pairs(localization_strings) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end