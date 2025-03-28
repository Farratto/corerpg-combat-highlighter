
# CoreRPG Combat Highlighter for FGU

<note from Farratto: this is repository is just a placeholder for pre-releases. You can come here to find new versions that have not hit the forge yet.>

A little diddy to make things mo betta when it comes to combat in Fantasy Grounds. It doesn't do much, but what it does I find super handy and will work with any ruleset using the CoreRPG ruleset.

[Download](https://gitlab.com/ccthiel/CoreRPG-Combat-Highlighter/-/jobs/artifacts/latest/file/CoreRPG-Combat-Highlighter.ext?job=build-extension) the latest version of the plugin!

[Gitlab repository](https://gitlab.com/ccthiel/CoreRPG-Combat-Highlighter)

[Fantasy Grounds Forum Thread](https://www.fantasygrounds.com/forums/showthread.php?66336-CoreRPG-Combat-Highlighter&p=581044#post581044)

[Discord Channel](https://discord.com/channels/812870526455250945/813173777663131659)

Proud member of the [Fantasy Grounds Unofficial Developer's Guild!](https://gitlab.com/fantasy-grounds-unofficial-developers-guild)

Much Thanks To:
Kelrugem, MeAndUnique, Celestian, damned, Moon Wizard, tahl_liadon for answering my many questions and providing code, graphics, guidance, etc.
Contributions to extension:
Farratto for helping make it easier to deal with tokens close together

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

Please see [Bug Reporting](https://gitlab.com/ccthiel/CoreRPG-Combat-Highlighter/-/blob/main/BUG_REPORT.md) when it comes to filing a bug. I'd absolutely weclome people reporting bugs (or even forking the repository and submitting a merge request!), but please do a bit of work on your part to make my life easier. Thank you!

Want to become a member of the Fantasy Grounds Unofficial Developers Guild? [Join up!](https://discord.gg/yAXPgR8Bc8) It'll give you [developer](https://docs.gitlab.com/ee/user/permissions.html) access to this repository (and hopefully others soon!)
