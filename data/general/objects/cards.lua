local Talents  = require "engine.interface.ActorTalents"

newEntity{
	define_as = "BASE_CARD",
	type="card",
	image = "default.png",
	display="#"
}

newEntity{base = "BASE_CARD",
	define_as = "CARD_SUMMON_JELLYBEAN_CANDY",
	image = "data/gfx/cards/summon_jelly_bean.png",
	talent = Talents.T_SUMMON_JELLYBEAN_CANDY,
}