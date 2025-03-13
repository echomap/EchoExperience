---------------------------------
--[[ EchoExp : INIT          ]]-- 
---------------------------------

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
-- LITANY
function EchoExperience.SetupLitanyOfBlood()
	--if( EchoExperience.savedVariables.LitanyOfBlood == nil) then
		--EchoExperience.savedVariables.LitanyOfBlood = EchoExperience:deepcopy(EchoExperience.LitanyOfBlood)
	--TESTINGend
  EchoExperience.savedVariables.LitanyOfBlood = nil
end

------------------------------
-- LIBMSGWIN
function EchoExperience.SetupLibMsgWin()
  --EchoExperience.debugMsg2("SetupLibMsgWin: LibMsgWin=", LibMsgWin, " sv='", EchoExperience.savedVariables.showlibmsgwin, "'")
  --
  EchoExperience.savedVariables.showlibmsgwin = false
  if( EchoExperience.savedVariables.uselibmsgwinLoot or EchoExperience.savedVariables.uselibmsgwinGuild or EchoExperience.savedVariables.uselibmsgwinExp or EchoExperience.savedVariables.uselibmsgwinQuest) then
    EchoExperience.savedVariables.showlibmsgwin = true
  end
  
  if( LibMsgWin ~= nil and EchoExperience.view.libmsgwindow == nil ) then
    EchoExperience.view.libmsgwindow = LibMsgWin:CreateMsgWindow("EchoExperienceLibMsgWin","EchoExperienceOutput", 0, 0 )
    --add close window
    local pClose = WINDOW_MANAGER:CreateControl("Echoexp_CloseBtn", EchoExperience.view.libmsgwindow, CT_BUTTON) 
    if(pClose==nil)then
      d("EchoesOfLore: Failed to create LibMsgWin!")
      return
    end
    pClose:ClearAnchors()
    pClose:SetAnchor(TOPRIGHT, EchoExperience.view.libmsgwindow, TOPRIGHT, -10, 10 )
    pClose:SetDimensions(100,25)
    pClose:SetFont("ZoFontGame")
    pClose:SetText("Close")
    pClose:SetDrawLayer(1)
    --
    pClose:SetClickSound('Click')
    pClose:SetMouseOverTexture('EsoUI/Art/ActionBar/actionBar_mouseOver.dds')
    pClose:SetNormalTexture('EsoUI/Art/ActionBar/abilityFrame64_up.dds')
    pClose:SetPressedMouseOverTexture('EsoUI/Art/ActionBar/abilityFrame64_down.dds')
    pClose:SetHandler('OnClicked',function(self)
      EchoExperience.view.libmsgwindow:SetHidden(true)  
      EchoExperience.savedVariables.showlibmsgwin = false
    end)
    EchoExperience.view.libmsgwindow:SetHandler('OnResizeStart',function(self)
        EchoExperience:LibMsgWin_onResizeStart()
    end)
    EchoExperience.view.libmsgwindow:SetHandler('OnResizeStop',function(self)
        EchoExperience:LibMsgWin_onResizeStop("onResizeStop")
    end)
  end
  if(EchoExperience.view.libmsgwindow~=nil) then
    if(EchoExperience.savedVariables.showlibmsgwin) then
      EchoExperience.view.libmsgwindow:SetHidden(false)
      EchoExperience:LibMsgWin_RestoreFrameInfo("onShow")
    else
      EchoExperience.view.libmsgwindow:SetHidden(true)
    end
  end
  EchoExperience.debugMsg2("SetupLibMsgWin: LibMsgWin=", LibMsgWin, " frame='", EchoExperience.view.libmsgwindow, "' show?='",EchoExperience.savedVariables.showlibmsgwin, "'")
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
    elem["color"] = EchoExperience.staticdata.rgbaBase
    table.insert(EchoExperience.savedVariables.expsettings, elem)   
    madeChange = true
  end
  if( EchoExperience.savedVariables.lootsettings == nil) then
    EchoExperience.savedVariables.lootsettings = {}
    local elem = {}
    elem["window"]= 1
    elem["tab"]   = 1
    elem["color"] = EchoExperience.staticdata.rgbaBase
    table.insert(EchoExperience.savedVariables.lootsettings, elem)    
    madeChange = true
  end
  if( EchoExperience.savedVariables.guildsettings == nil) then
    EchoExperience.savedVariables.guildsettings = {}
    local elem = {}
    elem["window"]= 1
    elem["tab"]   = 1
    elem["color"] = EchoExperience.staticdata.rgbaBase
    table.insert(EchoExperience.savedVariables.guildsettings, elem)    
    madeChange = true
  end
  if( EchoExperience.savedVariables.questsettings == nil) then
    EchoExperience.savedVariables.questsettings = {}
    local elem = {}
    elem["window"]= 1
    elem["tab"]   = 1
    elem["color"] = EchoExperience.staticdata.rgbaBase
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
  
  --Set collections 100033
  if( EchoExperience.savedVariables.lootshowsetcollection==nil ) then
    EchoExperience.savedVariables.lootshowsetcollection = true
  end
  if( EchoExperience.savedVariables.lootshowtrait==nil ) then
    EchoExperience.savedVariables.lootshowtrait = true
  end
  
  if(EchoExperience.savedVariables.lootgroupqualityname==nil) then
    EchoExperience.savedVariables.lootgroupqualityname = "Trash"
    EchoExperience.savedVariables.lootgroupqualityid   = ITEM_QUALITY_TRASH
  end
  if(EchoExperience.savedVariables.lootselfqualityname==nil) then
    EchoExperience.savedVariables.lootselfqualityname = "Trash"
    EchoExperience.savedVariables.lootselfqualityid   = ITEM_QUALITY_TRASH
  end
  
  if(EchoExperience.savedVariables.banditsidepanel==nil) then
    EchoExperience.savedVariables.banditsidepanel = true
  end
  --[[	Bandits User Interface Side Panel ]]--
  if(BUI~=nil and BUI.Vars~=nil and not EchoExperience.view.buisetup and EchoExperience.savedVariables.banditsidepanel) then
    EchoExperience.view.buisetup = true
    local content = {
        {--TrackingGui
          icon		= "/esoui/art/tutorial/pc_costumedye.dds",
          tooltip	=  GetString(SI_BINDING_NAME_EE_DISPLAY1),
          --context	= Context menu function (optional),
          func		= function() EchoExperience:ToggleTrackingFrame() end,
          enabled	= function() return not EchoExperience end,
        },
        {--LitanyGui
          icon		= "/esoui/art/tutorial/poi_cave_complete.dds",
          tooltip	=  GetString(SI_BINDING_NAME_EE_DISPLAY2),
          --context	= Context menu function (optional),
          func		= function() EchoExperience:ToggleLitanyFrame() end,
          enabled	= function() return not EchoExperience end,
        },
        {--Loot History
          icon		= "/esoui/art/tutorial/poi_areaofinterest_complete.dds",
          tooltip	=  GetString(SI_BINDING_NAME_EE_DISPLAY3),
          --context	= Context menu function (optional),
          func		= function() EchoExperience:ToggleLootHistoryFrame() end,
          enabled	= function() return not EchoExperience end,
        },
    }
    BUI.PanelAdd(content)
  end
  
  --
  --
  if(madeChange) then
    zo_callLater(EchoExperience.RefreshTabs, 12000)
  end
