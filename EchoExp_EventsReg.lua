---------------------------------
--[[ EchoExp : EVENTSRegister]]-- 
---------------------------------


------------------------------
-- SETUP
--https://wiki.esoui.com/Events
--EVENT_CLAIM_LEVEL_UP_REWARD_RESULT
--EVENT_DISCOVERY_EXPERIENCE (
--EVENT_LEVEL_UPDATE
function EchoExperience.SetupExpGainsEvents(reportMe)
	--
	if( EchoExperience.savedVariables.showExpT1 ==false and EchoExperience.savedVariables.showExpT2 == false) then
		EchoExperience.savedVariables.showExp = false
	end
	--
	if (EchoExperience.savedVariables.showExp) then
		if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_EXPGAINS_SHOW),EchoExperience.staticdata.msgTypeSYS) end
		local eventNamespace
		eventNamespace = EchoExperience.name.."SkillXPGain"
		EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_SKILL_XP_UPDATE, EchoExperience.OnSkillExperienceUpdate)
		--eventNamespace = EchoExperience.name.."OnCombatState"
		--EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_PLAYER_COMBAT_STATE,      EchoExperience.OnCombatState )
		eventNamespace = EchoExperience.name.."SkillLineAdded"
		EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_SKILL_LINE_ADDED, EchoExperience.OnSkillLineAdded)
		--TODO dont need sometimes?
		eventNamespace = EchoExperience.name.."ChampionUnlocked"
		EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_CHAMPION_SYSTEM_UNLOCKED, EchoExperience.OnChampionUnlocked)
		eventNamespace = EchoExperience.name.."XPUpdate"
		if(EchoExperience.savedVariables.showExpT2) then
			EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_EXPERIENCE_UPDATE, EchoExperience.OnExperienceUpdate)
		else
			EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_EXPERIENCE_UPDATE, EchoExperience.OnExperienceUpdate)
		end
		eventNamespace = EchoExperience.name.."XPGain"
		if(EchoExperience.savedVariables.showExpT1) then
			EVENT_MANAGER:RegisterForEvent(eventNamespace,		  EVENT_EXPERIENCE_GAIN,   EchoExperience.OnExperienceGain)
		else
			EVENT_MANAGER:UnregisterForEvent(eventNamespace,		EVENT_EXPERIENCE_GAIN,   EchoExperience.OnExperienceGain)
		end
		eventNamespace = EchoExperience.name.."EVENT_CHAMPION_POINT_GAINED"
		EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_CHAMPION_POINT_GAINED, EchoExperience.OnChampionPointGain)
		--eventNamespace = EchoExperience.name.."OnAlliancePtGain"
		--EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_ALLIANCE_POINT_UPDATE,    EchoExperience.OnAlliancePtGain)
		eventNamespace = EchoExperience.name.."OnSkillPtChange"
		EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_SKILL_POINTS_CHANGED, EchoExperience.OnSkillPtChange)
		--not really needed
		eventNamespace = EchoExperience.name.."AbilityProgression"
		EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_ABILITY_PROGRESSION_XP_UPDATE, EchoExperience.OnAbilityExperienceUpdate)
		eventNamespace = EchoExperience.name.."EVENT_SKILL_RANK_UPDATE"
		EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_SKILL_RANK_UPDATE, EchoExperience.OnSkillRankUpdate)
		eventNamespace = EchoExperience.name.."EVENT_ABILITY_PROGRESSION_RANK_UPDATE"
		EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_ABILITY_PROGRESSION_RANK_UPDATE, EchoExperience.OnSkillProgressRankUpdate)
		eventNamespace = EchoExperience.name.."EVENT_RIDING_SKILL_IMPROVEMENT"
		EVENT_MANAGER:RegisterForEvent(eventNamespace, EVENT_RIDING_SKILL_IMPROVEMENT, EchoExperience.OnRidingSkillUpdate)
	else -- showExp
		if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_EXPGAINS_HIDE),EchoExperience.staticdata.msgTypeSYS) end    
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."SkillXPGain",	    EVENT_SKILL_XP_UPDATE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."SkillLineAdded",	    EVENT_SKILL_LINE_ADDED)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."ChampionUnlocked",   EVENT_CHAMPION_SYSTEM_UNLOCKED)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."XPUpdate",		    EVENT_EXPERIENCE_UPDATE)    
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."XPGain",		        EVENT_EXPERIENCE_GAIN)    
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_CHAMPION_POINT_GAINED", EVENT_CHAMPION_POINT_GAINED)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnAlliancePtGain",	EVENT_ALLIANCE_POINT_UPDATE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnSkillPtChange",	EVENT_SKILL_POINTS_CHANGED)

		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnDiscoveryExp",		 EVENT_DISCOVERY_EXPERIENCE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."AbilityProgression",  EVENT_ABILITY_PROGRESSION_XP_UPDATE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_SKILL_RANK_UPDATE", EVENT_SKILL_RANK_UPDATE)    
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ABILITY_PROGRESSION_RANK_UPDATE", EVENT_ABILITY_PROGRESSION_RANK_UPDATE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_RIDING_SKILL_IMPROVEMENT",        EVENT_RIDING_SKILL_IMPROVEMENT)
	end
