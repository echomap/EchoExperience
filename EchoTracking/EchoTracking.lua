--[[ Echo Tracking ]]-- 

------------------------------
-- 
EchoTracking = {
    name            = "EchoTracking",           -- Matches folder and Manifest file names.
    version         = "1.0.1",                    -- A nuisance to match to the Manifest.
    author          = "Echomap",
    --menuName        = "EchoExperience_Options",   -- Unique identifier for menu object.
    --menuDisplayName = "EchoExperience",
    version = 1,
    SV_VERSION_NAME = 1,
    -- In Memory Settings
    view            = {
      fError    = false,
      fErrorMsg = nil,
    },
    --
    -- Saved settings.
    svAW      = {},
    svChar    = {},
    svAchieve = {},
    svLoot    = {},
    
    -- Default settings.    
    defaultSettingsLocal = {
    },
  --
    defaultSettingsGlobal = {
      debug      = false,
      beta       = false,
      --savePlayerData = true,
      --saveEquipData  = true,
    },
}

------------------------------
-- API
------------------------------
------------------------------

------------------------------
-- UTIL
function EchoTracking.debugMsg(text)
	if EchoTracking.savedVariables.debug then
    local val = zo_strformat( "(EchoExp) <<1>>",text)
    d(val)
	end
end

------------------------------
-- UTIL
function EchoTracking.outputMsg(text)
  if text ~= nil then
    local val = zo_strformat( "[EchoExp] <<1>>",text)
    d(val)
  end
end

------------------------------
-- UTIL
function EchoTracking.errorMsg(text)
  d("(" .. EchoTracking.name .. ") " .. text )
end

------------------------------
-- API
function EchoTracking.saveKills(targetName,targetType,targetUnitId, timeStamp)
  --
  if(EchoTracking.svKills[id]==nil) then
   EchoTracking.svKills[id] = {}
   EchoTracking.svKills[id].quantity = 0
  end
  local elemA    = EchoTracking.svKills[id]
  elemA.name     = targetName
  elemA.type     = targetType
  elemA.id       = targetUnitId
  elemA.quantity = elemA.quantity+1
  elemA.earned   = timeStamp -- id64
  --    
end

------------------------------
-- API
function EchoTracking.saveKills(targetName,targetType,targetUnitId,quantity, timeStamp)
  --
  if(EchoTracking.svKills[id]==nil) then
   EchoTracking.svKills[id] = {}
  end
  local elemA    = EchoTracking.svKills[id]
  elemA.name     = targetName
  elemA.type     = targetType
  elemA.id       = targetUnitId
  elemA.quantity = quantity
  elemA.earned   = timeStamp -- id64
  --   
end

------------------------------
-- API
function EchoTracking.saveAchievement(name, points, id, link, timeStamp)
  --
  if(EchoTracking.svAchieve[id]==nil) then
   EchoTracking.svAchieve[id] = {}
  end
  local elemA = EchoTracking.svAchieve[id]
  elemA.name   = name
  elemA.points = points
  elemA.id     = id
  elemA.link   = link
  elemA.earned = timeStamp -- id64
  --  
end

------------------------------
-- API
function EchoTracking.saveLoot(itemName,itemLink,stackCountChange, timeStamp)
  --EchoTracking.outputMsg("saveLoot: Called. itemName='"..itemName.."'")
  if(EchoTracking.svLoot.loot==nil) then
    EchoTracking.svLoot.loot = {}
  end
  local elemL = {}
  elemL.itemName  = itemName
  elemL.itemLink  = itemLink
  elemL.change    = stackCountChange
  elemL.timeStamp = timeStamp
  table.insert(EchoTracking.svLoot.loot, elemL)
  --TODO Sums only for the common/trash loots?
end

------------------------------
-- API
function EchoTracking.saveCurrency(currencyType, oldValue, newValue, timeStamp)
  --
  if(EchoTracking.svLoot.loot==nil) then
    EchoTracking.svLoot.loot = {}
  end  
 if(EchoTracking.svLoot.currency==nil) then
    EchoTracking.svLoot.currency = {}
  end
  local elemL = {}
  elemL.currency  = currencyType
  elemL.oldValue  = oldValue
  elemL.newValue  = newValue
  elemL.timeStamp = timeStamp
  table.insert(EchoTracking.svLoot, elemL)
  --
  --svChar, track counts
  if(EchoTracking.svChar.currency[currencyType]==nil) then
    EchoTracking.svChar.currency[currencyType] = {}
    EchoTracking.svChar.currency[currencyType].quantity=0
  end
  local cElem = EchoTracking.svChar.currency[currencyType]
  local diff = (oldValue - newValue)
  cElem.quantity=cElem.quantity + diff
  table.insert(EchoTracking.svLoot.currency, elemL)
  --
