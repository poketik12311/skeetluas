local script = {
    check = ui.new_checkbox("visuals", "player esp", "Hit marker sound"),
    chs = ui.new_textbox("visuals", "player esp", "custom hitsound"),
    hs = ui.reference("visuals", "player esp", "hit marker sound"),
    vol = ui.new_slider("visuals", "player esp", "\n", 1, 10, 10, true, "", 0.1),
    check_def = ui.new_checkbox("visuals", "player esp", "Use default sound")
}
ui.set_visible(script.hs, false)

local function menu()
    ui.set_visible(script.chs, ui.get(script.check))
    ui.set_visible(script.check_def, ui.get(script.check))
    ui.set_visible(script.vol, ui.get(script.check))
end

ui.set_callback(script.check, menu)
menu()

client.set_event_callback("player_hurt", function(e)
    local attacker = client.userid_to_entindex(e.attacker)
    local lp = entity.get_local_player()
    local volume = ui.get(script.vol)/10
	
    if ui.get(script.check) then
        if ui.get(script.chs) ~= "" then
		    if attacker == lp then
                client.exec("playvol */", ui.get(script.chs), " ", volume)
                ui.set(script.hs, ui.get(script.check_def))
            end
        else
            ui.set(script.hs, true)
        end
    else
        ui.set(script.hs, false)
	end
end)

client.set_event_callback("shutdown", function()
    ui.set_visible(script.hs, true)
end)
