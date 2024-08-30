--------------------------------------------------------------------------
-- TitanQuestsUtils.lua 
--------------------------------------------------------------------------
--[[
	Contains various utility functions for Titan [Quests].
]]--

-- create a shortcut to save typing in this file
local SC = TitanQuests

local objects_pattern = '^' .. QUEST_OBJECTS_FOUND:gsub('(%%%d?$?.)', '(.+)') .. '$' --QUEST_OBJECTS_FOUND = "%s: %d/%d"
local monsters_pattern = '^' .. QUEST_MONSTERS_KILLED:gsub('(%%%d?$?.)', '(.+)') .. '$' --QUEST_MONSTERS_KILLED = "%s slain: %d/%d"
local faction_pattern = '^' .. QUEST_FACTION_NEEDED:gsub('(%%%d?$?.)', '(.+)') .. '$' --QUEST_FACTION_NEEDED = "%s: %s / %s"

local done_text = {[-1]=" FAILED", [0]=" not complete", [1]=" complete"}

--
-- utility function to build old quest list to compare
--
function SC.BreakQuestDetail (j, quest_id)
	SC.DisplayDebug(1, "func: _BreakQuestDetail")
	local obj_text = "nyl"
	local obj_line = "nyl"
	local obj_type = "nyl"
	local obj_done = nil
	local obj_num = 0
	local obj_needed = 0
	local text, qtype, finished = (entry);
	
	local text, qtype, finished = GetQuestLogLeaderBoard(j, quest_id);

	text = (text or "Unk")
	qtype = (qtype or "event")
			
	if qtype == 'item' or qtype == 'object' then
		obj_text,obj_num,obj_needed = text:match(objects_pattern)
	elseif qtype == 'monster' then
		obj_text,obj_num,obj_needed = text:match(monsters_pattern)
		if obj_text == nil or obj_num == nil or obj_needed == nil then
			obj_text,obj_num,obj_needed = text:match(objects_pattern)
		end
	elseif qtype == 'reputation' then
		obj_text,obj_num,obj_needed = text:match(faction_pattern)
	elseif qtype == 'event' then
		if finished then
			obj_needed = 1
		end
	end
	
	obj_line = (text or "Unk")
	obj_type = qtype
	obj_done = finished
	obj_text = (obj_text or "Unk")
	obj_num = (tonumber(obj_num) or 0)
	obj_needed = (tonumber(obj_needed) or 0)

	return obj_line, obj_type, obj_done, obj_text, obj_num, obj_needed
end
--
-- utility function to an entry in the shadow list
--
function SC.OutputShadowDetail (entry)
	DEFAULT_CHAT_FRAME:AddMessage(
        GREEN_FONT_COLOR_CODE
		.."TQ Shadow: "
		..FONT_COLOR_CODE_CLOSE
		.."|cFFFFFF00"
		.."'"
		..(entry or "?").."' "
		..(SC.list_shadow[entry].numObjs or "?").." "
		..(SC.list_shadow[entry].done or "F").." "
		..FONT_COLOR_CODE_CLOSE);
	for i = 1,#(SC.list_shadow[entry].objs) do
		-- output the objectives
		otext = " "
			..i.."-- '"..(SC.list_shadow[entry].objs[i].text or "UNKNOWN").."' "
			..(SC.list_shadow[entry].objs[i].finished or " F").." "
			..(SC.list_shadow[entry].objs[i].obj_num or " ?").." / "
			..(SC.list_shadow[entry].objs[i].obj_needed or " ?").." "
		DEFAULT_CHAT_FRAME:AddMessage(
			GREEN_FONT_COLOR_CODE
			.."TQ Shadow--"
			..FONT_COLOR_CODE_CLOSE
			.."|cFFFFFF00"
			..otext
			..FONT_COLOR_CODE_CLOSE)
	end
end

