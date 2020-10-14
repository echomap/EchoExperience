--[[ ------------ ]]--
--[[ Tracking GUI ]]-- 
--[[ ------------ ]]--

------
---GUI

--TOOLTIP
function EchoExperience:Misc2HeaderTipEnter(sender,key)
  InitializeTooltip(EEXPTooltip, sender, TOPLEFT, 5, -56, TOPRIGHT)
  EEXPTooltip:AddLine(key, "ZoFontHeader3")
end
function EchoExperience:Misc2HeaderTipExit(sender)
  --ClearTooltip(InformationTooltip)
  ClearTooltip(EEXPTooltip)
end

function EchoExperience:SetGuiFilter(self, button, filterType, subFilter)
  EchoExperience.view.filterType = filterType
  --if(filterType=="All")then
  --end
  EchoExperience:UpdateScrollDataLinesData()
  EchoExperience:GuiResizeScroll()
  EchoExperience:RefreshInventoryScroll()
end

function EchoExperience:CloseUI()
  EOL_GUI:SetHidden( not EOL_GUI:IsHidden() )
end

function EchoExperience:onResizeStart()
	EVENT_MANAGER:RegisterForUpdate(EchoExperience.name.."OnWindowResize", 50, 
    function()
      EchoExperience:UpdateScrollDataLinesData()
      EchoExperience:GuiResizeScroll()
      EchoExperience:UpdateDataScroll()
    end)
end

function EchoExperience:SaveFrameInfo(calledFrom)
	if (calledFrom == "onHide") then return end
  if(EchoExperience.savedVariables.frame2==null)then
    EchoExperience.savedVariables.frame2 = {}
  end
	--local sceneName = EchoExperience:GetCurrentSceneName()
	--if not QUICKSLOT_FRAGMENT:IsHidden() then
	--	sceneName = sceneName .. "_quickslots"
	--end

	--local settings = IIfA:GetSceneSettings(sceneName)
	--settings.hidden = IIFA_GUI:IsControlHidden()

	--if (not settings.docked and (calledFrom == "onMoveStop" or calledFrom == "onResizeStop")) then
		EchoExperience.savedVariables.frame2.lastX	= EOL_GUI:GetLeft()
		EchoExperience.savedVariables.frame2.lastY	= EOL_GUI:GetTop()
		--if not settings.minimized then
			EchoExperience.savedVariables.frame2.width	= EOL_GUI:GetWidth()
			EchoExperience.savedVariables.frame2.height	= EOL_GUI:GetHeight()
		--end
	--end
end

function EchoExperience:SaveFramePosition(calledFrom)
  if(EchoExperience.savedVariables.frame2==null)then
    EchoExperience.savedVariables.frame2 = {}
  end
  EchoExperience.savedVariables.frame2.lastX	= EOL_GUI:GetLeft()
  EchoExperience.savedVariables.frame2.lastY	= EOL_GUI:GetTop()
end

function EchoExperience:onResizeStop()
	EVENT_MANAGER:UnregisterForUpdate(EchoExperience.name.."OnWindowResize")
	EchoExperience:SaveFrameInfo("onResizeStop")
	EchoExperience:GuiResizeScroll()	
  EchoExperience:UpdateDataScroll()
end

--
function EchoExperience:GuiOnSliderUpdate(slider, value)
  EchoExperience.debugMsg("GuiOnSliderUpdate: Called, w/value="..tostring(value)  )
	--if not value or slider.locked then return end
	local relativeValue = math.floor(EOL_GUI_ListHolder.dataOffset - value)
  EchoExperience.debugMsg("GuiOnSliderUpdate: relativeValue=" ..tostring(relativeValue) .. " value="..tostring(value) .. " offset="..tostring(EOL_GUI_ListHolder.dataOffset)  )
	EchoExperience:GuiOnScroll(slider, relativeValue)
end

