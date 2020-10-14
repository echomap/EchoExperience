--[[ EchoExp ]]-- 

------------------------------
-- 
EchoExperience = {
    name            = "EchoExperience",           -- Matches folder and Manifest file names.
    version         = "0.0.40",                   -- A nuisance to match to the Manifest.
    versionnumeric  = 40,                         -- A nuisance to match to the Manifest.
    author          = "Echomap",
    menuName        = "EchoExperience_Options",   -- Unique identifier for menu object.
    menuDisplayName = "EchoExperience",
    defaultMaxLines  = 10,
    defaultMaxLines2 = 15,
    view            = {},
    -- Saved settings.
    savedVariables = {},
    accountVariables = {},
    rgbaBase   = {
      ["r"] = 1,
      ["g"] = 1,
      ["b"] = 1,
      ["a"] = 0.9,
    },
    LitanyOfBlood = {
      version = 1,
      list = {
        ["Cimalire"] = { done=false, ZoneName="Skywatch",  },
        ["Dirdelas"] = { done=false, ZoneName="Elden Root",  },
        ["Calareth"] = { done=false, ZoneName="Marbruk",  },
        ["Sihada"]   = { done=false, ZoneName="Vulkwasten",  },
        ["Dablir"]   = { done=false, ZoneName="Rawl'Kha",  },
        ["Dinor Girano"]  = { done=false, ZoneName="Davon's Watch",  },
        ["Cindiri Malas"] = { done=false, ZoneName="Mournhold",  },
        ["Gideelar"] = { done=false, ZoneName="Stormhold",  },
        ["Hakida"] = { done=false, ZoneName="Windhelm",  },
        ["Eldfyr"] = { done=false, ZoneName="Riften",  },
        ["Cesarel Hedier"] = { done=false, ZoneName="Dagerfall",  },
        ["Alix Edette"] = { done=false, ZoneName="Wayrest",  },
        ["Bulag"] = { done=false, ZoneName="Shornhelm",  },
        ["Ebrayd"] = { done=false, ZoneName="Sentinel",  },
        ["Berea"] = { done=false, ZoneName="Evermore",  },
        
        --["Eilam"] = { done=false, ZoneName="Sentinel",  },
        --["Juwan"] = { done=false, ZoneName="Sentinel",  },
        },
     }
}
local msgTypeSYS     = 1
local msgTypeEXP     = 2
local msgTypeLOOT    = 4
local msgTypeGUILD   = 6 -- 
local msgTypeGUILD2  = 7 -- Guild Admin Messages
local msgTypeQuest   = 8

--local PCHAT = LibStub("PCHAT")
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
  showachievementmax     = 10,
  lorebooktracking       = false,  
  showalpha        = false,
  sessiontracking  = false,
  lifetimetracking = false,
  immersive = false,
}

------------------------------
-- UTIL
function EchoExperience.debugMsg(text)
	if EchoExperience.savedVariables.debug then
    local val = zo_strformat( "(EchoExp) <<1>>",text)
    d(val)
	end
end

------------------------------
-- UTIL
function EchoExperience.outputMsg(text)
  if text ~= nil then
    local val = zo_strformat( "[EchoExp] <<1>>",text)
    d(val)
  end
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
-- USERACTION
function EchoExperience:ShowOutputs()
  EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.expsettings,   "EXP outputs")
  EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.lootsettings,  "LOOT outputs", msgTypeLOOT)
  EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.guildsettings, "GUILD outputs",msgTypeGUILD)
  EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.questsettings, "Quest outputs",msgTypeQuest)
end

------------------------------
-- USERACTION
function EchoExperience:ShowDefaults()
  EchoExperience:ShowOutputsSub(EchoExperience.accountVariables.defaults.expsettings,   "EXP defaults")
  EchoExperience:ShowOutputsSub(EchoExperience.accountVariables.defaults.lootsettings,  "LOOT defaults",msgTypeLOOT)
  EchoExperience:ShowOutputsSub(EchoExperience.accountVariables.defaults.guildsettings, "GUILD defaults",msgTypeGUILD)
  EchoExperience:ShowOutputsSub(EchoExperience.accountVariables.defaults.questsettings, "Quest defaults",msgTypeQuest)
end

------------------------------
-- TRACKING User command
function EchoExperience:ShowTracking(trackingTableElement)
  d ( zo_strformat( "<<1>> (<<2>>) <<3>>","Session Tracked ", tostring(EchoExperience.savedVariables.sessiontracking), "Start==>") )
  --
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
  d("<==Session Tracked Done")
  --EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.expsettings,   "EXP outputs")
  --EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.lootsettings,  "LOOT outputs", msgTypeLOOT)
  --EchoExperience:ShowOutputsSub(EchoExperience.savedVariables.guildsettings, "GUILD outputs",msgTypeGUILD)
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
-- OUTPUT Main Output Function used by addon to control output and style
function EchoExperience.outputToChanel(text,msgType,filter)
	--Output to where
	if msgType == msgTypeSYS then
		d(text)
	elseif msgType == msgTypeEXP then
    EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.expsettings, filter )
    return
	elseif msgType == msgTypeLOOT then
    EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.lootsettings, filter)
    return
	elseif msgType == msgTypeGUILD then
    EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.guildsettings, filter)
  elseif msgType == msgTypeGUILD2 then
    EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.guildsettings, filter)
    --for later, when i seperate the LOGXX with the join/leave
  elseif msgType == msgTypeQuest then
    EchoExperience:outputToChanelSub(text, EchoExperience.savedVariables.questsettings, filter)
  end
  --
  if(EchoExperience.error)then
      EchoExperience.error = false
      EchoExperience.savedVariables.showGuildLogin  = false
      EchoExperience.savedVariables.showGuildLogout = false
      EchoExperience.outputMsg("Guild notifications are turned off")
  end
end

------------------------------
-- OUTPUT
function EchoExperience:ShowOutputsSub(dataSettings, headerText, msgType)
  if dataSettings ~= nil then
    EchoExperience.outputMsg(headerText)
    for k, v in pairs(dataSettings) do
      local c = ZO_ColorDef:New(v.color.r, v.color.g, v.color.b, v.color.a)
      local ctext = c:Colorize("COLOR")
      local cVals = zo_strformat( "r=<<1>>/g=<<2>>/b=<<3>>/a=<<4>>",
          string.format("%.3d",( (255*v.color.r) ) ),
          string.format("%.3d",( (255*v.color.g) ) ),
          string.format("%.3d",( (255*v.color.b) ) ),
          string.format("%.3d",( (255*v.color.a) ) )  )
      local gval = ""
      if(msgType==msgTypeLOOT)then
        gval=""
        --"itemLoot" "groupLoot"
      end      
      if(msgType==msgTypeGUILD) then
        gval = "[Show all]"
        if(v.guilds~=nil) then
          gval = "==["
          for i,v in pairs(v.guilds) do
            gval = zo_strformat( "<<1>>,<<2>>", gval, tostring(i) )
          end
          --gval = zo_strformat( "[g1=<<1>>/g2=<<2>>/g3=<<3>>/g4=<<4>>/g5=<<5>>]", tostring(v.guilds.guild1),tostring(v.guilds.guild2),tostring(v.guilds.guild3),tostring(v.guilds.guild4),tostring(v.guilds.guild5) )
        end            
      end
      local val = zo_strformat( "win=<<1>>, tab=<<2>>, color=<<3>> (<<4>>) <<5>>", v.window,v.tab,ctext,cVals,gval )
      EchoExperience.outputMsg(val)
    end
  else
    EchoExperience.outputMsg("No "..headerText.." configured")
  end 
end

------------------------------
-- OUTPUT
function EchoExperience:outputToChanelSub(text,outputSettings,filter)
  if(text==nil) then return end
  if outputSettings == nil then return end
  for k, v in pairs(outputSettings) do
    if(v.window~=nil and v.tab~=nil and v.window>0 and v.tab>0 and v.color~=nil and v.color.r~=nil) then
      local skip = false
      --filter
      if(filter~=nil and filter.type == msgTypeGUILD and v.guilds~=nil) then
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
    --
		EchoExperience.outputMsg("user commands include:")
    EchoExperience.outputMsg("-- 'outputs' to show in text what will happen ")
    EchoExperience.outputMsg("-- 'mute/unmute': should silence/unsilence EchoExp.")
    EchoExperience.outputMsg("The tracking module is in beta:")
    EchoExperience.outputMsg("-- 'showtracking' for text output, 'trackinggui' for GUI output")
    EchoExperience.outputMsg("-- 'startsession', 'pausesession', 'deletesession', 'newsession', 'sessionsreport' " )
    EchoExperience.outputMsg("-- 'showlifetime', 'clearlifetimedata' ")
    EchoExperience.outputMsg("Gui/Console commands:")
    EchoExperience.outputMsg("-- 'litanygui' to show alpha ui for litany of blood")
		EchoExperience.outputMsg("debug commands include:")
    EchoExperience.outputMsg("-- 'debug', 'testexp', 'testloot', 'testfull' ")
    -- MAIN
	elseif #options == 1 and options[1] == "outputs" then
		EchoExperience.ShowOutputs()
	elseif #options == 1 and options[1] == "defaults" then
		EchoExperience.ShowDefaults()
  elseif #options == 1 and options[1] == "mute" then
    EchoExperience:DoMute()
  elseif #options == 1 and options[1] == "unmute" then
    EchoExperience:DoUnMute()
    
  -- BETA
  elseif #options == 1 and options[1] == "litanygui" then
    EchoExperience:ToggleLitanyFrame()
    
  --Tracking
  elseif #options == 1 and options[1] == "trackinggui" then
    EchoExperience:ToggleTrackingFrame()
  elseif #options == 1 and options[1] == "trackingui" then
    EchoExperience:ToggleTrackingFrame()
	elseif #options == 1 and options[1] == "showtrackinggui" then
		EchoExperience:ToggleTrackingFrame()
	elseif #options == 1 and options[1] == "showtracking" then
		EchoExperience.ShowTracking(EchoExperience:GetCurrentTrackingSession())
  elseif #options == 1 and options[1] == "showlifetime" then
    EchoExperience.ShowLifetimeTracking()
    EchoExperience.CheckVerifyDefaults()
  elseif #options == 1 and options[1] == "clearlifetimedata" then
    EchoExperience.savedVariables.lifetime = {}
    
  --TRACKING SESSIONS 
  --'startsession', 'pausesession', 'deletesession', 'newsession' "
  elseif #options == 1 and options[1] == "startsession" then
    EchoExperience:TrackingSessionStart()
  elseif #options == 1 and options[1] == "pausesession" then
    EchoExperience:TrackingSessionPause()
  elseif #options == 1 and options[1] == "deletesession" then
    EchoExperience:TrackingSessionDelete()
  elseif #options == 1 and options[1] == "newsession" then
    EchoExperience:TrackingSessionNew()
  elseif #options == 2 and options[1] == "showsession" then
    local sessionNum = options[2]
    EchoExperience:TrackingSessionShow(sessionNum)
  elseif #options == 2 and options[1] == "sessionsreport" then  
    EchoExperience.TrackingSessionShowSessionReport()
  elseif #options == 1 and options[1] == "cleartracking" then
    EchoExperience:TrackingSessionClear()
    EchoExperience.outputMsg("Tracking data reset") 
  
  --
  --Testing
  elseif #options == 1 and options[1] == "testevents" then
    EchoExperience.savedVariables.showGuildMisc  = not EchoExperience.savedVariables.showGuildMisc
    EchoExperience.outputMsg("ShowGuildMisc = " .. tostring(EchoExperience.savedVariables.showGuildMisc) )
    EchoExperience.SetupGuildEvents()
	elseif #options == 1 and options[1] == "testexp" then
		EchoExperience.outputToChanel("Gained 0 xp in [Test] (1000/10000) need 9000xp",msgTypeEXP)
	elseif #options == 1 and options[1] == "testloot" then
		EchoExperience.outputToChanel("You looted TESTITEM.",msgTypeLOOT)    
    --eventCode,receivedBy,itemName,quantity,soundCategory,lootType,isSelf,
    --isPickpocketLoot,questItemIcon,itemId,isStolen)
    local pName = GetUnitName("player")
    EchoExperience.OnLootReceived(1, pName,   "Rough Maple",1,nil,1,true,false,false,802,false)
    EchoExperience.OnLootReceived(1,"Player1","Deni",1,nil,1,false,false,false,45833,false)
    EchoExperience.OnLootReceived(1,"Player2","Rough Maple",1,nil,1,false,false,false,802,false)
    
	elseif #options == 1 and options[1] == "testfull" then		--eventCode,receivedBy,itemName,quantity,soundCategory,lootType,isSelf,isPickpocketLoot,questItemIcon,itemId,isStolen)
		EchoExperience.OnLootReceived(0,"testuser","testitem",1,nil,nil,true,false,false,0,false)
		EchoExperience.OnLootReceived(0,"testuser","testitem",2,nil,nil,true,false,false,0,false)
		EchoExperience.OnLootReceived(0,"testuser","testitem",2,nil,nil,false,false,false,0,false)
    for i = ITEM_QUALITY_TRASH, ITEM_QUALITY_LEGENDARY do --for i = 0, 5 do
      local color = GetItemQualityColor(i)
      local qualName = GetString("SI_ITEMQUALITY", i)
      d("I="..tostring(i).."color=".. color:Colorize(qualName) )
    end
  elseif #options == 1 and options[1] == "testchars" then
    d("Here's a list of your characters:")
    for i = 1, GetNumCharacters() do
      local name, gender, level, classId, raceId, alliance, id, locationId = GetCharacterInfo(i)
      d( zo_strformat("char: name:<<1>> id:<<2>> loc:<<3>>", name, id, locationId) )
    end
  elseif #options == 1 and options[1] == "iam" then  
    d("Display Name: ".. tostring(EchoExperience.view.iamDisplayName)   )
    d("Char Name: "   .. tostring(EchoExperience.view.iamCharacterName) )
    
  --
  --
	elseif #options == 1 and options[1] == "debug" then
		local dg = EchoExperience.savedVariables.debug
		EchoExperience.savedVariables.debug = not dg
		EchoExperience.outputMsg("Debug = " .. tostring(EchoExperience.savedVariables.debug) )
	end
end

------------------------------
-- UI
function EchoExperience:ToggleLitanyFrame()
  EOL_GUI_Litany:SetHidden(not EOL_GUI_Litany:IsControlHidden())
  EEXPLitanyTooltip:SetParent(PopupTooltipTopLevel)
  --
  --
 	if not EOL_GUI_Litany:IsControlHidden() then
		--SetGameCameraUIMode(true)
		EchoExperience:Litany_GuiResizeScroll()
		EchoExperience:Litany_RefreshInventoryScroll()
	end
	EchoExperience:SaveFrameInfo("ToggleLitanyFrame")
end

------------------------------
-- UI
function EchoExperience:RefreshTrackingUIData()
  --
  EOL_GUI_Header_Dropdown_Sessions.comboBox = EOL_GUI_Header_Dropdown_Sessions.comboBox or ZO_ComboBox_ObjectFromContainer(EOL_GUI_Header_Dropdown_Sessions)
   local comboBoxS = EOL_GUI_Header_Dropdown_Sessions.comboBox
  --local entry = comboBoxS:CreateItemEntry(0, OnItemSelect1S)
  --comboBoxS:AddItem(entry)
  if(EchoExperience.view.trackingsessions==nil) then
  else
    for k, v in pairs(EchoExperience.view.trackingsessions) do
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
-- UI
function EchoExperience:ToggleTrackingFrame()
	EOL_GUI:SetHidden(not EOL_GUI:IsControlHidden())
  --EOL_GUI:SetHidden( not EOL_GUI:IsHidden() )
  --
  EEXPTooltip:SetParent(PopupTooltipTopLevel)
  
  --TRACKING SESSIONS
  EOL_GUI_Header_Dropdown_Sessions.comboBox = EOL_GUI_Header_Dropdown_Sessions.comboBox or ZO_ComboBox_ObjectFromContainer(EOL_GUI_Header_Dropdown_Sessions)
   local comboBoxS = EOL_GUI_Header_Dropdown_Sessions.comboBox
  comboBoxS:ClearItems()  
  comboBoxS:SetSortsItems(false)
  local function OnItemSelect1S(_, choiceText, choice)
    EchoExperience.view.trackingCurrentSession = choiceText
    --EchoExperience:UpdateScrollDataLinesData()
		--EchoExperience:GuiResizeScroll()
		--EchoExperience:RefreshInventoryScroll()
    PlaySound(SOUNDS.POSITIVE_CLICK)    
    EOL_GUI_Header_LabelStatus1:SetText("Session: ".. choiceText)--EchoExperience.view.trackingsessionid
    if(EchoExperience.savedVariables.sessiontracking)then
      EOL_GUI_Header_LabelStatus2:SetText("Tracker IS started")
    else
      EOL_GUI_Header_LabelStatus2:SetText("Tracker NOT started")
    end
  end
  EchoExperience:RefreshTrackingUIData()

  --
  EOL_GUI_Header_Dropdown_Main.comboBox = EOL_GUI_Header_Dropdown_Main.comboBox or ZO_ComboBox_ObjectFromContainer(EOL_GUI_Header_Dropdown_Main)
  local comboBox = EOL_GUI_Header_Dropdown_Main.comboBox
  comboBox:ClearItems()  
  comboBox:SetSortsItems(false)
  local function OnItemSelect1(_, choiceText, choice)
    --TODO
    --EchoesOfLore:debugMsg(" choiceText=" .. choiceText .. " choice=" .. tostring(choice) )  
    --EchoesOfLore:clearView()
    EchoExperience.view.trackingSelection = choiceText
    --EchoesOfLore:showViewTips2(choiceText)
    EchoExperience:UpdateScrollDataLinesData()
		EchoExperience:GuiResizeScroll()
		EchoExperience:RefreshInventoryScroll()
    PlaySound(SOUNDS.POSITIVE_CLICK)    
  end
  local validChoices = {}  
  table.insert(validChoices, "Session")
  --table.insert(validChoices, "Lifetime")
  for i = 1, #validChoices do
    local entry = comboBox:CreateItemEntry(validChoices[i], OnItemSelect1)
    comboBox:AddItem(entry)
  end
  --comboBox:SetHidden(true)
  --
	if not EOL_GUI:IsControlHidden() then
		--SetGameCameraUIMode(true)
		EchoExperience:GuiResizeScroll()
		EchoExperience:RefreshInventoryScroll()
	end
	--if not EchoExperience.data.dontFocusSearch then
		--EOL_GUI_SearchBox:TakeFocus()
	--end
  --EOL_GUI_Header_Dropdown_Main:TakeFocus()
  comboBox:SelectFirstItem()
	EchoExperience:SaveFrameInfo("ToggleInventoryFrame")
end

------------------------------
-- TRACKING
function EchoExperience:TrackingSessionStart()
  EchoExperience.savedVariables.sessiontracking = true
  EchoExperience:GetCurrentTrackingSession()
  EchoExperience.outputMsg("SessionTracking Started")
  EchoExperience:SetupLootGainsEvents(true)
  EOL_GUI_Header_LabelStatus1:SetText("Session: ".. EchoExperience.view.trackingsessionid)
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
  if(EchoExperience.view.trackingsessions==nil) then
    return
  end
  EchoExperience.view.trackingsessions[sessionnum] = nil
  --TODO
end

------------------------------
-- TRACKING
function EchoExperience:TrackingSessionShow(sessionnum)
  --TODO
  if(EchoExperience.view.trackingsessions==nil) then
    return
  end
  local oldsession = EchoExperience.view.trackingsessions[sessionnum]
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
  if(EchoExperience.view.trackingsessions==nil) then
    EchoExperience.outputMsg("There are no saved sessions")
    return
  end
  for k, v in pairs(EchoExperience.view.trackingsessions) do
     EchoExperience.outputMsg("Saved Sessions:")
     EchoExperience.outputMsg("sessionid: " .. tostring(k) )
  end
  --TODO
end

------------------------------
-- TRACKING
function EchoExperience:TrackingSessionNew(newid)
  --TODO
  if(EchoExperience.view.trackingsessions==nil) then
    EchoExperience.view.trackingsessions = {}
  end
  if(EchoExperience.view.trackingsessionid==nil) then
    EchoExperience.view.trackingsessionid = 1
  end
  if(newid==nil) then
    newid = EchoExperience.view.trackingsessionid
  end
  EchoExperience.view.trackingsessionid = newid
  local newsession = {}
    newsession.items    = {}
    newsession.currency = {}
    newsession.mobs     = {}
    newsession.mob      = {} --??
    newsession.bg       = {}
    newsession.id       = EchoExperience.view.trackingsessionid
  EchoExperience.view.trackingsessions[EchoExperience.view.trackingsessionid] = newsession
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
  if(EchoExperience.view.trackingCurrentSession==nil) then
    EchoExperience.view.trackingCurrentSession = 1
  end
  if(EchoExperience.view.trackingsessionid==nil) then
    EchoExperience.view.trackingsessionid = 1
  end
  if(EchoExperience.view.trackingsessions==nil) then
    EchoExperience.view.trackingsessions = {}
  end
  
  local currentSession = EchoExperience.view.trackingsessions[EchoExperience.view.trackingsessionid]
  if(currentSession==nil) then
    if(EchoExperience.view.trackingsessionid==nil) then
      EchoExperience.view.trackingsessionid = 1
    end
    EchoExperience.debugMsg2("GetCurrentTrackingSession: "
      , " trackingsessionid="..tostring(EchoExperience.view.trackingsessionid)
      , " trackingCurrentSession="..tostring(EchoExperience.view.trackingCurrentSession)
    )
    currentSession = {}
    EchoExperience:TrackingBlankEntry(currentSession, EchoExperience.view.trackingsessionid )
    --currentSession.id = EchoExperience.view.trackingsessionid
    EchoExperience.view.trackingsessions[EchoExperience.view.trackingsessionid] = currentSession
  end
  return currentSession
