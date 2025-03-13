---------------------------------
--[[ EchoExp : EVENTS        ]]-- 
---------------------------------

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
  EchoExperience.debugMsg2("OnSkillExperienceUpdateWork:"
      , " name="..tostring(skillLineName)
      , " rank="..tostring(currentSkillRank)
      , " available="..tostring(available)
    )
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
      --TODO skillLineNameI = zo_strformat(
			skillLineNameI = "|t14:14:"..normal.."|t" .. skillLineName
		end
    skillLineNameI = zo_strformat("<<1>> [<<2>>]",skillLineNameI, currentSkillRank)
		--EchoExperience.outputToChanel("skillLineNameI '"..skillLineNameI.."'", EchoExperience.staticdata.msgTypeEXP)
		local strL = zo_strformat(strI, ZO_CommaDelimitNumber(XPgain), skillLineNameI, ZO_CommaDelimitNumber(curCur), ZO_CommaDelimitNumber(curNext), ZO_CommaDelimitNumber(diff) )
		EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
		--EchoExperience.outputToChanel("Gained "..XPgain.."xp in [" ..skillLineName.."] ("..curCur.."/"..curNext..") need " .. diff .. "xp",EchoExperience.staticdata.msgTypeEXP)
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
			EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
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
	EchoExperience.outputToChanel(strI.." eventcode="..tostring(eventCode),EchoExperience.staticdata.msgTypeEXP)
	--EchoExperience.outputToChanel("You unlocked Champion points!".." eventcode="..tostring(eventCode),EchoExperience.staticdata.msgTypeEXP)
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
      , " aIdx="..tostring(abilityIndex)
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
		EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
    EchoExperience.ExpHistory(name2,currentXP,nextRankXP,diff,thisGain, texture )
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
    EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP) 
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
  EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
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
    EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
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
	EchoExperience.debugMsg2("OnDiscovery:",
		"areaName:",tostring(areaName),
		"level:",tostring(level)
	)
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
    EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
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
		EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
	end
	if pointsBefore~=nil and partialPointsNow~=nil and pointsNow > pointsBefore then
		EchoExperience.debugMsg2("echoexp(ospc test): eventCode=", tostring(eventCode))
		local diff =  pointsNow - pointsBefore
		local strI = GetString(SI_ECHOEXP_SKY_2)
		--local strI = "You gained a skill point! (<<1>>)."
		local strL = zo_strformat(strI, diff )
		EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
	end
	--[[
	if partialPointsBefore~=nil and partialPointsNow~=nil and partialPointsBefore==2 and partialPointsNow=0 then
		--local strI = GetString(SI_ECHOEXP_SKILL_GAIN)
		local strI = "You absorbed a skyshard <<1>> of <<2>>."
		local strL = zo_strformat(strI,pointsBefore, pointsNow )
		--EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
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
		EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeEXP)
		--EchoExperience.outputToChanel("You subtracted " .. Ldifference .. " AP.",EchoExperience.staticdata.msgTypeEXP)
	else
		--FORMAT
		local strI = GetString(SI_ECHOEXP_AP_GAIN)
		local strL = zo_strformat(strI, ZO_CommaDelimitNumber(difference) )
		EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
		--EchoExperience.outputToChanel("You gained " .. difference .. " AP.",EchoExperience.staticdata.msgTypeEXP)
	end
	--EchoExperience.debugMsg("OnAlliancePtGain Done")
end

--EVENT_CHAMPION_POINT_GAINED
function EchoExperience.OnChampionPointGain()
		local strI = GetString(SI_ECHOEXP_CP_EARNED)
		local strL = zo_strformat(strI, 1)
		EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
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
    EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
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
  if( IsChampionSystemUnlocked() and CanUnitGainChampionPoints("player") ) then 
    EchoExperience.OnExperienceUpdateCP(eventCode, unitTag, currentExp, maxExp, reason)
  else
    --is it only working sub 50?
    if(EchoExperience.savedVariables.currentExp == nil or EchoExperience.savedVariables.currentExp<0 ) then
      -- Can't report on what we don't know.
    else
      if( EchoExperience.view.startexptracking and EchoExperience.view.exptracking.startexp<0) then
        EchoExperience.view.exptracking.startexp = currentExp
      end
      if( not EchoExperience.view.startexptracking and EchoExperience.view.exptracking ~= nil) then
        EchoExperience.view.exptracking.endexp = currentExp
        EchoExperience.EndExperienceTracking()
      end      
      
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
        EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
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
          EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
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
  
	EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
	--EchoExperience.outputToChanel("You gained " .. XPgain .. " experience.",EchoExperience.staticdata.msgTypeEXP)
	if(championPoints) then
    --this reports what CP you curently have! not a gain!
		--local sentence = GetString(SI_ECHOEXP_CP_EARNED2)
		--local strL = zo_strformat(sentence, championPoints)
		--EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeEXP)
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
  --if( IsBankOpen() or IsGuildBankOpen() ) then
    --Don't report as should be in another method
  --end
  
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
  EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeLOOT)
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
	EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeLOOT)
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
	EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeLOOT)
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
	EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeLOOT)
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
function EchoExperience.OnMailTakeAttachedItemOk(eventCode,mailId)
  EchoExperience.debugMsg2("OnMailTakeAttachedItemOk: "
			, " eventCode="  , tostring(eventCode)
			, " mailId=" , tostring(mailId)
		)
  -- ZO_MailInboxShared_PopulateMailData(self:GetMailData(self.mailId), mailId)
  --GetAttachedItemLink(id64 mailId, number attachIndex, number LinkStyle linkStyle)
  --  Returns: string link   
  --GetMailAttachmentInfo
  --GetMailItemInfo
  --GetMailSender
  --GetAttachedItemInfo
end

------------------------------
-- EVENT
--EVENT_MAIL_TAKE_ATTACHED_MONEY_SUCCESS (number eventCode, id64 mailId) 
function EchoExperience.OnMailTakeAttachedMoneyOk(eventCode,mailId)
  EchoExperience.debugMsg2("OnMailTakeAttachedMoneyOk: "
			, " eventCode="  , tostring(eventCode)
			, " mailId=" , tostring(mailId)
		)
end

------------------------------
-- EVENT
--EVENT_MAIL_ATTACHMENT_ADDED (number eventCode, number attachmentSlot)
function EchoExperience.OnMailCreateAttachAdd(eventCode,attachmentSlot)
  EchoExperience.debugMsg2("OnMailCreateAttachAdd: "
    , " eventCode="  , tostring(eventCode)
    , " attachmentSlot=" , tostring(attachmentSlot)
  )
  
  -- Returns: number bagId, number slotIndex, textureName icon, number stack
  local bagId, slotIndex, icon, stack = GetQueuedItemAttachmentInfo(attachmentSlot)
  -- Returns: string link
  local link = GetMailQueuedAttachmentLink(attachmentSlot)--, linkStyle)
  EchoExperience.debugMsg2("OnMailCreateAttachAdd: "
    , " link="  , link
  )

