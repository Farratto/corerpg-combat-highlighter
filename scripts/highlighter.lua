-- Please see the LICENSE.txt file included with this distribution for
-- attribution and copyright information.

--luacheck: globals addHoverUnderlay removeUnderlay onCtDelete

function onInit()
	CombatManager.setCustomPreDeleteCombatantHandler(onCtDelete);
end

function addHoverUnderlay(tokenCT, nodeCT)
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_tracker_host_ct_entry_override.lua::addHoverUnderlay()"});
	if not tokenCT and not nodeCT then
		Debug.console("Higlighter.addHoverUnderlay - not tokenCT and not nodeCT");
		return;
	end
	if not tokenCT then tokenCT = CombatManager.getTokenFromCT(nodeCT) end
	if not tokenCT then return end

	if not nodeCT then nodeCT = CombatManager.getCTFromToken(tokenCT) end

	local widgetUnderlay = tokenCT.findWidget('ulay');
	if widgetUnderlay then widgetUnderlay.destroy() end
	local widgetUnderlay3D = tokenCT.findWidget('ulay3D');
	if widgetUnderlay3D then widgetUnderlay3D.destroy() end

	local nDU = GameSystem.getDistanceUnitsPerGrid();

	local nSpace = DB.getValue(nodeCT, 'currentspace');
	if not nSpace then nSpace = DB.getValue(nodeCT, 'space', nDU) end
	nSpace = nSpace / nDU;

	local nHalfSpace = nSpace / 2;
	local nReach = DB.getValue(nodeCT, 'currentreach');
	if not nReach then nReach = DB.getValue(nodeCT, 'reach', nDU) end
	nReach = ((nReach / nDU) + nHalfSpace) * 200;

	local sAsset = 'images/Extensions/combat_highlighter.webp@CombatHighlighter';
	local tWidget = {
		name = 'ulay',
		asset = sAsset,
		w = nReach, h = nReach,
		displaytype = 'underlay',
		displaymode = '2D',
	};
	local wgt = tokenCT.addBitmapWidget(tWidget);
	if wgt then wgt.sendToBack() end

	local tWidget3D = {
		name = 'ulay3D',
		asset = sAsset,
		w = nReach, h = nReach,
		displaytype = 'floor',
		displaymode = '3D',
	};
	local wgt3D = tokenCT.addBitmapWidget(tWidget3D);
	if wgt3D then wgt3D.sendToBack() end
end

function removeUnderlay(tokenMap)
	if type(tokenMap) == 'tokeninstance' then
		local widgetUnderlay = tokenMap.findWidget('ulay');
		if widgetUnderlay then widgetUnderlay.destroy() end
		local widgetUnderlay3D = tokenMap.findWidget('ulay3D');
		if widgetUnderlay3D then widgetUnderlay3D.destroy() end
	end
end

function onCtDelete(nodeCT)
	local winCT = UDGCoreRPGCombatHighlighterCombatManagerHelper.getCombatEntryWindowFromNode(nodeCT);
	if winCT and winCT == UDGCoreRPGCombatHighlighterTokenManager.winCtHighlight then
		UDGCoreRPGCombatHighlighterTokenManager.winCtHighlight = nil;
	end

	local tokenCT = CombatManager.getTokenFromCT(nodeCT);
	if tokenCT then
		if tokenCT == UDGCoreRPGCombatHighlighterTokenManager.tokenUnderlayed then
			UDGCoreRPGCombatHighlighterTokenManager.tokenUnderlayed = nil;
		end

		if Session.IsHost then
			local winCT = Interface.findWindow('combattracker_host', 'combattracker');
			if winCT then
				for _,win in ipairs(winCT.list.getWindows()) do
					local tSelectedTokens = win.UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS
					for k,tokenMap in ipairs(tSelectedTokens) do
						if tokenMap == tokenCT then
							win.UDGCORERPGCOMBATHIGHLIGHTERCURRENTLYSELECTEDTOKENS[k] = nil;
						end
					end
				end
			end
		end
	end
end