--
-- utility function to build old quest list to compare
--
function SC.CompareQuestDetail (entry)
   SC.DisplayDebug(1, "func: _CompareQuestDetail")

	-- just in case something bad happened, don't punish the user
	if not entry then
		DEFAULT_CHAT_FRAME:AddMessage(
		GREEN_FONT_COLOR_CODE
		..SC.app..SC.id
		.." "
		..FONT_COLOR_CODE_CLOSE
		..RED_FONT_COLOR_CODE
		.." Unknown quest entry to CompareQuestDetail!!!"
		..FONT_COLOR_CODE_CLOSE);
		return
	end

	local done_idx = (entry.questisComplete or 0)
	local is_done = done_text[done_idx]
   
	if SC.list_shadow[entry.questTitle] then
		if SC.list_shadow[entry.questTitle].done == is_done then
			-- Check if any objs changed
			if entry.numObjs > 0 then
				for i = 1, entry.numObjs do
					local quest_text = entry.questObjDetail[i].text
					local obj_line, obj_type, obj_done, obj_text, quest_num, obj_needed 
						= SC.BreakQuestDetail (i, entry.questID) 
					local shadow_text = SC.list_shadow[entry.questTitle].objs[i].text
					local shadow_num = SC.list_shadow[entry.questTitle].objs[i].obj_num
					if shadow_num == quest_num then
						-- no change to report
					else
						if done_idx ~= 1 then -- is complete
							-- output the difference to the user
							local otext = quest_text
							if (entry.questObjDetail[i].finished) then
								otext = otext.." ".."**"
							end
							UIErrorsFrame:AddMessage(
								otext, 
								0.0, 1.0, 1.0, 
								1, UIERRORS_HOLD_TIME) 
						end -- 
						-- save the update
						SC.list_shadow[entry.questTitle].objs[i].text = 
							entry.questObjDetail[i].text
						SC.list_shadow[entry.questTitle].objs[i].obj_num = quest_num
					end -- shadow_text
				end -- for loop
			end -- numObjs
		else
			if SC.list_shadow[entry.questTitle].done ~= done_text[1] 
      		and ( is_done == done_text[1] or
      			is_done == done_text[-1] ) then 
				-- if the quest is going complete tell the user
				local otext = " '"..(entry.questTitle or "UNKNOWN").."' "
					..(is_done or " ?")
				DEFAULT_CHAT_FRAME:AddMessage(
					GREEN_FONT_COLOR_CODE
					..SC.app..SC.id.." "
					..FONT_COLOR_CODE_CLOSE
					.."|cFFFFFF00"
					..otext
					..FONT_COLOR_CODE_CLOSE);

				UIErrorsFrame:AddMessage(
					otext, 
					0.0, 1.0, 1.0, 
					1, UIERRORS_HOLD_TIME) 
			end
            SC.list_shadow[entry.questTitle].done = is_done
		end
	else
		-- assume it is a new quest and place it in the shadow list
		-- NOTE: Blizz can send mulitple update events before the 
		-- quest is fully filled in 
		SC.list_shadow[entry.questTitle] = {
			numObjs = entry.numObjs,
			done = is_done,
			objs = {},
			current = true}
        local obj = {}
        for i = 1, entry.numObjs do
			local obj_line, obj_type, obj_done, obj_text, obj_num, obj_needed 
					= SC.BreakQuestDetail (i, entry.questID) 
			obj = 
              {text = (entry.questObjDetail[i].text or "?"),
               type = (entry.questObjDetail[i].type or "?"),
               finished = (entry.questObjDetail[i].finished or "?"),
			   obj_num = (obj_num or 0),
			   obj_needed = (obj_needed or 0)
              }
            table.insert(SC.list_shadow[entry.questTitle].objs, obj)
        end
--		SC.OutputShadowDetail (entry.questTitle)
   end
