---------------------------------
--[[ EchoExp                 ]]-- 
---------------------------------


------------------------------
-- 
EchoExperience = {
    name            = "EchoExperience",           -- Matches folder and Manifest file names.
    version         = "0.0.59",                   -- A nuisance to match to the Manifest.
    versionnumeric  =  59,                        -- A nuisance to match to the Manifest.
    author          = "Echomap",
    menuName        = "EchoExperience_Options",   -- Unique identifier for menu object.
    menuDisplayName = "EchoExperience",
    view            = {},
	staticdata      = {},
	currentCompanionId = nil,
	currentPartyMembers = { },
    -- Saved settings.
    savedVariables = {},
    accountVariables = {},
}

--EchoExperience.staticdata.XX
EchoExperience.staticdata = {
    defaultMaxLines  = 10,
    defaultMaxLines2 = 15,
    rgbaBase   = {
      ["r"] = 1,
      ["g"] = 1,
      ["b"] = 1,
      ["a"] = 0.9,
    },	
	msgTypeSYS     = 1,
	msgTypeEXP     = 2,
	msgTypeLOOT    = 4,
	msgTypeGUILD   = 6, -- 
	msgTypeGUILD2  = 7, -- Guild Admin Messages
	msgTypeQuest   = 8,
	msgTypeCOMP    = 9,
	msgTypeENDEAV  = 10,
}
--
EchoExperience.LitanyOfBlood = {
      version = 1,
      list = {
        ["Cimalire"]     = { done=false, SubZoneName="Skywatch",     ZoneName="Auridon",
          tooltip="She has two paths, one from the Mage's guild or out of Ingamircil's house .. she also stops and sits at these coords, and there's a hedge behind her...", id=1 , coord="48:42" },
        ["Dirdelas"]     = { done=false, SubZoneName="Elden Root",   ZoneName="Grahtwood",    
          tooltip="Found wandering between the Outside Inn and the Tree's Defense shop near the Elden Root wayshrine, as well as fishing near the stables", id=2 , coord="26:62" },
        ["Caraleth"]     = { done=false, SubZoneName="Marbruk",      ZoneName="Greenshade",       
          tooltip="Found in or walking between in the Merchant's Plaza and Fighters Guild or found inside the Fighters Guild. She can occasionally follow another patrol path, which takes her from the wayshrine to the cemetery northeast of the furnishing merchants",id=3 , coord="69:34"  },
        ["Sihada"]       = { done=false, SubZoneName="Vulkwasten",   ZoneName="Malabal Tor",    
          tooltip="Found in the center of the town, in a white dress, sweeping. She wanders around the center of town.",id=4 , coord="53:79" },
        ["Dablir"]       = { done=false, SubZoneName="Rawl'kha",     ZoneName="Reaper's March",      
          tooltip="Found wandering the marketplace in Rawl'kha, goes back to the hidden temple grounds...", id=5 , coord="66:55" },
        ["Dinor Girano"] = { done=false, SubZoneName="Davon's Watch", ZoneName="Stonefalls", 
          tooltip="Walks about, but can be found on this bridge.", id=6  , coord="58:58"},
        ["Cindiri Malas"]= { done=false, SubZoneName="Mournhold",   ZoneName="Deshaan",     
          tooltip="Found patrolling the west side of the Mournhold bank all the way to the bridge out of town", id=7 , coord="45:50" },
        ["Gideelar"]     = { done=false, SubZoneName="Stormhold",    ZoneName="Shadowfen",       
          tooltip="Found in the city, this lizard does some landscaping by the Outlaw Refuge entrance, but she has no time for talk.",id=8 , coord="62:17"  },
        ["Hakida"]       = { done=false, SubZoneName="Windhelm",     ZoneName="Eastmarch",
          tooltip="Found walking around the Mages Guild or a circuit of the Konunleikar festivities,",id=9 , coord="33:62" },
        ["Eldfyr"]       = { done=false, SubZoneName="Riften",       ZoneName="The Rift",       
          tooltip="Found fishing on the western docks, walking around the artisans hall, praying at the stones east of Fighters Guild, or inside the Fighters Guild.", id=10  , coord="58:85"},
        ["Cesarel Hedier"] = { done=false, SubZoneName="Daggerfall", ZoneName="Glenumbra",
          tooltip="NE Corner of city, near clotheslines and residences.",id=11  , coord="65:24"},
        ["Alix Edette"]  = { done=false, SubZoneName="Wayrest Docks", ZoneName="Stormhaven",    
          tooltip="Found wandering the docks by the Dock Warehouse", id=12, coord="62:68" },
        ["Bolaag"]       = { done=false, SubZoneName="Shornhelm",     ZoneName="Rivenspire",     
          tooltip="She jugles knives in the front marketplace, will travel to behind the bank" ,id=13, coord="66:47"  },
        ["Ebrayd"]       = { done=false, SubZoneName="Sentinel",      ZoneName="Alik'r Desert",   
          tooltip="Found near the crafting stations",id=14, coord="65:42" },
        ["Berea"]        = { done=false, SubZoneName="Evermore",      ZoneName="Bangkorai",       
          tooltip="Found walking in her purple dress, between Evermore Wayshrine graveyard, the Stalls, and the road to Tordrak's Eldritch Emporium.",id=15, coord="56:27"  },
      },
 }

