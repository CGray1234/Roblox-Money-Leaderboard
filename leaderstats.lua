local DataStoreService = game:GetService("DataStoreService")

local moneyDataStore = DataStoreService:GetDataStore("moneyDataStore")

game:GetService("Players").PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local cash = Instance.new("IntValue")
	cash.Name = "Money"
	cash.Parent = leaderstats
	
	local data
	local success, erreomessage = pcall(function()
		data = moneyDataStore:GetAsync(player.UserId.."-cash")
	end)
	
	if success then
		cash.Value = data
	else
		print("Data save failed")
		warn(erreomessage)
	end
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
	
	local success, errormessage = pcall(function()
		moneyDataStore:SetAsync(player.UserId.."-cash",player.leaderstats.Money.Value)
	end)
	
	if success then
		print("Player data successfully saved!")
	else
		print("Data save failed")
		warn(errormessage)
	end
	
end)
