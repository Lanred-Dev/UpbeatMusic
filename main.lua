--[[

	Upbeat Generator v0.1.0
	- by Lanred
	
	////
	
	Setup process:
	1. Put in path of choice ( example: "ReplicatedStorage" or "ServerStorage" )
	2. Create a "Script"
	3. Require the module ( example: require(path.to.module.UpbeatGenerator) )
	4. Call the engine 

]]

--//Services
local Engines = script:WaitForChild("Engines")
local Modules = script:WaitForChild("Modules")
local Types = script:WaitForChild("Types")
local deepcopy = require(Modules:WaitForChild("deepcopy"))
local Music_Engine = require(Engines:WaitForChild("Music"))

--//Types
local Default_Parameters = require(Types:WaitForChild("Default_Parameters"))
local Main_Types = require(Types:WaitForChild("Main"))
type Table = Main_Types.Table
type Music_Player = Default_Parameters.Music_Player

--//Code
--Functions
function Combine_New_Level_Table(Top_Level_Table, New_Level_Table)
	for Index, Value in pairs(New_Level_Table) do
		if typeof(Top_Level_Table[Index])  == "table" then
			Top_Level_Table[Index] = Combine_New_Level_Table(Top_Level_Table[Index], Value)
		else
			Top_Level_Table[Index] = Value
		end
	end
	
	return Top_Level_Table
end

function Create_Parameters(Default_Parameters: Table, User_Parameters: Table): Table
	local Parameters = deepcopy(Default_Parameters)
	
	for Index, Value in pairs(User_Parameters) do
		if typeof(Parameters[Index]) == "table" then
			Parameters[Index] = Combine_New_Level_Table(Parameters[Index], Value)
		else
			Parameters[Index] = Value
		end
	end
		
	return Parameters
end

--Main block
local UpbeatGenerator = {}

return function(Parameters: Music_Player): Table
	if typeof(Parameters) ~= "table" then Parameters = Default_Parameters end

	local Engine_Object: Table = Music_Engine(Parameters)
	
	return {
		play = Engine_Object.play,
		stop = Engine_Object.stop,
		volume = Engine_Object.volume,
		destroy = Engine_Object.destroy,
	}
end