end

------------------------------
-- EVENT
--EVENT_MAIL_ATTACHMENT_REMOVED (number eventCode, number attachmentSlot)
function EchoExperience.OnMailCreateAttachRem(eventCode,attachmentSlot)
  EchoExperience.debugMsg2("OnMailCreateAttachRem: "
			, " eventCode="  , tostring(eventCode)
			, " attachmentSlot=" , tostring(attachmentSlot)
		)
    local link = GetMailQueuedAttachmentLink(attachmentSlot)--, linkStyle)
  EchoExperience.debugMsg2("OnMailCreateAttachRem: "
    , " link="  , link
  )
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
  EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeLOOT)
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
      EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeLOOT)
      return
    end
    --withdrawls from the bank have no itemlink, but throw another event with the backpack... caught below
  end
  
  -- New Set Collections 1000033
  local collectionString = ""
  if(EchoExperience.savedVariables.lootshowsetcollection) then
    local itemId = GetItemLinkItemId(itemLink)
    local hasSet = GetItemLinkSetInfo(itemLink)
    --Check if crafted TODO
    local isCrafted = IsItemLinkCrafted(itemLink)
    local isCollected = false
    if(hasSet and not isCrafted) then
      isCollected = IsItemSetCollectionPieceUnlocked(itemId)
      if(isCollected) then
        collectionString = GetString(SI_ECHOEXP_SETCOLLECTION_COLLECTED)
      else
        collectionString = GetString(SI_ECHOEXP_SETCOLLECTION_NOTCOLLECTED)
      end
    end
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
  --TODO if(EchoExperience.savedVariables.lootshowtrait) then
    
  --end  

  local totalBagCount = GetItemTotalCount(bagId, slotId)
  --textureName icon, number stack, number sellPrice, boolean meetsUsageRequirement, boolean locked, number EquipType equipType, number itemStyleId, number ItemQuality quality = GetItemInfo(number Bag bagId, number slotIndex)
  --For some reason these bags do NOT report count
  --TODO to show count? use verbose setting or EchoExperience.savedVariables.extendedLoot ?
  if(not hasTraitInfo and EchoExperience.savedVariables.extendedLoot and bagId ~= BAG_SUBSCRIBER_BANK and bagId ~= BAG_VIRTUAL) then
    qualifier = qualifier + 4
    --traitName
  end
  --
  local armorType = GetItemArmorType(bagId, slotId)
  if(armorType~=ARMORTYPE_NONE) then
    if(armorType == ARMORTYPE_HEAVY) then
      armorType = "H"
    elseif(armorType == ARMORTYPE_MEDIUM) then
      armorType = "M"
    elseif(armorType == ARMORTYPE_LIGHT) then
      armorType = "L"
    end
    traitName = zo_strformat("<<1>> [<<2>>]", traitName, armorType)
  end
  
  -- Output
  
 --ItemQuality
  local showSL = true
  EchoExperience.debugMsg2("CHECK self: quality setting A:=" , EchoExperience.savedVariables.lootselfqualityid )
  EchoExperience.debugMsg2("CHECK self: quality setting B:=" , EchoExperience.savedVariables.lootselfqualityname )
  if(EchoExperience.savedVariables.lootselfqualityid~=nil) then
    local itemQuality = GetItemLinkQuality(itemLink)
    EchoExperience.debugMsg2("CHECK self: itemQuality:=" , itemQuality  )
    showSL = false
    if(itemQuality>=EchoExperience.savedVariables.lootselfqualityid) then
      showSL = true
    end
    EchoExperience.debugMsg2("OnInventorySingleSlotUpdate: "
      , " lootselfqualityid="   , tostring(EchoExperience.savedVariables.lootselfqualityid)
      , " itemQuality="     , tostring(itemQuality)      
      , " showSL="   , tostring(showSL)
    )
  end
  if(showSL) then
     EchoExperience.debugMsg2("OnInventorySingleSlotUpdate: "
      , " isNewItem="    , isNewItem
	  , " stackCountChange=" , stackCountChange
	  , " qualifier="    , qualifier
      , " IsBankOpen()=" , IsBankOpen()    
      , " IsGuildBankOpen()=" , IsGuildBankOpen() 
    )
    if(isNewItem) then
      local sentence = GetString("SI_ECHOLOOT_RECEIVE_", qualifier)
      local strL = zo_strformat(sentence, icon, itemLink, stackCountChange, traitName, totalBagCount, collectionString )
      EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeLOOT)
      --EchoExperience:LootHistory(itemLink,stackCountChange)
    elseif( stackCountChange~=0 and ( IsBankOpen() or IsGuildBankOpen() ) ) then
		local sentence = GetString("SI_ECHOLOOT_BANK_GET_", qualifier)
		EchoExperience.debugMsg2("OnInventorySingleSlotUpdate: ", " sentence=" , tostring(sentence) )
		local strL = zo_strformat(sentence, icon, itemLink, stackCountChange, traitName, totalBagCount, collectionString )
		EchoExperience.debugMsg2("OnInventorySingleSlotUpdate: ", " strL=" , tostring(strL) )
		EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeLOOT)
    end
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
	if lootType ~= nil and lootType ~= LOOT_TYPE_MONEY and lootType ~= LOOT_TYPE_QUEST_ITEM and lootType ~= LOOT_TYPE_ANTIQUITY_LEAD then
		--if itemType ~= ITEMTYPE_ARMOR_TRAIT and itemType ~= ITEMTYPE_WEAPON_TRAIT -- lootType ~= LOOT_TYPE_COLLECTIBLE
		local traitName, setName = EchoExperience:GetExtraInfo(itemName)
		if( traitName ~= nil and setName ~= nil and traitName ~= "" and setName ~= "") then
			extraInfo = string.format("(%s) %s set",traitName, setName)
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
  --Tracking
  if(isSelf) then
    EchoExperience:LootHistory(itemName,quantity)
  else
    EchoExperience:LootHistory(itemName,quantity,receivedBy)
  end
  
  local icon = GetItemLinkIcon(itemName)
  --local itemLink  = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
  local accountName = EchoExperience.currentPartyMembers[ tostring(receivedBy) ]
  EchoExperience.debugMsg2("OnLootReceivedWork: "
    .." accountName='"    .. tostring(accountName) .."'"
	.." receivedBy='"     .. tostring(receivedBy)  .."'"
  )  
  --
  if(isSelf) then
 
    --I can't remember why this... TODO derp
    if( not EchoExperience.savedVariables.extendedLoot and quantity>0 ) then
      --
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

     --ItemQuality
      local showSL = true
      EchoExperience.debugMsg2("CHECK self: quality setting A:=" , EchoExperience.savedVariables.lootselfqualityid )
      EchoExperience.debugMsg2("CHECK self: quality setting B:=" , EchoExperience.savedVariables.lootselfqualityname )
      if(EchoExperience.savedVariables.lootselfqualityid~=nil) then
        local itemQuality = GetItemLinkQuality(itemName)
        EchoExperience.debugMsg2("CHECK self: itemQuality:=" , itemQuality  )
        showSL = false
        if(itemQuality>=EchoExperience.savedVariables.lootselfqualityid) then
          showSL = true
        end
        EchoExperience.debugMsg2("OnLootReceived: "
          , " lootselfqualityid="   , tostring(EchoExperience.savedVariables.lootselfqualityid)
          , " itemQuality="     , tostring(itemQuality)      
          , " showSL="   , tostring(showSL)
        )
      end
      if(showSL) then
        -- output: if isSelf and not extendedLoot
        local sentence = GetString("SI_ECHOLOOT_YOU_GAIN_",qualifier)
        if(isPickpocketLoot) then
          sentence = GetString("SI_ECHOLOOT_YOU_PICK_",qualifier)
        elseif(lootType==LOOT_TYPE_QUEST_ITEM)then
          sentence = GetString("SI_ECHOLOOT_YOU_QUEST_",qualifier)
        end
        local strL = zo_strformat(sentence, icon, itemName, quantity, extraInfo)
        EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeLOOT)
            
      end--show quality
    end --isSelf and not extendedLoot
  elseif (EchoExperience.savedVariables.groupLoot and receivedBy~=nil) then
    --ItemQuality
    --TODO account name?
    local showGL = true
    EchoExperience.debugMsg2("CHECK OTHER: quality setting A:=" , EchoExperience.savedVariables.lootgroupqualityid )
    EchoExperience.debugMsg2("CHECK OTHER: quality setting B:=" , EchoExperience.savedVariables.lootgroupqualityname )
    if(EchoExperience.savedVariables.lootgroupqualityid~=nil) then
      local itemQuality = GetItemLinkQuality(itemName)
      EchoExperience.debugMsg2("CHECK OTHER: itemQuality:=" , itemQuality  )
      showGL = false
      if(itemQuality>=EchoExperience.savedVariables.lootgroupqualityid) then
        showGL = true
      end
      EchoExperience.debugMsg2("OnLootReceived: "
        , " lootgroupqualityid="   , tostring(EchoExperience.savedVariables.lootgroupqualityid)
        , " itemQuality="     , tostring(itemQuality)      
        , " showGL="   , tostring(showGL)
      )
    end
    if(showGL) then
      -- New Set Collections 1000033
      local collectionString = ""
      if(EchoExperience.savedVariables.lootshowsetcollection) then
        local itemId = GetItemLinkItemId(itemName)
        local hasSet = GetItemLinkSetInfo(itemName)
        --Check if crafted TODO
        local isCrafted = IsItemLinkCrafted(itemName)
        local isCollected = false
        if(hasSet and not isCrafted) then
          isCollected = IsItemSetCollectionPieceUnlocked(itemId)
          if(isCollected) then
            collectionString = GetString(SI_ECHOEXP_SETCOLLECTION_COLLECTED)
          else
            collectionString = GetString(SI_ECHOEXP_SETCOLLECTION_NOTCOLLECTED)
          end
        end
      end
      
      --if NOT self and IS groupLoot and has a receievedby value
      local qualifier = 1
      if(quantity>1) then qualifier = 2 end
      local sentence = GetString("SI_ECHOLOOT_OTHER_GAIN_", qualifier)
      if(isPickpocketLoot) then
        sentence = GetString("SI_ECHOLOOT_OTHER_PICK_", qualifier)
      elseif(lootType==LOOT_TYPE_QUEST_ITEM) then
        sentence = GetString("SI_ECHOLOOT_OTHER_QUEST_", qualifier)
      end
	  local rby = receivedBy
	  if(accountName~=nil and EchoExperience.savedVariables.useaccountnamepref ) then
		rby = accountName
	  end
      local strL = zo_strformat(sentence, rby, icon, itemName, quantity, extraInfo, collectionString)
      EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeLOOT)
    end
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
  filter.type    = EchoExperience.staticdata.msgTypeGUILD2
  filter.guildID = guildID
  filter.guildId = EchoExperience:GetGuildId(guildID)
  EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeGUILD2,filter) 
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
 --TESTING
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
  filter.type    = EchoExperience.staticdata.msgTypeGUILD2
  filter.guildID = guildID
  filter.guildId = EchoExperience:GetGuildId(guildID)
  EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeGUILD2,filter) 
