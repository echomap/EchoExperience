--[[ ------------ ]]--
--[[ Loot History GUI ]]-- 
--[[ ------------ ]]--

------------
---GUI
function EchoExperience:LH_Setup()  
  EchoExperience.view.lh = {}
  EchoExperience.view.lh.frame      = EOL_LOOTHISTORY_Frame
  EchoExperience.view.lh.list       = EOL_LOOTHISTORY_FrameList
  EchoExperience.view.lh.listholder = EOL_LOOTHISTORY_FrameList_ListHolder
  EchoExperience.view.lh.sortbar    = EOL_LOOTHISTORY_FrameListHeaders
  EchoExperience.view.lh.slider     = EOL_LOOTHISTORY_FrameList_ListHolder_Slider
  --EchoExperience.view.list = EOL_LOOTHISTORY_FrameListList
  
	EchoExperience.view.lh.listholder.rowHeight = 24
	EchoExperience.view.lh.listholder:SetDrawLayer(0)
  EchoExperience.view.lh.listholder.dataOffset = 0
  --
  EchoExperience.view.lh.sort = {}
  EchoExperience.view.lh.sort.key = "name"
  EchoExperience.view.lh.sort.dir = true
end

------------
---GUI
function EchoExperience:LH_Show() 
  if(EchoExperience.view.lh.listholder~=nil and EchoExperience.view.lh.listholder.dataLines ~=nil ) then
    EchoExperience:LH_UpdateDataScroll()
  end
end

------------
--- GUI
function EchoExperience:LH_CloseUI()
  EchoExperience.view.lh.frame:SetHidden( not EchoExperience.view.lh.frame:IsHidden() )
end

------------
--- GUI: Save
function EchoExperience:LH_SaveFramePosition(calledFrom)
  if(EchoExperience.savedVariables.frame_LH==null)then
    EchoExperience.savedVariables.frame_LH = {}
  end
  EchoExperience.savedVariables.frame_LH.lastX	= EchoExperience.view.lh.frame:GetLeft()
  EchoExperience.savedVariables.frame_LH.lastY	= EchoExperience.view.lh.frame:GetTop()
end

------------
--- GUI
function EchoExperience:LH_onResizeStop()
	EVENT_MANAGER:UnregisterForUpdate(EchoExperience.name.."LH_OnWindowResize")
	EchoExperience:LH_SaveFrameInfo("onResizeStop")
  --<Anchor point="BOTTOMRIGHT" relativeTo="$(parent)" relativePoint="BOTTOMRIGHT" offsetX="-35" offsetY="-10"/>
  --EchoExperience.view.lh.listholder:SetAnchor(BOTTOMRIGHT, EchoExperience.view.lh.list, BOTTOMRIGHT, 0, ElderScrollsOfAlts.altData.fieldYOffset)
  --
	EchoExperience:LH_GuiResizeScroll()	
  EchoExperience:LH_UpdateDataScroll()
end

------------
--- GUI
function EchoExperience:LH_onResizeStart()
	EVENT_MANAGER:RegisterForUpdate(EchoExperience.name.."LH_OnWindowResize", 50, 
    function()
      EchoExperience:LH_UpdateScrollDataLinesData()
      EchoExperience:LH_GuiResizeScroll()
      EchoExperience:LH_UpdateDataScroll()
    end)
end

------------
--- GUI
function EchoExperience:LH_SaveFrameInfo(calledFrom)
	if (calledFrom == "onHide") then return end
  if(EchoExperience.savedVariables.frame_LH==null)then
    EchoExperience.savedVariables.frame_LH = {}
  end

  EchoExperience.savedVariables.frame_LH.lastX	= EchoExperience.view.lh.frame:GetLeft()
  EchoExperience.savedVariables.frame_LH.lastY	= EchoExperience.view.lh.frame:GetTop()
  EchoExperience.savedVariables.frame_LH.width	= EchoExperience.view.lh.frame:GetWidth()
  EchoExperience.savedVariables.frame_LH.height	= EchoExperience.view.lh.frame:GetHeight()
end