------------------------------
-- 
local defaultSettings = {
	sversion   = EchoExperience.version,
	iversion   = EchoExperience.versionnumeric,
	debug      = false,
	showExp    = true,
	verboseExp = true,
	showExpT1  = true,
	showExpT2  = false,
	showSkillExp    = true,
	showAllSkillExp = true,
	messageFmt      = 1,
	showLoot         = false,
	groupLoot        = false,  
	extendedLoot     = false,
	showGuildLogin   = false,
	showGuildLogout  = false,
	showmdk          = true,
	showquests             = false,
	showquestsadvanced     = false,
	showdiscovery          = true,
	showachievements       = true,
	showachievementdetails = false,
	showcompanions         = false,
	showachievementmax     = 10,
	lorebooktracking       = false,  
	showalpha        = false,
	sessiontracking  = false,
	lifetimetracking = false,
	immersive = false,
	lootshowsetcollection = true,
	lootshowtrait         = true,
	loothistorymaxsize    = 110,
	lootHistoryMax = 110,
	lootHistoryCull = 9,
	expHistoryMax = 50,
	expHistoryCull = 9,
}
------------------------------

------------------------------
------------------------------
----[Section] MESSAGING
------------------------------

------------------------------
-- UTIL
function EchoExperience.outputRawMsg(text)
	d(text)
end

------------------------------
-- UTIL
function EchoExperience.debugMsg(text)
	EchoExperience.debugMsg2(text)
end

------------------------------
-- UTIL
function EchoExperience.outputMsg(text)
	EchoExperience.outputMsg2(text)
end

------------------------------
-- UTIL
function EchoExperience.outputMsg2(...)
	local arg={...}
	if arg == nil then
		return
	end
	local printResult = ""
	if(arg~=nil)then
		for i,v in ipairs(arg) do
			if(v==nil) then 
				printResult = printResult .. "nil"
			else
				printResult = printResult .. tostring(v) --.. " "
			end
		end
	end

	if printResult == nil then
		return
	end
	local val = zo_strformat( "(EchoExp) <<1>>",printResult)
	d(val)
end

------------------------------
-- UTIL
function EchoExperience.debugMsg2(...)
	if not EchoExperience.savedVariables.debug then
		return
	end
	local arg={...}
	if arg == nil then
		return
	end
	local printResult = ""
	if(arg~=nil)then
		for i,v in ipairs(arg) do
			if(v==nil) then 
				printResult = printResult .. "nil"
			else
				printResult = printResult .. tostring(v) --.. " "
			end
		end
	end

	if printResult == nil then
		return
	end
	local val = zo_strformat( "(EchoExp) <<1>>",printResult)
	d(val)
end
------------------------------

------------------------------
------------------------------
----[Section] Main Function
------------------------------

