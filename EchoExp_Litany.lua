--[[ ------------------- ]]--
--[[ Litany Of Blood GUI ]]-- 
--[[ ------------------- ]]--

------------------------------
-- LitanyUI
function EchoExperience:Litany_SetupUI()
  local customSettings = {
    sortEnabled = true,
    leftList = {
        title = "Alive",
    },
    rightList = {
        title = "Killed",
    }
  }
  if(EchoExperience.view.shifterBox==nil) then
    EchoExperience.view.shifterBox = LibShifterBox(EchoExperience.name, "LItany Of Blood", EOL_GUI_Litany_ListHolder, customSettings)
    -- required to correctly position/anchor it in your UI
    EchoExperience.view.shifterBox:SetAnchor(TOPLEFT, EOL_GUI_Litany_ListHolder, TOPLEFT, 15, 10) --there can be only one!
    --EchoExperience.view.shifterBox:SetAnchor(BOTTOMRIGHT, EOL_GUI_Litany_ListHolder, BOTTOMRIGHT, 10, 10)
    -- optionally set your own overall dimensions of the shifterBox
    EchoExperience.view.shifterBox:SetDimensions(620, 250) 
    -- add three entries to the left list
    --EchoExperience.view.shifterBox:AddEntriesToLeftList({[1] = "AAA", [2] = "BBB", [3] = "CCC"}) 
    -- add one entry to the right list
    --EchoExperience.view.shifterBox:AddEntryToRightList(4, "DDD")
    --TODO scan achievements?
    EchoExperience.view.shifterBox:RegisterCallback( LibShifterBox.EVENT_ENTRY_HIGHLIGHTED, EchoExperience.myEntryHighlightedFunction )
  else
    --EchoExperience.view.shifterBox:MoveAllEntriesToLeftList()
    --EchoExperience.view.shifterBox:GetLeftListEntriesFull
  end
  --
  EchoExperience.view.shifterBox:ClearLeftList()
  EchoExperience.view.shifterBox:ClearRightList()
  --
  -- Regenerate list, or we could fix lists dynamically.... TODO
  EchoExperience.view.shifterBoxHints = {}
  --LEFT
  for k, v in pairs(EchoExperience.LitanyOfBlood.list) do
    local ltext = zo_strformat( "<<1>> (<<2>>/<<3>>)[<<4>>]", k, v.ZoneName, v.SubZoneName, v.coord )
    if( EchoExperience.savedVariables.LitanyOfBloodDone[k] == nil ) then
      EchoExperience.view.shifterBox:AddEntryToLeftList(v.id, ltext )
    end
    EchoExperience.view.shifterBoxHints[ltext] = v.tooltip
  end
  --RIGHT
  local entryId = 1
  for k, v in pairs(EchoExperience.savedVariables.LitanyOfBloodDone) do
    --local ltext = zo_strformat( "<<1>> (<<2>>)", k, v.zonename)
    local ltext = zo_strformat( "<<1>> (<<2>>/<<3>>)[<<4>>]", k, v.zonename, v.subzonename, v.coord )
    if(v.id == nil or ltext == nil or ltext ==" ") then
        EchoExperience.savedVariables.LitanyOfBloodDone[k] = nil
    else
      EchoExperience.view.shifterBox:AddEntryToRightList(v.id, ltext )
    end
  end
    
  --EOL_GUI_Litany_Header_BtnClose:SetFocus()
end

------------------------------
-- LitanyUI
function EchoExperience:Litany_GuiOnScroll()
  
end

------------------------------
-- LitanyUI
function EchoExperience:Litany_CloseUI()
  EOL_GUI_Litany:SetHidden( not EOL_GUI_Litany:IsHidden() )
end

------------------------------
-- LitanyUI
--TOOLTIP
function EchoExperience:Litany_Misc2HeaderTipEnter(sender,key)
  InitializeTooltip(EEXPLitanyTooltip, sender, TOPLEFT, 5, -56, TOPRIGHT)
  EEXPLitanyTooltip:AddLine(key, "ZoFontHeader3")
