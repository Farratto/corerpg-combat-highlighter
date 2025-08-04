-- Please see the LICENSE.txt file included with this distribution for
-- attribution and copyright information.

--luacheck: globals winCtHighlight nodeCtUnderlayed onHover onDelete originalOnHover tokenUnderlayed

winCtHighlight = nil;
tokenUnderlayed = nil;

function onInit()
	UDGCoreRPGCombatHighlighterHelper.verbose({"token_manager_override.lua::onInit()"});

	originalOnHover = Token.onHover;
	Token.onHover = onHover;

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
		if winCtHighlight and type(winCtHighlight) == 'windowinstance'
			and (not ceWindow or ceWindow ~= winCtHighlight)
			and winCtHighlight.updateDisplay
		then
			winCtHighlight.updateDisplay();
			winCtHighlight = nil;
		end
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

		if OptionsManager.isOption("CORERPG_COMBAT_HIGHLIGHTER_TOKEN_HOVER_ON_HIGHLIGHT_CT_ENTRY", "on") then
			if ceWindow then
				if bOver then
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
end