end

------------------------------
-- EVENT
--EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED (integer GuildID,string PlayerName,luaindex prevStatus,luaindex curStatus)
--["PLAYER_STATUS_AWAY"] = 2 ["PLAYER_STATUS_DO_NOT_DISTURB"] = 3
--["PLAYER_STATUS_OFFLINE"] = 4 ["PLAYER_STATUS_ONLINE"] = 1 
function EchoExperience.OnGuildMemberStatusChanged(eventCode,guildID,playerName,prevStatus,curStatus)
  --
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
      filter.type = EchoExperience.staticdata.msgTypeGUILD
      filter.guildID = guildID
      filter.guildId = EchoExperience:GetGuildId(guildID)
      EchoExperience.outputToChanel(strL2,EchoExperience.staticdata.msgTypeGUILD,filter)  
    end
  elseif(curStatus == 4) then
    --offline
    if (EchoExperience.savedVariables.showGuildLogout) then
      local sentence2 = GetString("SI_ECHOEXP_GUILD_",3)
      local strL2 = zo_strformat(sentence2, (playerName), ZO_FormatClockTime(), gName, pLink )
      local filter = {}
      filter.type = EchoExperience.staticdata.msgTypeGUILD
      filter.guildID = guildID
      filter.guildId = EchoExperience:GetGuildId(guildID)
      EchoExperience.outputToChanel(strL2,EchoExperience.staticdata.msgTypeGUILD,filter)  
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
    EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeQuest)
    --EchoExperience.outputMsg("OnBattlegroundKill: you were killed by " .. tostring(killingPlayerDisplayName) )
  end
  if(EchoExperience.view.iamDisplayName == killingPlayerDisplayName ) then
    local sentence = GetString(SI_ECHOEXP_BG_KILLED)
    local strL     = zo_strformat(sentence, killingPlayerDisplayName )
    EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeQuest)
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
--EVENT_PLAYER_COMBAT_STATE
--OnCombatEnterExit (bool inCombat)
function EchoExperience.OnCombatEnterExit(eventCode, inCombat)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnCombatEnterExitWork(eventCode, inCombat)
      end
    )
  else
    EchoExperience.OnCombatEnterExitWork(eventCode, inCombat)
  end
