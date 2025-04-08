-- Please see the LICENSE.txt file included with this distribution for
-- attribution and copyright information.

--luacheck: globals onHover

function onInit()
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_tracker_client_override.lua::onInit"});

	if super and super.onInit then super.onInit() end
end

function onHover(state)
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_tracker_host_ct_entry_override.lua::onHover(state)"
		, "state: ", state
	});

	if OptionsManager.isOption("CORERPG_COMBAT_HIGHLIGHTER_DISABLE_FUNCTIONALITY_WHEN_DRAGGING", "on")
		and Input.getDragData()
	then --luacheck: ignore 542
		-- Do nothing - we're dragging
	else
		local nodeCT = getDatabaseNode();
		local tokenCT = CombatManager.getTokenFromCT(nodeCT);

--[[
		local missedExit;
		local nodeLastHover = UDGCoreRPGCombatHighlighterTokenManager.nodeLastHover;
		local bLastHoverEnter = UDGCoreRPGCombatHighlighterTokenManager.bLastHoverEnter;
		local nLastId = UDGCoreRPGCombatHighlighterTokenManager.nLastId;
		if not state then --we are exiting
			if bLastHoverEnter and nodeLastHover ~= nodeCT then --last ping was an entrance
				--and was not the entrance we are currently exiting
				--we missed the entrance of current exit
				--we may have missed an exit and an entrance
				if nLastId then --missed exit was a token
					--also checks if token still exists
					missedExit = Token.getToken(DB.getPath(nodeLastHover), nLastId);
				end
			end
		else --we are entering
			--last ping was also enter, which means we missed an exit
			if bLastHoverEnter then
				if nLastId then --missed exit was a token
					--also checks if token still exists
					missedExit = Token.getToken(DB.getPath(nodeLastHover), nLastId);
				end
			end
		end
		if missedExit then
			UDGCoreRPGCombatHighlighterTokenManager.onHover(missedExit, false);
		end
]]
		--clearing missed clears
		local winCtHighlight = UDGCoreRPGCombatHighlighterTokenManager.winCtHighlight;
		if winCtHighlight and winCtHighlight.updateDisplay then
			winCtHighlight.updateDisplay();
			UDGCoreRPGCombatHighlighterTokenManager.winCtHighlight = nil;
		end
--[[
		local nodeCtUnderlayed = UDGCoreRPGCombatHighlighterTokenManager.nodeCtUnderlayed
		if nodeCtUnderlayed and (not state or (nodeCT and nodeCtUnderlayed ~= nodeCT)) then
			UDGCoreRPGCombatHighlighterCommon.removeUnderlay(nodeCtUnderlayed);
			UDGCoreRPGCombatHighlighterTokenManager.nodeCtUnderlayed = nil;
		end
]]
		local tokenUnderlayed = UDGCoreRPGCombatHighlighterTokenManager.tokenUnderlayed
		if tokenUnderlayed and (not state or (tokenUnderlayed ~= tokenCT)) then
			UDGCoreRPGCombatHighlighterCommon.removeUnderlay(tokenUnderlayed);
			UDGCoreRPGCombatHighlighterTokenManager.tokenUnderlayed = nil;
		end

		if tokenCT then
			local CTHoverOnHighlightToken = OptionsManager.isOption(
				"CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_ON_HIGHLIGHT_TOKEN", "on"
			);

			if state then
				--local imageControl = ImageManager.getImageControl(tokenCT);

				--if imageControl and CTHoverOnHighlightToken then
				if CTHoverOnHighlightToken then
					UDGCoreRPGCombatHighlighterCommon.addHoverUnderlay(tokenCT, nodeCT);
					--UDGCoreRPGCombatHighlighterTokenManager.nodeCtUnderlayed = nodeCT;
					UDGCoreRPGCombatHighlighterTokenManager.tokenUnderlayed = tokenCT;
				end
			else
				if CTHoverOnHighlightToken then
--[[
					UDGCoreRPGCombatHighlighterCommon.removeUnderlay(nodeCT);
					if UDGCoreRPGCombatHighlighterTokenManager.nodeCtUnderlayed == nodeCT then
						UDGCoreRPGCombatHighlighterTokenManager.nodeCtUnderlayed = nil;
					end
]]
					UDGCoreRPGCombatHighlighterCommon.removeUnderlay(tokenCT);
					if UDGCoreRPGCombatHighlighterTokenManager.tokenUnderlayed == tokenCT then
						UDGCoreRPGCombatHighlighterTokenManager.tokenUnderlayed = nil;
					end
				end
			end
		end

--[[
		UDGCoreRPGCombatHighlighterTokenManager.nodeLastHover = nodeCT;
		UDGCoreRPGCombatHighlighterTokenManager.bLastHoverEnter = state;
		UDGCoreRPGCombatHighlighterTokenManager.nLastId = nil;
]]
	end

	if super and super.onHover then super.onHover(state) end
end
