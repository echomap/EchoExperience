--[[ ------------ ]]--
--[[ EXP History GUI ]]-- 
--[[ ------------ ]]--

------------
---GUI
function EchoExperience:EH_Setup()  
  EchoExperience.debugMsg2( "EH_Setup: called" )
  EchoExperience.view.eh = {}
  EchoExperience.view.eh.frame      = EOL_EXPHISTORY_Frame
  EchoExperience.view.eh.list       = EOL_EXPHISTORY_Frame_List
  EchoExperience.view.eh.TopBar     = EOL_EXPHISTORY_Frame_List_TopBar
  --EchoExperience.view.eh.searchlbl  = EOL_EXPHISTORY_Frame_List_TopBar_SearchLabel
  EchoExperience.view.eh.filter     = EOL_EXPHISTORY_Frame_List_TopBar_FilterDrop
  EchoExperience.view.eh.searchmain = EOL_EXPHISTORY_Frame_List_TopBar_Search
  EchoExperience.view.eh.search     = EOL_EXPHISTORY_Frame_List_TopBar_Search_Box
  EchoExperience.view.eh.searchbtn  = EOL_EXPHISTORY_Frame_List_TopBar_Search_Btn
  EchoExperience.view.eh.listholder = EOL_EXPHISTORY_Frame_List_ListHolder
  EchoExperience.view.eh.sortbar    = EOL_EXPHISTORY_Frame_List_Headers
  EchoExperience.view.eh.slider     = EOL_EXPHISTORY_Frame_List_ListHolder_Slider
  
	EchoExperience.view.eh.listholder.rowHeight = 24
	EchoExperience.view.eh.listholder:SetDrawLayer(0)
  EchoExperience.view.eh.listholder.dataOffset = 0
  EchoExperience.view.eh.frame.updating = false
  EchoExperience.view.eh.viewnamelength = 250
  if(EchoExperience.savedVariables.ehviewnamelength~=nil) then
    EchoExperience.view.eh.viewnamelength = EchoExperience.savedVariables.ehviewnamelength  
  end
  
  --
  EchoExperience.view.eh.sort = {}
  EchoExperience.view.eh.sort.key = "time"
  EchoExperience.view.eh.sort.dir = true
  
  --EOL_EXPHISTORY_Frame.setup
  EchoExperience.view.eh.frame.setup = true  
  -- Tooltip
  --EELHTooltip:SetParent(PopupTooltipTopLevel)
  EchoExperience.view.eh.tooltip = ItemTooltip
  
  
  --EchoExperience.view.eh.filter   
  EchoExperience.view.eh.filter.comboBox = EchoExperience.view.eh.filter.comboBox or ZO_ComboBox_ObjectFromContainer(EchoExperience.view.eh.filter)
  local comboBox = EchoExperience.view.eh.filter.comboBox
  comboBox:ClearItems()  
  comboBox:SetSortsItems(false)
  local function OnItemSelect1(_, choiceText, choice)
    EchoExperience:debugMsg("choiceText=" .. choiceText .. " choice=" .. tostring(choice) )    
    --local viewIdx = EchoExperience.view.viewLookupIdxFromName[choiceText]
    --EchoExperience:ShowAndSetView(choiceText,viewIdx,nil)
    EchoExperience.view.eh.listholder.filtered = true
    EchoExperience.view.eh.listholder.filter   = choiceText
    EchoExperience.view.eh.listholder.filterN  = EchoExperience:ListOfItemQualitySettingsXalte(choiceText)
    EchoExperience:EH_ClearDataLinesData()
    EchoExperience:EH_onResizeStop()
    PlaySound(SOUNDS.POSITIVE_CLICK)
  end
  local validChoices = EchoExperience:ListOfItemQualitySettings()
  for i = 1, #validChoices do
    local entry = comboBox:CreateItemEntry(validChoices[i], OnItemSelect1)
    comboBox:AddItem(entry)
  end
  
  --EchoExperience.view.eh.search
  --TODO Causing issues with too many updates!
  --OnTextChanged
  --[[
  EchoExperience.view.eh.search:SetHandler("OnTextChanged", function(self)
      EVENT_MANAGER:RegisterForUpdate(EchoExperience.name.."OTTOnTextChanged", 50,
        function() 
          EchoExperience.debugMsg2( "OnTextChanged: called" )
          --Setup max lines, and slider (calls RefreshViewableTable)
          EchoExperience.view.eh.listholder.filtered = true
          EchoExperience:EH_UpdateDataScroll()
          --Set max, and Hide lines out of the max display
          --EchoExperience:GuiResizeScroll() 
        end
      )
    end )
 --]]

  EchoExperience.debugMsg2( "EH_Setup: done" )
end

