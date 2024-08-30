--------------------------------------------------------------------------
-- TitanQuests.lua 
--------------------------------------------------------------------------
--[[

Titan Panel [Quests]
	Displays number of quests in Titan Panel. When hovered over it 
	displays the following info:
	- total number of quests
	- number of Elite quests
	- number of Dungeon quests
	- number of Raid quests
	- number of PvP quests 
	- number of regular quests (non elite/dungeon/raid/pvp)
    - number of daily quests
	- number of quests in log currently completed

	Right-click to see a color coded list of current quests. When hovered 
	over a dropdown menu will appear with the quest objective text, 
    a list of quest objectives, and commands to:
    - add to Blizzard's Quest Tracker, 
    - share quest, 
    - abandon quest, 
    - open quest details
    - link quest to chat.

	The Options menu allows you to sort and group the quests by level, zone, 
	or by title. You can also apply a filter to view only dungeon, elite,
	complete, incomplete, or regular quests.

	Can toggle MonkeyQuest, QuestHistory, PartyQuests, QuestIon and
	QuestBank if these AddOns are installed.

	NOTE: Requires Titan Panel version 3.0+

	TODO: Minor French and German translations.  Complete Korean translations.

]]--

-- Create a shortcut to save typing
local SC = TitanQuests

-- 
-- _OnLoad
--  Register with Titan and register the events needed
--
function SC.Button_OnLoad(self)
    SC.DisplayDebug (1, "TQ event: OnLoad");
-- set registry so Titan Panel can display and update the 
-- Titan Quests button.
	self.registry = { 
		id = SC.id,
      version = SC.version,
		menuText = SC.id,
		buttonTextFunction = "TitanPanelQuestsButton_GetButtonText",	
      category = "Interface",
		tooltipTitle = SC.id,
		tooltipTextFunction = "TitanPanelQuestsButton_GetTooltipText",
		icon = SC.artwork_path.."TitanQuests",	
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			SortByLevel = TITAN_NIL,
			SortByLocation = 1,
			SortByTitle = TITAN_NIL,
			ShowElite = TITAN_NIL,
			ShowDungeon = TITAN_NIL,
			ShowRaid = TITAN_NIL,
			ShowPVP = TITAN_NIL,
			ShowRegular = TITAN_NIL,
			ShowCompleted = TITAN_NIL,
			ShowIncomplete = TITAN_NIL,
			ShowAll = 1,
         GroupBehavior = 1,
         ShowQuestEvents = 1,
			ClickBehavior = TITAN_NIL,
			QuestsWatched = { nil, nil, nil, nil, nil },
			QShowText = 1,
			QShowDesc = 1,
			QShowObj = 1,
			QShowRewards = 1,
			QShowParty = 1,
		}
	};

   self:RegisterEvent("VARIABLES_LOADED");
   self:RegisterEvent("PLAYER_ENTERING_WORLD");
   self:RegisterEvent("UNIT_NAME_UPDATE");
   self:RegisterEvent("QUEST_LOG_UPDATE");
--	self:RegisterEvent("QUEST_WATCH_UPDATE");
--	self:RegisterEvent("QUEST_ITEM_UPDATE");

	-- shamelessly print a load message to chat window
	DEFAULT_CHAT_FRAME:AddMessage(
	  GREEN_FONT_COLOR_CODE
	  ..SC.app..SC.id.." "..SC.version
	  .." by "
	  ..FONT_COLOR_CODE_CLOSE
	  .."|cFFFFFF00"..SC.AUTHOR..FONT_COLOR_CODE_CLOSE);
end

function SC.Button_OnUpdate(self, Elapsed)

	if ( SC.watched ) then
		return;
	end
	
	if ( SC.settings_init ) then
		return;
	end

	if ( TitanGetVar(SC.id,"QuestsWatched") ~= nil ) then
		SC.InitSettings();
	end
end

function SC.Button_OnEvent(self, event, a1, ...)
	if (   event == "VARIABLES_LOADED" ) then
		SC.watched = nil;
		SC.settings_init = nil;
	elseif event == "UNIT_NAME_UPDATE" then
		SC.DisplayDebug (1, "TQ event: "..event);
		SC.watched = nil;
		SC.settings_init = nil;

	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
      SC.DisplayDebug (1, "TQ event: "..event);
		SC.watched = nil;
		SC.settings_init = nil;

        -- Initialize the quest cache to get everything rolling.
        SC.list = SC.BuildQuestList ();
        SC.count = SC.BuildQuestCount (SC.list);
    
        -- Make any changes to the Titan button
        TitanPanelButton_UpdateButton(SC.id);	
        TitanPanelButton_UpdateTooltip();

        -- A set of debug lines
        SC.DisplayDebugItem (1, "TQ var ShowIcon:", TitanGetVar(SC.id, "ShowIcon"));
        SC.DisplayDebugItem (1, "TQ var ShowLabelText:", TitanGetVar(SC.id, "ShowLabelText"));
        SC.DisplayDebugItem (1, "TQ var SortByLocation:", TitanGetVar(SC.id, "SortByLocation"));
        SC.DisplayDebugItem (1, "TQ var ShowLabelText:", TitanGetVar(SC.id, "ShowLabelText"));
        SC.DisplayDebugItem (1, "TQ var SortByTitle:", TitanGetVar(SC.id, "SortByTitle"));
        SC.DisplayDebugItem (1, "TQ var GroupBehavior:", TitanGetVar(SC.id, "GroupBehavior"));
        
        -- Update the QuestWatched trackers
        SC.UpdateSettings();		 
 		SC.DisplayDebug (1, "TQ event: "..event.." fini");

    elseif ( event == "QUEST_LOG_UPDATE" ) then
        SC.DisplayDebug (1, "TQ event: "..event);
		  
		  if TitanGetVar(SC.id, "ShowQuestEvents") then
		  	-- only do if the user requests
--[[
			DEFAULT_CHAT_FRAME:AddMessage(
               GREEN_FONT_COLOR_CODE
               .."TQ: "
               ..FONT_COLOR_CODE_CLOSE
               .."|cFFFFFF00"
               .."Update quest list"
               ..FONT_COLOR_CODE_CLOSE);
--]]
			SC.list = SC.BuildQuestList ()
		  end
        -- Make any changes to the Titan button
        TitanPanelButton_UpdateButton(SC.id);	
        TitanPanelButton_UpdateTooltip();
		-- Update the QuestWatched trackers
		SC.UpdateSettings();