end

------------------------------
-- SETUP INITIAL : 
function EchoExperience.SetupDefaultColors()
  EchoExperience.view.settingstemp = {}
  EchoExperience.view.settingstemp.colorExp = {}
  EchoExperience.view.settingstemp.colorExp.r = EchoExperience.staticdata.rgbaBase.r
  EchoExperience.view.settingstemp.colorExp.g = EchoExperience.staticdata.rgbaBase.g
  EchoExperience.view.settingstemp.colorExp.b = EchoExperience.staticdata.rgbaBase.b
  EchoExperience.view.settingstemp.colorExp.a = EchoExperience.staticdata.rgbaBase.a  
  EchoExperience.view.settingstemp.colorLoot = {}
  EchoExperience.view.settingstemp.colorLoot.r = EchoExperience.staticdata.rgbaBase.r
  EchoExperience.view.settingstemp.colorLoot.g = EchoExperience.staticdata.rgbaBase.g
  EchoExperience.view.settingstemp.colorLoot.b = EchoExperience.staticdata.rgbaBase.b
  EchoExperience.view.settingstemp.colorLoot.a = EchoExperience.staticdata.rgbaBase.a
  EchoExperience.view.settingstemp.colorGuild = {}
  EchoExperience.view.settingstemp.colorGuild.r = EchoExperience.staticdata.rgbaBase.r
  EchoExperience.view.settingstemp.colorGuild.g = EchoExperience.staticdata.rgbaBase.g
  EchoExperience.view.settingstemp.colorGuild.b = EchoExperience.staticdata.rgbaBase.b
  EchoExperience.view.settingstemp.colorGuild.a = EchoExperience.staticdata.rgbaBase.a
  EchoExperience.view.settingstemp.colorQuest = {}
  EchoExperience.view.settingstemp.colorQuest.r = EchoExperience.staticdata.rgbaBase.r
  EchoExperience.view.settingstemp.colorQuest.g = EchoExperience.staticdata.rgbaBase.g
  EchoExperience.view.settingstemp.colorQuest.b = EchoExperience.staticdata.rgbaBase.b
  EchoExperience.view.settingstemp.colorQuest.a = EchoExperience.staticdata.rgbaBase.a
