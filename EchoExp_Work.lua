---------------------------------
--[[ EchoExp : WORK          ]]-- 
---------------------------------

------------------------------
------------------------------
----[Section] USERACTION
------------------------------

------------------------------
-- USERACTION
function EchoExperience:ShowOutputs()
	EchoExperience.outputMsg("")
	EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.expsettings,   "**EXP outputs**")
	EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.lootsettings,  "**LOOT outputs**", EchoExperience.staticdata.msgTypeLOOT)
	EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.questsettings, "**Quest outputs**",EchoExperience.staticdata.msgTypeQuest)
	EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.guildsettings, "**GUILD outputs**",EchoExperience.staticdata.msgTypeGUILD)
end

------------------------------
-- USERACTION OUTPUT
function EchoExperience:ShowOutputsSub(dataSettings, headerText, msgType)
	if dataSettings == nil then  
		EchoExperience.outputMsg("No "..headerText.." configured")
		return
	end   
    EchoExperience.outputMsg(headerText)
	
    for k, v in pairs(dataSettings) do
		local c = ZO_ColorDef:New(v.color.r, v.color.g, v.color.b, v.color.a)
		local ctext = c:Colorize("COLOR")
		local cVals = zo_strformat( "r=<<1>>/g=<<2>>/b=<<3>>/a=<<4>>",
		string.format("%.3d",( (255*v.color.r) ) ),
		string.format("%.3d",( (255*v.color.g) ) ),
		string.format("%.3d",( (255*v.color.b) ) ),
		string.format("%.3d",( (255*v.color.a) ) )  )
		local wintab= zo_strformat( "--win=<<1>>, tab=<<2>>", v.window,v.tab )
		local gval      = ""
		local extratext = ""
		--
		if(msgType==EchoExperience.staticdata.msgTypeLOOT)then
			gval=""
			--"itemLoot" "groupLoot" TODO
		end      
		--
		if(msgType==EchoExperience.staticdata.msgTypeGUILD) then
			gval = "[Show all]"
			if(v.guilds~=nil) then
				gval = "[Guilds="
				for i,v in pairs(v.guilds) do
					local gname = EchoExperience:GetGuildName(i)
					gval = zo_strformat( "<<1>> <<2>>", gval, gname, tostring(i) )
				end
				gval = gval .. "]"
			end            
		end
		--
		local val = zo_strformat( "<<1>>, color=<<2>> (<<3>>) <<4>> <<5>>", wintab,ctext,cVals, gval,extratext )
		EchoExperience.outputRawMsg(val)
	end
end

------------------------------
-- USERACTION
function EchoExperience:ShowDefaults()
  EchoExperience:ShowOutputsSub(EchoExperience.accountVariables.defaults.expsettings,   "EXP defaults")
  EchoExperience:ShowOutputsSub(EchoExperience.accountVariables.defaults.lootsettings,  "LOOT defaults",EchoExperience.staticdata.msgTypeLOOT)
  EchoExperience:ShowOutputsSub(EchoExperience.accountVariables.defaults.guildsettings, "GUILD defaults",EchoExperience.staticdata.msgTypeGUILD)
  EchoExperience:ShowOutputsSub(EchoExperience.accountVariables.defaults.questsettings, "Quest defaults",EchoExperience.staticdata.msgTypeQuest)
end