end
--
-- utility function to build quest list cache
--
function SC.BuildQuestList()
    SC.DisplayDebug(1, "func: _BuildQuestList")

    -- (returns table of current active quests and location headers)
	local NumEntries, NumQuests;

	local Title, Level, Tag, suggestedGroup, isHeader, isCollapsed,
	 isComplete, isDaily;
	local questIndex;

	local Location;

	local useTag;
	local completeTag;
	local questWatched = "";
	local diff;

	local QuestList, ObjList = { };

   -- expand the quest log fully just in case.
   --ExpandQuestHeader (0);
	for title, current in pairs(SC.list_shadow) do
		SC.list_shadow[title].current = false
	end

	NumEntries, NumQuests = GetNumQuestLogEntries();
	SC.DisplayDebug(1, "TQ build quest nums: "
        ..NumEntries..":"
        ..NumQuests..":"
        )
	
	for questIndex=1, NumEntries do
		Title, Level, Tag, suggestedGroup, isHeader, 
        isCollapsed, isComplete, isDaily = GetQuestLogTitle(questIndex);

        SC.DisplayDebug(10, "TQ build list: "
        ..questIndex..":"
        ..Title..":"
        ..Level..":"
        ..suggestedGroup..":"
        )

		local entry = {}
		if ( Level == 0 ) then
			-- Set the location for subsequent quests in the same area.
			Location = Title;
			-- Make a header item in the list to remove the need to 
			-- search the quest list. Use the queest log id instead.
			entry = { questID = questIndex, 
                    questTitle = Title, 
                    questLevel = Level, 
                    questTag = Tag, 
                    questisHeader = isHeader, 
                    questisComplete = isComplete, 
                    questLocation = Title, 
                    questGroup = suggestedGroup,
					questisShareable = nil,
                    questisDaily = isDaily,
					questDesc = "<none>",
					questObjs = "<none>",
					numObjs = 0,
					questRewardDetail = nil,
					questObjDetail = nil,
                    };
			table.insert(QuestList, entry);
		else	
			-- select the quest entry
			SelectQuestLogEntry(questIndex);
			QuestLog_SetSelection(questIndex);
			local questDescription, questObjectives = GetQuestLogQuestText();

			local numObjectives = GetNumQuestLeaderBoards();
			entry = { questID = questIndex, 
                    questTitle = Title, 
                    questLevel = Level, 
                    questTag = Tag, 
                    questisHeader = isHeader, 
                    questisComplete = isComplete, 
                    questLocation = Location, 
                    questGroup = suggestedGroup,
                    questisDaily = isDaily,
					questisShareable = GetQuestLogPushable(),
					questDesc = questDescription,
					questObjs = questObjectives,
					numObjs = numObjectives,
					questRewardDetail = SC.RewardDetails(questIndex),
                    questObjDetail = SC.BuildObjsInfo(questIndex),
                    };
			table.insert(QuestList, entry);
		end
		if TitanGetVar(SC.id, "ShowQuestEvents") then
			SC.CompareQuestDetail (entry)
		end
	end	
    SC.DisplayTheList(QuestList)
	return QuestList;
end

--
-- utility function to get the quest count cache
--
function SC.BuildQuestCount(questlist)
	-- counters
	local numElite = 0;
	local numDungeon = 0;
	local numRaid = 0;
	local numPVP = 0;
	local numReg = 0;
	local numComplete = 0;
	local numIncomplete = 0;
	local numDaily = 0;

	local i = 0;

	local numQuests = 0;
	local numEntries = 0;

    -- Clear the counters
    qcount = {};

	-- total number of quests
	numEntries = #(questlist); -- table.getn(questlist);
	numQuests = numEntries;

	-- count the different type of quests and count completed quests
	for i=1, numEntries do
		if ( questlist[i].questLevel == 0 ) then
            -- is a header so subtract from the number of entries
            numQuests = numQuests - 1;
        elseif ( questlist[i].questTag == ELITE ) then
			numElite = numElite + 1;
		elseif ( questlist[i].questTag == SC.DUNGEON ) then
			numDungeon = numDungeon + 1;
		elseif ( questlist[i].questTag == SC.RAID ) then
			numRaid = numRaid + 1;
		elseif ( questlist[i].questTag == SC.PVP ) then
			numPVP = numPVP + 1;
		else
			numReg = numReg + 1;
		end

		-- count complete and incomplete quests
        if ( questlist[i].questLevel ~= 0 ) then 
            if ( questlist[i].questisComplete ) then
                numComplete = numComplete + 1;
            else
                numIncomplete = numIncomplete + 1;
            end
		end
        
        -- check for daily quests
		if ( questlist[i].questisDaily ) then
			numDaily = numDaily + 1;
		end
	end

    qcount.total = numQuests;
    qcount.elite = numElite;
    qcount.dungeon = numDungeon;
    qcount.raid = numRaid;
    qcount.pvp = numPVP;
    qcount.regular = numReg;
    qcount.daily = numDaily;
    qcount.complete = numComplete;
    qcount.incomplete = numIncomplete;

	 SC.DisplayDebug(1, "TQ build quest counts: "
		 .."tot"..numElite..":"
		 .."e"..numElite..":"
		 .."d"..numDungeon..":"
		 .."r"..numRaid..":"
		 .."p"..numPVP..":"
		 .."y"..numDaily..":"
		 .."c"..numComplete..":"
		 .."ic"..numComplete..":"
			)
    return qcount;
end