--    elseif ( event == "QUEST_WATCH_UPDATE" ) then
--			 SC.DisplayDebug (1, "TQ event: "..event);
--[[			 
			 DEFAULT_CHAT_FRAME:AddMessage(
				GREEN_FONT_COLOR_CODE
				.." TQ: "
				..FONT_COLOR_CODE_CLOSE
				.."|cFFFFFF00"..event..FONT_COLOR_CODE_CLOSE)
				--]]
--	elseif ( event == "QUEST_ITEM_UPDATE" ) then
--			SC.DisplayDebug (1, "TQ event: "..event);
--[[						
						DEFAULT_CHAT_FRAME:AddMessage(
						  GREEN_FONT_COLOR_CODE
						  .." TQ: "
						  ..FONT_COLOR_CODE_CLOSE
						  .."|cFFFFFF00"..event..FONT_COLOR_CODE_CLOSE);
						  --]]
	end
	
end 

function SC.Button_OnClick(self, button)
   SC.DisplayDebug (1, "TQ event: _OnClick");
	
   if ( button == "LeftButton" ) then
      SC.ToggleQuestLog()
   end
end 
	
function SC.Button_OnEnter()
    SC.DisplayDebug (1, "TQ event: _OnEnter");
    -- Initialize the quest cache incase something has changed.
    SC.list = SC.BuildQuestList ();
    SC.count = SC.BuildQuestCount (SC.list);

    -- Make any changes to the Titan button
    TitanPanelButton_UpdateButton(SC.id); 
    TitanPanelButton_UpdateTooltip();

   -- Update the QuestWatched trackers
   SC.UpdateSettings();     
end 

--
-- initialize all Titan Quests settings
--
function SC.InitSettings()

	SC.settings_init = 1;

	-- Load up the Blizzard Quest Tracker
	if ( not SC.watched ) then

		if (TitanGetVar(SC.id, "QuestsWatched") ~= nil) then
			SC.watched = TitanGetVar(SC.id, "QuestsWatched");
		else
			SC.watched = { nil, nil, nil, nil, nil };
			TitanSetVar(SC.id, "QuestsWatched", SC.watched);
		end

		for i=1, MAX_WATCHABLE_QUESTS do
			if (SC.watched[i] ~= nil) then
				if ( GetNumQuestLeaderBoards(SC.watched[i]) > 0 ) then
					local foundQuest = nil;
					for j=1, GetNumQuestWatches() do
						local questIndex = GetQuestIndexForWatch(j);
						if ( questIndex == SC.watched[i] ) then
							foundQuest = 1;
						end;
					end

					if (not foundQuest) then
						AddQuestWatch(SC.watched[i]);
					end
				else
					SC.watched[i] = nil;
					TitanSetVar(SC.id, 
                        "QuestsWatched", SC.watched);
				end
			end
		end
		QuestWatch_Update();
	end
end

--
-- update the Titan Quests settings following a log update
--
function SC.UpdateSettings()
	local questIndex;
	local numWatched;

	-- Fill in the watched quests.
	if (   not SC.watched 
        or not TitanGetVar(SC.id, "QuestsWatched") ) then
		return;
	end

	numWatched = GetNumQuestWatches();
	for i=1, MAX_WATCHABLE_QUESTS do
		if ( i <= numWatched ) then
			questIndex = GetQuestIndexForWatch(i);
			if ( questIndex ) then
				SC.watched[i] = questIndex;
			end
		else
			SC.watched[i] = nil;
		end
	end
	TitanSetVar(SC.id, "QuestsWatched", SC.watched);
end

--
-- create button text for the Titan bar
-- has to remain in global namespace for Titan
--
function TitanPanelQuestsButton_GetButtonText(id)
	-- create string for Titan bar display
--	local buttonRichText = format(SC.BUTTON_TEXT, 
--        TitanUtils_GetGreenText(SC.count.complete), 
--        TitanUtils_GetHighlightText(SC.count.total) );

    local NumEntries, NumQuests = GetNumQuestLogEntries();
	local buttonRichText = format(SC.BUTTON_TEXT,
        TitanUtils_GetGreenText(NumQuests) );
    
	-- Return our button label
	return SC.BUTTON_LABEL, buttonRichText;
end

--
-- create tooltip text for Titan bar
-- has to remain in global namespace for Titan
--
function TitanPanelQuestsButton_GetTooltipText()

	local tooltipRichText = "";
	
	tooltipRichText = tooltipRichText
        ..TitanUtils_GetNormalText(SC.TOOLTIP_QUESTS_TEXT)
        ..TitanUtils_GetHighlightText(SC.count.total.."\n");
	tooltipRichText = tooltipRichText
        ..TitanUtils_GetNormalText(SC.TOOLTIP_ELITE_TEXT)
        ..TitanUtils_GetHighlightText(SC.count.elite.."\n");
	tooltipRichText = tooltipRichText
        ..TitanUtils_GetNormalText(SC.TOOLTIP_DUNGEON_TEXT)
        ..TitanUtils_GetHighlightText(SC.count.dungeon.."\n");
	tooltipRichText = tooltipRichText
        ..TitanUtils_GetNormalText(SC.TOOLTIP_RAID_TEXT)
        ..TitanUtils_GetHighlightText(SC.count.raid.."\n");
	tooltipRichText = tooltipRichText
        ..TitanUtils_GetNormalText(SC.TOOLTIP_PVP_TEXT)
        ..TitanUtils_GetHighlightText(SC.count.pvp.."\n");
	tooltipRichText = tooltipRichText
        ..TitanUtils_GetNormalText(SC.TOOLTIP_REGULAR_TEXT)
        ..TitanUtils_GetHighlightText(SC.count.regular.."\n");
	tooltipRichText = tooltipRichText.."\n";
	tooltipRichText = tooltipRichText
        ..TitanUtils_GetNormalText(SC.TOOLTIP_DAILY_TEXT)
        ..TitanUtils_GetHighlightText(SC.count.daily.."\n");
	tooltipRichText = tooltipRichText
        ..TitanUtils_GetNormalText(SC.TOOLTIP_COMPLETED_TEXT)
        ..TitanUtils_GetHighlightText(SC.count.complete).."\n";
	tooltipRichText = tooltipRichText
        ..TitanUtils_GetNormalText(SC.TOOLTIP_INCOMPLETE_TEXT)
        ..TitanUtils_GetHighlightText(SC.count.incomplete).."\n";
	tooltipRichText = tooltipRichText.."\n"
        ..TitanUtils_GetGreenText(SC.TOOLTIP_HINT_TEXT);

	return tooltipRichText;
