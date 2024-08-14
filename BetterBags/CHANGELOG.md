# BetterBags

## [v0.1.92](https://github.com/Cidan/BetterBags/tree/v0.1.92) (2024-08-14)
[Full Changelog](https://github.com/Cidan/BetterBags/compare/v0.1.91...v0.1.92) [Previous Releases](https://github.com/Cidan/BetterBags/releases)

- Fixed a few annotations and types for TWW  
- Update README.md for Anchor support and BindType searching (#576)  
    * Update README.md for Anchor support  
    Include initial note for Dynamic number of columns.  
    Include information about click-to-move categories.  
    Update Warbank information for depositing items into the warbank.  
    Update planned/under-development features.  
    * Update README.md for BindType searches  
    Fix spelling mistakes.  
    Explicitly mention Warcraft.wiki.  
    Update search section with the newest search features.  
    * Update README.md  
    Fix broken link.  
    Add GUID of item and remove bagName.  
    * Minor README.md edits  
    Add note about soulbound and warbound on non-Retail.  
- Deposit reagents (#574)  
    Right clicking a section title when the reagent bank is open will move those items to the reagent bank.  
- bindings module (#566)  
    * Added support for several bind types in search. See the readme for more information.  
- fix anchor and move section in both classic version (#568)  
- Perma Items (#577)  
    * Dropping items into section title, section name in config, or item list in config, will correctly add an item to the permanent item list.  
- added documentation on new create category API.  
- Another small fix.  
- fixed count search  
- fix for ketho vscode submodule  
- added submodules for ketho's wow api and wow-ui-source  
- Take into account current tab at bank (#567)  
    Fixed a bug where clicking the header to xfer items would not work correctly in some cases.  
- Workaround a WoW bug where bank tabs would not show sometimes.  
- The show bags view no longer inserts bag names into the category list.  
- Dynamic categories will now always show up on the category disk if the category has appeared at least once.  
- Dynamic categories are now handled correctly in item lists.  
- added GUID to the search index for items.  
- Fixed a bug where item lists for categories would not show all items.  
- Bag Anchor (#564)  
    * Added support for bag anchors that can be enabled or disabled via each bag's drop down menu.  