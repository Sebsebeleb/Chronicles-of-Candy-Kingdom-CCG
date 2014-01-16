require "socket"
module(..., package.seeall)

local connection = nil

function host()
	server = socket.bind("*","7520")
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
	game.log("Connected")
end

function send(data)
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
	local match = string.split(data, "|")
	local command = match[1]
	

	if command == "ENDTURN" then
		game:tick()
	elseif commannd == "USETALENT" then
		local who = tonumber(match[2])
		local talent = match[3]
		local target = match[4] --must have both x and y coordinate
		if target then
			local pos = string.split(target ",")
			target = {x=pos[1],y=pos[2]}
		end

		local actor = __uids[who]

		actor:useTalent(talent, {force_target=target})
	end
end

function end_turn()
	send("ENDTURN")
end