------------------------------
-- TRACKING User command
function EchoExperience:ShowTracking(trackingTableElement)
  d ( zo_strformat( "<<1>> (<<2>>) <<3>>","Session Tracked ", tostring(EchoExperience.savedVariables.sessiontracking), "Start==>") )
  --
  if(trackingTableElement~=nil) then
	  d ( "General:") 
	  for k, v in pairs(trackingTableElement) do
		  for kk, vv in pairs(trackingTableElement[k]) do
			if(vv~=nil and vv.quantity~=nil)then
			  d ( zo_strformat( "<<3>>=<<2>>",kk, vv.quantity, vv.itemlink) )
			end
		  end
	  end
	  --
	   d ( "Specfic") 
	  for k, v in pairs(trackingTableElement.items) do
		if(v~=nil and v.quantity~=nil)then
		  d ( zo_strformat( "<<3>>=<<2>>",k, v.quantity, v.itemlink) )
		end
	  end
	  for k, v in pairs(trackingTableElement.currency) do
		if(v~=nil and v.quantity~=nil)then
		  local currname = GetCurrencyName(k, true, false)
		  d ( zo_strformat( "<<1>>=<<2>>", currname, v.quantity) )
		  d ( zo_strformat( "--plus=<<2>>", currname, v.plus) )
		  d ( zo_strformat( "--minus=<<2>>", currname, v.minus) )
		end
	  end  
	  for k, v in pairs(trackingTableElement.mobs) do
		if(v~=nil and v.quantity~=nil)then
		  local ctype = EchoExperience:GetCombatUnitType(v.targetType)
		  d ( zo_strformat( "<<1>>=<<2>> (<<4>>)", k, v.quantity, v.itemlink, ctype)  )
		end
	  end
  end -- nil check 
  d("<==Session Tracked Done")
  --EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.expsettings,   "EXP outputs")
  --EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.lootsettings,  "LOOT outputs", EchoExperience.staticdata.msgTypeLOOT)
  --EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.guildsettings, "GUILD outputs",EchoExperience.staticdata.msgTypeGUILD)
end

------------------------------
-- TRACKING
function EchoExperience:ShowLifetimeTracking()
  --
end

------------------------------
-- USERACTION
function EchoExperience:DoMute()
  -- Save current values
  EchoExperience.savedVariables.mutedprevious = {}
  EchoExperience.savedVariables.mutedprevious.verboseExp      = EchoExperience.savedVariables.verboseExp
  EchoExperience.savedVariables.mutedprevious.showLoot        = EchoExperience.savedVariables.showLoot
  EchoExperience.savedVariables.mutedprevious.extendedLoot    = EchoExperience.savedVariables.extendedLoot 
  EchoExperience.savedVariables.mutedprevious.groupLoot       = EchoExperience.savedVariables.groupLoot
  EchoExperience.savedVariables.mutedprevious.showItemLoot    = EchoExperience.view.settingstemp.showItemLoot
  EchoExperience.savedVariables.mutedprevious.showGroupLoot   = EchoExperience.view.settingstemp.showGroupLoot
  EchoExperience.savedVariables.mutedprevious.showGuildLogin  = EchoExperience.savedVariables.showGuildLogin
  EchoExperience.savedVariables.mutedprevious.showGuildLogout = EchoExperience.savedVariables.showGuildLogout
  
  -- Settings
  EchoExperience.savedVariables.verboseExp    = false
  EchoExperience.savedVariables.showLoot      = false
  EchoExperience.savedVariables.extendedLoot  = false
  EchoExperience.savedVariables.groupLoot     = false
  EchoExperience.view.settingstemp.showItemLoot  = false
  EchoExperience.view.settingstemp.showGroupLoot = false
  EchoExperience.savedVariables.showGuildLogin   = false
  EchoExperience.savedVariables.showGuildLogout  = false
  --
  EchoExperience.SetupLootGainsEvents(false)
  EchoExperience.outputMsg("Muted")
end

------------------------------
-- USERACTION
function EchoExperience:DoUnMute()
  if(EchoExperience.savedVariables.mutedprevious == nil) then
    EchoExperience.outputMsg("Already UnMuted...?")
  else      
    EchoExperience.savedVariables.verboseExp       = EchoExperience.savedVariables.mutedprevious.verboseExp   
    EchoExperience.savedVariables.showLoot         = EchoExperience.savedVariables.mutedprevious.showLoot     
    EchoExperience.savedVariables.extendedLoot     = EchoExperience.savedVariables.mutedprevious.extendedLoot 
    EchoExperience.savedVariables.groupLoot        = EchoExperience.savedVariables.mutedprevious.groupLoot    
    EchoExperience.view.settingstemp.showItemLoot  = EchoExperience.savedVariables.mutedprevious.showItemLoot 
    EchoExperience.view.settingstemp.showGroupLoot = EchoExperience.savedVariables.mutedprevious.showGroupLoot   
    EchoExperience.savedVariables.showGuildLogin   = EchoExperience.savedVariables.mutedprevious.showGuildLogin  
    EchoExperience.savedVariables.showGuildLogout  = EchoExperience.savedVariables.mutedprevious.showGuildLogout 
  end
  EchoExperience.outputMsg("UnMuted")
end
------------------------------


------------------------------
------------------------------
----[Section] UTIL
------------------------------

