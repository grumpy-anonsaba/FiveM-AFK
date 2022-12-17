local function onAFKCommand(source, args)
    TriggerClientEvent('afk', -1, source)
end

-- Register the command
RegisterCommand('afk', onAFKCommand)