------------------------------
-- OUTPUT 
-- Parse where window/tab to write message
-- Main Output Function used by addon to control output and style
-- System/Experience/Loot/Guild/Quest/Companion -> Experience
function EchoExperience.outputToChanel(text,msgType,filter)
    EchoExperience.debugMsg2("outputToChanel: msgType:'", tostring(msgType), "'" )
	--Category: System
	if msgType == nil or msgType == EchoExperience.staticdata.msgTypeSYS then
		d(text)
	--Category: Experience
	elseif msgType == EchoExperience.staticdata.msgTypeEXP then
		EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.expsettings, filter, msgType )
		return
	--Category: Loot
	elseif msgType == EchoExperience.staticdata.msgTypeLOOT then
		EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.lootsettings, filter, msgType)
		return
	--Category: Guild
	elseif msgType == EchoExperience.staticdata.msgTypeGUILD then
		EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.guildsettings, filter, msgType)
	--Category: Guild x2 -> Guild
	--for later, when I seperate the LOGXX with the join/leave
	elseif msgType == EchoExperience.staticdata.msgTypeGUILD2 then
		EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.guildsettings, filter, msgType)
	--Category: Quest
	elseif msgType == EchoExperience.staticdata.msgTypeQuest then
		EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.questsettings, filter, msgType)
	--
	--Category: Companion -> Experience
	elseif msgType == EchoExperience.staticdata.msgTypeCOMP then
		EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.expsettings, filter, EchoExperience.staticdata.msgTypeEXP)
	--Category: Endeavor -> Quest
	elseif msgType == EchoExperience.staticdata.msgTypeENDEAV then
		EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.questsettings, filter, EchoExperience.staticdata.msgTypeQuest)
	end
  --
  if(EchoExperience.error)then
      EchoExperience.error = false
      EchoExperience.savedVariables.showGuildLogin  = false
      EchoExperience.savedVariables.showGuildLogout = false
      EchoExperience.outputMsg( GetString(SI_ECHOEXP_GUILD_AUTO_OFFMSG) )
  end
end

------------------------------
-- OUTPUT
function EchoExperience:outputToChanelSub(text,outputSettings,filter, msgType)
  if(text==nil) then return end
  if outputSettings == nil then return end
  if(EchoExperience.view.libmsgwindow==nil) then
    EchoExperience:SetupLibMsgWin()
  end
  if(EchoExperience.savedVariables.showlibmsgwin and LibMsgWin~=nil and EchoExperience.view.libmsgwindow~=nil ) then
    if( not EchoExperience.view.libmsgwindow:IsControlHidden() ) then
      local showInSepWindow = false
      if(msgType==EchoExperience.staticdata.msgTypeLOOT and EchoExperience.savedVariables.uselibmsgwinExp)then
        showInSepWindow = true
      elseif( (msgType==EchoExperience.staticdata.msgTypeGUILD or msgType==EchoExperience.staticdata.msgTypeGUILD2) and EchoExperience.savedVariables.uselibmsgwinGuild)then
        showInSepWindow = true
      elseif( (msgType==EchoExperience.staticdata.msgTypeEXP) and EchoExperience.savedVariables.uselibmsgwinExp)then
        showInSepWindow = true
      elseif( (msgType==EchoExperience.staticdata.msgTypeQuest) and EchoExperience.savedVariables.uselibmsgwinQuest)then
        showInSepWindow = true
      end
      if(showInSepWindow) then
        EchoExperience.view.libmsgwindow:AddText(text, 1, 1, 1)
      end
    end
  end
  
  for k, v in pairs(outputSettings) do
    if(v.window~=nil and v.tab~=nil and v.window>0 and v.tab>0 and v.color~=nil and v.color.r~=nil) then
      local skip = false
      --filter
      if(filter~=nil and filter.type == EchoExperience.staticdata.msgTypeGUILD and v.guilds~=nil) then
        EchoExperience.debugMsg2("filter.guildID=", filter.guildID, " filter.guildId=", filter.guildId )
        skip = true
        --local gkey = "guild"..filter.guildID
        local gkey = filter.guildId
        if(v.guilds[gkey]==nil) then skip = false
        elseif(v.guilds[gkey]==true)then
          skip = false
          EchoExperience.debugMsg("Found guildid in show list")
        end
      end
      if(not skip) then
        --colorized text and write it out
        local cCD = ZO_ColorDef:New(v.color.r,v.color.g,v.color.b,v.color.a)
        local text2 = cCD:Colorize(text)
        if(text2~=nil) then 
          local text1 = ""
          if( not EchoExperience.savedVariables.immersive ) then
            text1 = "[EchoExp]"
          end
          text2 = zo_strformat( "<<1>> <<2>>", text1, text2)
          --TODO timestamp
          --EchoExperience.savedVariables.showTimeStamp
          --EchoExperience.savedVariables.timeStampFormat
          CHAT_SYSTEM.containers[v.window].windows[v.tab].buffer:AddMessage(text2)
        end
      end
    else
      --ERROR
      EchoExperience.error = true
      if( v.color~=nil) then
        local cVals = zo_strformat( "r=<<1>>/g=<<2>>/b=<<3>>/a=<<4>>", tostring(v.color.r),tostring(v.color.g),tostring(v.color.b),tostring(v.color.a) )
         local cText = zo_strformat( "Error in config: tab=<<1>>/win=<<2>>/color=<<3>>",tostring(v.tab),tostring(v.window),cVals )
        EchoExperience.outputMsg(cText);
      else
         local cText = zo_strformat( "Error in config: tab=<<1>>/win=<<2>>/color of setting",tostring(v.tab),tostring(v.window) )
        EchoExperience.outputMsg(cText);
      end
    end
  end