--
-- utility function to get the quest objectives into cache
--
function SC.BuildObjsInfo(quest_id)
    local questObjs = {};
    local text;
    local qtype;
    local finished;
	local obj_text
	local obj_num
	local obj_needed
	 
	local numObjectives = GetNumQuestLeaderBoards(quest_id)

	-- Fill in the list of quest rewards
    if ( numObjectives > 0 ) then
        for j = 1, numObjectives, 1 do
    
			obj_line, obj_type, obj_done, obj_text,obj_num,obj_needed 
				= SC.BreakQuestDetail (j, quest_id)

            SC.DisplayDebug(10, "Build QuestObjs:"
                    ..numObjectives.."^"..obj_type.."^"..obj_line.."^");
            local entry = { text = obj_line, 
				type = obj_type,
				finished = obj_done,
				obj_text = obj_text,
				obj_num = obj_num,
				obj_needed = obj_needed};
            table.insert(questObjs, entry);
        end
        questObjs.numObjs = numObjectives;
    else
    	questObjs = nil;
    end
    
    return questObjs;
end

--
-- utility function to get the party members on same quest
--
function SC.GetQuestPartyInfo(questID)
	local numPartyMembers = GetNumPartyMembers();
	local membersOnQuest = UnitName("player").." " --"<"..SC.SOLO..">";
	local numOnQuest = 0;
    local name, realm, punit = "<noone>", "<realm>", "";
    local onQuest;
	if ( numPartyMembers >= 0 ) then
		for i=1, numPartyMembers do
--			DEFAULT_CHAT_FRAME:AddMessage("TQ1: ".."party"..i..":"
--				..questID);
            onQuest = IsUnitOnQuest( questID, "party"..i );
			if ( onQuest ) then
                name = UnitName("party"..i);
                SC.DisplayDebug(10, "TQ party name:"..name);
				membersOnQuest = membersOnQuest..name.." ";
				numOnQuest = numOnQuest + 1
--				DEFAULT_CHAT_FRAME:AddMessage("TQ2: ".."party"..i..":"
--				  ..questID..":"..name..":"..membersOnQuest..":");
			end
		end
	end
    return numOnQuest, membersOnQuest
end

--
-- utility function to get the tag header for a quest
--
function SC.GetQuestTagText(Tag, isDaily)
	local useTag = "";

	if ( Tag == ELITE ) then
		useTag = SC.TAG_ELITE;
	elseif ( Tag == SC.DUNGEON ) then
		useTag = SC.TAG_DUNGEON;
	elseif ( Tag == SC.RAID ) then
		useTag = SC.TAG_RAID;
	elseif ( Tag == SC.PVP ) then
		useTag = SC.TAG_PVP;
	elseif ( Tag == DUNGEON_DIFFICULTY2 ) then
		useTag = SC.TAG_HERIOC;
	else
		useTag = SC.TAG_NORMAL;
	end 
	
    -- Check if a daily tag is needed.
    -- Add the tag in case it is a dungeon daily.
    if ( isDaily ) then
       useTag = useTag..SC.TAG_DAILY
    end

	return useTag;
end

--
-- utility function to get the string tag for a watched quest
--
function SC.GetQuestWatchText(questID)
	local questWatched;

	if ( IsQuestWatched(questID) ) then
		questWatched = SC.ColorText(" ("
            ..SC.TAG_WATCHER..")", "Watcher");
	else
		questWatched = "";
	end
	
	return questWatched;
end

--
-- utility function to get the string tag for a completed quest
--
function SC.GetQuestCompleteText(questID, isComplete)
	local completeTag = "";
	if ( isComplete ) then
		if ( isComplete == 1) then -- 'Complete' per spec of GetQuestLogTitle
			completeTag = "  ("..TEXT(COMPLETE)..")";
		elseif ( isComplete == -1 ) then -- 'Failed' per spec of GetQuestLogTitle
			completeTag = "  ("..TEXT(FAILED)..")";
		else
			completeTag = "  <?>";
		end
	end
    return completeTag;
end

--
-- utility function to get the location string for a quest
--
function SC.GetQuestLocationText(questID)
	if ( TitanGetVar(SC.id, "SortByLocation") 
        and TitanGetVar(SC.id, "GroupBehavior") ) then
		return "";
	else
		return TitanUtils_GetNormalText("  ["
        ..TitanQuests.list[questID].questLocation.."]");
	end
end

