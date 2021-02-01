local inverter = ui.new_hotkey("AA", "Anti-aimbot angles", "Inverter (Legit AA)")

client.set_event_callback("setup_command", function(info)
    if info.in_use == 1 then 
        if info.in_grenade1 == 1 or info.in_grenade2 == 1 or info.in_attack == 1 then return end
        local cam_anglesx, cam_anglesy, cam_anglesr = client.camera_angles()
        local tick_count = globals.tickcount() % 3
        if ui.get(inverter) then
            if tick_count == 1 then
                info.yaw = cam_anglesy + 120
                info.allow_send_packet = false
            elseif tick_count == 2 then
                info.yaw = cam_anglesy - 120
                info.allow_send_packet = false
            else
                info.yaw = cam_anglesy
                info.allow_send_packet = true
            end
        else
            if tick_count == 1 then
                info.yaw = cam_anglesy - 120
                info.allow_send_packet = false
            elseif tick_count == 2 then
                info.yaw = cam_anglesy + 120
                info.allow_send_packet = false
            else
                info.yaw = cam_anglesy
                info.allow_send_packet = true
            end
        end
    end
end)