end

------------------------------
-- TRACKING
function EchoExperience:GetTrackingSession(trackingid)
  local currentSession = EchoExperience.view.trackingsessions[trackingid]
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
-- EVENT
--ONEvent  shows skill exp gains
--EVENT:   EVENT_SKILL_XP_UPDATE
--RETURNS:(num eventCode, SkillType skillType, num skillIndex, num reason, num rank, num previousXP, num currentXP)
--NOTES:  XX
function EchoExperience.OnSkillExperienceUpdate(eventCode, skillType, skillIndex, reason, rank, previousXP, currentXPIn)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnSkillExperienceUpdateWork(eventCode, skillType, skillIndex, reason, rank, previousXP, currentXPIn)
      end
    )
  else
    EchoExperience.OnSkillExperienceUpdateWork(eventCode, skillType, skillIndex, reason, rank, previousXP, currentXPIn)
  end
end

--
function EchoExperience.OnSkillExperienceUpdateWork(eventCode, skillType, skillIndex, reason, rank, previousXP, currentXPIn)
	local skillLineName, currentSkillRank, available = GetSkillLineInfo(skillType, skillIndex)
	local lastRankXP, nextRankXP, currentXP          = GetSkillLineXPInfo(skillType, skillIndex)
	
	local pressed, normal, mouseOver, announce = ZO_Skills_GetIconsForSkillType(skillType)
  -- (this used to work, but that stopped working? so put into ability gains)
  --Oh! there are changes to these calls when you hit 50! ??
	-- Output
	local diff = nextRankXP - currentXP
  --EchoExperience.outputMsg("skillLineName="..tostring(skillLineName) .. " available: " ..tostring(available).. " verboseExp: ".. tostring(EchoExperience.savedVariables.verboseExp)  )
	if skillLineName ~= nil and available 
      and EchoExperience.savedVariables.showSkillExp and EchoExperience.savedVariables.showAllSkillExp then
		local XPgain  = currentXP  - previousXP
		local curCur  = currentXP  - lastRankXP
		local curNext = nextRankXP - lastRankXP
		--EchoExperience.outputToChanel("You gained [" .. XPgain .. "] experience in [" .. skillLineName .."]")
		--EchoExperience.outputToChanel("    at "..curCur.."/"..curNext..", need [" .. diff .. "] more, experience")
		--FORMAT
		local qualifier = 2
		if( EchoExperience.savedVariables.verboseExp ) then
			qualifier = 1
		end
    --EchoExperience.outputMsg("qualifier=" ..tostring(qualifier) )
		local strI = GetString("SI_ECHOEXP_XP_SKILL_GAIN_",qualifier)
		local skillLineNameI = skillLineName
		if normal ~= nil and skillLineName~=nil then
			skillLineNameI = "|t14:14:"..normal.."|t" .. skillLineName
		end
		--EchoExperience.outputToChanel("skillLineNameI '"..skillLineNameI.."'", msgTypeEXP)
		local strL = zo_strformat(strI, ZO_CommaDelimitNumber(XPgain), skillLineNameI, ZO_CommaDelimitNumber(curCur), ZO_CommaDelimitNumber(curNext), ZO_CommaDelimitNumber(diff) )
		EchoExperience.outputToChanel(strL,msgTypeEXP)
		--EchoExperience.outputToChanel("Gained "..XPgain.."xp in [" ..skillLineName.."] ("..curCur.."/"..curNext..") need " .. diff .. "xp",msgTypeEXP)
	end
end

------------------------------
-- EVENT
--ONEvent  EVENT_SKILL_LINE_ADDED
--EVENT:   xx
--RETURNS: (number eventCode, SkillType skillType, number skillIndex, boolean advised)
--NOTES:  XX
function EchoExperience.OnSkillLineAdded(eventCode, skillType, skillIndex)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnSkillLineAddedWork(eventCode, skillType, skillIndex)
      end
    )
  else
    EchoExperience.OnSkillLineAddedWork(eventCode, skillType, skillIndex)
  end
end

--
function EchoExperience.OnSkillLineAddedWork(eventCode, skillType, skillIndex)
	--EchoExperience.debugMsg("OnSkillLineAdded. skillType="..tostring(skillType) .. " skillIndex="..tostring(skillIndex))
	EchoExperience.debugMsg2("echoexp test osla: skillType=", tostring(skillType), " skillIndex=", tostring(skillIndex) )
	--learn clothing, skillType=3 skillIndex=false
	if skillType ~= nil then
		local name, rank, discovered, skillLineId, advised, unlockText = GetSkillLineInfo(skillType, skillIndex)
		EchoExperience.debugMsg2("echoexp test osla: name=", tostring(name), " discovered=", tostring(discovered) )
		--GetSkillLineInfo(number SkillType skillType, number skillIndex)
        --Returns: string name, number rank, boolean discovered, number skillLineId, boolean advised, string unlockText
		if name ~= nil then --TODO discovered and ??
			--local strI = "You learned the skillline, <<1>>"
			local strI = GetString(SI_ECHOEXP_SKILLINE)
			local strL = zo_strformat(strI, name)
			EchoExperience.outputToChanel(strL,msgTypeEXP)
		end
	end
end

------------------------------
-- EVENT 
--ONEvent  TODO
--EVENT:   xx
--RETURNS:(num eventCode, xx)
function EchoExperience.OnChampionUnlocked(eventCode)
	--EchoExperience.debugMsg("OnChampionUnlocked")
	--FORMAT
	local strI = GetString(SI_ECHOEXP_CP_UNLOCKED)
	EchoExperience.outputToChanel(strI.." eventcode="..tostring(eventCode),msgTypeEXP)
	--EchoExperience.outputToChanel("You unlocked Champion points!".." eventcode="..tostring(eventCode),msgTypeEXP)
end

------------------------------
-- EVENT
--ONEvent  NOT NEEDED
--EVENT:   EVENT_ABILITY_PROGRESSION_XP_UPDATE
--RETURNS:(number eventCode, number progressionIndex, number lastRankXP, number nextRankXP, number currentXP, boolean atMorph)
--NOTES:  currentXP is new total xp, last is all the way back. (this used to be unnecessary as i used expgains, but that stopped working?)
function EchoExperience.OnAbilityExperienceUpdate(eventCode, progressionIndex, lastRankXP, nextRankXP, currentXP, atMorph)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnAbilityExperienceUpdateWork(eventCode, progressionIndex, lastRankXP, nextRankXP, currentXP, atMorph)
      end
    )
  else
    EchoExperience.OnAbilityExperienceUpdateWork(eventCode, progressionIndex, lastRankXP, nextRankXP, currentXP, atMorph)
  end
end

--
function EchoExperience.OnAbilityExperienceUpdateWork(eventCode, progressionIndex, lastRankXP, nextRankXP, currentXP, atMorph)
  --Only do this if want to show skillExp and skill has some to gain
  if( EchoExperience.savedVariables.showSkillExp and nextRankXP>0 and EchoExperience.savedVariables.showAllSkillExp ) then
    local name, morph, rank             = GetAbilityProgressionInfo(progressionIndex)     
    local name2, texture,  abilityIndex = GetAbilityProgressionAbilityInfo(progressionIndex, morph, rank)
    local diff =  nextRankXP - currentXP
    EchoExperience.debugMsg2("OnAbilityExperienceUpdate:"
      , " name="..tostring(name)
      , " name2="..tostring(name2)
      , " morph="..tostring(morph)
      , " diff="..tostring(diff)
    )
    
    --
    local nameFmt = name2
    local qualifier = 1
    local qualStr = "SI_ECHOEXP_XP_SKILLLINE_"
    if(EchoExperience.savedVariables.verboseExp) then
      qualifier = 3
    end
		if texture ~= nil then
      qualStr = "SI_ECHOEXP_XP_SKILLLINE_ICON_"
		end
    -- Check last saved value of XP
    local tableKey = tostring(name)
    local thisGain = nil
    if( EchoExperience.savedVariables.skilltracking ~= nil) then
      local skillElem = EchoExperience.savedVariables.skilltracking[tableKey]
      if( skillElem ~= nil ) then
        local lastCurrXp = skillElem.currXP
        thisGain = currentXP - lastCurrXp
        if(thisGain>0) then
           qualifier = qualifier + 1
        end
      end
    end
    
    -- NO ICON
    -- Qualifier: 1 non verb,  2 non verb w/currXP 2; 3 verb,  4 verb w/currXP
    -- HAS ICON
    -- Qualifier: 1 non verb,  2 non verb w/currXP 2; 3 verb,  4 verb w/currXP
    -- <<1>>name, <<2>> currentXP, <<3>> nextXP <<4>> diff, <<5>> thisGain, <<6>> icon
    local sentence = GetString(qualStr,qualifier)    
    local strL = zo_strformat(sentence, tostring(name2), ZO_CommaDelimitNumber(currentXP), ZO_CommaDelimitNumber(nextRankXP), ZO_CommaDelimitNumber(diff), thisGain, texture )
		EchoExperience.outputToChanel(strL,msgTypeEXP)
    -- Table to keep old values of player curent exp to be able to diff
    if(nextRankXP==0 or currentXP>nextRankXP) then
      EchoExperience.savedVariables.skilltracking[tableKey] = nil
      --TESTING
      EchoExperience.outputMsg("OnAbilityExperienceUpdate: removing skill "..name2.." per done?") --TODO
    else      
      EchoExperience.savedVariables.skilltracking[tableKey] = {}
      EchoExperience.savedVariables.skilltracking[tableKey].name2 = name2
      EchoExperience.savedVariables.skilltracking[tableKey].morph = morph
      EchoExperience.savedVariables.skilltracking[tableKey].currXP = currentXP
      EchoExperience.savedVariables.skilltracking[tableKey].nextRankXP = nextRankXP
    end
  end
end

  
------------------------------
-- EVENT
--ONEvent  on skill update ??
--EVENT:   EVENT_ABILITY_PROGRESSION_RANK_UPDATE
--RETURNS:(evebtCode, number progressionIndex, number rank, number maxRank, number morph)
--NOTES:  What is this for??? skillline gains are another method, as are exp gains
function EchoExperience.OnSkillProgressRankUpdate(eventCode, progressionIndex, rank, maxRank, morph)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnSkillProgressRankUpdateWork(eventCode, progressionIndex, rank, maxRank, morph)  
      end
    )
  else
    EchoExperience.OnSkillProgressRankUpdateWork(eventCode, progressionIndex, rank, maxRank, morph)  
  end
end
  
--
function EchoExperience.OnSkillProgressRankUpdateWork(eventCode, progressionIndex, rank, maxRank, morph)  
  if( not EchoExperience.savedVariables.showSkillExp ) then 
    return
  end
  if(rank==maxRank) then
    return
  end
  
  return
  --CANT FIGURE OUT WHAT THIS FUNCTION SHOULD BE DOING! Everything seems to be reported elsewhere,
  -- and this seems to report weird skill upgrades?
  --[[
  --
  EchoExperience.outputMsg2(EchoExperience.name , " OnSkillProgressRankUpdate: "
    , " eventCode=" , tostring(eventCode)
    , " progressionIndex="  , tostring(progressionIndex)
    , " rank="      , tostring(rank)
    , " maxRank="   , tostring(maxRank)
    , " morph="     , tostring(morph)
  )  
  local skillType,skillLineIndex,abilityIndex = GetSkillAbilityIndicesFromProgressionIndex(progressionIndex)
  local skillLineName, currentSkillRank = GetSkillLineInfo(skillType, skillLineIndex)
  EchoExperience.outputMsg2("OnSkillProgressRankUpdate: "
    , " skillLineName=" , tostring(skillLineName)
    , " currentSkillRank="  , tostring(currentSkillRank)
    , " skillType="      , tostring(skillType)
    , " maxRank="   , tostring(maxRank)
  )       
  if(maxRank==0) then
    EchoExperience.outputMsg2("OnSkillProgressRankUpdate: skipped per can't rank up")
  elseif(rank==maxRank) then
    EchoExperience.outputMsg2("OnSkillProgressRankUpdate: rank==maxrank and i dont know why its reported!")
  else
    
    --maxRank==0 == shortcircuit?
    --currentSkillRank> maxRank == shortcircuit?
    
    EchoExperience.outputMsg2("OnSkillProgressRankUpdate: "
      , "eventCode=" , tostring(eventCode)
      , " progressionIndex="  , tostring(progressionIndex)
      , " rank="      , tostring(rank)
      , " maxRank="   , tostring(maxRank)
      , " morph="     , tostring(morph)
    )   
    
    local skillType,skillLineIndex,abilityIndex = GetSkillAbilityIndicesFromProgressionIndex(progressionIndex)
    local skillLineName, currentSkillRank = GetSkillLineInfo(skillType, skillLineIndex)
    EchoExperience.outputMsg2("OnSkillProgressRankUpdate: "
      , " skillLineName=" , tostring(skillLineName)
      , " currentSkillRank="  , tostring(currentSkillRank)
      , " skillType="      , tostring(skillType)
      , " maxRank="   , tostring(maxRank)
    )       
    --
    local sentence = GetString(SI_ECHOEXP_XP_SKILLLINE_GAIN)  
    local strL = zo_strformat(sentence, skillLineName,currentSkillRank, skillType )
    EchoExperience.outputToChanel(strL,msgTypeEXP) 
  end
  --]]
end

------------------------------
-- EVENT
--ONEvent  on riding skill update
--EVENT:   EVENT_RIDING_SKILL_IMPROVEMENT
--RETURNS:(number eventCode, RidingTrainType ridingSkillType, number previous, number current, RidingTrainSource source))
--NOTES:  XX
function EchoExperience.OnRidingSkillUpdate(eventCode, ridingSkillType, previous, current, source)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnRidingSkillUpdateWork(eventCode, ridingSkillType, previous, current, source)
      end
    )
  else
    EchoExperience.OnRidingSkillUpdateWork(eventCode, ridingSkillType, previous, current, source)
  end
end
  
--
function EchoExperience.OnRidingSkillUpdateWork(eventCode, ridingSkillType, previous, current, source)
  if( not EchoExperience.savedVariables.showSkillExp ) then 
    return
  end
  --
  EchoExperience.debugMsg2(EchoExperience.name .. "OnSkillRankUpdate: "
    , " eventCode=" .. tostring(eventCode)
    , " ridingSkillType="  .. tostring(ridingSkillType)
    , " previous=" .. tostring(previous)
    , " current="       .. tostring(current)
    , " source="  .. tostring(source)
    , " RIDING_TRAIN_SPEED="  .. tostring(RIDING_TRAIN_SPEED)
    , " RIDING_TRAIN_STAMINA="  .. tostring(RIDING_TRAIN_STAMINA)
    , " RIDING_TRAIN_CARRYING_CAPACITY="  .. tostring(RIDING_TRAIN_CARRYING_CAPACITY)
  )
  --
  local sentence = GetString(SI_ECHOEXP_RIDING_UP)
  local trainingTypeWord = "UNKNOWNSKILL"
  local sourceWord       = "UNKNOWNSKILL"
  if(ridingSkillType == nil) then
  elseif(ridingSkillType==RIDING_TRAIN_SPEED) then
    trainingTypeWord = GetString(SI_ECHOEXP_RIDING_SPEED)
  elseif(ridingSkillType==RIDING_TRAIN_STAMINA) then
    trainingTypeWord = GetString(SI_ECHOEXP_RIDING_STAMINA)
  elseif(ridingSkillType==RIDING_TRAIN_CARRYING_CAPACITY) then
    trainingTypeWord = GetString(SI_ECHOEXP_RIDING_CARRY)
  end
  if(source == nil) then
  elseif(source==RIDING_TRAIN_SOURCE_INITIALIZE) then
    sourceWord = GetString(SI_ECHOEXP_RIDING_INIT)
  elseif(source==RIDING_TRAIN_SOURCE_ITEM) then
    sourceWord = GetString(SI_ECHOEXP_RIDING_ITEM)
  elseif(source==RIDING_TRAIN_SOURCE_STABLES) then
    sourceWord = GetString(SI_ECHOEXP_RIDING_STABLE)
  end
  --
  local strL = zo_strformat(sentence, eventCode, sourceWord, trainingTypeWord, previous, current )
  EchoExperience.outputToChanel(strL,msgTypeEXP)
end
  

------------------------------
-- EVENT
--ONEvent  on skillline rank update
--EVENT:   EVENT_SKILL_RANK_UPDATE
--RETURNS:(number eventCode, SkillType skillType, number skillIndex, number rank)
--NOTES:  XX
function EchoExperience.OnSkillRankUpdate(eventCode, skillType, skillIndex, rank)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnSkillRankUpdateWork(eventCode, skillType, skillIndex, rank)
      end
    )
  else
    EchoExperience.OnSkillRankUpdateWork(eventCode, skillType, skillIndex, rank)
  end
end
  
--
function EchoExperience.OnSkillRankUpdateWork(eventCode, skillType, skillIndex, rank)
	local skillLineName, currentSkillRank, available = GetSkillLineInfo(skillType, skillIndex)
	--local lastRankXP, nextRankXP, currentXP        = GetSkillLineXPInfo(skillType, skillIndex)
	local pressed, normal, mouseOver, announce = ZO_Skills_GetIconsForSkillType(skillType)
  if( EchoExperience.savedVariables.showSkillExp ) then 
     if(not available) then
      return
    end
    --
    EchoExperience.debugMsg2(EchoExperience.name .. "OnSkillRankUpdate: "
      , " eventCode=" .. tostring(eventCode)
      , " skillType="  .. tostring(skillType)
      , " skillIndex=" .. tostring(skillIndex)
      , " rank="       .. tostring(rank)
      , " available="  .. tostring(available)
      , " skillLineName=" .. tostring(skillLineName)
    )   
    -- 
    local sentence = GetString(SI_ECHOEXP_XP_SKILLLINE_UP)
    local sName = skillLineName
    if(normal~=nil) then
      sName = "|t14:14:"..normal.."|t"..skillLineName
    end
    local strL = zo_strformat(sentence, eventCode, sName, rank, normal )
    EchoExperience.outputToChanel(strL,msgTypeEXP)
  end
end
  
------------------------------
-- EVENT
--ONEvent  shows that you discovered something/somewhere
--EVENT:   EVENT_DISCOVERY_EXPERIENCE
--RETURNS:(num eventCode, str areaName, num level, num previousExperience, num currentExperience, num championPoints)
--NOTES:  XX
function EchoExperience.OnDiscoveryExperienceGain(event, eventCode, areaName, level, previousExperience, currentExperience, championPoints)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnDiscoveryExperienceGainWork(event, eventCode, areaName, level, previousExperience, currentExperience, championPoints)
      end
    )
  else
    EchoExperience.OnDiscoveryExperienceGainWork(event, eventCode, areaName, level, previousExperience, currentExperience, championPoints)
  end
end
  
--
function EchoExperience.OnDiscoveryExperienceGainWork(event, eventCode, areaName, level, previousExperience, currentExperience, championPoints)
	--[[
	if EchoExperience.savedVariables.debug then
		d(EchoExperience.name .. " OnDiscovery: "
		.. " previousExperience=" .. previousExperience
		.. " currentExperience="  .. currentExperience
		.. " eventCode=" .. eventCode
		.. " reason=" .. areaName
		.. " level="  .. level
		.. " areaName="  .. areaName
		.. " champ="  .. tostring(championPoints)
		)
	end
	]]
  if( EchoExperience.savedVariables.showdiscovery ) then 
    local strI = GetString(SI_ECHOEXP_DISCOVERY)
    local strL = zo_strformat(strI, eventCode )
    EchoExperience.outputToChanel(strL,msgTypeEXP)
  end
end

------------------------------
-- EVENT
--ONEvent  TODO   WORKING ON
--EVENT:   EVENT_SKILL_POINTS_CHANGED
--RETURNS:(num eventCode, num pointsBefore, num pointsNow, num partialPointsBefore, num partialPointsNow)
--NOTES:  Hopefully Skyshards are the only thing that gives partial points
function EchoExperience.OnSkillPtChange(eventCode, pointsBefore, pointsNow, partialPointsBefore, partialPointsNow)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnSkillPtChangeWork(eventCode, pointsBefore, pointsNow, partialPointsBefore, partialPointsNow)
      end
    )
  else
    EchoExperience.OnSkillPtChangeWork(eventCode, pointsBefore, pointsNow, partialPointsBefore, partialPointsNow)
  end
end
  