--
-- utility function to build the quest title
--
function SC.GetQuestText(questID)
	local isComplete = TitanQuests.list[questID].questisComplete;
	local isDaily = TitanQuests.list[questID].questisDaily;
	local Tag = TitanQuests.list[questID].questTag;
 	local Level = TitanQuests.list[questID].questLevel;
 	local Title = TitanQuests.list[questID].questTitle;
	local suggestedGroup = TitanQuests.list[questID].questGroup;
 --	local isHeader = TitanQuests.list[questID].questisHeader;

	local locationTag = SC.GetQuestLocationText(questID); 

	local tmpLevel = TitanUtils_GetColoredText (
		"["..Level..SC.GetQuestTagText(Tag, isDaily).."] "
		, GetDifficultyColor(Level));
	local tmpComp = SC.ColorText(
		SC.GetQuestCompleteText(questID, isComplete), 
		"Complete");
	local tmpWatch = SC.GetQuestWatchText(questID);
   
	local questTag;
	local grpNum = "";
    if ( suggestedGroup > 0 ) then
        grpNum = " ["..suggestedGroup.."]";
    end
    
    local numInPartyOnQuest, partyNamesOnQuest = 
	 	SC.GetQuestPartyInfo(questID)
    if ( numInPartyOnQuest > 0 ) then
        numInPartyOnQuest = numInPartyOnQuest.." "
    else
        numInPartyOnQuest = "  ";
    end

	SC.DisplayDebug(10, "QUEST TITLE TAG:"
		.."lvl^"..tmpLevel.."^"
		.."#party^"..numInPartyOnQuest.."^"
		.."title^"..Title.."^"
		.."grp^"..grpNum.."^"
		.."done^"..tmpComp.."^"
		.."loc^"..locationTag.."^"
		.."watch^"..tmpWatch.."^"
	   );
	questTag = tmpLevel
        ..numInPartyOnQuest.." "
        ..Title
        ..grpNum
        ..tmpComp
        ..locationTag
        ..tmpWatch;

	return questTag;
end

--
-- IsWatchAllowed
--	
function SC.IsWatchAllowed(questID)
	if ( GetNumQuestLeaderBoards(questID) == 0 ) then
		-- Set an error that there are no objectives for the quest, 
        -- so it may not be watched.
		UIErrorsFrame:AddMessage(QUEST_WATCH_NO_OBJECTIVES, 
            1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME);
		return false;
	end
	if ( GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS ) then
       	-- Set an error message if trying to show too many quests
        UIErrorsFrame:AddMessage(format(QUEST_WATCH_TOO_MANY, 
            MAX_WATCHABLE_QUESTS), 
            1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME);
		return false;
    end

	-- Retrieve the quest info for questID.
	if ( TitanQuests.list[questID].questisComplete ) then
		-- We can't watch a complete item.
		return false;
	end
	return true;
end

--
-- Get the reward details of the quest.
--
function SC.RewardDetails(questID)
	local numQuestRewards;
	local numQuestChoices;
	local numQuestSpellRewards = 0;
	local money;
    local questRewardDetail = {};
    local questRewards = {};
    local questChoices = {};
    local questSpells = {};
	local name, texture, numItems, quality, isUsable;
    
    -- Select the specific quest log entry so the various
    -- the various Getxxx functions will work,
    SelectQuestLogEntry(questID);
	numQuestRewards = GetNumQuestLogRewards();
	numQuestChoices = GetNumQuestLogChoices();
	if ( GetQuestLogRewardSpell() ) then
	 	numQuestSpellRewards = 1;
	end
	money = GetQuestLogRewardMoney();
    
    SC.DisplayDebug(10,"reward details: "
    ..questID..":"
    ..numQuestRewards..":"
    ..numQuestChoices..":"
    ..numQuestSpellRewards..":"
    ..money..":"
    )

	-- Fill in the list of quest rewards
    if ( numQuestRewards > 0 ) then
	    for i=1, numQuestRewards, 1 do
		    name, texture, numItems, quality, isUsable = 
						 GetQuestLogRewardInfo(i);
						 if name == nil then
							 name = "Unknown"
						 end
						 if quality == nil then
							 quality = 0
						 end
						 if usable == nil then
							 usable = false
						 end
		    local entry = { name = name, 
						 texture = texture,
						 usable = isUsable, 
						 numItems = numItems, 
						 quality = quality,
						 rewardType = "reward"};
		    table.insert(questRewards, entry);
		end
    else
    	questRewards = nil;
    end

    -- Fill in the list of reward choices
    if ( numQuestChoices > 0 ) then
		for i=1, numQuestChoices, 1 do
				name, texture, numItems, quality, isUsable = 
                    GetQuestLogChoiceInfo(i);
			  if name == nil then
				  name = "Unknown"
			  end
			  if quality == nil then
				  quality = 0
			  end
			  if usable == nil then
				  usable = false
			  end
				local entry = { name = name, 
                    texture = texture,
						  usable = isUsable, 
						  numItems = numItems, 
						  quality = quality,
                    rewardType = "choice"};
			table.insert(questChoices, entry);
        end
	else
		questChoices = nil;
	end

    -- Fill in the reward spells
	if ( numQuestSpellRewards > 0 ) then
		texture, name = GetQuestLogRewardSpell()
        local entry = { name = name, 
            texture = texture,
				usable = true, -- assume true since the routine does not tell
				numItems = 1, -- assume 1 since the routine does not tell
				quality = 100, -- assume since the routine does not
            rewardType = "spell"};
		table.insert(questSpells, entry);
    else
    	questSpells = nil;
    end
    
    -- now that we have the reward info, collect it to return.
    questRewardDetail.money = money;
    questRewardDetail.numRewards = numQuestRewards;
    questRewardDetail.numChoices = numQuestChoices;
    questRewardDetail.numSpells = numQuestSpellRewards;
	 questRewardDetail.rewards = questRewards;
    questRewardDetail.choices = questChoices;
    questRewardDetail.spells = questSpells;
	
	return questRewardDetail;