end

------------------------------
-- SETUP  setup event handling
function EchoTracking.DelayedStart()
  d(EchoTracking.name .." Loaded")    
end

------------------------------
-- EVENT
function EchoTracking.OnPlayerLoaded(e)
  EVENT_MANAGER:UnregisterForEvent(EchoTracking.name, EVENT_PLAYER_ACTIVATED)
end

------------------------------
-- EVENT
-- Player can be unloaded on zone change, reload, etc, but not called on QUIT/Crash
function EchoTracking.OnPlayerUnloaded(event)
  --ESOADatastoreLogic.saveCurrentPlayerData()
end

------------------------------
-- EVENT
function EchoTracking.OnAddOnLoaded(event, addonName)
  --d("addonName="..addonName)
  if addonName ~= EchoTracking.name then return end
  EVENT_MANAGER:UnregisterForEvent(EchoTracking.name, EVENT_ADD_ON_LOADED)
  
  --(savedVariableTable, version, namespace, defaults, profile, displayName, characterName)
  EchoTracking.svAW = ZO_SavedVars:NewAccountWide("EchoTrackingAV", EchoTracking.SV_VERSION_NAME, nil, EchoTracking.defaultSettingsGlobal )

  --(savedVariableTable, version, namespace, defaults, profile, displayName, characterName)
  EchoTracking.svChar = ZO_SavedVars:New("EchoTrackingSV", EchoTracking.SV_VERSION_NAME, nil, EchoTracking.defaultSettingsLocal )
  
    --(savedVariableTable, version, namespace, defaults, profile, displayName, characterName)
  EchoTracking.svAchieve = ZO_SavedVars:New("EchoTracking_Achieve", EchoTracking.SV_VERSION_NAME, nil, EchoTracking.defaultSettingsLocal )
    
  --(savedVariableTable, version, namespace, defaults, profile, displayName, characterName)
  EchoTracking.svLoot = ZO_SavedVars:New("EchoTracking_Loot", EchoTracking.SV_VERSION_NAME, nil, EchoTracking.defaultSettingsLocal )
  
  --(savedVariableTable, version, namespace, defaults, profile, displayName, characterName)
  EchoTracking.svKills = ZO_SavedVars:New("EchoTracking_Kills", EchoTracking.SV_VERSION_NAME, nil, EchoTracking.defaultSettingsLocal )

  --check/setup a bit earlier
  --EchoTracking.CheckData()
  --EchoTracking.SetupDefaultColors()
  zo_callLater(EchoTracking.DelayedStart, 3000)

  -- Slash commands must be lowercase. Set to nil to disable.
  SLASH_COMMANDS["/echotrack"]      = EchoTracking.SlashCommandHandler
  SLASH_COMMANDS["/echotracking"] = EchoTracking.SlashCommandHandler
  --d("ESOA Datastore loaded")
end

------------------------------
-- Commands, help/debug/beta/testdata/deltestdata
function EchoTracking.SlashCommandHandler(text)
	EchoTracking.debugMsg("SlashCommandHandler: " , text)
	local options = {}
	local searchResult = { string.match(text,"^(%S*)%s*(.-)$") }
	for i,v in pairs(searchResult) do
		if (v ~= nil and v ~= "") then
		    options[i] = string.lower(v)
		end
	end

	if #options == 0 then
    EchoTracking.ShowHelp()
  --elseif (options[1] == "note" and #options == 2) then
  --  local playerName = options[2]
  --  EchoTracking.GetPlayerNote(playerName)
  elseif options[1] == "help" then
    EchoTracking.ShowHelp()
  else
      EchoTracking.ShowHelp()
	end
end

------------------------------
-- User command
function EchoTracking.ShowHelp()
    EchoTracking.outputMsg("/echotrack <commands> where command can be, note")
    EchoTracking.outputMsg("/echotracking <commands> where command can be, note")
end

------------------------------
-- Register for starting/startup events

-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(EchoTracking.name, EVENT_ADD_ON_LOADED, EchoTracking.OnAddOnLoaded)
-- Add on player loaded
EVENT_MANAGER:RegisterForEvent(EchoTracking.name, EVENT_PLAYER_DEACTIVATED, EchoTracking.OnPlayerUnloaded)
-- When player is ready, after everything has been loaded. (after addon loaded)
EVENT_MANAGER:RegisterForEvent(EchoTracking.name, EVENT_PLAYER_ACTIVATED, EchoTracking.OnPlayerLoaded)
--EOF