--
function EchoExperience.OnSkillPtChangeWork(eventCode, pointsBefore, pointsNow, partialPointsBefore, partialPointsNow)
  --EchoExperience.debugMsg("OnSkillPtChange Called")
	EchoExperience.debugMsg2("EE skptchange: eventCode=", tostring(eventCode)
    , " pointsBefore=", tostring(pointsBefore)
    , " pointsNow=", tostring(pointsNow)
    , " partialPointsBefore=", tostring(partialPointsBefore)
    , " partialPointsNow=", tostring(partialPointsNow)
	)
	local skyShardSkillUP = false
	if partialPointsBefore~=nil and partialPointsNow~=nil and partialPointsBefore==2 and partialPointsNow==0 then
		skyShardSkillUP = true
	end
	if pointsBefore > pointsNow then
		EchoExperience.debugMsg("Returned since probably just spend points")
		return
	end
	if partialPointsBefore~=nil and partialPointsNow~=nil and partialPointsNow > partialPointsBefore then
		EchoExperience.debugMsg2("echoexp(ospc test): eventCode=", tostring(eventCode))
		local strI = GetString(SI_ECHOEXP_SKY_1)
		--local strI = "You absorbed a skyshard! (<<1>> of <<2>>)."
		local strL = zo_strformat(strI, partialPointsNow, 3 )
		EchoExperience.outputToChanel(strL,msgTypeEXP)
	end
	if pointsBefore~=nil and partialPointsNow~=nil and pointsNow > pointsBefore then
		EchoExperience.debugMsg2("echoexp(ospc test): eventCode=", tostring(eventCode))
		local diff =  pointsNow - pointsBefore
		local strI = GetString(SI_ECHOEXP_SKY_2)
		--local strI = "You gained a skill point! (<<1>>)."
		local strL = zo_strformat(strI, diff )
		EchoExperience.outputToChanel(strL,msgTypeEXP)
	end
	--[[
	if partialPointsBefore~=nil and partialPointsNow~=nil and partialPointsBefore==2 and partialPointsNow=0 then
		--local strI = GetString(SI_ECHOEXP_SKILL_GAIN)
		local strI = "You absorbed a skyshard <<1>> of <<2>>."
		local strL = zo_strformat(strI,pointsBefore, pointsNow )
		--EchoExperience.outputToChanel(strL,msgTypeEXP)
	end
	]]
	--EchoExperience.debugMsg("OnSkillPtChange Done")
end

------------------------------
-- EVENT
--ONEvent  shows alliance point gains
--EVENT:   EVENT_ALLIANCE_POINT_UPDATE
--RETURNS:(num eventCode, num alliancePoints, bool playSound, num difference, CurrencyChangeReason reason)
--NOTES:  XX
function EchoExperience.OnAlliancePtGain(eventCode, alliancePoints,  playSound,  difference,  reason)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnAlliancePtGainWork(eventCode, alliancePoints,  playSound,  difference,  reason)
      end
    )
  else
    EchoExperience.OnAlliancePtGainWork(eventCode, alliancePoints,  playSound,  difference,  reason)
  end
end
  
--
function EchoExperience.OnAlliancePtGainWork(eventCode, alliancePoints,  playSound,  difference,  reason)
	EchoExperience.debugMsg2("OnAlliancePtGain Called. eventCode=", eventCode, ", reason=", reason, ".")
	if difference < 0 then
		local Ldifference = difference*-1.0
		--FORMAT
		local strI = GetString(SI_ECHOEXP_AP_LOSS)
		local strL = zo_strformat(strI, ZO_CommaDelimitNumber(Ldifference) )
		EchoExperience.outputToChanel(strL, msgTypeEXP)
		--EchoExperience.outputToChanel("You subtracted " .. Ldifference .. " AP.",msgTypeEXP)
	else
		--FORMAT
		local strI = GetString(SI_ECHOEXP_AP_GAIN)
		local strL = zo_strformat(strI, ZO_CommaDelimitNumber(difference) )
		EchoExperience.outputToChanel(strL,msgTypeEXP)
		--EchoExperience.outputToChanel("You gained " .. difference .. " AP.",msgTypeEXP)
	end
	--EchoExperience.debugMsg("OnAlliancePtGain Done")
end

--EVENT_CHAMPION_POINT_GAINED
function EchoExperience.OnChampionPointGain()
		local strI = GetString(SI_ECHOEXP_CP_EARNED)
		local strL = zo_strformat(strI, 1)
		EchoExperience.outputToChanel(strL,msgTypeEXP)
end


------------------------------
-- EVENT
--ONEvent  
--EVENT:   EVENT_LEVEL_UPDATE
--RETURNS:
--NOTES:  XX
function EchoExperience.OnExperienceLevelUpdate(eventCode, unitTag, level)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnExperienceLevelUpdateWork(eventCode, unitTag, level)
      end
    )
  else
    EchoExperience.OnExperienceLevelUpdateWork(eventCode, unitTag, level)
  end
end
  
--
function EchoExperience.OnExperienceLevelUpdateWork(eventCode, unitTag, level)
	--[[EchoExperience.outputMsg(EchoExperience.name .. " OnExperienceLevelUpdate: "
    .. " eventCode=" .. tostring(eventCode)
		.. " unitTag="  .. tostring(unitTag)
		.. " level="  .. tostring(level)
  )--]]
  if(unitTag=="player") then
    local sentence = GetString(SI_ECHOEXP_LEVEL_GAIN)
    local strL = zo_strformat(sentence, level, unitTag )
    EchoExperience.outputToChanel(strL,msgTypeEXP)
  else
    --unitTag==group#
  end
end

------------------------------
-- EVENT  uuuiii
--ONEvent  shows skill exp gains and CP gains
--EVENT:   EVENT_EXPERIENCE_UPDATE
--RETURNS:(xxx)
--NOTES:  XX
function EchoExperience.OnExperienceUpdate(eventCode, unitTag, currentExp, maxExp, reason)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnExperienceUpdateWork(eventCode, unitTag, currentExp, maxExp, reason)  
      end
    )
  else
    EchoExperience.OnExperienceUpdateWork(eventCode, unitTag, currentExp, maxExp, reason)  
  end
end
  
--
function EchoExperience.OnExperienceUpdateWork(eventCode, unitTag, currentExp, maxExp, reason)  
  EchoExperience.debugMsg2(EchoExperience.name .. " EVENT_EXPERIENCE_UPDATE: "
    , " eventCode=" .. eventCode
		, " unitTag="  .. unitTag
		, " currentExp=" .. currentExp
    , " maxExp=" .. maxExp
		, " reason=" .. reason
  )
  -- TODO CHECKBOX TO ENABLE!
  --
  if( IsChampionSystemUnlocked() ) then 
    EchoExperience.OnExperienceUpdateCP(eventCode, unitTag, currentExp, maxExp, reason)
  else
    --is it only working sub 50?
    if(EchoExperience.savedVariables.currentExp == nil or EchoExperience.savedVariables.currentExp<0 ) then
      -- Can't report on what we don't know.
    else    
      local XPgain = currentExp - EchoExperience.savedVariables.currentExp
      EchoExperience.debugMsg2(EchoExperience.name .. " EVENT_EXPERIENCE_UPDATE: "
        , " XPgain=" .. XPgain
        , " SavedExp=" .. tostring(EchoExperience.savedVariables.currentExp)
      )
      if(XPgain<1) then
        --TODO why get here?
        EchoExperience.debugMsg2(EchoExperience.name .. " EVENT_EXPERIENCE_UPDATE: err? "
          , " XPgain=" .. XPgain
          , " SavedExp=" .. tostring(EchoExperience.savedVariables.currentExp)
        )    
      else
        --FORMAT
        --You discovered <whateverplace> - 42 xp
        --"You <<1>> <<2>> - <<3>>.",
        local sourceText1 = EchoExperience.lookupExpSourceText(reason)
        local sourceText2 = ""
        local sentence = GetString(SI_ECHOEXP_XP_GAIN_SOURCE)
        XPgain = ZO_CommaDelimitNumber(XPgain)
        local strL = zo_strformat(sentence, sourceText1, sourceText2, XPgain )    
        EchoExperience.outputToChanel(strL,msgTypeEXP)
      end
    end
    --
    EchoExperience.savedVariables.currentExp = currentExp
  end
  --
end

function EchoExperience.OnExperienceUpdateCP(eventCode, unitTag, currentExp, maxExp, reason)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnExperienceUpdateCPWork(eventCode, unitTag, currentExp, maxExp, reason)
      end
    )
  else
    EchoExperience.OnExperienceUpdateCPWork(eventCode, unitTag, currentExp, maxExp, reason)
  end
end
  
--
function EchoExperience.OnExperienceUpdateCPWork(eventCode, unitTag, currentExp, maxExp, reason)
      local currXPCP   = GetPlayerChampionXP()      
      local currCPNow  = GetPlayerChampionPointsEarned()
      local currXPinCP = GetNumChampionXPInChampionPoint(currCPNow)
      if( EchoExperience.savedVariables.currentExp == nil or EchoExperience.savedVariables.currentExp<0 ) then
        -- Can't report on what we don't know.
      else
        local prevXPCP = EchoExperience.savedVariables.currentExp
        local XPgain   = currXPCP - prevXPCP
        EchoExperience.debugMsg2(EchoExperience.name .. " EVENT_EXPERIENCE_UPDATE: "
          , " currXPCP=" .. tostring(currXPCP)
          , " prevXPCP=" .. tostring(prevXPCP)
          , " XPgain="   .. tostring(XPgain)
        )
        local doReport = true
        local sourceText1 = EchoExperience.lookupExpSourceText(reason)
        local sourceText2 = ""
        local sentence = GetString(SI_ECHOEXP_XP_GAIN_SOURCE)
        if( XPgain ~= nil and XPgain > 0) then
          XPgain = ZO_CommaDelimitNumber(XPgain)
        else
          -- we have a CP level stored and it's not what we are, maybe we gained CP?
          if(EchoExperience.savedVariables.currCP~=nil and EchoExperience.savedVariables.currCP~=currCPNow) then
            --old max to end and use curr-oldmax
            --local oldXPinCP = EchoExperience.savedVariables.currXPinCP
            local diffOldCPlvl = EchoExperience.savedVariables.currXPinCP - EchoExperience.savedVariables.currentExp
            EchoExperience.debugMsg2(EchoExperience.name .. " EVENT_EXPERIENCE_UPDATE: "
              , " sv.currXPinCP=" , tostring(EchoExperience.savedVariables.currXPinCP)
              , " sv.currentExp=" , tostring(EchoExperience.savedVariables.currentExp)
              , " diffOldCPlvl="  , tostring(diffOldCPlvl)
              , " currentExp=" , currentExp
              , " maxExp=" , maxExp
            )
            XPgain = currXPCP - 0 + diffOldCPlvl
            XPgain = ZO_CommaDelimitNumber(XPgain)
          elseif(EchoExperience.savedVariables.currCP~=nil and currXPCP==prevXPCP) then
            EchoExperience.debugMsg(EchoExperience.name .. " EVENT_EXPERIENCE_UPDATE: same cp, so something weird happened...?")            
            doReport=false
          else -- ???
            EchoExperience.debugMsg(EchoExperience.name .. " EVENT_EXPERIENCE_UPDATE: ?>???")
            doReport=false
          end
        end
        if(doReport)then
          local strL = zo_strformat(sentence, sourceText1, sourceText2, XPgain )    
          EchoExperience.outputToChanel(strL,msgTypeEXP)
        else
          EchoExperience.debugMsg2(EchoExperience.name .. " EVENT_EXPERIENCE_UPDATE: "
            , " currXPCP=" , tostring(currXPCP)
            , " prevXPCP=" , tostring(prevXPCP)
            , " XPgain="   , tostring(XPgain)
            , " currentExp=" , currentExp
            , " maxExp="     , maxExp
            , " currCPNow="  , currCPNow
            , " sv.currCP="  , tostring(EchoExperience.savedVariables.currCP)
          )
        end
      end      
      --
      EchoExperience.savedVariables.currentExp = currXPCP
      EchoExperience.savedVariables.currCP     = currCPNow
      EchoExperience.savedVariables.currXPinCP = currXPinCP
end
    
------------------------------
-- EVENT
--ONEvent  shows skill exp gains and CP gains
--EVENT:   EVENT_EXPERIENCE_GAIN
--RETURNS:(num eventCode, ProgressReason reason, num level, num previousExperience, num currentExperience, num championPoints)
--NOTES:  XX
function EchoExperience.OnExperienceGain(eventCode, reason, level, previousExperience, currentExperience, championPoints)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnExperienceGainWork(eventCode, reason, level, previousExperience, currentExperience, championPoints)
      end
    )
  else
    EchoExperience.OnExperienceGainWork(eventCode, reason, level, previousExperience, currentExperience, championPoints)
  end
end
  
--
function EchoExperience.OnExperienceGainWork(eventCode, reason, level, previousExperience, currentExperience, championPoints)
	--EchoExperience.debugMsg("OnExperienceGain Called")	
	EchoExperience.debugMsg2(EchoExperience.name .. " previousExperience=" .. previousExperience
		, " currentExperience="  .. currentExperience
		, " eventCode=" .. eventCode
		, " reason=" .. reason
		, " level="  .. level
		, " champ="  .. tostring(championPoints) --allways nil?
  )
	-- TODO ugh need less than 50 char to test this, is it level or this is fine?
	local XPgain = currentExperience - previousExperience
  --if(championPoints ~= nil and championPoints>0) then
  --    XPgain = currentExperience - previousExperience
  --end  
	--FORMAT
	local sentence = GetString(SI_ECHOEXP_XP_GAIN)
  XPgain = ZO_CommaDelimitNumber(XPgain)
	local strL = zo_strformat(sentence, XPgain )
  
	EchoExperience.outputToChanel(strL,msgTypeEXP)
	--EchoExperience.outputToChanel("You gained " .. XPgain .. " experience.",msgTypeEXP)
	if(championPoints) then
    --this reports what CP you curently have! not a gain!
		--local sentence = GetString(SI_ECHOEXP_CP_EARNED2)
		--local strL = zo_strformat(sentence, championPoints)
		--EchoExperience.outputToChanel(strL,msgTypeEXP)
	end
  --TODO? EchoExperience.savedVariables.currentExp = currentExperience
end

------------------------------
-- EVENT
--EVENT_LOOT_ITEM_FAILED (number eventCode, LootItemResult reason, string itemName) 
function EchoExperience.OnLootFailed(eventCode, reason, itemName)
		EchoExperience.debugMsg2("OnLootFailed: "
			," eventCode="  .. tostring(eventCode)
			," reason="     .. tostring(reason)
			," itemName="   .. tostring(itemName)
		)
end

------------------------------
-- EVENT
--EVENT_BANKED_CURRENCY_UPDATE (number eventCode, CurrencyType currency, number newValue, number oldValue) 
function EchoExperience.OnBankedCurrency(eventCode, currency, newValue, oldValue) 
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnBankedCurrencyWork(eventCode, currency, newValue, oldValue) 
      end
    )
  else
    EchoExperience.OnBankedCurrencyWork(eventCode, currency, newValue, oldValue) 
  end
end
  
--
function EchoExperience.OnBankedCurrencyWork(eventCode, currency, newValue, oldValue) 
  EchoExperience.debugMsg2("OnBankedCurrency: "
    , " eventCode="  , tostring(eventCode)
    , " currency="   , tostring(currency)
    , " newValue="   , tostring(newValue)
    , " oldValue="   , tostring(oldValue)
  )

  --New Tracking Module
  if(EchoTracking~=nil and EchoExperience.savedVariables.lifetimetracking )then
    EchoTracking.saveCurrency(currency, oldValue, newValue, GetTimeStamp() )
  end
  --Tracking
  if(EchoExperience.savedVariables.sessiontracking) then
    local currentSession = EchoExperience:GetCurrentTrackingSession()
    if(currentSession.currency[currency]==nil) then
      currentSession.currency[currency]          = {}
      currentSession.currency[currency].quantity = 0
    end
    currentSession.currency[currency].quantity = currentSession.currency[currency].quantity + (oldValue - newValue)
    --
  end--Tracking
end

------------------------------
-- EVENT
--EVENT_CURRENCY_UPDATE (number eventCode, CurrencyType currencyType, CurrencyLocation currencyLocation, number newAmount, number oldAmount, CurrencyChangeReason reason) 
function EchoExperience.OnCurrencyUpdate(eventCode, currencyType, currencyLocation, newAmount, oldAmount, reason) 
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnCurrencyUpdateWork(eventCode, currencyType, currencyLocation, newAmount, oldAmount, reason) 
      end
    )
  else
    EchoExperience.OnCurrencyUpdateWork(eventCode, currencyType, currencyLocation, newAmount, oldAmount, reason) 
  end
end
  
--
function EchoExperience.OnCurrencyUpdateWork(eventCode, currencyType, currencyLocation, newAmount, oldAmount, reason) 
  EchoExperience.debugMsg2("OnCurrencyUpdate: "
    , " eventCode="        , tostring(eventCode)
    , " currencyType="     , tostring(currencyType)
    , " currencyLocation=" , tostring(currencyLocation)
    , " newAmount="        , tostring(newAmount)
    , " oldAmount="        , tostring(oldAmount)
    , " reason="           , tostring(reason)      
  )
  if(reason==35) then
    return --Just a UI refresh
  end
  
  local qualifier = 1
  local entryQuantity = oldAmount - newAmount
  local isSingular = true
  if(entryQuantity>1) then isSingular = false end
  if(newAmount>oldAmount) then 
    qualifier = 2
    entryQuantity = newAmount - oldAmount
  end
  if(entryQuantity>1) then isSingular = false end
  --New Tracking Module
  if(EchoTracking~=nil and EchoExperience.savedVariables.lifetimetracking )then
    EchoTracking.saveCurrency(currencyType, oldAmount, newAmount, GetTimeStamp() )
  end
  
  -- ----------
  --Tracking
  if(EchoExperience.savedVariables.sessiontracking) then
    local currentSession = EchoExperience:GetCurrentTrackingSession()
    if(currentSession.currency[currencyType]==nil) then
      currentSession.currency[currencyType] = {}
      currentSession.currency[currencyType].quantity = 0
      currentSession.currency[currencyType].plus     = 0
      currentSession.currency[currencyType].minus    = 0
    end
    --Something odd going on that i need to do this..?
    if(currentSession.currency[currencyType].plus==nil) then
      currentSession.currency[currencyType].plus = 0
    end
    if(currentSession.currency[currencyType].minus==nil) then
      currentSession.currency[currencyType].minus = 0
    end
    if(currentSession.currency[currencyType].quantity==nil) then
      currentSession.currency[currencyType].quantity = 0
    end
    currentSession.currency[currencyType].quantity = currentSession.currency[currencyType].quantity+ (newAmount - oldAmount)
    if( qualifier == 2 ) then
      currentSession.currency[currencyType].plus = currentSession.currency[currencyType].plus+ (newAmount - oldAmount)
    else
      currentSession.currency[currencyType].minus = currentSession.currency[currencyType].minus+ (newAmount - oldAmount)
    end
    --
  end--Tracking
  -- ----------
  if( IsBankOpen() or IsGuildBankOpen() ) then
    --Don't report as should be in another method
  end
  
  -- TODO IsCurrencyCapped(number CurrencyType currencyType, number CurrencyLocation currencyLocation) Returns: boolean isCapped

  local icon = GetCurrencyKeyboardIcon(currencyType) 
  --local icon = GetCurrencyLootKeyboardIcon(currencyType) 
  local entryName   = GetCurrencyName(currencyType, isSingular, false )
  local totalAmount = GetCurrencyAmount(currencyType, currencyLocation)
  
  local sentence = GetString("SI_ECHOLOOT_CURRENCY_",qualifier)
  if(currencyLocation~=nil and currencyLocation==1 )then --is bank    
    sentence = GetString("SI_ECHOLOOT_CURRENCY_BANK_",qualifier)
  end
  local strL = zo_strformat(sentence, icon, entryName, ZO_CommaDelimitNumber(entryQuantity), ZO_CommaDelimitNumber(totalAmount) )
  EchoExperience.outputToChanel(strL,msgTypeLOOT)
	--EchoExperience.debugMsg("OnCurrencyUpdate: "
	--	.." isSingular="  .. tostring(isSingular)
	--)
end

------------------------------
-- EVENT
--EVENT_SELL_RECEIPT (eventCode, itemName, itemQuantity, money)
function EchoExperience.OnSellReceipt(eventCode, itemName, itemQuantity, money) 
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnSellReceiptWork(eventCode, itemName, itemQuantity, money) 
      end
    )
  else
    EchoExperience.OnSellReceiptWork(eventCode, itemName, itemQuantity, money) 
  end
end
  
--
function EchoExperience.OnSellReceiptWork(eventCode, itemName, itemQuantity, money) 
  EchoExperience.debugMsg2("OnSellReceipt: "
    , " eventCode="    , tostring(eventCode)
    , " itemName="     , tostring(itemName)
    , " itemQuantity=" , tostring(itemQuantity)
    , " money="        , tostring(money)      
  )
  local qualifier = 1
  if(itemQuantity>1) then qualifier = 2 end
  local icon, sellPrice, meetsUsageRequirement, equipType, itemStyleId = GetItemLinkInfo(itemName)
  --local curricon = GetCurrencyKeyboardIcon(currencyType) 
  local sentence = GetString("SI_ECHOLOOT_SELL_", qualifier)
  local strL = zo_strformat(sentence, icon, itemName, itemQuantity, money )
	EchoExperience.outputToChanel(strL,msgTypeLOOT)
end

------------------------------
-- EVENT
--EVENT_BUYBACK_RECEIPT (number eventCode, string itemLink, number itemQuantity, number money, ItemUISoundCategory itemSoundCategory)
function EchoExperience.OnBuybackReceipt(eventCode, itemLink, itemQuantity, money, itemSoundCategory)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnBuybackReceiptWork(eventCode, itemLink, itemQuantity, money, itemSoundCategory)
      end
    )
  else
    EchoExperience.OnBuybackReceiptWork(eventCode, itemLink, itemQuantity, money, itemSoundCategory)
  end
end
  