------------------------------
-- 
function EchoExperience.starts_with(str, start)
	return str:sub(1, #start) == start
end

------------------------------
-- UTIL
function EchoExperience:GetCombatUnitType(gnum)
  --EchoExperience.debugMsg("GetGuildName:=".. gnum.. " name='"..GetGuildName(gnum).."'")  
  local ret = nil
  if(gnum==nil) then return ret end
  if(gnum==COMBAT_UNIT_TYPE_GROUP) then return "Group" end
  if(gnum==COMBAT_UNIT_TYPE_NONE) then return "None" end
  if(gnum==COMBAT_UNIT_TYPE_OTHER) then return "Other" end
  if(gnum==COMBAT_UNIT_TYPE_PLAYER) then return "Player" end
  if(gnum==COMBAT_UNIT_TYPE_PLAYER_PET) then return "Pet" end
  if(gnum==COMBAT_UNIT_TYPE_TARGET_DUMMY) then return "Dummy" end
end

------------------------------
-- UTIL
function EchoExperience:GetGuildName(gnum)
  if(EchoExperience.view.guildnames==nil) then
    EchoExperience.view.guildnames = {}
  end
  local gname = EchoExperience.view.guildnames[gnum];
  if(gname==nil) then
    gname = GetGuildName(gnum)
    EchoExperience.view.guildnames[gnum] = gname
  else
    EchoExperience.debugMsg2("GetGuildName: used *cache*")
  end
  EchoExperience.debugMsg2("GetGuildName: num=", gnum, " name='", gname, "'")  
  return gname
end    

------------------------------
-- UTIL
function EchoExperience:GetGuildId(gnum)
  if(EchoExperience.view.guildids==nil) then
    EchoExperience.view.guildids = {}
  end
  local gid = EchoExperience.view.guildids[gnum];
  if(gid==nil) then
    gid = GetGuildId(gnum)
    EchoExperience.view.guildids[gnum] = gid
  else
    EchoExperience.debugMsg2("GetGuildId: used *cache*")
  end
  EchoExperience.debugMsg2("GetGuildId:=", gnum, " gid='", gid, "'")  
  return gid
end

------------------------------
-- UTIL
function EchoExperience:GetBagNameFromID(bnum)
  EchoExperience.debugMsg2("GetBagNameFromID: id: ", tostring(bnum), "'")
  if(bnum==BAG_BACKPACK) then
    return "Backpack"
  elseif(bnum==BAG_BANK) then
    return "Bank"
  elseif(bnum==BAG_BUYBACK) then
    return "Buyback"
  elseif(bnum==BAG_GUILDBANK) then
    return "GuildBank"
  elseif(bnum==BAG_SUBSCRIBER_BANK) then
    return "SubscriberBank"
  elseif(bnum==BAG_VIRTUAL) then
    return "Virtual"
  elseif(bnum==BAG_WORN) then
    return "Worn"
  elseif(bnum==BAG_HOUSE_BANK_TEN) then
    return "Bank10?"
  elseif(bnum==BAG_HOUSE_BANK_NINE) then
    return "Bank9?"
  elseif(bnum==BAG_HOUSE_BANK_EIGHT) then
    return "Bank8?"
  elseif(bnum==BAG_HOUSE_BANK_SEVEN) then
    return "Bank7?"
  elseif(bnum==BAG_HOUSE_BANK_SIX) then
    return "Bank6?"
  elseif(bnum==BAG_HOUSE_BANK_FIVE) then
    return "Bank5?"
  elseif(bnum==BAG_HOUSE_BANK_FOUR) then
    return "Bank4?"
  elseif(bnum==BAG_HOUSE_BANK_THREE) then
    return "Bank3?"
  elseif(bnum==BAG_HOUSE_BANK_TWO) then
    return "Bank2?"
  elseif(bnum==BAG_HOUSE_BANK_ONE) then
    return "Bank1?"
  else 
    return "Bag"
  end
end

------------------------------
-- UTIL Helper that Wraps text with a color.
function EchoExperience.Colorize(text, color)
    if  color == nil then return text end
    text = "|c" .. color .. text .. "|r"
    return text
end

------------------------------
-- UTIL
function EchoExperience:deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[EchoExperience:deepcopy(orig_key)] = EchoExperience:deepcopy(orig_value)
        end
        setmetatable(copy, EchoExperience:deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

------------------------------
-- UTIL
function EchoExperience.lookupExpSourceText(reasonId)
  local retVal = GetString(SI_ECHOEXP_LEST_GAIN) .. "("..tostring(reasonId)..")"
  if(reasonId == nil) then
  elseif(reasonId==PROGRESS_REASON_ACHIEVEMENT) then
    retVal = GetString(SI_ECHOEXP_LEST_ACHIEVE)
  elseif(reasonId==PROGRESS_REASON_ACTION) then
    retVal = GetString(SI_ECHOEXP_LEST_ACTION)
  elseif(reasonId==PROGRESS_REASON_ALLIANCE_POINTS) then
    retVal = GetString(SI_ECHOEXP_LEST_AP)
  elseif(reasonId==PROGRESS_REASON_AVA) then
    retVal = GetString(SI_ECHOEXP_LEST_AVA)
  elseif(reasonId==PROGRESS_REASON_BATTLEGROUND) then
    retVal = GetString(SI_ECHOEXP_LEST_BG)
  elseif(reasonId==PROGRESS_REASON_BOOK_COLLECTION_COMPLETE) then
    retVal = GetString(SI_ECHOEXP_LEST_COLLECTION)
  elseif(reasonId==PROGRESS_REASON_BOSS_KILL) then
    retVal = GetString(SI_ECHOEXP_LEST_BOSSKILL)
  elseif(reasonId==PROGRESS_REASON_COLLECT_BOOK) then
    retVal = GetString(SI_ECHOEXP_LEST_COLLECTBOOK)
  elseif(reasonId==PROGRESS_REASON_COMMAND) then
    retVal = GetString(SI_ECHOEXP_LEST_COMMAND)
  elseif(reasonId==PROGRESS_REASON_COMPLETE_POI) then
    retVal = GetString(SI_ECHOEXP_LEST_COMPLETEPOI)
  elseif(reasonId==PROGRESS_REASON_DARK_ANCHOR_CLOSED) then
    retVal = GetString(SI_ECHOEXP_LEST_DARKANCHOR)
  elseif(reasonId==PROGRESS_REASON_DARK_FISSURE_CLOSED) then
    retVal = GetString(SI_ECHOEXP_LEST_FISSURE)
  elseif(reasonId==PROGRESS_REASON_DISCOVER_POI) then
    retVal = GetString(SI_ECHOEXP_LEST_DISCOVERPOI)
  elseif(reasonId==PROGRESS_REASON_DRAGON_KILL) then
    retVal = GetString(SI_ECHOEXP_LEST_DRAGONKILL)
  elseif(reasonId==PROGRESS_REASON_DUNGEON_CHALLENGE) then
    retVal = GetString(SI_ECHOEXP_LEST_DUNGEONCHALLENGE)
  elseif(reasonId==PROGRESS_REASON_EVENT) then
    retVal = GetString(SI_ECHOEXP_LEST_EVENT)
  elseif(reasonId==PROGRESS_REASON_FINESSE) then
    retVal = GetString(SI_ECHOEXP_LEST_FINESSE)
  elseif(reasonId==PROGRESS_REASON_GRANT_REPUTATION) then
    retVal = GetString(SI_ECHOEXP_LEST_REPUTATION)
  elseif(reasonId==PROGRESS_REASON_GUILD_REP) then
    retVal = GetString(SI_ECHOEXP_LEST_GUILDREP)
  elseif(reasonId==PROGRESS_REASON_JUSTICE_SKILL_EVENT) then
    retVal = GetString(SI_ECHOEXP_LEST_JUSTICESKILL)
  elseif(reasonId==PROGRESS_REASON_KEEP_REWARD) then
    retVal = GetString(SI_ECHOEXP_LEST_KEEPREWARD)
  elseif(reasonId==PROGRESS_REASON_KILL) then
    retVal = GetString(SI_ECHOEXP_LEST_KILL)
  elseif(reasonId==PROGRESS_REASON_LFG_REWARD) then
    retVal = GetString(SI_ECHOEXP_LEST_LFG)
  elseif(reasonId==PROGRESS_REASON_LOCK_PICK) then
    retVal = GetString(SI_ECHOEXP_LEST_LOCKPICK)
  elseif(reasonId==PROGRESS_REASON_MEDAL) then
    retVal = GetString(SI_ECHOEXP_LEST_MEDAL)
  elseif(reasonId==PROGRESS_REASON_NONE) then
    retVal = GetString(SI_ECHOEXP_LEST_NONE)
  elseif(reasonId==PROGRESS_REASON_OTHER) then
    retVal = GetString(SI_ECHOEXP_LEST_OTHER)
  elseif(reasonId==PROGRESS_REASON_OVERLAND_BOSS_KILL) then
    retVal = GetString(SI_ECHOEXP_LEST_WBKILL)
  elseif(reasonId==PROGRESS_REASON_PVP_EMPEROR) then
    retVal = GetString(SI_ECHOEXP_LEST_EMPEROR)
  elseif(reasonId==PROGRESS_REASON_QUEST) then
    retVal = GetString(SI_ECHOEXP_LEST_COMPLETEQUEST)
  elseif(reasonId==PROGRESS_REASON_REWARD) then
    retVal = GetString(SI_ECHOEXP_LEST_REWARD)
  elseif(reasonId==PROGRESS_REASON_SCRIPTED_EVENT) then
    retVal = GetString(SI_ECHOEXP_LEST_SCRIPTEVENT)
  elseif(reasonId==PROGRESS_REASON_SKILL_BOOK) then
    retVal = GetString(SI_ECHOEXP_LEST_SKILLBOOK)
  elseif(reasonId==PROGRESS_REASON_TRADESKILL) then
    retVal = GetString(SI_ECHOEXP_LEST_TRADESKILL)
  elseif(reasonId==PROGRESS_REASON_TRADESKILL_ACHIEVEMENT) then
    retVal = GetString(SI_ECHOEXP_LEST_TRADEACHIEVE)
  elseif(reasonId==PROGRESS_REASON_TRADESKILL_CONSUME) then
    retVal = GetString(SI_ECHOEXP_LEST_TRADECONSUME)
  elseif(reasonId==PROGRESS_REASON_TRADESKILL_HARVEST) then
    retVal = GetString(SI_ECHOEXP_LEST_HARVEST)
  elseif(reasonId==PROGRESS_REASON_TRADESKILL_QUEST) then
    retVal = GetString(SI_ECHOEXP_LEST_TRADEQUEST)
  elseif(reasonId==PROGRESS_REASON_TRADESKILL_RECIPE) then
    retVal = GetString(SI_ECHOEXP_LEST_RECIPE)
  elseif(reasonId==PROGRESS_REASON_TRADESKILL_TRAIT) then
    retVal = GetString(SI_ECHOEXP_LEST_TRAIT)
  elseif(reasonId==PROGRESS_REASON_WORLD_EVENT_COMPLETED) then
    retVal = GetString(SI_ECHOEXP_LEST_WORLDEVENT)
  end
  return retVal;
end



------------------------------
-- UI
function EchoExperience:RefreshTrackingUIData()
  --
  EOL_GUI_Header_Dropdown_Sessions.comboBox = EOL_GUI_Header_Dropdown_Sessions.comboBox or ZO_ComboBox_ObjectFromContainer(EOL_GUI_Header_Dropdown_Sessions)
   local comboBoxS = EOL_GUI_Header_Dropdown_Sessions.comboBox
  --local entry = comboBoxS:CreateItemEntry(0, OnItemSelect1S)
  --comboBoxS:AddItem(entry)
  if(EchoExperience.view.tracking.sessions==nil) then
  else
    for k, v in pairs(EchoExperience.view.tracking.sessions) do
      local entry = comboBoxS:CreateItemEntry(k, OnItemSelect1S)
      comboBoxS:AddItem(entry)
    end
  end
  comboBoxS:SetSelectedItem(k)
  --comboBoxS:SelectFirstItem()
  --
  --
end

------------------------------
-- TRACKING
function EchoExperience:TrackingSessionStart()
  EchoExperience.savedVariables.sessiontracking = true
  EchoExperience:GetCurrentTrackingSession()
  EchoExperience.outputMsg("SessionTracking Started")
  EchoExperience:SetupLootGainsEvents(true)
  EOL_GUI_Header_LabelStatus1:SetText("Session: ".. EchoExperience.view.tracking.currentsessionid)
  EOL_GUI_Header_LabelStatus2:SetText("Tracker IS started")
end

------------------------------
-- TRACKING
function EchoExperience:TrackingSessionPause()
		EchoExperience.savedVariables.sessiontracking = false
    EchoExperience.outputMsg("SessionTracking Paused")
    EchoExperience:SetupLootGainsEvents(true)
    EOL_GUI_Header_LabelStatus2:SetText("Tracker NOT started")
end

------------------------------
-- TRACKING
function EchoExperience:TrackingSessionDelete(sessionnum)
  --TODO
  if(EchoExperience.view.tracking.viewsessionid==nil) then
    return
  end
  EchoExperience.view.tracking.sessions[sessionnum] = nil
  --TODO
end

------------------------------
-- TRACKING
function EchoExperience:TrackingSessionShow(sessionnum)
  --TODO
  if(EchoExperience.view.tracking.sessions==nil) then
    return
  end
  local oldsession = EchoExperience.view.tracking.sessions[sessionnum]
  if(oldsession~=nil) then
    EchoExperience.outputMsg("Old session Report for id:" .. tostring(sessionnum) )
    EchoExperience.ShowTracking(oldsession)
  end
  --TODO
end

------------------------------
-- TRACKING
function EchoExperience:TrackingSessionShowSessionReport()
  --TODO
  if(EchoExperience.view.tracking.sessions==nil) then
    EchoExperience.outputMsg("There are no saved sessions")
    return
  end
  for k, v in pairs(EchoExperience.view.tracking.sessions) do
     EchoExperience.outputMsg("Saved Sessions:")
     EchoExperience.outputMsg("sessionid: " .. tostring(k) )
  end
  --TODO
end

------------------------------
-- TRACKING
-- If called with new, makes a new id at the end of the list
-- If called with an id, and it exists.... TODO
function EchoExperience:TrackingSessionNew(newid)
  if(EchoExperience.view.tracking==nil) then
    EchoExperience.view.tracking = {}
  end
  if(EchoExperience.view.tracking.sessions==nil) then
    EchoExperience.view.tracking.sessions = {}
    EchoExperience.view.tracking.sessionidlast = 0
  end
  if(EchoExperience.view.tracking.sessionidlast==nil) then
    EchoExperience.view.tracking.sessionidlast = 0
  end
  if(newid==nil) then
    newid = EchoExperience.view.tracking.sessionidlast + 1
  end
  --stop last session, move to this one?
  EchoExperience.view.tracking.currentsessionid = newid
  EchoExperience.view.tracking.viewsessionid    = newid  
  EchoExperience.view.tracking.sessionidlast    = newid
  EchoExperience.debugMsg2("TrackingSessionNew: "
      , " newid="..tostring(newid)
    )
  --
  local newsession = {}
    newsession.items    = {}
    newsession.currency = {}
    newsession.mobs     = {}
    newsession.mob      = {} --??
    newsession.bg       = {}
    newsession.achievements = {}
    newsession.id       = EchoExperience.view.tracking.currentsessionid
  EchoExperience.view.tracking.sessions[EchoExperience.view.tracking.currentsessionid] = newsession
  
  --Refresh DROPDOWN
  EchoExperience:RefreshTrackingUIData()  
end

------------------------------
-- TRACKING
function EchoExperience:TrackingSessionClear()
  local currentSession = EchoExperience:GetCurrentTrackingSession()
  currentSession = {}
  EchoExperience:TrackingBlankEntry(currentSession)
end

------------------------------
-- TRACKING
function EchoExperience:TrackingBlankEntry(currentSession, currentId)
  currentSession.items = {}
  currentSession.currency = {}
  currentSession.mobs = {}
  currentSession.bg = {}
  currentSession.achievements = {}
  if(currentId~=nil) then
    currentSession.id = currentId
  end
  return currentSession
end

------------------------------
-- TRACKING
function EchoExperience:GetCurrentTrackingSession()
  if(EchoExperience.view.tracking==nil) then
    EchoExperience.view.tracking = {}
  end
  if(EchoExperience.view.tracking.currentsessionid==nil) then
    EchoExperience.view.tracking.currentsessionid = 1
  end
  if(EchoExperience.view.tracking.sessionid==nil) then
    EchoExperience.view.tracking.sessionid = 1
  end
  if(EchoExperience.view.tracking.sessions==nil) then
    EchoExperience.view.tracking.sessions = {}
  end
  
  local currentSession = EchoExperience.view.tracking.sessions[EchoExperience.view.tracking.currentsessionid]
  if(currentSession==nil) then
    --EchoExperience.view.tracking.sessions[EchoExperience.view.tracking.currentsessionid] = newsession
    EchoExperience:TrackingSessionNew()
    EchoExperience.debugMsg2("GetCurrentTrackingSession: "
      , " trackingsessionid="..tostring(EchoExperience.view.tracking.viewsessionid)
      , " trackingCurrentSession="..tostring(EchoExperience.view.tracking.currentsessionid)
    )
    currentSession = EchoExperience.view.tracking.sessions[EchoExperience.view.tracking.currentsessionid]
  end
  return currentSession
end

------------------------------
-- TRACKING
function EchoExperience:GetTrackingSession(trackingid)
  local currentSession = EchoExperience.view.tracking.sessions[trackingid]
  if(currentSession==nil) then
    if(EchoExperience.view.trackingsessionid==nil) then
      EchoExperience.view.trackingsessionid = 0
    end
    currentSession = {}
    EchoExperience:TrackingBlankEntry(currentSession, EchoExperience.view.trackingsessionid)
  end
  return currentSession
end

------------------------------
-- TRACKING
function EchoExperience.EndExperienceTracking()
  local strL = zo_strformat("EndExperienceTracking: start: <<1>> end: <<2>>", 
    ZO_CommaDelimitNumber(EchoExperience.view.exptracking.startexp),
    ZO_CommaDelimitNumber(EchoExperience.view.exptracking.endexp)
  )
  EchoExperience.outputToChanel(strL)
end


------------------------------
-- UTIL
function EchoExperience:GetExtraInfo(itemName)
	local traitName = nil
	local traitType, traitDescription = GetItemLinkTraitInfo(itemName)
	--
	EchoExperience.debugMsg2("GetExtraInfo: traitType=" , tostring(traitType)
			, " traitDescription="  , tostring(traitDescription)
		)
	if (traitType ~= ITEM_TRAIT_TYPE_NONE) then
		traitName = GetString("SI_ITEMTRAITTYPE", traitType)
	end
	--bool hasSet, str setName, num numBonuses, num numEquipped, num maxEquipped, num setId
	local hasSet, setName, numBonuses, numEquipped, maxEquipped, setId = GetItemLinkSetInfo(itemName)
	EchoExperience.debugMsg2("GetExtraInfo:"
			, " hasSet="    , tostring(hasSet)
			, " setName="   , tostring(setName)
			, " setId="     , tostring(setId)
      , " traitName=" , tostring(traitName)
		)
	if( hasSet and setId > 0 ) then
		return traitName, setName
	end
	return traitName, nil
end

------------------------------
-- Tracking
function EchoExperience:ExpHistory(name,currentXP,nextRankXP,diff,thisGain, texture)
  if(EchoExperience.savedVariables.sessiontracking) then
    if(EchoExperience.view.exphistory == nil) then
      EchoExperience.view.exphistory = {}
    end
    --
    local elem = {}
    -- seconds in UTC based on the player's OS time.
    elem.timestr    = GetTimeString()
    elem.time       = GetTimeStamp()
    elem.frame      = GetFrameTimeSeconds()
    elem.name        = name
    elem.currentXP  = currentXP
    elem.nextRankXP = nextRankXP
    elem.diff       = diff
    elem.thisGain   = thisGain
    elem.texture    = texture
    --
    table.insert(EchoExperience.view.exphistory, elem)  
    EchoExperience.debugMsg2("ExpHistory", tostring(name) )    
    --
    --check max length and purge/remove old? TODO
    local cnt = #EchoExperience.view.exphistory
    if(cnt>EchoExperience.savedVariables.expHistoryMax) then
      local numtoremove = EchoExperience.savedVariables.expHistoryCull      
      for ii = 1, numtoremove do
        table.remove(EchoExperience.view.exphistory,1)
      end
    end
    --Update gui?
    if( not EOL_EXPHISTORY_Frame:IsControlHidden() ) then
      EchoExperience:EH_UpdateViewData()
    end
  end
end

---------------------------------
--[[ EchoExp : WORK          ]]-- 
---------------------------------