end

------------------------------
-- SETUP
function EchoExperience.SetupLootGainsEvents(reportMe)
	if (EchoExperience.savedVariables.showLoot) then
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."LootReceived",	EVENT_LOOT_RECEIVED, EchoExperience.OnLootReceived)
		if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINS_SHOW),EchoExperience.staticdata.msgTypeSYS) end
		--TODO redundency here can fix?
		if (EchoExperience.savedVariables.extendedLoot) then
		  if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINSE_SHOW),EchoExperience.staticdata.msgTypeSYS) end
		  --
		  local eventNamespace
		  eventNamespace = EchoExperience.name.."OnLootFailed"
		  EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_LOOT_ITEM_FAILED, EchoExperience.OnLootFailed)
		  eventNamespace = EchoExperience.name.."OnBankedCurrency"
		  EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_BANKED_CURRENCY_UPDATE, EchoExperience.OnBankedCurrency)
		  eventNamespace = EchoExperience.name.."OnCurrencyUpdate"
		  EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_CURRENCY_UPDATE, EchoExperience.OnCurrencyUpdate)
		  eventNamespace = EchoExperience.name.."OnSellReceipt"
		  EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_SELL_RECEIPT, EchoExperience.OnSellReceipt)
		  eventNamespace = EchoExperience.name.."OnBuybackReceipt"
		  EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_BUYBACK_RECEIPT, EchoExperience.OnBuybackReceipt)
		  eventNamespace = EchoExperience.name.."OnBuyReceipt"
		  EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_BUY_RECEIPT, EchoExperience.OnBuyReceipt)

		  eventNamespace = EchoExperience.name.."OnAlliancePointUpdate"
		  EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_ALLIANCE_POINT_UPDATE, EchoExperience.OnAlliancePointUpdate)
		  eventNamespace = EchoExperience.name.."OnInventoryItemDestroyed"
		  EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_INVENTORY_ITEM_DESTROYED, EchoExperience.OnInventoryItemDestroyed)
		  eventNamespace = EchoExperience.name.."OnInventoryItemUsed"
		  EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_INVENTORY_ITEM_USED, EchoExperience.OnInventoryItemUsed)
		  eventNamespace = EchoExperience.name.."OnInventorySingleSlotUpdate"
		  EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_INVENTORY_SINGLE_SLOT_UPDATE, EchoExperience.OnInventorySingleSlotUpdate)
		  eventNamespace = EchoExperience.name.."OnInventorySingleSlotUpdate"
		  EVENT_MANAGER:AddFilterForEvent(eventNamespace, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DEFAULT)
		  eventNamespace = EchoExperience.name.."EVENT_ANTIQUITY_LEAD_ACQUIRED"
		  EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_ANTIQUITY_LEAD_ACQUIRED, EchoExperience.OnAntiquityLeadAcquired)
		  --Extended loot
		else
		  if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINSE_HIDE),EchoExperience.staticdata.msgTypeSYS) end
		end
	else
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."LootReceived",	EVENT_LOOT_RECEIVED)
		if (not EchoExperience.savedVariables.extendedLoot) then
		  if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINSE_HIDE),EchoExperience.staticdata.msgTypeSYS) end
		end
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnLootFailed",     EVENT_LOOT_ITEM_FAILED)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnBankedCurrency", EVENT_BANKED_CURRENCY_UPDATE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnCurrencyUpdate", EVENT_CURRENCY_UPDATE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnSellReceipt",	  EVENT_SELL_RECEIPT)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnBuybackReceipt", EVENT_BUYBACK_RECEIPT)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnBuyReceipt",	  EVENT_BUY_RECEIPT)
	  
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnAlliancePointUpdate",	       EVENT_ALLIANCE_POINT_UPDATE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnInventoryItemDestroyed",	   EVENT_INVENTORY_ITEM_DESTROYED)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnInventoryItemUsed",	       EVENT_INVENTORY_ITEM_USED)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."OnInventorySingleSlotUpdate",   EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ANTIQUITY_LEAD_ACQUIRED", EVENT_ANTIQUITY_LEAD_ACQUIRED)
		if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_LOOTGAINS_HIDE),EchoExperience.staticdata.msgTypeSYS) end
	end
end