end

------------------------------
-- LitanyUI
--TOOLTIP
function EchoExperience:Litany_Misc2HeaderTipExit(sender)
  --ClearTooltip(InformationTooltip)
  ClearTooltip(EEXPLitanyTooltip)
end

------------------------------
-- LitanyUI
function EchoExperience:Litany_onResizeStart()
	EVENT_MANAGER:RegisterForUpdate(EchoExperience.name.."OnWindowResize", 50, 
    function()
      EchoExperience:Litany_UpdateScrollDataLinesData()
      EchoExperience:Litany_GuiResizeScroll()
      EchoExperience:Litany_UpdateDataScroll()
    end)
end

------------------------------
-- LitanyUI
function EchoExperience:Litany_onResizeStop()
	EVENT_MANAGER:UnregisterForUpdate(EchoExperience.name.."OnWindowResize")
	EchoExperience:Litany_SaveFrameInfo("onResizeStop")
	EchoExperience:Litany_GuiResizeScroll()	
  EchoExperience:Litany_UpdateDataScroll()
end

function EchoExperience:Litany_GuiResizeScroll()
end
function EchoExperience:Litany_UpdateDataScroll()
end

------------------------------
-- LitanyUI
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

------------------------------
-- LitanyUI
function EchoExperience:Litany_SaveFramePosition(calledFrom)
  if(EchoExperience.savedVariables.LitanyFrame==null)then
    EchoExperience.savedVariables.LitanyFrame = {}
  end
  EchoExperience.savedVariables.LitanyFrame.lastX	= EOL_GUI_Litany:GetLeft()
  EchoExperience.savedVariables.LitanyFrame.lastY	= EOL_GUI_Litany:GetTop()
end

------------------------------
-- LitanyUI
function EchoExperience:Litany_SaveAchievements(btn)
  EchoExperience.debugMsg("Litany_SaveAchievements: btn="..tostring(btn) .. "idx:"..tostring(idx)  )  
  --get right list.
  --add those to done list: EchoExperience.savedVariables.LitanyOfBloodDone[k]
  --from "EchoExperience.LitanyOfBlood.list" data
  local righttable = EchoExperience.view.shifterBox:GetRightListEntries(false)
  EchoExperience.savedVariables.LitanyOfBloodDone = {}
  for k, v in pairs(righttable) do
    local dv = EchoExperience.LitanyOfBlood.list[k]
    EchoExperience.savedVariables.LitanyOfBloodDone[k] = dv
  end
end