------------
---GUI
function EchoExperience:EH_Show()
  if(EchoExperience.view.eh.listholder ~=nil and EchoExperience.view.eh.listholder.dataLines ~=nil ) then
    EchoExperience:EH_UpdateDataScroll()
  end
  EchoExperience:EH_RestoreFrameInfo("onShow")
  --
  EchoExperience.view.eh.search:SetText("")
  EchoExperience.view.eh.listholder.filtered = false
  EchoExperience.view.eh.listholder.filter   = nil
  EchoExperience.view.eh.listholder.filterN  = nil
  
  --name bar size?
  local sortName = EchoExperience.view.eh.sortbar:GetNamedChild("_Sort_Name")
  sortName:SetWidth(EchoExperience.view.eh.viewnamelength)
  
  --
  EchoExperience:EH_UpdateScrollDataLinesData()
	EchoExperience:EH_GuiResizeScroll()	
  EchoExperience:EH_UpdateDataScroll()
  --
end

------------
---GUI
function EchoExperience:EH_UpdateViewData()
  if( not EchoExperience.view.eh.frame.updating ) then
    if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
      EchoExperience.view.task:Call(
        function()
          EchoExperience:EH_UpdateScrollDataLinesData()
        end
      )
    else
      EchoExperience:EH_UpdateScrollDataLinesData()
    end  
  end
end
------------
--- GUI
function EchoExperience:EH_CloseUI()
  EchoExperience.view.eh.frame:SetHidden( not EchoExperience.view.eh.frame:IsHidden() )
end

------------
--- GUI
function EchoExperience:EH_onResizeStop()
	EVENT_MANAGER:UnregisterForUpdate(EchoExperience.name.."EH_OnWindowResize")
	EchoExperience:EH_SaveFrameInfo("onResizeStop")
  --<Anchor point="BOTTOMRIGHT" relativeTo="$(parent)"    relativePoint="BOTTOMRIGHT" offsetX="-35" offsetY="-10"/>
  --EchoExperience.view.eh.listholder:SetAnchor(BOTTOMRIGHT, EchoExperience.view.eh.list, BOTTOMRIGHT, 0, EchoExperience.altData.fieldYOffset )
  
  EchoExperience.outputMsg2( "EH_onResizeStop: framewidth: ", EchoExperience.view.eh.frame:GetWidth() )
  if( EchoExperience.view.eh.frame:GetWidth() < 350 ) then
    EchoExperience.outputMsg( "EH_onResizeStop: resizing internal thingies" )
    --<Anchor point="TOP"     relativeTo="$(parent)" relativePoint="TOP"  offsetY="30" />
    --<Anchor point="BOTTOM"  relativeTo="$(parent)" relativePoint="TOP"  offsetY="60" />
    EchoExperience.view.eh.TopBar:SetAnchor( TOP, EchoExperience.view.eh.frame, TOP, 0, 30 )
    EchoExperience.view.eh.TopBar:SetAnchor( BOTTOM, EchoExperience.view.eh.frame, TOP, 0, 60 )

    --<Anchor point="TOPLEFT" relativePoint="TOPLEFT" relativeTo="$(parent)" offsetX="10" offsetY="0" /> TOPBAR
    --EchoExperience.view.eh.searchlbl:SetAnchor( TOPLEFT, EchoExperience.view.eh.TopBar, TOPLEFT, 10, 0 )   
    
    --<Anchor point="TOPLEFT" relativePoint="TOPLEFT" relativeTo="$(parent)" offsetX="10" offsetY="0" />
    EchoExperience.view.eh.searchmain:SetAnchor( TOPLEFT, EchoExperience.view.eh.TopBar, TOPLEFT, 10, 0 )
    EchoExperience.view.eh.filter:SetAnchor( TOPLEFT, EchoExperience.view.eh.searchmain, BOTTOMLEFT, 10, 0 )
    
    --<Anchor point="LEFT" relativeTo="$(parent)" relativePoint="LEFT"  offsetX="0" offsetY="0" />
    --<Anchor point="TOP"  relativeTo="$(parent)_TopBar" relativePoint="BOTTOM" offsetX="0" offsetY="5" />
    EchoExperience.view.eh.sortbar:SetAnchor( LEFT, EchoExperience.view.eh.list, LEFT, 0, 0 )
    EchoExperience.view.eh.sortbar:SetAnchor( TOP, EchoExperience.view.eh.TopBar, BOTTOM, 0, 20 )
  else
    --<Anchor point="TOP"     relativeTo="$(parent)" relativePoint="TOP"  offsetY="30" />
    --<Anchor point="BOTTOM"  relativeTo="$(parent)" relativePoint="TOP"  offsetY="60" />
    EchoExperience.view.eh.TopBar:SetAnchor( TOP, EchoExperience.view.eh.frame, TOP, 0, 30 )
    EchoExperience.view.eh.TopBar:SetAnchor( BOTTOM, EchoExperience.view.eh.frame, TOP, 0, 60 )

    --<Anchor point="TOPLEFT" relativePoint="TOPLEFT" relativeTo="$(parent)" offsetX="10" offsetY="0" /> TOPBAR
    --EchoExperience.view.eh.searchlbl:SetAnchor( TOPLEFT, EchoExperience.view.eh.TopBar, TOPLEFT, 10, 0 )   

    --<Anchor point="TOPLEFT" relativePoint="TOPLEFT" relativeTo="$(parent)" offsetX="10" offsetY="0" />
    EchoExperience.view.eh.searchmain:SetAnchor( TOPLEFT, EchoExperience.view.eh.TopBar, TOPLEFT, 10, 0 )       
    EchoExperience.view.eh.filter:SetAnchor( TOPLEFT, EchoExperience.view.eh.searchbtn, TOPRIGHT, 10, 0 )       
    
    --<Anchor point="LEFT" relativeTo="$(parent)" relativePoint="LEFT"  offsetX="0" offsetY="0" />
    --<Anchor point="TOP"  relativeTo="$(parent)_TopBar" relativePoint="BOTTOM" offsetX="0" offsetY="5" />
    EchoExperience.view.eh.sortbar:SetAnchor( LEFT, EchoExperience.view.eh.list, LEFT, 0, 0 )       
    EchoExperience.view.eh.sortbar:SetAnchor( TOP, EchoExperience.view.eh.TopBar, BOTTOM, 0, 0 )       
    
    --<Anchor point="TOPLEFT" relativeTo="$(parent)_Headers" relativePoint="BOTTOMLEFT"  offsetX="0"   offsetY="10"/>
    --<Anchor point="BOTTOMRIGHT" relativeTo="$(parent)"    relativePoint="BOTTOMRIGHT" offsetX="-35" offsetY="-10"/>
    EchoExperience.view.eh.listholder:SetAnchor( TOPLEFT, EchoExperience.view.eh.sortbar, BOTTOMLEFT, 0, 10 )       
    EchoExperience.view.eh.listholder:SetAnchor( BOTTOMRIGHT, EchoExperience.view.eh.frame, BOTTOMRIGHT, -35, -10 )       
    
  end
  
  --
  EchoExperience:EH_UpdateScrollDataLinesData()
	EchoExperience:EH_GuiResizeScroll()	
  EchoExperience:EH_UpdateDataScroll()
