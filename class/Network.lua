require "socket"
module(..., package.seeall)

function host()
	server = socket.bind("*","7520")
	client = server:accept()
	game.log("Recieved connection")
end

function join(host, port)
	connection = socket.tcp()
	connection:connect(host, port)
	game.log("Connected")
end
