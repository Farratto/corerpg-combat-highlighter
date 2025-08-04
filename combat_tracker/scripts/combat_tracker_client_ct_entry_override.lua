-- Please see the LICENSE.txt file included with this distribution for
-- attribution and copyright information.

--luacheck: globals onHover

function onInit()
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_tracker_client_override.lua::onInit"});

	if super and super.onInit then return super.onInit() end
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
		if winCtHighlight and type(winCtHighlight) == 'windowinstance'
			and winCtHighlight.updateDisplay --luacheck: ignore 143
		then
			winCtHighlight.updateDisplay(); --luacheck: ignore 143
			UDGCoreRPGCombatHighlighterTokenManager.winCtHighlight = nil;
		end
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

				if CTHoverOnHighlightToken then
					UDGCoreRPGCombatHighlighterCommon.addHoverUnderlay(tokenCT, nodeCT);
					UDGCoreRPGCombatHighlighterTokenManager.tokenUnderlayed = tokenCT;
				end
			else
				if CTHoverOnHighlightToken then
					UDGCoreRPGCombatHighlighterCommon.removeUnderlay(tokenCT);
					if UDGCoreRPGCombatHighlighterTokenManager.tokenUnderlayed == tokenCT then
						UDGCoreRPGCombatHighlighterTokenManager.tokenUnderlayed = nil;
					end
				end
			end
		end
	end

	if super and super.onHover then return super.onHover(state) end
end
