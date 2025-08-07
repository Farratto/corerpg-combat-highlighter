-- Please see the LICENSE.txt file included with this distribution for
-- attribution and copyright information.

--luacheck: globals onHover addHoverUnderlay updateDisplay handleStatusOnUpdate
--luacheck: globals UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS

UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS = {};

function onInit()
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_tracker_host_ct_entry_override.lua::onInit"});

	if super and super.onInit then super.onInit() end

	DB.addHandler(getDatabaseNode().getPath("status"), "onUpdate", handleStatusOnUpdate);

	updateDisplay();
end

function onClose()
	DB.removeHandler(getDatabaseNode().getPath('status'), 'onUpdate', handleStatusOnUpdate);

	if super and super.onClose then return super.onClose() end
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

		--clearing missed clears
		local winCtHighlight = UDGCoreRPGCombatHighlighterTokenManager.winCtHighlight;
		--if winCtHighlight and type(winCtHighlight) == 'windowinstance'
		if winCtHighlight and Interface.isWindowClass(winCtHighlight)
			and winCtHighlight.updateDisplay --luacheck: ignore 143
		then
			winCtHighlight.updateDisplay(); --luacheck: ignore 143
			UDGCoreRPGCombatHighlighterTokenManager.winCtHighlight = nil;
		end
		local tokenUnderlayed = UDGCoreRPGCombatHighlighterTokenManager.tokenUnderlayed;
		if tokenUnderlayed and (not state or (tokenUnderlayed ~= tokenCT)) then
			UDGCoreRPGCombatHighlighterCommon.removeUnderlay(tokenUnderlayed);
			UDGCoreRPGCombatHighlighterTokenManager.tokenUnderlayed = nil;
		end

		if tokenCT then
			local CTHoverOffTokenSelect = OptionsManager.getOption(
				"CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_OFF_TOKEN_SELECT"
			);
			local CTHoverOnSelectToken = OptionsManager.isOption(
				"CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_ON_SELECT_TOKEN", "on"
			);
			local AutomaticallyOpenWindow = OptionsManager.isOption(
				"CORERPG_COMBAT_HIGHLIGHTER_AUTOMATICALLY_OPEN_WINDOW", "on"
			);
			local AutomaticallyFocusOnWindow = OptionsManager.isOption(
				"CORERPG_COMBAT_HIGHLIGHTER_AUTOMATICALLY_FOCUS_ON_WINDOW", "on"
			);
			local CTHoverOnHighlightToken = OptionsManager.isOption(
				"CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_ON_HIGHLIGHT_TOKEN", "on"
			);
			local CTHoverOnCenterOnToken = OptionsManager.isOption(
				"CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_ON_CENTER_ON_TOKEN", "on"
			);
			local CTHoverOffCenterOnActiveCombatant = OptionsManager.isOption(
				"CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_OFF_CENTER_ON_ACTIVE_TOKEN", "on"
			);

			if state then
				local imageControl, windowInstance = ImageManager.getImageControl(tokenCT
					, AutomaticallyOpenWindow
				);

				if windowInstance and AutomaticallyFocusOnWindow then windowInstance.bringToFront() end

				if imageControl then
					UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS = imageControl.getSelectedTokens();

					if CTHoverOnHighlightToken then
						UDGCoreRPGCombatHighlighterCommon.addHoverUnderlay(tokenCT, nodeCT);
						UDGCoreRPGCombatHighlighterTokenManager.tokenUnderlayed = tokenCT;
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
					UDGCoreRPGCombatHighlighterCommon.removeUnderlay(tokenCT);
					if UDGCoreRPGCombatHighlighterTokenManager.tokenUnderlayed == tokenCT then
						UDGCoreRPGCombatHighlighterTokenManager.tokenUnderlayed = nil;
					end
				end

				local imageControl = ImageManager.getImageControl(tokenCT, AutomaticallyOpenWindow);

				if imageControl then
					if CTHoverOffTokenSelect ~= "off" then imageControl.clearSelectedTokens() end

					if CTHoverOffTokenSelect == "current" then
						if UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS then
							for _,token in pairs(UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS) do
								if token then
									imageControl.selectToken(token.getId(), true);
									local node = CombatManager.getCTFromToken(token);
									if node then TokenManager.updateSizeHelper(token, node) end
								end
							end
						end
					elseif CTHoverOffTokenSelect == "active_ct_token" then
						local activeCT = CombatManager.getActiveCT();
						if activeCT then
							local activeToken = CombatManager.getTokenFromCT(activeCT);
							if activeToken then
								local cImage, windowInstance = ImageManager.getImageControl(activeToken
									, AutomaticallyOpenWindow
								);
								if windowInstance and AutomaticallyFocusOnWindow then
									windowInstance.bringToFront();
								end

								cImage.selectToken(activeToken.getId(), true);
								TokenManager.updateSizeHelper(activeToken, activeCT);
							end
						end
					end

					if CTHoverOffCenterOnActiveCombatant then
						local activeCT = CombatManager.getActiveCT();
						if activeCT then
							local activeToken = CombatManager.getTokenFromCT(activeCT);
							if activeToken then
								local cImage = ImageManager.getImageControl(activeToken, AutomaticallyOpenWindow);
								cImage.setViewpoint(activeToken.getPosition());
							end
						end
					end
				end
				UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS = {};
			end
		end
	end

	if super and super.onHover then return super.onHover(state) end
end

--no longer in use.  using addBitmapWidget() instead.  seems faster, looks the same
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

	if super and super.updateDisplay then super.updateDisplay() end

	local node = getDatabaseNode();
	local status = DB.getValue(node, "status");

	local greyOutInactiveCombatants = OptionsManager.isOption(
		"CORERPG_COMBAT_HIGHLIGHTER_GREY_OUT_INACTIVE_COMBATANTS", "on"
	);

	if greyOutInactiveCombatants then
		if string.match(status, "Dying") or string.match(status, "Disabled") or string.match(status, "Dead")
			or string.match(status, "Unconcious")
		then
			setFrame("ctentrybox_inactive");
		end
	end
end

function handleStatusOnUpdate(statusNode)
	UDGCoreRPGCombatHighlighterHelper.verbose({
		"combat_tracker_host_ct_entry_override.lua::handleStatusOnUpdate(statusNode)", "statusNode:", statusNode
	});

	updateDisplay();
end