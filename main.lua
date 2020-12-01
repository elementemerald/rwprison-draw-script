-- ui lib that i tried working on but broke the script so u couldnt draw

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kiwi-i/wallys-ui-fork/master/lib.lua", true))();
lib.options.underlinecolor = "rainbow";
getgenv().a1 = lib:CreateWindow("RP Draw Script");

local materials = {};
local ptypes = {};

local materialitems = Enum.Material:GetEnumItems();
local pitems = Enum.PartType:GetEnumItems();

for i,v in pairs(materialitems) do
    table.insert(materials, tostring(v));
end;

for i,v in pairs(pitems) do
    table.insert(ptypes, tostring(v));
end;

a1:Section("Main");

local t1 = a1:Toggle("Enabled", {flag="drawEnabled"});

a1:Section("Color");

local s1 = a1:Slider("R", {
    precise = true,
    default = 0,
    min = 0,
    max = 255,
    flag = "RED"
});

local s2 = a1:Slider("G", {
    precise = true,
    default = 0,
    min = 0,
    max = 255,
    flag = "GREEN"
});

local s3 = a1:Slider("B", {
    precise = true,
    default = 0,
    min = 0,
    max = 255,
    flag = "BLUE"
});

a1:Section("Part Properties");

local t2 = a1:Toggle("CanCollide", {flag="collide"});
local dd1 = a1:Dropdown("Material", {
    location = shared,
    flag = "material",
    list = materials
});

local dd2 = a1:Dropdown("Shape", {
    location = shared,
    flag = "shape",
    list = ptypes
});

local s4 = a1:Slider("Size", {
    precise = true,
    default = 0,
    min = 0,
    max = 5000,
    flag = "size"
});

local drawlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/elementemerald/rwprison-draw-script/main/source.lua", true))();

local b1 = a1:Button("Clear", function()
    drawlib.clearallhits();
end);
