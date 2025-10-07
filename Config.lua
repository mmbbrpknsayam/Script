game.Players.LocalPlayer.Character.Humanoid.JumpPower = 200

local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldindex = gmt.__index

gmt.__index = newcclosure(function(self,spoof)
    if spoof == "JumpPower" then return 50 end
    if spoof == "WalkSpeed" then return 16 end
    return oldindex(self,spoof)
end)
