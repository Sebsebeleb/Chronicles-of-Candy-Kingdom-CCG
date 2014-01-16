require "engine.class"
local Faction = require "engine.Faction"
require "mod.class.Actor"

module(..., package.seeall, class.inherit(mod.class.Actor))

function _M:init(t, no_default)
	t.display=t.display or '@'
	t.color_r=t.color_r or 230
	t.color_g=t.color_g or 230
	t.color_b=t.color_b or 230

	t.faction = "player_2"

	t.lite = t.lite or 0

	mod.class.Actor.init(self, t, no_default)

	self.descriptor = {}
end

function _M:act()
	-- Do basic actor stuff
	if not mod.class.Actor.act(self) then return end

	-- Compute FOV, if needed
	self:computeFOV(self.sight or 20)

	-- Let the AI think .... beware of Shub !
	-- If AI did nothing, use energy anyway
	if not self.energy.used then self:useEnergy() end
end