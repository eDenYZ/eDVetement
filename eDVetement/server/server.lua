ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('</eDen:GetPrice', function(source, cb, Price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= Price then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent("Vetement:Buy")
AddEventHandler("Vetement:Buy", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 75
    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)  
        TriggerClientEvent('esx:showNotification', source,  "Vous avez payez ~g~"..price.."$")
        TriggerClientEvent('Vetement:SaveSkin', source)
    else 
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'argent, il vous manque ~g~"..price-xPlayer.getMoney().."$")
    end
end)


RegisterServerEvent('Vetement:clothe_save')
AddEventHandler('Vetement:clothe_save', function(nom, contenu)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('INSERT INTO user_vetement (identifier, nom, contenu, type) VALUES (@identifier, @nom, @contenu, @type)', {
        ['@identifier'] = xPlayer.identifier,
        ['@nom'] = nom,
        ['@contenu'] = json.encode(contenu),
        ['@type'] = "Vetement"
    }) 
end)


ESX.RegisterServerCallback('Vetement:clothe_load', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tenue = {}
    MySQL.Async.fetchAll('SELECT * FROM user_vetement WHERE (identifier = @identifier and type = @type)', {
        ['@identifier'] = xPlayer.identifier,
        ['@type'] = "Vetement"
    }, function(result)
      for i = 1, #result, 1 do
      table.insert(tenue, {
      	id = result[i].id,
        nom = result[i].nom,
        contenu = result[i].contenu
      })
    end
    cb(tenue)

    end)
end)

RegisterServerEvent('Vetement:clothe_rename')
AddEventHandler('Vetement:clothe_rename', function (nouveaunom, id)
  	if id ~= nil then
  		MySQL.Async.execute(
			'UPDATE user_vetement SET nom = @nomnouveau WHERE id = @id',
			{
				['@nomnouveau'] = nouveaunom,
				['@id'] = id
			}
		)
		TriggerClientEvent('esx:showNotification', source, "La tenue a été renommer, si la modification n'apparaît pas, relancer le menu")
  	else
  		TriggerClientEvent('esx:showNotification', source, "La tenue est introuvable")
  	end

end)

RegisterServerEvent('Vetement:clothe_del_tenue')
AddEventHandler('Vetement:clothe_del_tenue', function (id)
  	if id ~= nil then
  		MySQL.Async.execute(
			'DELETE FROM user_vetement WHERE id = @id',
			{
				['@id'] = id
			}
		)
		TriggerClientEvent('esx:showNotification', source, "Suppresion de la tenue ok!")
  	else
  		TriggerClientEvent('esx:showNotification', source, "La tenue est introuvable")
  	end

end)
