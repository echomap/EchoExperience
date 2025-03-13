-- Every variable must start with this addon's unique ID, as each is a global.
local localization_strings = {
	SI_ECHOEXP_MESSAGE = " is active!",
	SI_BINDING_NAME_EE_DISPLAY1    = "Show EchoExp Tracking UI",
	SI_BINDING_NAME_EE_DISPLAY2    = "Show EchoExp Litany UI",
	SI_BINDING_NAME_EE_DISPLAY3    = "Show EchoExp Loot History UI",
	SI_BINDING_NAME_EE_DISPLAY4    = "Show EchoExp EXP History UI",
	------------------------------
	-- 
	SI_ECHOEXP_EXPGAINS_SHOW   = "EchoExp is showing Experience Gains",
	SI_ECHOEXP_EXPGAINS_HIDE   = "EchoExp is no longer showing Experience Gains",
	SI_ECHOEXP_LOOTGAINS_SHOW  = "EchoExp is showing Loot Gains",
	SI_ECHOEXP_LOOTGAINS_HIDE  = "EchoExp is not showing Loot Gains",
	SI_ECHOEXP_LOOTGAINSE_SHOW = "EchoExp is showing Extended Loot Gains",
	SI_ECHOEXP_LOOTGAINSE_HIDE = "EchoExp is not showing Extended Loot Gains",
	SI_ECHOEXP_QUEST_SHOW      = "EchoExp is showing Quest related things",
	SI_ECHOEXP_QUEST_HIDE      = "EchoExp is not showing Quest related things",
  
	SI_ECHOEXP_COMPANION_SHOW      = "EchoExp is showing Companion related things",
	SI_ECHOEXP_COMPANION_HIDE      = "EchoExp is not showing Companion related things",

	------------------------------
	-- 
	SI_ECHOEXP_GUILD_EVENT_REG   = "Registered for Guild events",
	SI_ECHOEXP_GUILD_EVENT_UNREG = "Unregistered for Guild events",
	SI_ECHOEXP_GUILD_AUTO_OFFMSG = "Guild notifications are now turned OFF",
  
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
	SI_ECHOEXP_SETTINGS_AUTOUSEDEF_NM   = "Automatically use saved settings on new character?",
	SI_ECHOEXP_SETTINGS_AUTOUSEDEF_TT   = "If checked, this addon will use the saved default settings when a new character is loaded.",

	SI_ECHOEXP_SETTINGS_ACCOUNTNAMES_NM   = "Use Acount names?",
	SI_ECHOEXP_SETTINGS_ACCOUNTNAMES_TT   = "If checked, Use account name over character name when possible.",

	SI_ECHOEXP_SETTINGS_KILLS_SHOW        = "Show kills/deaths?",
	SI_ECHOEXP_SETTINGS_KILLS_SHOW_TT     = "Show kills/deaths?",
	SI_ECHOEXP_SETTINGS_DISCOVERY_SHOW    = "Show discovered?",
	SI_ECHOEXP_SETTINGS_DISCOVERY_SHOW_TT = "Show discovered locations?",
	SI_ECHOEXP_SETTINGS_ACHIEVEMENT_SHOW    = "Show Achievments?",
	SI_ECHOEXP_SETTINGS_ACHIEVEMENT_SHOW_TT = "Show Achievments?",
	SI_ECHOEXP_SETTINGS_ACHIEVEMENTDETAIL_SHOW    = "Detailed Achievments?",
	SI_ECHOEXP_SETTINGS_ACHIEVEMENTDETAIL_SHOW_TT = "Show in-progress Achievment messages?",
	SI_ECHOEXP_SETTINGS_ACHIEVEMENTDETAIL_SLIDER    = "Criteria Max #",
	SI_ECHOEXP_SETTINGS_ACHIEVEMENTDETAIL_SLIDER_TT = "How many lines to show max for achievements that have multiple criteria (10=all)",
	SI_ECHOEXP_SETTINGS_LOREOBOOK_SHOW        = "Show Lorebooks?",
	SI_ECHOEXP_SETTINGS_LOREOBOOK_SHOW_TT     = "Show Lorebook events found/learned/collected",
	SI_ECHOEXP_SETTINGS_ENDEAVOR_SHOW        = "Show Endeavors?",
	SI_ECHOEXP_SETTINGS_ENDEAVOR_SHOW_TT     = "Show Endeavors events completed",
	SI_ECHOEXP_SETTINGS_ASYNCALL_NM = "Use ASYNC Library for all",
	SI_ECHOEXP_SETTINGS_ASYNCALL_TT = "Async might help with disconnects, but will show events slower",
	SI_ECHOEXP_SETTINGS_LIBMSGWIN_SHOW_NM = "Use discrete/seperate window for loot output",
	SI_ECHOEXP_SETTINGS_LIBMSGWIN_SHOW_TT = "Use discrete/seperate window for loot output",

	SI_ECHOEXP_SETTINGS_LOOTHISTORY_MAX_NM = "Loot History Max memory",
	SI_ECHOEXP_SETTINGS_LOOTHISTORY_MAX_TT = "Loot History Max memory",
	SI_ECHOEXP_SETTINGS_LOOTHISTORY_CULL_NM = "Loot History Cull",
	SI_ECHOEXP_SETTINGS_LOOTHISTORY_CULL_TT = "Loot History Cull",

	SI_ECHOEXP_SETTINGS_EXPHISTORY_MAX_NM = "Exp History Max memory",
	SI_ECHOEXP_SETTINGS_EXPHISTORY_MAX_TT = "Exp History Max memory",
	SI_ECHOEXP_SETTINGS_EXPHISTORY_CULL_NM = "Exp History Cull memory",
	SI_ECHOEXP_SETTINGS_EXPHISTORY_CULL_TT = "Exp History Cull memory",

	SI_ECHOEXP_SETTINGS_ALPHA_NAME    = "Show Alpha events?",
	SI_ECHOEXP_SETTINGS_ALPHA_TT      = "Dev Alpha?",

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
	SI_ECHOEXP_SETTINGS_QUEST_OUTPUTS_NAME    = "Quest Output Config",
	SI_ECHOEXP_SETTINGS_QUEST_OUTPUTS_TOOLTIP = "Quest output entries for (window/tab/color).",
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
	SI_ECHOEXP_SETTINGS_EXP_VERB_NAME             = "Show Have/need?",
	SI_ECHOEXP_SETTINGS_EXP_VERB_TOOLTIP          = "Show more Verbose reporting, if experience is on? (Show % have and need)",
	SI_ECHOEXP_SETTINGS_EXP_SKILLLINE_TITLE       = "Show Skill Experience",
	SI_ECHOEXP_SETTINGS_EXP_SKILLLINE_TOOLTIP     = "Report on skill lines Rank Gains? (if experience is on)",
	SI_ECHOEXP_SETTINGS_EXP_VERBSKILLLINE_TITLE   = "Show Verbose Skill Experience",
	SI_ECHOEXP_SETTINGS_EXP_VERBSKILLLINE_TOOLTIP = "Report on all exp gains for skill lines? (if experience is on)",
	SI_ECHOEXP_SETTINGS_EXP_OUTPUTS_NAME    = "Exp Output Config",
	SI_ECHOEXP_SETTINGS_EXP_OUTPUTS_TOOLTIP = "Experience output entries for (window/tab/color).",
	SI_ECHOEXP_SETTINGS_EXP_OUTPUTS_DELETE  = "Delete selected Exp's Data!",
	SI_ECHOEXP_SETTINGS_EXP_COMPANIONS_TITLE   = "Show Companion Experience Events",
	SI_ECHOEXP_SETTINGS_EXP_COMPANIONS_TOOLTIP = "Show Companion Experience Events",

	SI_ECHOEXP_SETTINGS_BANDITSIDEPANEL_NM = "Show EchoExp in Bandit's sidepanel",
	SI_ECHOEXP_SETTINGS_BANDITSIDEPANEL_TT = "Show EchoExp in Bandit's sidepanel",

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
	SI_ECHOEXP_SETTINGS_LOOT_OUTPUTS_NAME    = "Loot Output Config",
	SI_ECHOEXP_SETTINGS_LOOT_OUTPUTS_TOOLTIP = "Shows Loot output entries in format: (window/tab/color). Use this to view or delete.",
	SI_ECHOEXP_SETTINGS_LOOT_OUTPUTS_DELETE  = "Delete selected Loot's Data!",
	SI_ECHOEXP_SETTINGS_LOOT_TRAIT_NAME            = "On Loot, show Trait",
	SI_ECHOEXP_SETTINGS_LOOT_TRAIT_TOOLTIP         = "On Loot, show Trait",
	SI_ECHOEXP_SETTINGS_LOOT_SETCOLLECTION_NAME    = "On Loot, show if collected",
	SI_ECHOEXP_SETTINGS_LOOT_SETCOLLECTION_TOOLTIP = "On Loot, show if collected",
	SI_ECHOEXP_SETTINGS_LOOT_SELF_QUALITY_TITLE   = "(Self) Select the item to report on or above",
	SI_ECHOEXP_SETTINGS_LOOT_SELF_QUALITY_TOOLTIP = "(Self) The selection here is the lowest loot type reported to chat",

	SI_ECHOEXP_SETTINGS_LOOT_GROUP_QUALITY_TITLE   = "(Group) Select the item to report on or above",
	SI_ECHOEXP_SETTINGS_LOOT_GROUP_QUALITY_TOOLTIP = "(Group) The selection here is the lowest loot type reported to chat.",

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
	SI_ECHOEXP_SETTINGS_GUILD_JOINLEAVE_NAME     = "Show Guild Join/Leave?",
	SI_ECHOEXP_SETTINGS_GUILD_JOINLEAVE_TOOLTIP  = "Report? on or off.",
	SI_ECHOEXP_SETTINGS_GUILD_G1 = "G1",
	SI_ECHOEXP_SETTINGS_GUILD_G2 = "G2",
	SI_ECHOEXP_SETTINGS_GUILD_G3 = "G3",
	SI_ECHOEXP_SETTINGS_GUILD_G4 = "G4",
	SI_ECHOEXP_SETTINGS_GUILD_G5 = "G5",
	SI_ECHOEXP_SETTINGS_GUILD_OUTPUTS_NAME    = "Guild Output Config",
	SI_ECHOEXP_SETTINGS_GUILD_OUTPUTS_TOOLTIP = "Guild output entries for (window/tab/color).",
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

	SI_ECHOEXP_SETTINGS_LOOTHISTORY_NM = "LootHistory Max Size",
	SI_ECHOEXP_SETTINGS_LOOTHISTORY_TT = "The limit of entries to save for loot history",
  
	--
	SI_ECHOEXP_HEADER_TIME = "Time",
	SI_ECHOEXP_HEADER_ITEM = "Item",
	SI_ECHOEXP_HEADER_COUNT = "Count",
	SI_ECHOEXP_HEADER_RECIPIENT = "Recipient",
	SI_ECHOEXP_FILTER_LABEL = "Filters",
  
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
	SI_ECHOEXP_QUEST_ACCEPT   = "You accepted the quest [<<t:1>>] (<<2>>/<<3>>)",
	SI_ECHOEXP_QUEST_COMPLETE = "You completed the quest [<<t:1>>] (<<2>>/<<3>>)",
	SI_ECHOEXP_QUEST_REMOVED  = "The quest [<<1>>] was removed from your log. (<<2>>/<<3>>)",
	SI_ECHOEXP_QUEST_STEPDONE1 = "You finished a step of the quest [<<t:1>>]",
	-- name, points, id, link)
	SI_ECHOEXP_ACHIEVEMENT_AWARDED = "You have earned the achievment [<<4>>] !!!",
	SI_ECHOEXP_LEVEL_GAIN = "*** You feel more powerful! *** You have reached level [<<1>>] ! ***",
	--isname, itemSetId, numPieces, numSlotsUnlocked, itemLink
	SI_ECHOEXP_SETCOLLECTION_UPDATED2 = "You collected a piece in the [<<5>>] set [<<4>>/<<3>>].",
	SI_ECHOEXP_SETCOLLECTION_COLLECTED = "",
	SI_ECHOEXP_SETCOLLECTION_NOTCOLLECTED = "-Not Collected-",

	--name, achievementID, description, numCompleted, numRequired
	SI_ECHOEXP_ACHIEVEMENT_UPDATED   = "Achievement <<1>> progressed (<<4>>/<<5>>).",
	SI_ECHOEXP_ACHIEVEMENT_UPDATED1  = "Achievement <<1>> completed.",
	SI_ECHOEXP_ACHIEVEMENT_UPDATED2  = "Achievement <<1>> progressed (<<4>>/<<5>>).",
	SI_ECHOEXP_ACHIEVEMENT_COMPLETED = "Achievement <<1>> Completed.",
	SI_ECHOEXP_LOREBOOK_LEARNED      = "Discovered book <<1>> in category <<2>> (<<3>>/<<4>>).",
	SI_ECHOEXP_LOREBOOK_LEARNED_SOLO = "Discovered book <<1>>.",
	SI_ECHOEXP_LOREBOOK_CAT_COMPLETE = "Finished collecting the collection [<<2>>] in category [<<1>>]!!.",
	SI_ECHOEXP_LOREBOOK_EXP          = "Earned Exp <<1>> for discovering book [<<2>>] in category [<<3>>] (<<4>>/<<5>>).",
	SI_ECHOEXP_LOREBOOK_CATCOMPLETE_EXP = "Earned Exp <<3>> for finished the collection [<<2>>] in category [<<1>>]!!.",

	SI_ECHOEXP_BG_KILLED   = "You killed <<1>>.",
	SI_ECHOEXP_BG_KILLEDBY = "You were killed by <<1>>.",
	SI_ECHOEXP_DIED = "You died!",

	SI_ECHOEXP_COMBAT_ENTER = "*Combat started*",
	SI_ECHOEXP_COMBAT_EXIT  = "*Combat ended*",
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
	SI_ECHOEXP_GUILDADD_1    = "<<5>> *JOINED* (<<2>>) at <<4>>",
	--<<1>> guildID, <<2>>guild, <<3>>characterName, <<4>>ZO_FormatClockTime() , <<5>>pLink
	SI_ECHOEXP_GUILDREM_1    = "<<5>> *LEFT* (<<2>>) at <<4>>",  
	--
	SI_ECHOEXP_GUILDINVITED    = "<<1>> Invited you to the guild (<<2>>)",  
  
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
	SI_ECHOLOOT_OTHER_GAIN_1  = "<<1>> looted |t14:14:<<2>>|t [<<3>>] <<5>> <<6>>",
	SI_ECHOLOOT_OTHER_PICK_1  = "<<1>> acquired |t14:14:<<2>>|t [<<3>>] <<5>> <<6>>",
	SI_ECHOLOOT_OTHER_QUEST_1 = "<<1>> acquired |t14:14:<<2>>|t [<<3>>] (quest item).",
		
	--<<1>>receivedBy, <<2>>icon, <<3>>itemName, <<4>>quantity, <<5>>traitName 
	SI_ECHOLOOT_OTHER_GAIN_2  = "<<1>> looted |t14:14:<<2>>|t [<<3>>] x<<4>> <<5>> <<6>>",
	SI_ECHOLOOT_OTHER_PICK_2  = "<<1>> acquired |t14:14:<<2>>|t [<<3>>] x<<4>> <<5>> <<6>>",
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
	SI_ECHOLOOT_CURRENCY_1 = "You spent <<3>> [|t14:14:<<1>>|t <<2>>] (Total: <<4>>)", 
	SI_ECHOLOOT_CURRENCY_2 = "You gain <<3>> [|t14:14:<<1>>|t <<2>>] (Total: <<4>>)", 
	SI_ECHOLOOT_CURRENCY_BANK_1 = "Bank withdrawl: <<3>> [|t14:14:<<1>>|t <<2>>]", 
	SI_ECHOLOOT_CURRENCY_BANK_2 = "You banked: <<3>> [|t14:14:<<1>>|t <<2>>]", 

	--1 icon, 2 itemLink, 3 stackCountChange, 4 traitName )
	SI_ECHOLOOT_RECEIVE_1 = "You receive [|t14:14:<<1>>|t <<2>>]",
	SI_ECHOLOOT_RECEIVE_2 = "You receive [|t14:14:<<1>>|t <<2>>] x<<3>> <<6>>",
	SI_ECHOLOOT_RECEIVE_3 = "You receive [|t14:14:<<1>>|t <<2>>] (<<4>>) <<6>>",
	SI_ECHOLOOT_RECEIVE_4 = "You receive [|t14:14:<<1>>|t <<2>>] x<<3>> (<<4>>) <<6>>",  
	SI_ECHOLOOT_RECEIVE_5 = "You receive [|t14:14:<<1>>|t <<2>>] <<6>> (Total: <<5>>)",
	SI_ECHOLOOT_RECEIVE_6 = "You receive [|t14:14:<<1>>|t <<2>>] x<<3>>  <<6>> (Total: <<5>>)",

	--
	SI_ECHOLOOT_LOSE_1    = "You lose |t14:14:<<1>>|t <<2>>",
	SI_ECHOLOOT_LOSE_2    = "You lose|t14:14:<<1>>|t <<2>> x<<3>>",
	--texture, iconFileIndex, name
	SI_ECHOANTIQ_RECEIVE  = "You found the lead [|t14:14:<<1>>|t <<3>>] !!",  

	--icon, itemLink, stackCountChange
	SI_ECHOLOOT_BANK_DEP   = "You deposit [|t14:14:<<1>>|t <<2>>] x<<3>> ", 
	SI_ECHOLOOT_BANK_GET_1 = "You withdrawl [|t14:14:<<1>>|t <<2>>] <<6>>",
	SI_ECHOLOOT_BANK_GET_2 = "You withdrawl [|t14:14:<<1>>|t <<2>>] x<<3>> <<6>>",
	SI_ECHOLOOT_BANK_GET_3 = "You withdrawl [|t14:14:<<1>>|t <<2>>] (<<4>>) <<6>>",
	SI_ECHOLOOT_BANK_GET_4 = "You withdrawl [|t14:14:<<1>>|t <<2>>] x<<3>> (<<4>>) <<6>>",
	SI_ECHOLOOT_BANK_GET_5 = "You withdrawl [|t14:14:<<1>>|t <<2>>] <<6>> (Total: <<5>>)",
	SI_ECHOLOOT_BANK_GET_5 = "You withdrawl [|t14:14:<<1>>|t <<2>>] <<6>> (Total: <<5>>)",
	SI_ECHOLOOT_BANK_GET_6 = "You withdrawl [|t14:14:<<1>>|t <<2>>] x<<3>>  <<6>> (Total: <<5>>)",

	--QUEST Output
	SI_ECHOLOOT_QUEST_SHARED_TO_YOU = "The quest [<<1>>] was shared to you by <<2>>.", 
	--questName, shareTargetCharacterName, shareTargetDisplayName, resultString)
	SI_ECHOEXP_QUEST_SHARE_RESULT = "Quest [<<1>>] <<4>> by <<2>>@<<3>> .",  
	SI_ECHOEXP_QUEST_ACCEPTED = "was Accepted",
	SI_ECHOEXP_QUEST_DECLINED = "was Declined",
	SI_ECHOEXP_QUEST_FAILED   = "Failed to Share with",

	--
	SI_ECHOEXP_GUILD_SELFLEFT   = "You left the guild <<1>>.",
	SI_ECHOEXP_GUILD_SELFJOIN   = "You joined the guild <<1>>.",

	SI_ECHOEXP_LITANY_SCANFOUND = "Scan added <<1>> to the litany DONE list",

	-- COMPANIONS
	SI_ECHOEXP_COMPANION_ACTIVE        = "Companion [<<1>>] arrived. (lvl:<<2>>) (rapp:<<3>>).",
	SI_ECHOEXP_COMPANION_DEACTIVE      = "Companion left.",
	--cname, level, diff, previousExperience, currentExperience, xplevel 
	SI_ECHOEXP_COMPANION_EXPGAIN       = "Companion [<<1>>(<<2>>)] gained <<3>>xp (<<5>>/<<6>>).",
	SI_ECHOEXP_COMPANION_LEVELUP       = "Companion [<<1>>(<<2>>)] gained <<3>>xp, and LEVELLED UP!",
	--cname, diff, previousRapport, currentRapport
	SI_ECHOEXP_COMPANION_RAPPORTGAIN   = "Companion [<<1>>] gained <<2>> rapport (<<4>/<<3>>).",
	SI_ECHOEXP_COMPANION_RAPPORTLOSS   = "Companion [<<1>>] lost <<2>> rapport (<<4>/<<3>>).",
	--
	--OnCompanionSkillsFullUpdate
	--slName, skillLineId
	SI_ECHOEXP_COMPANION_SKILLLINEADD  = "Companion gained the <<1>> skillline!",
	--skillLineId, skillLineName, rank
	SI_ECHOEXP_COMPANION_SKILLRANKGAIN = "Companion gained rank <<2>> in [<<2>>]", --xp in [<<2>>] (<<3>>/<<4>>) need <<5>>xp
	--slName, diff, rank
	SI_ECHOEXP_COMPANION_SKILLXPUPD    = "Companion gained <<2>>xp in <<1>>[<<3>>].",
	--
	--OnCompanionUltimateFailure
	--
	--OnCompanionWarning
	SI_ECHOEXP_COMPANION_X = "",
	--TIMED Activity
	SI_ECHOEXP_TIMEDACTIVITY_UPDATE0 = "You completed a Daily Endeavor!",
	SI_ECHOEXP_TIMEDACTIVITY_UPDATE1 = "You completed a Weekly Endeavors!",
	SI_ECHOEXP_TIMEDACTIVITY_DONE0 = "You finished all Daily Endeavors for today!",
	SI_ECHOEXP_TIMEDACTIVITY_DONE1 = "You finished  all Weekly Endeavors for the week!",
	
}
------------------------------
-- 
--TODO use GetChatFontSize()  to get size
--https://wiki.esoui.com/Text_Formatting
for stringId, stringValue in pairs(localization_strings) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end