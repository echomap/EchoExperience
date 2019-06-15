--[[ Litany Of Blood GUI ]]-- 

--
function EchoExperience:Litany_RefreshInventoryScroll()
	EchoExperience:Litany_UpdateScrollDataLinesData()
	--EchoExperience:Litany_UpdateDataScroll()
end

--
function EchoExperience:Litany_GuiOnScroll(control, delta)  
	if not delta then return end
  EchoExperience.debugMsg("Litany_GuiOnScroll: delta="..tostring(delta) )
	if delta == 0 then return end
  if EOL_GUI_Litany_ListHolder.dataOffset < 0 then EOL_GUI_Litany_ListHolder.dataOffset = 0 end
  
	local slider = EOL_GUI_Litany_ListHolder_Slider
	local value  = (EOL_GUI_Litany_ListHolder.dataOffset - delta)
	local total  = #EOL_GUI_Litany_ListHolder.dataLines - EOL_GUI_Litany_ListHolder.maxLines

	if value < 0 then value = 0 end
	if value > total then value = total end
	EOL_GUI_Litany_ListHolder.dataOffset  = value
  EchoExperience.debugMsg("GuiOnScroll: set dataOffset="..tostring(value) )

  ----Setup max lines, and slider (calls RefreshViewableTable: create show lines based on offset)
	EchoExperience:Litany_UpdateDataScroll()
  
  --Set max, and Hide lines out of the max display
  EchoExperience:Litany_GuiResizeScroll()

	slider:SetValue(EOL_GUI_Litany_ListHolder.dataOffset)

	--EchoExperience:GuiLineOnMouseEnter(moc())
end

-- returns true if it had to be resized, otherwise false
function EchoExperience:Litany_GuiResizeScroll()
	local regionHeight = EOL_GUI_Litany_ListHolder:GetHeight()
  local rowHeight    = EOL_GUI_Litany_ListHolder.rowHeight
	local newLines = math.floor( regionHeight / rowHeight)
	if EOL_GUI_Litany_ListHolder.maxLines == nil or EOL_GUI_Litany_ListHolder.maxLines ~= newLines then
		EOL_GUI_Litany_ListHolder.maxLines = newLines
		EchoExperience:Litany_GuiResizeLines()
	end
end

--
function EchoExperience:Litany_CloseUI()
  EOL_GUI_Litany:SetHidden( not EOL_GUI_Litany:IsHidden() )
end

function EchoExperience:Litany_fillLine(curLine, curItem)
  if(curLine==nil) then return end--??????? TODO
	local color
	if curItem == nil then
		curLine.itemLink = ""
		curLine.btn:SetTexture(nil)
		curLine.btn:SetAlpha(0)
		curLine.name:SetText("")
		curLine.zone:SetText("")
		--curLine.worn:SetHidden(true)
		--curLine.stolen:SetHidden(true)
	else
		local r, g, b, a = 255, 255, 255, 1
		local text = zo_strformat(SI_TOOLTIP_ITEM_NAME, curItem.name)
		curLine.name:SetText(text)
		curLine.name:SetColor(r, g, b, a)
    curLine.zone:SetText( curItem.ZoneName )
		-- -- curLine.qty:SetText(curItem.qty)
		--curLine.worn:SetHidden(not curItem.worn)
		--curLine.stolen:SetHidden(not IsItemLinkStolen(curItem.link))
    --
    if(curItem.done) then
      curLine.btn:SetTexture("esoui\art\buttons\checkbox_checked.dds")
    else
      curLine.btn:SetTexture("esoui\art\buttons\checkbox_unchecked.dds")
    end    
    --curLine.icon:SetAlpha(1)
	end
end

--??
function EchoExperience:Litany_SetDataLinesData()
	local curLine, curData
	for i = 1, EOL_GUI_Litany_ListHolder.maxLines do
		curLine = EOL_GUI_Litany_ListHolder.lines[i]
		curData = EOL_GUI_Litany_ListHolder.dataLines[EOL_GUI_Litany_ListHolder.dataOffset + i]
		EOL_GUI_Litany_ListHolder.lines[i] = curLine

		if( curData ~= nil) then
			EchoExperience:Litany_fillLine(curLine, curData)
		else
			EchoExperience:Litany_fillLine(curLine, nil)
		end
	end
