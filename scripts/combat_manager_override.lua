-- Please see the LICENSE.txt file included with this distribution for
-- attribution and copyright information.

--luacheck: globals customTurnStart updateCTDisplays

function onInit()
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_manager_override.lua::onInit()"});

	--CombatManager.setCustomTurnStart(customTurnStart);

	OptionsManager.registerCallback("CORERPG_COMBAT_HIGHLIGHTER_GREY_OUT_INACTIVE_COMBATANTS", updateCTDisplays);
end


function customTurnStart(nodeCT)
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_manager_override.lua::customTurnStart(nodeCT)", "nodeCT:", nodeCT});

	local selectTokenOnTurnStart = OptionsManager.isOption("CORERPG_COMBAT_HIGHLIGHTER_SELECT_TOKEN_ON_TURN_START", "on");

	if selectTokenOnTurnStart  then
		local tokenCT = CombatManager.getTokenFromCT(nodeCT);

		if tokenCT then
			local imageControl = ImageManager.getImageControl(tokenCT, false);
			if imageControl then
				imageControl.clearSelectedTokens();
				imageControl.selectToken(tokenCT.getId(), true);
			end
		end
	end
end

function updateCTDisplays()
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_manager_override.lua::updateCTDisplays()"});

	local combatants = CombatManager.getCombatantNodes();

	for _,node in pairs(combatants) do
		local ceWindow = UDGCoreRPGCombatHighlighterCombatManagerHelper.getCombatEntryWindowFromNode(node);

		if ceWindow then
			ceWindow.updateDisplay();
		end
	end
end
