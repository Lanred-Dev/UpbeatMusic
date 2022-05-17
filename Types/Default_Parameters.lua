--!nocheck

local Main_Types = require(script.Parent:WaitForChild("Main"))
type Table = Main_Types.Table

export type Music_Player = {
	music: Table,
	looped: boolean,
	volume: number,
	random_order: boolean,
}

return {
	music = {},
	looped = false,
	volume = 1,
	random_order = false,
}