UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS = nil;

function onInit()
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_tracker_host_ct_entry_override.lua::onInit"});

	if super and super.onInit then
		super.onInit();
	end

	DB.addHandler(getDatabaseNode().getPath("status"), "onUpdate", handleStatusOnUpdate);

	updateDisplay();
end

function onHover(state)
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_tracker_host_ct_entry_override.lua::onHover(state)", "state: ", state});

	if OptionsManager.isOption("CORERPG_COMBAT_HIGHLIGHTER_DISABLE_FUNCTIONALITY_WHEN_DRAGGING", "on") and Input.getDragData() then
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
				--we need to clear token selection data, as it is no longer valid
				UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS = nil;
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
			winCtHighlight = nil;
			UDGCoreRPGCombatHighlighterTokenManager.winCtHighlight = nil;
		end
		local nodeCtUnderlayed = UDGCoreRPGCombatHighlighterTokenManager.nodeCtUnderlayed
		if nodeCtUnderlayed and (not state or (nodeCT and nodeCtUnderlayed ~= nodeCT)) then
			UDGCoreRPGCombatHighlighterCommon.removeUnderlay(nodeCtUnderlayed);
			nodeCtUnderlayed = nil;
			UDGCoreRPGCombatHighlighterTokenManager.nodeCtUnderlayed = nil;
		end

		if tokenCT then
			local CTHoverOffTokenSelect = OptionsManager.getOption("CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_OFF_TOKEN_SELECT");
			local CTHoverOnSelectToken = OptionsManager.isOption("CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_ON_SELECT_TOKEN", "on");
			local AutomaticallyOpenWindow = OptionsManager.isOption("CORERPG_COMBAT_HIGHLIGHTER_AUTOMATICALLY_OPEN_WINDOW", "on");
			local AutomaticallyFocusOnWindow = OptionsManager.isOption("CORERPG_COMBAT_HIGHLIGHTER_AUTOMATICALLY_FOCUS_ON_WINDOW", "on");
			local CTHoverOnHighlightToken = OptionsManager.isOption("CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_ON_HIGHLIGHT_TOKEN", "on");
			local CTHoverOnCenterOnToken = OptionsManager.isOption("CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_ON_CENTER_ON_TOKEN", "on");
			local CTHoverOffCenterOnActiveCombatant = OptionsManager.isOption("CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_OFF_CENTER_ON_ACTIVE_TOKEN", "on");
	
			local imageControl, windowInstance, _bWindowOpened = nil, nil, nil;
	
			if state then
				imageControl, windowInstance, _bWindowOpened  = ImageManager.getImageControl(tokenCT, AutomaticallyOpenWindow);
	
				if windowInstance and AutomaticallyFocusOnWindow then
					windowInstance.bringToFront()
				end
	
				if imageControl then
					UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS = imageControl.getSelectedTokens();
	
	
					if CTHoverOnHighlightToken then
						UDGCoreRPGCombatHighlighterCommon.addHoverUnderlay(tokenCT, nodeCT);
						UDGCoreRPGCombatHighlighterTokenManager.nodeCtUnderlayed = nodeCT;
					end
	
					if CTHoverOnSelectToken then
						imageControl.clearSelectedTokens();
						imageControl.selectToken(tokenCT.getId(), true);
					end
	
					if CTHoverOnCenterOnToken then
						local x, y = tokenCT.getPosition();
						local _, _, zoom = imageControl.getViewpoint();
						if x and y then
							imageControl.setViewpoint(x, y, zoom);
						end
					end
				end
	
			else
				if CTHoverOnHighlightToken then
					UDGCoreRPGCombatHighlighterCommon.removeUnderlay(nodeCT);
					if UDGCoreRPGCombatHighlighterTokenManager.nodeCtUnderlayed == nodeCT then
						UDGCoreRPGCombatHighlighterTokenManager.nodeCtUnderlayed = nil;
					end
				end
	
				imageControl, windowInstance, _bWindowOpened  = ImageManager.getImageControl(tokenCT, AutomaticallyOpenWindow);
	
				if imageControl then
	
					if CTHoverOffTokenSelect ~= "off" then imageControl.clearSelectedTokens() end
	
					if CTHoverOffTokenSelect == "current" then
						if UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS then
							for key,token in pairs(UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS) do
								if token and token.getId then
									imageControl.selectToken(token.getId(), true);
									--local node = CombatManager.getCTFromToken(token);
									local node = UDGCoreRPGCombatHighlighterCombatManagerHelper.getCTFromTokenSafe(token);
									if node then
										TokenManager.updateSizeHelper(token, node);
									end
								end
							end
						end
					elseif CTHoverOffTokenSelect == "active_ct_token" then
						local activeCT = CombatManager.getActiveCT();
						if activeCT then
							local activeToken = CombatManager.getTokenFromCT(activeCT);
							if activeToken then
								imageControl, windowInstance, _bWindowOpened  = ImageManager.getImageControl(activeToken, AutomaticallyOpenWindow);
								if windowInstance and AutomaticallyFocusOnWindow then
									windowInstance.bringToFront();
								end
	
								imageControl.selectToken(activeToken.getId(), true);
								TokenManager.updateSizeHelper(activeToken, activeCT);
							end
						end
					end
	
					if CTHoverOffCenterOnActiveCombatant then
						local activeCT = CombatManager.getActiveCT();
						if activeCT then
							local activeToken = CombatManager.getTokenFromCT(activeCT);
							if activeToken then
								imageControl, windowInstance, _bWindowOpened  = ImageManager.getImageControl(activeToken, AutomaticallyOpenWindow);
								imageControl.setViewpoint(activeToken.getPosition());
							end
						end
					end
				end
				UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS = nil;
			end
		end
