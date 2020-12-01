--[[
Block Draw Script
elementemerald#4175
https://www.roblox.com/games/402122991/Redwood-Prison
]]

--if shared.bsize == nil then return error("Block size for drawing has not been defined"); end;

local UIS = game:GetService("UserInputService");
local plr = game:GetService("Players").LocalPlayer;
local cam = workspace.CurrentCamera;
local Mouse = game.Players.LocalPlayer:GetMouse();

if type(plr.PlayerGui.GUI.roleChoose) ~= "nil" then plr.PlayerGui.GUI.roleChoose:Destroy(); end;

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
<<<<<<< HEAD

=======
>>>>>>> parent of 2f9918a... Update source.lua
-- store mouse.hit cframes and remove them when table is too big

local function clearallhits()
    for k in pairs(mhits) do
        mhits[k] = nil;
    end;
    print("all hits cleared");	
end;

UIS.InputBegan:connect(function(i)
    local itype = i.UserInputType;
    if itype == Enum.UserInputType.MouseButton1 and isrbxactive() then
        if #mhits >= 200 then
            clearallhits();
        end;
        --[[local pos = getmousep(i.Position.X, i.Position.Y);
        table.insert(mhits, pos);
        print("hit inserted");
        for i,v in pairs(mhits) do
            print(i,v);
        end;]]
	print("mouse down");
	hit = true;
	hitpos = getmousep(i.Position.X, i.Position.Y);
	table.insert(mhits, hitpos);
    elseif itype == Enum.UserInputType.Keyboard and isrbxactive() then
	local ik = i.KeyCode;
	if ik == Enum.KeyCode.BackSlash and isrbxactive() then
	    clearallhits();
	end;
    end;
end);

UIS.InputEnded:connect(function(i)
    local itype = i.UserInputType;
    if itype == Enum.UserInputType.MouseButton1 and isrbxactive() then
	print("mouse up");
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
spawn(function()
while wait(0.1) do
    -- a1 is the ui window
    if a1.flags.drawEnabled then
    for i,v in pairs(mhits) do
        game:GetService("Workspace").resources.RemoteEvent:FireServer(
            "FireAllClients",
            "drawLaser",
            Vector3.new(55, 1.5, -382),
            Vector3.new(55, 2, -382),
            {
                --["CFrame"] = CFrame.new(55, 0.5, -382, 0, 1, 0, 0, 0, -1, -1, 0, 0),
                ["CFrame"] = CFrame.new(v),
<<<<<<< HEAD
                --["BrickColor"] = BrickColor.new("Bright green"),
		["BrickColor"] = BrickColor.new(a1.flags.RED, a1.flags.GREEN, a1.flags.BLUE),
                --["CanCollide"] = false,
		["CanCollide"] = a1.flags.collide,
                ["Parent"] = game:GetService("Workspace"),
                ["Material"] = a1.flags.material,
                --["Shape"] = Enum.PartType.Block,
		["Shape"] = a1.flags.shape,
                ["Size"] = Vector3.new(a1.flags.bsize, a1.flags.bsize, a1.flags.bsize)
=======
                ["BrickColor"] = BrickColor.new("Bright green"),
                ["CanCollide"] = false,
                ["Parent"] = game:GetService("Workspace"),
                ["Material"] = "Neon",
                ["Shape"] = Enum.PartType.Block,
                ["Size"] = Vector3.new(shared.bsize, shared.bsize, shared.bsize)
>>>>>>> parent of 2f9918a... Update source.lua
            }
        );
    end;
    end;
end;
end);

game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
Text = "{System} Loaded elementemerald's Redwood Prison Draw Script."
});