end
  
--
function EchoExperience.OnCombatEnterExitWork(eventCode, inCombat)
  EchoExperience.debugMsg2("OnCombatEnterExitWork: "
      , " eventCode=" , (eventCode)
      , " inCombat="  , (inCombat)
  )
  --inCombat is a number? I'm so confused!  
  local isInCombat = IsUnitInCombat("player")
  if( EchoExperience.view.inCombat ~= isInCombat) then
    EchoExperience.view.inCombat = isInCombat
    --EchoExperience.view.inCombat = IsUnitInCombat("player")
    if(isInCombat) then
      local sentence = GetString(SI_ECHOEXP_COMBAT_ENTER)
      local strL = zo_strformat(sentence )
      EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeQuest)
    else
      local sentence = GetString(SI_ECHOEXP_COMBAT_EXIT)
      local strL = zo_strformat(sentence )
      EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeQuest)
    end
  end
end


------------------------------
-- EVENT
--EVENT_COMBAT_EVENT (number eventCode, ActionResult result, boolean isError, string abilityName, number abilityGraphic, ActionSlotType abilityActionSlotType, string sourceName, CombatUnitType sourceType, string targetName, CombatUnitType targetType, number hitValue, CombatMechanicType powerType, DamageType damageType, boolean log, number sourceUnitId, number targetUnitId, number abilityId) 
function EchoExperience.OnCombatEvent(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
  if(isError)then
    return
  end
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnCombatEventWork(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
      end
    )
  else
    EchoExperience.OnCombatEventWork(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
  end
end
  
--
function EchoExperience.OnCombatEventWork(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
  if(isError)then
    return
  end

  if(result==ACTION_RESULT_IN_COMBAT ) then  
    EchoExperience.debugMsg2("OnCombatEvent: "
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
    --EchoExperience.debugMsg("OnCombatEvent: not dead event")
    return
  end

  --sourceName==nil or sourceName=="" or
  if(isError or targetName==nil or targetName=="") then
    EchoExperience.debugMsg("OnCombatEvent: but no good data !!!")
    EchoExperience.debugMsg2("OnCombatEvent: "
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
    EchoExperience.debugMsg2("OnCombatEvent: "
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
    --[14:28] [14:28] (EchoExp) OnCombatEvent: sourceUnitId=0 targetUnitId=58426 result=2260(ACTION_RESULT_DIED)
    --or EchoExperience.view.iamDisplayName == targetUnitId
    if(sourceUnitId==targetUnitId) then
      local sentence = GetString(SI_ECHOEXP_DIED)
      local strL     = zo_strformat(sentence )
      EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeSYS)
      --EchoExperience.outputToChanel("You died!",EchoExperience.staticdata.msgTypeSYS)--TODO 
    else
      --TEST REMOVE TODO
      EchoExperience.debugMsg2("SomethingDied: "
        , " sourceUnitId=" , tostring(sourceUnitId)
        , " targetUnitId=" , tostring(targetUnitId) 
        , " result="       , tostring(result) 
      )
      local sentence = GetString(SI_ECHOEXP_KILL_MOB)
      local strL = zo_strformat(sentence, targetName )
      EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeQuest)
      
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
  local sentence = GetString(SI_ECHOEXP_GUILD_SELFLEFT)
  local strL     = zo_strformat(sentence, guildName )
  EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeGUILD2)
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
  local sentence = GetString(SI_ECHOEXP_GUILD_SELFJOIN)
  local strL     = zo_strformat(sentence, guildName )
  EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeGUILD2)
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
  --EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
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
  local strL = zo_strformat(sentence, questName, characterName, questId )
  EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
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
  EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
  EchoExperience.view.sharedquests[questName..shareTargetCharacterName] = GetTimeStamp()
end

------------------------------
-- EVENT
-- Alpha
--EVENT_GUILD_INVITE_ADDED
--(number eventCode, number guildId, string guildName, Alliance guildAlliance, string inviterDisplayName)
function EchoExperience.OnEventGuildInviteAdded(eventCode, guildId, guildName, guildAlliance, inviterDisplayName)
  --TESTING
  EchoExperience.debugMsg2("OnEventGuildInviteAdded: "
    , " eventCode="      , tostring(eventCode)
    , " guildId="   , tostring(guildId) 
    , " guildName="     , tostring(guildName) 
    , " guildAlliance="     , tostring(guildAlliance) 
    , " inviterDisplayName="        , tostring(inviterDisplayName) 
  )
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnEventGuildInviteAddedWork(eventCode, guildId, guildName, guildAlliance, inviterDisplayName)
      end
    )
  else
    EchoExperience.OnEventGuildInviteAddedWork(eventCode, guildId, guildName, guildAlliance, inviterDisplayName)
  end
end
function EchoExperience.OnEventGuildInviteAddedWork(eventCode, guildId, guildName, guildAlliance, inviterDisplayName)
	--SI_ECHOEXP_GUILDINVITED    = "<<1>> Invited you to the guild (<<2>>)",  
	local psAlliance = GetAllianceName(pAlliance)
	EchoExperience.debugMsg2("OnEventGuildInviteAdded: "
		, " psAlliance="      , tostring(psAlliance)
	)
	local sentence = GetString(SI_ECHOEXP_GUILDINVITED)
	local strL = zo_strformat(sentence, inviterDisplayName, guildName )
	EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeGuild)
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
      EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
    else
      EchoExperience.debugMsg2("OnEventQuestAdvanced: "
        , " questName="      , tostring(questName)
        , " isComplete="     , tostring(isComplete) 
      )
      local count    = GetNumJournalQuests()
      local sentence = GetString(SI_ECHOEXP_QUEST_COMPLETE)
      local strL = zo_strformat(sentence, questName, count, 25 )
      EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
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
  EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
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
  EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
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
    EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
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
    EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
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
  EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
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
  EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
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
  EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
end

------------------------------
-- EVENT_LORE_LIBRARY_INITIALIZED (number eventCode)
function EchoExperience.OnLoreBookLibraryInit(eventCode)
  EchoExperience.debugMsg2("OnLoreBookLibraryInit: "
    , " eventCode="     , tostring(eventCode) 
  )
end

