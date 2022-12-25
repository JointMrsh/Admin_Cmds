local commands = {}

local admins = {
	"Your name";
	"Admin Name";
}

local prefix = "/"

local function findPlayer(name) -- name: String
	
	for _, player in pairs(game.Players:GetPlayers()) do
		if string.lower(player.Name) == name then
			return player -- Returned a player Object
		end
	end

	return nil
	
end

local function isAdmin(player) -- player: Object
	for _, v in pairs(admins) do
		if v == player.Name then
			return true
		end
	end

	return false
end

commands.tp = function(sender, arguments) -- sender: Object / arguments: Table

	print("TP Function fired by "..sender.Name)
	
	for _, playerName in pairs(arguments) do
		print(playerName)
	end
	
	local playerToTeleportName = arguments[1]
	local playerToTeleportToName = arguments[2]
	
	if playerToTeleportName and playerToTeleportToName then
		local plrToTP = findPlayer(playerToTeleportName)
		local plrToTPTo = findPlayer(playerToTeleportToName)

		if plrToTP and plrToTPTo then
			plrToTP.Character.HumanoidRootPart.CFrame = plrToTPTo.Character.HumanoidRootPart.CFrame
			print("Successfully moved!")
		end
	end
	
end

commands.speed = function(sender, arguments) 
	
	print("Speed command fired by "..sender.Name)
	
	local playerToGiveSpeedTo = arguments[1]
	local amountOfSpeedToGive = arguments[2]
	
	if playerToGiveSpeedTo and amountOfSpeedToGive then
		local plr = findPlayer(playerToGiveSpeedTo)
		
		if plr then
			plr.Character.Humanoid.WalkSpeed = tonumber(amountOfSpeedToGive)
			print(playerToGiveSpeedTo.." was given Walkspeed "..amountOfSpeedToGive)
		end
	end
end


game.Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(message,recipient)
		if isAdmin(player) then
			message = string.lower(message)
			
			local splitString = message:split(" ")
			
			local slashCommand = splitString[1] -- "/tp"
			
			local cmd = slashCommand:split(prefix) -- {"/","tp"}
	
			local cmdName = cmd[2]
	
			if commands[cmdName] then
				
				local arguments = {} -- Contain the next split parts of the message 
				
				for i = 2, #splitString, 1 do
					table.insert(arguments,splitString[i])
				end
				
				commands[cmdName](player,arguments) -- Fired our TP function
				
			end

		end
	end)
end)
