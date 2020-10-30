//=============================================================================//
//========= Citizen Networks, All rights reserved. ============//
//
// Name: sh_factions.lua
// Author: DidVaitel
// Created: 2019-11-06 23:03:56
// Modified: 2019-11-28 01:59:21
//
//=============================================================================//

GM.Factions = GM.Factions or {}
GM.Factions.Classes = GM.Factions.Classes or {}

function PlayerMeta:GetFaction()

	return self:GetNetVar("Faction")

end

function PlayerMeta:GetRank()

	return self:GetNetVar("Rank")

end

function GM:AddClass( Table )

	self.Factions.Classes[#self.Factions.Classes + 1] = Table
	return #self.Factions.Classes

end

function PlayerMeta:GetClassTable()

	return GAMEMODE.Factions.Classes[self:GetNetVar("Class")][self:GetNetVar("Team")]

end

function PlayerMeta:CanTakeClass( Class )


end

function GM:AddFaction( Table )

	self.Factions[#self.Factions + 1] = Table
	return #self.Factions

end
