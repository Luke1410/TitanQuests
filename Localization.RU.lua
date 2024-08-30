function TitanQuestLocalizeRU()
	
	local SC = TitanQuests
	
	 SC.QUEST_TEXT = "Квест"
	 SC.QUESTS_TEXT = "Квесты";
	 SC.OBJECTIVE_TEXT = "Цели"
	 SC.QUESTS_DESCRIPTION = "Описание"
	 SC.REWARD_TEXT = "Награды"
	 SC.MEMBERSONQUEST_TEXT = "Члены Группы на Квест";

	 SC.BUTTON_LABEL = "Квесты: ";
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
	 
	 SC.OPTIONS_TEXT = "Настройки";
	 
	 SC.LEVEL_TEXT = "Уровень ";
	 
	 SC.ABOUT_VERSION_TEXT = "Версия";
	 SC.ABOUT_AUTHOR_TEXT = "Автор";
	 SC.ABOUT_POPUP_TEXT = TitanUtils_GetGreenText("Titan Panel [Quests]").."\n"..TitanUtils_GetNormalText(SC.ABOUT_VERSION_TEXT..": ")..TitanUtils_GetHighlightText(TitanQuests.version).."\n"..TitanUtils_GetNormalText(SC.ABOUT_AUTHOR_TEXT..": ")..TitanUtils_GetHighlightText("urnati/Corgi/Ryessa");
	 
	 SC.SORT_TEXT = "Сортировать";
	 SC.SORT_LOCATION_TEXT = "по Местности (по умолчанию)";
	 SC.SORT_LEVEL_TEXT = "по Уровню";
	 SC.SORT_TITLE_TEXT = "по Названию";
	 
	 SC.SHOW_TEXT = "Показывать";
	 SC.SHOW_ELITE_TEXT = "только Elite";
	 SC.SHOW_DUNGEON_TEXT = "только Подземелье";
	 SC.SHOW_RAID_TEXT = "только Рейд";
	 SC.SHOW_PVP_TEXT = "только PvP";
	 SC.SHOW_REGULAR_TEXT = "только Regular";
	 SC.SHOW_COMPLETED_TEXT = "только Выполненные";
	 SC.SHOW_INCOMPLETE_TEXT = "только Невыполненные";
	 SC.SHOW_ALL_TEXT = "Все (по умолчанию)";
	 
	 SC.TOGGLE_TEXT = "Переключатель";
	 
	 SC.CLICK_BEHAVIOR_TEXT = "Нажмите ЛКМ, чтобы Посмотреть Квест";
	 SC.GROUP_BEHAVIOR_TEXT = "Сортировать Квесты";
	 SC.EVENTS_TEXT = "Show Quest Events"
	 
	 SC.QUESTLOG_TRUNCATED_TEXT = "Quest Display Truncated...";
	 SC.OPEN_QUESTLOG_TEXT = "Открыть Журнал заданий";
	 SC.CLOSE_QUESTLOG_TEXT = "Закрыть Журнал заданий";
	 
	 SC.OPEN_MONKEYQUEST_TEXT = "Открыть MonkeyQuest";
	 SC.CLOSE_MONKEYQUEST_TEXT = "Закрыть MonkeyQuest";
	 
	 SC.OPEN_QUESTION_TEXT = "Открыть QuestIon";
	 SC.CLOSE_QUESTION_TEXT = "Закрыть QuestIon";
	 
	 SC.OPEN_PARTYQUESTS_TEXT = "Открыть PartyQuests";
	 SC.CLOSE_PARTYQUESTS_TEXT = "Закрыть PartyQuests";
	 
	 SC.OPEN_QUESTHISTORY_TEXT = "Открыть QuestHistory";
	 SC.CLOSE_QUESTHISTORY_TEXT = "Закрыть QuestHistory";
	 
	 SC.OPEN_QUESTBANK_TEXT = "Открыть QuestBank";
	 SC.CLOSE_QUESTBANK_TEXT = "Закрыть QuestBank";
	 
	 SC.ABOUT_TEXT = "О программе";
	 
	 SC.OBJECTIVESTXT_LONG_TEXT = TitanUtils_GetRedText("Описание целей квеста слишком большое,\nНажмите на квест за подробностями.");
	 
	 SC.REMOVE_FROM_WATCHER_TEXT = "Прекратить отслеживать";
	 SC.ADD_TO_WATCHER_TEXT = "Отслеживать";
	 
	 SC.ABANDON_QUEST_TEXT = "Отказаться от Квеста";
	 SC.SHARE_QUEST_TEXT = "Поделиться Квестом";
	 
	 SC.QUEST_DETAILS_TEXT = "Подробности Квеста";
	 SC.QUEST_DETAILS_OPTIONS_TEXT = "Настройки Квеста";
	 
	 SC.LINK_QUEST_TEXT = "Ссылка на Квест";
	 
	 SC.DETAILS_SHARE_BUTTON_TEXT = "Поделиться";
	 SC.DETAILS_WATCH_BUTTON_TEXT = "Отслеживать";
	 
	 SC.NEWBIE_TOOLTIP_WATCHQUEST = "Добавить/Удалить квест в/из Quest Tracker.";
	 
	 SC.TOOLTIP_QUESTS_TEXT = "Всего Квестов: ";
	 SC.TOOLTIP_ELITE_TEXT = "Elite ("..SC.TAG_ELITE..")".." Квестов: ";
	 SC.TOOLTIP_DUNGEON_TEXT = "Подземелье ("..SC.TAG_DUNGEON..")".." Квестов: ";
	 SC.TOOLTIP_RAID_TEXT = "Рейд ("..SC.TAG_RAID..")".." Квестов: ";
	 SC.TOOLTIP_PVP_TEXT = "PvP ("..SC.TAG_PVP..")".." Квестов: ";
	 SC.TOOLTIP_REGULAR_TEXT = "Regular ("..SC.TAG_NORMAL..")".." Квестов: ";
	 SC.TOOLTIP_DAILY_TEXT = "Daily ("..SC.TAG_DAILY..")".." Квестов: ";
	 SC.TOOLTIP_COMPLETED_TEXT = "Выполненых Квестов: ";
	 SC.TOOLTIP_INCOMPLETE_TEXT = "Невыполненых Квестов: ";
	 SC.TOOLTIP_HINT_TEXT = "Подсказка: нажмите ПКМ для отображения списка квестов.";
	 
	 -- quest labels 
	 SC.DUNGEON = "Подземелье";
	 SC.RAID = "Рейд";
	 SC.PVP = "PvP";
	 SC.HEROIC = "Heroic";
	 
	 SC.SOLO = "Solo";

	 SC.SHOW_DETAILS_TITLE = "Подробности Квеста";
	 SC.SHOW_DETAILS_NAME = "Текст";
	 SC.SHOW_DETAILS_DESCRIPTION = "Описание";
	 SC.SHOW_DETAILS_OBJECTIVES = "Цели";
	 SC.SHOW_DETAILS_REWARDS = "Награды";
	 SC.SHOW_DETAILS_PARTY = "Party";
end