------------------------------
-- LitanyUI
function EchoExperience:Litany_ScanAchievements(btn)
  EchoExperience.outputMsg("Starting scan of achieves for Litany of Blood")
  for topLevelIndex = 1, GetNumAchievementCategories() do
    local cname, numSubCatgories, numAchievements, earnedPoints, totalPoints, hidesPoints = GetAchievementCategoryInfo(topLevelIndex)
    if("Dark Brotherhood" == cname) then
      EchoExperience.debugMsg2("-Category: " , cname)
      for achievementIndex = 1, numAchievements do
        local achievementId = GetAchievementId(topLevelIndex, nil, achievementIndex) --(Nil subcat,,, ie: General)
        achievementIndex = achievementIndex + 1
        local aname, description, points, icon, completed, date, time = GetAchievementInfo(achievementId)
        if("Litany of Blood" == aname) then    
          EchoExperience.debugMsg2("-name: " , aname)
          if(completed) then
            --
          else
          end
          local numCriteria = GetAchievementNumCriteria(achievementId)
          for criteriaIndex = 1, numCriteria do
            local description, numCompleted, numRequired =  GetAchievementCriterion(achievementId, criteriaIndex)
            if(numCompleted == numRequired) then
              EchoExperience.debugMsg2("-Criteria: description: " .. description)
              --"Slay the Target in <<1>> with the Blade of Woe
              local match2 = string.match(description, 'Slay the Target in (.+) with the Blade of Woe')
              EchoExperience.debugMsg2("-Criteria: zone to match: '" , tostring(match2) , "'" )
              --match list for SubZoneName
              for k, v in pairs(EchoExperience.LitanyOfBlood.list) do
                if( v.ZoneName == match2 or v.SubZoneName == match2 ) then
                  local sentence = GetString(SI_ECHOEXP_LITANY_SCANFOUND)
                  local val = zo_strformat( sentence, k, v.SubZoneName )
                  EchoExperience.outputMsg(val)
                  local targetName = k
                  EchoExperience.savedVariables.LitanyOfBloodDone[targetName] = {}
                  EchoExperience.savedVariables.LitanyOfBloodDone[targetName].time = GetTimeStamp()
                  EchoExperience.savedVariables.LitanyOfBloodDone[targetName].id   = v.id
                  EchoExperience.savedVariables.LitanyOfBloodDone[targetName].zonename     = v.ZoneName
                  EchoExperience.savedVariables.LitanyOfBloodDone[targetName].subzonename  = v.SubZoneName
                  EchoExperience.savedVariables.LitanyOfBloodDone[targetName].tooltip      = v.tooltip
                end
              end--if done
            end
          end
        end
      end--achieve
    end--darkbrothers
  end--top
  EchoExperience:Litany_SetupUI()
  EchoExperience.outputMsg("Done scan of achieves for Litany of Blood")
end

-- @param control object referencing the entry/row that has been highlighted
-- @param shifterBox object referencing the shifterBox that triggered this event
-- @param key string with the key of the highlighted entry
-- @param value string with the (displayed) value of the highlighted entry
-- @categoryId string with the category of the highlighted entry (can be nil)
-- @isLeftList boolean whether the highlighted entry is in the left listBox
function EchoExperience:myEntryHighlightedFunction(control, shifterBox, key, value, categoryId, isLeftList)
  -- do something
  local tt = EchoExperience.view.shifterBoxHints[key]
  EOL_GUI_Litany_HintText:SetText( tt )
end


------------------------------
-- LitanyUI
-- LitanyUI
--
function EchoExperience:Litany_DoSelectedButtonClicked(btn,idx,curline,curItem)
  EchoExperience.debugMsg("OnClicked: btn="..tostring(btn) .. "idx:"..tostring(idx)  )  
  EchoExperience.debugMsg("OnClicked: curItem Name: "..tostring(curItem.name) .. " ZoneName: "..tostring(curItem.ZoneName) .. " Done: "..tostring(curItem.done) )
  
  curItem.done = not curItem.done
  EchoExperience.debugMsg("OnClicked: Done? Name: "..tostring(curItem.name) .. " Done: "..tostring(curItem.done) )
  local foundItem = EchoExperience.LitanyOfBlood.list[curItem.name]
  EchoExperience.savedVariables.LitanyOfBloodDone[curItem.name] = GetTimeStamp()  
  
  --if(curItem.do ne) then
  btn:SetNormalTexture("esoui\art\buttons\checkbox_checked.dds")
      --local btnIcon  = btn:GetNamedChild("Icon")
      --if(btnIcon~=nil) then
      --  btnIcon:SetTexture("esoui\art\buttons\checkbox_checked.dds")
      --end
  --else
      --btn:SetNormalTexture("esoui\art\buttons\checkbox_unchecked.dds")
      --local btnIcon  = btn:GetNamedChild("Icon")
      --if(btnIcon~=nil) then
      --  btnIcon:SetTexture("esoui\art\buttons\checkbox_unchecked.dds")
      --end
  --end

end



--[[ ------------------- ]]--
--[[ Litany Of Blood GUI ]]-- 
--[[ ------------------- ]]--