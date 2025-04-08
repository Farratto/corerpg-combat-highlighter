# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]
### [1.8.1] Improved stability and reliability of highlighting and clearing highlighting compliments of Farratto
### [1.8.0] Added support for Client-side token highlighting on CT hover compliments of Farratto
- Improved interaction with other extensions that was causing disappearing or misplaced graphics
### [1.7.7] Added and Fixed compliments of Farratto
- Rare bug with handling of overlapping tokens fixed
- Occasional error window when loading new map fixed
- Added option to disable token selection upon hovering off CT entries
- Made client-side options controllable by clients
- Fixed bug where GM hovering CT can be seen from client-side

### [1.7.6] Fixed
- Fix for tokens close together compliments of Farratto.

### [1.7.5] Added

- Adding Pathfinder 2 Legacy as an allowed ruleset.

### [1.7.4] Added

- Adding Call of Cthulu as an allowed ruleset.

### [1.7.3] Added

- When centering on tokens, current zoom level is respected.

### [1.7.2] Added

- Added menu option to toggle whether or not to disable when dragging. Defaults to off.

### [1.7.1] Added

- All funtionality disabled when dragging anything (dice, etc)

### [1.7.0] Added

- Menu option as to whether or not to automatically open a map containing a token
- Menu option as to whether or not to automatically focus on a map containing a token

## [1.6.1] - 2021-10-13

### [1.6.1] Fixed

- Fixed issue with tokens on multiple maps causing strange behavior

### [1.6.1] Added

- Hovering over combat tracker entry will open and bring to front map that contains token

## [1.6.0] - 2021-03-23

### [1.6.0] Added

- Hovering over CT will now open associated map and bring it to the front

### [1.6.0] Fixed

- Having tokens on multiple maps was resulting in strange behavior

## [1.5.3] - 2021-03-23

### [1.5.3] Added

- On turn start, matching token to active CT entry (if any) is selected
  - Menu option to toggle this
- Grey out CT entry of any actor that has a status that makes them incapable of performing actions
  - Currently 'Dead', 'Dying', 'Unconcious', 'Disabled'
  - Menu option to toggle this

### [1.5.3] Changed

- Renamed some scripts

## [1.5.2] - 2021-03-20

### [1.5.2] Fixed

- Hovering off CT caused issues when active CT had no matching token

### [1.5.2] Added

- Conan 2d20 ruleset added as allowed ruleset

## [1.5.1] - 2021-03-19

### [1.5.1] Changed

- Toned down combat tracker highlight color

## [1.5.0] - 2021-03-18

### [1.5.0] Added

- Menu option as to which tokens are selected when overing off CT entry

### [1.5.0] Changed

- Lua scripts moved out of xml into files

## [1.4.1] - 2021-03-10

### [1.4.1] Fixed

- Hovering over token without matching CT entry resulted in error

## [1.4.0] - 2021-03-09

### [1.4.0] Added

- Menu option added as to whether hover over token highlights matching CT entry

### [1.4.0] Changed

- Refactoring onHover method to deal with above implementation

## [1.3.1] - 2021-03-09

### [1.3.1] Fixed

- Menu options having a blank value

## [1.3.0] - 2021-03-09

### [1.3.0] Added

- Hovering off CT entry now centers map to active CT entry
  - menu option to toggle this behavior

### [1.3.0] Changed

- Menu option added as to whether hovering over CT entry highlights matching token on map

### [1.3.0] Maintenance

- Various variable renaming in an attempt to arrive at some sort of consistency

## [1.2.0] - 2021-03-08

### [1.2.0] Added

- Hovering over CT entry now centers map to matching token
  - menu option to toggle this behavior

## [1.1.1] - 2021-03-04

### [1.1.1] Fixed

- Client hovering over CT was causing issues

## [1.1.0] - 2021-03-04

- Hovering anywhere on the CT entry now highlights the matching token
- Highlight underlay now matches reach of token
- Hovering over CT entry now selects matching token
  - menu option to toggle this behavior
- Hovering over token on map will scroll to matching combat tracker entry
  - menu option to toggle this behavior
- Hovering off token on map will scroll to actice combat tracker entry
  - menu option to toggle this behavior

## [1.0.2] - 2021-03-01

### [1.0.2] Added

- Extension announcement text
- Added all CoreRPG rulesets as allowable
- Replaced User.isHost() with Session.IsHost

## [1.0.1] - 2021-02-23

### [1.0.1] Changed

- Renaming all script imports to avoid collisions with other extensions

## [1.0.0] - 2021-02-17

### [1.0.0] Added

- When client double clicks on owned token in combat tracker, associated map is opened
- Hovering over token on map highlights combat entry
- Hovering over token in combat tracker highlights token on map
