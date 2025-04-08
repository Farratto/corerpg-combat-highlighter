-- Please see the LICENSE.txt file included with this distribution for
-- attribution and copyright information.

--luacheck: globals getCombatEntryWindowFromToken getCombatEntryWindowFromNode

function onInit()
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_manager_helper.lua::onInit()"});
end

function getCombatEntryWindowFromToken(token)
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_manager_helper.lua::getCombatEntryWindowFromToken(token)"
		, "token: ", token
	});

	local nodeCT = CombatManager.getCTFromToken(token);

	if nodeCT then return getCombatEntryWindowFromNode(nodeCT) end
end

function getCombatEntryWindowFromNode(nodeCT)
	UDGCoreRPGCombatHighlighterHelper.verbose({"combat_manager_helper.lua::getCombatEntryWindowFromNode(nodeCT)"
		, "nodeCT: ", nodeCT
	});

	local combatTrackerWindow, windowPath, matchingWindow;

	if Session.IsHost then
		combatTrackerWindow = Interface.findWindow("combattracker_host", "combattracker");
	else
		combatTrackerWindow = Interface.findWindow("combattracker_client", "combattracker");
	end

	if combatTrackerWindow then windowPath = combatTrackerWindow.list end

	if windowPath and nodeCT then
		local sNodeID = nodeCT.getPath();

		for _,v in pairs(windowPath.getWindows(true)) do
			local node = v.getDatabaseNode();
			if node.getPath() == sNodeID then
				matchingWindow = v;
			end
		end
	end

	return matchingWindow;
end