------------
--- TOOLTIP
function EchoExperience:LH_Misc2HeaderTipEnter(sender,key)
  InitializeTooltip(EEXPTooltip, sender, TOPLEFT, 5, -56, TOPRIGHT)
  EEXPTooltip:AddLine(key, "ZoFontHeader3")
end

------------
--- TOOLTIP
function EchoExperience:LH_Misc2HeaderTipExit(sender)
  --ClearTooltip(InformationTooltip)
  ClearTooltip(EEXPTooltip)
end

------------
--- GUI
function EchoExperience:LH_GuiResizeScroll()
	local regionHeight = EchoExperience.view.lh.listholder:GetHeight()
  local rowHeight    = EchoExperience.view.lh.listholder.rowHeight
  EchoExperience.debugMsg2("LH_GuiResizeScroll: regionHeight: ", regionHeight, " rowHeight: ", rowHeight )
	local newLines = math.floor(regionHeight / rowHeight)
	if EchoExperience.view.lh.listholder.maxLines == nil or EchoExperience.view.lh.listholder.maxLines ~= newLines then
		EchoExperience.view.lh.listholder.maxLines = newLines
		EchoExperience:LH_GuiResizeLines()
	end
end

------------
--- GUI: Hide what is not withing size and scrolling
function EchoExperience:LH_GuiResizeLines()
	local lines

	if not EchoExperience.view.lh.listholder.lines then
		lines = EchoExperience:LH_CreateInventoryScroll()
	end
	if EchoExperience.view.lh.listholder.lines ~= {} then
		lines = EchoExperience.view.lh.listholder.lines
	end

	for index, line in ipairs(lines) do
--		line.text:SetWidth(textwidth)
--		line:SetWidth(linewidth)
		line:SetHidden(index > EchoExperience.view.lh.listholder.maxLines )
	end
end