--
function EchoExperience.OnBuybackReceiptWork(eventCode, itemLink, itemQuantity, money, itemSoundCategory)
  EchoExperience.debugMsg2("OnBuybackReceipt: "
    , " eventCode="    , tostring(eventCode)
    , " itemLink="     , tostring(itemLink)
    , " itemQuantity=" , tostring(itemQuantity)
    , " money="        , tostring(money)      
    , " itemSoundCategory=" , tostring(itemSoundCategory)          
  )
  local qualifier = 1
  if(itemQuantity>1) then qualifier = 2 end
  --local icon, sellPrice, meetsUsageRequirement, equipType, itemStyleId = GetItemLinkInfo(itemLink)
  local icon = GetItemLinkIcon(itemLink) 
  --local curricon = GetCurrencyKeyboardIcon(currencyType) 
  local sentence = GetString("SI_ECHOLOOT_BUYBACK_",qualifier)
  local strL = zo_strformat(sentence, icon, itemLink, itemQuantity, money )
	EchoExperience.outputToChanel(strL,msgTypeLOOT)
end

------------------------------
-- EVENT
--EVENT_BUY_RECEIPT (number eventCode, string entryName, StoreEntryType entryType, number entryQuantity, number money, CurrencyType specialCurrencyType1, string specialCurrencyInfo1, number specialCurrencyQuantity1, CurrencyType specialCurrencyType2, string specialCurrencyInfo2, number specialCurrencyQuantity2, ItemUISoundCategory itemSoundCategory) 
function EchoExperience.OnBuyReceipt(eventCode, entryName, entryType, entryQuantity, money, specialCurrencyType1, specialCurrencyInfo1, specialCurrencyQuantity1, specialCurrencyType2, specialCurrencyInfo2, specialCurrencyQuantity2, itemSoundCategory)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnBuyReceiptWork(eventCode, entryName, entryType, entryQuantity, money, specialCurrencyType1, specialCurrencyInfo1, specialCurrencyQuantity1, specialCurrencyType2, specialCurrencyInfo2, specialCurrencyQuantity2, itemSoundCategory)
      end
    )
  else
    EchoExperience.OnBuyReceiptWork(eventCode, entryName, entryType, entryQuantity, money, specialCurrencyType1, specialCurrencyInfo1, specialCurrencyQuantity1, specialCurrencyType2, specialCurrencyInfo2, specialCurrencyQuantity2, itemSoundCategory)
  end
end
  
--
function EchoExperience.OnBuyReceiptWork(eventCode, entryName, entryType, entryQuantity, money, specialCurrencyType1, specialCurrencyInfo1, specialCurrencyQuantity1, specialCurrencyType2, specialCurrencyInfo2, specialCurrencyQuantity2, itemSoundCategory)
		EchoExperience.debugMsg2("OnBuyReceipt: "
			, " eventCode="     , tostring(eventCode)
			, " entryName="     , tostring(entryName)
			, " entryType="     , tostring(entryType)
      , " entryQuantity=" , tostring(entryQuantity)
      , " money="         , tostring(money)
      , " specialCurrencyType1="     , tostring(specialCurrencyType1)
      , " specialCurrencyInfo1="     , tostring(specialCurrencyInfo1)
      , " specialCurrencyQuantity1=" , tostring(specialCurrencyQuantity1)
      , " specialCurrencyType2="     , tostring(specialCurrencyType2)
      , " specialCurrencyInfo2="     , tostring(specialCurrencyInfo2)
      , " specialCurrencyQuantity2=" , tostring(specialCurrencyQuantity2)
      , " itemSoundCategory="        , tostring(itemSoundCategory)      
		)
  local qualifier = 1
  if(entryQuantity>1) then qualifier = 2 end
  local icon, sellPrice, meetsUsageRequirement, equipType, itemStyleId = GetItemLinkInfo(entryName)  
  --local icon = GetItemLinkIcon(itemLink) 
  local sentence = GetString("SI_ECHOLOOT_BUY_",qualifier)
  local strL = zo_strformat(sentence, icon, entryName, entryQuantity, money )
	EchoExperience.outputToChanel(strL,msgTypeLOOT)
end

-- EVENT_ALLIANCE_POINT_UPDATE (number eventCode, number alliancePoints, boolean playSound, number difference, CurrencyChangeReason reason) 
function EchoExperience.OnAlliancePointUpdate(eventCode, alliancePoints, playSound, difference, reason) 
		EchoExperience.debugMsg2("OnAlliancePointUpdate: "
			, " eventCode="       , tostring(eventCode)
			, " alliancePoints="  , tostring(alliancePoints)
      , " playSound="       , tostring(playSound)            
			, " difference="      , tostring(difference)
			, " reason="          , tostring(reason)      
		)
end

------------------------------
-- EVENT
--EVENT_INVENTORY_ITEM_DESTROYED (number eventCode, ItemUISoundCategory itemSoundCategory) 
function EchoExperience.OnInventoryItemDestroyed(eventCode, ItemUISoundCategory, itemSoundCategory) 
		EchoExperience.debugMsg2("OnInventoryItemDestroyed: "
			, " eventCode="            , tostring(eventCode)
			, " ItemUISoundCategory="  , tostring(ItemUISoundCategory)
      , " itemSoundCategory="    , tostring(itemSoundCategory)            
		)
end

------------------------------
-- EVENT
--EVENT_INVENTORY_ITEM_USED (number eventCode, ItemUISoundCategory itemSoundCategory) 
function EchoExperience.OnInventoryItemUsed(eventCode, ItemUISoundCategory, itemSoundCategory) 
		EchoExperience.debugMsg2("OnInventoryItemUsed: "
			, " eventCode="  , tostring(eventCode)
			, " ItemUISoundCategory=" , tostring(ItemUISoundCategory)
      , " itemSoundCategory="   , tostring(itemSoundCategory)            
		)
end

------------------------------
-- EVENT
--EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS (number eventCode, id64 mailId)
function EchoExperience.OnMailItemRecieved(eventCode,mailId)
--        ZO_MailInboxShared_PopulateMailData(self:GetMailData(self.mailId), mailId)
--GetAttachedItemLink(id64 mailId, number attachIndex, number LinkStyle linkStyle)
  --  Returns: string link 
end

------------------------------
-- EVENT
--EVENT_MAIL_TAKE_ATTACHED_MONEY_SUCCESS (number eventCode, id64 mailId) 
function EchoExperience.OnMailMoneyRecieved(eventCode,mailId)
  --
end

------------------------------
-- EVENT
--EVENT_ANTIQUITY_LEAD_ACQUIRED
function EchoExperience.OnAntiquityLeadAcquired(eventCode, antiquityId)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnAntiquityLeadAcquiredWork(eventCode, antiquityId)
      end
    )
  else
    EchoExperience.OnAntiquityLeadAcquiredWork(eventCode, antiquityId)
  end
end
  
--
function EchoExperience.OnAntiquityLeadAcquiredWork(eventCode, antiquityId)
  EchoExperience.debugMsg2("OnAntiquityLeadAcquired: "
      , " eventCode="   , tostring(eventCode)    
			, " antiquityId=" , tostring(antiquityId)
		)
  local texture, iconFileIndex = GetAntiquityIcon(antiquityId)
  local name = GetAntiquityName(antiquityId)
  --AntiquityQuality]* _antiquityQuality_
  local antiquityQuality = GetAntiquityQuality(antiquityId)
  -- COLOR
  
  --local red, green, blue, alpha = GetInterfaceColor( INTERFACE_COLOR_TYPE_ITEM_QUALITY_COLORS, antiquityQuality)
  --local cCD = ZO_ColorDef:New(red,green,blue,alpha)
  --name = cCD:Colorize(name)
  if(antiquityQuality==ANTIQUITY_QUALITY_BLUE) then
    name = EchoExperience.Colorize(name, "5499c7")
  elseif(antiquityQuality==ANTIQUITY_QUALITY_GOLD) then
    name = EchoExperience.Colorize(name, "EED700")
  elseif(antiquityQuality==ANTIQUITY_QUALITY_GREEN) then
    local cCD = ZO_ColorDef:New(0,1,0,1)
    name = cCD:Colorize(name)
  elseif(antiquityQuality==ANTIQUITY_QUALITY_ORANGE) then
    name = EchoExperience.Colorize(name, "FFA500")
  elseif(antiquityQuality==ANTIQUITY_QUALITY_PURPLE) then
    name = EchoExperience.Colorize(name, "b450f3")
  elseif(antiquityQuality==ANTIQUITY_QUALITY_WHITE) then
    local cCD = ZO_ColorDef:New(0,0,0,1)
    name = cCD:Colorize(name)
  end
  local sentence = GetString(SI_ECHOANTIQ_RECEIVE)
  local strL = zo_strformat(sentence, texture, iconFileIndex, name)
  EchoExperience.outputToChanel(strL,msgTypeLOOT)
end

------------------------------
-- EVENT
--EVENT_INVENTORY_SINGLE_SLOT_UPDATE (number eventCode, Bag bagId, number slotId, boolean isNewItem, ItemUISoundCategory itemSoundCategory, number inventoryUpdateReason, number stackCountChange) 
function EchoExperience.OnInventorySingleSlotUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnInventorySingleSlotUpdateWork(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
      end
    )
  else
    EchoExperience.OnInventorySingleSlotUpdateWork(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
  end
end
  
--
function EchoExperience.OnInventorySingleSlotUpdateWork(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
  -- Short circuit: for damaged items,  TODO filter at event register?
  if(not isNewItem and bagId == BAG_WORN and inventoryUpdateReason==INVENTORY_UPDATE_REASON_DURABILITY_CHANGE) then
    return
  end
  
  EchoExperience.debugMsg2("OnInventorySingleSlotUpdate: "
			, " eventCode="  , tostring(eventCode)
      , " bagId="      , tostring(bagId)
      , " bagName="    , EchoExperience:GetBagNameFromID(bagId)
      , " slotId="     , tostring(slotId)
      , " isNewItem="  , tostring(isNewItem)
			, " ItemUISoundCategory="    , tostring(ItemUISoundCategory)
      , " inventoryUpdateReason="  , tostring(inventoryUpdateReason)            
      , " stackCountChange="       , tostring(stackCountChange)
  )   
  --
  local itemLink = GetItemLink(bagId, slotId)	
  EchoExperience.debugMsg2("GetItemInfo: " , " itemLink='"  , tostring(itemLink), "'"  )
  -- Short circuit: If cant get item link, just return
  if(itemLink == nil or itemLink == "" ) then
    EchoExperience.debugMsg2("Short circuit: If cant get item link, just return" )
    return
  end
  --
  local icon = GetItemLinkIcon(itemLink)
  if(not isNewItem) then
    if( (bagId==BAG_BANK or bagId==BAG_SUBSCRIBER_BANK or bagId==BAG_GUILDBANK) and stackCountChange>0) then
      local sentence = GetString(SI_ECHOLOOT_BANK_DEP)
      local strL = zo_strformat(sentence, icon, itemLink, stackCountChange )
      EchoExperience.outputToChanel(strL,msgTypeLOOT)
      return
    end
    --withdrawls from the bank have no itemlink, but throw another event with the backpack... caught below
  end
  --[[
  local icon, stack, sellPrice, meetsUsageRequirement, locked, equipType, itemStyleId, quality = GetItemInfo(bagId, slotId)
  131219 mail? from?
    TODO queue up messages?
  -]]
  --
  local qualifier = 1
  if(stackCountChange>1) then qualifier = 2 end
  local hasTraitInfo = false
  local traitName, setName = EchoExperience:GetExtraInfo(itemLink)
  if( traitName == nil) then
    traitName = ""
  else
    qualifier = qualifier + 2
    hasTraitInfo = true
  end
  local totalBagCount = GetItemTotalCount(bagId, slotId)
  --textureName icon, number stack, number sellPrice, boolean meetsUsageRequirement, boolean locked, number EquipType equipType, number itemStyleId, number ItemQuality quality = GetItemInfo(number Bag bagId, number slotIndex)
  --For some reason these bags do NOT report count
  --TODO to show count? use verbose setting or EchoExperience.savedVariables.extendedLoot ?
  if(not hasTraitInfo and EchoExperience.savedVariables.extendedLoot and bagId ~= BAG_SUBSCRIBER_BANK and bagId ~= BAG_VIRTUAL) then
    qualifier = qualifier + 4
  end
  -- Output
  if(isNewItem) then
    local sentence = GetString("SI_ECHOLOOT_RECEIVE_", qualifier)
    local strL = zo_strformat(sentence, icon, itemLink, stackCountChange, traitName, totalBagCount )
    EchoExperience.outputToChanel(strL,msgTypeLOOT)
  elseif( IsBankOpen() or IsGuildBankOpen() ) then
    local sentence = GetString("SI_ECHOLOOT_BANK_GET_", qualifier)
    local strL = zo_strformat(sentence, icon, itemLink, stackCountChange, traitName, totalBagCount )
    EchoExperience.outputToChanel(strL,msgTypeLOOT)
  end
  --New Tracking Module
  if(isNewItem) then
    local itemName = GetItemLinkName(itemLink) 
    if(EchoTracking~=nil and EchoExperience.savedVariables.lifetimetracking )then
      EchoTracking.saveLoot(itemName,itemLink,stackCountChange, GetTimeStamp() )
    end
    --Tracking
    if(EchoExperience.savedVariables.sessiontracking) then
      local currentSession = EchoExperience:GetCurrentTrackingSession()
      if(currentSession.items[itemName]==nil)then
        currentSession.items[itemName] = {}
        currentSession.items[itemName].quantity=0
      end
      currentSession.items[itemName].quantity = currentSession.items[itemName].quantity+ (stackCountChange)
      --if(itemLink==nil) then itemLink = itemName
      currentSession.items[itemName].itemlink = itemLink
      currentSession.items[itemName].icon     = icon
      --
    end--Tracking
  end
  --
end

------------------------------
-- EVENT
--ONEvent  shows loot gains
--EVENT:   EVENT_LOOT_RECEIVED
--RETURNS:(num eventCode, str receivedBy, str itemName, num quantity,
--			ItemUISoundCategory soundCategory, LootItemType lootType,
--			bool self, bool isPickpocketLoot, str questItemIcon, num itemId, bool isStolen)
--NOTES:  XX
--LOOTTPE=LOOT_TYPE_ANY,LOOT_TYPE_CHAOTIC_CREATIA, LOOT_TYPE_COLLECTIBLE, LOOT_TYPE_ITEM, LOOT_TYPE_MONEY,
--				LOOT_TYPE_QUEST_ITEM, LOOT_TYPE_STYLE_STONES, LOOT_TYPE_TELVAR_STONES,LOOT_TYPE_WRIT_VOUCHERS
function EchoExperience.OnLootReceived(eventCode,receivedBy,itemName,quantity,soundCategory,lootType,isSelf,isPickpocketLoot,questItemIcon,itemId,isStolen)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnLootReceivedWork(eventCode,receivedBy,itemName,quantity,soundCategory,lootType,isSelf,isPickpocketLoot,questItemIcon,itemId,isStolen)
      end
    )
  else
    EchoExperience.OnLootReceivedWork(eventCode,receivedBy,itemName,quantity,soundCategory,lootType,isSelf,isPickpocketLoot,questItemIcon,itemId,isStolen)
  end
end
  
--
function EchoExperience.OnLootReceivedWork(eventCode,receivedBy,itemName,quantity,soundCategory,lootType,isSelf,isPickpocketLoot,questItemIcon,itemId,isStolen)
  -- Get Extra Info for types that have it
	local extraInfo = nill  
	if lootType ~= nil and lootType ~= LOOT_TYPE_MONEY and lootType ~= LOOT_TYPE_QUEST_ITEM then
		--if itemType ~= ITEMTYPE_ARMOR_TRAIT and itemType ~= ITEMTYPE_WEAPON_TRAIT -- lootType ~= LOOT_TYPE_COLLECTIBLE
		local traitName, setName = EchoExperience:GetExtraInfo(itemName)
		if( traitName ~= nil and setName ~= nil and traitName ~= "" and setName ~= "") then
			extraInfo = string.format("%s, %s set",traitName, setName)
		elseif( traitName ~= nil) then
			extraInfo = string.format("%s",traitName)
		elseif( setName ~= nil) then
			extraInfo = string.format("%s set",setName)
		end
		EchoExperience.debugMsg2("OnLootReceived: "
      , " itemName="  , (itemName)
			, " lootType="  , tostring(lootType)
			, " traitName=" , tostring(traitName)
			, " setName="   , tostring(setName)
			, " itemId="    , tostring(itemId)
      , " extraInfo=" , tostring(extraInfo)
		)
	end
  --[[Tracking
  if(EchoExperience.savedVariables.XXXtracking) then

  --]]
  
  local icon      = GetItemLinkIcon(itemName)
  --local itemLink  = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
  --
  if(isSelf) then
    --I can't remember why this...
    if( not EchoExperience.savedVariables.extendedLoot) then
      local qualifier = 1
      if(quantity==1) then
        if(extraInfo ~= nil) then
          qualifier = 3
        else
          qualifier = 1 --**1 item, no extra info
        end
      else
        if(extraInfo ~= nil) then
          qualifier = 4
        else
          qualifier = 2 --**2+ item, no extra info
        end
      end
      EchoExperience.debugMsg2("qualifier=" , tostring(qualifier) )

      -- output: if isSelf and not extendedLoot
      local sentence = GetString("SI_ECHOLOOT_YOU_GAIN_",qualifier)
      if(isPickpocketLoot) then
        sentence = GetString("SI_ECHOLOOT_YOU_PICK_",qualifier)
      elseif(lootType==LOOT_TYPE_QUEST_ITEM)then
        sentence = GetString("SI_ECHOLOOT_YOU_QUEST_",qualifier)
      end
      local strL = zo_strformat(sentence, icon, itemName, quantity, extraInfo)
      EchoExperience.outputToChanel(strL,msgTypeLOOT)
    end --isSelf and not extendedLoot
  elseif (EchoExperience.savedVariables.groupLoot and receivedBy~=nil) then
    --if NOT self and IS groupLoot and has a receievedby value
    local qualifier = 1
    if(quantity>1) then qualifier = 2 end
    local sentence = GetString("SI_ECHOLOOT_OTHER_GAIN_", qualifier)
    if(isPickpocketLoot) then
      sentence = GetString("SI_ECHOLOOT_OTHER_PICK_", qualifier)
    elseif(lootType==LOOT_TYPE_QUEST_ITEM) then
      sentence = GetString("SI_ECHOLOOT_OTHER_QUEST_", qualifier)
    end
    local strL = zo_strformat(sentence, receivedBy, icon, itemName, quantity, extraInfo)
    EchoExperience.outputToChanel(strL,msgTypeLOOT)
  end--self check
end

------------------------------
-- EVENT
--EVENT_GUILD_MEMBER_ADDED (number eventCode, number guildId, string displayName) 
function EchoExperience.OnGuildMemberAdded(eventCode, guildID, displayName)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnGuildMemberAddedWork(eventCode, guildID, displayName)
      end
    )
  else
    EchoExperience.OnGuildMemberAddedWork(eventCode, guildID, displayName)
  end
end
  
--
function EchoExperience.OnGuildMemberAddedWork(eventCode, guildID, displayName)
  EchoExperience.debugMsg2("OnGuildMemberAdded: "
    , " eventCode="   , tostring(eventCode)
    , " guildID="     , tostring(guildID)      
    , " guild="       , tostring(EchoExperience:GetGuildName(guildID))      
    , " displayName=" , tostring(displayName)
  )
  local gName    = EchoExperience:GetGuildName(guildID)
  local pLink    = ZO_LinkHandler_CreatePlayerLink(displayName)
  local sentence = GetString("SI_ECHOEXP_GUILDADD_",1)
  local strL = zo_strformat(sentence, tostring(guildID), gName, displayName, ZO_FormatClockTime(), pLink )
  local filter = {}
  filter.type    = msgTypeGUILD2
  filter.guildID = guildID
  filter.guildId = EchoExperience:GetGuildId(guildID)
  EchoExperience.outputToChanel(strL,msgTypeGUILD2,filter) 
end

------------------------------
-- EVENT
--EVENT_GUILD_MEMBER_REMOVED (number eventCode, number guildId, string displayName, string characterName) 
function EchoExperience.OnGuildMemberRemoved(eventCode, guildID, displayName, characterName)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnGuildMemberRemovedWork(eventCode, guildID, displayName, characterName)
      end
    )
  else
    EchoExperience.OnGuildMemberRemovedWork(eventCode, guildID, displayName, characterName)
  end
end
  
--  
function EchoExperience.OnGuildMemberRemovedWork(eventCode, guildID, displayName, characterName)
  EchoExperience.debugMsg2("OnGuildMemberRemoved: "
    , " eventCode="     , tostring(eventCode)
    , " guildID="       , tostring(guildID)      
    , " guild="         , tostring(EchoExperience:GetGuildName(guildID))      
    , " displayName="   , tostring(displayName)
    , " characterName=" , tostring(characterName)
  )
  local gName = EchoExperience:GetGuildName(guildID)
  local pLink = ZO_LinkHandler_CreatePlayerLink(displayName)
  local sentence = GetString("SI_ECHOEXP_GUILDREM_", 1)
  local strL = zo_strformat(sentence, tostring(guildID), gName, characterName, ZO_FormatClockTime(), pLink )
  local filter = {}
  filter.type    = msgTypeGUILD2
  filter.guildID = guildID
  filter.guildId = EchoExperience:GetGuildId(guildID)
  EchoExperience.outputToChanel(strL,msgTypeGUILD2,filter) 
end

------------------------------
-- EVENT
--EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED (integer GuildID,string PlayerName,luaindex prevStatus,luaindex curStatus)
--["PLAYER_STATUS_AWAY"] = 2 ["PLAYER_STATUS_DO_NOT_DISTURB"] = 3
--["PLAYER_STATUS_OFFLINE"] = 4 ["PLAYER_STATUS_ONLINE"] = 1 
function EchoExperience.OnGuildMemberStatusChanged(eventCode,guildID,playerName,prevStatus,curStatus)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnGuildMemberStatusChangedWork(eventCode,guildID,playerName,prevStatus,curStatus)
      end
    )
  else
    EchoExperience.OnGuildMemberStatusChangedWork(eventCode,guildID,playerName,prevStatus,curStatus)
  end
