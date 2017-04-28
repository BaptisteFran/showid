player_jobs = {}

AddEventHandler("showid:getPlayerJob", function(user, cb)
	if(cb ~= nil)then
		cb(player_jobs[user])
	end
end)


TriggerEvent('es:addCommand', 'id', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords

		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					TriggerEvent("showid:getPlayerJob", user.identifier, function(job)
						local dJob = "None"
						if(job)then
							dJob = job.job .. " ^0(^2" .. job.id .. "^0)"
						end

						if(range < 10.0)then
							TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "^2" .. GetPlayerName(source) .. "'s ID")
							TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "Name: ^2" .. GetPlayerName(source) .. "")
							TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "Job: ^2" .. dJob)
						end

					end)
				end)
			end
		end
	end)
	end)
end)