end

--
-- create menu after a right-click
-- has to remain in global namespace for Titan
--
function TitanPanelRightClickMenu_PrepareQuestsMenu()
    -- create the right level of menu once the menu is up.
	if ( UIDROPDOWNMENU_MENU_LEVEL >= 2 ) then
        -- show other menu levels
		SC.CreateMenu();
	else
      -- create the menu list of quests showing title +
      SC.CreateQuestListMenu()
	end
end

--
-- create the menu for the quest list
--
function SC.CreateQuestListMenu()
	-- get quest list from cache
    local questlist = SC.list;

	-- total number of quests
	local numQuests = #(questlist); -- table.getn(questlist);

	local groupBy = "Location";

	-- tracking length of list
	-- Starts at 1 because "Quests" header is added elsewhere. - Ryessa
	local numButtons = 1;

	if ( TitanGetVar(SC.id, "SortByLevel") ) then
		table.sort(questlist, 
            function(a,b) return (a.questLevel < b.questLevel); end);
		groupBy = "Level";
	end

	if ( TitanGetVar(SC.id, "SortByTitle") ) then
		table.sort(questlist, 
            function(a,b) return (a.questTitle < b.questTitle); end);
		groupBy = "Title";
	end

	local useTag;
	local completeTag;
	local questWatched = "";
	local diff;

	local groupId = "";
	local lastGroupId = "";

	local questDisplayCount = 0;

	local i = 0;

	local info = {};

	-- create a configuration entry
	info = {};
	info.text = SC.OPTIONS_TEXT;
	info.value = "Options";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);
	numButtons = numButtons + 1;

	-- output quest list to menu
	for i=1, numQuests do
		local unCheckableQuest = nil; -- added
		if ( TitanGetVar(SC.id, "SortByLocation") 
            and TitanGetVar(SC.id, "GroupBehavior") ) then
			groupId = questlist[i].questLocation;
		elseif ( TitanGetVar(SC.id, "SortByLevel") 
            and TitanGetVar(SC.id, "GroupBehavior") ) then
			groupId = SC.LEVEL_TEXT..questlist[i].questLevel;
		end

		-- check to see if quest is to be displayed
		local checkDisplay = 0;

		if ( TitanGetVar(SC.id, "ShowElite") ) then
			if ( questlist[i].questTag == ELITE ) then
				checkDisplay = 1;
			end
		elseif ( TitanGetVar(SC.id, "ShowDungeon") ) then
			if ( questlist[i].questTag == SC.DUNGEON ) then
				checkDisplay = 1;
			end
		elseif ( TitanGetVar(SC.id, "ShowRaid") ) then
			if ( questlist[i].questTag == SC.RAID ) then
				checkDisplay = 1;
			end
		elseif ( TitanGetVar(SC.id, "ShowPVP") ) then
			if ( questlist[i].questTag == SC.PVP ) then
				checkDisplay = 1;
			end
		elseif ( TitanGetVar(SC.id, "ShowRegular") ) then
			if ( questlist[i].questTag == nil ) then
				checkDisplay = 1;
			end
		elseif ( TitanGetVar(SC.id, "ShowCompleted") ) then
			if ( questlist[i].questisComplete ) then
				checkDisplay = 1;
			end
		elseif ( TitanGetVar(SC.id, "ShowIncomplete") ) then
			if ( not questlist[i].questisComplete ) then
				checkDisplay = 1;
			end
		else	
			checkDisplay = 1;
		end

		-- Make sure it is not a header (location)
		-- and that the user wants to see it.
		if ( checkDisplay == 1 and questlist[i].questLevel > 0 ) then
			questDisplayCount = questDisplayCount + 1;
			info = {};
			if ( groupId ~= "" and groupId ~= lastGroupId ) then
				info.text = groupId;
				info.isTitle = 1;
				info.notCheckable = 1;
				UIDropDownMenu_AddButton(info);
				numButtons = numButtons + 1;
				info = {};
				lastGroupId = groupId;
				questDisplayCount = questDisplayCount + 1;
			end

			if ( IsQuestWatched(questlist[i].questID) ) then
				TitanSetVar(SC.id, questlist[i].questID, 1);
--				info.checked = TitanGetVar(SC.id, questlist[i].questID);
			end

			info.text = SC.GetQuestText(questlist[i].questID);

			info.value = {SC.id, questlist[i].questID, nil};
			info.hasArrow = 1;

			info.func = function () SC.ClickQuest () end;
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info);
			numButtons = numButtons + 1;
			
			-- Add a tracking variable to set the button id for this quest.
			TitanSetVar(SC.id, questlist[i].questID.."ButtonID"
                , numButtons);
		end	
	end
end

--
-- Toggle display of quest details
--
function SC.ToggleQShow (detail_item)
	TitanToggleVar(SC.id, detail_item);
end

--
-- Show toggle functions
--
function SC.showall_clear()
	TitanSetVar(SC.id, "ShowAll", nil);
	TitanSetVar(SC.id, "ShowElite", nil);
	TitanSetVar(SC.id, "ShowDungeon", nil);
	TitanSetVar(SC.id, "ShowRaid", nil);
	TitanSetVar(SC.id, "ShowPVP", nil);
	TitanSetVar(SC.id, "ShowRegular", nil);
	TitanSetVar(SC.id, "ShowCompleted", nil);
	TitanSetVar(SC.id, "ShowIncomplete", nil);
end