end
  
--
function EchoExperience.OnGuildMemberStatusChangedWork(eventCode,guildID,playerName,prevStatus,curStatus)
  EchoExperience.debugMsg("OnGuildMemberStatusChanged called") -- Prints to chat.    
  local sentence = GetString("SI_ECHOEXP_GUILD_",1)
  --"eventCode: <<1>>, guildID: <<2>>, playerName: <<3>>, prevStatus: <<4>>, curStatus: <<5>> ."    
  local strL = zo_strformat(sentence, eventCode, tostring(guildID), tostring(playerName), tostring(prevStatus), tostring(curStatus) )
  EchoExperience.debugMsg(strL)
  local gName = EchoExperience:GetGuildName(guildID)
  --EchoExperience.debugMsg2("gName='", gName, "'")
  local pLink = ZO_LinkHandler_CreatePlayerLink(playerName)
  if(curStatus == 1) then
    --online
    if (EchoExperience.savedVariables.showGuildLogin) then
      local sentence2 = GetString("SI_ECHOEXP_GUILD_",2)
      local strL2 = zo_strformat(sentence2, playerName, ZO_FormatClockTime(), gName, pLink )
      local filter = {}
      filter.type = msgTypeGUILD
      filter.guildID = guildID
      filter.guildId = EchoExperience:GetGuildId(guildID)
      EchoExperience.outputToChanel(strL2,msgTypeGUILD,filter)  
    end
  elseif(curStatus == 4) then
    --offline
    if (EchoExperience.savedVariables.showGuildLogout) then
      local sentence2 = GetString("SI_ECHOEXP_GUILD_",3)
      local strL2 = zo_strformat(sentence2, (playerName), ZO_FormatClockTime(), gName, pLink )
      local filter = {}
      filter.type = msgTypeGUILD
      filter.guildID = guildID
      filter.guildId = EchoExperience:GetGuildId(guildID)
      EchoExperience.outputToChanel(strL2,msgTypeGUILD,filter)  
    end
  end
end

------------------------------
-- EVENT
--EVENT_BATTLEGROUND_KILL (number eventCode, string killedPlayerCharacterName, string killedPlayerDisplayName, BattlegroundAlliance killedPlayerBattlegroundAlliance, string killingPlayerCharacterName, string killingPlayerDisplayName, BattlegroundAlliance killingPlayerBattlegroundAlliance, BattlegroundKillType battlegroundKillType, number killingAbilityId) 
function EchoExperience.OnBattlegroundKill(eventCode, killedPlayerCharacterName, killedPlayerDisplayName, killedPlayerBattlegroundAlliance, killingPlayerCharacterName, killingPlayerDisplayName, killingPlayerBattlegroundAlliance, battlegroundKillType, killingAbilityId)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnBattlegroundKillWork(eventCode, killedPlayerCharacterName, killedPlayerDisplayName, killedPlayerBattlegroundAlliance, killingPlayerCharacterName, killingPlayerDisplayName, killingPlayerBattlegroundAlliance, battlegroundKillType, killingAbilityId)
      end
    )
  else
    EchoExperience.OnBattlegroundKillWork(eventCode, killedPlayerCharacterName, killedPlayerDisplayName, killedPlayerBattlegroundAlliance, killingPlayerCharacterName, killingPlayerDisplayName, killingPlayerBattlegroundAlliance, battlegroundKillType, killingAbilityId)
  end
end
  
--
function EchoExperience.OnBattlegroundKillWork(eventCode, killedPlayerCharacterName, killedPlayerDisplayName, killedPlayerBattlegroundAlliance, killingPlayerCharacterName, killingPlayerDisplayName, killingPlayerBattlegroundAlliance, battlegroundKillType, killingAbilityId)
  --
  --TESTING
  EchoExperience.debugMsg2("OnBattlegroundKill: "
    , " eventCode="      , tostring(eventCode)
    , " killedPlayerCharacterName="   , tostring(killedPlayerCharacterName)      
    , " killedPlayerDisplayName="     , tostring(killedPlayerDisplayName)
    , " killingPlayerCharacterName="  , tostring(killingPlayerCharacterName)
    , " killingPlayerDisplayName="    , tostring(killingPlayerDisplayName)
    , " EchoExperience.view.iamDisplayName=" , tostring(EchoExperience.view.iamDisplayName)
  )
  --
  if(EchoExperience.view.iamDisplayName == killedPlayerDisplayName ) then
    local sentence = GetString(SI_ECHOEXP_BG_KILLEDBY)
    local strL     = zo_strformat(sentence, killingPlayerDisplayName )
    EchoExperience.outputToChanel(strL,msgTypeQuest)
    --EchoExperience.outputMsg("OnBattlegroundKill: you were killed by " .. tostring(killingPlayerDisplayName) )
  end
  if(EchoExperience.view.iamDisplayName == killingPlayerDisplayName ) then
    local sentence = GetString(SI_ECHOEXP_BG_KILLED)
    local strL     = zo_strformat(sentence, killingPlayerDisplayName )
    EchoExperience.outputToChanel(strL,msgTypeQuest)
    --EchoExperience.outputMsg("OnBattlegroundKill: you killed " .. tostring(killedPlayerDisplayName) )
  end
  --
end

------------------------------
-- EVENT
--EVENT_UNIT_DESTROYED (number eventCode, string unitTag) 
function EchoExperience.OnUnitDestroyed(eventCode, unitTag)
  d("OnUnitDestroyed: "
			.." eventCode="  .. tostring(eventCode)
			.." unitTag="     .. tostring(unitTag)
		)
end

------------------------------
-- EVENT
--EVENT_COMBAT_EVENT (number eventCode, ActionResult result, boolean isError, string abilityName, number abilityGraphic, ActionSlotType abilityActionSlotType, string sourceName, CombatUnitType sourceType, string targetName, CombatUnitType targetType, number hitValue, CombatMechanicType powerType, DamageType damageType, boolean log, number sourceUnitId, number targetUnitId, number abilityId) 
function EchoExperience.OnCombatSomethingDied(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
  if(isError)then
    return
  end
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnCombatSomethingDiedWork(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
      end
    )
  else
    EchoExperience.OnCombatSomethingDiedWork(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
  end
end
  
--
function EchoExperience.OnCombatSomethingDiedWork(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
  if(isError)then
    return
  end

  if(result==ACTION_RESULT_IN_COMBAT ) then  
    EchoExperience.debugMsg2("OnCombatSomethingDied: "
      , " eventCode="      , tostring(eventCode)
      , " sourceName="     , tostring(sourceName)      
      , " targetName="     , tostring(targetName)
      , " targetType="     , tostring(targetType)
      , " result="         , tostring(result)
      , " isError="        , tostring(isError)      
      , " abilityName="    , tostring(abilityName)      
      , " sourceUnitId="   , tostring(sourceUnitId)     
      , " targetUnitId="   , tostring(targetUnitId)
    )
  end
  --]]
  --ACTION_RESULT_DIED_XP ???
  --ACTION_RESULT_TARGET_DEAD 
  if(result~=ACTION_RESULT_DIED and result~=ACTION_RESULT_DIED_XP)then
    --EchoExperience.debugMsg("OnCombatSomethingDied: not dead event")
    return
  end

  --sourceName==nil or sourceName=="" or
  if(isError or targetName==nil or targetName=="") then
    EchoExperience.debugMsg("OnCombatSomethingDied: but no good data !!!")
    EchoExperience.debugMsg2("OnCombatSomethingDied: "
    , " eventCode="      , tostring(eventCode)
    , " sourceName="     , tostring(sourceName)      
    , " targetName="     , tostring(targetName)
    , " targetType="     , tostring(targetType)
    , " result="         , tostring(result)
    , " isError="        , tostring(isError)      
    , " abilityName="    , tostring(abilityName)     
    , " sourceUnitId="   , tostring(sourceUnitId)     
    , " targetUnitId="   , tostring(targetUnitId)
  )
    return
  else
    EchoExperience.debugMsg2("OnCombatSomethingDied: "
      , " sourceUnitId=" , tostring(sourceUnitId)
      , " targetUnitId=" , tostring(targetUnitId) 
      , " result="       , tostring(result) 
    )
  end
  -- Check if just got this target death notification
  if(EchoExperience.view.lastKilledTargetId ~= nil and 
        EchoExperience.view.lastKilledTargetId == targetUnitId) then
    EchoExperience.view.lastKilledTargetId = nil
    return
  end
  
  EchoExperience.view.lastKilledTargetId = targetUnitId
  
  --
  --New Tracking Module
  if(EchoTracking~=nil and EchoExperience.savedVariables.lifetimetracking )then
    EchoTracking.saveKills(targetName,targetType,targetUnitId, GetTimeStamp() )
  end
  --Tracking
  if(EchoExperience.savedVariables.sessiontracking) then
    --
    local currentSession = EchoExperience:GetCurrentTrackingSession()
    if(currentSession.mobs[targetName]==nil)then
      currentSession.mobs[targetName] = {}
      currentSession.mobs[targetName].quantity=0
    end    
    currentSession.mobs[targetName].quantity   = currentSession.mobs[targetName].quantity+ 1
    currentSession.mobs[targetName].targetType = targetType
    --
  end--Tracking
  --TODO localize etc  
  
  if(EchoExperience.savedVariables.showmdk) then
    --[14:28] [14:28] (EchoExp) OnCombatSomethingDied: sourceUnitId=0 targetUnitId=58426 result=2260(ACTION_RESULT_DIED)
    if(sourceUnitId==targetUnitId) then
      local sentence = GetString(SI_ECHOEXP_DIED)
      local strL     = zo_strformat(sentence )
      EchoExperience.outputToChanel(strL,msgTypeSYS)
      --EchoExperience.outputToChanel("You died!",msgTypeSYS)--TODO 
    else
      --TEST REMOVE TODO
      EchoExperience.debugMsg2("SomethingDied: "
        , " sourceUnitId=" , tostring(sourceUnitId)
        , " targetUnitId=" , tostring(targetUnitId) 
        , " result="       , tostring(result) 
      )
      local sentence = GetString(SI_ECHOEXP_KILL_MOB)
      local strL = zo_strformat(sentence, targetName )
      EchoExperience.outputToChanel(strL,msgTypeQuest)
      
      --Check LitanyOfBlood
      EchoExperience.OnLitanyOfBlood(tostring(targetName), targetUnitId)      
    end --you vs other
  end--showmdk
end

------------------------------
-- EVENT
-- Triggers when you leave a guild (guildId / guildName)
--EVENT_GUILD_SELF_LEFT_GUILD (integer eventCode, integer guildId, string guildName)
function EchoExperience.OnGuildSelfLeft(eventCode, guildId, guildName)
  --TESTING
  EchoExperience.debugMsg2("OnGuildSelfLeft: "
    , " eventCode="   , tostring(eventCode)
    , " guildId="     , tostring(guildId) 
    , " guildName="   , tostring(guildName) 
  )
  --Reset guild cache
  EchoExperience.view.guildids   = nil
  EchoExperience.view.guildnames = nil
  --
  local sentence = GetString(SI_ECHOEXP_GUILD_SELFJOIN)
  local strL     = zo_strformat(sentence, guildName )
  EchoExperience.outputToChanel(strL, msgTypeGUILD2)
end

------------------------------
-- EVENT
-- Triggers when you join a guild (guildId / guildName)
--EVENT_GUILD_SELF_JOINED_GUILD (integer eventCode, integer guildId, string guildName)
function EchoExperience.OnGuildSelfJoined(eventCode, guildId, guildName)
  --TESTING
  EchoExperience.debugMsg2("OnGuildSelfJoined: "
    , " eventCode="   , tostring(eventCode)
    , " guildId="     , tostring(guildId) 
    , " guildName="     , tostring(guildName) 
  )
  --Reset guild cache
  EchoExperience.view.guildids   = nil
  EchoExperience.view.guildnames = nil  
  --
  local sentence = GetString(SI_ECHOEXP_GUILD_SELFLEFT)
  local strL     = zo_strformat(sentence, guildName )
  EchoExperience.outputToChanel(strL, msgTypeGUILD2)
end

------------------------------
-- EVENT
-- Alpha
--EVENT_QUEST_SHARE_REMOVED 
--(number eventCode, number questId)
--Note: called on success or fail?
function EchoExperience.OnEventQuestSharedRemoved(eventCode, questId)
  --TESTING
  EchoExperience.debugMsg2("OnEventQuestSharedRemoved: "
    , " eventCode="   , tostring(eventCode)
    , " questId="     , tostring(questId) 
  )  --
  --Returns: string questName, string characterName, number millisecondsSinceRequest, string displayName  
  --local questName, characterName, millisecondsSinceRequest, displayName = GetOfferedQuestShareInfo( questId )
  --local sentence = GetString(SI_ECHOLOOT_QUEST_SHARED_TO_YOU)
  --local strL = zo_strformat(sentence, questName, questId )
  --EchoExperience.outputToChanel(strL, msgTypeQuest)
  --  
end

------------------------------
-- EVENT
-- Alpha
--EVENT_QUEST_SHARE_RESULT
--(number eventCode, number questId)
function EchoExperience.OnEventQuestSharedStart(eventCode, questId)
  --TESTING
  EchoExperience.debugMsg2("OnEventQuestSharedStart: "
    , " eventCode="   , tostring(eventCode)
    , " questId="     , tostring(questId)
  )
  --
  --Returns: string questName, string characterName, number millisecondsSinceRequest, string displayName  
  local questName, characterName, millisecondsSinceRequest, displayName = GetOfferedQuestShareInfo( questId )
  local sentence = GetString(SI_ECHOLOOT_QUEST_SHARED_TO_YOU)
  local strL = zo_strformat(sentence, questName, questId )
  EchoExperience.outputToChanel(strL, msgTypeQuest)
  --  
end    

------------------------------
-- EVENT
-- Alpha
--EVENT_QUEST_SHARE_RESULT
--(number eventCode, string shareTargetCharacterName, string shareTargetDisplayName, string questName, number QuestShareResult result)
function EchoExperience.OnEventQuestSharedResult(eventCode, shareTargetCharacterName, shareTargetDisplayName, questName, result)
  --TESTING
  EchoExperience.debugMsg2("OnEventQuestSharedResult: "
    , " eventCode="      , tostring(eventCode)
    , " shareTargetCharacterName="   , tostring(shareTargetCharacterName) 
    , " shareTargetDisplayName="     , tostring(shareTargetDisplayName) 
    , " questName="     , tostring(questName) 
    , " result="        , tostring(result) 
  )
  --QuestShareResult
  --QUEST_SHARE_RESULT_ACCEPTED
  --QUEST_SHARE_RESULT_DECLINED
  --QUEST_SHARE_RESULT_FAILED_TO_SHARE
  if(EchoExperience.view.sharedquests==nil) then
    EchoExperience.view.sharedquests = {}
  end
  local oldval = EchoExperience.view.sharedquests[questName..shareTargetCharacterName];
  local sharedThisSession = false;
  if(oldval~=nil) then
    --shared in this session
    sharedThisSession = true
  else 
    --not shared in this session
  end
  local resultString = "Unknown"
  if(result==QUEST_SHARE_RESULT_ACCEPTED) then
    resultString = GetString(SI_ECHOEXP_QUEST_ACCEPTED) 
  elseif(result==QUEST_SHARE_RESULT_DECLINED) then
    resultString = GetString(SI_ECHOEXP_QUEST_DECLINED)
  elseif(result==QUEST_SHARE_RESULT_FAILED_TO_SHARE) then
    resultString = GetString(SI_ECHOEXP_QUEST_FAILED)
  end
  local sentence = GetString(SI_ECHOEXP_QUEST_SHARE_RESULT)
  local strL = zo_strformat(sentence, questName, shareTargetCharacterName, shareTargetDisplayName, resultString )
  EchoExperience.outputToChanel(strL, msgTypeQuest)
  EchoExperience.view.sharedquests[questName..shareTargetCharacterName] = GetTimeStamp()
end

------------------------------
-- EVENT
    -- EVENT_QUEST_ADVANCED (number eventCode, number journalIndex, string questName, boolean isPushed, boolean isComplete, boolean mainStepChanged)
function EchoExperience.OnEventQuestAdvanced(eventCode, journalIndex, questName, isPushed, isComplete, mainStepChanged)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnEventQuestAdvancedWork(eventCode, journalIndex, questName, isPushed, isComplete, mainStepChanged)
      end
    )
  else
    EchoExperience.OnEventQuestAdvancedWork(eventCode, journalIndex, questName, isPushed, isComplete, mainStepChanged)
  end
end
  
--
function EchoExperience.OnEventQuestAdvancedWork(eventCode, journalIndex, questName, isPushed, isComplete, mainStepChanged)
  EchoExperience.debugMsg2("OnEventQuestAdvanced: "
    , " eventCode="       , tostring(eventCode)
    , " journalIndex="    , tostring(journalIndex) 
    , " questName="       , tostring(questName) 
    , " isPushed="        , tostring(isPushed) 
    , " isComplete="      , tostring(isComplete)     
    , " mainStepChanged=" , tostring(mainStepChanged)     
  )
  local sentence = nil
  local status   = nil
  if(mainStepChanged) then
    if( not isComplete) then
      local sentence = GetString(SI_ECHOEXP_QUEST_STEPDONE1)
      local strL = zo_strformat(sentence, questName )
      EchoExperience.outputToChanel(strL, msgTypeQuest)
    else
      EchoExperience.debugMsg2("OnEventQuestAdvanced: "
        , " questName="      , tostring(questName)
        , " isComplete="     , tostring(isComplete) 
      )
      local count    = GetNumJournalQuests()
      local sentence = GetString(SI_ECHOEXP_QUEST_COMPLETE)
      local strL = zo_strformat(sentence, questName, count, 25 )
      EchoExperience.outputToChanel(strL, msgTypeQuest)
    end
  end
end

------------------------------
-- EVENT
----integer eventCode, string questName, integer playerLevel, integer previousXP, integer currentXP, integer playerVeteranRank, integer previousVeteranPoints, integer currentVeteranPoints)
function EchoExperience.OnEventQuestAdded(eventCode, level, questName)
  EchoExperience.debugMsg2("OnEventQuestAdded: "
    , " eventCode="  , tostring(eventCode)
    , " questName="  , tostring(questName) 
    , " level="      , tostring(level) 
  )
  local count    = GetNumJournalQuests()
  local sentence = GetString(SI_ECHOEXP_QUEST_ACCEPT)
  local strL = zo_strformat(sentence, questName, count, 25 )
  EchoExperience.outputToChanel(strL, msgTypeQuest)
end

------------------------------
-- EVENT
function EchoExperience.OnEventQuestComplete(eventCode, questName, level, previousExperience)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnEventQuestCompleteWork(eventCode, questName, level, previousExperience)
      end
    )
  else
    EchoExperience.OnEventQuestCompleteWork(eventCode, questName, level, previousExperience)
  end
end
  
--
function EchoExperience.OnEventQuestCompleteWork(eventCode, questName, level, previousExperience)
  EchoExperience.debugMsg2("OnEventQuestComplete: "
    , " questName=" , tostring(questName)
    , " level="     , tostring(level) 
  )
  local count    = GetNumJournalQuests()
  local sentence = GetString(SI_ECHOEXP_QUEST_COMPLETE)
  local strL = zo_strformat(sentence, questName, count, 25 )
  EchoExperience.outputToChanel(strL, msgTypeQuest)
end

------------------------------
-- EVENT
--(number eventCode, boolean isCompleted, number journalIndex, string questName, number zoneIndex, number poiIndex, number questID)
function EchoExperience.OnEventQuestRemoved(eventCode, isCompleted, journalIndex, questName, zoneIndex, poiIndex, questID)
  EchoExperience.debugMsg2("OnEventQuestRemoved: "
    , " questName="     , tostring(questName)
    , " eventCode="     , tostring(eventCode) 
  )
  if(not isCompleted) then
    local count    = GetNumJournalQuests()
    local sentence = GetString(SI_ECHOEXP_QUEST_REMOVED)
    local strL = zo_strformat(sentence, questName, count, 25 )
    EchoExperience.outputToChanel(strL, msgTypeQuest)
  end
end

  
  

------------------------------
-- EVENT_LORE_BOOK_ALREADY_KNOWN (number eventCode, string bookTitle)
function EchoExperience.OnLoreBookAlreadyKnown(eventCode,bookTitle)
  EchoExperience.debugMsg2("OnLoreBookAlreadyKnown: "
    , " eventCode="     , tostring(eventCode) 
    , " bookTitle="     , tostring(bookTitle) 
  )
end

------------------------------
-- EVENT_LORE_BOOK_LEARNED (number eventCode, number categoryIndex, number collectionIndex, number bookIndex, number guildIndex, boolean isMaxRank)
function EchoExperience.OnLoreBookLearned(eventCode, categoryIndex, collectionIndex, bookIndex, guildIndex, isMaxRank)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnLoreBookLearnedWork(eventCode, categoryIndex, collectionIndex, bookIndex, guildIndex, isMaxRank)
      end
    )
  else
    EchoExperience.OnLoreBookLearnedWork(eventCode, categoryIndex, collectionIndex, bookIndex, guildIndex, isMaxRank)
  end
end
  