end
--
function EchoExperience:Litany_UpdateDataScroll()
	local index = 0
	if EOL_GUI_Litany_ListHolder.dataOffset < 0 then EOL_GUI_Litany_ListHolder.dataOffset = 0 end
	if EOL_GUI_Litany_ListHolder.maxLines == nil then
		EOL_GUI_Litany_ListHolder.maxLines = EchoExperience.defaultMaxLines --TODO
	end
  --d("UpdateDataScroll: offset="..EOL_GUI_Litany_ListHolder.dataOffset.." maxLines="..EOL_GUI_Litany_ListHolder.maxLines )  
	EchoExperience:Litany_SetDataLinesData()

	local total = #EOL_GUI_Litany_ListHolder.dataLines - EOL_GUI_Litany_ListHolder.maxLines
	EOL_GUI_Litany_ListHolder_Slider:SetMinMax(0, total)
end
--
function EchoExperience:Litany_CreateLine(i, predecessor, parent)
	local line = WINDOW_MANAGER:CreateControlFromVirtual("EOL_Litany_ListItem_".. i, parent, "EOL_Litany_SlotTemplate")

	line.btn = line:GetNamedChild("Button"):GetNamedChild("Icon")
	line.name = line:GetNamedChild("Name")
	line.zone  = line:GetNamedChild("Qty")
	--line.worn = line:GetNamedChild("IconWorn")
	--line.stolen = line:GetNamedChild("IconStolen")

	line:SetHidden(false)
	line:SetMouseEnabled(true)
	line:SetHeight(EOL_GUI_Litany_ListHolder.rowHeight)

	if i == 1 then
		line:SetAnchor(TOPLEFT, EOL_GUI_Litany_ListHolder, TOPLEFT, 0, 0)
		line:SetAnchor(TOPRIGHT, EOL_GUI_Litany_ListHolder, TOPRIGHT, 0, 0)
	else
		line:SetAnchor(TOPLEFT, predecessor, BOTTOMLEFT, 0, 0)
		line:SetAnchor(TOPRIGHT, predecessor, BOTTOMRIGHT, 0, 0)
	end

	--line:SetHandler("OnMouseEnter", function(self) IIfA:GuiLineOnMouseEnter(self) end )
	--line:SetHandler("OnMouseExit", function(self) IIfA:GuiLineOnMouseExit(self) end )
	--line:SetHandler("OnMouseDoubleClick", function(...) IIfA:GUIDoubleClick(...) end )

	return line
end

