function TitanQuestLocalizeFR()
	
	local SC = TitanQuests
	-- French localization
	-- by Vorpale
	-- for 0.22 updated by urnati
		 SC.QUESTS_TEXT = "Qu\195\170tes";
       SC.QUEST_TEXT = "Qu\195\170te"
		 SC.OBJECTIVE_TEXT = "Objectifs"
		 SC.QUESTS_DESCRIPTION = "Description"
		 SC.REWARD_TEXT = "Prix"
		 SC.MEMBERSONQUEST_TEXT = "Membre du parti dans qu\195\170tes";
	
		SC.BUTTON_LABEL = "Qu\195\170tes: ";
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
		SC.ABOUT_AUTHOR_TEXT = "Auteur";
		
		SC.SORT_TEXT = "Trier";
		SC.SORT_LOCATION_TEXT = "par Localisation (D\195\168faut)";
		SC.SORT_LEVEL_TEXT = "par Niveau";
		SC.SORT_TITLE_TEXT = "Par Titre";
	
		SC.SHOW_TEXT = "Afficher";
		SC.SHOW_ELITE_TEXT = "seulement Elites";
		SC.SHOW_DUNGEON_TEXT = "seulement Donjons";
		SC.SHOW_RAID_TEXT = "seulement Raids";
		SC.SHOW_PVP_TEXT = "seulement JcJ";
		SC.SHOW_REGULAR_TEXT = "seulement Normales";
		SC.SHOW_COMPLETED_TEXT = "seulement Compl\195\168t\195\168es";
		SC.SHOW_INCOMPLETE_TEXT = "seulement Non Compl\195\168t\195\168es";
		SC.SHOW_ALL_TEXT = "Tout (D\195\168faut)";
	
		SC.TOGGLE_TEXT = "Activer";
	
		SC.CLICK_BEHAVIOR_TEXT = "Left-Click to Watch Quest";
		SC.GROUP_BEHAVIOR_TEXT = "Group Sorted Quests";
		SC.EVENTS_TEXT = "Afficher Qu\195\170te \144v\130nements"
	
		SC.QUESTLOG_TRUNCATED_TEXT = "Qu\195\170t Display Truncated...";
		SC.OPEN_QUESTLOG_TEXT = "Ouvrir le journal de qu\195\170tes";
		SC.CLOSE_QUESTLOG_TEXT = "Fermer le journal de qu\195\170tes";
	
		SC.OPEN_MONKEYQUEST_TEXT = "Ouvrir MonkeyQuest";
		SC.CLOSE_MONKEYQUEST_TEXT = "Fermer MonkeyQuest";
	
		SC.OPEN_QUESTION_TEXT = "Ouvrir QuestIon";
		SC.CLOSE_QUESTION_TEXT = "Fermer QuestIon";
	
		SC.OPEN_PARTYQUESTS_TEXT = "Ouvrir PartyQuests";
		SC.CLOSE_PARTYQUESTS_TEXT = "Fermer PartyQuests";
	
		SC.OPEN_QUESTHISTORY_TEXT = "Ouvrir QuestHistory";
		SC.CLOSE_QUESTHISTORY_TEXT = "Fermer QuestHistory";
	
		SC.OPEN_QUESTBANK_TEXT = "Ouvrir QuestBank";
		SC.CLOSE_QUESTBANK_TEXT = "Fermer QuestBank";
	
		SC.ABOUT_TEXT = "A propos";
	
		SC.OBJECTIVESTXT_LONG_TEXT = TitanUtils_GetRedText("Texte des objectifs trop long,\ncliquez sur la qu\195\170te pour les d\195\168tails.");
	
		SC.REMOVE_FROM_WATCHER_TEXT = "Enlever de la surveillance";
		SC.ADD_TO_WATCHER_TEXT = "Ajouter \195\160 la surveillance";
	
		SC.ABANDON_QUEST_TEXT = "Abandonner la qu\195\170te";
			  SC.SHARE_QUEST_TEXT = "Partager la qu\195\170te";
	
		SC.QUEST_DETAILS_TEXT = "D\195\168tails de la qu\195\170te";
		SC.QUEST_DETAILS_OPTIONS_TEXT = "Quest Options";
	
		SC.LINK_QUEST_TEXT = "Lier la qu\195\170te";
	
		SC.DETAILS_SHARE_BUTTON_TEXT = "Partager";
		SC.DETAILS_WATCH_BUTTON_TEXT = "Surveiller";
	
		SC.NEWBIE_TOOLTIP_WATCHQUEST = "Ajouter/supprimer la qu\195\170te du Quest Tracker.";
	
		SC.TOOLTIP_QUESTS_TEXT = "# de qu\195\170tes: ";
		SC.TOOLTIP_ELITE_TEXT = "# de qu\195\170tes Elite ("..SC.TAG_ELITE..")"..": ";
		SC.TOOLTIP_DUNGEON_TEXT = "# de qu\195\170tes Donjon ("..SC.TAG_DUNGEON..")"..": ";
		SC.TOOLTIP_RAID_TEXT = "# de qu\195\170tes Raid ("..SC.TAG_RAID..")"..": ";
		SC.TOOLTIP_PVP_TEXT = "# de qu\195\170tes JcJ ("..SC.TAG_PVP..")"..": ";
		SC.TOOLTIP_REGULAR_TEXT = "# de qu\195\170tes normales ("..SC.TAG_NORMAL..")"..": ";
		SC.TOOLTIP_COMPLETED_TEXT = "# de qu\195\170tes actuellement termin\195\168es: ";
		SC.TOOLTIP_INCOMPLETE_TEXT = "# de qu\195\170tes non actuellement termin\195\168es: ";
		SC.TOOLTIP_HINT_TEXT = "Astuce: Clic-droit pour la liste des qu\195\170tes.";
		
		-- quest labels
		SC.DUNGEON = "Donjon";
		SC.RAID = "Raid";
		SC.PVP = "JcJ";
	
		 SC.SOLO = "Seul";

       SC.SHOW_DETAILS_TITLE = "Quest Details";
       SC.SHOW_DETAILS_NAME = "Text";
       SC.SHOW_DETAILS_DESCRIPTION = "Description";
       SC.SHOW_DETAILS_OBJECTIVES = "Objective";
       SC.SHOW_DETAILS_REWARDS = "Rewards";
       SC.SHOW_DETAILS_PARTY = "Party";
	end