--
function EchoExperience.OnLoreBookLearnedWork(eventCode, categoryIndex, collectionIndex, bookIndex, guildIndex, isMaxRank)
  EchoExperience.debugMsg("OnLoreBookLearned: "
    , " eventCode="       , tostring(eventCode) 
    , " categoryIndex="   , tostring(categoryIndex) 
    , " collectionIndex=" , tostring(collectionIndex) 
    , " bookIndex="       , tostring(bookIndex) 
    , " guildIndex="      , tostring(guildIndex) 
    , " isMaxRank="       , tostring(isMaxRank) 
  )
  --eventCode=131477 categoryIndex=3 collectionIndex=15 bookIndex=26 guildIndex=0 isMaxRank=false
  --eventCode=131477 categoryIndex=1 collectionIndex=24 bookIndex=7 guildIndex=8 isMaxRank=true
  
  --Returns: string title, textureName icon, boolean known, number bookId
  local title, icon, known, bookId = GetLoreBookInfo(categoryIndex, collectionIndex, bookIndex)  
  --Returns: string link
  local link = GetLoreBookLink(categoryIndex, collectionIndex, bookIndex, LINK_STYLE_BRACKETS )
   
  --Returns: string name, number numCollections, number categoryId
  local nameC, numCollectionsC, categoryIdC = GetLoreCategoryInfo(categoryIndex)
  
  --Returns: string name, string description, number numKnownBooks, number totalBooks, boolean hidden, textureName gamepadIcon, number collectionId
  local nameCI, descriptionCI, numKnownBooksCI, totalBooksCI, hiddenCI, gamepadIconCI, collectionIdCI = GetLoreCollectionInfo(categoryIndex, collectionIndex)
  
    EchoExperience.debugMsg2("OnLoreBookLearned: "
      , " nameCI="          , tostring(nameCI) 
      , " descriptionCI="   , tostring(descriptionCI) 
      , " numKnownBooksCI=" , tostring(numKnownBooksCI) 
      , " totalBooksCI="    , tostring(totalBooksCI) 
      , " link="            , tostring(link) 
  )
--eventCode=131477 categoryIndex=3 collectionIndex=20 bookIndex=19 guildIndex=0 isMaxRank=false
--nameCI=The World and Its Creatures descriptionCI=Books about the many and varied environments of Tamriel and the creatures that live in them. numKnownBooksCI=28 totalBooksCI=79 link=[]
    local sentence = GetString(SI_ECHOEXP_LOREBOOK_LEARNED)
    if(nameCI==nil or totalBooksCI==0) then
      sentence = GetString(SI_ECHOEXP_LOREBOOK_LEARNED_SOLO)
    end
    local strL     = zo_strformat(sentence, link, nameCI, numKnownBooksCI, totalBooksCI)
    EchoExperience.outputToChanel(strL, msgTypeQuest)
end

------------------------------
--   EVENT_LORE_BOOK_LEARNED_SKILL_EXPERIENCE (number eventCode, number categoryIndex, number collectionIndex, number bookIndex, number guildIndex, SkillType skillType, number skillIndex, number rank, number previousXP, number currentXP)
function EchoExperience.OnLoreBookSkillExp(eventCode, categoryIndex, collectionIndex, bookIndex, guildIndex, skillType, skillIndex, rank, previousXP, currentXP)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnLoreBookSkillExpWork(eventCode, categoryIndex, collectionIndex, bookIndex, guildIndex, skillType, skillIndex, rank, previousXP, currentXP)
      end
    )
  else
    EchoExperience.OnLoreBookSkillExpWork(eventCode, categoryIndex, collectionIndex, bookIndex, guildIndex, skillType, skillIndex, rank, previousXP, currentXP)
  end
end
  
--
function EchoExperience.OnLoreBookSkillExpWork(eventCode, categoryIndex, collectionIndex, bookIndex, guildIndex, skillType, skillIndex, rank, previousXP, currentXP)
  --TESTING
  EchoExperience.debugMsg2("OnLoreBookSkillExp: "
    , " eventCode="       , tostring(eventCode) 
    , " categoryIndex="   , tostring(categoryIndex) 
    , " collectionIndex=" , tostring(collectionIndex) 
    , " bookIndex="       , tostring(bookIndex) 
    , " guildIndex="      , tostring(guildIndex) 
    , " skillType="       , tostring(skillType) 
    , " skillIndex="      , tostring(skillIndex) 
    , " rank="            , tostring(rank) 
    , " previousXP="      , tostring(previousXP) 
    , " currentXP="       , tostring(currentXP) 
  )
  --
  local diffexp = currentXP - previousXP
  
  --Returns: string name, number numCollections, number categoryId
  --local nameC, numCollectionsC, categoryIdC = GetLoreCategoryInfo(categoryIndex)
  
  --Returns: string title, textureName icon, boolean known, number bookId
  local title, icon, known, bookId = GetLoreBookInfo(categoryIndex, collectionIndex, bookIndex)  
  --Returns: string link
  local link = GetLoreBookLink(categoryIndex, collectionIndex, bookIndex, LINK_STYLE_BRACKETS )
  
  --Returns: string name, string description, number numKnownBooks, number totalBooks, boolean hidden, textureName gamepadIcon, number collectionId
  local nameCI, descriptionCI, numKnownBooksCI, totalBooksCI, hiddenCI, gamepadIconCI, collectionIdCI = GetLoreCollectionInfo(categoryIndex, collectionIndex)

  --SI_ECHOEXP_LOREBOOK_EXP = "Earned Exp <<1>> for discovering book <<2>> <<3>> (<<4>>/<<5>>).",
  local sentence = GetString(SI_ECHOEXP_LOREBOOK_EXP)
  local strL     = zo_strformat(sentence, diffexp, title, nameCI, numKnownBooksCI, totalBooksCI)
  EchoExperience.outputToChanel(strL, msgTypeQuest)
end

------------------------------
-- EVENT_LORE_COLLECTION_COMPLETED (number eventCode, number categoryIndex, number collectionIndex, number guildIndex, boolean isMaxRank)
function EchoExperience.OnLoreBookCollectionComplete(eventCode, categoryIndex, collectionIndex, guildIndex, isMaxRank)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnLoreBookCollectionCompleteWork(eventCode, categoryIndex, collectionIndex, guildIndex, isMaxRank)
      end
    )
  else
    EchoExperience.OnLoreBookCollectionCompleteWork(eventCode, categoryIndex, collectionIndex, guildIndex, isMaxRank)
  end
end
  
--
function EchoExperience.OnLoreBookCollectionCompleteWork(eventCode, categoryIndex, collectionIndex, guildIndex, isMaxRank)
  --TESTING
  EchoExperience.debugMsg2("OnLoreBookCollectionComplete: "
    , " eventCode="       , tostring(eventCode) 
    , " categoryIndex="   , tostring(categoryIndex) 
    , " collectionIndex=" , tostring(collectionIndex) 
    , " guildIndex="      , tostring(guildIndex) 
    , " isMaxRank="       , tostring(isMaxRank) 
  )
  --eventCode=131479 categoryIndex=1 collectionIndex=24 guildIndex=1 isMaxRank=true
    --Returns: string name, number numCollections, number categoryId
  local nameC, numCollectionsC, categoryIdC = GetLoreCategoryInfo(categoryIndex)
  
  --Returns: string name, string description, number numKnownBooks, number totalBooks, boolean hidden, textureName gamepadIcon, number collectionId
  local nameCI, descriptionCI, numKnownBooksCI, totalBooksCI, hiddenCI, gamepadIconCI, collectionIdCI = GetLoreCollectionInfo(categoryIndex, collectionIndex)

  --
  local sentence = GetString(SI_ECHOEXP_LOREBOOK_CAT_COMPLETE)
  local strL     = zo_strformat(sentence, nameC, nameCI, numKnownBooksCI, totalBooksCI)
  EchoExperience.outputToChanel(strL, msgTypeQuest)
end

------------------------------
-- EVENT_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE (number eventCode, number categoryIndex, number collectionIndex, number guildIndex, SkillType skillType, number skillIndex, number rank, number previousXP, number currentXP)
function EchoExperience.OnLoreBookCollectionCompleteSkillExp(eventCode, categoryIndex, collectionIndex, guildIndex, skillType, skillIndex, rank, previousXP, currentXP)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnLoreBookCollectionCompleteSkillExpWork(eventCode, categoryIndex, collectionIndex, guildIndex, skillType, skillIndex, rank, previousXP, currentXP)
      end
    )
  else
    EchoExperience.OnLoreBookCollectionCompleteSkillExpWork(eventCode, categoryIndex, collectionIndex, guildIndex, skillType, skillIndex, rank, previousXP, currentXP)
  end
end
  
--  
function EchoExperience.OnLoreBookCollectionCompleteSkillExpWork(eventCode, categoryIndex, collectionIndex, guildIndex, skillType, skillIndex, rank, previousXP, currentXP)
  --TESTING
  EchoExperience.debugMsg2("OnLoreBookCollectionCompleteSkillExp: "
    , " eventCode="       , tostring(eventCode) 
    , " categoryIndex="   , tostring(categoryIndex) 
    , " collectionIndex=" , tostring(collectionIndex) 
    , " guildIndex="      , tostring(guildIndex) 
    , " skillType="       , tostring(skillType) 
    , " skillIndex="      , tostring(skillIndex) 
    , " rank="            , tostring(rank) 
    , " previousXP="      , tostring(previousXP) 
    , " currentXP="       , tostring(currentXP)
  )
  
  local diffexp = currentXP - previousXP
  local nameC, numCollectionsC, categoryIdC = GetLoreCategoryInfo(categoryIndex)
  --Returns: string name, string description, number numKnownBooks, number totalBooks, boolean hidden, textureName gamepadIcon, number collectionId
  local nameCI, descriptionCI, numKnownBooksCI, totalBooksCI, hiddenCI, gamepadIconCI, collectionIdCI = GetLoreCollectionInfo(categoryIndex, collectionIndex)

  --local sourceText1 = EchoExperience.lookupExpSourceText(reason)
  --local sourceText2 = ""
  --local sentence = GetString(SI_ECHOEXP_XP_GAIN_SOURCE)
  diffexp = ZO_CommaDelimitNumber(diffexp)
  
  ----"Earned Exp <<3>> for finished the collection [<<2>>] in category [<<1>>]!!.",
  local sentence = GetString(SI_ECHOEXP_LOREBOOK_CATCOMPLETE_EXP)
  local strL     = zo_strformat(sentence, nameC, nameCI, diffexp)
  EchoExperience.outputToChanel(strL, msgTypeQuest)
end

------------------------------
-- EVENT_LORE_LIBRARY_INITIALIZED (number eventCode)
function EchoExperience.OnLoreBookLibraryInit(eventCode)
  EchoExperience.debugMsg2("OnLoreBookLibraryInit: "
    , " eventCode="     , tostring(eventCode) 
  )
end

----


------------------------------
-- EVENT EVENT_ACHIEVEMENTS_UPDATED (number eventCode)
function EchoExperience.OnAchievementsUpdated(eventCode)
  --TESTING
  EchoExperience.outputMsg("OnAchievementsUpdated: "
    .." eventCode="     .. tostring(eventCode) 
  ) 
end

------------------------------
-- EVENT EVENT_ACHIEVEMENT_UPDATED (number eventCode, number id)
function EchoExperience.OnAchievementUpdated(eventCode, achievementID)
  EchoExperience.debugMsg2("OnAchievementUpdated: "
    , " eventCode="     , tostring(eventCode) 
    , " achievementID=" , tostring(achievementID) 
  )
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    --Does this help at all??? is this how it is supposed to work? no idea!
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnAchievementUpdatedWork(achievementID)
      end
    )
  else
    EchoExperience.OnAchievementUpdatedWork(achievementID)
  end
end

------------------------------
-- HELPER for
-- EVENT EVENT_ACHIEVEMENT_UPDATED (number eventCode, number id)
function EchoExperience.OnAchievementUpdatedWork(achievementID)
  --d("OnAchievementUpdatedWork: achievementID="..achievementID)
  local name        = GetAchievementInfo(achievementID)
  local link        = GetAchievementLink(achievementID, LINK_STYLE_BRACKETS)
  local numCriteria = GetAchievementNumCriteria(achievementID)
  --local progress    = GetAchievementProgress(achievementID)
  --
  local maxCnt = numCriteria
  if(EchoExperience.savedVariables.showachievementmax<10) then    
    if( numCriteria > EchoExperience.savedVariables.showachievementmax) then
      --EchoExperience.debugMsg("OnAchievementUpdated: Achievement " .. name .. " has criteria:" .. tostring(numCriteria) )
      --numCriteria = EchoExperience.savedVariables.showachievementmax
      maxCnt = EchoExperience.savedVariables.showachievementmax
     -- EchoExperience.debugMsg("OnAchievementUpdated: Going to skip criteria over:" .. tostring(maxCnt) )
    end
  end
  --
  local cnt = 0
  local successCnt = 0
  for i = 1, maxCnt do
      local description, numCompleted, numRequired = GetAchievementCriterion(achievementID, i)
      EchoExperience.debugMsg2("OnAchievementUpdated: "
        , " description="  , tostring(description) 
        , " numCompleted=" , tostring(numCompleted) 
        , " numRequired="  , tostring(numRequired) 
        , " maxCnt="       , tostring(maxCnt) 
        , " cnt="          , tostring(cnt) 
        --, " progress="     , tostring(progress) 
      )
      if numCompleted == numRequired then
        successCnt = successCnt + 1
      end
      if( numRequired > 1 and numCompleted > 0 ) then
        if( cnt <= maxCnt) then
          local sentence = GetString(SI_ECHOEXP_ACHIEVEMENT_UPDATED)
          local strL     = zo_strformat(sentence, link, achievementID, description, numCompleted, numRequired)
          EchoExperience.outputToChanel(strL, msgTypeQuest)
        end
        cnt = cnt + 1
      end
  end
  --
  if(numCriteria==1 and successCnt==numCriteria) then
    local sentence = GetString(SI_ECHOEXP_ACHIEVEMENT_COMPLETED)
    local strL = zo_strformat(sentence, link, achievementID, description)
    EchoExperience.outputToChanel(strL, msgTypeQuest)    
  elseif(numCriteria > 1 and successCnt==numCriteria) then
    local sentence = GetString(SI_ECHOEXP_ACHIEVEMENT_UPDATED1)
    local strL = zo_strformat(sentence, link, achievementID, description)
    EchoExperience.outputToChanel(strL, msgTypeQuest)
  elseif( numCriteria > 1 ) then
    local sentence = GetString(SI_ECHOEXP_ACHIEVEMENT_UPDATED2)
    local strL = zo_strformat(sentence, link, achievementID, description, successCnt, numCriteria)
    EchoExperience.outputToChanel(strL, msgTypeQuest)
  end
  --
end

------------------------------
-- EVENT EVENT_ACHIEVEMENT_AWARDED
-- (number eventCode, string name, number points, number id, string link)
function EchoExperience.OnAchievementAwarded(eventCode, name, points, id, link)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnAchievementAwardedWork(eventCode, name, points, id, link)
      end
    )
  else
    EchoExperience.OnAchievementAwardedWork(eventCode, name, points, id, link)
  end
end
  
-- 
function EchoExperience.OnAchievementAwardedWork(eventCode, name, points, id, link)
  EchoExperience.debugMsg2("OnAchievementAwarded: "
    , " name="      , tostring(name)
    , " points="    , tostring(points)
    , " id="        , tostring(id)
    , " link="      , tostring(link)
    , " eventCode=" , tostring(eventCode) 
  )  
  local sentence = GetString(SI_ECHOEXP_ACHIEVEMENT_AWARDED)
  local strL = zo_strformat(sentence, name, points, id, link)
  EchoExperience.outputToChanel(strL, msgTypeQuest)
  --if(EchoExperience.savedVariables.sessiontracking) then
    --New Tracking Module
  if(EchoTracking~=nil and EchoExperience.savedVariables.lifetimetracking )then
    EchoTracking.saveAchievement(name, points, id, link, GetTimeStamp() )
  end
  --Tracking
  if(EchoExperience.savedVariables.sessiontracking) then
    local currentSession = EchoExperience:GetCurrentTrackingSession()
    currentSession.achievements[name] = {}
    currentSession.achievements[name].earned = GetTimeStamp() -- id64
    currentSession.achievements[name].link   = link
    currentSession.achievements[name].id     = id
    currentSession.achievements[name].points = points
  end
end


------------------------------
-- Unused
-- EVENT
-- EVENT_EFFECT_CHANGED (number eventCode, MsgEffectResult changeType, number effectSlot, string effectName, string unitTag, number beginTime, number endTime, number stackCount, string iconName, string buffType, BuffEffectType effectType, AbilityType abilityType, StatusEffectType statusEffectType, string unitName, number unitId, number abilityId, CombatUnitType sourceType)
--https://wiki.esoui.com/EVENT_EFFECT_CHANGED
-- NOTES: No the psyjic passive for major protection never gets thrown!
function EchoExperience.OnCombatEffectChanged(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, sourceType)
  --
  --local pID       = GetCurrentCharacterId()
  --if(pID ~= unitId) then return end
  --TESTING
  EchoExperience.outputMsg("OnCombatEffectChanged: "
    .." eventCode="     .. tostring(eventCode) 
    .." pID="           .. tostring(pID)
    .." unitId="        .. tostring(unitId)
    .." changeType="    .. tostring(changeType)
    .." effectSlot="    .. tostring(effectSlot)
    .." effectName="    .. tostring(effectName)
    .." unitTag="       .. tostring(unitTag)
    .." buffType="      .. tostring(buffType)
    .." unitName="      .. tostring(unitName)
    .." abilityId="     .. tostring(abilityId)    
  )
  --
end
------------------------------
------------------------------

------------------------------
-- EVENT
function EchoExperience.OnLitanyOfBlood(targetNameL, targetUnitId)
  --name coming in might not be a string
  local targetName = zo_strformat("<<1>>", targetNameL )
  EchoExperience.debugMsg2("lob called w/targetName='", tostring(targetName), "'")
  local lob = EchoExperience.LitanyOfBlood
  if( lob == nil) then
    EchoExperience.debugMsg("lob null")
    return
  end
  local loblist = lob.list
  if( loblist == nil) then
    EchoExperience.debugMsg("loblist null")
    return
  end
  local targetData = nil
  for k, v in pairs(loblist) do
    EchoExperience.debugMsg( zo_strformat( "<<1>>=<<2>>",tostring(k), tostring(v) ) )
    if( tostring(k) == tostring(targetName) ) then
      targetData = v
    end
  end
  --
  local elemLB = targetData -- loblist[targetName]
  if( elemLB == nil) then
    EchoExperience.debugMsg("Corpse not on list for Litany")
    return
  end  
  -- found person on list 
  EchoExperience.debugMsg("Corpse may be on list for Litany")
  local elemLBZoneName = zo_strformat("<<1>>", elemLB["ZoneName"] )
  EchoExperience.debugMsg2("LitanyOfBlood1: "
    , " elemLBZoneName='" , tostring(elemLBZoneName), "'"
  )        
  local elemLBSubzoneName = zo_strformat("<<1>>", elemLB["SubzoneName"] ) 
  EchoExperience.debugMsg2("LitanyOfBlood1: "
    , " elemLBSubzoneName='", tostring(elemLBSubzoneName), "'"
  )
  local subzoneNamePL = zo_strformat("<<1>>",  GetPlayerActiveSubzoneName() )
  local zoneNamePL    =  zo_strformat("<<1>>", GetPlayerActiveZoneName() )
   EchoExperience.debugMsg2("LitanyOfBlood1: "
    , " zoneNamePL='"      , tostring(zoneNamePL) , "'"
  )
  EchoExperience.debugMsg2("LitanyOfBlood1: "
    , " subzoneNamePL='"      , tostring(subzoneNamePL) , "'"
  )
  local lbDataHasSubzone = true
  if(elemLBSubzoneName==nil or elemLBSubzoneName=="" ) then
    lbDataHasSubzone = false
  end
  local playerHasSubzone = true
  if(subzoneNamePL==nil or subzoneNamePL=="" ) then
    playerHasSubzone = false
  end
  EchoExperience.debugMsg2("LitanyOfBlood1: "
    , " lbDataHasSubzone='"      , tostring(lbDataHasSubzone) , "'"
  )
  EchoExperience.debugMsg2("LitanyOfBlood1: "
    , " playerHasSubzone='"      , tostring(playerHasSubzone) , "'"
  )
  
  --
  local lbMatch = false
  if( lbDataHasSubzone and playerHasSubzone ) then
    EchoExperience.debugMsg("LitanyOfBlood1: check subzone")
    if( elemLBZoneName == zoneNamePL and elemLBSubzoneName == subzoneNamePL ) then
      EchoExperience.debugMsg("LitanyOfBlood1: MATCH")
      lbMatch = true
    end
  elseif( elemLBZoneName == zoneNamePL or elemLBZoneName == subzoneNamePL ) then
    EchoExperience.debugMsg("LitanyOfBlood1: just check zone")
    EchoExperience.debugMsg("LitanyOfBlood1: MATCH")
    lbMatch = true
  end
  --found person on list 
  if(lbMatch) then
    local sentence = GetString(SI_ECHOEXP_KILL_LB1)
    EchoExperience.outputMsg(sentence)
    EchoExperience.savedVariables.LitanyOfBloodDone[targetName] = GetTimeStamp()
  else
    local sentence = GetString(SI_ECHOEXP_KILL_LB0)
    EchoExperience.outputMsg(sentence)
  end
  --
end

