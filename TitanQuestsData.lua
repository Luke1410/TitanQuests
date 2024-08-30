--------------------------------------------------------------------------
-- TitanQuestsData.lua 
--------------------------------------------------------------------------
--[[

Create the TitanQuests namespace and any 'global' data needed
]]--
TitanQuests = {}

-- Create a shortcut to save typing
local SC = TitanQuests

--
-- Titan Panel Variables
--
SC.app = "Titan";
SC.id = "Quests";
SC.version = "2.05.30000";
SC.AUTHOR = "urnati"

SC.objective_wrap = 65;

SC.artwork_path = "Interface\\AddOns\\TitanQuests\\Artwork\\";

SC.watched = nil; 
SC.settings_init = nil;

--
-- Cached quest list and counts
--
SC.list = {};
SC.list_shadow = {}
--[[
SC.list attributes:
.questID
.questTitle
.questLevel 
.questTag
.questisHeader
.questisComplete
.questLocation
.questGroup 
.questDaily
.questRewardDetail.money
.questRewardDetail.numRewards
.questRewardDetail.numChoices 
.questRewardDetail.numSpells
.questRewardDetail.rewards <list>
.questRewardDetail.rewards.name
.questRewardDetail.rewards.texture
.questRewardDetail.rewards.usable 
.questRewardDetail.rewards.numItems 
.questRewardDetail.rewards.quality
.questRewardDetail.rewards.rewardType
.questRewardDetail.choices <list>
.questRewardDetail.choices.name
.questRewardDetail.choices.texture
.questRewardDetail.choices.usable 
.questRewardDetail.choices.numItems 
.questRewardDetail.choices.quality
.questRewardDetail.choices.rewardType
.questRewardDetail.spells <list>
.questRewardDetail.spells.name
.questRewardDetail.spells.texture
.questRewardDetail.spells.usable 
.questRewardDetail.spells.numItems 
.questRewardDetail.spells.quality
.questRewardDetail.spells.rewardType
-
--]]
SC.count = {};
--[[
SC.count attributes:
.total
.elite
.dungeon
.raid
.pvp
.daily
.regular
.complete
.incomplete
--]]

SC.debug = false;
SC.debug_level = 1;
