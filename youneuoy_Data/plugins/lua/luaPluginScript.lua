require('myconfigs')
require('extras')
-- Fires when the plugin is first loaded at game start or restarted with restartLua()
function onPluginLoad()
    M2TWEOP.unlockGameConsoleCommands();
    -- UNCOMMENT TO ENABLE BELOW SETTINGS
    M2TWEOP.setAncillariesLimit(16);
    M2TWEOP.setMaxBgSize(100) -- 250 on Huge unit size
    M2TWEOP.setReligionsLimit(50)
    M2TWEOP.setBuildingChainLimit(40)
end

--- Called after loading the campaign map
function onCampaignMapLoaded() 
    GAME_DATA = gameDataAll.get()
    CAMPAIGN = GAME_DATA.campaignStruct
    STRAT_MAP = GAME_DATA.stratMap
    BATTLE = GAME_DATA.battleStruct
    UI_MANAGER = GAME_DATA.uiCardManager
end


--- Called every time an image is rendered for display
---@param pDevice LPDIRECT3DDEVICE9
function draw(pDevice)
    if (ImGui.IsKeyPressed(ImGuiKey.GraveAccent))
        and (ImGui.IsKeyDown(ImGuiKey.LeftCtrl))
    then
        M2TWEOP.toggleConsole()
    elseif (ImGui.IsKeyPressed(ImGuiKey.Q))
        and (ImGui.IsKeyDown(ImGuiKey.LeftCtrl))
        and BATTLE.inBattle
    then
        M2TWEOP.toggleUnitsBMapHighlight()
    elseif (ImGui.IsKeyPressed(ImGuiKey.GraveAccent))
        and (ImGui.IsKeyDown(ImGuiKey.LeftAlt))
    then
        M2TWEOP.toggleDeveloperMode()
    elseif (ImGui.IsKeyPressed(ImGuiKey.R))
        and (ImGui.IsKeyDown(ImGuiKey.LeftCtrl))
        and (ImGui.IsKeyDown(ImGuiKey.LeftShift))
    then
        M2TWEOP.restartLua()
    end
end

--- Called before the faction's turn starts.
-- Exports: faction, religion
---@param eventData eventTrigger
function onPreFactionTurnStart(eventData)
    local faction = eventData.faction
    local factionId = faction.factionID

    if faction.name == "slave" then
        autoSortStack()
    end
end