------------------------------
-- ProfileSettings, from settings
function EchoExperience:DoSaveProfileSettings()
  local pName = GetUnitName("player")
  EchoExperience.accountVariables.useAsDefault = 	pName
  EchoExperience.accountVariables.defaults = {}
  --
  EchoExperience.accountVariables.defaults.immersive        = EchoExperience.savedVariables.immersive
  EchoExperience.accountVariables.defaults.showmdk          = EchoExperience.savedVariables.showmdk
  EchoExperience.accountVariables.defaults.showdiscovery    = EchoExperience.savedVariables.showdiscovery
  EchoExperience.accountVariables.defaults.sessiontracking  = EchoExperience.savedVariables.sessiontracking
  EchoExperience.accountVariables.defaults.lifetimetracking = EchoExperience.savedVariables.lifetimetracking
  --
  EchoExperience.accountVariables.defaults.groupLoot       = EchoExperience.savedVariables.groupLoot
  EchoExperience.accountVariables.defaults.showGuildLogin  = EchoExperience.savedVariables.showGuildLogin
  EchoExperience.accountVariables.defaults.showGuildLogout = EchoExperience.savedVariables.showGuildLogout
  EchoExperience.accountVariables.defaults.showExp         = EchoExperience.savedVariables.showExp
  EchoExperience.accountVariables.defaults.showExpT1       = EchoExperience.savedVariables.showExpT1
  EchoExperience.accountVariables.defaults.showExpT2       = EchoExperience.savedVariables.showExpT2
  EchoExperience.accountVariables.defaults.verboseExp      = EchoExperience.savedVariables.verboseExp
  
  --
  EchoExperience.accountVariables.defaults.showSkillExp    = EchoExperience.savedVariables.showSkillExp
  EchoExperience.accountVariables.defaults.showAllSkillExp = EchoExperience.savedVariables.showAllSkillExp
  --
  EchoExperience.accountVariables.defaults.showLoot           = EchoExperience.savedVariables.showLoot
  EchoExperience.accountVariables.defaults.extendedLoot       = EchoExperience.savedVariables.extendedLoot
  EchoExperience.accountVariables.defaults.showquests         = EchoExperience.savedVariables.showquests
  EchoExperience.accountVariables.defaults.showquestsadvanced = EchoExperience.savedVariables.showquestsadvanced
  
  EchoExperience.accountVariables.defaults.showachievements       = EchoExperience.savedVariables.showachievements
  EchoExperience.accountVariables.defaults.showachievementdetails = EchoExperience.savedVariables.showachievementdetails
  EchoExperience.accountVariables.defaults.lorebooktracking       = EchoExperience.savedVariables.lorebooktracking
  
  --
  --Copy table Settings
  EchoExperience.accountVariables.defaults.guildsettings   = EchoExperience:deepcopy(EchoExperience.savedVariables.guildsettings)
  EchoExperience.accountVariables.defaults.lootsettings    = EchoExperience:deepcopy(EchoExperience.savedVariables.lootsettings)
  EchoExperience.accountVariables.defaults.expsettings     = EchoExperience:deepcopy(EchoExperience.savedVariables.expsettings)
  EchoExperience.accountVariables.defaults.questsettings   = EchoExperience:deepcopy(EchoExperience.savedVariables.questsettings)
end

------------------------------
-- ProfileSettings, from settings
function EchoExperience:DoLoadProfileSettings()
  if(EchoExperience.accountVariables.useAsDefault~=nil and EchoExperience.accountVariables.defaults~=nil )then
    --
    EchoExperience.savedVariables.immersive        = EchoExperience.accountVariables.defaults.immersive
    EchoExperience.savedVariables.showmdk          = EchoExperience.accountVariables.defaults.showmdk
    EchoExperience.savedVariables.showdiscovery    = EchoExperience.accountVariables.defaults.showdiscovery
    EchoExperience.savedVariables.sessiontracking  = EchoExperience.accountVariables.defaults.sessiontracking
    EchoExperience.savedVariables.lifetimetracking = EchoExperience.accountVariables.defaults.lifetimetracking
    --
    EchoExperience.savedVariables.verboseExp      = EchoExperience.accountVariables.defaults.verboseExp
    EchoExperience.savedVariables.showAllSkillExp = EchoExperience.accountVariables.defaults.showAllSkillExp	
    EchoExperience.savedVariables.showSkillExp    = EchoExperience.accountVariables.defaults.showSkillExp	
    --
    EchoExperience.savedVariables.groupLoot       = EchoExperience.accountVariables.defaults.groupLoot       
    EchoExperience.savedVariables.showGuildLogin  = EchoExperience.accountVariables.defaults.showGuildLogin
    EchoExperience.savedVariables.showGuildLogout = EchoExperience.accountVariables.defaults.showGuildLogout
    EchoExperience.savedVariables.showExp         = EchoExperience.accountVariables.defaults.showExp
    EchoExperience.savedVariables.showExpT1       = EchoExperience.accountVariables.defaults.showExpT1
    EchoExperience.savedVariables.showExpT2       = EchoExperience.accountVariables.defaults.showExpT2
    EchoExperience.savedVariables.showLoot        = EchoExperience.accountVariables.defaults.showLoot
    EchoExperience.savedVariables.extendedLoot    = EchoExperience.accountVariables.defaults.extendedLoot
    EchoExperience.savedVariables.showquests      = EchoExperience.accountVariables.defaults.showquests
    EchoExperience.savedVariables.showquestsadvanced = EchoExperience.accountVariables.defaults.showquestsadvanced
    
    EchoExperience.savedVariables.showachievements       = EchoExperience.accountVariables.defaults.showachievements
    EchoExperience.savedVariables.showachievementdetails = EchoExperience.accountVariables.defaults.showachievementdetails
    EchoExperience.savedVariables.lorebooktracking       = EchoExperience.accountVariables.defaults.lorebooktracking
    --
    --Copy table Settings
    EchoExperience.savedVariables.guildsettings   = EchoExperience:deepcopy(EchoExperience.accountVariables.defaults.guildsettings)
    EchoExperience.savedVariables.lootsettings    = EchoExperience:deepcopy(EchoExperience.accountVariables.defaults.lootsettings)
    EchoExperience.savedVariables.expsettings     = EchoExperience:deepcopy(EchoExperience.accountVariables.defaults.expsettings)
    EchoExperience.savedVariables.questsettings   = EchoExperience:deepcopy(EchoExperience.accountVariables.defaults.questsettings)
    
    EchoExperience:RefreshTabs()
  end
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
-- SETUP
--https://wiki.esoui.com/Events
--EVENT_CLAIM_LEVEL_UP_REWARD_RESULT
--EVENT_DISCOVERY_EXPERIENCE (
--EVENT_LEVEL_UPDATE
function EchoExperience.SetupExpGainsEvents(reportMe)
  --
  if( EchoExperience.savedVariables.showExpT1 ==false and EchoExperience.savedVariables.showExpT2 == false) then
    EchoExperience.savedVariables.showExp = false
  end
  --
	if (EchoExperience.savedVariables.showExp) then
		if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_EXPGAINS_SHOW),msgTypeSYS) end
    local eventNamespace
    eventNamespace = EchoExperience.name.."SkillXPGain"
		EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_SKILL_XP_UPDATE, EchoExperience.OnSkillExperienceUpdate)
    --eventNamespace = EchoExperience.name.."OnCombatState"
		--EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_PLAYER_COMBAT_STATE,      EchoExperience.OnCombatState )
    eventNamespace = EchoExperience.name.."SkillLineAdded"
		EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_SKILL_LINE_ADDED, EchoExperience.OnSkillLineAdded)
		--TODO dont need sometimes?
    eventNamespace = EchoExperience.name.."ChampionUnlocked"
		EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_CHAMPION_SYSTEM_UNLOCKED, EchoExperience.OnChampionUnlocked)
    eventNamespace = EchoExperience.name.."XPUpdate"
    if(EchoExperience.savedVariables.showExpT2) then
      EVENT_MANAGER:RegisterForEvent(eventNamespace,		EVENT_EXPERIENCE_UPDATE, EchoExperience.OnExperienceUpdate)
    else
      EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_EXPERIENCE_UPDATE, EchoExperience.OnExperienceUpdate)
    end
    eventNamespace = EchoExperience.name.."XPGain"
    if(EchoExperience.savedVariables.showExpT1) then
      EVENT_MANAGER:RegisterForEvent(eventNamespace,		  EVENT_EXPERIENCE_GAIN,   EchoExperience.OnExperienceGain)
    else
      EVENT_MANAGER:UnregisterForEvent(eventNamespace,		EVENT_EXPERIENCE_GAIN,   EchoExperience.OnExperienceGain)
    end
    eventNamespace = EchoExperience.name.."EVENT_CHAMPION_POINT_GAINED"
		EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_CHAMPION_POINT_GAINED, EchoExperience.OnChampionPointGain)
    --eventNamespace = EchoExperience.name.."OnAlliancePtGain"
		--EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_ALLIANCE_POINT_UPDATE,    EchoExperience.OnAlliancePtGain)
    eventNamespace = EchoExperience.name.."OnSkillPtChange"
		EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_SKILL_POINTS_CHANGED, EchoExperience.OnSkillPtChange)
		--not really needed
    eventNamespace = EchoExperience.name.."AbilityProgression"
    EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_ABILITY_PROGRESSION_XP_UPDATE, EchoExperience.OnAbilityExperienceUpdate)
    eventNamespace = EchoExperience.name.."EVENT_SKILL_RANK_UPDATE"
    EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_SKILL_RANK_UPDATE, EchoExperience.OnSkillRankUpdate)
    eventNamespace = EchoExperience.name.."EVENT_ABILITY_PROGRESSION_RANK_UPDATE"
    EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_ABILITY_PROGRESSION_RANK_UPDATE, EchoExperience.OnSkillProgressRankUpdate)
    eventNamespace = EchoExperience.name.."EVENT_RIDING_SKILL_IMPROVEMENT"
    EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_RIDING_SKILL_IMPROVEMENT, EchoExperience.OnRidingSkillUpdate)
	else -- showExp
    if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_EXPGAINS_HIDE),msgTypeSYS) end    
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."SkillXPGain",	    EVENT_SKILL_XP_UPDATE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."SkillLineAdded",	  EVENT_SKILL_LINE_ADDED)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."ChampionUnlocked", EVENT_CHAMPION_SYSTEM_UNLOCKED)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."XPUpdate",		      EVENT_EXPERIENCE_UPDATE)    
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."XPGain",		        EVENT_EXPERIENCE_GAIN)    
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_CHAMPION_POINT_GAINED", EVENT_CHAMPION_POINT_GAINED)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnAlliancePtGain",	EVENT_ALLIANCE_POINT_UPDATE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnSkillPtChange",	EVENT_SKILL_POINTS_CHANGED)

		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnDiscoveryExp",		       EVENT_DISCOVERY_EXPERIENCE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."AbilityProgression",      EVENT_ABILITY_PROGRESSION_XP_UPDATE)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_SKILL_RANK_UPDATE", EVENT_SKILL_RANK_UPDATE)    
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ABILITY_PROGRESSION_RANK_UPDATE",EVENT_ABILITY_PROGRESSION_RANK_UPDATE)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_RIDING_SKILL_IMPROVEMENT",       EVENT_RIDING_SKILL_IMPROVEMENT)
	end
end

------------------------------
-- SETUP
function EchoExperience.SetupLootGainsEvents(reportMe)
	if (EchoExperience.savedVariables.showLoot) then
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."LootReceived",	EVENT_LOOT_RECEIVED, EchoExperience.OnLootReceived)
		if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINS_SHOW),msgTypeSYS) end
    --TODO redundency here can fix?
    if (EchoExperience.savedVariables.extendedLoot) then
      if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINSE_SHOW),msgTypeSYS) end
      --
      local eventNamespace
      eventNamespace = EchoExperience.name.."OnLootFailed"
      EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_LOOT_ITEM_FAILED, EchoExperience.OnLootFailed)
      eventNamespace = EchoExperience.name.."OnBankedCurrency"
      EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_BANKED_CURRENCY_UPDATE, EchoExperience.OnBankedCurrency)
      eventNamespace = EchoExperience.name.."OnCurrencyUpdate"
      EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_CURRENCY_UPDATE, EchoExperience.OnCurrencyUpdate)
      eventNamespace = EchoExperience.name.."OnSellReceipt"
      EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_SELL_RECEIPT, EchoExperience.OnSellReceipt)
      eventNamespace = EchoExperience.name.."OnBuybackReceipt"
      EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_BUYBACK_RECEIPT, EchoExperience.OnBuybackReceipt)
      eventNamespace = EchoExperience.name.."OnBuyReceipt"
      EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_BUY_RECEIPT, EchoExperience.OnBuyReceipt)

      eventNamespace = EchoExperience.name.."OnAlliancePointUpdate"
      EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_ALLIANCE_POINT_UPDATE, EchoExperience.OnAlliancePointUpdate)
      eventNamespace = EchoExperience.name.."OnInventoryItemDestroyed"
      EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_INVENTORY_ITEM_DESTROYED, EchoExperience.OnInventoryItemDestroyed)
      eventNamespace = EchoExperience.name.."OnInventoryItemUsed"
      EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_INVENTORY_ITEM_USED, EchoExperience.OnInventoryItemUsed)
      eventNamespace = EchoExperience.name.."OnInventorySingleSlotUpdate"
      EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_INVENTORY_SINGLE_SLOT_UPDATE, EchoExperience.OnInventorySingleSlotUpdate)
      eventNamespace = EchoExperience.name.."OnInventorySingleSlotUpdate"
      EVENT_MANAGER:AddFilterForEvent(eventNamespace, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DEFAULT)
      eventNamespace = EchoExperience.name.."EVENT_ANTIQUITY_LEAD_ACQUIRED"
      EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_ANTIQUITY_LEAD_ACQUIRED, EchoExperience.OnAntiquityLeadAcquired)
      --Extended loot
    else
      if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINSE_HIDE),msgTypeSYS) end
    end
	else
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."LootReceived",	EVENT_LOOT_RECEIVED)
    if (not EchoExperience.savedVariables.extendedLoot) then
      if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINSE_HIDE),msgTypeSYS) end
    end
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnLootFailed",     EVENT_LOOT_ITEM_FAILED)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnBankedCurrency",	EVENT_BANKED_CURRENCY_UPDATE)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnCurrencyUpdate",	EVENT_CURRENCY_UPDATE)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnSellReceipt",	  EVENT_SELL_RECEIPT)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnBuybackReceipt",	EVENT_BUYBACK_RECEIPT)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnBuyReceipt",	    EVENT_BUY_RECEIPT)
  
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnAlliancePointUpdate",	  EVENT_ALLIANCE_POINT_UPDATE)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnInventoryItemDestroyed",	EVENT_INVENTORY_ITEM_DESTROYED)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnInventoryItemUsed",	    EVENT_INVENTORY_ITEM_USED)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnInventorySingleSlotUpdate",	  EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ANTIQUITY_LEAD_ACQUIRED",	EVENT_ANTIQUITY_LEAD_ACQUIRED)
		if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINS_HIDE),msgTypeSYS) end
	end
end

------------------------------
-- SETUP
function EchoExperience.SetupGuildEvents()
  if( EchoExperience.view.GuildEventsReg == true) then
    if ( not EchoExperience.savedVariables.showGuildLogin and not EchoExperience.savedVariables.showGuildLogout ) then
    	EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED",	EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED, EchoExperience.OnGuildMemberStatusChanged)
      EchoExperience.view.GuildEventsReg = false
      EchoExperience.debugMsg(GetString(SI_ECHOEXP_GUILD_EVENT_UNREG))--"Unregistered for Guild events")
    end
  else
    if (EchoExperience.savedVariables.showGuildLogin or EchoExperience.savedVariables.showGuildLogout ) then
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED",	EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED, EchoExperience.OnGuildMemberStatusChanged)
      EchoExperience.view.GuildEventsReg = true
      EchoExperience.debugMsg(GetString(SI_ECHOEXP_GUILD_EVENT_REG))--"Registered for Guild events")
    end
  end
  if (EchoExperience.savedVariables.showGuildMisc ) then
      EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_ADDED",	EVENT_GUILD_MEMBER_ADDED, EchoExperience.OnGuildMemberAdded)
      EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_REMOVED",	EVENT_GUILD_MEMBER_REMOVED, EchoExperience.OnGuildMemberRemoved)
  else
    EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_ADDED",	EVENT_GUILD_MEMBER_ADDED, EchoExperience.OnGuildMemberAdded)
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_REMOVED",	EVENT_GUILD_MEMBER_REMOVED, EchoExperience.OnGuildMemberRemoved)    
  end
end

------------------------------
-- SETUP
function EchoExperience.SetupAchievmentEvents(reportMe)
  if( EchoExperience.savedVariables.showachievements) then
    EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENT_AWARDED",	EVENT_ACHIEVEMENT_AWARDED, EchoExperience.OnAchievementAwarded)
    EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_LEVEL_UPDATE",		    EVENT_LEVEL_UPDATE,          EchoExperience.OnExperienceLevelUpdate, REGISTER_FILTER_UNIT_TAG , "player" )
    if(EchoExperience.savedVariables.showachievementdetails) then
      --EchoExperience.debugMsg("Showing achievement details")
      --EVENT_ACHIEVEMENTS_SEARCH_RESULTS_READY (number eventCode)
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENTS_UPDATED",	EVENT_ACHIEVEMENTS_UPDATED, EchoExperience.OnAchievementsUpdated)
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENT_UPDATED",	EVENT_ACHIEVEMENT_UPDATED, EchoExperience.OnAchievementUpdated)    
      --EVENT_PLAYER_TITLES_UPDATE (number eventCode)
      --EVENT_TITLE_UPDATE (number eventCode, string unitTag)
    else
      --EchoExperience.debugMsg("Not showing achievement details")
      --EVENT_ACHIEVEMENTS_SEARCH_RESULTS_READY (number eventCode)
      EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENTS_UPDATED",	EVENT_ACHIEVEMENTS_UPDATED)
      EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENT_UPDATED",	EVENT_ACHIEVEMENT_UPDATED)    
      --EVENT_PLAYER_TITLES_UPDATE (number eventCode)
      --EVENT_TITLE_UPDATE (number eventCode, string unitTag)
    end
  else
    --EchoExperience.debugMsg("Not showing achievement details")
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENT_AWARDED",	EVENT_ACHIEVEMENT_AWARDED)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_LEVEL_UPDATE", EVENT_LEVEL_UPDATE)
    --EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENTS_SEARCH_RESULTS_READY", EVENT_ACHIEVEMENTS_SEARCH_RESULTS_READY)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENTS_UPDATED", EVENT_ACHIEVEMENTS_UPDATED)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENT_UPDATED", EVENT_ACHIEVEMENT_UPDATED)
    --EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_PLAYER_TITLES_UPDATE", EVENT_PLAYER_TITLES_UPDATE)
    --EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_TITLE_UPDATE", EVENT_TITLE_UPDATE)
  end
end

------------------------------
-- SETUP
function EchoExperience.SetupDiscoveryEvents(reportMe)
  if( EchoExperience.savedVariables.showdiscovery) then
  		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnDiscoveryExp",	EVENT_DISCOVERY_EXPERIENCE,     EchoExperience.OnDiscoveryExperienceGain)
  else
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_DISCOVERY_EXPERIENCE",	EVENT_DISCOVERY_EXPERIENCE)
  end
end

------------------------------
-- SETUP
function EchoExperience.SetupAlphaEvents(reportMe)
  if( EchoExperience.savedVariables.showalpha ) then
    local eventNamespace
    eventNamespace = EchoExperience.name.."EVENT_QUEST_SHARE_RESULT"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_QUEST_SHARE_RESULT, EchoExperience.OnEventQuestSharedResult)
    eventNamespace = EchoExperience.name.."EVENT_QUEST_SHARE_REMOVED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_QUEST_SHARE_REMOVED, EchoExperience.OnEventQuestSharedRemoved)
    eventNamespace = EchoExperience.name.."EVENT_QUEST_SHARED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_QUEST_SHARED, EchoExperience.OnEventQuestSharedStart)
    
    --EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_EFFECT_CHANGED",	EVENT_EFFECT_CHANGED, EchoExperience.OnCombatEffectChanged)    
    --EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_UNIT_DESTROYED",	EVENT_UNIT_DESTROYED, EchoExperience.OnUnitDestroyed)
  else
    local eventNamespace
    --EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_EFFECT_CHANGED",	EVENT_EFFECT_CHANGED)
    eventNamespace = EchoExperience.name.."EVENT_QUEST_SHARE_RESULT"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_QUEST_SHARE_RESULT)
    eventNamespace = EchoExperience.name.."EVENT_QUEST_SHARE_REMOVED"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_QUEST_SHARE_REMOVED)
    eventNamespace = EchoExperience.name.."EVENT_QUEST_SHARED"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_QUEST_SHARED)
  end
end