end

------------
--- GUI
function EchoExperience:EH_onResizeStart()
	EVENT_MANAGER:RegisterForUpdate(EchoExperience.name.."EH_OnWindowResize", 50, 
    function()
      EchoExperience.debugMsg2( "EH_onResizeStart: called" )
      --EchoExperience:EH_UpdateScrollDataLinesData()
      EchoExperience:EH_GuiResizeScroll()
      EchoExperience:EH_UpdateDataScroll()
    end)
end

------------
--- GUI
function EchoExperience:EH_SaveFrameInfo(calledFrom)
	if (calledFrom == "onHide") then return end
  if(EchoExperience.savedVariables.frame_LH==null)then
    EchoExperience.savedVariables.frame_LH = {}
  end
  --
  EchoExperience.savedVariables.frame_LH.lastX	= EchoExperience.view.eh.frame:GetLeft()
  EchoExperience.savedVariables.frame_LH.lastY	= EchoExperience.view.eh.frame:GetTop()
  EchoExperience.savedVariables.frame_LH.width	= EchoExperience.view.eh.frame:GetWidth()
  EchoExperience.savedVariables.frame_LH.height	= EchoExperience.view.eh.frame:GetHeight()
end

------------
--- GUI
function EchoExperience:EH_RestoreFrameInfo(calledFrom)
	if (calledFrom == "onHide") then return end
  if( EchoExperience.savedVariables.frame_LH==nil )then
    return
  end
  
  EchoExperience.view.eh.frame:ClearAnchors()
  EchoExperience.view.eh.frame:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, EchoExperience.savedVariables.frame_LH.lastX, EchoExperience.savedVariables.frame_LH.lastY)
  EchoExperience.view.eh.frame:SetWidth( EchoExperience.savedVariables.frame_LH.width )
  EchoExperience.view.eh.frame:SetHeight(EchoExperience.savedVariables.frame_LH.height)
end

