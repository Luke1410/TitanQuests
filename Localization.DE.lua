function TitanQuestLocalizeDE()
	
	local SC = TitanQuests
	-- German localization
	-- by Scarabeus
	-- and Kaesemuffin
		TITAN_QUESTS_QUESTS_TEXT = "Quests";
		TITAN_QUESTS_QUEST_TEXT = "Quest"
		TITAN_QUESTS_OBJECTIVE_TEXT = "Questbeschreibung"
		SC.QUESTS_DESCRIPTION = "Beschreiben"
		SC.REWARD_TEXT = "Belohnt"
		SC.MEMBERSONQUEST_TEXT = "Mitglieder mit Quest";
	
		SC.MENU_TEXT = "Quest Men\195\188";
		SC.BUTTON_LABEL = "Quests: ";
		SC.TOOLTIP = "Quest Infos";
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
	
		SC.SORT_TEXT = "Sortieren";
		SC.SORT_LOCATION_TEXT = "nach Zonen (Standart)";
		 SC.SORT_LEVEL_TEXT = "nach Level";
		 SC.SORT_TITLE_TEXT = "nach Bezeichnung";
	
		SC.SHOW_TEXT = "Anzeige";
		 SC.SHOW_ELITE_TEXT = "nur Elite-Quests";
		 SC.SHOW_DUNGEON_TEXT = "nur Dungeon-Quests";
		 SC.SHOW_RAID_TEXT = "nur Schlachtzugs-Quests";
		 SC.SHOW_PVP_TEXT = "nur PvP-Quests";
		 SC.SHOW_REGULAR_TEXT = "nur regul\195\164re Quests";
		 SC.SHOW_COMPLETED_TEXT = "nur vervollst\195\164ndigte Quests";
		 SC.SHOW_INCOMPLETE_TEXT = "nur nicht vervollst\195\164ndigte Quests";
		 SC.SHOW_ALL_TEXT = "Alle (Standart)";
	
		SC.TOGGLE_TEXT =  "Ein/Ausschalten";
	
		SC.CLICK_BEHAVIOR_TEXT = "Left-Click to Watch Quest";
		SC.GROUP_BEHAVIOR_TEXT = "Group Sorted Quests";
		SC.EVENTS_TEXT = "Anzeige Quest Geschehen"
	
		SC.QUESTLOG_TRUNCATED_TEXT = "Quest Display Truncated...";
		SC.OPEN_QUESTLOG_TEXT = "\195\150ffne QuestLog";
		 SC.CLOSE_QUESTLOG_TEXT = "Schlie\195\159e QuestLog";
	
		 SC.OPEN_MONKEYQUEST_TEXT = "\195\150ffne MonkeyQuest";
		 SC.CLOSE_MONKEYQUEST_TEXT = "Schlie\195\159e MonkeyQuest";
	
		 SC.OPEN_QUESTION_TEXT = "\195\150ffne QuestIon";
		 SC.CLOSE_QUESTION_TEXT = "Schlie\195\159e QuestIon";
	
		 SC.OPEN_PARTYQUESTS_TEXT = "\195\150ffne PartyQuests";
		 SC.CLOSE_PARTYQUESTS_TEXT = "Schlie\195\159e PartyQuests";
	
		 SC.OPEN_QUESTHISTORY_TEXT = "\195\150ffne Questverlauf";
		 SC.CLOSE_QUESTHISTORY_TEXT = "Schlie\195\159e Questverlauf";
	
		 SC.OPEN_QUESTBANK_TEXT = "\195\150ffne QuestBank";
		 SC.CLOSE_QUESTBANK_TEXT = "Schlie\195\159e QuestBank";
	
		 SC.ABOUT_TEXT = "\195\156ber";
	
		 SC.OBJECTIVESTXT_LONG_TEXT = TitanUtils_GetRedText("Questbeschreibung zu lang,\nklicken f\195\188r Details.");
	
		 SC.REMOVE_FROM_WATCHER_TEXT = "Vom 'Beobachter' entfernen";
		 SC.ADD_TO_WATCHER_TEXT = "Zum 'Beobachter' hinzuf\195\188gen";
	
		 SC.QUEST_DETAILS_TEXT = "Quest Details";
		SC.QUEST_DETAILS_OPTIONS_TEXT = "Quest Options";
	
		 SC.LINK_QUEST_TEXT = "Verlinke Quest";
	
		 SC.DETAILS_SHARE_BUTTON_TEXT = "Teilen";
		 SC.DETAILS_WATCH_BUTTON_TEXT = "Beobachten";
	
		 SC.NEWBIE_TOOLTIP_WATCHQUEST = "F\195\188ge hinzu / entferne die Quest vom Quest Tracker.";
	
		 SC.TOOLTIP_QUESTS_TEXT = "Insgesamt # Quests: ";
		 SC.TOOLTIP_ELITE_TEXT = "Davon # Elite-Quests ("..SC.TAG_ELITE..")"..": ";
		SC.TOOLTIP_DUNGEON_TEXT = "# Dungeon-Quests ("..SC.TAG_DUNGEON..")"..": ";
		 SC.TOOLTIP_RAID_TEXT = "# Schlachtzugs-Quests ("..SC.TAG_RAID..")"..": ";
		 SC.TOOLTIP_PVP_TEXT = "# PvP-Quests ("..SC.TAG_PVP..")"..": ";
		 SC.TOOLTIP_REGULAR_TEXT = "# regul\195\164re Quests ("..SC.TAG_NORMAL..")"..": ";
		 SC.TOOLTIP_COMPLETED_TEXT = "# vervollst\195\164ndigte Quests: ";
		 SC.TOOLTIP_INCOMPLETE_TEXT = "# nicht vervollst\195\164ndigte Quests: ";
		 SC.TOOLTIP_HINT_TEXT = "Hinweis: Rechts-klick f\195\188r Quest-Liste.";
	
		 -- quest labels
		 SC.DUNGEON = "Dungeon";
		 SC.RAID = "Schlachtzug";
		 SC.PVP = "PvP";
	

       SC.SHOW_DETAILS_TITLE = "Quest Details";
       SC.SHOW_DETAILS_NAME = "Text";
       SC.SHOW_DETAILS_DESCRIPTION = "Description";
       SC.SHOW_DETAILS_OBJECTIVES = "Objective";
       SC.SHOW_DETAILS_REWARDS = "Rewards";
       SC.SHOW_DETAILS_PARTY = "Party";
	end