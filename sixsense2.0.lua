local ui_get, exec, uid_eindex, local_player = ui.get, client.exec, client.userid_to_entindex, entity.get_local_player

local hitsounds = {
    "-",
    "Default",
    "LUA error",
    "Warning",
    "Custom"
}

local hitsound  = ui.new_combobox("Visuals", "Player ESP", "Hit sound", hitsounds)

client.set_event_callback("player_hurt", function(e)
    local hitsound_get = ui_get(hitsound)

    if hitsound_get == "-" then return end
    
    local attacker = e.attacker
    
    if attacker == nil then return end

    local attacker_entindex = uid_eindex(attacker)

    if attacker_entindex == local_player() then
        if hitsound_get == "Default" then
            exec("playvol buttons\\arena_switch_press_02.wav 1")
        elseif hitsound_get == "LUA error" then
            exec("playvol ui\\weapon_cant_buy.wav 1")
        elseif hitsound_get == "Warning" then
            exec("playvol resource\\warning.wav 1")
        elseif hitsound_get == "Custom" then
            exec("playvol *\\bow_ding.wav 1")
        end
    end
end)
