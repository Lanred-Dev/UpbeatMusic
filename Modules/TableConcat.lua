return function(Table1, Table2)
	local Table = {}
	
	for Index, Value in pairs(Table1) do
		Table[Index] = Value
	end
	
	for Index, Value in pairs(Table2) do
		Table[Index] = Value
	end
	
	return Table
end