------------------------------
-- SETUP
function EchoExperience.SetupGuildEvents()
	EchoExperience.debugMsg2("SetupGuildEvents: "
		, " showGuildLogin="     , tostring(EchoExperience.savedVariables.showGuildLogin)
		, " showGuildLogout="    , tostring(EchoExperience.savedVariables.showGuildLogout)      
		, " showGuildJoinLeave=" , tostring(EchoExperience.savedVariables.showGuildJoinLeave)
	)
	if( EchoExperience.view.GuildEventsReg == true) then
		if ( not EchoExperience.savedVariables.showGuildLogin and not EchoExperience.savedVariables.showGuildLogout ) then
			EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED",	EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED, EchoExperience.OnGuildMemberStatusChanged)
			EchoExperience.view.GuildEventsReg = false
			EchoExperience.debugMsg(GetString(SI_ECHOEXP_GUILD_EVENT_UNREG))--"Unregistered for Guild events")
		end
	else
		if (EchoExperience.savedVariables.showGuildLogin or EchoExperience.savedVariables.showGuildLogout ) then
			EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED",	EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED, EchoExperience.OnGuildMemberStatusChanged)
			EchoExperience.view.GuildEventsReg = true
			EchoExperience.debugMsg(GetString(SI_ECHOEXP_GUILD_EVENT_REG))--"Registered for Guild events")
		end
	end
	if (EchoExperience.savedVariables.showGuildJoinLeave) then  
		EchoExperience.debugMsg2("SetupGuildEvents: register joinLeave")
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_ADDED",	EVENT_GUILD_MEMBER_ADDED, EchoExperience.OnGuildMemberAdded)
		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_REMOVED",	EVENT_GUILD_MEMBER_REMOVED, EchoExperience.OnGuildMemberRemoved)
	else
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_ADDED",	EVENT_GUILD_MEMBER_ADDED, EchoExperience.OnGuildMemberAdded)
		EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_GUILD_MEMBER_REMOVED",	EVENT_GUILD_MEMBER_REMOVED, EchoExperience.OnGuildMemberRemoved)    
	end
end

------------------------------
-- SETUP
function EchoExperience.SetupAchievmentEvents(reportMe)
  if( EchoExperience.savedVariables.showachievements) then
    EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENT_AWARDED",	EVENT_ACHIEVEMENT_AWARDED, EchoExperience.OnAchievementAwarded)
	--* U47 RegisterForEvent(*string* _name_, *integer* _event_, *function* _callback_, *bool* _doOnce_)
    EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_LEVEL_UPDATE",		    EVENT_LEVEL_UPDATE,          EchoExperience.OnExperienceLevelUpdate) -- U47, REGISTER_FILTER_UNIT_TAG , "player" )
	--* AddFilterForEvent(*string* _name_, *integer* _event_, *variant* _filterParameter_)
	EVENT_MANAGER:AddFilterForEvent(EchoExperience.name.."EVENT_LEVEL_UPDATE",		    EVENT_LEVEL_UPDATE, REGISTER_FILTER_UNIT_TAG , "player")	
	--* 
    EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_ITEM_SET_COLLECTION_UPDATED",	EVENT_ITEM_SET_COLLECTION_UPDATED, EchoExperience.OnSetCollectionUpdated)
    if(EchoExperience.savedVariables.showachievementdetails) then
      --EchoExperience.debugMsg("Showing achievement details")
      --EVENT_ACHIEVEMENTS_SEARCH_RESULTS_READY (number eventCode)
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENTS_UPDATED",	EVENT_ACHIEVEMENTS_UPDATED, EchoExperience.OnAchievementsUpdated)
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENT_UPDATED",	EVENT_ACHIEVEMENT_UPDATED, EchoExperience.OnAchievementUpdated)
      --EVENT_PLAYER_TITLES_UPDATE (number eventCode)
      --EVENT_TITLE_UPDATE (number eventCode, string unitTag)
    else
      --EchoExperience.debugMsg("Not showing achievement details")
      --EVENT_ACHIEVEMENTS_SEARCH_RESULTS_READY (number eventCode)
      EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENTS_UPDATED",	EVENT_ACHIEVEMENTS_UPDATED)
      EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENT_UPDATED",	EVENT_ACHIEVEMENT_UPDATED)    
      --EVENT_PLAYER_TITLES_UPDATE (number eventCode)
      --EVENT_TITLE_UPDATE (number eventCode, string unitTag)
    end
  else
    --EchoExperience.debugMsg("Not showing achievement details")
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENT_AWARDED",	EVENT_ACHIEVEMENT_AWARDED)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_LEVEL_UPDATE",         EVENT_LEVEL_UPDATE)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ITEM_SET_COLLECTION_UPDATED", EVENT_ITEM_SET_COLLECTION_UPDATED)
    --EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENTS_SEARCH_RESULTS_READY", EVENT_ACHIEVEMENTS_SEARCH_RESULTS_READY)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENTS_UPDATED",   EVENT_ACHIEVEMENTS_UPDATED)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_ACHIEVEMENT_UPDATED",    EVENT_ACHIEVEMENT_UPDATED)
    --EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_PLAYER_TITLES_UPDATE", EVENT_PLAYER_TITLES_UPDATE)
    --EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_TITLE_UPDATE",         EVENT_TITLE_UPDATE)
  end
