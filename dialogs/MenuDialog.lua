
require "engine.class"
local Dialog = require "engine.ui.Dialog"
local List = require "engine.ui.List"
local Textbox = require "engine.ui.Textbox"
local Button = require "engine.ui.Button"

module(..., package.seeall, class.inherit(Dialog))

function _M:init()
	Dialog.init(self, "", 1, 1)

	local host_button = Button.new{text="Host", fct=function() self:host() end}
	local join_button = Button.new{text="Join", fct=function() self:join() end}
	self.c_ip = Textbox.new{title="Ip (empty for localhost)", fct=function() end,  text="", chars=20}
	self.c_port = Textbox.new{title="Port", fct=function() end, text="8040", chars=20}

	self:loadUI{
		{left=0, top=0, ui=self.c_ip},
		{left=0, top=self.c_ip.h, ui=self.c_port},
		{left=0, top=self.c_port.h+40, ui=host_button},
		{right=0, top=self.c_port.h+40, ui=join_button},
	}
	self:setupUI(true, true)

	self.key:addCommands{ __TEXTINPUT = function(c) if self.list and self.list.chars[c] then self:use(self.list[self.list.chars[c]]) end end}
end

function host(self)
	local Net = require "mod.class.Network"
	Net.host(self.c_port.text)
	game:unregisterDialog(self)

end

function join(self)
	local Net = require "mod.class.Network"
	Net.join(self.c_ip.text, self.c_port.text)
	game:unregisterDialog(self)

end