-- LocalScript
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ParryButtonPress = ReplicatedStorage.Remotes:WaitForChild("ParryButtonPress")

-- Fire to the server
ParryButtonPress:FireServer()
