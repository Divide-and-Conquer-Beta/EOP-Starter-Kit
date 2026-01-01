AUTO_SORT_PLAYER = true
function autoSortStack()
    -- Sort all the stacks on the map right before the turn starts
    local factionsNum = CAMPAIGN.numberOfFactions
    for i = 0, factionsNum - 1 do
        local faction = stratmap.game.getFaction(i)
        if faction.isPlayerControlled == 0 then
            for j = 0, faction.stacksNum - 1 do
                local stack = faction:getStack(j)
                if stack then
                    stack:sortStack(sortType.categoryClass, sortType.soldierCount, sortType.experience)
                end
            end
        end
    end
end