------------------------------
-- EVENT EVENT_ITEM_SET_COLLECTION_UPDATED ( )
function EchoExperience.OnSetCollectionUpdated(eventCode, itemSetId, slotsJustUnlockedMask)
  --TESTING
  EchoExperience.debugMsg2("OnSetCollectionUpdated: "
    , " eventCode="     .. tostring(eventCode) 
    , " itemSetId="     .. tostring(itemSetId) 
    , " itemSetCollectionSlot="     .. tostring(itemSetCollectionSlot) 
  )
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    --Does this help at all??? is this how it is supposed to work? no idea!
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnSetCollectionUpdatedWork(itemSetId, itemSetCollectionSlot)
      end
    )
  else
    EchoExperience.OnSetCollectionUpdatedWork(itemSetId, itemSetCollectionSlot)
  end
end

--
function EchoExperience.OnSetCollectionUpdatedWork(itemSetId, itemSetCollectionSlot)
  local catId = GetItemSetCollectionCategoryId(itemSetId)
  local isname = GetItemSetName(itemSetId)
  EchoExperience.debugMsg2("OnSetCollectionUpdated: "
    , " catId="     .. tostring(catId) 
    , " isname="    .. tostring(isname) 
  )
  --
  local numPieces        = GetNumItemSetCollectionPieces(itemSetId)
  local numSlotsUnlocked = GetNumItemSetCollectionSlotsUnlocked(itemSetId)  
  
  -- New Set Collections 1000033
  local itemId      = GetItemLinkItemId(itemLink)
	local hasSet      = GetItemLinkSetInfo(itemLink)	
  local isCollected = IsItemSetCollectionPieceUnlocked(itemId)
  --TODO get a link to the item!!!set!!!
  --local pieceId, slot = GetItemSetCollectionPieceInfo(_itemSetId_, _index_)
  --local itemId           = GetItemLinkItemId(itemLink)
  --local itemLink2         = GetItemSetCollectionPieceItemLink(itemId, LINK_STYLE_DEFAULT, ITEM_TRAIT_TYPE_NONE)
  --local isUnlocked = IsItemSetCollectionSlotUnlocked(itemSetId, slot)
  EchoExperience.debugMsg2("OnSetCollectionUpdated: "
    , " numPieces="        .. tostring(numPieces) 
    , " numSlotsUnlocked=" .. tostring(numSlotsUnlocked) 
    --, " itemId=" .. tostring(itemId) 
    --, " itemLink2=" .. tostring(itemLink2) 
  )
  --
  local sentence = GetString(SI_ECHOEXP_SETCOLLECTION_UPDATED2)
  local strL = zo_strformat(sentence, isname, itemSetId, numPieces, numSlotsUnlocked, isname)
  EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeLOOT)
end

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
          EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
        end
        cnt = cnt + 1
      end
  end
  --
  if(numCriteria==1 and successCnt==numCriteria) then
    local sentence = GetString(SI_ECHOEXP_ACHIEVEMENT_COMPLETED)
    local strL = zo_strformat(sentence, link, achievementID, description)
    EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)    
  elseif(numCriteria > 1 and successCnt==numCriteria) then
    local sentence = GetString(SI_ECHOEXP_ACHIEVEMENT_UPDATED1)
    local strL = zo_strformat(sentence, link, achievementID, description)
    EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
  elseif( numCriteria > 1 ) then
    local sentence = GetString(SI_ECHOEXP_ACHIEVEMENT_UPDATED2)
    local strL = zo_strformat(sentence, link, achievementID, description, successCnt, numCriteria)
    EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
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
  EchoExperience.outputToChanel(strL, EchoExperience.staticdata.msgTypeQuest)
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
-- EVENT_GROUP_MEMBER_JOINED (number eventCode, string memberCharacterName, string memberDisplayName, boolean isLocalPlayer) - Changed in 100028
function EchoExperience.OnGroupMemberJoin(eventCode, memberCharacterName, memberDisplayName,  isLocalPlayer)
	--
  EchoExperience.debugMsg("OnGroupMemberJoin: "
    .." eventCode="     .. tostring(eventCode) 
    .." memberCharacterName=" .. tostring(memberCharacterName)
    .." memberDisplayName="   .. tostring(memberDisplayName)
    .." isLocalPlayer="       .. tostring(isLocalPlayer)
  )
  EchoExperience.currentPartyMembers[memberCharacterName] = memberDisplayName
  if(memberDisplayName==EchoExperience.view.iamDisplayName) then
	local gsize = GetGroupSize()
	EchoExperience.debugMsg("-GetGroupSize= " .. gsize)
    for i = 1, gsize do
		local unitTag = GetGroupUnitTagByIndex(i)
        if unitTag then
            local rawCharacterName = GetRawUnitName(unitTag)
            local displayName      = GetUnitDisplayName(unitTag) or ""
			EchoExperience.debugMsg("*rawCharacterName= " .. rawCharacterName)
			EchoExperience.debugMsg("**displayName= "     .. displayName)
			EchoExperience.currentPartyMembers[rawCharacterName] = displayName
		end
	end
  end
  --
end

------------------------------
-- EVENT_GROUP_MEMBER_LEFT(characterName, reason, isLocalPlayer, isLeader, displayName)
function EchoExperience.OnGroupMemberLeft(eventCode, characterName, reason, isLocalPlayer, isLeader, displayName)
	--
  EchoExperience.debugMsg("OnGroupMemberLeft: "
    .." eventCode="     .. tostring(eventCode) 
    .." characterName="  .. tostring(characterName)
    .." reason="        .. tostring(reason)
    .." isLocalPlayer="  .. tostring(isLocalPlayer)
    .." isLeader="    .. tostring(isLeader)
    .." isLeader="    .. tostring(displayName)
  )
  if(EchoExperience.currentPartyMembers and EchoExperience.currentPartyMembers[memberCharacterName]) then
	EchoExperience.currentPartyMembers[memberCharacterName] = nil
  end
  
  EchoExperience.currentPartyMembers[EchoExperience.view.iamCharacterName] = EchoExperience.view.iamDisplayName
end

------------------------------
-- EVENT_COMPANION_ACTIVATED (*integer* _companionId_)
function EchoExperience.OnCompanionActivated(eventCode, companionId)
  EchoExperience.debugMsg2( "OnCompanionActivated: eventCode: '", eventCode, "' companionId='", tostring(companionId), "'")
  if(EchoExperience.currentCompanionId~=nil and EchoExperience.currentCompanionId==companionId) then
	return; -- skip as they are already out and we just probably changed zones
  end  
  --
  local cname = GetCompanionName(companionId)
  local level, currentExperience = GetActiveCompanionLevelInfo()
  local currentRapport           = GetActiveCompanionRapport()
  --
  local strI  = GetString(SI_ECHOEXP_COMPANION_ACTIVE)
  local strL  = zo_strformat(strI, cname, level, currentRapport, currentExperience)
  EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeCOMP)
  EchoExperience.currentCompanionId = companionId