function SC.showall_set()
	TitanSetVar(SC.id, "ShowAll", 1);
	TitanSetVar(SC.id, "ShowElite", nil);
	TitanSetVar(SC.id, "ShowDungeon", nil);
	TitanSetVar(SC.id, "ShowRaid", nil);
	TitanSetVar(SC.id, "ShowPVP", nil);
	TitanSetVar(SC.id, "ShowRegular", nil);
	TitanSetVar(SC.id, "ShowCompleted", nil);
	TitanSetVar(SC.id, "ShowIncomplete", nil);
end

--
-- Toggle display of quest types
--
function SC.ToggleShowType (item)
	if ( TitanGetVar(SC.id, item) ) then
	  SC.showall_set();
	else
	  SC.showall_clear();
	  TitanSetVar(SC.id, item, 1);
	end
	DropDownList1:Hide();
end
--
-- SortBy toggle functions
--	
function SC.SortClear()
	TitanSetVar(SC.id, "SortByLevel", nil);
	TitanSetVar(SC.id, "SortByLocation", nil);
	TitanSetVar(SC.id, "SortByTitle", nil);
end

function SC.SortBy(item)
	SC.SortClear();
	TitanSetVar(SC.id, item, 1);
	DropDownList1:Hide();
end
--
-- create 2nd or 3rd level right-click menu
--
function SC.CreateMenu()
    
    local info = {};

	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
		if ( UIDROPDOWNMENU_MENU_VALUE == "Options" ) then
		   SC.MenuOptions ();
		else
		   SC.CreateQuestList();
		end
	elseif ( UIDROPDOWNMENU_MENU_LEVEL == 3 ) then
		if ( UIDROPDOWNMENU_MENU_VALUE == "DisplayAbout" ) then

			local AboutText = SC.ABOUT_POPUP_TEXT;

			info.text = AboutText;
			info.value = "AboutTextPopUP";
			info.notClickable = 1;
			info.isTitle = 0;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		elseif ( UIDROPDOWNMENU_MENU_VALUE == "Sort" ) then
	
				info = { };
				info.text = SC.SORT_TEXT;
				info.value = nil;
				info.notClickable = nil;
				info.isTitle = 1;
				info.checked = nil;
				info.func = nil;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
				-- sort by location (default)
				info = {};
				info.text = SC.SORT_LOCATION_TEXT;
				info.value = nil;
				info.notClickable = nil;
				info.isTitle = nil;
				info.checked = TitanGetVar(SC.id, "SortByLocation");
				info.func = function () SC.SortBy ("SortByLocation") end
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
				-- sort by level
				info.text = SC.SORT_LEVEL_TEXT;
				info.value = nil;
				info.notClickable = nil;
				info.isTitle = nil;
				info.checked = TitanGetVar(SC.id, "SortByLevel");
				info.func = function () SC.SortBy ("SortByLevel") end
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
				-- sort by title
				info.text = SC.SORT_TITLE_TEXT;
				info.value = nil;
				info.notClickable = nil;
				info.isTitle = nil;
				info.checked = TitanGetVar(SC.id, "SortByTitle");
				info.func = function () SC.SortBy ("SortByTitle") end
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
			elseif ( UIDROPDOWNMENU_MENU_VALUE == "QShow" ) then
				-- show / hide the quest details the user selected
					info = { };
					info.text = SC.SHOW_DETAILS_TITLE
					info.value = nil;
					info.notClickable = nil;
					info.isTitle = 1;
					info.checked = nil;
					info.func = nil;
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
					info = {};
					info.text = SC.SHOW_DETAILS_NAME
					info.value = nil;
					info.notClickable = nil;
					info.isTitle = nil;
					info.keepShownOnClick = 1
					info.checked = TitanGetVar(SC.id, "QShowText");
					info.func = function () SC.ToggleQShow ("QShowText") end
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
					info.text = SC.SHOW_DETAILS_DESCRIPTION
					info.value = nil;
					info.notClickable = nil;
					info.isTitle = nil;
					info.keepShownOnClick = 1
					info.checked = TitanGetVar(SC.id, "QShowDesc");
					info.func = function () SC.ToggleQShow ("QShowDesc") end
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
					info.text = SC.SHOW_DETAILS_OBJECTIVES
					info.value = nil;
					info.notClickable = nil;
					info.isTitle = nil;
					info.keepShownOnClick = 1
					info.checked = TitanGetVar(SC.id, "QShowObj");
					info.func = function () SC.ToggleQShow ("QShowObj") end
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
					info.text = SC.SHOW_DETAILS_REWARDS
					info.value = nil;
					info.notClickable = nil;
					info.isTitle = nil;
					info.keepShownOnClick = 1
					info.checked = TitanGetVar(SC.id, "QShowRewards");
					info.func = function () SC.ToggleQShow ("QShowRewards") end
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
					info.text = SC.SHOW_DETAILS_PARTY
					info.value = nil;
					info.notClickable = nil;
					info.isTitle = nil;
					info.keepShownOnClick = 1
					info.checked = TitanGetVar(SC.id, "QShowParty");
					info.func = function () SC.ToggleQShow ("QShowParty") end
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
		elseif ( UIDROPDOWNMENU_MENU_VALUE == "Show" ) then
			-- show the quest the user selected
			info = { };
			info.text = SC.SHOW_TEXT;
			info.isTitle = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			info = {};
			info.text = SC.SHOW_ELITE_TEXT;
			info.func = function () SC.ToggleShowType ("ShowElite") end
			info.checked = TitanGetVar(SC.id, "ShowElite");
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			info.text = SC.SHOW_DUNGEON_TEXT;
			info.func = function () SC.ToggleShowType ("ShowDungeon") end
			info.checked = TitanGetVar(SC.id, "ShowDungeon");
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			info.text = SC.SHOW_RAID_TEXT;
			info.func = function () SC.ToggleShowType ("ShowRaid") end;
			info.checked = TitanGetVar(SC.id, "ShowRaid");
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			
			info.text = SC.SHOW_PVP_TEXT;
			info.func = function () SC.ToggleShowType ("ShowPVP") end;
			info.checked = TitanGetVar(SC.id, "ShowPVP");
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			
			info.text = SC.SHOW_REGULAR_TEXT;
			info.func = function () SC.ToggleShowType ("ShowRegular") end;
			info.checked = TitanGetVar(SC.id, "ShowRegular");
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			info.text = SC.SHOW_COMPLETED_TEXT;
			info.func = function () SC.ToggleShowType ("ShowCompleted") end;
			info.checked = TitanGetVar(SC.id, "ShowCompleted");
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			info.text = SC.SHOW_INCOMPLETE_TEXT;
			info.func = function () SC.ToggleShowType ("ShowIncomplete") end;
			info.checked = TitanGetVar(SC.id, "ShowIncomplete");
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			info.text = SC.SHOW_ALL_TEXT;
			info.func = function () SC.ToggleShowType ("ShowAll") end;
			info.checked = TitanGetVar(SC.id, "ShowAll");
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		elseif ( UIDROPDOWNMENU_MENU_VALUE == "Toggle" ) then

			info = { };
			info.text = SC.TOGGLE_TEXT;
			info.isTitle = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			-- toggle blizzard's questlog
			info = {};
			if ( QuestLogFrame:IsVisible() ) then
				info.text = SC.CLOSE_QUESTLOG_TEXT;
			else
				info.text = SC.OPEN_QUESTLOG_TEXT;
			end

			info.value = "OpenQuestLog";
			info.func = function () SC.ToggleQuestLog() end
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			-- toggle MonkeyQuest
			if ( MonkeyQuestFrame ~= nil ) then
				info = {};
				if ( MonkeyQuestFrame:IsVisible() ) then
					info.text = SC.CLOSE_MONKEYQUEST_TEXT;
				else
					info.text = SC.OPEN_MONKEYQUEST_TEXT;
				end
				info.value = "OpenMonkeyQuest";
				info.func = function () SC.ToggleMonkeyQuest () end
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end

			-- toggle QuestIon
			if ( QuestIon_Frame ~= nil ) then
				info = {};
				if ( QuestIon_Frame:IsVisible() ) then
					info.text = SC.CLOSE_QUESTION_TEXT;
				else
					info.text = SC.OPEN_QUESTION_TEXT;
				end
				info.value = "OpenQuestIon";
				info.func = QuestIon_ToggleVisible;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end

			-- toggle PartyQuests
			if ( PartyQuestsFrame ~= nil ) then
				info = {};
				if ( PartyQuestsFrame:IsVisible() ) then
					info.text = SC.CLOSE_PARTYQUESTS_TEXT;
				else
					info.text = SC.OPEN_PARTYQUESTS_TEXT;
				end
				info.value = "OpenPartyQuests";
				info.func = TogglePartyQuests;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end

			-- toggle QuestHistory
 			if ( QuestHistoryFrame ~= nil ) then
				info = {};
				if ( QuestHistoryFrame:IsVisible() ) then
					info.text = SC.CLOSE_QUESTHISTORY_TEXT;
				else
					info.text = SC.OPEN_QUESTHISTORY_TEXT;
				end
				info.value = "OpenQuestHistory";
				info.func = QuestHistory_Toggle;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end	
	
			-- toggle QuestBank
			if (QuestBankFrame ~= nil ) then
				info = {};
				if ( QuestBankFrame:IsVisible() ) then
					info.text = SC.CLOSE_QUESTBANK_TEXT;
				else
					info.text = SC.OPEN_QUESTHISTORY_TEXT;
				end
				info.value = "OpenQuestBank";
				info.func = QuestBank_Toggle;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
			-- end toggles	
		end
	end