end

------------------------------
-- SETUP
function EchoExperience.SetupDiscoveryEvents(reportMe)
  if( EchoExperience.savedVariables.showdiscovery) then
  		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnDiscoveryExp",	EVENT_DISCOVERY_EXPERIENCE,     EchoExperience.OnDiscoveryExperienceGain)
  else
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_DISCOVERY_EXPERIENCE",	EVENT_DISCOVERY_EXPERIENCE)
  end
end

------------------------------
-- SETUP
  --EVENT_MAIL_ATTACHED_MONEY_CHANGED (number eventCode, number moneyAmount)
  --EVENT_MAIL_COD_CHANGED (number eventCode, number codAmount)
  --EVENT_MAIL_SEND_FAILED (number eventCode, SendMailResult reason)
  --EVENT_MAIL_SEND_SUCCESS (number eventCode)
  --EVENT_MAIL_OPEN_MAILBOX (number eventCode)
  --EVENT_MAIL_CLOSE_MAILBOX (number eventCode)
  --EVENT_MAIL_INBOX_UPDATE (number eventCode)
  --EVENT_MAIL_NUM_UNREAD_CHANGED (number eventCode, number numUnread)
  --EVENT_MAIL_READABLE (number eventCode, id64 mailId)
  --EVENT_MAIL_REMOVED (number eventCode, id64 mailId)
function EchoExperience.SetupMailEvents(reportMe)
  --if( EchoExperience.savedVariables.showdiscovery) then
  		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnMailTakeAttachedItemOk",	EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS,     EchoExperience.OnMailTakeAttachedItemOk )
  		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnMailTakeAttachedMoneyOk",	EVENT_MAIL_TAKE_ATTACHED_MONEY_SUCCESS,     EchoExperience.OnMailTakeAttachedMoneyOk )
      
      EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnMailCreateAttachAdd",	EVENT_MAIL_ATTACHMENT_ADDED,     EchoExperience.OnMailCreateAttachAdd )
  		EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."OnMailCreateAttachRem",	EVENT_MAIL_ATTACHMENT_REMOVED,     EchoExperience.OnMailCreateAttachRem )

      
  --else
    --EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_DISCOVERY_EXPERIENCE",	EVENT_DISCOVERY_EXPERIENCE)
  --end
end

------------------------------
-- SETUP
function EchoExperience.SetupAlphaEvents(reportMe)
  if( EchoExperience.savedVariables.showalpha ) then
    local eventNamespace
    eventNamespace = EchoExperience.name.."EVENT_QUEST_SHARE_RESULT"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_QUEST_SHARE_RESULT, EchoExperience.OnEventQuestSharedResult)
    eventNamespace = EchoExperience.name.."EVENT_QUEST_SHARE_REMOVED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_QUEST_SHARE_REMOVED, EchoExperience.OnEventQuestSharedRemoved)
    eventNamespace = EchoExperience.name.."EVENT_QUEST_SHARED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_QUEST_SHARED, EchoExperience.OnEventQuestSharedStart)
    
    eventNamespace = EchoExperience.name.."EVENT_GUILD_INVITE_ADDED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_GUILD_INVITE_ADDED, EchoExperience.OnEventGuildInviteAdded)
    --EVENT_GUILD_INVITE_ADDED (number eventCode, number guildId, string guildName, Alliance guildAlliance, string inviterDisplayName)
    
    
    --EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_EFFECT_CHANGED",	EVENT_EFFECT_CHANGED, EchoExperience.OnCombatEffectChanged)    
    --EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_UNIT_DESTROYED",	EVENT_UNIT_DESTROYED, EchoExperience.OnUnitDestroyed)
  else
    local eventNamespace
    --EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_EFFECT_CHANGED",	EVENT_EFFECT_CHANGED)
    eventNamespace = EchoExperience.name.."EVENT_QUEST_SHARE_RESULT"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_QUEST_SHARE_RESULT)
    eventNamespace = EchoExperience.name.."EVENT_QUEST_SHARE_REMOVED"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_QUEST_SHARE_REMOVED)
    eventNamespace = EchoExperience.name.."EVENT_QUEST_SHARED"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_QUEST_SHARED)
    eventNamespace = EchoExperience.name.."EVENT_GUILD_INVITE_ADDED"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_GUILD_INVITE_ADDED, EchoExperience.OnEventGuildInviteAdded)
  end