end

------------------------------
-- SETUP INITIAL : setup event handling
function EchoExperience.SetupView()
  -- d("EchoExp SetupView Called")
  EchoExperience.view = {}
  EchoExperience.view.GuildEventsReg = false
  EchoExperience.view.settingstemp = {}
  EchoExperience.view.settingstemp.windowGuild = nil
  EchoExperience.view.settingstemp.tabGuild = nil
  EchoExperience.view.settingstemp.colorGuild = EchoExperience.staticdata.rgbaBase  
  EchoExperience.view.settingstemp.windowLoot = nil
  EchoExperience.view.settingstemp.tabLoot = nil
  EchoExperience.view.settingstemp.colorLoot = EchoExperience.staticdata.rgbaBase
  EchoExperience.view.settingstemp.windowExp = nil
  EchoExperience.view.settingstemp.tabExp = nil
  EchoExperience.view.settingstemp.colorExp = EchoExperience.staticdata.rgbaBase
  
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
  
  -- EchoExperience.currentPartyMembers[CharacterName] = AccountName
  EchoExperience.currentPartyMembers[EchoExperience.view.iamCharacterName] = EchoExperience.view.iamDisplayName
  EchoExperience.debugMsg("SetupView: "
    .." iamCharacterName='"    .. tostring(EchoExperience.view.iamCharacterName) .."'"
    .." iamDisplayName='"    .. tostring(EchoExperience.view.iamDisplayName) .."'"
    .." accountName='"    .. tostring(accountName) .."'"
	.." receivedBy='"     .. tostring(receivedBy)  .."'"
  ) 
  local printEntries = ""
  for kName, kVal in pairs(EchoExperience.currentPartyMembers) do
    printEntries = zo_strformat("<<1>> {<<2>>=<<3>>},", printEntries, kName, kVal )
  end
  printEntries = "List of chars stored: " .. printEntries
  EchoExperience.debugMsg(printEntries)
  --
  EchoExperience.view.asyncName = EchoExperience.pre_view.asyncName
  EchoExperience.view.async     = EchoExperience.pre_view.async
  EchoExperience.view.task      = EchoExperience.pre_view.task
  --
end

------------------------------
-- SETUP INITIAL : 
-- SETUP  setup event handling
-- Called from method "Activated"
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
  EchoExperience:TrackingSessionNew()
  --
  EchoExperience:UpgradeSettings()
  
	--Setup Events Related
  EchoExperience.SetupGroupEvents()
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
  EchoExperience.SetupCompanionEvents()
  EchoExperience.SetupEndeavors()
  --
  EchoExperience.SetupMailEvents()
  --
end

---------------------------------
--[[ EchoExp : INIT          ]]-- 
---------------------------------