end

--
-- Click on a Quest entry to display a quest style window
--	
function SC.ClickQuest()
	-- for now, toggle the watcher for this quest
	SC.ToggleWatchStatus ()
	
--	DEFAULT_CHAT_FRAME:AddMessage("OnClick: "..arg1);
--[[
    if ( (TitanGetVar(SC.id, "ClickBehavior") 
        and not IsShiftKeyDown()) 
        or (not TitanGetVar(SC.id, "ClickBehavior") 
            and IsShiftKeyDown()) ) then
		SC.ToggleWatchStatus()
	else
		TitanPanelQuests_DisplayQuest();
		this:GetParent():Hide();
	end
--]]
end

--
-- Toggle Watch Status
--	
function SC.ToggleWatchStatus()
	local questID;
	local button;

	-- Get current Quest selected
	questID = this.value[2];

	-- Get the quest button
	for i=1, UIDROPDOWNMENU_MAXBUTTONS, 1 do
		button = getglobal("DropDownList1Button"..i);
		if ( type(button.value) == type(this.value) ) then
			if ( button.value[2] and this.value[2] == button.value[2] ) then
				break;
			else
				button = nil;
			end
		else
			button = nil;
		end
	end

    -- Add/Remove quest from Quest Tracker
	if ( IsQuestWatched(questID) ) then
		-- Update Quest Tracker
		RemoveQuestWatch(questID);
	else
		-- Update Quest Tracker
		AddQuestWatch(questID);
	end
		QuestWatch_Update();
		SC.UpdateSettings();
		-- Toggle Status
		TitanPanelRightClickMenu_ToggleVar(SC.id, questID);
		-- Update watcher tag.
		button:SetText(SC.GetQuestText(questID));
		-- Hide the secondary pane in case it is shown
		getglobal("DropDownList2"):Hide();
--[[
	DEFAULT_CHAT_FRAME:AddMessage(
	  GREEN_FONT_COLOR_CODE
	  .."TQ: "
	  ..FONT_COLOR_CODE_CLOSE
	  .."|cFFFFFF00"
	  ..(this:GetParent():GetName() or "?")
	  ..FONT_COLOR_CODE_CLOSE);
		if ( this:GetParent():GetName() == "DropDownList2" ) then
			button.checked = nil;
			getglobal(button:GetName().."Check"):Hide();
			UIDropDownMenu_Refresh();
		end
--]]
--[[
		if (SC.IsWatchAllowed(questID)) then
			QuestWatch_Update();
			SC.UpdateSettings();
			-- Toggle Status
			TitanPanelRightClickMenu_ToggleVar(SC.id, questID);
			-- Update watcher tag.
			button:SetText(SC.GetQuestText(questID));
			-- Update the secondary pane
			getglobal("DropDownList2"):Hide();
			if ( this:GetParent():GetName() == "DropDownList2" ) then
				button.checked = 1;
				getglobal(button:GetName().."Check"):Show();
				UIDropDownMenu_Refresh();
			end
		else
			-- Prevent checkmark from showing up... pretty counter-intuitive, we need to set this to checked
			-- so that the later code in UIDropDownMenu.lua will uncheck it again. - Ryessa
			if ( this:GetParent():GetName() == "DropDownList1" ) then
				button.checked = 1;
			else
				button.checked = nil;
				getglobal(button:GetName().."Check"):Hide();
				this:GetParent():Hide();
				UIDropDownMenu_Refresh();
			end;
		end
--]]
end

