---------------------------------
--[[ EchoExp : GUI          ]]-- 
---------------------------------

------------------------------
-- UI
function EchoExperience:ToggleExpHistoryFrame()
  --EchoExperience.outputMsg2("Show Loot history")
	EOL_EXPHISTORY_Frame:SetHidden(not EOL_EXPHISTORY_Frame:IsControlHidden())
  if( EOL_EXPHISTORY_Frame.setup == nil) then
    EchoExperience:EH_Setup()
  end
  EchoExperience:EH_Show()
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
    EchoExperience.view.tracking.currentsessionid = choiceText
    --EchoExperience:UpdateScrollDataLinesData()
		--EchoExperience:GuiResizeScroll()
		--EchoExperience:RefreshInventoryScroll()
    PlaySound(SOUNDS.POSITIVE_CLICK)    
    EOL_GUI_Header_LabelStatus1:SetText("Session: ".. choiceText)
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
    EchoExperience.view.tracking.viewsessionid = choiceText
    --EchoesOfLore:showViewTips2(choiceText)
    EchoExperience:TrackUpdateScrollDataLinesData()
		EchoExperience:TrackGuiResizeScroll()
		EchoExperience:TrackRefreshInventoryScroll()
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
		EchoExperience:TrackGuiResizeScroll()
		EchoExperience:TrackRefreshInventoryScroll()
	end
	--if not EchoExperience.data.dontFocusSearch then
		--EOL_GUI_SearchBox:TakeFocus()
	--end
  --EOL_GUI_Header_Dropdown_Main:TakeFocus()
  comboBox:SelectFirstItem()
	EchoExperience:TrackSaveFrameInfo("ToggleInventoryFrame")
end

------------------------------
-- UI
function EchoExperience:ToggleLootHistoryFrame()
  --EchoExperience.outputMsg2("Show Loot history")
	EOL_LOOTHISTORY_Frame:SetHidden(not EOL_LOOTHISTORY_Frame:IsControlHidden())
  if( EOL_LOOTHISTORY_Frame.setup == nil) then
    EchoExperience:LH_Setup()
  end
  EchoExperience:LH_Show()
end

------------------------------
-- UI
function EchoExperience:ToggleLitanyFrame()
  EOL_GUI_Litany:SetHidden(not EOL_GUI_Litany:IsControlHidden())
  EEXPLitanyTooltip:SetParent(PopupTooltipTopLevel)
  --
  if(LibShifterBox==nil) then
    EchoExperience.outputMsg("LItany Gui needs the lib LibShifterBox to function.")
    return
  end
  
  --
 	if not EOL_GUI_Litany:IsControlHidden() then
		--SetGameCameraUIMode(true)
    EchoExperience:Litany_SetupUI()
		--EchoExperience:Litany_GuiResizeScroll()
		--EchoExperience:Litany_RefreshInventoryScroll()
	end
	EchoExperience:Litany_SaveFrameInfo("ToggleLitanyFrame")
end

------------
--- GUI
function EchoExperience:LibMsgWin_onResizeStart()
--[[
EVENT_MANAGER:RegisterForUpdate(EchoExperience.name.."LibMsgWin_OnWindowResize", 50, 
    function()
      EchoExperience.debugMsg2( "LibMsgWin_onResizeStart: called" )
    end)
--]]
  EchoExperience.debugMsg2("LibMsgWin_onResizeStart") 
end

------------
--- GUI
function EchoExperience:LibMsgWin_onResizeStop()
  EchoExperience.debugMsg2("LibMsgWin_onResizeStop") 
	--EVENT_MANAGER:UnregisterForUpdate(EchoExperience.name.."LibMsgWin_OnWindowResize")
	EchoExperience:LibMsgWin_SaveFrameInfo("onResizeStop")
end


------------
--- GUI
function EchoExperience:LibMsgWin_SaveFrameInfo(calledFrom)
	if (calledFrom == "onHide") then return end
  if(EchoExperience.savedVariables.frame_LMW==null)then
    EchoExperience.savedVariables.frame_LMW = {}
  end
  --
  EchoExperience.savedVariables.frame_LMW.lastX	= EchoExperience.view.libmsgwindow:GetLeft()
  EchoExperience.savedVariables.frame_LMW.lastY	= EchoExperience.view.libmsgwindow:GetTop()
  EchoExperience.savedVariables.frame_LMW.width	= EchoExperience.view.libmsgwindow:GetWidth()
  EchoExperience.savedVariables.frame_LMW.height= EchoExperience.view.libmsgwindow:GetHeight()
end

------------
--- GUI
function EchoExperience:LibMsgWin_RestoreFrameInfo(calledFrom)
	EchoExperience.debugMsg2("LibMsgWin_RestoreFrameInfo: Called")
  if (calledFrom == "onHide") then return end
  if( EchoExperience.savedVariables.frame_LMW==nil )then
    return
  end
  EchoExperience.debugMsg2("LibMsgWin_RestoreFrameInfo: Working")
  
  EchoExperience.view.libmsgwindow:ClearAnchors()
  EchoExperience.view.libmsgwindow:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, EchoExperience.savedVariables.frame_LMW.lastX, EchoExperience.savedVariables.frame_LMW.lastY)
  EchoExperience.view.libmsgwindow:SetWidth( EchoExperience.savedVariables.frame_LMW.width )
  EchoExperience.view.libmsgwindow:SetHeight(EchoExperience.savedVariables.frame_LMW.height)
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
-- Tracking
function EchoExperience:LootHistory(itemLink,quantity,receivedBy)
  if(EchoExperience.savedVariables.sessiontracking) then
    if(EchoExperience.view.loothistory == nil) then
      EchoExperience.view.loothistory = {}
    end
    if(receivedBy==nil) then
      receivedBy = "Me"
    end
    --
    local elem = {}
    -- seconds in UTC based on the player's OS time.
    elem.timestr    = GetTimeString()
    elem.time       = GetTimeStamp()
    elem.frame      = GetFrameTimeSeconds()
    elem.itemLink   = itemLink
    elem.link       = itemLink
    elem.quantity   = quantity
    elem.user       = receivedBy
    --
    table.insert(EchoExperience.view.loothistory, elem)  
    EchoExperience.debugMsg2("LootHistory", tostring(itemLink) )    
    --
    --check max length and purge/remove old? TODO
    local cnt = #EchoExperience.view.loothistory
    if(cnt>EchoExperience.savedVariables.lootHistoryMax) then
      local numtoremove = EchoExperience.savedVariables.lootHistoryCull
      for ii = 1, numtoremove do
        table.remove(EchoExperience.view.loothistory,1)
      end
    end
    --Update gui?
    if( not EOL_LOOTHISTORY_Frame:IsControlHidden() ) then
      EchoExperience:LH_UpdateViewData()
    end
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
-- SETUP INITIAL : 
function EchoExperience.InitializeGui()
  --
	EOL_GUI_ListHolder.rowHeight = 24
	EOL_GUI_ListHolder:SetDrawLayer(0)
  
  --EOL_GUI_Litany_ListHolder.rowHeight = 24
  EOL_GUI_Litany_ListHolder:SetDrawLayer(0)
  --EchoExperience:SetupLitanyOfBlood()
  --
  EchoExperience:TrackingSessionNew()
  --EchoExperience.debugMsg("Initialized!!!!")
end

---------------------------------
---------------------------------