--[[
		UDGCoreRPGCombatHighlighterTokenManager.nodeLastHover = nodeCT;
		UDGCoreRPGCombatHighlighterTokenManager.bLastHoverEnter = state;
		UDGCoreRPGCombatHighlighterTokenManager.nLastId = nil;
]]
	end

	if super and super.onHover then
		super.onHover(state);
	end
end

function addHoverUnderlay()
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_tracker_host_ct_entry_override.lua::addHoverUnderlay()"});
	local nodeCT = getDatabaseNode(); 
	local tokenCT = CombatManager.getTokenFromCT(nodeCT);

	local nDU = GameSystem.getDistanceUnitsPerGrid();

	local nSpace = math.ceil(DB.getValue(nodeCT, "space", nDU) / nDU);
	local nHalfSpace = nSpace / 2;
	local nReach = math.ceil(DB.getValue(nodeCT, "reach", nDU) / nDU) + nHalfSpace;

	-- add token hover underlay
	tokenCT.addUnderlay(nReach, UDGCoreRPGCombatHighlighterConstants.TOKEN_UNDERLAY_HOVER, "gmonly");
end

function updateDisplay()
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_tracker_host_ct_entry_override.lua::updateDisplay()"});

	if super and super.updateDisplay then
		super.updateDisplay();
	end

	local node = getDatabaseNode();
	local status = DB.getValue(node, "status");

	local greyOutInactiveCombatants = OptionsManager.isOption("CORERPG_COMBAT_HIGHLIGHTER_GREY_OUT_INACTIVE_COMBATANTS", "on");

	if greyOutInactiveCombatants then
		if string.match(status, "Dying") or string.match(status, "Disabled") or string.match(status, "Dead") or string.match(status, "Unconcious") then
			setFrame("ctentrybox_inactive");
		end
	end
end

function handleStatusOnUpdate(statusNode)
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_tracker_host_ct_entry_override.lua::handleStatusOnUpdate(statusNode)", "statusNode:", statusNode});

	updateDisplay();
end