end
------------------------------

------------------------------
------------------------------
----[Section] User Input
------------------------------

------------------------------
-- SLASH
function EchoExperience.SlashCommandHandler(text)
	--EchoExperience.debugMsg("SlashCommandHandler: " .. text)
	local options = {}
	local searchResult = { string.match(text,"^(%S*)%s*(.-)$") }
	for i,v in pairs(searchResult) do
		if (v ~= nil and v ~= "") then
		    options[i] = string.lower(v)
		end
	end

	if #options == 0 or options[1] == "help" then
		EchoExperience.outputMsg("user commands include:")
		EchoExperience.outputMsg("-- 'outputs' to show in text what will happen ")
		EchoExperience.outputMsg("-- 'mute/unmute': should silence/unsilence EchoExp.")
		
		EchoExperience.outputMsg("The tracking module: (is in alpha):")
		EchoExperience.outputMsg("-- 'showtracking' for text output")
		EchoExperience.outputMsg("-- 'trackinggui' for GUI output")
		EchoExperience.outputMsg("-- 'startsession', 'pausesession', 'deletesession', 'newsession', 'sessionsreport' " )
		EchoExperience.outputMsg("-- 'showlifetime', 'clearlifetimedata' ")
		EchoExperience.outputMsg("Gui/Console commands:")
		EchoExperience.outputMsg("-- 'litanygui' to show (alpha ui) for litany of blood")
		EchoExperience.outputMsg("debug commands include:")
		EchoExperience.outputMsg("-- 'debug', 'testexp', 'testloot', 'testfull' ")
    -- MAIN
  elseif #options == 1 and options[1] then
    if options[1] == "debug" or options[1] == "d" then
      local dg = EchoExperience.savedVariables.debug
      EchoExperience.savedVariables.debug = not dg
      EchoExperience.outputMsg("Debug = " .. tostring(EchoExperience.savedVariables.debug) )
    elseif options[1] == "outputs" then
      EchoExperience.ShowOutputs()
    elseif options[1] == "defaults" then
      EchoExperience.ShowDefaults()
    elseif options[1] == "mute" then
      EchoExperience:DoMute()
    elseif options[1] == "unmute" then
      EchoExperience:DoUnMute()
    --
    elseif options[1] == "history" or options[1] == "h" then
      EchoExperience:ToggleLootHistoryFrame()    
    elseif options[1] == "lhclear" or options[1] == "lhc" then
      EchoExperience:LH_ClearLootHistory()
    elseif options[1] == "eh" or options[1] == "ehs" then
      EchoExperience:ToggleExpHistoryFrame()
    -- BETA
    elseif options[1] == "litanygui" then
      EchoExperience:ToggleLitanyFrame()
    --
    elseif options[1] == "showtracking" then
      EchoExperience.ShowTracking(EchoExperience:GetCurrentTrackingSession())
    elseif options[1] == "showlifetime" then
      EchoExperience.ShowLifetimeTracking()
      EchoExperience.CheckVerifyDefaults()
    elseif options[1] == "clearlifetimedata" then
      EchoExperience.savedVariables.lifetime = {}
    --TRACKING SESSIONS 
    --'startsession', 'pausesession', 'deletesession', 'newsession' "
    elseif options[1] == "trackinggui" or options[1] == "tg" or options[1] == "trackingui" or options[1] == "showtrackinggui" then
      EchoExperience:ToggleTrackingFrame()
    elseif options[1] == "startsession" then
      EchoExperience:TrackingSessionStart()
    elseif options[1] == "pausesession" then
      EchoExperience:TrackingSessionPause()
    elseif options[1] == "deletesession" then
      EchoExperience:TrackingSessionDelete()
    elseif options[1] == "newsession" then
      EchoExperience:TrackingSessionNew()
    elseif #options == 2 and options[1] == "showsession" then
      local sessionNum = options[2]
      EchoExperience:TrackingSessionShow(sessionNum)
    elseif #options == 2 and options[1] == "sessionsreport" then  
      EchoExperience.TrackingSessionShowSessionReport()
    elseif options[1] == "cleartracking" then
      EchoExperience:TrackingSessionClear()
      EchoExperience.outputMsg("Tracking data reset")
    --
    elseif options[1] == "startexptrack" then
      EchoExperience.outputToChanel("Start tracking exp")
      EchoExperience.view.startexptracking = true  
      EchoExperience.view.exptracking = {}
      EchoExperience.view.exptracking.startexp = -1
      EchoExperience.view.exptracking.endexp   = -1
    elseif options[1] == "stopexptrack" or options[1] == "endexptrack"  then
      EchoExperience.outputToChanel("End tracking exp")
      EchoExperience.view.startexptracking = false
      EchoExperience.EndExperienceTracking()
    --
    --
    --Testing
    elseif options[1] == "testevents" then
      EchoExperience.savedVariables.showGuildMisc  = not EchoExperience.savedVariables.showGuildMisc
      EchoExperience.outputMsg("ShowGuildMisc = " .. tostring(EchoExperience.savedVariables.showGuildMisc) )
      EchoExperience.SetupGuildEvents()
	elseif options[1] == "test1" then
		EchoExperience.RunTest1()
	elseif options[1] == "test2" then
		EchoExperience.RunTest2()
    elseif options[1] == "testexp" then
      EchoExperience.outputToChanel("Gained 0 xp in [Test] (1000/10000) need 9000xp",EchoExperience.staticdata.msgTypeEXP)
    elseif options[1] == "testloot" then
      EchoExperience.outputToChanel("You looted TESTITEM.",EchoExperience.staticdata.msgTypeLOOT)    
      --eventCode,receivedBy,itemName,quantity,soundCategory,lootType,isSelf,
      --isPickpocketLoot,questItemIcon,itemId,isStolen)
      local pName = GetUnitName("player")
      EchoExperience.OnLootReceived(1, pName,   "Rough Maple",1,nil,1,true,false,false,802,false)
      EchoExperience.OnLootReceived(1,"Player1","Deni",1,nil,1,false,false,false,45833,false)
      EchoExperience.OnLootReceived(1,"Player2","Rough Maple",1,nil,1,false,false,false,802,false)
      
    elseif options[1] == "testfull" then		--eventCode,receivedBy,itemName,quantity,soundCategory,lootType,isSelf,isPickpocketLoot,questItemIcon,itemId,isStolen)
      EchoExperience.OnLootReceived(0,"testuser","testitem",1,nil,nil,true,false,false,0,false)
      EchoExperience.OnLootReceived(0,"testuser","testitem",2,nil,nil,true,false,false,0,false)
      EchoExperience.OnLootReceived(0,"testuser","testitem",2,nil,nil,false,false,false,0,false)
      for i = ITEM_QUALITY_TRASH, ITEM_QUALITY_LEGENDARY do --for i = 0, 5 do
        local color = GetItemQualityColor(i)
        local qualName = GetString("SI_ITEMQUALITY", i)
        d("I="..tostring(i).."color=".. color:Colorize(qualName) )
      end
    elseif options[1] == "testchars" then
      d("Here's a list of your characters:")
      for i = 1, GetNumCharacters() do
        local name, gender, level, classId, raceId, alliance, id, locationId = GetCharacterInfo(i)
        d( zo_strformat("char: name:<<1>> id:<<2>> loc:<<3>>", name, id, locationId) )
      end
    elseif options[1] == "iam" then  
      d("Display Name: ".. tostring(EchoExperience.view.iamDisplayName)   )
      d("Char Name: "   .. tostring(EchoExperience.view.iamCharacterName) )
    end
  elseif #options == 2 and options[1] then  
    --
  end
  --
