-- Please see the LICENSE.txt file included with this distribution for
-- attribution and copyright information.

--luacheck: globals winCtHighlight nodeCtUnderlayed onHover onDelete originalOnHover originalOnDelete tokenUnderlayed

--[[
nodeLastHover = nil;
nLastId = nil;
bLastHoverEnter = nil;
]]
winCtHighlight = nil;
--nodeCtUnderlayed = nil;
tokenUnderlayed = nil;

function onInit()
	UDGCoreRPGCombatHighlighterHelper.verbose({"token_manager_override.lua::onInit()"});

	originalOnHover = Token.onHover;
	Token.onHover = onHover;

	originalOnDelete = Token.onDelete;
	Token.onDelete = onDelete;
end

function onHover(tokenMap, bOver) --if bOver is false, token is leaving hover area, true if it is entering
	UDGCoreRPGCombatHighlighterHelper.verbose({"token_manager_override.lua::onHover(tokenMap, bOver)", "tokenMap: "
		, tokenMap, "bOver: ", bOver
	});

	if OptionsManager.isOption("CORERPG_COMBAT_HIGHLIGHTER_DISABLE_FUNCTIONALITY_WHEN_DRAGGING", "on")
		and Input.getDragData()
	then --luacheck: ignore 542
		-- Do nothing - we're dragging
	else
		local ceWindow = nil;
		if tokenMap then
			ceWindow = UDGCoreRPGCombatHighlighterCombatManagerHelper.getCombatEntryWindowFromToken(tokenMap);
		end

		--clearing missed clears
		if winCtHighlight and (not ceWindow or ceWindow ~= winCtHighlight
			) and winCtHighlight.updateDisplay
		then
			winCtHighlight.updateDisplay();
			winCtHighlight = nil;
		end
--[[
		if nodeCtUnderlayed then
			UDGCoreRPGCombatHighlighterCommon.removeUnderlay(nodeCtUnderlayed);
			nodeCtUnderlayed = nil;
		end
]]
		if tokenUnderlayed then
			UDGCoreRPGCombatHighlighterCommon.removeUnderlay(tokenUnderlayed);
			tokenUnderlayed = nil;
		end

		local combatTrackerWindow;
		if Session.IsHost then
			combatTrackerWindow = Interface.findWindow("combattracker_host", "combattracker");
		else
			combatTrackerWindow = Interface.findWindow("combattracker_client", "combattracker");
		end

		local windowList = nil;
		if combatTrackerWindow then
			windowList = combatTrackerWindow.list;
		end

--[[
		--checking for missed hover
		local missedEnter;
		local missedExit;
		if not bOver then --we are exiting
			if bLastHoverEnter == false then --last ping was an exit
				--we missed the entrance of current exit
				if nLastId then --missed enter was a token
					--also checks if token still exists
					missedEnter = Token.getToken(DB.getPath(nodeLastHover), nLastId);
				end
			elseif bLastHoverEnter then --last ping was an entrance
				if nodeLastHover ~= tokenMap.getContainerNode() then --but last ping was not the entrance we are currently exiting
					--we missed an exit and an entrance
					if nLastId then --missed exit was a token
						--also checks if token still exists
						local sNodeLastHover;
						if nodeLastHover then sNodeLastHover = DB.getPath(nodeLastHover) end
						if sNodeLastHover then missedExit = Token.getToken(sNodeLastHover, nLastId) end
					end
					missedEnter = tokenMap;
				end
			--else this is the first ping
			end
		else --we are entering
			if bLastHoverEnter then --last ping was also enter, which means we missed an exit
				if nLastId then --missed exit was a token
					--also checks if token still exists and our nodeLastHover is legit
					local sNodeLastHover;
					if nodeLastHover then sNodeLastHover = DB.getPath(nodeLastHover) end
					if sNodeLastHover then missedExit = Token.getToken(sNodeLastHover, nLastId) end
				end
			end
		end
]]

		if OptionsManager.isOption("CORERPG_COMBAT_HIGHLIGHTER_TOKEN_HOVER_ON_HIGHLIGHT_CT_ENTRY", "on") then
			if ceWindow then
				if bOver then
--[[
					if missedExit then
						local wMissed = UDGCoreRPGCombatHighlighterCombatManagerHelper.getCombatEntryWindowFromToken(missedExit);
						if wMissed and wMissed.updateDisplay then wMissed.updateDisplay() end
					end
]]
					ceWindow.setFrame("ctentrybox_highlight");
					winCtHighlight = ceWindow;
				else
					ceWindow.updateDisplay();
					winCtHighlight = nil;
				end
			end
		end

		if OptionsManager.isOption("CORERPG_COMBAT_HIGHLIGHTER_TOKEN_HOVER_ON_AUTO_SCROLL_TO_CT_ENTRY", "on") then
			if windowList and bOver and ceWindow then
				windowList.scrollToWindow(ceWindow);
			end
		end

		if OptionsManager.isOption("CORERPG_COMBAT_HIGHLIGHTER_TOKEN_HOVER_OFF_AUTO_SCROLL_TO_ACTIVE_CT_ENTRY"
			, "on")
		then
			if (not bOver) and windowList then
				local node = CombatManager.getActiveCT();
				local activeCE = nil;

				if node then
					activeCE = UDGCoreRPGCombatHighlighterCombatManagerHelper.getCombatEntryWindowFromNode(node);
				end

				if activeCE then
					windowList.scrollToWindow(activeCE);
				end
			end
		end

--[[
		if tokenMap then
			if tokenMap.getContainerNode then nodeLastHover = tokenMap.getContainerNode() end
			if tokenMap.getId then nLastId = tokenMap.getId() end
		end
		bLastHoverEnter = bOver;
]]
	end

	if originalOnHover then return originalOnHover(tokenMap, bOver)	end
end

function onDelete(token)
	UDGCoreRPGCombatHighlighterHelper.verbose({"token_manager_override.lua::onDelete(token)", "token: ", token});

	if token == tokenUnderlayed then tokenUnderlayed = nil end

	combatants = CombatManager.getCombatantNodes();

	for _,combatant in pairs(combatants) do
		local window = UDGCoreRPGCombatHighlighterCombatManagerHelper.getCombatEntryWindowFromNode(combatant);
		if window then
			if not DB.getValue(combatant, 'tokenrefid') then
				window.updateDisplay();
				if winCtHighlight == window then winCtHighlight = nil end
			end
			if Session.IsHost then
				local tSelectedTokens = window.UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS
				for k,tokenMap in ipairs(tSelectedTokens) do
					if tokenMap == token then window.UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS[k] = nil end
				end
			end
		end
	end

	if originalOnDelete then return originalOnDelete(token) end
end
