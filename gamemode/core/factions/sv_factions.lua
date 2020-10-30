//=============================================================================//
//========= Citizen Networks, All rights reserved. ============//
//
// Name: sv_factions.lua
// Author: DidVaitel
// Created: 2019-11-27 22:13:13
// Modified: 2019-11-29 21:52:31
//
//=============================================================================//

util.AddNetworkString( "MilitaryRP.JoinFaction" )

function PlayerMeta:GetSpawn()

	return table.Random( GAMEMODE.Factions[self:GetFaction()].SpawnPositions[self:GetRank()] ) or table.Random( GAMEMODE.Factions[self:GetFaction()].SpawnPositions["Default"] )

end

function PlayerMeta:SetFaction( Faction )

	self:SetNetVar( "Faction", Faction )

end

function PlayerMeta:SetRank( Rank )

	self:SetNetVar( "Rank", Rank )

end

function PlayerMeta:SetFactionClass( Class )

	self:SetNetVar( "Class", Class )

end

function PlayerMeta:SetClassTeam( Number )

	self:SetNetVar( "Team", Number )

end

function GM:SetupFaction( Player )

	net.Start( "MilitaryRP.JoinFaction" )
	net.Send( Player )

end

net.Receive( "MilitaryRP.JoinFaction", function( Lenght, Player ) 

	if ( Player:GetFaction() ) then return end
	local Faction = net.ReadUInt( 2 )
	if ( !Faction or Faction > 2 or Faction < 1 ) then return end

	Player:SetFaction( Faction )
	Player:SetRank( "Private" )
	Player:SetFactionClass( US_Army )
	Player:SetClassTeam( 1 )
	Player:Spawn()
	
end )