end
  
------------------------------
-- EVENT_COMPANION_DEACTIVATED ( )
function EchoExperience.OnCompanionDeactivated(eventCode)
  EchoExperience.debugMsg2( "OnCompanionDeactivated: eventCode: '", tostring(eventCode), "'")
  local strI = GetString(SI_ECHOEXP_COMPANION_DEACTIVE)
  local strL = zo_strformat(strI, cname)
  EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeCOMP)
  EchoExperience.currentCompanionId = nil
end

------------------------------
-- EVENT_COMPANION_EXPERIENCE_GAIN (*integer* _companionId_, *integer* _level_, *integer* _previousExperience_, *integer* _currentExperience_)
function EchoExperience.OnCompanionExpGain(eventCode, companionId, level, previousExperience, currentExperience )
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    --Does this help at all??? is this how it is supposed to work? no idea!
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnCompanionExpGainWork(eventCode, companionId, level, previousExperience, currentExperience )
      end
    )
  else
    EchoExperience.OnCompanionExpGainWork(eventCode, companionId, level, previousExperience, currentExperience )
  end
end
    
------------------------------
-- EVENT_COMPANION_EXPERIENCE_GAIN (*integer* _companionId_, *integer* _level_, *integer* _previousExperience_, *integer* _currentExperience_)
function EchoExperience.OnCompanionExpGainWork(eventCode, companionId, level, previousExperience, currentExperience )
  EchoExperience.debugMsg2( "OnCompanionExpGain: eventCode: '", eventCode, "' companionId='", (companionId), 
    "' level: '", (level), 
    "' previousExperience: '", (previousExperience), "' currentExperience: '", (currentExperience), "'" )
  local cname   = GetCompanionName(companionId)
  local xplevel = GetNumExperiencePointsInCompanionLevel(level+1)
  if(level<1) then
    xplevel = GetNumExperiencePointsInCompanionLevel(1)
  end
  if(xplevel==nil) then 
    EchoExperience.debugMsg2( "OnCompanionExpGain: xplevel nil error")
    return
  end
  EchoExperience.debugMsg2( "OnCompanionExpGain: xplevel: '", xplevel, "'")
  --xplevel = xplevel + previousExperience
  --** _Returns:_ *integer* _level_, *integer* _currentExperience_ = GetActiveCompanionLevelInfo()
	local diff = currentExperience - previousExperience
  if(diff>0) then
    local strI  = GetString(SI_ECHOEXP_COMPANION_EXPGAIN)
    if(currentExperience > xplevel) then
      strI  = GetString(SI_ECHOEXP_COMPANION_LEVELUP)
    end
    local strL  = zo_strformat(strI, cname, level, diff, previousExperience, currentExperience, xplevel  )
    EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeCOMP)
  end
end

------------------------------
-- EVENT_COMPANION_RAPPORT_UPDATE (*integer* _companionId_, *integer* _previousRapport_, *integer* _currentRapport_)
function EchoExperience.OnCompanionRapportUpdate(eventCode, companionId, previousRapport, currentRapport )
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    --Does this help at all??? is this how it is supposed to work? no idea!
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnCompanionRapportUpdateWork(eventCode, companionId, previousRapport, currentRapport )
      end
    )
  else
    EchoExperience.OnCompanionRapportUpdateWork(eventCode, companionId, previousRapport, currentRapport )
  end
end

------------------------------
-- EVENT_COMPANION_RAPPORT_UPDATE (*integer* _companionId_, *integer* _previousRapport_, *integer* _currentRapport_)
function EchoExperience.OnCompanionRapportUpdateWork(eventCode, companionId, previousRapport, currentRapport )
  EchoExperience.debugMsg2( "OnCompanionRapportUpdate: eventCode: '", eventCode, 
    "' companionId='", tostring(companionId), "' warningType: '" , tostring(warningType), 
    "' previousRapport: '", (previousRapport), "' currentRapport: '", (currentRapport), "'" )
  local cname = GetCompanionName(companionId)
	local diff = currentRapport - previousRapport
  -- local _maxRapport_ = GetMaximumRapport()
  -- _local minRapport_ = GetMinimumRapport()
  --_Returns:_ *[CompanionRapportLevel|#CompanionRapportLevel]* _rapportLevel_ = GetActiveCompanionRapportLevel()
  -- _Returns:_ *integer* _rapport_ = GetActiveCompanionRapport()
  local strI = GetString(SI_ECHOEXP_COMPANION_RAPPORTGAIN)
  if(diff<0) then
    strI = GetString(SI_ECHOEXP_COMPANION_RAPPORTLOSS)
    diff = diff*-1
  end
  local strL = zo_strformat(strI, cname, diff, previousRapport, currentRapport)
  EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeCOMP)
end

------------------------------
-- EVENT_COMPANION_SKILLS_FULL_UPDATE (*bool* _isInit_)
function EchoExperience.OnCompanionSkillsFullUpdate(eventCode, isInit)
  EchoExperience.debugMsg2( "OnCompanionSkillsFullUpdate: eventCode: '", eventCode, "' isInit='", tostring(isInit), "'")
  --TODO EchoExperience.staticdata.msgTypeCOMP
end

------------------------------
-- EVENT_COMPANION_SKILL_LINE_ADDED (** _skillLineId_)
function EchoExperience.OnCompanionSkilllineAdded(eventCode, skillLineId)
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    --Does this help at all??? is this how it is supposed to work? no idea!
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnCompanionSkilllineAddedWork(eventCode, skillLineId)
      end
    )
  else
    EchoExperience.OnCompanionSkilllineAddedWork(eventCode, skillLineId)
  end
end

------------------------------
-- EVENT_COMPANION_SKILL_LINE_ADDED (** _skillLineId_)
function EchoExperience.OnCompanionSkilllineAddedWork(eventCode, skillLineId)
  EchoExperience.debugMsg2( "OnCompanionSkilllineAdded: eventCode: '", eventCode, "' skillLineId='", tostring(skillLineId), "'")
  local slName = GetSkillLineNameById(skillLineId)
  local strI = GetString(SI_ECHOEXP_COMPANION_SKILLLINEADD)
  local strL = zo_strformat(strI, slName, skillLineId )
  EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeCOMP)
end

