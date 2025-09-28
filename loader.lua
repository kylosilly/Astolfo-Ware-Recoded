local script_key = script_key

local game_loaders = {
    [8316902627] = "24195eae48beac5757ce894c3d382c6c",
    [7709344486] = "48a7ec7ffcd054f17bbd1c71eee5451a",
    [7094518649] = "b8560c39bfc9adc5c6d83714c009c265",
    [8353463684] = "f92e09e4994d2ffb274fbcbfbeb2d69c"
}

local game_id_loader = game_loaders[game.GameId]

if (not game_id_loader) then
    setclipboard("https://discord.gg/zrEef4CnTS")
    game:GetService("Players").LocalPlayer:Kick(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. " is not supported! if you want it supported join the discord copied to your clipboard!")
    return
end

loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/"..loaderId))()
