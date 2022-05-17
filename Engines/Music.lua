--[[

	Music Item v0.1.0
	- by Lanred
	
]]

--//Services
local Modules = script.Parent.Parent:WaitForChild("Modules")
local Assets = script.Parent.Parent:WaitForChild("Assets")
local Types = script.Parent.Parent:WaitForChild("Types")

--//Types
local Default_Parameters = require(Types:WaitForChild("Default_Parameters"))
local Main_Types = require(Types:WaitForChild("Main"))
type Table = Main_Types.Table
type Music_Player = Default_Parameters.Music_Player

--//Assets
local Music_Asset = Assets:WaitForChild("Music")

--//Code
--Functions
function shuffle(tbl) --https://scriptinghelpers.org/questions/90012/sorting-a-table-fully-random
	for i = #tbl, 2, -1 do
		local j = math.random(i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	return tbl
end

local function Play(Sound_Template: Sound, MusicIDs: Table, Random_Order: boolean)
	local Running = true

	coroutine.wrap(function()
		while Running do
			if Random_Order == true then
				MusicIDs = shuffle(MusicIDs)
			end

			for _, MusicID in pairs(MusicIDs) do
				if typeof(MusicID) ~= "number" then continue end

				if Sound_Template.SoundId ~= "rbxassetid://"..MusicID then
					Sound_Template.SoundId = "rbxassetid://"..MusicID

					if not Sound_Template.IsLoaded then Sound_Template.Loaded:Wait() end
				end

				Sound_Template.TimePosition = 0
				Sound_Template:Play()
				Sound_Template.Ended:Wait()
			end
		end
	end)()

	return function()
		Running = false
	end
end

--Main block
return function(Parameters: Music_Player)
	--[[
	
		Music Settings
	
	]]

	local MusicIDs = Parameters.music
	local Volume = Parameters.volume
	local Looped = Parameters.looped
	local Random_Order = Parameters.random_order

	--[[
	
		Others
	
	]]

	local Music_Player = nil
	local Sound_Template: Sound = Music_Asset:Clone()
	Sound_Template.Volume = Volume
	Sound_Template.Parent = workspace
	Sound_Template.Name = "UpbeatMusic"

	return {
		play = function()
			Music_Player = Play(Sound_Template, MusicIDs, Random_Order)
		end,

		stop = Music_Player,

		volume = function(New_Volume: number)
			Sound_Template.Volume = New_Volume
		end,

		destroy = function()
			if Music_Player ~= nil then Music_Player() end
			Sound_Template:Destroy()
		end,
	}
end