--
-- Click Behavior toggle function
--
function SC.ToggleClickBehavior()
	TitanToggleVar(SC.id, "ClickBehavior");
end

--
-- Group Behavior toggle function
--
function SC.ToggleGroupBehavior()
   TitanToggleVar(SC.id, "GroupBehavior");
   TitanPanelRightClickMenu_Close();
end

--
-- Show events toggle function
--
function SC.ToggleShowEvents()
   TitanToggleVar(SC.id, "ShowQuestEvents");
   TitanPanelRightClickMenu_Close();
end

--
-- toggle MonkeyQuest
--
function SC.ToggleMonkeyQuest()
   if ( MonkeyQuestFrame:IsVisible() ) then
      HideUIPanel(MonkeyQuestFrame);
   else
      ShowUIPanel(MonkeyQuestFrame);
   end
end

--
-- toggle MonkeyQuest
--
function SC.ToggleQuestLog()
	if ( QuestLogFrame:IsVisible() ) then
		HideUIPanel(QuestLogFrame)
	else
		ShowUIPanel(QuestLogFrame)
	end
end

--
-- Options Menu
--
function SC.MenuOptions ()
    local info = {};
	-- sort selection
	info = {};
	info.text = SC.SORT_TEXT;
	info.value = "Sort";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- show selection
	info.text = SC.SHOW_TEXT;
	info.value = "Show";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- show quest details
	info.text = SC.SHOW_DETAILS_TITLE
	info.value = "QShow";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- toggle dropdown menu
	info.text = SC.TOGGLE_TEXT;
	info.value = "Toggle";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);
--[[
	-- toggle click behavior
	info = {};
	info.text = SC.CLICK_BEHAVIOR_TEXT;
	info.value = "ClickBehavior";
	info.hasArrow = nil;
	info.keepShownOnClick = 1;	
	info.func = function () SC.ToggleClickBehavior () end;
	info.checked = TitanGetVar(SC.id, "ClickBehavior");
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
--]]
	-- toggle grouping 
	info = {};
	info.text = SC.GROUP_BEHAVIOR_TEXT;
	info.value = "GroupBehavior";
	info.hasArrow = nil;
	info.keepShownOnClick = nil;
	info.func = function () SC.ToggleGroupBehavior () end
	info.checked = TitanGetVar(SC.id, "GroupBehavior");
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

   -- toggle ShowQuestEvents
   info = {};
   info.text = SC.EVENTS_TEXT;
   info.value = "ShowEvents";
   info.hasArrow = nil;
   info.keepShownOnClick = nil;
   info.func = function () SC.ToggleShowEvents () end
   info.checked = TitanGetVar(SC.id, "ShowQuestEvents");
   UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);

	-- Toggle icon
	info = {};
	info.text = TITAN_PANEL_MENU_SHOW_ICON;
	info.value = {SC.id, "ShowIcon", nil};
	info.func = function() 
		TitanPanelRightClickMenu_ToggleVar({SC.id, "ShowIcon", nil})
	end
	info.checked = TitanGetVar(SC.id, "ShowIcon");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- Toggle Label Text
	info = {};
	info.text = TITAN_PANEL_MENU_SHOW_LABEL_TEXT;
	info.value = {SC.id, "ShowLabelText", nil};
	info.func = function()
		TitanPanelRightClickMenu_ToggleVar({SC.id, "ShowLabelText", nil})
	end
	info.checked = TitanGetVar(SC.id, "ShowLabelText");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE,SC.id
        , TITAN_PANEL_MENU_FUNC_HIDE
        , UIDROPDOWNMENU_MENU_LEVEL);
	TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);

    -- info about plugin
    info = {};
    info.text = SC.ABOUT_TEXT;
    info.value = "DisplayAbout";
    info.hasArrow = 1;
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
--[[	 
	 TitanPanelRightClickMenu_AddSpacer();
	 TitanPanelRightClickMenu_AddToggleIcon(SC.id);
	 TitanPanelRightClickMenu_AddToggleLabelText(SC.id);
	 TitanPanelRightClickMenu_AddToggleColoredText(SC.id);
	 
	 TitanPanelRightClickMenu_AddSpacer()
	 TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, 
	 	SC.id, TITAN_PANEL_MENU_FUNC_HIDE);
--]]
end

