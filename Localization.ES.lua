function TitanQuestLocalizeES()

	local SC = TitanQuests
	-- Spanish localization
	-- by PatoDaia
	-- Español ES
		 SC.QUESTS_TEXT = "Misiones";
       SC.QUEST_TEXT = "Misione"
		 SC.OBJECTIVE_TEXT = "Objetivos"
		 SC.QUESTS_DESCRIPTION = "Descripción"
		 SC.REWARD_TEXT = "Recompensas"
		 SC.MEMBERSONQUEST_TEXT = "Miembros del grupo haciendo la misión";
	
		 SC.BUTTON_LABEL = "Misiones: ";
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
		 
		 SC.OPTIONS_TEXT = "Opciones";
		 
		 SC.LEVEL_TEXT = "Nivel ";
		 
		 SC.ABOUT_VERSION_TEXT = "Version";
		 SC.ABOUT_AUTHOR_TEXT = "Autor";
		 SC.ABOUT_POPUP_TEXT = TitanUtils_GetGreenText("Titan Panel [Quests]").."\n"..TitanUtils_GetNormalText(SC.ABOUT_VERSION_TEXT..": ")..TitanUtils_GetHighlightText(TitanQuests.version).."\n"..TitanUtils_GetNormalText(SC.ABOUT_AUTHOR_TEXT..": ")..TitanUtils_GetHighlightText("urnati/Corgi/Ryessa");
		 
		 SC.SORT_TEXT = "Ordenar";
		 SC.SORT_LOCATION_TEXT = "por Lugar (por defecto)";
		 SC.SORT_LEVEL_TEXT = "por Nivel";
		 SC.SORT_TITLE_TEXT = "por Título";
		 
		 SC.SHOW_TEXT = "Mostrar";
		 SC.SHOW_ELITE_TEXT = "sólo Elite";
		 SC.SHOW_DUNGEON_TEXT = "sólo Mazmorra";
		 SC.SHOW_RAID_TEXT = "sólo Banda";
		 SC.SHOW_PVP_TEXT = "sólo PvP";
		 SC.SHOW_REGULAR_TEXT = "sólo Normales";
		 SC.SHOW_COMPLETED_TEXT = "sólo Completadas";
		 SC.SHOW_INCOMPLETE_TEXT = "sólo Incompletas";
		 SC.SHOW_ALL_TEXT = "Todas (por defecto)";
		 
		 SC.TOGGLE_TEXT = "Cambiar";
		 
		 SC.CLICK_BEHAVIOR_TEXT = "Click-Izq para ver la Misión";
		 SC.GROUP_BEHAVIOR_TEXT = "Quests Ordenadas por Grupos";
       SC.EVENTS_TEXT = "Mostrar Misione Eventos"
		 
		 SC.QUESTLOG_TRUNCATED_TEXT = "Lista de Misiones truncada...";
		 SC.OPEN_QUESTLOG_TEXT = "Abrir Registro de Misiones";
		 SC.CLOSE_QUESTLOG_TEXT = "Cerrar Registro de Misiones";
		 
		 SC.OPEN_MONKEYQUEST_TEXT = "Abrir MonkeyQuest";
		 SC.CLOSE_MONKEYQUEST_TEXT = "Cerrar MonkeyQuest";
		 
		 SC.OPEN_QUESTION_TEXT = "Abrir Pregunta";
		 SC.CLOSE_QUESTION_TEXT = "Cerrar Pregunta";
		 
		 SC.OPEN_PARTYQUESTS_TEXT = "Abrir Misiones del Grupo";
		 SC.CLOSE_PARTYQUESTS_TEXT = "Cerrar Misiones del Grupo";
		 
		 SC.OPEN_QUESTHISTORY_TEXT = "Abrir Historial de Misiones";
		 SC.CLOSE_QUESTHISTORY_TEXT = "Cerrar Historial de Misiones";
		 
		 SC.OPEN_QUESTBANK_TEXT = "Abrir Banco de Misiones";
		 SC.CLOSE_QUESTBANK_TEXT = "Cerrar Banco de Misiones";
		 
		 SC.ABOUT_TEXT = "Acerca de...";
		 
		 SC.OBJECTIVESTXT_LONG_TEXT = TitanUtils_GetRedText("El texto de los objetivos es muy largo,\nClick en la misión para obtener detalles.");
		 
		 SC.REMOVE_FROM_WATCHER_TEXT = "Quitar del Tracker";
		 SC.ADD_TO_WATCHER_TEXT = "Añadir al Tracker";
		 
		 SC.ABANDON_QUEST_TEXT = "Abandonar Misión";
		 SC.SHARE_QUEST_TEXT = "Compartir Misión";
		 
		 SC.QUEST_DETAILS_TEXT = "Detalles de la Misión";
		 SC.QUEST_DETAILS_OPTIONS_TEXT = "Opciones de la Misión";
		 
		 SC.LINK_QUEST_TEXT = "Linkea la Misión";
		 
		 SC.DETAILS_SHARE_BUTTON_TEXT = "Compartir";
		 SC.DETAILS_WATCH_BUTTON_TEXT = "Visualizar";
		 
		 SC.NEWBIE_TOOLTIP_WATCHQUEST = "Añadir/Quitar Misión del Tracker.";
		 
		 SC.TOOLTIP_QUESTS_TEXT = "Total de misiones: ";
		 SC.TOOLTIP_ELITE_TEXT = "Misiones Elite ("..SC.TAG_ELITE..")"..": ";
		 SC.TOOLTIP_DUNGEON_TEXT = "Misiones de Mazmorra ("..SC.TAG_DUNGEON..")"..": ";
		 SC.TOOLTIP_RAID_TEXT = "Misiones de Banda ("..SC.TAG_RAID..")"..": ";
		 SC.TOOLTIP_PVP_TEXT = "Misiones PvP ("..SC.TAG_PVP..")"..": ";
		 SC.TOOLTIP_REGULAR_TEXT = "Misiones Normales ("..SC.TAG_NORMAL..")"..": ";
		 SC.TOOLTIP_DAILY_TEXT = "Misiones Diarias ("..SC.TAG_DAILY..")"..": ";
		 SC.TOOLTIP_COMPLETED_TEXT = "Misiones Completadas: ";
		 SC.TOOLTIP_INCOMPLETE_TEXT = "Misiones Incompletas: ";
		 SC.TOOLTIP_HINT_TEXT = "Consejo: click-derecho para ver la lista de misiones.";
		 
		 -- quest labels
		 SC.DUNGEON = "Mazmorra";
		 SC.RAID = "Banda";
		 SC.PVP = "PvP";
		 SC.HEROIC = "Heroica";
		 SC.DAILY = "Diaria";
		 SC.SOLO = "Solo";

		 SC.SHOW_DETAILS_TITLE = "Mostrar detalles";
		 SC.SHOW_DETAILS_NAME = "Nombre";
		 SC.SHOW_DETAILS_DESCRIPTION = "Descripción";
		 SC.SHOW_DETAILS_OBJECTIVES = "Objetivos";
		 SC.SHOW_DETAILS_REWARDS = "Recompensas";
		 SC.SHOW_DETAILS_PARTY = "Grupo";
	end
	