end

--
-- utility function to color the text by useage
--
function SC.ColorText(text, useType)
	if (text and useType) then
		--local colorCode = "|cff"..redColorCode..greenColorCode..blueColorCode;
        -- Default to an off green
		local colorCode = "|cff"
            ..format("%02x", 204)..format("%02x", 255)..format("%02x", 0);

        if ( useType == "Watcher" ) then
		    colorCode = "|cff"
                ..format("%02x", 0)..format("%02x", 102)..format("%02x", 255);
        elseif ( useType == "Complete" ) then
		    colorCode = "|cff"
                ..format("%02x", 255)..format("%02x", 0)..format("%02x", 102);
		elseif ( useType == "Gold" ) then
			colorCode = "|cff"
				..format("%02x", 204)..format("%02x", 153)..format("%02x", 0);        
		elseif ( useType == "Silver" ) then
			colorCode = "|cff"
				..format("%02x", 204)..format("%02x", 204)..format("%02x", 204);        
        elseif ( useType == "Copper" ) then
			colorCode = "|cff"
		  		..format("%02x", 204)..format("%02x", 102)..format("%02x", 0);
		elseif ( useType == "Unuseable" ) then
			colorCode = "|cff"
				..format("%02x", 204)..format("%02x", 0)..format("%02x", 0);        
		elseif ( useType == "Highlight" ) then
            colorCode = HIGHLIGHT_FONT_COLOR_CODE;
        elseif ( useType == "Normal" ) then
            colorCode = NORMAL_FONT_COLOR_CODE;
        end
        
		return colorCode..text..FONT_COLOR_CODE_CLOSE;
	end
end

--
-- utility function to color the text by r, b, g
--
function SC.ColorTextRBG(text, red, blue, green)
	if (text and red and blue and green) then
		local colorCode = "|cff"
            ..format("%02x", red * 255)
			..format("%02x", blue * 255)
			..format("%02x", green * 255);

		return colorCode..text..FONT_COLOR_CODE_CLOSE;
	end
end

--
-- utility function to break money into gold / silver / copper
--
function SC.BreakMoney(money)
     -- Non-negative money only
     if (money >= 0) then
          local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
          local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
          local copper = mod(money, COPPER_PER_SILVER);
          return gold, silver, copper;
     end
end     

--
-- utility function to put a msg to the chat window
--
function SC.ChatPrint(msg)
    DEFAULT_CHAT_FRAME:AddMessage(msg);
end

--
-- debug - put the text msg to chat
--
function SC.DisplayDebug(level, msg)
	-- put the text to chat if 'debug' is set and  
	-- the debug level is higher than the msg level
   if ( TitanQuests.debug and TitanQuests.debug_level >= level ) then
   	SC.ChatPrint(TitanQuests.id.."_"
        	..TitanQuests.version
            .." DEBUG: "
            ..msg);
   end