--
-- Build quest info when the cursor is hovered over the quest 
-- in the menu list.
--
function SC.CreateQuestList()
	local questID = UIDROPDOWNMENU_MENU_VALUE[2];

	local questTitle = SC.list[questID].questTitle;
	local questLevel = SC.list[questID].questLevel;
	local questDescription = "";
	local questObjectives = "";
	local numObjectives = 0;
	local ObjectivesText, tmpTest = "";

	questDescription = SC.list[questID].questDesc;
	questObjectives = SC.list[questID].questObjs;
	numObjectives = SC.list[questID].numObjs;

    info = {};

	-- Title for the quest detail
    info.text = questTitle; --SC.QUESTS_TEXT;
    info.value = "QuestText";
    info.notClickable = 1;
    info.isTitle = 1;
    info.notCheckable = 1;
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	 -- Show the quest text if asked
	if TitanGetVar(SC.id, "QShowText") then

		SC.DisplayDebug(10, "QuestText:"..numObjectives.."^"
			..strlen(questObjectives).."^"..questObjectives.."^");
		local descSize = SC.objective_wrap;
		local descIdxStart = 1;
		local descIdxEnd = descSize;
		local descIdx = true;
		local textToWrap = nil;
		questObjectives = string.gsub (questObjectives, "%c", "_");
		local descLen = strlen(questObjectives);
			
		--Slice up the text in a simplistic wrap.
		while descIdx do
			textToWrap = string.sub (questObjectives,descIdxStart,descIdxEnd);
			info.text = SC.ColorText(textToWrap, "Highlight");
			info.value = textToWrap;
			info.notClickable = nil;
			info.isTitle = nil;
			info.notCheckable = nil;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				 
			if descLen >= descIdxEnd then
				descIdxStart = descIdxStart + descSize;
				descIdxEnd = descIdxEnd + descSize;                
			else
				descIdx = false;
			end
		end
	end			

	-- Show the quest long description if asked
 	if TitanGetVar(SC.id, "QShowDesc") then
		-- Place the quest description in the menu.
		info.text = SC.QUESTS_DESCRIPTION
		info.value = "QuestDesc";
		info.notClickable = 1;
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		descSize = SC.objective_wrap;
		descIdxStart = 1;
		descIdxEnd = descSize;
		descIdx = true;
		textToWrap = nil;
		questDescription = string.gsub (questDescription, "%c", "_");
		descLen = strlen(questDescription);
			 
		--Slice up the text in a simplistic wrap.
		while descIdx do
			textToWrap = string.sub (questDescription,descIdxStart,descIdxEnd);
			info.text = SC.ColorText(textToWrap, "Highlight");
			info.value = textToWrap;
			info.notClickable = nil;
			info.isTitle = nil;
			info.notCheckable = nil;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				  
			if descLen >= descIdxEnd then
				descIdxStart = descIdxStart + descSize;
				descIdxEnd = descIdxEnd + descSize;                
			else
				descIdx = false;
			end
		end
	end

	-- Show the quest objectives if asked
	if TitanGetVar(SC.id, "QShowObj") then
		if ( numObjectives > 0 and SC.list[questID].questObjDetail ) then
			-- Title for the quest objs
			info.text = SC.OBJECTIVE_TEXT; --"Objectives";
			info.value = "QuestObjs";
			info.notClickable = 1;
			info.isTitle = 1;
			info.notCheckable = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
    
			for j = 1, numObjectives, 1 do
				tmpText = SC.list[questID].questObjDetail[j].text;
				SC.DisplayDebug(10, "QuestObjs:"
					..numObjectives
					.."^"..SC.list[questID].questObjDetail[j].type
					.."^"..tmpText.."^");
				if ( SC.list[questID].questObjDetail[j].finished ) then
					info.text = SC.ColorText(tmpText, "Complete");
				else
					info.text = SC.ColorText(tmpText, "Highlight");
				end
				info.value = tmpText;
				info.notClickable = nil;
				info.isTitle = nil;
				info.notCheckable = nil;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
	end
	
	-- Show the quest rewards if asked
	if TitanGetVar(SC.id, "QShowRewards") then
		-- Header for rewards stuff
		info = {};
		info.value = SC.REWARD_TEXT; --"Rewards";
		info.text = "Rewards"; --SC.QUEST_DETAILS_OPTIONS_TEXT;
		info.isTitle = 1;
		info.notClickable = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		if ( SC.list[questID].questRewardDetail ) then
			SC.CreateQuestListRewards(SC.list[questID])
		end
	end
	
	-- Show the quest party members if asked
	if TitanGetVar(SC.id, "QShowParty") then
		-- Party members on same quest.
		info.text = SC.MEMBERSONQUEST_TEXT; --"Party Members on Quest";
		info.value = "PartyMembersTitle";
		info.notClickable = 1;
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		local numInPartyOnQuest, partyNamesOnQuest = 
			SC.GetQuestPartyInfo(questID);
        info.text = SC.ColorText(partyNamesOnQuest, "Highlight");
        info.value = "PartyMembersOnQuest";
        info.notClickable = 1;
        info.isTitle = 0;
        info.notCheckable = 1;
        UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
 	end

	-- Header for options stuff
	info = {};
	info.value = "Quest Options";
	info.text = SC.QUEST_DETAILS_OPTIONS_TEXT;
	info.isTitle = 1;
	info.notClickable = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	info = {};
	-- Option: Add/Remove quest from Blizz Quest Tracker
	if ( IsQuestWatched(questID) ) then
		info = {};
		info.value = {SC.id, questID, nil};
		info.text = SC.REMOVE_FROM_WATCHER_TEXT;
		info.func = function () SC.ToggleWatchStatus () end
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	else
		if ( GetNumQuestLeaderBoards(questID) > 0 ) then
			info.value = {SC.id, questID, nil};
			info.text = SC.ADD_TO_WATCHER_TEXT;
			info.func = function () SC.ToggleWatchStatus () end			
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
	end
	
	-- Option: share quest
	info = {};
	info.value = "ShareQuest";
	info.text = SC.SHARE_QUEST_TEXT;
