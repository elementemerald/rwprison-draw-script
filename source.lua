--[[
Block Draw Script
elementemerald#4175
https://www.roblox.com/games/402122991/Redwood-Prison
]]

if shared.bsize == nil then return error("Block size for drawing has not been defined"); end;

local UIS = game:GetService("UserInputService");
local plr = game:GetService("Players").LocalPlayer;
local cam = workspace.CurrentCamera;
local Mouse = game.Players.LocalPlayer:GetMouse();

while wait(2) do
if plr.PlayerGui.GUI.roleChoose ~= nil then
plr.PlayerGui.GUI.roleChoose:Destroy();
end;
end;

-- Get mouse hit position
function getmousep(X, Y)
	local RayMag1 = cam:ScreenPointToRay(X, Y) --Hence the var name, the magnitude of this is 1.
	local NewRay = Ray.new(RayMag1.Origin, RayMag1.Direction * 1000)
	local Target, Position = workspace:FindPartOnRay(NewRay, plr.Character)
	return Position
end

mhits = {};
local hit = false;
local hitpos;
-- store mouse.hit cframes and remove them when table is too big

UIS.InputBegan:connect(function(i)
    local itype = i.UserInputType;
    if itype == Enum.UserInputType.MouseButton1 and isrbxactive() then
        if #mhits >= 200 then
            for k in pairs(mhits) do
                mhits[k] = nil;
            end;
            print("all hits cleared");
        end;
        --[[local pos = getmousep(i.Position.X, i.Position.Y);
        table.insert(mhits, pos);
        print("hit inserted");
        for i,v in pairs(mhits) do
            print(i,v);
        end;]]
	hit = true;
	hitpos = getmousep(i.Position.X, i.Position.Y);
	table.insert(mhits, hitpos);
    end
end);

UIS.InputEnded:connect(function(i)
    local itype = i.UserInputType;
    if itype == Enum.UserInputType.MouseButton1 and isrbxactive() then
	hit = false;
    end
end);

UIS.InputChanged:connect(function(i)
    local itype = i.UserInputType;
    if itype == Enum.UserInputType.MouseMovement and hit and isrbxactive() then
	hitpos = getmousep(i.Position.X, i.Position.Y);
	table.insert(mhits, hitpos);
    end;
end);

-- this might cause lag issues while drawing
local mainDraw = coroutine.wrap(function()
    repeat wait();
    for i,v in pairs(mhits) do
        game:GetService("Workspace").resources.RemoteEvent:FireServer(
            "FireAllClients",
            "drawLaser",
            Vector3.new(55, 1.5, -382),
            Vector3.new(55, 2, -382),
            {
                --["CFrame"] = CFrame.new(55, 0.5, -382, 0, 1, 0, 0, 0, -1, -1, 0, 0),
                ["CFrame"] = CFrame.new(v),
                ["BrickColor"] = BrickColor.new("Bright green"),
                ["CanCollide"] = false,
                ["Parent"] = game:GetService("Workspace"),
                ["Material"] = "Neon",
                ["Shape"] = Enum.PartType.Block,
                ["Size"] = Vector3.new(shared.bsize, shared.bsize, shared.bsize)
            }
        );
    end;
    until not shared.enabled;
end);

mainDraw();

game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
Text = "{System} Loaded elementemerald's Redwood Prison Draw Script."
});