------------------------------
-- EVENT_COMPANION_SKILL_RANK_UPDATE (*integer* _skillLineId_, *luaindex* _rank_)
function EchoExperience.OnCompanionSkillRankUpdate(eventCode, skillLineId, rank )
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    --Does this help at all??? is this how it is supposed to work? no idea!
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnCompanionSkillRankUpdateWork(eventCode, skillLineId, rank )
      end
    )
  else
    EchoExperience.OnCompanionSkillRankUpdateWork(eventCode, skillLineId, rank )
  end
end

------------------------------
-- EVENT_COMPANION_SKILL_RANK_UPDATE (*integer* _skillLineId_, *luaindex* _rank_)
function EchoExperience.OnCompanionSkillRankUpdateWork(eventCode, skillLineId, rank )
  EchoExperience.debugMsg2( "OnCompanionSkillRankUpdate: eventCode: '", eventCode, "' skillLineId='", tostring(skillLineId), "' rank: '", (rank), "'" )
  --local cname = GetCompanionName(companionId)
  local strI = GetString(SI_ECHOEXP_COMPANION_SKILLRANKGAIN)
  local skillLineName = GetCompanionSkillLineNameById(skillLineId)
  local strL = zo_strformat(strI, skillLineId, skillLineName, rank )
  EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeCOMP)
end

------------------------------
-- EVENT_COMPANION_SKILL_XP_UPDATE (*integer* _skillLineId_, *integer* _reason_, *luaindex* _rank_, *integer* _previousXP_, *integer* _currentXP_)
function EchoExperience.OnCompanionSkillXpUpdate(eventCode, skillLineId, reason, rank, previousXP, currentXP )
  if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
    --Does this help at all??? is this how it is supposed to work? no idea!
    EchoExperience.view.task:Call(
      function()
        EchoExperience.OnCompanionSkillXpUpdateWork(eventCode, skillLineId, reason, rank, previousXP, currentXP )
      end
    )
  else
    EchoExperience.OnCompanionSkillXpUpdateWork(eventCode, skillLineId, reason, rank, previousXP, currentXP )
  end
end

------------------------------
-- EVENT_COMPANION_SKILL_XP_UPDATE (*integer* _skillLineId_, *integer* _reason_, *luaindex* _rank_, *integer* _previousXP_, *integer* _currentXP_)
function EchoExperience.OnCompanionSkillXpUpdateWork(eventCode, skillLineId, reason, rank, previousXP, currentXP )
  EchoExperience.debugMsg2( "OnCompanionSkillXpUpdate: eventCode: '", eventCode, 
    "' skillLineId='", (skillLineId), "' reason: '", (reason), "' rank: '", (rank), 
    "' previousXP: '", (previousXP), "'", "' currentXP: '", (currentXP), "'" )
  --local cname = GetCompanionName(companionId)
  local slName = GetSkillLineNameById(skillLineId)
  local diff = currentXP - previousXP
  local strI = GetString(SI_ECHOEXP_COMPANION_SKILLXPUPD)
  local strL = zo_strformat(strI, slName, diff, rank )
  EchoExperience.outputToChanel(strL,EchoExperience.staticdata.msgTypeCOMP)
end