------------------------------
-- SETUP
function EchoExperience.SetupLoreBookEvents(reportMe)
  if( EchoExperience.savedVariables.lorebooktracking ) then
    local eventNamespace = EchoExperience.name.."EVENT_LORE_BOOK_ALREADY_KNOWN"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_LORE_BOOK_ALREADY_KNOWN, EchoExperience.OnLoreBookAlreadyKnown)
    eventNamespace = EchoExperience.name.."EVENT_LORE_BOOK_LEARNED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_LORE_BOOK_LEARNED, EchoExperience.OnLoreBookLearned)    
    eventNamespace = EchoExperience.name.."EVENT_LORE_BOOK_LEARNED_SKILL_EXPERIENCE"
    --dont think need this... EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_LORE_BOOK_LEARNED_SKILL_EXPERIENCE, EchoExperience.OnLoreBookSkillExp)
    eventNamespace = EchoExperience.name.."EVENT_LORE_COLLECTION_COMPLETED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_LORE_COLLECTION_COMPLETED, EchoExperience.OnLoreBookCollectionComplete)
    eventNamespace = EchoExperience.name.."EVENT_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE, EchoExperience.OnLoreBookCollectionCompleteSkillExp)
    eventNamespace = EchoExperience.name.."EVENT_LORE_LIBRARY_INITIALIZED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_LORE_LIBRARY_INITIALIZED, EchoExperience.OnLoreBookLibraryInit)    
  else
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_LORE_BOOK_ALREADY_KNOWN",	EVENT_LORE_BOOK_ALREADY_KNOWN)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_LORE_BOOK_LEARNED",	EVENT_LORE_BOOK_LEARNED)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_LORE_BOOK_LEARNED_SKILL_EXPERIENCE",	EVENT_LORE_BOOK_LEARNED_SKILL_EXPERIENCE)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_LORE_COLLECTION_COMPLETED",	EVENT_LORE_COLLECTION_COMPLETED)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE",	EVENT_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_LORE_LIBRARY_INITIALIZED",	EVENT_LORE_LIBRARY_INITIALIZED)
  end
  
--[[ TODO BOOK EVENTS
  EVENT_LORE_BOOK_ALREADY_KNOWN (number eventCode, string bookTitle)
  EVENT_LORE_BOOK_LEARNED (number eventCode, number categoryIndex, number collectionIndex, number bookIndex, number guildIndex, boolean isMaxRank)
  EVENT_LORE_BOOK_LEARNED_SKILL_EXPERIENCE (number eventCode, number categoryIndex, number collectionIndex, number bookIndex, number guildIndex, SkillType skillType, number skillIndex, number rank, number previousXP, number currentXP)
  EVENT_LORE_COLLECTION_COMPLETED (number eventCode, number categoryIndex, number collectionIndex, number guildIndex, boolean isMaxRank)
  EVENT_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE (number eventCode, number categoryIndex, number collectionIndex, number guildIndex, SkillType skillType, number skillIndex, number rank, number previousXP, number currentXP)
  EVENT_LORE_LIBRARY_INITIALIZED (number eventCode)
--]]
end

------------------------------
-- SETUP
function EchoExperience.SetupMiscEvents(reportMe)
  if( EchoExperience.savedVariables.sessiontracking or EchoExperience.savedVariables.showmdk ) then
    --if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_XXX_HIDE),msgTypeSYS) end
    local eventNamespace = EchoExperience.name.."EVENT_COMBAT_EVENT"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_COMBAT_EVENT, EchoExperience.OnCombatSomethingDied)
    --EVENT_MANAGER:AddFilterForEvent(eventNamespace, eventId, filterType, varying filterParameter)
    --EVENT_MANAGER:AddFilterForEvent(eventNamespace, EVENT_COMBAT_EVENT, REGISTER_FILTER_COMBAT_RESULT, ACTION_RESULT_DIED)
    --EVENT_MANAGER:AddFilterForEvent(eventNamespace, EVENT_COMBAT_EVENT, REGISTER_FILTER_IS_ERROR, false)
     --ACTION_RESULT_TARGET_DEAD 
    --EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_UNIT_DESTROYED",	EVENT_UNIT_DESTROYED, EchoExperience.OnUnitDestroyed)
    eventNamespace = EchoExperience.name.."EVENT_BATTLEGROUND_KILL"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_BATTLEGROUND_KILL, EchoExperience.OnBattlegroundKill)
    --
    -- Triggers when you leave a guild (guildId / guildName)
    eventNamespace = EchoExperience.name.."EVENT_GUILD_SELF_LEFT_GUILD"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_GUILD_SELF_LEFT_GUILD, EchoExperience.OnGuildSelfLeft)
    -- Triggers when you join a guild (guildId / guildName)
    eventNamespace = EchoExperience.name.."EVENT_GUILD_SELF_JOINED_GUILD"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_GUILD_SELF_JOINED_GUILD, EchoExperience.OnGuildSelfJoined)
    --
  else
    --if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_XXX_HIDE),msgTypeSYS) end
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_COMBAT_EVENT",	      EVENT_COMBAT_EVENT)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_BATTLEGROUND_KILL",	EVENT_BATTLEGROUND_KILL)
    --EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_UNIT_DESTROYED",	EVENT_UNIT_DESTROYED, EchoExperience.OnUnitDestroyed)
  end
  --EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_UNIT_DESTROYED",	EVENT_UNIT_DESTROYED, EchoExperience.OnUnitDestroyed)
end

------------------------------
-- SETUP
function EchoExperience.SetupEventsQuest(reportMe)
  if( EchoExperience.savedVariables.showquests ) then
    if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_QUEST_SHOW),msgTypeSYS) end
    local eventNamespace = nil
    eventNamespace = EchoExperience.name.."EVENT_QUEST_ADDED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_QUEST_ADDED, EchoExperience.OnEventQuestAdded)
    eventNamespace = EchoExperience.name.."EVENT_QUEST_COMPLETE"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_QUEST_COMPLETE, EchoExperience.OnEventQuestComplete)    
    eventNamespace = EchoExperience.name.."EVENT_QUEST_REMOVED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_QUEST_REMOVED, EchoExperience.OnEventQuestRemoved)    
        
    if( EchoExperience.savedVariables.showquestsadvanced ) then
      eventNamespace = EchoExperience.name.."EVENT_QUEST_ADVANCED"
      EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_QUEST_ADVANCED, EchoExperience.OnEventQuestAdvanced)
    end
  else
    if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_QUEST_HIDE),msgTypeSYS) end
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_QUEST_ADDED",	EVENT_QUEST_ADDED)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_QUEST_COMPLETE",	EVENT_QUEST_COMPLETE)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_QUEST_REMOVED",	EVENT_QUEST_REMOVED)    
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_QUEST_ADVANCED",	EVENT_QUEST_ADVANCED)
  end
end

------------------------------
-- SETUP
--In case of big version changes
function EchoExperience:UpgradeSettings()
  local upgraded = false
  --
  local needUpgrade = false
  if( EchoExperience.savedVariables.iversion == nil) then
    needUpgrade = true
  end
  if( EchoExperience.savedVariables.iversion < EchoExperience.versionnumeric) then
    needUpgrade = true
  end
  if(needUpgrade) then
    EchoExperience.savedVariables.LitanyOfBloodDone = {}
    if(EchoExperience.savedVariables.LitanyOfBlood~=nil) then
      for k, v in pairs(EchoExperience.savedVariables.LitanyOfBlood) do
        d ( zo_strformat( "litany: <<1>>=<<2>>", k, v ))
        if(v.done) then
          EchoExperience.savedVariables.LitanyOfBloodDone[k] = GetTimeStamp()
        end
      end
    end
    EchoExperience.savedVariables.LitanyOfBlood = nil
    upgraded = true    
  end
  
  --
  if(upgraded) then
    local oldversion = EchoExperience.savedVariables.sversion
    EchoExperience.savedVariables.oldversion  = EchoExperience.savedVariables.sversion
    EchoExperience.savedVariables.sversion    = EchoExperience.version
    EchoExperience.savedVariables.oldversion  = EchoExperience.savedVariables.sversion
    EchoExperience.savedVariables.iversion    = EchoExperience.versionnumeric
    EchoExperience.savedVariables.oldiversion = EchoExperience.savedVariables.iversion
    EchoExperience:UpdateUIExpTabs()
    EchoExperience:UpdateUILootTabs()
    EchoExperience:UpdateUIGuildTabs()
    local val = zo_strformat( "Upgraded EchoExp Version from '<<1>>' to '<<2>>'.", oldversion, EchoExperience.version )
    EchoExperience.outputMsg(val)        
    zo_callLater(EchoExperience.RefreshTabs, 12000)
  end
end

------------------------------
-- UI
function EchoExperience:RefreshTabs()
  local myFpsLabelControl = WINDOW_MANAGER:GetControlByName("EchoExpDDExpOutput", "")
  if(myFpsLabelControl~=nil) then
    EchoExperience.UpdateUIExpTabs()
    EchoExperience.UpdateUILootTabs()
    EchoExperience.UpdateUIGuildTabs()
    EchoExperience.UpdateUIQuestTabs()
  else
    zo_callLater(EchoExperience.RefreshTabs, 12000)
  end  
end

------------------------------
-- UI
-- SELECT/TABS/WINDOWS/COLORS Functions here --
-----------------------------
function EchoExperience:UpdateUIExpTabs()
  --need to update dropdown I guess?
  local myFpsLabelControl = WINDOW_MANAGER:GetControlByName("EchoExpDDExpOutput", "")
  if(myFpsLabelControl~=nil) then
    local vals = EchoExperience:ListOfExpTabs()
    myFpsLabelControl:UpdateChoices( vals )
  else
    EchoExperience.debugMsg("WARN: Dropdown EchoExpDDExpOutput not found, changes will not be reflected until /reloadui")
  end
end

------------------------------
-- UI
function EchoExperience:UpdateUILootTabs()
  --need to update dropdown I guess?
  local myFpsLabelControl = WINDOW_MANAGER:GetControlByName("EchoExpDDLootOutput", "")
  if(myFpsLabelControl~=nil) then
    local vals = EchoExperience:ListOfLootTabs()
    myFpsLabelControl:UpdateChoices(vals )
  end
end

------------------------------
-- UI
function EchoExperience:UpdateUIGuildTabs()
  --need to update dropdown I guess?
  local myFpsLabelControl = WINDOW_MANAGER:GetControlByName("EchoExpDDGuildOutput", "")
  if(myFpsLabelControl~=nil) then
    local vals = EchoExperience:ListOfGuildTabs()
    myFpsLabelControl:UpdateChoices(vals )
  end
end

------------------------------
-- UI
function EchoExperience:UpdateUIQuestTabs()
  --need to update dropdown I guess?
  local myFpsLabelControl = WINDOW_MANAGER:GetControlByName("EchoExpDDQuestOutput", "")
  if(myFpsLabelControl~=nil) then
    local vals = EchoExperience:ListOfQuestTabs()
    myFpsLabelControl:UpdateChoices(vals )
  end
end

------------------------------
-- UI
function EchoExperience.InitializeGui()
  --
	EOL_GUI_ListHolder.rowHeight = 24
	EOL_GUI_ListHolder:SetDrawLayer(0)
  
  EOL_GUI_Litany_ListHolder.rowHeight = 24
  EOL_GUI_Litany_ListHolder:SetDrawLayer(0)
  --EchoExperience:SetupLitanyOfBlood()
  --
  EchoExperience.TrackingSessionClear()
  --EchoExperience.debugMsg("Initialized!!!!")
end

------------------------------
-- UTIL
function EchoExperience.SetupDefaultColors()
  EchoExperience.view.settingstemp = {}
  EchoExperience.view.settingstemp.colorExp = {}
  EchoExperience.view.settingstemp.colorExp.r = EchoExperience.rgbaBase.r
  EchoExperience.view.settingstemp.colorExp.g = EchoExperience.rgbaBase.g
  EchoExperience.view.settingstemp.colorExp.b = EchoExperience.rgbaBase.b
  EchoExperience.view.settingstemp.colorExp.a = EchoExperience.rgbaBase.a  
  EchoExperience.view.settingstemp.colorLoot = {}
  EchoExperience.view.settingstemp.colorLoot.r = EchoExperience.rgbaBase.r
  EchoExperience.view.settingstemp.colorLoot.g = EchoExperience.rgbaBase.g
  EchoExperience.view.settingstemp.colorLoot.b = EchoExperience.rgbaBase.b
  EchoExperience.view.settingstemp.colorLoot.a = EchoExperience.rgbaBase.a
  EchoExperience.view.settingstemp.colorGuild = {}
  EchoExperience.view.settingstemp.colorGuild.r = EchoExperience.rgbaBase.r
  EchoExperience.view.settingstemp.colorGuild.g = EchoExperience.rgbaBase.g
  EchoExperience.view.settingstemp.colorGuild.b = EchoExperience.rgbaBase.b
  EchoExperience.view.settingstemp.colorGuild.a = EchoExperience.rgbaBase.a
  EchoExperience.view.settingstemp.colorQuest = {}
  EchoExperience.view.settingstemp.colorQuest.r = EchoExperience.rgbaBase.r
  EchoExperience.view.settingstemp.colorQuest.g = EchoExperience.rgbaBase.g
  EchoExperience.view.settingstemp.colorQuest.b = EchoExperience.rgbaBase.b
  EchoExperience.view.settingstemp.colorQuest.a = EchoExperience.rgbaBase.a
end

------------------------------
-- LITANY
function EchoExperience.SetupLitanyOfBlood()
	--if( EchoExperience.savedVariables.LitanyOfBlood == nil) then
		--EchoExperience.savedVariables.LitanyOfBlood = EchoExperience:deepcopy(EchoExperience.LitanyOfBlood)
	--TESTINGend
  EchoExperience.savedVariables.LitanyOfBlood = nil
end

------------------------------
-- SETUP defaults/savedvars, called from DelayedStart
function EchoExperience.CheckVerifyDefaults()
  --Setup Basic Options
  local madeChange = false
  
   if( EchoExperience.savedVariables.expsettings == nil) then
    EchoExperience.savedVariables.expsettings = {}
    local elem = {}
    elem["window"]= 1
    elem["tab"]   = 1
    elem["color"] = EchoExperience.rgbaBase
    table.insert(EchoExperience.savedVariables.expsettings, elem)   
    madeChange = true
  end
  if( EchoExperience.savedVariables.lootsettings == nil) then
    EchoExperience.savedVariables.lootsettings = {}
    local elem = {}
    elem["window"]= 1
    elem["tab"]   = 1
    elem["color"] = EchoExperience.rgbaBase
    table.insert(EchoExperience.savedVariables.lootsettings, elem)    
    madeChange = true
  end
  if( EchoExperience.savedVariables.guildsettings == nil) then
    EchoExperience.savedVariables.guildsettings = {}
    local elem = {}
    elem["window"]= 1
    elem["tab"]   = 1
    elem["color"] = EchoExperience.rgbaBase
    table.insert(EchoExperience.savedVariables.guildsettings, elem)    
    madeChange = true
  end
  if( EchoExperience.savedVariables.questsettings == nil) then
    EchoExperience.savedVariables.questsettings = {}
    local elem = {}
    elem["window"]= 1
    elem["tab"]   = 1
    elem["color"] = EchoExperience.rgbaBase
    table.insert(EchoExperience.savedVariables.questsettings, elem)   
    madeChange = true
  end
  
  --
  if(EchoExperience.accountVariables.defaults==nil)then
    EchoExperience.accountVariables.defaults = {}
    madeChange = true
  end
  
  --Old settings
  EchoExperience.savedVariables.rgba = nil
  EchoExperience.savedVariables.rgba2 = nil
  
  if( EchoExperience.savedVariables.skilltracking == nil ) then
    EchoExperience.savedVariables.skilltracking = {}
    madeChange = true
  end
  
  --
  if(EchoExperience.accountVariables.defaults == nil) then 
    EchoExperience.accountVariables.defaults = {}
  end
  if(EchoExperience.savedVariables.defaults == nil) then 
    EchoExperience.savedVariables.defaults = {}
  end
  
  if(EchoExperience.savedVariables.defaults.showachievements == nil) then
    EchoExperience.savedVariables.defaults.showachievements = false
  end
  if( EchoExperience.accountVariables.defaults.showachievementdetails == nil) then
    EchoExperience.accountVariables.defaults.showachievementdetails = false
  end
  if( EchoExperience.savedVariables.defaults.lorebooktracking == nil) then
    EchoExperience.savedVariables.defaults.lorebooktracking = false
  end
  
  --
  if( EchoExperience.savedVariables.LitanyOfBloodDone == nil ) then
    EchoExperience.savedVariables.LitanyOfBloodDone = {}
    madeChange = true
  end

  -- Clean up tracking data
  EchoExperience.savedVariables.tracking = nil
  EchoExperience.savedVariables.lifetime = nil
  
  -- Tracking data init
  --EchoExperience.view.trackingsessions = {}
  --
  if(madeChange) then
    zo_callLater(EchoExperience.RefreshTabs, 12000)
  end
end

------------------------------
-- SETUP  setup event handling
function EchoExperience.SetupView()
  --
  EchoExperience.view = {}
  EchoExperience.view.GuildEventsReg = false
  EchoExperience.view.settingstemp = {}
  EchoExperience.view.settingstemp.windowGuild = nil
  EchoExperience.view.settingstemp.tabGuild = nil
  EchoExperience.view.settingstemp.colorGuild = rgbaBase  
  EchoExperience.view.settingstemp.windowLoot = nil
  EchoExperience.view.settingstemp.tabLoot = nil
  EchoExperience.view.settingstemp.colorLoot = rgbaBase
  EchoExperience.view.settingstemp.windowExp = nil
  EchoExperience.view.settingstemp.tabExp = nil
  EchoExperience.view.settingstemp.colorExp = rgbaBase
  
  EchoExperience.view.settingstemp.guild1 = true
  EchoExperience.view.settingstemp.guild2 = true
  EchoExperience.view.settingstemp.guild3 = true
  EchoExperience.view.settingstemp.guild4 = true
  EchoExperience.view.settingstemp.guild5 = true
  
  EchoExperience.view.selected = {}
  EchoExperience.view.selected.guildtab = nil
  EchoExperience.view.selected.loottab = nil
  EchoExperience.view.selected.exptab = nil
  
  --
  EchoExperience.view.iamDisplayName   = GetDisplayName() --GetUnitDisplayName("player")
  EchoExperience.view.iamCharacterName = GetUnitName("player")
  --
  EchoExperience.view.asyncName = EchoExperience.pre_view.asyncName
  EchoExperience.view.async     = EchoExperience.pre_view.async
  EchoExperience.view.task      = EchoExperience.pre_view.task
  --
end

------------------------------
-- SETUP  setup event handling
function EchoExperience.DelayedStart()
  --d("EchoExp DelayedStart Called")
  --
  EchoExperience.CheckVerifyDefaults()

  --
  if(EchoExperience.savedVariables.sessiontracking==nil)then
    EchoExperience.savedVariables.sessiontracking = false
  end
  if(EchoExperience.savedVariables.lifetimetracking==nil)then
    EchoExperience.savedVariables.lifetimetracking = false
  end
  if(EchoExperience.savedVariables.immersive==nil)then
    EchoExperience.savedVariables.immersive = false
  end
  --Tracking data init
  if(EchoExperience.view.trackingsessions==nil) then
    EchoExperience:TrackingSessionNew()
  end
  if(EchoExperience.view.trackingsessionid==nil) then
    EchoExperience.view.trackingsessionid = 1
  end

  EchoExperience:UpgradeSettings()
  
	--Setup Events Related
	EchoExperience.SetupExpGainsEvents()
	EchoExperience.SetupLootGainsEvents()
  EchoExperience.SetupGuildEvents()
  EchoExperience.SetupMiscEvents()  
  EchoExperience.SetupLoreBookEvents()
  EchoExperience.SetupEventsQuest()
  EchoExperience.SetupAchievmentEvents()
  EchoExperience.SetupDiscoveryEvents()
  EchoExperience.SetupAlphaEvents()
  EchoExperience.SetupLitanyOfBlood()
  --
end

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
    --d(EchoExperience.name .. GetString(SI_ECHOEXP_MESSAGE)) -- Prints to chat.
    --ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil,
    --    EchoExperience.name .. GetString(SI_NEW_ADDON_MESSAGE)) -- Top-right alert.
    --d("EchoExperience.view.iamDisplayName = " .. tostring(EchoExperience.view.iamDisplayName) )
    EchoExperience.SetupView()
    --
    EchoExperience.SetupDefaultColors()
    EchoExperience.InitializeGui()
    zo_callLater(EchoExperience.DelayedStart, 2000)
end

------------------------------
-- SETUP
function EchoExperience.OnAddOnLoaded(event, addonName)
  if addonName ~= EchoExperience.name then return end
  EVENT_MANAGER:UnregisterForEvent(EchoExperience.name, EVENT_ADD_ON_LOADED)

  EchoExperience.savedVariables   = ZO_SavedVars:New("EchoExperienceSavedVariables", 1, nil, defaultSettings)
  EchoExperience.accountVariables = ZO_SavedVars:NewAccountWide("EchoExperienceAccountSavedVariables", 1, nil, nil)

  --
  EchoExperience.pre_view = {}
  EchoExperience.pre_view.asyncName = "EchoExperienceAchieveAsync"
  EchoExperience.pre_view.async = LibAsync
  if(EchoExperience.pre_view.async ~= nil) then
    EchoExperience.pre_view.task = EchoExperience.pre_view.async:Create(EchoExperience.pre_view.asyncName)
    --d("EE Created ASYNC Task")
  else
    --d("EE Created NOT !!! ASYNC Task")
  end

  -- Settings menu in Settings.lua.
  --EchoExperience:RestoreSettings()
  EchoExperience.LoadSettings() --Setup Addon Settings MENU

  --[[
  if( EchoExperience.savedVariables.sversion == "0.0.6" ) then
    --EchoExperience:UpgradeSettings()
  end
  --sversion = EchoExperience.version
  ]]

  -- Slash commands must be lowercase. Set to nil to disable.
  SLASH_COMMANDS["/echoexp"] = EchoExperience.SlashCommandHandler
  -- Reset autocomplete cache to update it.
  --SLASH_COMMAND_AUTO_COMPLETE:InvalidateSlashCommandCache()
end

-- SETUP When player is ready, after everything has been loaded.
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_PLAYER_ACTIVATED, EchoExperience.Activated)
-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_ADD_ON_LOADED, EchoExperience.OnAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(EchoExperience.name, EVENT_PLAYER_DEACTIVATED, EchoExperience.OnAddOnUnloaded)