--
function EchoExperience:Litany_CreateInventoryScroll()
	EOL_GUI_Litany_ListHolder.dataOffset = 0

	EOL_GUI_Litany_ListHolder.dataLines = {}
	EOL_GUI_Litany_ListHolder.lines = {}
	--EOL_GUI_Header_SortBar.Icon = EOL_GUI_Header_SortBar:GetNamedChild("_Sort"):GetNamedChild("_Icon")
	
	EOL_GUI_Litany_ListHolder.maxLines = EchoExperience.defaultMaxLines
	local predecessor = nil
	for i=1, EOL_GUI_Litany_ListHolder.maxLines do
		EOL_GUI_Litany_ListHolder.lines[i] = EchoExperience:Litany_CreateLine(i, predecessor, EOL_GUI_Litany_ListHolder)
		predecessor = EOL_GUI_Litany_ListHolder.lines[i]
	end
  --
	EchoExperience:Litany_SetItemCountPosition()
	-- setup slider
	EOL_GUI_Litany_ListHolder_Slider:SetMinMax(0, #EOL_GUI_Litany_ListHolder.dataLines - EOL_GUI_Litany_ListHolder.maxLines)
  --
	return EOL_GUI_Litany_ListHolder.lines
end

--
function EchoExperience:Litany_SetItemCountPosition()
	for i=1, EOL_GUI_Litany_ListHolder.maxLines do
		local line = EOL_GUI_Litany_ListHolder.lines[i]
		line.name:ClearAnchors()
		line.zone:ClearAnchors()
		--if EchoExperience:GetSettings().showItemCountOnRight then
			line.zone:SetAnchor(TOPRIGHT, line, TOPRIGHT, 0, 0)
			line.name:SetAnchor(TOPLEFT, line:GetNamedChild("Button"), TOPRIGHT, 18, 0)
			line.name:SetAnchor(TOPRIGHT, line.zone, TOPLEFT, -10, 0)
		--[[else
			line.qty:SetAnchor(TOPLEFT, line:GetNamedChild("Button"), TOPRIGHT, 8, -3)
			line.text:SetAnchor(TOPLEFT, line.qty, TOPRIGHT, 18, 0)
			line.text:SetAnchor(TOPRIGHT, line, TOPLEFT, 0, 0)
		end--]]
	end
end

--
function EchoExperience:Litany_GuiResizeLines()
	local lines

	if not EOL_GUI_Litany_ListHolder.lines then
		lines = EchoExperience:Litany_CreateInventoryScroll()
	end
	if EOL_GUI_Litany_ListHolder.lines ~= {} then
		lines = EOL_GUI_Litany_ListHolder.lines
	end

	for index, line in ipairs(lines) do
		line:SetHidden(index > EOL_GUI_Litany_ListHolder.maxLines)
	end
end

--
function EchoExperience:Litany_UpdateScrollDataLinesData()
  local tempDataLine = nil
	local dataLines = {}
  local itemCount = 0
  
  local elemListS = nil
  elemListS = EchoExperience.savedVariables.LitanyOfBlood
  if(elemListS~=nil) then
    for iName, dbItem in pairs(elemListS) do
      --k, v.done, v.ZoneName, v.SubzoneName
      tempDataLine = {
        ZoneName    = dbItem.ZoneName,
        SubzoneName = dbItem.SubzoneName,
        name = iName,
      }
      --d("iName="..iName );
      table.insert(dataLines, tempDataLine)
      itemCount = itemCount + 1
    end 
  end 

	EOL_GUI_Litany_ListHolder.dataLines = dataLines
	EchoExperience:sort(EOL_GUI_Litany_ListHolder.dataLines)
	EOL_GUI_Litany_ListHolder.dataOffset = 0

	--EOL_GUI_Litany_ListHolder_Counts_Items:SetText("Item Count: " .. totItems)
	--EOL_GUI_Litany_ListHolder_Counts_Slots:SetText("Appx. Slots Used: " .. #dataLines)
end

function EchoExperience:Litany_onResizeStart()
	EVENT_MANAGER:RegisterForUpdate(EchoExperience.name.."OnWindowResize", 50, 
    function()
      EchoExperience:Litany_UpdateScrollDataLinesData()
      EchoExperience:Litany_GuiResizeScroll()
      EchoExperience:Litany_UpdateDataScroll()
    end)
end

function EchoExperience:Litany_onResizeStop()
	EVENT_MANAGER:UnregisterForUpdate(EchoExperience.name.."OnWindowResize")
	EchoExperience:Litany_SaveFrameInfo("onResizeStop")
	EchoExperience:Litany_GuiResizeScroll()	
  EchoExperience:Litany_UpdateDataScroll()
end

function EchoExperience:Litany_SaveFrameInfo(calledFrom)
	if (calledFrom == "onHide") then return end
  if(EchoExperience.savedVariables.LitanyFrame==null)then
    EchoExperience.savedVariables.LitanyFrame = {}
  end
  EchoExperience.savedVariables.LitanyFrame.lastX	 = EOL_GUI_Litany:GetLeft()
  EchoExperience.savedVariables.LitanyFrame.lastY	 = EOL_GUI_Litany:GetTop()
  EchoExperience.savedVariables.LitanyFrame.width	 = EOL_GUI_Litany:GetWidth()
  EchoExperience.savedVariables.LitanyFrame.height = EOL_GUI_Litany:GetHeight()
end
--
function EchoExperience:Litany_SaveFramePosition(calledFrom)
  if(EchoExperience.savedVariables.LitanyFrame==null)then
    EchoExperience.savedVariables.LitanyFrame = {}
  end
  EchoExperience.savedVariables.LitanyFrame.lastX	= EOL_GUI_Litany:GetLeft()
  EchoExperience.savedVariables.LitanyFrame.lastY	= EOL_GUI_Litany:GetTop()
end
--
function EchoExperience:Litany_GuiOnSliderUpdate(slider, value)
  EchoExperience.debugMsg("GuiOnSliderUpdate: Called, w/value="..tostring(value)  )
	--if not value or slider.locked then return end
	local relativeValue = math.floor(EOL_GUI_Litany_ListHolder.dataOffset - value)
  EchoExperience.debugMsg("GuiOnSliderUpdate: relativeValue=" ..tostring(relativeValue) .. " value="..tostring(value) .. " offset="..tostring(EOL_GUI_Litany_ListHolder.dataOffset)  )
	EchoExperience:Litany_GuiOnScroll(slider, relativeValue)
end


--TOOLTIP
function EchoExperience:Litany_Misc2HeaderTipEnter(sender,key)
  InitializeTooltip(EEXPLitanyTooltip, sender, TOPLEFT, 5, -56, TOPRIGHT)
  EOLTooltip:AddLine(key, "ZoFontHeader3")
end
function EchoExperience:Litany_Misc2HeaderTipExit(sender)
  --ClearTooltip(InformationTooltip)
  ClearTooltip(EEXPLitanyTooltip)
end
