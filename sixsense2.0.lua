local websockets = require "gamesense/websockets"

-- sample echo server provided by https://websocket.org/echo.html
local DEFAULT_URL = "wss://echo.websocket.org"
local websocket_connection

local callbacks = {
	open = function(ws)
		print("[WS] connection to ", ws.url, " opened!")

		websocket_connection = ws
	end,
	message = function(ws, data)
		print("[WS] Got message: ", data)
	end,
	close = function(ws, code, reason, was_clean)
		print("[WS] Connection closed: code=", code, " reason=", reason, " was_clean=", was_clean)

		websocket_connection = nil
	end,
	error = function(ws, err)
		print("[WS] Error: ", err)

		websocket_connection = nil
	end
}

client.set_event_callback("console_input", function(text)
	if text:match("^ws_open") then
		if websocket_connection == nil then
			local url = text:match("^ws_open (.+)$") or DEFAULT_URL
			websockets.connect(url, callbacks)

			print("[WS] Connecting to ", url)
		else
			print("[WS] Connection already open.")
		end

		return true
	elseif text:match("^ws_close") then
		if websocket_connection ~= nil then
			websocket_connection:close()

			print("[WS] Closing connection")
		else
			print("[WS] No open WebSocket connection.")
		end

		return true
	elseif text:match("^ws_send") then
		local message = text:match("^ws_send (.*)$")

		print("[WS] Sending message: ", message)
		websocket_connection:send(message)

		return true
	end
end)
