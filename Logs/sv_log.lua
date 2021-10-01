  -- .___________..______        ______   .__   __.  __  ___   ___ 
-- |           ||   _  \      /  __  \  |  \ |  | |  | \  \ /  / 
-- `---|  |----`|  |_)  |    |  |  |  | |   \|  | |  |  \  V  /  
--     |  |     |      /     |  |  |  | |  . `  | |  |   >   <   
--     |  |     |  |\  \----.|  `--'  | |  |\   | |  |  /  .  \  
--     |__|     | _| `._____| \______/  |__| \__| |__| /__/ \__\ 



local Config = {} 
 
-- Send message when Player connects to the server.
AddEventHandler("playerConnecting", function(name, setReason, deferrals)
   local ids = ExtractIdentifiers(source)
   if Config.discordID then if ids.discord ~= "" then _discordID ="\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\n**Discord ID:** N/A" end else _discordID = "" end
   if Config.steamID then if ids.steam ~= "" then _steamID ="\n**Steam ID:** " ..ids.steam.."" else _steamID = "\n**Steam ID:** N/A" end else _steamID = "" end
   if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\n**Steam URL:** N/A" end else _steamID = "" end
   
   TriggerEvent("tronix-log:server:CreateLog", "joinleave", "Joining", "green", "\r **Name: " .. GetPlayerName(source) .."**\n is connecting to the server!..")

end)

-- Send message when Player disconnects from the server
AddEventHandler('playerDropped', function(reason)
   local ids = ExtractIdentifiers(source)
   if Config.discordID then if ids.discord ~= "" then _discordID ="\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\n**Discord ID:** N/A" end else _discordID = "" end
   if Config.steamID then if ids.steam ~= "" then _steamID ="\n**Steam ID:** " ..ids.steam.."" else _steamID = "\n**Steam ID:** N/A" end else _steamID = "" end
   if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\n**Steam URL:** N/A" end else _steamID = "" end
   if Config.playerID then _playerID ="\n**Player ID:** " ..source.."" else _playerID = "" end
   
   TriggerEvent("tronix-log:server:CreateLog", "joinleave", "Leaving", "green", "** ID: ".. source .. "\r Name: " .. GetPlayerName(source) .."**\n has left the server ".. reason .."!..")

end)

function ExtractIdentifiers(src)
   local identifiers = {
       steam = "",
       ip = "",
       discord = "",
       license = "",
       xbl = "",
       live = ""
   }

   for i = 0, GetNumPlayerIdentifiers(src) - 1 do
       local id = GetPlayerIdentifier(src, i)

       if string.find(id, "steam") then
           identifiers.steam = id
       elseif string.find(id, "ip") then
           identifiers.ip = id
       elseif string.find(id, "discord") then
           identifiers.discord = id
       elseif string.find(id, "license") then
           identifiers.license = id
       elseif string.find(id, "xbl") then
           identifiers.xbl = id
       elseif string.find(id, "live") then
           identifiers.live = id
       end
   end

   return identifiers
end
  
  RegisterServerEvent('tronix-log:server:CreateLog')
  AddEventHandler('tronix-log:server:CreateLog', function(name, title, color, message, tagEveryone)
      local tag = tagEveryone ~= nil and tagEveryone or false
      local webHook1 = TronixWebhooks[name] ~= nil and TronixWebhooks[name] or TronixWebhooks["default"]
      local embedData = {
          {
              ["title"] = title,
              ["color"] = TronixColors[color] ~= nil and TronixColors[color] or TronixColors["default"],
              ["footer"] = {
                  ["text"] = os.date("%c"),
              },
              ["description"] = message,
          }
      }
      PerformHttpRequest(webHook1, function(err, text, headers) end, 'POST', json.encode({ username = "©️ - Tronix",embeds = embedData}), { ['Content-Type'] = 'application/json' })
      print(title)
      Citizen.Wait(100)
      if tag then
          PerformHttpRequest(webHook1, function(err, text, headers) end, 'POST', json.encode({ username = "©️ - Tronix", content = "@everyone"}), { ['Content-Type'] = 'application/json' })
      end
  end)
  


  ---------------------------

  -- Example -- 

  --TriggerEvent("tronix-log:server:CreateLog", "webhooknameinhere", "Top Of Message", "Colour", "Message")

TronixWebhooks = {
      ["default"] = "webhook",
      ["joinleave"] = "webhook",
  
  }
  
 TronixColors = {
      ["default"] = 16711680,
      ["blue"] = 25087,
      ["green"] = 762640,
      ["white"] = 16777215,
      ["black"] = 0,
      ["orange"] = 16743168,
      ["lightgreen"] = 65309,
      ["yellow"] = 15335168,
      ["turqois"] = 62207,
      ["pink"] = 16711900,
      ["red"] = 16711680,
  }