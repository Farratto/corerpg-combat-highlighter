function onInit()
	UDGCoreRPGCombatHighlighterHelper.verbose("helper_functions.lua::onInit()");
end

function verbose(messages)
	local debugOption = OptionsManager.getOption("CORERPG_COMBAT_HIGHLIGHTER_DEBUG");
	if debugOption == "verbose" then
		for _, message in ipairs(messages) do
			Debug.console(message);
		end
		Debug.console("**************************************************************");
	end
end

function debug(title, message)
	local debugOption = OptionsManager.getOption("CORERPG_COMBAT_HIGHLIGHTER_DEBUG");
	if debugOption == "debug" or debugOption == "verbose" then
		Debug.console(title);
		Debug.console(message);
		Debug.console("**************************************************************");
	end
end

function outputDBNode(node)
	local debugOption = OptionsManager.getOption("CORERPG_COMBAT_HIGHLIGHTER_DEBUG");
	if debugOption == "debug" or debugOption == "verbose" then
		Debug.console("**************************************************************");
		Debug.console("Database Node: " .. node.getNodeName());
		Debug.console(node);
		for key,value in pairs(node.getChildren()) do
			Debug.console("Key: " .. key);
			Debug.console(value.getValue());
		end
		Debug.console("End of Database Node: " .. node.getNodeName());
		Debug.console("**************************************************************");
	end
end