end

------------------------------
-- SETUP
function EchoExperience.SetupLoreBookEvents(reportMe)
  if( EchoExperience.savedVariables.lorebooktracking ) then
    local eventNamespace = EchoExperience.name.."EVENT_LORE_BOOK_ALREADY_KNOWN"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_LORE_BOOK_ALREADY_KNOWN, EchoExperience.OnLoreBookAlreadyKnown)
    eventNamespace = EchoExperience.name.."EVENT_LORE_BOOK_LEARNED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_LORE_BOOK_LEARNED, EchoExperience.OnLoreBookLearned)    
    eventNamespace = EchoExperience.name.."EVENT_LORE_BOOK_LEARNED_SKILL_EXPERIENCE"
    --dont think need this... EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_LORE_BOOK_LEARNED_SKILL_EXPERIENCE, EchoExperience.OnLoreBookSkillExp)
    eventNamespace = EchoExperience.name.."EVENT_LORE_COLLECTION_COMPLETED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_LORE_COLLECTION_COMPLETED, EchoExperience.OnLoreBookCollectionComplete)
    eventNamespace = EchoExperience.name.."EVENT_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE, EchoExperience.OnLoreBookCollectionCompleteSkillExp)
    eventNamespace = EchoExperience.name.."EVENT_LORE_LIBRARY_INITIALIZED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_LORE_LIBRARY_INITIALIZED, EchoExperience.OnLoreBookLibraryInit)    
  else
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_LORE_BOOK_ALREADY_KNOWN",	EVENT_LORE_BOOK_ALREADY_KNOWN)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_LORE_BOOK_LEARNED",	    EVENT_LORE_BOOK_LEARNED)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_LORE_BOOK_LEARNED_SKILL_EXPERIENCE",	EVENT_LORE_BOOK_LEARNED_SKILL_EXPERIENCE)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_LORE_COLLECTION_COMPLETED", EVENT_LORE_COLLECTION_COMPLETED)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE",	EVENT_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_LORE_LIBRARY_INITIALIZED",	 EVENT_LORE_LIBRARY_INITIALIZED)
  end
  
--[[ TODO BOOK EVENTS
  EVENT_LORE_BOOK_ALREADY_KNOWN (number eventCode, string bookTitle)
  EVENT_LORE_BOOK_LEARNED (number eventCode, number categoryIndex, number collectionIndex, number bookIndex, number guildIndex, boolean isMaxRank)
  EVENT_LORE_BOOK_LEARNED_SKILL_EXPERIENCE (number eventCode, number categoryIndex, number collectionIndex, number bookIndex, number guildIndex, SkillType skillType, number skillIndex, number rank, number previousXP, number currentXP)
  EVENT_LORE_COLLECTION_COMPLETED (number eventCode, number categoryIndex, number collectionIndex, number guildIndex, boolean isMaxRank)
  EVENT_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE (number eventCode, number categoryIndex, number collectionIndex, number guildIndex, SkillType skillType, number skillIndex, number rank, number previousXP, number currentXP)
  EVENT_LORE_LIBRARY_INITIALIZED (number eventCode)
--]]
end

------------------------------
-- SETUP
function EchoExperience.SetupMiscEvents(reportMe)
  if( EchoExperience.savedVariables.sessiontracking or EchoExperience.savedVariables.showmdk ) then
    --if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_XXX_HIDE),EchoExperience.staticdata.msgTypeSYS) end
    local eventNamespace = EchoExperience.name.."EVENT_COMBAT_EVENT"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_COMBAT_EVENT, EchoExperience.OnCombatEvent)
    EchoExperience.view.inCombat = IsUnitInCombat("player")
    --eventNamespace = EchoExperience.name.."EVENT_PLAYER_COMBAT_STATE"
    --EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_COMBAT_EVENT, EchoExperience.OnCombatEnterExit)
    --EVENT_MANAGER:AddFilterForEvent(eventNamespace, eventId, filterType, varying filterParameter)
    --EVENT_MANAGER:AddFilterForEvent(eventNamespace, EVENT_COMBAT_EVENT, REGISTER_FILTER_COMBAT_RESULT, ACTION_RESULT_DIED)
    --EVENT_MANAGER:AddFilterForEvent(eventNamespace, EVENT_COMBAT_EVENT, REGISTER_FILTER_IS_ERROR, false)
     --ACTION_RESULT_TARGET_DEAD 
    --EVENT_MANAGER:RegisterForEvent(EchoExperience.name.."EVENT_UNIT_DESTROYED",	EVENT_UNIT_DESTROYED, EchoExperience.OnUnitDestroyed)
    eventNamespace = EchoExperience.name.."EVENT_BATTLEGROUND_KILL"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_BATTLEGROUND_KILL, EchoExperience.OnBattlegroundKill)
    -- Triggers when you leave a guild (guildId / guildName)
    eventNamespace = EchoExperience.name.."EVENT_GUILD_SELF_LEFT_GUILD"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_GUILD_SELF_LEFT_GUILD, EchoExperience.OnGuildSelfLeft)
    -- Triggers when you join a guild (guildId / guildName)
    eventNamespace = EchoExperience.name.."EVENT_GUILD_SELF_JOINED_GUILD"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_GUILD_SELF_JOINED_GUILD, EchoExperience.OnGuildSelfJoined)
    --
  else
    --if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_XXX_HIDE),EchoExperience.staticdata.msgTypeSYS) end
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_COMBAT_EVENT",	        EVENT_COMBAT_EVENT)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_BATTLEGROUND_KILL",	EVENT_BATTLEGROUND_KILL)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_PLAYER_COMBAT_STATE",	EVENT_PLAYER_COMBAT_STATE)    
  end
