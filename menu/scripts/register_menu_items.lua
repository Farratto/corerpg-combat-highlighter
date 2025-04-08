-- Please see the LICENSE.txt file included with this distribution for
-- attribution and copyright information.

--luacheck: globals registerMenuItems

function onInit()
	UDGCoreRPGCombatHighlighterHelper.verbose({"register_menu_items.lua::onInit()"});

	registerMenuItems();
end

function registerMenuItems()
	UDGCoreRPGCombatHighlighterHelper.verbose({"register_menu_items.lua::registerMenuItems()"});
--luacheck: push ignore 631
	OptionsManager.registerOption2("CORERPG_COMBAT_HIGHLIGHTER_DEBUG", false, "menu_option_header_corerpg_combat_highlighter", "menu_option_header_corerpg_combat_highlighter_debug", "option_entry_cycler", { labels = "option_val_off|option_val_debug|option_val_verbose", values = "off|debug|verbose", default = "off" });

	OptionsManager.registerOption2("CORERPG_COMBAT_HIGHLIGHTER_DISABLE_FUNCTIONALITY_WHEN_DRAGGING", true, "menu_option_header_corerpg_combat_highlighter", "menu_option_corerpg_combat_highlighter_disable_functionality_when_dragging", "option_entry_cycler", { labels = "option_val_off", values = "off", baselabel="option_val_on", baseval="on", default = "on" });

	--OptionsManager.registerOption2("CORERPG_COMBAT_HIGHLIGHTER_SELECT_TOKEN_ON_TURN_START", false, "menu_option_header_corerpg_combat_highlighter", "menu_option_header_corerpg_combat_highlighter_select_token_on_turn_start", "option_entry_cycler", { labels = "option_val_off", values = "off", baselabel="option_val_on", baseval="on", default = "on" });

	OptionsManager.registerOption2("CORERPG_COMBAT_HIGHLIGHTER_GREY_OUT_INACTIVE_COMBATANTS", false, "menu_option_header_corerpg_combat_highlighter", "menu_option_header_corerpg_combat_highlighter_grey_out_inactive_combatants", "option_entry_cycler", { labels = "option_val_off", values = "off", baselabel="option_val_on", baseval="on", default = "on" });

	OptionsManager.registerOption2("CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_ON_SELECT_TOKEN", false, "menu_option_header_corerpg_combat_highlighter", "menu_option_header_corerpg_combat_highlighter_ct_hover_on_select_token", "option_entry_cycler", { labels = "option_val_on", values = "on", baselabel="option_val_off", baseval="off", default = "off" });

	OptionsManager.registerOption2("CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_ON_CENTER_ON_TOKEN", false, "menu_option_header_corerpg_combat_highlighter", "menu_option_header_corerpg_combat_highlighter_ct_hover_on_center_on_token", "option_entry_cycler", { labels = "option_val_on", values = "on", baselabel="option_val_off", baseval="off", default = "off" });

	OptionsManager.registerOption2("CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_ON_HIGHLIGHT_TOKEN", true, "menu_option_header_corerpg_combat_highlighter", "menu_option_header_corerpg_combat_highlighter_ct_hover_on_highlight_token", "option_entry_cycler", { labels = "option_val_off", values = "off", baselabel="option_val_on", baseval="on", default = "on" });

	OptionsManager.registerOption2("CORERPG_COMBAT_HIGHLIGHTER_AUTOMATICALLY_OPEN_WINDOW", false, "menu_option_header_corerpg_combat_highlighter", "menu_option_header_corerpg_combat_highlighter_automatically_open_window", "option_entry_cycler", { labels = "option_val_on", values = "on", baselabel="option_val_off", baseval="off", default = "off" });

	OptionsManager.registerOption2("CORERPG_COMBAT_HIGHLIGHTER_AUTOMATICALLY_FOCUS_ON_WINDOW", false, "menu_option_header_corerpg_combat_highlighter", "menu_option_header_corerpg_combat_highlighter_automatically_focus_on_window", "option_entry_cycler", { labels = "option_val_on", values = "on", baselabel="option_val_off", baseval="off", default = "off" });

	OptionsManager.registerOption2("CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_OFF_CENTER_ON_ACTIVE_TOKEN", false, "menu_option_header_corerpg_combat_highlighter", "menu_option_header_corerpg_combat_highlighter_ct_hover_off_center_on_active_token", "option_entry_cycler", { labels = "option_val_on", values = "on", baselabel="option_val_off", baseval="off", default = "off" });

	OptionsManager.registerOption2("CORERPG_COMBAT_HIGHLIGHTER_CT_HOVER_OFF_TOKEN_SELECT", false, "menu_option_header_corerpg_combat_highlighter", "menu_option_header_corerpg_combat_highlighter_ct_hover_off_token_select", "option_entry_cycler", { labels = "option_val_off|option_val_active_ct_token|option_val_none|option_val_current_token", values = "off|active_ct_token|none|current", baselabel="option_val_off", baseval="off", default = "off" });

	OptionsManager.registerOption2("CORERPG_COMBAT_HIGHLIGHTER_TOKEN_HOVER_ON_AUTO_SCROLL_TO_CT_ENTRY", true, "menu_option_header_corerpg_combat_highlighter", "menu_option_corerpg_combat_highlighter_token_hover_on_auto_scroll_to_ct_entry", "option_entry_cycler", { labels = "option_val_on", values = "on", baselabel="option_val_off", baseval="off", default = "off" });

	OptionsManager.registerOption2("CORERPG_COMBAT_HIGHLIGHTER_TOKEN_HOVER_ON_HIGHLIGHT_CT_ENTRY", true, "menu_option_header_corerpg_combat_highlighter", "menu_option_corerpg_combat_highlighter_token_hover_on_highlight_ct_entry", "option_entry_cycler", { labels = "option_val_off", values = "off", baselabel="option_val_on", baseval="on", default = "on" });

	OptionsManager.registerOption2("CORERPG_COMBAT_HIGHLIGHTER_TOKEN_HOVER_OFF_AUTO_SCROLL_TO_ACTIVE_CT_ENTRY", true, "menu_option_header_corerpg_combat_highlighter", "menu_option_corerpg_combat_highlighter_token_hover_off_auto_scroll_to_active_ct_entry", "option_entry_cycler", { labels = "option_val_on", values = "on", baselabel="option_val_off", baseval="off", default = "off" });
--luacheck: pop
end
