require "socket"
module(..., package.seeall)

local connection = nil

function host(port)
	local port = port or "7520"
	server = socket.bind("*", port)
	connection = server:accept()
	connection:settimeout(0)

	game.log("Recieved connection")
end

function join(host, port)
	host = host or "localhost"
	port = port or 7520
	connection = socket.tcp()
	connection:connect(host, port)
	connection:settimeout(0)
	local tmp = game.player
	game.log("Connected")
	game:switchPlayer()
end

function send(data)
	game.log("Sending: "..data)
	data = tostring(data)
	connection:send(data.."\n")
end

function receive()
	if connection then
		data, err  = connection:receive()
		if err then
			if not err == "timeout" then
				game.log("Sorry, error: "..err)
			end
		else
			if data then
				handle_data(data)
			end
		end
	end
end

function handle_data(data)
	--game.log("Recieved data: "..data)
	local match = string.split(data, "|")
	local command = match[1]
	

	if command == "ENDTURN" then
		game.paused=false
		game.opponent:useEnergy()
		game.log("It is now your turn.")

	elseif command == "USETALENT" then
		local who = tonumber(match[2])
		local talent = match[3]
		local tgt = match[4] --must have both x and y coordinate
		local target = {x=0, y=0}
		if tgt then
			local pos = string.split(tgt, ",")
			target = {x=pos[1], y=pos[2]}
		end


		local actor = __uids[who]
		if not actor then
			game.log("ERROR, NO ACTOR")
		end

		actor:useTalent(talent, nil, nil, nil, target)
	end
end

function end_turn()
	send("ENDTURN")
end