end

------------------------------
-- SETUP
function EchoExperience.SetupEventsQuest(reportMe)
  if( EchoExperience.savedVariables.showquests ) then
    if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_QUEST_SHOW),EchoExperience.staticdata.msgTypeSYS) end
    local eventNamespace = nil
    eventNamespace = EchoExperience.name.."EVENT_QUEST_ADDED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_QUEST_ADDED, EchoExperience.OnEventQuestAdded)
    eventNamespace = EchoExperience.name.."EVENT_QUEST_COMPLETE"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_QUEST_COMPLETE, EchoExperience.OnEventQuestComplete)    
    eventNamespace = EchoExperience.name.."EVENT_QUEST_REMOVED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_QUEST_REMOVED, EchoExperience.OnEventQuestRemoved)    
        
    if( EchoExperience.savedVariables.showquestsadvanced ) then
      eventNamespace = EchoExperience.name.."EVENT_QUEST_ADVANCED"
      EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_QUEST_ADVANCED, EchoExperience.OnEventQuestAdvanced)
    end
  else
    if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_QUEST_HIDE),EchoExperience.staticdata.msgTypeSYS) end
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_QUEST_ADDED",	    EVENT_QUEST_ADDED)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_QUEST_COMPLETE",	EVENT_QUEST_COMPLETE)
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_QUEST_REMOVED",	EVENT_QUEST_REMOVED)    
    EVENT_MANAGER:UnregisterForEvent(EchoExperience.name.."EVENT_QUEST_ADVANCED",	EVENT_QUEST_ADVANCED)
  end
end

------------------------------
-- SETUP
function EchoExperience.SetupGroupEvents(reportMe)
	--if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_COMPANION_SHOW),EchoExperience.staticdata.msgTypeSYS) end
	local eventNamespace = nil
    eventNamespace = EchoExperience.name.."EVENT_GROUP_MEMBER_JOINED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_GROUP_MEMBER_JOINED, EchoExperience.OnGroupMemberJoin )
	--
	eventNamespace = EchoExperience.name.."EVENT_GROUP_MEMBER_LEFT"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_GROUP_MEMBER_LEFT, EchoExperience.OnGroupMemberLeft )
end

------------------------------
-- SETUP
function EchoExperience.UnsetupGroupEvents(reportMe)
	--if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_COMPANION_SHOW),EchoExperience.staticdata.msgTypeSYS) end
	local eventNamespace = nil
    eventNamespace = EchoExperience.name.."EVENT_GROUP_MEMBER_JOINED"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_GROUP_MEMBER_JOINED, EchoExperience.OnGroupMemberJoin )
	--
	eventNamespace = EchoExperience.name.."EVENT_GROUP_MEMBER_LEFT"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_GROUP_MEMBER_LEFT, EchoExperience.OnGroupMemberLeft )
end