------------------------------
-- VENT_COMPANION_ULTIMATE_FAILURE (*[CompanionUltimateFailureReason|#CompanionUltimateFailureReason]* _reason_, *string* _companionName_)
function EchoExperience.OnCompanionUltimateFailure(eventCode, reason, companionName )
  EchoExperience.debugMsg2( "OnCompanionUltimateFailure: eventCode: '", eventCode, 
    "' reason='", tostring(reason), "' companionName: '", (companionName), "'" )
  --TODO EchoExperience.staticdata.msgTypeCOMP
end
    
------------------------------
-- EVENT_COMPANION_WARNING (*[CompanionWarningType|#CompanionWarningType]* _warningType_, *integer* _companionId_)
function EchoExperience.OnCompanionWarning(eventCode, warningType, companionId)
  EchoExperience.outputMsg2( "OnCompanionWarning: eventCode: '", eventCode, 
    "' companionId='", tostring(companionId), "' warningType: '" , tostring(warningType), "'" )
  --TODO EchoExperience.staticdata.msgTypeCOMP
end
  
------------------------------
------------------------------

------------------------------
--SetupEndeavors
-- --EVENT_TIMED_ACTIVITY_TYPE_PROGRESS_UPDATED (number eventCode, TimedActivityType timedActivityType, integer previousNumCompleted, integer currentNumCompleted, bool complete)
function EchoExperience.OnEndeavorTimedActivityUpdated(eventCode, timedActivityType, previousNumCompleted, currentNumCompleted, complete)
	EchoExperience.debugMsg2(
		"OnEndeavorTimedActivityUpdated:",
		" eventCode: '", eventCode, 
		"' timedActivityType='", tostring(timedActivityType),
		"' previousNumCompleted: '" , tostring(previousNumCompleted),
		"' currentNumCompleted: '" , tostring(currentNumCompleted),
		"' complete: '" , tostring(complete), "'"	)
	--TODO
	--if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
	if(EchoExperience.savedVariables.useasyncall) then
		EchoExperience.view.task:Call(
		function()
			EchoExperience.OnEndeavorTimedActivityUpdatedWork(eventCode, timedActivityType, previousNumCompleted, currentNumCompleted, complete)
		end
		)
		else
			EchoExperience.OnEndeavorTimedActivityUpdatedWork(eventCode, timedActivityType, previousNumCompleted, currentNumCompleted, complete)
	end
end
function EchoExperience.OnEndeavorTimedActivityUpdatedWork(eventCode, timedActivityType, previousNumCompleted, currentNumCompleted, complete)
	EchoExperience.debugMsg2(
		"OnEndeavorTimedActivityUpdatedWork:",
		" eventCode: '", eventCode,
		"' complete: '" , tostring(complete), "'"
	)
	--Daily example
	--OnEndeavorUpdated: eventCode: '131791' timedActivityType='0' previousNumCompleted: '1' currentNumCompleted: '2' complete: 'false'
	--OnEndeavorUpdated: eventCode: '131791' timedActivityType='0' previousNumCompleted: '2' currentNumCompleted: '3' complete: 'true'
	--OnEndeavorUpdated: activityTypeName: 'Daily
	--
    if complete then
		--DONE with weekly or Daily?
        local activityTypeName = GetString("SI_TIMEDACTIVITYTYPE", timedActivityType)
		EchoExperience.debugMsg2( "OnEndeavorTimedActivityUpdated: activityTypeName: '", tostring(activityTypeName) )
		--local _, maxNumActivities = TIMED_ACTIVITIES_MANAGER:GetTimedActivityTypeLimitInfo(timedActivityType)
        --local messageTitle = zo_strformat(SI_TIMED_ACTIVITY_TYPE_COMPLETED_CSA, currentNumComplete, maxNumActivities, activityTypeName)
        --local messageSubheading = GetString("SI_TIMEDACTIVITYTYPE_FOLLOWUPHINT", timedActivityType)
        --local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT)
        --messageParams:SetText(messageTitle, messageSubheading)
        --return messageParams
		
		local strL = zo_strformat("<<1>>_<<2>>", "SI_ECHOEXP_TIMEDACTIVITY_DONE", timedActivityType)		
		local strI = GetString("SI_ECHOEXP_TIMEDACTIVITY_DONE",timedActivityType)
		EchoExperience.debugMsg2(
			"OnEndeavorTimedActivityUpdatedWork:",
			" strI: '", strI, "'",
			" strL: '", strL, "'"
		)
		EchoExperience.outputToChanel(strI,EchoExperience.staticdata.msgTypeENDEAV)
	else
		--		
		--Daily example
		--OnEndeavorUpdated: eventCode: '131791' timedActivityType='0' previousNumCompleted: '1' currentNumCompleted: '2' complete: 'false'
		local strL = zo_strformat("<<1>>_<<2>>", "SI_ECHOEXP_TIMEDACTIVITY_DONE", timedActivityType)	
		local strI = GetString("SI_ECHOEXP_TIMEDACTIVITY_UPDATE",timedActivityType)
		EchoExperience.debugMsg2(
			"OnEndeavorTimedActivityUpdatedWork:",
			" strI: '", strI, "'",
			" strL: '", strL, "'"
		)
		EchoExperience.outputToChanel(strI,EchoExperience.staticdata.msgTypeENDEAV)
    end
end

------------------------------
-- EVENT EVENT_OPEN_TIMED_ACTIVITIES (number eventCode)
function EchoExperience.OnEndeavorTimedActivity(eventCode)
	EchoExperience.outputMsg2( "OnEndeavorTimedActivity: called", " eventCode: '", eventCode )
end

------------------------------
-- EVENT EVENT_TIMED_ACTIVITY_SYSTEM_STATUS_UPDATED (number eventCode)
function EchoExperience.OnEndeavorUpdated(eventCode)
	EchoExperience.debugMsg2( "OnEndeavorUpdated: called", " eventCode: '", eventCode )
	--TODO
	--if(EchoExperience.savedVariables.useasyncall and EchoExperience.view.task~=nil) then
	if(EchoExperience.savedVariables.useasyncall) then
		EchoExperience.view.task:Call(
		function()
			EchoExperience.OnEndeavorUpdatedWork(eventCode)
		end
		)
		else
			EchoExperience.OnEndeavorUpdatedWork(eventCode)
	end
end
function EchoExperience.OnEndeavorUpdatedWork(eventCode)
	--local strI = GetString(SI_ECHOEXP_TIMEDACTIVITY_DONE,timedActivityType)
	--EchoExperience.outputToChanel(strI,EchoExperience.staticdata.msgTypeENDEAV)
end

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
  local targetZoneName = zo_strformat("<<1>>", elemLB["ZoneName"] )
  EchoExperience.debugMsg2("Litany: "
    , " TargetZoneName='" , tostring(targetZoneName), "'"
  )        
  local targetSubzoneName = zo_strformat("<<1>>", elemLB["SubZoneName"] ) 
  EchoExperience.debugMsg2("Litany: "
    , " TargetSubzoneName='", tostring(targetSubzoneName), "'"
  )
  local subzoneNamePL = zo_strformat("<<1>>", GetPlayerActiveSubzoneName() )
  local zoneNamePL    = zo_strformat("<<1>>", GetPlayerActiveZoneName()    )
  EchoExperience.debugMsg2("Litany: " , " CorpseZoneName='", tostring(zoneNamePL) 
     , "' CorpseSubzoneName='" , tostring(subzoneNamePL) , "'"
  )
  local lbDataHasSubzone = true
  if(targetSubzoneName==nil or targetSubzoneName=="" ) then
    lbDataHasSubzone = false
  end
  local playerHasSubzone = true
  if(subzoneNamePL==nil or subzoneNamePL=="" ) then
    playerHasSubzone = false
  end
  EchoExperience.debugMsg2("Litany: "
    , " lbDataHasSubzone='"   , tostring(lbDataHasSubzone) 
    , "' playerHasSubzone='"  , tostring(playerHasSubzone) , "'"
  )
  --
  local lbMatch = false  
  if( targetZoneName == zoneNamePL) then
    EchoExperience.debugMsg("Litany: zone match")
    if( lbDataHasSubzone and playerHasSubzone ) then
      EchoExperience.debugMsg("Litany: check subzone too")
      EchoExperience.debugMsg2("Litany: " , " subzoneNamePL='", tostring(subzoneNamePL) 
        , "' targetSubzoneName='" , tostring(targetSubzoneName) , "'"
      )
      if( subzoneNamePL==targetSubzoneName) then
        EchoExperience.debugMsg("Litany: exact MATCH")
        lbMatch = true
      elseif( EchoExperience.starts_with(subzoneNamePL, targetSubzoneName) ) then
        EchoExperience.debugMsg("Litany: partial MATCH")
        lbMatch = true
      end
    elseif( targetZoneName == zoneNamePL or subzoneNamePL == targetZoneName ) then
      EchoExperience.debugMsg("Litany: just check zone")
      EchoExperience.debugMsg("Litany: MATCH")
      lbMatch = true
    end
  else
    EchoExperience.debugMsg("Litany: Zone doesn't match target")
  end
  --found person on list 
  if(lbMatch) then
    local sentence = GetString(SI_ECHOEXP_KILL_LB1)
    EchoExperience.outputMsg(sentence)
    EchoExperience.savedVariables.LitanyOfBloodDone[targetName] = {}
    EchoExperience.savedVariables.LitanyOfBloodDone[targetName].time = GetTimeStamp()
    EchoExperience.savedVariables.LitanyOfBloodDone[targetName].id   = targetData.id
    EchoExperience.savedVariables.LitanyOfBloodDone[targetName].zonename     = targetData.ZoneName
    EchoExperience.savedVariables.LitanyOfBloodDone[targetName].subzonename  = targetData.SubZoneName
    EchoExperience.savedVariables.LitanyOfBloodDone[targetName].subzonename2 = targetData.SubZoneName2
    EchoExperience.savedVariables.LitanyOfBloodDone[targetName].tooltip      = targetData.tooltip
    EchoExperience.savedVariables.LitanyOfBloodDone[targetName].coord        = targetData.coord
  else
    local sentence = GetString(SI_ECHOEXP_KILL_LB0)
    EchoExperience.outputMsg(sentence)
  end
  --
end

---------------------------------
--[[ EchoExp : EVENTS        ]]-- 
---------------------------------
