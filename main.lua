--made by HTDBarsi#0001

local default = {
    Workspace = '<Item class="Workspace"><Properties></Properties>',
    Players = '<Item class="Players"><Properties></Properties>',
    ReplicatedFirst = '<Item class="ReplicatedFirst"><Properties></Properties>',
    StarterPlayer = '<Item class="StarterPlayer"><Properties></Properties>',
    StarterGui = '<Item class="StarterGui"><Properties></Properties>',
    ReplicatedStorage = '<Item class="ReplicatedStorage"><Properties></Properties>',
    Lighting = '<Item class="Lighting"><Properties></Properties>'
}

local scriptlist = {
    Workspace = {},
    Players = {},
    ReplicatedFirst = {},
    StarterPlayer = {},
    StarterGui = {},
    ReplicatedStorage = {},
    Lighting = {}
};

local main = '\n<roblox xmlns:xmime="http://www.w3.org/2005/05/xmlmime" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.roblox.com/roblox.xsd" version="4">'
local count = 0

function start(name)
    writefile(name..".rbxlx", "")
    for n,_ in next, default do wait()
        spawn(function()
        for i,v in next, game[tostring(n)]:GetDescendants() do
            if v:IsA("LocalScript") or v:IsA("ModuleScript") then
                table.insert(scriptlist[tostring(n)],{v.ClassName,v.Name,'--[['..v:GetFullName().."]]\n"..decompile(v)})
            end
        end
        count += 1
        print(count)
        end)
    end
    repeat wait() until count == 7
    print("got everything")

    for n,m in next, default do
        main = main..m
        for _,v in next, scriptlist[tostring(n)] do
            main = main..' <Item class="'..v[1]..'"><Properties><String name="Name">'..v[2]..'</String><ProtectedString name="Source"><![CDATA['..v[3]..']]></ProtectedString></Properties></Item>'
        end
        main = main.."</Item>"
    end
    main = main.."\n</roblox>"
    writefile(name..".rbxlx",main)
end
local _,gamename = pcall(game:GetService("MarketplaceService").GetProductInfo, game:GetService("MarketplaceService"), game.PlaceId)
start(gamename.Name)
print("saved successfully")