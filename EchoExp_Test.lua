---------------------------------
--[[ EchoExp : TEST          ]]-- 
---------------------------------


function EchoExperience:RunTest2()
	EchoExperience.outputMsg("Test2-->")
	EchoExperience.BuildSettings()	
	--[[
	-- use to update this table later?
	EchoExperience.view.settings_questEnd = #optionsTable
	optionsTable[#optionsTable+1] = {
		type = "submenu",
		name = "Quest Submenu, --TODO
		tooltip = "TODO", --"Save selected Quest chat Data!",
		--width = "half",	--or "half" (optional)
		controls = {
			--https://github.com/sirinsidiator/ESO-LibAddonMenu/blob/master/LibAddonMenu-2.0/exampleoptions.lua
		},
		reference = "QuestSubMenuTab"
	}
	--]]
	EchoExperience.outputMsg("<--Test2")
end

function EchoExperience:RunTest1()
	EchoExperience.outputMsg("Test1-->")
	local gsize = GetGroupSize()
	EchoExperience.outputMsg("-GetGroupSize= " .. gsize)
    for i = 1, gsize do
		local unitTag = GetGroupUnitTagByIndex(i)
        if unitTag then
            local rawCharacterName = GetRawUnitName(unitTag)
            local displayName = GetUnitDisplayName(unitTag) or ""
			EchoExperience.outputMsg("*rawCharacterName= " .. rawCharacterName)
			EchoExperience.outputMsg("**displayName= "     .. displayName)
			--
			EchoExperience.currentPartyMembers[rawCharacterName] = displayName
		end
	end	
	EchoExperience.outputMsg("<--Test1")
end

---------------------------------
--[[ EchoExp : TEST          ]]-- 
---------------------------------