------------------------------
-- SETUP
function EchoExperience.SetupCompanionEvents(reportMe)
  --
  if( EchoExperience.savedVariables.showcompanions2 ) then
	if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_COMPANION2_SHOW),EchoExperience.staticdata.msgTypeSYS) end
	local eventNamespace = nil
    --* EVENT_COMPANION_RAPPORT_UPDATE (*integer* _companionId_, *integer* _previousRapport_, *integer* _currentRapport_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_RAPPORT_UPDATE"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_COMPANION_RAPPORT_UPDATE, EchoExperience.OnCompanionRapportUpdate )
  else
    if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_COMPANION2_HIDE),EchoExperience.staticdata.msgTypeSYS) end
     local eventNamespace = nil
	--* EVENT_COMPANION_RAPPORT_UPDATE (*integer* _companionId_, *integer* _previousRapport_, *integer* _currentRapport_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_RAPPORT_UPDATE"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_COMPANION_RAPPORT_UPDATE, EchoExperience.OnCompanionRapportUpdate )
  end
  --
  if( EchoExperience.savedVariables.showcompanions ) then
    if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_COMPANION_SHOW),EchoExperience.staticdata.msgTypeSYS) end
    local eventNamespace = nil
    --* EVENT_COMPANION_ACTIVATED (*integer* _companionId_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_ACTIVATED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_COMPANION_ACTIVATED, EchoExperience.OnCompanionActivated )
    --* EVENT_COMPANION_DEACTIVATED
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_DEACTIVATED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_COMPANION_DEACTIVATED, EchoExperience.OnCompanionDeactivated )
    --* EVENT_COMPANION_EXPERIENCE_GAIN (*integer* _companionId_, *integer* _level_, *integer* _previousExperience_, *integer* _currentExperience_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_EXPERIENCE_GAIN"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_COMPANION_EXPERIENCE_GAIN, EchoExperience.OnCompanionExpGain )
    --* EVENT_COMPANION_RAPPORT_UPDATE (*integer* _companionId_, *integer* _previousRapport_, *integer* _currentRapport_)
    --eventNamespace = EchoExperience.name.."EVENT_COMPANION_RAPPORT_UPDATE"
    --EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_COMPANION_RAPPORT_UPDATE, EchoExperience.OnCompanionRapportUpdate )
    --* EVENT_COMPANION_SKILLS_FULL_UPDATE (*bool* _isInit_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_SKILLS_FULL_UPDATE"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_COMPANION_SKILLS_FULL_UPDATE, EchoExperience.OnCompanionSkillsFullUpdate )
    --* EVENT_COMPANION_SKILL_LINE_ADDED (** _skillLineId_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_SKILL_LINE_ADDED"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_COMPANION_SKILL_LINE_ADDED, EchoExperience.OnCompanionSkilllineAdded )
    --* EVENT_COMPANION_SKILL_RANK_UPDATE (*integer* _skillLineId_, *luaindex* _rank_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_SKILL_RANK_UPDATE"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_COMPANION_SKILL_RANK_UPDATE, EchoExperience.OnCompanionSkillRankUpdate )
    --* EVENT_COMPANION_SKILL_XP_UPDATE (*integer* _skillLineId_, *integer* _reason_, *luaindex* _rank_, *integer* _previousXP_, *integer* _currentXP_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_SKILL_XP_UPDATE"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_COMPANION_SKILL_XP_UPDATE, EchoExperience.OnCompanionSkillXpUpdate )
    --* EVENT_COMPANION_ULTIMATE_FAILURE (*[CompanionUltimateFailureReason|#CompanionUltimateFailureReason]* _reason_, *string* _companionName_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_ULTIMATE_FAILURE"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_COMPANION_ULTIMATE_FAILURE, EchoExperience.OnCompanionUltimateFailure )
    --* EVENT_COMPANION_WARNING (*[CompanionWarningType|#CompanionWarningType]* _warningType_, *integer* _companionId_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_WARNING"
    EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_COMPANION_WARNING, EchoExperience.OnCompanionWarning )
  else
    if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_COMPANION_HIDE),EchoExperience.staticdata.msgTypeSYS) end
     local eventNamespace = nil
    --* EVENT_COMPANION_ACTIVATED (*integer* _companionId_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_ACTIVATED"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_COMPANION_ACTIVATED, EchoExperience.OnCompanionActivated )
    --* EVENT_COMPANION_DEACTIVATED
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_DEACTIVATED"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_COMPANION_DEACTIVATED, EchoExperience.OnCompanionDeactivated )
    --* EVENT_COMPANION_EXPERIENCE_GAIN (*integer* _companionId_, *integer* _level_, *integer* _previousExperience_, *integer* _currentExperience_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_EXPERIENCE_GAIN"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_COMPANION_EXPERIENCE_GAIN, EchoExperience.OnCompanionExpGain )
    --* EVENT_COMPANION_RAPPORT_UPDATE (*integer* _companionId_, *integer* _previousRapport_, *integer* _currentRapport_)
    --eventNamespace = EchoExperience.name.."EVENT_COMPANION_RAPPORT_UPDATE"
    --EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_COMPANION_RAPPORT_UPDATE, EchoExperience.OnCompanionRapportUpdate )
    --* EVENT_COMPANION_SKILLS_FULL_UPDATE (*bool* _isInit_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_SKILLS_FULL_UPDATE"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_COMPANION_SKILLS_FULL_UPDATE, EchoExperience.OnCompanionSkillsFullUpdate )
    --* EVENT_COMPANION_SKILL_LINE_ADDED (** _skillLineId_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_SKILL_LINE_ADDED"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_COMPANION_SKILL_LINE_ADDED, EchoExperience.OnCompanionSkilllineAdded )
    --* EVENT_COMPANION_SKILL_RANK_UPDATE (*integer* _skillLineId_, *luaindex* _rank_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_SKILL_RANK_UPDATE"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_COMPANION_SKILL_RANK_UPDATE, EchoExperience.OnCompanionSkillRankUpdate )
    --* EVENT_COMPANION_SKILL_XP_UPDATE (*integer* _skillLineId_, *integer* _reason_, *luaindex* _rank_, *integer* _previousXP_, *integer* _currentXP_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_SKILL_XP_UPDATE"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_COMPANION_SKILL_XP_UPDATE, EchoExperience.OnCompanionSkillXpUpdate )
    --* EVENT_COMPANION_ULTIMATE_FAILURE (*[CompanionUltimateFailureReason|#CompanionUltimateFailureReason]* _reason_, *string* _companionName_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_ULTIMATE_FAILURE"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_COMPANION_ULTIMATE_FAILURE, EchoExperience.OnCompanionUltimateFailure )
    --* EVENT_COMPANION_WARNING (*[CompanionWarningType|#CompanionWarningType]* _warningType_, *integer* _companionId_)
    eventNamespace = EchoExperience.name.."EVENT_COMPANION_WARNING"
    EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_COMPANION_WARNING, EchoExperience.OnCompanionWarning )
  end
end


------------------------------
-- SETUP
-- NOT WORKING ??
function EchoExperience.SetupEndeavors(reportMe)
	if( EchoExperience.savedVariables.endeavortracking ) then
		--if(reportMe) then EchoExperience.outputToChanel(GetString(SI_ECHOEXP_COMPANION_SHOW),EchoExperience.staticdata.msgTypeSYS) end
		EchoExperience.debugMsg( "SetupEndeavors: register" )
		local eventNamespace = nil	

		--EVENT_TIMED_ACTIVITY_SYSTEM_STATUS_UPDATED (number eventCode)
		eventNamespace = EchoExperience.name.."EVENT_TIMED_ACTIVITY_SYSTEM_STATUS_UPDATED"
		EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_TIMED_ACTIVITY_SYSTEM_STATUS_UPDATED, EchoExperience.OnEndeavorUpdated )
		--EVENT_OPEN_TIMED_ACTIVITIES (number eventCode)
		eventNamespace = EchoExperience.name.."EVENT_OPEN_TIMED_ACTIVITIES"
		EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_OPEN_TIMED_ACTIVITIES, EchoExperience.OnEndeavorTimedActivity )
		--EVENT_TIMED_ACTIVITY_TYPE_PROGRESS_UPDATED (number eventCode, TimedActivityType timedActivityType, integer previousNumCompleted, integer currentNumCompleted, bool complete)
		eventNamespace = EchoExperience.name.."EVENT_TIMED_ACTIVITY_TYPE_PROGRESS_UPDATED"
		EVENT_MANAGER:RegisterForEvent(eventNamespace,	EVENT_TIMED_ACTIVITY_TYPE_PROGRESS_UPDATED, EchoExperience.OnEndeavorTimedActivityUpdated )
	else
		EchoExperience.debugMsg( "SetupEndeavors: unregister" )
		local eventNamespace = nil	

		--EVENT_TIMED_ACTIVITY_SYSTEM_STATUS_UPDATED (number eventCode)
		eventNamespace = EchoExperience.name.."EVENT_TIMED_ACTIVITY_SYSTEM_STATUS_UPDATED"
		EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_TIMED_ACTIVITY_SYSTEM_STATUS_UPDATED, EchoExperience.OnEndeavorUpdated )
		--EVENT_OPEN_TIMED_ACTIVITIES (number eventCode)
		eventNamespace = EchoExperience.name.."EVENT_OPEN_TIMED_ACTIVITIES"
		EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_OPEN_TIMED_ACTIVITIES, EchoExperience.OnEndeavorTimedActivity )
		--EVENT_TIMED_ACTIVITY_TYPE_PROGRESS_UPDATED (number eventCode, TimedActivityType timedActivityType, integer previousNumCompleted, integer currentNumCompleted, bool complete)
		eventNamespace = EchoExperience.name.."EVENT_TIMED_ACTIVITY_TYPE_PROGRESS_UPDATED"
		EVENT_MANAGER:UnregisterForEvent(eventNamespace,	EVENT_TIMED_ACTIVITY_TYPE_PROGRESS_UPDATED, EchoExperience.OnEndeavorTimedActivityUpdated )
	end
end

---------------------------------
--[[ EchoExp : EVENTSRegister]]-- 
---------------------------------