--
function EchoExperience:GuiOnScroll(control, delta)  
	if not delta then return end
  EchoExperience.debugMsg("GuiOnScroll: delta="..tostring(delta) )
	if delta == 0 then return end
  if EOL_GUI_ListHolder.dataOffset < 0 then EOL_GUI_ListHolder.dataOffset = 0 end
  
	local slider = EOL_GUI_ListHolder_Slider
	local value  = (EOL_GUI_ListHolder.dataOffset - delta)
	local total  = #EOL_GUI_ListHolder.dataLines - EOL_GUI_ListHolder.maxLines

	if value < 0 then value = 0 end
	if value > total then value = total end
	EOL_GUI_ListHolder.dataOffset  = value
  EchoExperience.debugMsg("GuiOnScroll: set dataOffset="..tostring(value) )

  ----Setup max lines, and slider (calls RefreshViewableTable: create show lines based on offset)
	EchoExperience:UpdateDataScroll()
  
  --Set max, and Hide lines out of the max display
  EchoExperience:GuiResizeScroll()

	slider:SetValue(EOL_GUI_ListHolder.dataOffset)

	--EchoExperience:GuiLineOnMouseEnter(moc())
end

function EchoExperience:UpdateDataScroll()
	local index = 0
	if EOL_GUI_ListHolder.dataOffset < 0 then EOL_GUI_ListHolder.dataOffset = 0 end
	if EOL_GUI_ListHolder.maxLines == nil then
		EOL_GUI_ListHolder.maxLines = EchoExperience.defaultMaxLines
	end
  --d("UpdateDataScroll: offset="..EOL_GUI_ListHolder.dataOffset.." maxLines="..EOL_GUI_ListHolder.maxLines )  
	EchoExperience:SetDataLinesData()

	local total = #EOL_GUI_ListHolder.dataLines - EOL_GUI_ListHolder.maxLines
	EOL_GUI_ListHolder_Slider:SetMinMax(0, total)
end

--??
function EchoExperience:SetDataLinesData()
	local curLine, curData
	for i = 1, EOL_GUI_ListHolder.maxLines do
		curLine = EOL_GUI_ListHolder.lines[i]
		curData = EOL_GUI_ListHolder.dataLines[EOL_GUI_ListHolder.dataOffset + i]
		EOL_GUI_ListHolder.lines[i] = curLine

		if( curData ~= nil) then
			EchoExperience:fillLine(curLine, curData)
		else
			EchoExperience:fillLine(curLine, nil)
		end
	end
end

function EchoExperience:fillLine(curLine, curItem)
  if(curLine==nil) then return end--??????? TODO
	local color
	if curItem == nil then
		curLine.itemLink = ""
		curLine.icon:SetTexture(nil)
		curLine.icon:SetAlpha(0)
		curLine.text:SetText("")
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
		curLine.icon:SetTexture(curItem.icon)
    curLine.icon:SetAlpha(1)
		local text = zo_strformat(SI_TOOLTIP_ITEM_NAME, curItem.name)
		curLine.text:SetText(text)
		curLine.text:SetColor(r, g, b, a)
		curLine.qty:SetText(curItem.qty)
		--curLine.worn:SetHidden(not curItem.worn)
		--curLine.stolen:SetHidden(not IsItemLinkStolen(curItem.link))
		--Show the FCOIS marker icons at the line, if enabled in the settings (create them if needed)  -> File plugins/FCOIS/IIfA_FCOIS.lua
		--if IIfA.UpdateFCOISMarkerIcons ~= nil then
		--	local showFCOISMarkerIcons = IIfA:GetSettings().FCOISshowMarkerIcons
		--	IIfA:UpdateFCOISMarkerIcons(curLine, showFCOISMarkerIcons, false, -1)
		--end
	end
end


function EchoExperience:RefreshInventoryScroll()
	EchoExperience:UpdateScrollDataLinesData()
	EchoExperience:UpdateDataScroll()
end