------------
--- GUI
--- Update number of lines in the listholder area
function EchoExperience:EH_GuiResizeScroll()
	local regionHeight = EchoExperience.view.eh.listholder:GetHeight()
  local rowHeight    = EchoExperience.view.eh.listholder.rowHeight
  EchoExperience.debugMsg2("EH_GuiResizeScroll: regionHeight: ", regionHeight, " rowHeight: ", rowHeight )
	local newLines = math.floor(regionHeight / rowHeight)
  EchoExperience.debugMsg2("EH_GuiResizeScroll: newLines:", newLines, " maxlines: ", EchoExperience.view.eh.listholder.maxLines)
	if EchoExperience.view.eh.listholder.maxLines == nil or EchoExperience.view.eh.listholder.maxLines ~= newLines then
    EchoExperience.debugMsg2("EH_GuiResizeScroll: resizing ") 
		EchoExperience.view.eh.listholder.maxLines = newLines
		EchoExperience:EH_GuiResizeLines()
	end
end

------------
--- GUI: Hide what is not withing size and scrolling
function EchoExperience:EH_GuiResizeLines()
	local lines

	if not EchoExperience.view.eh.listholder.lines then
		lines = EchoExperience:EH_CreateInventoryScroll()
  else
    local predecessor = EchoExperience.view.eh.listholder
    EchoExperience.debugMsg2("CreatedLinesCount: ", EchoExperience.view.eh.listholder.createdLinesCount , " maxLines: " , EchoExperience.view.eh.listholder.maxLines)
    if(EchoExperience.view.eh.listholder.createdLinesCount < EchoExperience.view.eh.listholder.maxLines) then
      for i=1, EchoExperience.view.eh.listholder.maxLines do
        EchoExperience.view.eh.listholder.lines[i] = EchoExperience:EH_CreateLine(i, predecessor, EchoExperience.view.eh.listholder)
        predecessor = EchoExperience.view.eh.listholder.lines[i]
      end
      EchoExperience.view.eh.listholder.createdLinesCount = EchoExperience.view.eh.listholder.maxLines
    end
    --EchoExperience:EH_SetItemCountPosition()
    -- setup slider
    --EOL_GUI_ListHolder_Slider:SetMinMax(0, #EchoExperience.view.eh.listholder.dataLines - EchoExperience.view.eh.listholder.maxLines)
	end
	if EchoExperience.view.eh.listholder.lines ~= {} then
		lines = EchoExperience.view.eh.listholder.lines
	end

	for index, line in ipairs(lines) do
--		line.text:SetWidth(textwidth)
--		line:SetWidth(linewidth)
		line:SetHidden(index > EchoExperience.view.eh.listholder.maxLines )
	end
end

------------
--- GUI: setup icons and counts and scroll min/max
function EchoExperience:EH_CreateInventoryScroll()
	EchoExperience.view.eh.listholder.dataOffset = 0

	EchoExperience.view.eh.listholder.dataLines = {}
	EchoExperience.view.eh.listholder.lines = {}
	EchoExperience.view.eh.sortbar.Icon = EchoExperience.view.eh.sortbar:GetNamedChild("_Sort_Name"):GetNamedChild("_Icon")
	
	EchoExperience.view.eh.listholder.maxLines = EchoExperience.defaultMaxLines
	local predecessor = EchoExperience.view.eh.listholder
  EchoExperience.debugMsg2("Creating ", EchoExperience.view.eh.listholder.maxLines , " lines")
	for i=1, EchoExperience.view.eh.listholder.maxLines do
    EchoExperience.view.eh.listholder.lines[i] = EchoExperience:EH_CreateLine(i, predecessor, EchoExperience.view.eh.listholder)
    predecessor = EchoExperience.view.eh.listholder.lines[i]
	end
  EchoExperience.view.eh.listholder.createdLinesCount = EchoExperience.view.eh.listholder.maxLines
  --
	EchoExperience:EH_SetItemCountPosition()
	-- setup slider
	EOL_GUI_ListHolder_Slider:SetMinMax(0, #EchoExperience.view.eh.listholder.dataLines - EchoExperience.view.eh.listholder.maxLines)
  --
	return EchoExperience.view.eh.listholder.lines
end

------------
--- GUI: Scrolling
function EchoExperience:EH_UpdateDataScroll()
	local index = 0
	if EchoExperience.view.eh.listholder.dataOffset < 0 then EchoExperience.view.eh.listholder.dataOffset = 0 end
	if EchoExperience.view.eh.listholder.maxLines == nil then
		EchoExperience.view.eh.listholder.maxLines = EchoExperience.defaultMaxLines
	end
  --d("UpdateDataScroll: offset="..EchoExperience.view.eh.listholder.dataOffset.." maxLines="..EchoExperience.view.eh.listholder.maxLines )  
	EchoExperience:EH_SetDataLinesData()

	local total = #EchoExperience.view.eh.listholder.dataLines - EchoExperience.view.eh.listholder.maxLines
	EchoExperience.view.eh.slider:SetMinMax(0, total)
end

------------
--- GUI: data
function EchoExperience:EH_ClearDataLinesData()
	local curLine, curData
  local lineCount = EchoExperience.view.eh.listholder.maxLines
	for i = 1, lineCount do    
    curLine = EchoExperience.view.eh.listholder.lines[i]
    EchoExperience:EH_fillLine(curLine, nil)
  end
end

------------
--- GUI: data
function EchoExperience:EH_SetDataLinesData()
	local curLine, curData
  --TODO update for EchoExperience.view.eh.search
  EchoExperience.debugMsg2("EH_SetDataLinesData: "
    , " search="  , EchoExperience.view.eh.search
  )

  local lineCount = EchoExperience.view.eh.listholder.maxLines
  local i = 0
  while lineCount > 0 do
	--for i = 1, EchoExperience.view.eh.listholder.maxLines do    
    i = i + 1
    curLine = EchoExperience.view.eh.listholder.lines[i]
    curData = EchoExperience.view.eh.listholder.dataLines[ EchoExperience.view.eh.listholder.dataOffset + i]
    EchoExperience.view.eh.listholder.lines[i] = curLine
    if( curData ~= nil) then
      local okay = true
      if(EchoExperience.view.eh.listholder.filtered and EchoExperience.view.eh.listholder.filterN ~= nil ) then
        --EchoExperience.view.eh.search
        local qlty = curData.quality
        if(qlty~=nil) then
            EchoExperience.debugMsg2("EH_SetDataLinesData: "
              , " qlty="  , qlty
              , " filter="  , EchoExperience.view.eh.listholder.filter
              , " filterN="  , EchoExperience.view.eh.listholder.filterN
            )
            if(EchoExperience.view.eh.listholder.filterN>qlty) then
              okay = false
              EchoExperience.debugMsg2("EH_SetDataLinesData: failed qlty filter")
            end
        end
      end
      if(okay) then
        lineCount = lineCount - 1
        EchoExperience:EH_fillLine(curLine, curData)
      else
        --lineCount = lineCount - 1
        --EchoExperience:EH_fillLine(curLine, nil)
      end
    else
      lineCount = lineCount - 1
      EchoExperience:EH_fillLine(curLine, nil)
    end
	end
end

------------
--- GUI: data: From data into row elements
function EchoExperience:EH_fillLine(curLine, curItem)
  if(curLine==nil) then return end--??????? TODO
	local color
	if curItem == nil then
    curLine.time:SetText("")
    curLine.link = nil
		curLine.icon:SetTexture(nil)
		curLine.icon:SetAlpha(0)
		curLine.name:SetText("")
		curLine.qty:SetText("")
    curLine.user:SetText("")
	else
		local r, g, b, a = 255, 255, 255, 1
		--if (curItem.quality) then
		--	color = GetItemQualityColor(curItem.quality)
		--	r, g, b, a = color:UnpackRGBA()
		--end
    if(curItem.icon==nil) then
        --local icon = GetItemLinkIcon(curItem.link)
        --curItem.icon = icon
    end
    if(curItem.icon~=nil) then
      --curLine.icon:SetTexture(curItem.icon)
      --curLine.icon:SetAlpha(1)
    end
    --[[
        name      = dbItem.name,
        timestr   = dbItem.timestr,
        time      = dbItem.time,
        frame     = dbItem.frame,
        currentxp = dbItem.currentXP,
        nextranxp = dbItem.nextRankXP,
        diff      = dbItem.diff, 
        thisgain  = dbItem.thisGain, 
        texture   = dbItem.texture,
    --]]
    --local strL = zo_strformat("<<1>>", curItem.user)
    --curLine.link     = curItem.link
    curLine.time:SetText( curItem.timestr )
    --curLine.user:SetText( strL )
		--curLine.qty:SetText(curItem.qty)
		--local text = zo_strformat(SI_TOOLTIP_ITEM_NAME, curItem.name)
		--curLine.text:SetText(text)
    curLine.text:SetText(curItem.name)
		--curLine.text:SetColor(r, g, b, a)
    --curLine.name:SetText(curItem.link)
    --curLine.name.link = curItem.link
    --curLine.name:SetLinkEnabled(true)
    --curLine.name:SetLink( curItem.link )
    --curLine:SetLinkEnabled(true)
    --
    --curLine.quality = curItem.itemQuality
    --curLine.itemid = curItem.itemId
    --curLine.iscollected = curItem.isCollected
    --curLine.setname = curItem.setName
		--curLine.stolen = curItem.isStolen
    --curLine.worn = not curItem.worn
    --Indicator    
    EchoExperience.debugMsg2("EH_fillLine: curLine.link: ", curLine.link )    
    --[[
    curLine:SetMouseEnabled(true)
    curLine:SetHandler('OnMouseEnter',function(self)
      EchoExperience:EH_Misc2HeaderTipEnter(self, curLine.link )
    end)
    curLine:SetHandler('OnMouseExit',function(self)
      EchoExperience:EH_Misc2HeaderTipExit(self)
    end)
    --]]
	end
end

------------
--- GUI: data: From HISTORY into datalines
function EchoExperience:EH_UpdateScrollDataLinesData()
  EchoExperience.view.eh.frame.updating = true
  local tempDataLine = nil
	local dataLines = {}
  local itemCount = 0
	local totItems = 0
  
  local elemListP = EchoExperience.view.exphistory
  if elemListP ~= nil then
    for itemKey, dbItem in pairs(elemListP) do
      --k, v.quantity, v.itemlink
      --[[
      elem.timestr    = GetTimeString()
      elem.time       = GetTimeStamp()
      elem.frame      = GetFrameTimeSeconds()
      elem.name        = name
      elem.currentXP  = currentXP
      elem.nextRankXP = nextRankXP
      elem.diff       = diff
      elem.thisGain   = thisGain
      elem.texture    = texture
      --]]
      EchoExperience.debugMsg2("Tracking: itemKey: ", itemKey)
      --
      tempDataLine = {
        name      = dbItem.name,
        timestr   = dbItem.timestr,
        time      = dbItem.time,
        frame     = dbItem.frame,
        currentxp = dbItem.currentXP,
        nextranxp = dbItem.nextRankXP,
        diff      = dbItem.diff, 
        thisgain  = dbItem.thisGain, 
        texture   = dbItem.texture, 
        --
      }
      table.insert(dataLines, tempDataLine)
      totItems = totItems + (itemCount or 0)
    end
  else
    EchoExperience.debugMsg2("Tracking: exp history is null!")
  end
  --  
  --EchoExperience.view.eh.listholder.alldataLines = dataLines
	EchoExperience.view.eh.listholder.dataLines = dataLines
	EchoExperience:EH_Sort(EchoExperience.view.eh.listholder.dataLines)
	EchoExperience.view.eh.listholder.dataOffset = 0

	--EOL_GUI_ListHolder_Counts_Items:SetText("Item Count: " .. totItems)
	--EOL_GUI_ListHolder_Counts_Slots:SetText("Appx. Slots Used: " .. #dataLines)
  EchoExperience.view.eh.frame.updating = false
end

------------
--- GUI: SORT
function EchoExperience:EH_Sort(dataLines)
	if dataLines == nil then dataLines = EchoExperience.view.eh.listholder.dataLines end
	--if (ScrollSortUp) then
  --TODO dataLines = table.sort(dataLines, IIfA_FilterCompareUp)
  --dataLines = table.sort(dataLines, IIfA_FilterCompareDown)
	--end
  EchoExperience:EH_DoGuiSort(nil,nil,nil)
end

------------
--- GUI: Create gui row
function EchoExperience:EH_CreateLine(i, predecessor, parent)
  local name = "EchoExp_EH_ListItem_".. i
	--local line = parent:GetNamedChild(name)
  --EchoExperience.debugMsg2("EH_CreateLine: name: ", name, " parent: ", parent:GetName() )
  --local line = WINDOW_MANAGER:GetControlByName(name, parent:GetName() )
  local line  = EchoExperience.view.eh.listholder.lines[i]
  if(line==nil) then
    EchoExperience.debugMsg2("EH_CreateLine: creating new line!!")
    line = WINDOW_MANAGER:CreateControlFromVirtual("EchoExp_EH_ListItem_".. i, parent, "EchoExp_EH_SlotTemplate")
    line.icon = line:GetNamedChild("Button"):GetNamedChild("Icon")
    line.time = line:GetNamedChild("Time")
    line.name = line:GetNamedChild("Name")
    line.qty  = line:GetNamedChild("Qty")
    line.user = line:GetNamedChild("User")
    line.div  = line:GetNamedChild("Indicator")
    --line.worn = line:GetNamedChild("IconWorn")
    --line.stolen = line:GetNamedChild("IconStolen")
    line:SetHidden(false)
    line:SetMouseEnabled(true)
    line:SetHeight(EchoExperience.view.eh.listholder.rowHeight)

    if i == 1 then
      line:SetAnchor(TOPLEFT,  EchoExperience.view.eh.listholder, TOPLEFT, 0, 0)
      line:SetAnchor(TOPRIGHT, EchoExperience.view.eh.listholder, TOPRIGHT, 0, 0)
    else
      line:SetAnchor(TOPLEFT, predecessor, BOTTOMLEFT, 0, 0)
      line:SetAnchor(TOPRIGHT, predecessor, BOTTOMRIGHT, 0, 0)
    end
    --line:SetHandler("OnMouseEnter", function(self) IIfA:GuiLineOnMouseEnter(self) end )
    --line:SetHandler("OnMouseExit", function(self) IIfA:GuiLineOnMouseExit(self) end )
    --line:SetHandler("OnMouseDoubleClick", function(...) IIfA:GUIDoubleClick(...) end )
  end
  
  --
  if(EchoExperience.view.eh.viewnamelength~=nil) then
    line.name:SetWidth( EchoExperience.view.eh.viewnamelength )
  end
  
  EchoExperience.debugMsg2("Created line ", i , ".")
	return line
end

------------
--- ??
function EchoExperience:EH_SetItemCountPosition()
  --[[
	for i=1, EchoExperience.view.eh.listholder.maxLines do
		local line = EchoExperience.view.eh.listholder.lines[i]
		line.text:ClearAnchors()
		line.qty:ClearAnchors()
		--if EchoExperience:GetSettings().showItemCountOnRight then
			line.qty:SetAnchor(TOPRIGHT,  line, TOPRIGHT, 0, 0)
			line.text:SetAnchor(TOPLEFT,  line:GetNamedChild("Button"), TOPRIGHT, 18, 0)
			line.text:SetAnchor(TOPRIGHT, line.qty, TOPLEFT, -10, 0)
	end
  --]]
end

------------
---GUI: Scrolling handler: update relative values
function EchoExperience:EH_GuiOnSliderUpdate(slider, value)
  EchoExperience.debugMsg("GuiOnSliderUpdate: Called, w/value="..tostring(value)  )
	--if not value or slider.locked then return end
	local relativeValue = math.floor(EchoExperience.view.eh.listholder.dataOffset - value)
  EchoExperience.debugMsg("GuiOnSliderUpdate: relativeValue=" ..tostring(relativeValue) .. " value="..tostring(value) .. " offset="..tostring(EchoExperience.view.eh.listholder.dataOffset)  )
	EchoExperience:EH_GuiOnScroll(slider, relativeValue)
end

------------
---GUI: Scrolling handler
function EchoExperience:EH_GuiOnScroll(control, delta)  
	if not delta then return end
  EchoExperience.debugMsg("GuiOnScroll: delta="..tostring(delta) )
	if delta == 0 then return end
  if EchoExperience.view.eh.listholder.dataOffset < 0 then EchoExperience.view.eh.listholder.dataOffset = 0 end
  
	local slider = EchoExperience.view.eh.slider
	local value  = (EchoExperience.view.eh.listholder.dataOffset - delta)
	local total  = #EchoExperience.view.eh.listholder.dataLines - EchoExperience.view.eh.listholder.maxLines

	if value < 0 then value = 0 end
	if value > total then value = total end
	EchoExperience.view.eh.listholder.dataOffset  = value
  EchoExperience.debugMsg("GuiOnScroll: set dataOffset="..tostring(value) )

  ----Setup max lines, and slider (calls RefreshViewableTable: create show lines based on offset)
	EchoExperience:EH_UpdateDataScroll()
  
  --Set max, and Hide lines out of the max display
  EchoExperience:EH_GuiResizeScroll()

	slider:SetValue(EchoExperience.view.eh.listholder.dataOffset)

	--EchoExperience:GuiLineOnMouseEnter(moc())
end

------------
---SORT: 
function EchoExperience:EH_DoGuiSort(control,newSort,sortText)
  EchoExperience.debugMsg2("DoGuiSort: called w/sortText='", tostring(sortText), "' newSort: ", tostring(newSort) )
  if(sortText==nil) then
    EchoExperience.debugMsg("DoGuiSort: reset sort?")
    newSort = true
    if(EchoExperience.view.eh.sort.key==nil) then
      sortText = "time"
    else
      sortText = EchoExperience.view.eh.sort.key
    end
  end
  if(newSort or sortText ~= EchoExperience.view.eh.sort.key ) then
    EchoExperience.view.eh.sort = {}
    EchoExperience.view.eh.sort.key = sortText
    EchoExperience.view.eh.sort.dir = false
  else 
    EchoExperience.view.eh.sort.dir = not EchoExperience.view.eh.sort.dir
  end
  EchoExperience.debugMsg2("DoGuiSort: called w/key='", tostring(EchoExperience.view.eh.sort.key), "' order: ", tostring(EchoExperience.view.eh.sort.dir) )

  --setup function
  local gSearch = nil
  local gSearch1 = function (a,b)
    local aVal = a[EchoExperience.view.eh.sort.key]
    local bVal = b[EchoExperience.view.eh.sort.key]
    EchoExperience.debugMsg2("gSearch1: aVal=", tostring(aVal) , " bVal="..tostring(bVal) )
    local value1Type = type(aVal)
    if(aVal == nil) then 
        if(value1Type=="string") then
          aVal = "nil"
        else
          aVal = 0
        end
    end
    if(bVal == nil) then 
        if(value1Type=="string") then
          bVal = "nil"
        else
          bVal = 0
        end
    end
    EchoExperience.debugMsg("sort: aVal="..tostring(aVal).." bVal="..tostring(bVal))
    --debugMsg("ESOA: a.name="..a.name.." b.name="..b.name)
    if(EchoExperience.view.eh.sort.dir) then
      return bVal > aVal or bVal == aVal and b.name < a.name
    else
      return aVal > bVal or aVal == bVal and a.name < b.name
    end
  end
  --
  gSearch = gSearch1
  if(EchoExperience.view.eh.listholder==nil or EchoExperience.view.eh.listholder.dataLines==nil or EchoExperience.view.eh.listholder.dataLines[1]==nil) then
    gSearch = nil
  else
  --[[
  setmetatable(t,{
    __index = function(t,k) return 0 end
  })
  --]]
    local testEntry1 = EchoExperience.view.eh.listholder.dataLines[1]
    if(testEntry1==nil) then
      gSearch = nil
   -- elseif( testEntry1[EchoExperience.view.currentSortKey.."_Rank"] ~=nil ) then
    --  gSearch = gSearch2
    --elseif( testEntry1[EchoExperience.view.currentSortKey.."_rank"] ~=nil ) then
    --  gSearch = gSearch2b
    --elseif( testEntry1[ EchoExperience.view.currentSortKey:gsub(" ","_") ] ~=nil ) then
    --  gSearch = gSearch3
    end
  end
  --
  if(gSearch~=nil) then
    table.sort( EchoExperience.view.eh.listholder.dataLines, gSearch )
  else
    EchoExperience.debugMsg("sort: null input so no sorting")
  end
  --Sort Label
  local sVal = zo_strformat("<<C:1>>", EchoExperience.view.eh.sort.key )
  --ESOA_GUI2_Header_SortBy_Value:SetText( sVal )
  
  -- Sort Arrows
  if( not EchoExperience.view.eh.sort.dir ) then
    --ESOA_GUI2_Header_SortUp:SetHidden(false)
    --ESOA_GUI2_Header_SortDown:SetHidden(true)
  else
    --ESOA_GUI2_Header_SortUp:SetHidden(true)
    --ESOA_GUI2_Header_SortDown:SetHidden(false)
  end
  
	--ESOA_GUI2_Body_ListHolder.dataOffset = 0
  EchoExperience:EH_GuiResizeScroll()	
  EchoExperience:EH_UpdateDataScroll()

end--DOGUISORT

------------
---Logic 
function EchoExperience:EH_ClearHistory()
  EchoExperience.view.exphistory = {}
end

--TOOLTIP
function EchoExperience:EH_Misc2HeaderTipEnter(sender,textline)
  --EchoExperience.debugMsg2("EH_Misc2HeaderTipEnter: called. deftype: ", textline )
  --InitializeTooltip(EELHTooltip, sender, TOPLEFT, 5, -56, TOPRIGHT)
  if(textline==nil or textline=="Link" and sender.link ~= nil) then
    --EchoExperience.debugMsg2("EH_Misc2HeaderTipEnter: called. link: ", sender.link )
    --EchoExperience.ItemTooltip(sender.link)
		InitializeTooltip(EchoExperience.view.eh.tooltip, EchoExperience.view.eh.frame, TOPRIGHT, -50, 0, TOPLEFT)
    local linkType = GetLinkType(sender.link)
    if(linkType==LINK_TYPE_INVALID) then
      EELHTooltip:AddLine(sender.link, "ZoFontHeader3")
    else
      EchoExperience.view.eh.tooltip:SetLink(sender.link)
    end    
  --EELHTooltip:AddLine(sender.link, "ZoFontHeader3")
  else
    --EchoExperience.ItemTooltip(textline)
    --EELHTooltip:AddLine(textline, "ZoFontHeader3")
    InitializeTooltip(EELHTooltip, sender, TOPLEFT, 5, -56, TOPRIGHT)
    EELHTooltip:AddLine(textline, "ZoFontHeader3")
  end
end
function EchoExperience:EH_Misc2HeaderTipExit(sender)
  --ClearTooltip(InformationTooltip)
  --EchoExperience.debugMsg2("EH_Misc2HeaderTipExit: called.")
  ClearTooltip(EELHTooltip)
  ClearTooltip(EchoExperience.view.eh.tooltip)
end
--EH_LineTipEnter
--EH_LineTipExit
------------
--EOF
------------