end

--
-- debug - put the text msg to chat
--
function SC.DisplayDebugItem(level, label, value)
    tmpstr="<nil>"
	-- put the text to chat if 'debug' is set and  
	-- the debug level is higher than the msg level
   if ( TitanQuests.debug and TitanQuests.debug_level >= level ) then
    if value then
    else
      tmpstr="<nil>"
    end
   	SC.ChatPrint(TitanQuests.id.."_"
        	..TitanQuests.version
            .." DEBUG: "
            ..label
            ..tmpstr);
   end
end

--
-- debug - Display a single quest from the quest list cache
--
function SC.DisplayTheItem(id, theItem)
	local textbool = "";
	local tmpstr = ""
	textbool = theItem.questisComplete;
	if (textbool == nil) then
		textbool = 0
	end
	if (theItem.questisShareable == nil) then
		tmpstr = "false"
	else
		tmpstr = "true"
	end
	SC.DisplayDebug(3, 
		"idx:"..id..":"
		.."lvl:"..theItem.questLevel..":"
		.."title:"..theItem.questTitle..":"
		.."loc:"..theItem.questLocation..":"
		.."id:"..theItem.questID..":"
		.."sharable:"..tmpstr..":"
		.."done:"..textbool..":"
	   );
		SC.DisplayDebug(5, "__details: "
--			.."^"..theItem.questDesc
			.."^"..theItem.questObjs
			.."^"..theItem.numObjs);
		if ( theItem.questRewardDetail ) then
			SC.DisplayDebug(0,
				"__$:"..theItem.questRewardDetail.money);
			if ( theItem.questRewardDetail.numRewards > 0 ) then
				for i=1, theItem.questRewardDetail.numRewards do
					if (theItem.questRewardDetail.rewards[i].usable) then
						textbool = "true"
					else
						textbool = "false"
					end
					SC.DisplayDebug (1,"__rewards: "
						..theItem.questRewardDetail.rewards[i].name..":"
						--..theItem.questRewardDetail.rewards[i].texture..":"
						..textbool..":"
						..theItem.questRewardDetail.rewards[i].numItems..":"
						..theItem.questRewardDetail.rewards[i].quality..":"
						)
				end
			else
				SC.DisplayDebug(5,"__rewards: <none>");				
			end
			if ( theItem.questRewardDetail.numChoices > 0 ) then
				for i=1, theItem.questRewardDetail.numChoices do
					if (theItem.questRewardDetail.choices[i].usable) then
						textbool = "true"
					else
						textbool = "false"
					end
					SC.DisplayDebug (5,"__choices: "
					..theItem.questRewardDetail.choices[i].name..":"
					--..theItem.questRewardDetail.rewards[i].texture..":"
					..textbool..":"
					..theItem.questRewardDetail.choices[i].numItems..":"
					..theItem.questRewardDetail.choices[i].quality..":"
					)
				end
			else
				SC.DisplayDebug(5,"__choices: <none>");				
			end
			if ( theItem.questRewardDetail.numSpells > 0 ) then

				for i=1, theItem.questRewardDetail.numSpells do
					if (theItem.questRewardDetail.spells[i].usable) then
						textbool = "true"
					else
						textbool = "false"
					end
				SC.DisplayDebug (5,"__spells: "
					..theItem.questRewardDetail.spells[i].name..":"
					--..theItem.questRewardDetail.rewards[i].texture..":"
					..textbool..":"
					..theItem.questRewardDetail.spells[i].numItems..":"
					..theItem.questRewardDetail.spells[i].quality..":"
					)
				end
			else
				SC.DisplayDebug(5,"__spells: <none>");				
			end
		end
        
        if ( theItem.questObjDetail ) then
			for i=1, theItem.questObjDetail.numObjs do
                if ( theItem.questObjDetail[i].finished ) then
                    textbool = "true"
                else
                    textbool = "false"
                end
                SC.DisplayDebug (5,"__objs: "
                    ..theItem.questObjDetail[i].text..":"
                    ..theItem.questObjDetail[i].type..":"
                    ..textbool..":"
                    )
			end
        end
	end
	
--
-- debug - display the list of quests
--
function SC.DisplayTheList(thelist)
	-- Walk the list of quests to display each one
	-- into chat in debug mode.
	local i = 0;
	for i=1, table.getn(thelist) do
		SC.DisplayTheItem (i, thelist[i]);
	end
end