function EchoExperience:UpdateScrollDataLinesData()
  --
  --TODO mode, tracking vs lifetime
  local tempDataLine = nil
	local dataLines = {}
  local itemCount = 0
	local totItems = 0
  
  local elemListP = nil
  local elemListS = nil
  if(EchoExperience.view.trackingSelection=="Lifetime") then
    elemListP = EchoExperience.savedVariables.lifetime
  else
    EchoExperience.debugMsg2("Tracking: trackingCurrentSession: '", EchoExperience.view.trackingCurrentSession, "'" )
    elemListP = EchoExperience.view.tracking --EchoExperience.savedVariables.tracking 
    if(EchoExperience.view.trackingCurrentSession~=nil and 
        (EchoExperience.view.trackingCurrentSession ~= "0" or EchoExperience.view.trackingCurrentSession ~= 0) 
    ) then
      EchoExperience.debugMsg2("Tracking: set to session: ", EchoExperience.view.trackingCurrentSession)
      elemListP = EchoExperience.view.trackingsessions[EchoExperience.view.trackingCurrentSession]
      EchoExperience.debugMsg2("Tracking: trackingCurrentSession: using session data ")
    end
    local thisSession =  EchoExperience:GetTrackingSession(EchoExperience.view.trackingCurrentSession)
    elemListP = thisSession
    if(elemListP==nil) then
       EchoExperience.debugMsg2("Tracking: Sessions: dbkey2= table all NIL!")
    else
      for dbkey2, dbItem2 in pairs(elemListP) do
        EchoExperience.debugMsg2("Tracking: Sessions: dbkey2='", dbkey2, "'" )
      end
    end
  end
  if(EchoExperience.view.filterType=="Items")then
    elemListS = elemListP.items
  elseif(EchoExperience.view.filterType=="Mobs")then
    elemListS = elemListP.mobs
  elseif(EchoExperience.view.filterType=="Currency")then
    elemListS = elemListP.currency
  elseif(EchoExperience.view.filterType=="BG")then
    elemListS = elemListP.bg
  else
    elemListS = nil
  end
  
  if(elemListS~=nil) then
    for itemKey, dbItem in pairs(elemListS) do
      --k, v.quantity, v.itemlink
      local iName = itemKey
      if(EchoExperience.view.filterType=="Currency") then
        iName = GetCurrencyName(itemKey, true, false)
        if(dbItem.icon==nil) then
          dbItem.icon = GetCurrencyKeyboardIcon(iName)--currencyType
          EchoExperience.debugMsg2("Tracking: icon: ",dbItem.icon)
        end
      end
      if(dbItem.icon==nil) then
        dbItem.icon = GetItemLinkIcon(dbItem.itemLink)
        EchoExperience.debugMsg2("Tracking: nullicon: ",dbItem.icon)
      end
      tempDataLine = {
        link = dbItem.itemLink,
        qty  = dbItem.quantity,
        icon = dbItem.icon,
        name = iName,
        --quality = dbItem.itemQuality,
        --filter = itemTypeFilter,
        --worn = bWorn
      }
      --d("iName="..iName.." icon: " .. GetItemLinkIcon(dbItem.itemLink) )
      table.insert(dataLines, tempDataLine)
      totItems = totItems + (itemCount or 0)
    end 
  elseif(elemListP~=nil) then
    if(elemListP.currency==nil) then
      -- 
    else
      for itemKey, dbItem in pairs(elemListP.currency) do
        --k, v.quantity, v.itemlink
        EchoExperience.debugMsg2("Tracking: currKey: ", itemKey)
        if(dbItem.name==nil) then
          dbItem.name = GetCurrencyName(itemKey, true, false)
          EchoExperience.debugMsg2("Tracking: name: ", dbItem.name)
        end        
        if(dbItem.icon==nil) then
          dbItem.icon = GetCurrencyKeyboardIcon(itemKey)--currencyType
          EchoExperience.debugMsg2("Tracking: icon: ", dbItem.icon)
        end
        --
        tempDataLine = {
          link = dbItem.itemLink,
          qty  = dbItem.quantity,
          icon = dbItem.icon,
          name = dbItem.name,
          --quality = dbItem.itemQuality,
          --filter = itemTypeFilter,
          --worn = bWorn
        }
        if(dbItem.itemLink~=nil)then
          --d("iName="..iName.." icon: " .. GetItemLinkIcon(dbItem.itemLink) )
        end
        table.insert(dataLines, tempDataLine)
        totItems = totItems + (itemCount or 0)
      end
    end
    if(elemListP.items==nil) then
      -- 
    else
      for itemKey, dbItem in pairs(elemListP.items) do
        --k, v.quantity, v.itemlink
        EchoExperience.debugMsg2("Tracking: itemKey: ", itemKey)
        if(dbItem.name==nil) then
          dbItem.name = itemKey
          EchoExperience.debugMsg2("Tracking: name: ", dbItem.name)
        end  
        if(dbItem.icon==nil) then
          dbItem.icon = GetItemLinkIcon(dbItem.itemLink)
          EchoExperience.debugMsg2("Tracking: icon: ", dbItem.icon)
        end
        --
        tempDataLine = {
          link = dbItem.itemLink,
          qty  = dbItem.quantity,
          icon = dbItem.icon,
          name = itemKey,
          --quality = dbItem.itemQuality,
          --filter = itemTypeFilter,
          --worn = bWorn
        }
        if(dbItem.itemLink~=nil)then
          --d("iName="..iName.." icon: " .. GetItemLinkIcon(dbItem.itemLink) )
        end
        table.insert(dataLines, tempDataLine)
        totItems = totItems + (itemCount or 0)
      end
    end
    if(elemListP.mobs==nil) then
      -- 
    else
      for itemKey, dbItem in pairs(elemListP.mobs) do
        --k, v.quantity, v.itemlink
        tempDataLine = {
          link = dbItem.itemLink,
          qty  = dbItem.quantity,
          icon = GetItemLinkIcon(dbItem.itemLink),
          name = itemKey,
          --quality = dbItem.itemQuality,
          --filter = itemTypeFilter,
          --worn = bWorn
        }
        if(dbItem.itemLink~=nil)then
          --d("iName="..iName.." icon: " .. GetItemLinkIcon(dbItem.itemLink) )
        end
        table.insert(dataLines, tempDataLine)
        totItems = totItems + (itemCount or 0)
      end
    end
    --
    if(elemListP.achievements==nil) then
      -- 
    else
      for itemKey, dbItem in pairs(elemListP.achievements) do
        --k, v.quantity, v.itemlink
        --[name] = { earned(date), link, id, points
        tempDataLine = {
          link = dbItem.link,
          qty  = dbItem.points,
          --icon = GetItemLinkIcon(dbItem.itemLink),
          name = itemKey,
          --quality = dbItem.itemQuality,
          --filter = itemTypeFilter,
          --worn = bWorn
        }
        if(dbItem.link~=nil)then
          --d("iName="..iName.." icon: " .. GetItemLinkIcon(dbItem.itemLink) )
        end
        table.insert(dataLines, tempDataLine)
        totItems = totItems + (itemCount or 0)
      end
    end
    
  end--sort or all
  --  
	EOL_GUI_ListHolder.dataLines = dataLines
	EchoExperience:sort(EOL_GUI_ListHolder.dataLines)
	EOL_GUI_ListHolder.dataOffset = 0

	--EOL_GUI_ListHolder_Counts_Items:SetText("Item Count: " .. totItems)
	--EOL_GUI_ListHolder_Counts_Slots:SetText("Appx. Slots Used: " .. #dataLines)
end

function EchoExperience:sort(dataLines)
	if dataLines == nil then dataLines = EOL_GUI_ListHolder.dataLines end

	--if (ScrollSortUp) then
  --TODO dataLines = table.sort(dataLines, IIfA_FilterCompareUp)
  --dataLines = table.sort(dataLines, IIfA_FilterCompareDown)
	--end
end

-- returns true if it had to be resized, otherwise false
function EchoExperience:GuiResizeScroll()
	local regionHeight = EOL_GUI_ListHolder:GetHeight()
  local rowHeight    = EOL_GUI_ListHolder.rowHeight
	local newLines = math.floor(regionHeight / rowHeight)
	if EOL_GUI_ListHolder.maxLines == nil or EOL_GUI_ListHolder.maxLines ~= newLines then
		EOL_GUI_ListHolder.maxLines = newLines
		EchoExperience:GuiResizeLines()
	end
end

function EchoExperience:GuiResizeLines()
	local lines

	if not EOL_GUI_ListHolder.lines then
		lines = EchoExperience:CreateInventoryScroll()
	end
	if EOL_GUI_ListHolder.lines ~= {} then
		lines = EOL_GUI_ListHolder.lines
	end

	for index, line in ipairs(lines) do
--		line.text:SetWidth(textwidth)
--		line:SetWidth(linewidth)
		line:SetHidden(index > EOL_GUI_ListHolder.maxLines)
	end
end

function EchoExperience:CreateInventoryScroll()
	EOL_GUI_ListHolder.dataOffset = 0

	EOL_GUI_ListHolder.dataLines = {}
	EOL_GUI_ListHolder.lines = {}
	EOL_GUI_Header_SortBar.Icon = EOL_GUI_Header_SortBar:GetNamedChild("_Sort"):GetNamedChild("_Icon")
	
	EOL_GUI_ListHolder.maxLines = EchoExperience.defaultMaxLines
	local predecessor = nil
	for i=1, EOL_GUI_ListHolder.maxLines do
		EOL_GUI_ListHolder.lines[i] = EchoExperience:CreateLine(i, predecessor, EOL_GUI_ListHolder)
		predecessor = EOL_GUI_ListHolder.lines[i]
	end

  --
	EchoExperience:SetItemCountPosition()
	-- setup slider
	EOL_GUI_ListHolder_Slider:SetMinMax(0, #EOL_GUI_ListHolder.dataLines - EOL_GUI_ListHolder.maxLines)
  --
	return EOL_GUI_ListHolder.lines
end

function EchoExperience:CreateLine(i, predecessor, parent)
	local line = WINDOW_MANAGER:CreateControlFromVirtual("EOL_ListItem_".. i, parent, "EOL_SlotTemplate")

	line.icon = line:GetNamedChild("Button"):GetNamedChild("Icon")
	line.text = line:GetNamedChild("Name")
	line.qty  = line:GetNamedChild("Qty")
	--line.worn = line:GetNamedChild("IconWorn")
	--line.stolen = line:GetNamedChild("IconStolen")

	line:SetHidden(false)
	line:SetMouseEnabled(true)
	line:SetHeight(EOL_GUI_ListHolder.rowHeight)

	if i == 1 then
		line:SetAnchor(TOPLEFT, EOL_GUI_ListHolder, TOPLEFT, 0, 0)
		line:SetAnchor(TOPRIGHT, EOL_GUI_ListHolder, TOPRIGHT, 0, 0)
	else
		line:SetAnchor(TOPLEFT, predecessor, BOTTOMLEFT, 0, 0)
		line:SetAnchor(TOPRIGHT, predecessor, BOTTOMRIGHT, 0, 0)
	end

	--line:SetHandler("OnMouseEnter", function(self) IIfA:GuiLineOnMouseEnter(self) end )
	--line:SetHandler("OnMouseExit", function(self) IIfA:GuiLineOnMouseExit(self) end )
	--line:SetHandler("OnMouseDoubleClick", function(...) IIfA:GUIDoubleClick(...) end )

	return line
end

function EchoExperience:SetItemCountPosition()
	for i=1, EOL_GUI_ListHolder.maxLines do
		local line = EOL_GUI_ListHolder.lines[i]
		line.text:ClearAnchors()
		line.qty:ClearAnchors()
		--if EchoExperience:GetSettings().showItemCountOnRight then
			line.qty:SetAnchor(TOPRIGHT, line, TOPRIGHT, 0, 0)
			line.text:SetAnchor(TOPLEFT, line:GetNamedChild("Button"), TOPRIGHT, 18, 0)
			line.text:SetAnchor(TOPRIGHT, line.qty, TOPLEFT, -10, 0)
		--[[else
			line.qty:SetAnchor(TOPLEFT, line:GetNamedChild("Button"), TOPRIGHT, 8, -3)
			line.text:SetAnchor(TOPLEFT, line.qty, TOPRIGHT, 18, 0)
			line.text:SetAnchor(TOPRIGHT, line, TOPLEFT, 0, 0)
		end--]]
	end
end

---GUI
------
