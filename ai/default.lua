newAI("TEST", function(self)
	local ty = self.faction == "player_1" and 1 or -1
	return self:move(self.x, self.y+ty)
end)