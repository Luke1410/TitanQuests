function TitanQuestLocalizeEN()
	
	local SC = TitanQuests
	
	 SC.QUEST_TEXT = "Quest"
	 SC.QUESTS_TEXT = "Quests";
	 SC.OBJECTIVE_TEXT = "Objectives"
	 SC.QUESTS_DESCRIPTION = "Description"
	 SC.REWARD_TEXT = "Rewards"
	 SC.MEMBERSONQUEST_TEXT = "Party Members on Quest";

	 SC.BUTTON_LABEL = "Quests: ";
--    SC.BUTTON_TEXT = "%s"..TitanUtils_GetHighlightText("/").."%s";
	 SC.BUTTON_TEXT = "%s";
	 
	 SC.TAG_NORMAL = ""; -- quest
	 SC.TAG_RAID = "r"; -- raid
	 SC.TAG_PVP = "p"; -- PVP
	 SC.TAG_ELITE = "+"; -- elite
	 SC.TAG_DUNGEON = "d"; -- dungeon
	 SC.TAG_HERIOC = "d+"; -- dungeon heroic
	 SC.TAG_DAILY = "y"; -- daily
	 SC.TAG_WATCHER = "W"; -- watcher
	 SC.TAG_COMPLETE = "C"; -- complete
	 
	 SC.OPTIONS_TEXT = "Options";
	 
	 SC.LEVEL_TEXT = "Level ";
	 
	 SC.ABOUT_VERSION_TEXT = "Version";
	 SC.ABOUT_AUTHOR_TEXT = "Author";
	 SC.ABOUT_POPUP_TEXT = TitanUtils_GetGreenText("Titan Panel [Quests]").."\n"..TitanUtils_GetNormalText(SC.ABOUT_VERSION_TEXT..": ")..TitanUtils_GetHighlightText(TitanQuests.version).."\n"..TitanUtils_GetNormalText(SC.ABOUT_AUTHOR_TEXT..": ")..TitanUtils_GetHighlightText("urnati/Corgi/Ryessa");
	 
	 SC.SORT_TEXT = "Sort";
	 SC.SORT_LOCATION_TEXT = "by Location (Default)";
	 SC.SORT_LEVEL_TEXT = "by Level";
	 SC.SORT_TITLE_TEXT = "by Title";
	 
	 SC.SHOW_TEXT = "Show";
	 SC.SHOW_ELITE_TEXT = "only Elite";
	 SC.SHOW_DUNGEON_TEXT = "only Dungeon";
	 SC.SHOW_RAID_TEXT = "only Raid";
	 SC.SHOW_PVP_TEXT = "only PvP";
	 SC.SHOW_REGULAR_TEXT = "only Regular";
	 SC.SHOW_COMPLETED_TEXT = "only Completed";
	 SC.SHOW_INCOMPLETE_TEXT = "only Incomplete";
	 SC.SHOW_ALL_TEXT = "All (Default)";
	 
	 SC.TOGGLE_TEXT = "Toggle";
	 
	 SC.CLICK_BEHAVIOR_TEXT = "Left Click to Watch Quest";
	 SC.GROUP_BEHAVIOR_TEXT = "Group Sorted Quests";
	 SC.EVENTS_TEXT = "Show Quest Events"
	 
	 SC.QUESTLOG_TRUNCATED_TEXT = "Quest Display Truncated...";
	 SC.OPEN_QUESTLOG_TEXT = "Open QuestLog";
	 SC.CLOSE_QUESTLOG_TEXT = "Close QuestLog";
	 
	 SC.OPEN_MONKEYQUEST_TEXT = "Open MonkeyQuest";
	 SC.CLOSE_MONKEYQUEST_TEXT = "Close MonkeyQuest";
	 
	 SC.OPEN_QUESTION_TEXT = "Open QuestIon";
	 SC.CLOSE_QUESTION_TEXT = "Close QuestIon";
	 
	 SC.OPEN_PARTYQUESTS_TEXT = "Open PartyQuests";
	 SC.CLOSE_PARTYQUESTS_TEXT = "Close PartyQuests";
	 
	 SC.OPEN_QUESTHISTORY_TEXT = "Open QuestHistory";
	 SC.CLOSE_QUESTHISTORY_TEXT = "Close QuestHistory";
	 
	 SC.OPEN_QUESTBANK_TEXT = "Open QuestBank";
	 SC.CLOSE_QUESTBANK_TEXT = "Close QuestBank";
	 
	 SC.ABOUT_TEXT = "About";
	 
	 SC.OBJECTIVESTXT_LONG_TEXT = TitanUtils_GetRedText("Objectives text too long,\nClick quest for details.");
	 
	 SC.REMOVE_FROM_WATCHER_TEXT = "Remove from Watcher";
	 SC.ADD_TO_WATCHER_TEXT = "Add to Watcher";
	 
	 SC.ABANDON_QUEST_TEXT = "Abandon Quest";
	 SC.SHARE_QUEST_TEXT = "Share Quest";
	 
	 SC.QUEST_DETAILS_TEXT = "Quest Details";
	 SC.QUEST_DETAILS_OPTIONS_TEXT = "Quest Options";
	 
	 SC.LINK_QUEST_TEXT = "Link Quest";
	 
	 SC.DETAILS_SHARE_BUTTON_TEXT = "Share";
	 SC.DETAILS_WATCH_BUTTON_TEXT = "Watch";
	 
	 SC.NEWBIE_TOOLTIP_WATCHQUEST = "Add/Remove quest from Quest Tracker.";
	 
	 SC.TOOLTIP_QUESTS_TEXT = "Total Quests: ";
	 SC.TOOLTIP_ELITE_TEXT = "Elite ("..SC.TAG_ELITE..")".." Quests: ";
	 SC.TOOLTIP_DUNGEON_TEXT = "Dungeon ("..SC.TAG_DUNGEON..")".." Quests: ";
	 SC.TOOLTIP_RAID_TEXT = "Raid ("..SC.TAG_RAID..")".." Quests: ";
	 SC.TOOLTIP_PVP_TEXT = "PvP ("..SC.TAG_PVP..")".." Quests: ";
	 SC.TOOLTIP_REGULAR_TEXT = "Regular ("..SC.TAG_NORMAL..")".." Quests: ";
	 SC.TOOLTIP_DAILY_TEXT = "Daily ("..SC.TAG_DAILY..")".." Quests: ";
	 SC.TOOLTIP_COMPLETED_TEXT = "Completed Quests: ";
	 SC.TOOLTIP_INCOMPLETE_TEXT = "Incomplete Quests: ";
	 SC.TOOLTIP_HINT_TEXT = "Hint: Right-click for quest list.";
	 
	 -- quest labels 
	 SC.DUNGEON = "Dungeon";
	 SC.RAID = "Raid";
	 SC.PVP = "PvP";
	 SC.HEROIC = "Heroic";
	 
	 SC.SOLO = "Solo";

	 SC.SHOW_DETAILS_TITLE = "Quest Details";
	 SC.SHOW_DETAILS_NAME = "Text";
	 SC.SHOW_DETAILS_DESCRIPTION = "Description";
	 SC.SHOW_DETAILS_OBJECTIVES = "Objective";
	 SC.SHOW_DETAILS_REWARDS = "Rewards";
	 SC.SHOW_DETAILS_PARTY = "Party";
end