--	info.notClickable = not SC.list[questID].questisShareable
	info.func = function ()
        SelectQuestLogEntry(questID);
		QuestLogPushQuest();
		end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- Option: abandon quest
	info = {};
	info.value = "AbandonQuest";
	info.text = SC.ABANDON_QUEST_TEXT;
	info.func = function ()	
        DropDownList1:Hide();
        SelectQuestLogEntry(questID);
        SetAbandonQuest();
        StaticPopup_Show("ABANDON_QUEST", GetAbandonQuestName());
        end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- Option: open quest log to this quest
	info = {};
	info.value = {SC.id, questID, nil};
	info.text = SC.OPEN_QUESTLOG_TEXT;
	info.func = TitanPanelQuests_DisplayQuest;
	info.func = function ()	
        DropDownList1:Hide() -- main quest list
        SelectQuestLogEntry(questID)
        ShowUIPanel(QuestLogFrame)
        end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- Option: link quest
	info = {};
	info.value = "LinkQuest";
	info.text = SC.LINK_QUEST_TEXT;
	info.func = function ()
		ChatFrameEditBox:Insert("["..questLevel.."]"..questTitle.." ");
		end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	--[[
	local listFrame = getglobal("DropDownList"..UIDROPDOWNMENU_MENU_LEVEL)
	if listFrame then
      DEFAULT_CHAT_FRAME:AddMessage(
            "TPQ   +:"
            .." L:"..floor ((listFrame:GetLeft() * 10) * frame:GetEffectiveScale()) / 10
            .." R:"..floor ((listFrame:GetRight() * 10) * frame:GetEffectiveScale()) / 10
            .." T:"..floor ((listFrame:GetTop() * 10) * frame:GetEffectiveScale()) / 10
            .." B:"..floor ((listFrame:GetBottom() * 10) * frame:GetEffectiveScale()) / 10
            )
		DEFAULT_CHAT_FRAME:AddMessage(
				"TPQ -:"
				.." L:"..floor ((listFrame:GetLeft() * 10)) / 10
				.." R:"..floor ((listFrame:GetRight() * 10)) / 10
				.." T:"..floor ((listFrame:GetTop() * 10)) / 10
				.." B:"..floor ((listFrame:GetBottom() * 10)) / 10
						)
		DEFAULT_CHAT_FRAME:AddMessage(
				"TPQ UI+:"
				.." L:"..floor ((UIParent:GetLeft() * 10) * UIParent:GetEffectiveScale()) / 10
				.." R:"..floor ((UIParent:GetRight() * 10) * UIParent:GetEffectiveScale()) / 10
				.." T:"..floor ((UIParent:GetTop() * 10) * UIParent:GetEffectiveScale()) / 10
				.." B:"..floor ((UIParent:GetBottom() * 10) * UIParent:GetEffectiveScale()) / 10
				)
		DEFAULT_CHAT_FRAME:AddMessage(
				"TPQ UI-:"
				.." L:"..floor ((UIParent:GetLeft() * 10)) / 10
				.." R:"..floor ((UIParent:GetRight() * 10)) / 10
				.." T:"..floor ((UIParent:GetTop() * 10)) / 10
				.." B:"..floor ((UIParent:GetBottom() * 10)) / 10
				)
		local offscreenX, offscreenY = TitanUtils_GetOffscreen(listFrame);
      DEFAULT_CHAT_FRAME:AddMessage(
            "TPQ Off screen:"
            .." X:"..offscreenX
            .." Y:"..offscreenY
            .." F:"..floor ((frame:GetEffectiveScale() * 10)) / 10
            .." UI:"..floor ((UIParent:GetEffectiveScale() * 10)) / 10
            )
		offscreenX = TitanUtils_Ternary(offscreenX == 0, nil, 1);
		offscreenY = TitanUtils_Ternary(offscreenY == 0, nil, 1);
	end
	--]]
end


--
-- Display the rewards from a single quest.
--
function SC.CreateQuestListRewards(theItem)
	local info = {};
	local text = ";"
    local usable = "x";
		if ( theItem.questRewardDetail ) then
			if ( theItem.questRewardDetail.money == 0
				and theItem.questRewardDetail.numRewards == 0
				and theItem.questRewardDetail.numChoices == 0
				and theItem.questRewardDetail.numSpells == 0
			    ) then
				 info.text = SC.ColorText("None", "Highlight");
				 info.value = "None";
				 info.notClickable = nil;
				 info.isTitle = nil;
				 info.notCheckable = nil;
				 UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			else
				-- Show the money!
				if (theItem.questRewardDetail.money > 0) then
				local gold, silver, copper =
				   SC.BreakMoney(theItem.questRewardDetail.money)
				text = SC.ColorText(gold.."g ", "Gold")
				..SC.ColorText(silver.."s ", "Silver")
				..SC.ColorText(copper.."c ", "Copper")
				;
				info.text = text;
				info.value = "Money";
				info.notClickable = nil;
				info.isTitle = nil;
				info.notCheckable = nil;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				end
				
				if ( theItem.questRewardDetail.numRewards > 0 ) then
					for i=1, theItem.questRewardDetail.numRewards do
						local r, g, b, hex = 
						GetItemQualityColor(
                            theItem.questRewardDetail.rewards[i].quality);
						text = SC.ColorTextRBG (
							"["
							..theItem.questRewardDetail.rewards[i].name
							.."]"
							,r, g, b
						);
						if (theItem.questRewardDetail.rewards[i].usable) then
                        usable = "Highlight";
                        else
                        usable = "Unuseable";
						end
						text = text..SC.ColorText("x", usable);
						if (theItem.questRewardDetail.rewards[i].numItems > 1) then
						text = text..theItem.questRewardDetail.rewards[i].numItems;
						end
						info.text = text;
						info.value = "Reward"..i;
						info.notClickable = nil;
						info.isTitle = nil;
						info.notCheckable = nil;
						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
					end
				end
				
				if ( theItem.questRewardDetail.numChoices > 0 ) then
						info.text = "Choose:";
						info.value = "Choose";
						info.notClickable = nil;
						info.isTitle = nil;
						info.notCheckable = nil;
						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
					for i=1, theItem.questRewardDetail.numChoices do
						local r, g, b, hex = 
						GetItemQualityColor(theItem.questRewardDetail.choices[i].quality);
						if (theItem.questRewardDetail.choices[i].usable) then
                        usable = "Highlight";
                        else
                        usable = "Unuseable";
						end
						text = SC.ColorTextRBG (
                            "- ["
							..theItem.questRewardDetail.choices[i].name
							.."]"
							,r, g, b
						);
						text = text..SC.ColorText("x", usable);
						if (theItem.questRewardDetail.choices[i].numItems > 1) then
						text = text..theItem.questRewardDetail.choices[i].numItems;
						end
						info.text = text;
						info.value = "Choice"..i;
						info.notClickable = nil;
						info.isTitle = nil;
						info.notCheckable = nil;
						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
					end
				end
				
				if ( theItem.questRewardDetail.numSpells > 0 ) then
					for i=1, theItem.questRewardDetail.numSpells do
						local r, g, b, hex = 
						GetItemQualityColor(theItem.questRewardDetail.spells[i].quality);
						text = SC.ColorTextRBG (
							"["
							..theItem.questRewardDetail.spells[i].name
							.."]"
							,r, g, b
						);
						if (theItem.questRewardDetail.spells[i].usable) then
                        usable = "Highlight";
                        else
                        usable = "Unuseable";
						end
						text = text..SC.ColorText("x", usable);
						if (theItem.questRewardDetail.spells[i].numItems > 1) then
						    text = text
                                ..theItem.questRewardDetail.spells[i].numItems;
						end
						info.text = text;
						info.value = "Spells"..i;
						info.notClickable = nil;
						info.isTitle = nil;
						info.notCheckable = nil;
						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
					end
				end
			end
		end
	end