end
------------------------------

------------------------------
------------------------------
----[Section] Addon Setup 
------------------------------

------------------------------
-- SETUP-- and is only called on reloadui, not quit?
function EchoExperience.OnAddOnUnloaded(event)
  --EchoExperience.debugMsg("OnAddOnUnloaded called") -- Prints to chat.
  --EchoExperience:Savesettings()
  --EchoExperience.debugMsg("OnAddOnUnloaded done") -- Prints to chat.
end

------------------------------
-- SETUP on player activated called delayed start
function EchoExperience.Activated(e)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name, EVENT_PLAYER_ACTIVATED)	
	local strI = GetString(SI_ECHOEXP_MESSAGE)
	--local strL = zo_strformat(strI, EchoExperience.version )
    d( EchoExperience.name.."v"..EchoExperience.version .. strI ) -- Prints to chat.
	--
    --ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil,
    --    EchoExperience.name .. GetString(SI_NEW_ADDON_MESSAGE)) -- Top-right alert.
	--
    EchoExperience.SetupView()
    EchoExperience.SetupDefaultColors()
    EchoExperience.InitializeGui()
    zo_callLater(EchoExperience.DelayedStart, 2000)
end

------------------------------
-- SETUP
function EchoExperience.OnAddOnLoaded(event, addonName)
	if addonName ~= EchoExperience.name then return end
	EVENT_MANAGER:UnregisterForEvent(EchoExperience.name, EVENT_ADD_ON_LOADED)
	--
	EchoExperience.savedVariables   = ZO_SavedVars:New("EchoExperienceSavedVariables", 1, nil, defaultSettings)
	EchoExperience.accountVariables = ZO_SavedVars:NewAccountWide("EchoExperienceAccountSavedVariables", 1, nil, nil)
	--
	EchoExperience.pre_view = {}
	EchoExperience.pre_view.asyncName = "EchoExperienceAchieveAsync"
	EchoExperience.pre_view.async = LibAsync
	if(EchoExperience.pre_view.async ~= nil) then
		EchoExperience.pre_view.task = EchoExperience.pre_view.async:Create(EchoExperience.pre_view.asyncName)
		EchoExperience.debugMsg2("Created ASYNC Task" )
	else
		EchoExperience.debugMsg2("Created NOT !!! ASYNC Task" )
	end
  --
  EchoExperience.InitSettings() --Setup Addon Settings MENU
  EchoExperience.BuildSettings()
  -- Slash commands must be lowercase. Set to nil to disable.
  SLASH_COMMANDS["/echoexp"] = EchoExperience.SlashCommandHandler
  -- Reset autocomplete cache to update it.
  --SLASH_COMMAND_AUTO_COMPLETE:InvalidateSlashCommandCache()
end

------------------------------
-- AUTO CALLED
-- SETUP When player is ready, after everything has been loaded.
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_PLAYER_ACTIVATED, EchoExperience.Activated)
-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_ADD_ON_LOADED, EchoExperience.OnAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_PLAYER_DEACTIVATED, EchoExperience.OnAddOnUnloaded)
---------------------------------
--[[ EchoExp                 ]]-- 
---------------------------------