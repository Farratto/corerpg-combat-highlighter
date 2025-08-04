## Combat Highlighter
**Current Version**: ~v-dev~ \
**Updated**: ~date~

A little diddy to make things mo betta when it comes to combat in Fantasy Grounds. It doesn't do much, but what it does I find super handy and will work with any ruleset using the CoreRPG ruleset.

### Installation

Install from the [Fantasy Grounds Forge](https://forge.fantasygrounds.com/shop/items/289/view). \
You can find the source code at Farratto's [GitHub](https://github.com/Farratto/corerpg-combat-highlighter). \
You can ask questions at the [Fantasy Grounds Forum](https://www.fantasygrounds.com/forums/showthread.php?66336).

### Details

Features:

* GM: On turn start, select matching token to combat tracker entry
  * menu option to toggle this behavior

* GM: Grey out combatants unable to perform actions
  * menu option to toggle this behavior

* GM: Any action performed on a token will automatically open the map containing the token first, if not open
  * menu option to toggle this behavior

* GM: Any action performed on a token will automatically focus on the map containing the token first, if not focused
  * menu option to toggle this behavior

* GM: Hovering over entry in combat tracker will highlight the matching token on the map
  * menu option to toggle this behavior

* GM: hovering over entry in combat tracker will select the matching token on the map
  * menu option to toggle this behavior

* GM: hovering over entry in combat tracker will center on the matching token on the map
  * menu option to toggle this behavior

* GM: hovering off entry in combat tracker will center on the matching token to active CT entry
  * menu option to toggle this behavior

* GM: hovering off entry in combat tracker has options as to which tokens to select on map
  * menu option to customize this behavior

* All: Hovering over token on the map will scroll to and highlight the associated entry in the combat tracker
  * Menu option to toggle this behavior

* All: Hovering off the token will then scroll back to active combat tracker entry
  * Menu option to toggle this behavior

* Players: Double clicking on token of owned PC in the combat tracker will open the map the token is on, if any

Menu Option explanations:

* Select Token On Turn Start
  * When set, this will automatically select (identical to left clicking) the token matching the combat tracker entry when that combatant's turn starts

* Grey Out Inactive Combatants
  * This is tied to the 'status' field that is updated by Fantasy Grounds automatically. This field is just a function of max hit points vs current wounds. When this field is set to something that suggests the actor cannot perform any actions, the row is greyed out. It is not disabled or anything else, it is just a visual indicator.
	* Current status values that will cause this: Dead, Dying, Unconcious, Disabled

* Disable All Functionality When Dragging
  * When set, this will turn off all highlighting functionality when dragging anything (clicking and dragging dice, etc)

* Automatically Open Window Containing Token
  * When set, if a combat tracker entry has an associated token on a map, that map will be opened when hovering over the combat tracker entry

* Automatically Focus on Window Containing Token
  * When set, if a combat tracker entry has an associated token on a map, that map will be brought to the front when hovering over the combat tracker entry

* Combat Tracker Hover On Selects Matching Token
  * Whether or not when hovering over an entry in the combat tracker, the matching token on the map (if any) is selected - the same as left clicking on the token

* Combat Tracker Hover On Highlights Matching Token
  * Whether or not when hovering over an entry in the combat tracker, the matching token on the map (if any) is highlighted with an underlay
  * Note: All clients can see this underlay.

* Combat Tracker Hover On Centers on Matching Token
  * Whether or not when hovering over an entry in the combat tracker, the matching token on the map (if any) is centered on the map

* Combat Tracker Hover Off Centers on Active Combatant Token
  * Whether or not when hovering off an entry in the combat tracker, the matching token (if any) to the currently active entry in the combat tracker is centered on the map

* Combat Tracker Hover Off Token Select
  * Which tokens (if any) to select (same as left clicking) on the map when hovering off an entry in the combat tracker
  * Current Token(s): The tokens that were selected (if any) before hovering on the combat tracker
  * Active CT Token: The matching token (if any) to the currently active entry in the combat tracker
  * None: Unselect all tokens on map when hovering off combat tracker
  * Off: Makes no changes to selected tokens

* Token Hover On Scrolls To Matching CT Entry
  * Whether or not to scroll to the matching combat tracker entry (if any) of a token when hovering over the token, if that entry currently isn't visible in the combat tracker

* Token Hover On Highlights Matching CT Entry
  * Whether or not to change the color of the matching combat tracker entry (if any) of a token when hovering over the token

* Token Hover Off Scrolls Back To Active CT Entry
  * Whether or not to scroll back to the active combat tracker entry (if any) when hovering off a token

### Attribution

OgreManDude is the author of Combat Highlighter.  Farratto now maintains this extension with permission from OgreManDude. \
SmiteWorks owns rights to code sections copied from their rulesets by permission for Fantasy Grounds community development. \
headerpoweratwill.webp and headerpowerenc.webp copied from included Smiteworks themes. \
'Fantasy Grounds' is a trademark of SmiteWorks USA, LLC. \
'Fantasy Grounds' is Copyright 2004-2021 SmiteWorks USA LLC.

Proud member of the [Fantasy Grounds Unofficial Developer's Guild!](https://gitlab.com/fantasy-grounds-unofficial-developers-guild)

Much Thanks To:
Kelrugem, MeAndUnique, Celestian, damned, Moon Wizard, tahl_liadon for answering my many questions and providing code, graphics, guidance, etc.

Want to become a member of the Fantasy Grounds Unofficial Developers Guild? [Join up!](https://discord.gg/yAXPgR8Bc8) It'll give you [developer](https://docs.gitlab.com/ee/user/permissions.html) access to this repository (and hopefully others soon!)

### Change Log

* v1.8.6: FIXED: rare errors on client side.
* v1.8.5: FIXED: was not correctly evaluating sizes with modified sizes from Go Big or Go Gnome
* v1.8.4: FIXED: very rare console errors. Increased stability
* v1.8.3: FIXED: rare console errors; wrong version number
* v1.8.2: In extension list: renamed to Feature: Combat Highlighter (no functional difference). Removed redundant feature: select token on turn start. Now maintained by Farratto.
* v1.8.1: Improved stability and reliability of highlighting and clearing highlighting
* v1.8.0: Added support for Client-side token highlighting on CT hover. Improved interaction with other extensions that was causing disappearing or misplaced graphics
* v1.7.7: Added and Fixed: Rare bug with handling of overlapping tokens fixed; Occasional error window when loading new map fixed; Added option to disable token selection upon hovering off CT entries; Made client-side options controllable by clients; Fixed bug where GM hovering CT can be seen from client-side
* v1.7.6: Fix for tokens close together compliments of Farratto.
* v1.7.5: Adding Pathfinder 2 Legacy as an allowed ruleset.
* v1.7.4: Adding Call of Cthulu as an allowed ruleset.
* v1.7.3: Added: When centering on tokens, current zoom level is respected.
* v1.7.2: Added menu option to toggle whether or not to disable when dragging. Defaults to off.
* v1.7.1: Added: All funtionality disabled when dragging anything (dice, etc)
* v1.7.0: Added: Menu option as to whether or not to automatically open a map containing a token; Menu option as to whether or not to automatically focus on a map containing a token
* v1.6.1-2021-10-13: Fixed issue with tokens on multiple maps causing strange behavior
* v1.6.1: Added: Hovering over combat tracker entry will open and bring to front map that contains token
* v1.6.0-2021-03-23: Added: Hovering over CT will now open associated map and bring it to the front
* v1.6.0: Fixed: Having tokens on multiple maps was resulting in strange behavior
* v1.5.3-2021-03-23: On turn start, matching token to active CT entry (if any) is selected with Menu option to toggle this. Grey out CT entry of any actor that has a status that makes them incapable of performing actions: Currently 'Dead', 'Dying', 'Unconcious', 'Disabled'; with Menu option to toggle this
* v1.5.3: Renamed some scripts
* v1.5.2-2021-03-20: Fixed: Hovering off CT caused issues when active CT had no matching token
* v1.5.2: Added: Conan 2d20 ruleset added as allowed ruleset
* v1.5.1-2021-03-19: Toned down combat tracker highlight color
* v1.5.0-2021-03-18: Added menu option as to which tokens are selected when overing off CT entry
* v1.5.0: Lua scripts moved out of xml into files
* v1.4.1-2021-03-10: Fixed: Hovering over token without matching CT entry resulted in error
* v1.4.0-2021-03-09: Added menu option added as to whether hover over token highlights matching CT entry
* v1.4.0: Refactoring onHover method to deal with above implementation
* v1.3.1-2021-03-09: Fixed: Menu options having a blank value
* v1.3.0-2021-03-09: Added: Hovering off CT entry now centers map to active CT entry with menu option to toggle this behavior
* v1.3.0: Menu option added as to whether hovering over CT entry highlights matching token on map
* v1.3.0: Maintenance: Various variable renaming in an attempt to arrive at some sort of consistency
* v1.2.0-2021-03-08: Added: Hovering over CT entry now centers map to matching token with menu option to toggle this behavior
* v1.1.1-2021-03-04: Fixed: Client hovering over CT was causing issues
* v1.1.0-2021-03-04: Hovering anywhere on the CT entry now highlights the matching token. Highlight underlay now matches reach of token. Hovering over CT entry now selects matching token with menu option to toggle this behavior. Hovering over token on map will scroll to matching combat tracker entry with menu option to toggle this behavior. Hovering off token on map will scroll to actice combat tracker entry with menu option to toggle this behavior.
* v1.0.2-2021-03-01: Added: Extension announcement text; Added all CoreRPG rulesets as allowable. Replaced User.isHost() with Session.IsHost
* v1.0.1-2021-02-23: Renaming all script imports to avoid collisions with other extensions
* v1.0.0-2021-02-17: Added: When client double clicks on owned token in combat tracker, associated map is opened; Hovering over token on map highlights combat entry; Hovering over token in combat tracker highlights token on map.