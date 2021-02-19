--[[
Block Draw Script
elementemerald#4175
https://www.roblox.com/games/402122991/Redwood-Prison
]]

local UIS = game:GetService("UserInputService");
local plr = game:GetService("Players").LocalPlayer;
local cam = workspace.CurrentCamera;
local Mouse = game.Players.LocalPlayer:GetMouse();
function getmousep(X, Y)
	local RayMag1 = cam:ScreenPointToRay(X, Y) --Hence the var name, the magnitude of this is 1.
	local NewRay = Ray.new(RayMag1.Origin, RayMag1.Direction * 1000)
	local Target, Position = workspace:FindPartOnRay(NewRay, plr.Character)
	return Position
end

mhits = {};
local hit = false;
local hitpos;
local fireconfig = {};

local clientParts = Instance.new("Folder");
clientParts.Name = "ClientPartsDraw";
clientParts.Parent = workspace;

for i,v in pairs(shared.drawconfig) do
fireconfig[i] = v;
end;

local function clearallhits()
    for k in pairs(mhits) do
        mhits[k] = nil;
    end;
    for i,v in pairs(clientParts:GetChildren()) do
    	if v:IsA("Part") then
    	    v:Destroy();
	end;
    end;
    print("all hits cleared");	
end;

UIS.InputBegan:connect(function(i)
    local itype = i.UserInputType;
    if itype == Enum.UserInputType.MouseButton1 and isrbxactive() then
        if #mhits >= 75 then
            clearallhits();
        end;
	print("mouse down");
	hit = true;
	hitpos = getmousep(i.Position.X, i.Position.Y);
	table.insert(mhits, hitpos);
	
	local repPart = Instance.new("Part");
	repPart.CFrame = CFrame.new(hitpos);
	repPart.BrickColor = fireconfig.color;
	repPart.CanCollide = fireconfig.collide;
	repPart.Material = Enum.Material.Neon;
	repPart.Shape = fireconfig.shape;
	repPart.Size = Vector3.new(shared.bsize.x, shared.bsize.y, shared.bsize.z);
	repPart.Anchored = true;
	repPart.Parent = clientParts;
	
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
	local repPart = Instance.new("Part");
	repPart.CFrame = CFrame.new(hitpos);
	repPart.BrickColor = fireconfig.color;
	repPart.CanCollide = fireconfig.collide;
	repPart.Material = Enum.Material.Neon;
	repPart.Shape = fireconfig.shape;
	repPart.Size = Vector3.new(shared.bsize.x, shared.bsize.y, shared.bsize.z);
	repPart.Anchored = true;
	repPart.Parent = clientParts;
    end;
end);

coroutine.wrap(function()
    repeat wait();
    for i,v in pairs(mhits) do
        game:GetService("Workspace").resources.RemoteEvent:FireServer(
            "FireOtherClients",
            "drawLaser",
            Vector3.new(55, 1.5, -382),
            Vector3.new(55, 2, -382),
            {
                ["CFrame"] = CFrame.new(v),
		["BrickColor"] = fireconfig.color,
		["CanCollide"] = fireconfig.collide,
                ["Parent"] = game:GetService("Workspace"),
                ["Material"] = "Neon",
		["Shape"] = fireconfig.shape,
                ["Size"] = Vector3.new(shared.bsize.x, shared.bsize.y, shared.bsize.z)
            }
        );
    end;
    until not shared.enabled;
end)();

game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
Text = "{System} Loaded elementemerald's Redwood Prison Draw Script."
});
