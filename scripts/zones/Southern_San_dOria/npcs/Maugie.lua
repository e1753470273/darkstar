-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Maugie
--  General Info NPC
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs");
require("scripts/globals/settings");
require("scripts/globals/quests");

function onTrade(player,npc,trade)
    if (player:getQuestStatus(SANDORIA,FLYERS_FOR_REGINE) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(532,1) and trade:getItemCount() == 1 and player:getVar("tradeMaugie") == 0) then
            player:messageSpecial(ID.text.MAUGIE_DIALOG);
            player:addVar("FFR", -1)
            player:setVar("tradeMaugie",1);
            player:messageSpecial(ID.text.FLYER_ACCEPTED);
            player:tradeComplete();
            elseif (player:getVar("tradeMaugie") ==1) then
                player:messageSpecial(ID.text.FLYER_ALREADY);
            end
        end
    end;

function onTrigger(player,npc)
    local grimySignpost = player:getQuestStatus(SANDORIA,GRIMY_SIGNPOSTS);
    if (grimySignpost == QUEST_AVAILABLE and player:getFameLevel(SANDORIA) >= 2) then
        player:startEvent(45);
    elseif (grimySignpost == QUEST_ACCEPTED) then
        if (player:getVar("CleanSignPost") == 15) then
            player:startEvent(44);
        else
            player:startEvent(43);
        end
    elseif (grimySignpost == QUEST_COMPLETED) then
        player:startEvent(42);
    else
        player:startEvent(46); -- default text
    end
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
    if (csid == 45 and option == 0) then
        player:addQuest(SANDORIA,GRIMY_SIGNPOSTS);
    elseif (csid == 44) then
        player:setVar("CleanSignPost",0);
        player:addFame(SANDORIA,30);
        player:addGil(GIL_RATE*1500);
        player:messageSpecial(ID.text.GIL_OBTAINED,GIL_RATE*1500);
        player:completeQuest(SANDORIA,GRIMY_SIGNPOSTS);
    end
end;