------------
--- GUI: setup icons and counts and scroll min/max
function EchoExperience:LH_CreateInventoryScroll()
	EchoExperience.view.lh.listholder.dataOffset = 0

	EchoExperience.view.lh.listholder.dataLines = {}
	EchoExperience.view.lh.listholder.lines = {}
	EchoExperience.view.lh.sortbar.Icon = EchoExperience.view.lh.sortbar:GetNamedChild("_Sort_Name"):GetNamedChild("_Icon")
	
	EchoExperience.view.lh.listholder.maxLines = EchoExperience.defaultMaxLines
	local predecessor = nil
	for i=1, EchoExperience.view.lh.listholder.maxLines do
		EchoExperience.view.lh.listholder.lines[i] = EchoExperience:LH_CreateLine(i, predecessor, EchoExperience.view.lh.listholder)
		predecessor = EchoExperience.view.lh.listholder.lines[i]
	end
  --
	EchoExperience:LH_SetItemCountPosition()
	-- setup slider
	EOL_GUI_ListHolder_Slider:SetMinMax(0, #EchoExperience.view.lh.listholder.dataLines - EchoExperience.view.lh.listholder.maxLines)
  --
	return EchoExperience.view.lh.listholder.lines
end

------------
--- GUI: Scrolling
function EchoExperience:LH_UpdateDataScroll()
	local index = 0
	if EchoExperience.view.lh.listholder.dataOffset < 0 then EchoExperience.view.lh.listholder.dataOffset = 0 end
	if EchoExperience.view.lh.listholder.maxLines == nil then
		EchoExperience.view.lh.listholder.maxLines = EchoExperience.defaultMaxLines
	end
  --d("UpdateDataScroll: offset="..EchoExperience.view.lh.listholder.dataOffset.." maxLines="..EchoExperience.view.lh.listholder.maxLines )  
	EchoExperience:LH_SetDataLinesData()

	local total = #EchoExperience.view.lh.listholder.dataLines - EchoExperience.view.lh.listholder.maxLines
	EchoExperience.view.lh.slider:SetMinMax(0, total)
end

------------
--- GUI: data
function EchoExperience:LH_SetDataLinesData()
	local curLine, curData
	for i = 1, EchoExperience.view.lh.listholder.maxLines do
		curLine = EchoExperience.view.lh.listholder.lines[i]
		curData = EchoExperience.view.lh.listholder.dataLines[EchoExperience.view.lh.listholder.dataOffset + i]
		EchoExperience.view.lh.listholder.lines[i] = curLine

		if( curData ~= nil) then
			EchoExperience:LH_fillLine(curLine, curData)
		else
			EchoExperience:LH_fillLine(curLine, nil)
		end
	end
end

------------
--- GUI: data: From data into row elements
function EchoExperience:LH_fillLine(curLine, curItem)
  if(curLine==nil) then return end--??????? TODO
	local color
	if curItem == nil then
    curLine.time:SetText("")
		curLine.itemLink = ""
		curLine.icon:SetTexture(nil)
		curLine.icon:SetAlpha(0)
		curLine.name:SetText("")
		curLine.qty:SetText("")
		--curLine.worn:SetHidden(true)
		--curLine.stolen:SetHidden(true)
		--Hide the FCOIS marker icons at the line (do not create them if not needed) -> File plugins/FCOIS/IIfA_FCOIS.lua
	--	if IIfA.UpdateFCOISMarkerIcons ~= nil then
	--		IIfA:UpdateFCOISMarkerIcons(curLine, false, false, -1)
	--	end
	else
		local r, g, b, a = 255, 255, 255, 1
		--if (curItem.quality) then
		--	color = GetItemQualityColor(curItem.quality)
		--	r, g, b, a = color:UnpackRGBA()
		--end
    if(curItem.icon==nil) then
        local icon = GetItemLinkIcon(curItem.link)
        curItem.icon = icon
    end
    -- 
		curLine.itemLink = curItem.link
    curLine.time:SetText( curItem.time )
    curLine.user:SetText( tostring(curItem.user) )
		curLine.qty:SetText(curItem.qty)
		--local text = zo_strformat(SI_TOOLTIP_ITEM_NAME, curItem.name)
		--curLine.text:SetText(text)
		--curLine.text:SetColor(r, g, b, a)
    curLine.name:SetText(curItem.link)
    --curLine:SetLinkEnabled(true)
		curLine.icon:SetTexture(curItem.icon)
    curLine.icon:SetAlpha(1)
    --
    --curLine.quality = curItem.itemQuality
    --curLine.itemid = curItem.itemId
    --curLine.iscollected = curItem.isCollected
    --curLine.setname = curItem.setName
		--curLine.stolen = curItem.isStolen
    --curLine.worn = not curItem.worn
    --Indicator    
    if(not curItem.iscollected) then
      curLine.icon:SetTexture("esoui\art\inventory\inventory_sell_forbidden_icon.dds")
      curLine.icon:SetAlpha(1)
    elseif(curItem.isstolen) then
      curLine.icon:SetTexture("esoui\art\inventory\inventory_stolenitem_icon.dds")
      curLine.icon:SetAlpha(1)
    end
    --
	end
end

------------
--- GUI: data: From HISTORY into datalines
function EchoExperience:LH_UpdateScrollDataLinesData()
  local tempDataLine = nil
	local dataLines = {}
  local itemCount = 0
	local totItems = 0
  
  local elemListP = EchoExperience.view.loothistory
  if elemListP ~= nil then
    for itemKey, dbItem in pairs(elemListP) do
      --k, v.quantity, v.itemlink
      EchoExperience.debugMsg2("Tracking: itemKey: ", itemKey)
      dbItem.name = GetItemLinkName(dbItem.itemLink) 
      dbItem.icon = GetItemLinkIcon(dbItem.itemLink)
      --
      local itemQuality = GetItemLinkQuality(dbItem.link)
      local itemId      = GetItemLinkItemId(dbItem.link)
      local isCollected = IsItemSetCollectionPieceUnlocked(itemId)
      local traitType, traitDescription = GetItemLinkTraitInfo(dbItem.link)
      local hasSet, setName, numBonuses, numEquipped, maxEquipped, setId   = GetItemLinkSetInfo(dbItem.link)
      local icon, sellPrice, meetsUsageRequirement, equipType, itemStyleId = GetItemLinkInfo(dbItem.link)
      local isStolen    = IsItemLinkStolen(dbItem.link)
      --
      tempDataLine = {
        link = dbItem.itemLink,
        qty  = dbItem.quantity,
        icon = dbItem.icon,
        name = dbItem.name,
        time = dbItem.time,
        user = dbItem.user, 
        --
        quality = itemQuality,
        itemid = itemId,
        iscollected = isCollected,
        setname = setName,
        stolen = isStolen,
        --quality = dbItem.itemQuality,
        --filter = itemTypeFilter,
        --worn = bWorn
      }
      table.insert(dataLines, tempDataLine)
      totItems = totItems + (itemCount or 0)
    end
  end
  --  
	EchoExperience.view.lh.listholder.dataLines = dataLines
	EchoExperience:LH_Sort(EchoExperience.view.lh.listholder.dataLines)
	EchoExperience.view.lh.listholder.dataOffset = 0

	--EOL_GUI_ListHolder_Counts_Items:SetText("Item Count: " .. totItems)
	--EOL_GUI_ListHolder_Counts_Slots:SetText("Appx. Slots Used: " .. #dataLines)
end

------------
--- GUI: SORT
function EchoExperience:LH_Sort(dataLines)
	if dataLines == nil then dataLines = EchoExperience.view.lh.listholder.dataLines end
	--if (ScrollSortUp) then
  --TODO dataLines = table.sort(dataLines, IIfA_FilterCompareUp)
  --dataLines = table.sort(dataLines, IIfA_FilterCompareDown)
	--end
  EchoExperience:LH_DoGuiSort(nil,nil,nil)
end

------------
--- GUI: Create gui row
function EchoExperience:LH_CreateLine(i, predecessor, parent)
	local line = WINDOW_MANAGER:CreateControlFromVirtual("EchoExp_LH_ListItem_".. i, parent, "EchoExp_LH_SlotTemplate")

	line.icon = line:GetNamedChild("Button"):GetNamedChild("Icon")
  line.time = line:GetNamedChild("Time")
	line.name = line:GetNamedChild("Name")
	line.qty  = line:GetNamedChild("Qty")
  line.user = line:GetNamedChild("User")
  line.div = line:GetNamedChild("Indicator")
	--line.worn = line:GetNamedChild("IconWorn")
	--line.stolen = line:GetNamedChild("IconStolen")

	line:SetHidden(false)
	line:SetMouseEnabled(true)
	line:SetHeight(EchoExperience.view.lh.listholder.rowHeight)

	if i == 1 then
		line:SetAnchor(TOPLEFT,  EchoExperience.view.lh.listholder, TOPLEFT, 0, 0)
		line:SetAnchor(TOPRIGHT, EchoExperience.view.lh.listholder, TOPRIGHT, 0, 0)
	else
		line:SetAnchor(TOPLEFT, predecessor, BOTTOMLEFT, 0, 0)
		line:SetAnchor(TOPRIGHT, predecessor, BOTTOMRIGHT, 0, 0)
	end

	--line:SetHandler("OnMouseEnter", function(self) IIfA:GuiLineOnMouseEnter(self) end )
	--line:SetHandler("OnMouseExit", function(self) IIfA:GuiLineOnMouseExit(self) end )
	--line:SetHandler("OnMouseDoubleClick", function(...) IIfA:GUIDoubleClick(...) end )

	return line
end

------------
--- ??
function EchoExperience:LH_SetItemCountPosition()
  --[[
	for i=1, EchoExperience.view.lh.listholder.maxLines do
		local line = EchoExperience.view.lh.listholder.lines[i]
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
function EchoExperience:LH_GuiOnSliderUpdate(slider, value)
  EchoExperience.debugMsg("GuiOnSliderUpdate: Called, w/value="..tostring(value)  )
	--if not value or slider.locked then return end
	local relativeValue = math.floor(EchoExperience.view.lh.listholder.dataOffset - value)
  EchoExperience.debugMsg("GuiOnSliderUpdate: relativeValue=" ..tostring(relativeValue) .. " value="..tostring(value) .. " offset="..tostring(EchoExperience.view.lh.listholder.dataOffset)  )
	EchoExperience:LH_GuiOnScroll(slider, relativeValue)
end

------------
---GUI: Scrolling handler
function EchoExperience:LH_GuiOnScroll(control, delta)  
	if not delta then return end
  EchoExperience.debugMsg("GuiOnScroll: delta="..tostring(delta) )
	if delta == 0 then return end
  if EchoExperience.view.lh.listholder.dataOffset < 0 then EchoExperience.view.lh.listholder.dataOffset = 0 end
  
	local slider = EchoExperience.view.lh.slider
	local value  = (EchoExperience.view.lh.listholder.dataOffset - delta)
	local total  = #EchoExperience.view.lh.listholder.dataLines - EchoExperience.view.lh.listholder.maxLines

	if value < 0 then value = 0 end
	if value > total then value = total end
	EchoExperience.view.lh.listholder.dataOffset  = value
  EchoExperience.debugMsg("GuiOnScroll: set dataOffset="..tostring(value) )

  ----Setup max lines, and slider (calls RefreshViewableTable: create show lines based on offset)
	EchoExperience:LH_UpdateDataScroll()
  
  --Set max, and Hide lines out of the max display
  EchoExperience:LH_GuiResizeScroll()

	slider:SetValue(EchoExperience.view.lh.listholder.dataOffset)

	--EchoExperience:GuiLineOnMouseEnter(moc())
end

------------
---SORT: 
function EchoExperience:LH_DoGuiSort(control,newSort,sortText)
  EchoExperience.debugMsg2("DoGuiSort: called w/sortText='", tostring(sortText), "' newSort: ", tostring(newSort) )
  if(sortText==nil) then
    EchoExperience.debugMsg("DoGuiSort: reset sort?")
    if(EchoExperience.view.lh.sort.key==nil) then
      sortText = "time"
    else
      sortText = EchoExperience.view.lh.sort.key
    end
  end
  if(newSort or sortText ~= EchoExperience.view.lh.sort.key ) then
    EchoExperience.view.lh.sort = {}
    EchoExperience.view.lh.sort.key = sortText
    EchoExperience.view.lh.sort.dir = true
  else 
    EchoExperience.view.lh.sort.dir = not EchoExperience.view.lh.sort.dir
  end
  EchoExperience.debugMsg2("DoGuiSort: called w/key='", tostring(EchoExperience.view.lh.sort.key), "' order: ", tostring(EchoExperience.view.lh.sort.dir) )

  --setup function
  local gSearch = nil
  local gSearch1 = function (a,b)
    local aVal = a[EchoExperience.view.lh.sort.key]
    local bVal = b[EchoExperience.view.lh.sort.key]
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
    if(EchoExperience.view.lh.sort.dir) then
      return bVal > aVal or bVal == aVal and b.name < a.name
    else
      return aVal > bVal or aVal == bVal and a.name < b.name
    end
  end
  --
  gSearch = gSearch1
  if(EchoExperience.view.lh.listholder==nil or EchoExperience.view.lh.listholder.dataLines==nil or EchoExperience.view.lh.listholder.dataLines[1]==nil) then
    gSearch = nil
  else
  --[[
  setmetatable(t,{
    __index = function(t,k) return 0 end
  })
  --]]
    local testEntry1 = EchoExperience.view.lh.listholder.dataLines[1]
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
    table.sort( EchoExperience.view.lh.listholder.dataLines, gSearch )
  else
    EchoExperience.debugMsg("sort: null input so no sorting")
  end
  --Sort Label
  local sVal = zo_strformat("<<C:1>>", EchoExperience.view.lh.sort.key )
  --ESOA_GUI2_Header_SortBy_Value:SetText( sVal )
  
  -- Sort Arrows
  if( not EchoExperience.view.lh.sort.dir ) then
    --ESOA_GUI2_Header_SortUp:SetHidden(false)
    --ESOA_GUI2_Header_SortDown:SetHidden(true)
  else
    --ESOA_GUI2_Header_SortUp:SetHidden(true)
    --ESOA_GUI2_Header_SortDown:SetHidden(false)
  end
  
	--ESOA_GUI2_Body_ListHolder.dataOffset = 0
  EchoExperience:LH_GuiResizeScroll()	
  EchoExperience:LH_UpdateDataScroll()

end--DOGUISORT

------------
---Logic 
function EchoExperience:LH_ClearLootHistory()
  EchoExperience.view.loothistory = {}
end

------------
--EOF
------------