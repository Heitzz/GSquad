//=============================================================================//
//========= Citizen Networks, All rights reserved. ============//
//
// Name: sv_player.lua
// Author: DidVaitel
// Created: 09.11.2019
// Modified: 2019-11-29 16:02:20
//
//=============================================================================//


--[[-------------------------------------------------------------------------
	Standard Sandbox hooks
---------------------------------------------------------------------------]]

function GM:CanPlayerSuicide( Player )

	self:Notify( Player, NOTIFY_ERROR, self:GetTerm("CanSuicide") )
	return false 

end

function GM:PlayerSpawnProp( Player, Model )

	if self.Config.DisableProps or Player:IsFrozen() then return false end

	Model = string.gsub( tostring( Model ), "\\", "/" )
	Model = string.gsub( tostring( Model ), "//", "/" )
	
	return Player:CheckLimit('props') and self.Config.EnablePropsWhitelist and table.HasValue( self.Config.PropsWhitelist, Model )

end

function GM:DoPlayerDeath( Player, Attacker, DamageInfomation)

	Player:CreateRagdoll()

end

function GM:PlayerSetModel( Player )

	Player:SetModel("models/player/Group03/female_01.mdl")
	Player:SetupHands()

end

--[[-------------------------------------------------------------------------
	RP Hooks
---------------------------------------------------------------------------]]

function GM:PlayerAuthed( Player )

	//local Data = SQLModule.Row( "SELECT * FROM militaryrp_playerdata WHERE SteamID=" .. Player:SteamID64() .. ";" )

	//PrintTable( Data )
	nw.WaitForPlayer( Player, function()

		///Player:SetFaction( 1 )
		//Player:SetRank( "Private" )
		////Player:SetFactionClass( US_Army )
		//Player:SetClassTeam(1)
		self:SetupFaction( Player )

		Player:Spawn()

	end)

end

function GM:PlayerInitialSpawn(ply)


end

function GM:PlayerSpawn( Player )

	if ( !Player:GetFaction() ) then return end

	player_manager.SetPlayerClass( Player, 'rp_player' )

	Player:SetNoCollideWithTeammates( false )
	Player:UnSpectate()
	Player:SetHealth( 100 )
	Player:SetJumpPower( 200 )
	
	GAMEMODE:SetPlayerSpeed( Player, self.Config.WalkSpeed, self.Config.RunSpeed )

	Player:Extinguish()
	if IsValid( Player:GetActiveWeapon() ) then
		Player:GetActiveWeapon():Extinguish()
	end

	Player:GetTable().StartHealth = Player:Health()

	gamemode.Call( "PlayerSetModel", Player )
	gamemode.Call( "PlayerLoadout", Player )

	//local _, pos = self:PlayerSelectSpawn(ply) -- позиция
	Player:SetPos( Player:GetSpawn() ) 

	local view1, view2 = Player:GetViewModel(1), Player:GetViewModel(2)
	if IsValid(view1) then
		view1:Remove()
	end
	if IsValid(view2) then
		view2:Remove()
	end

	Player:AllowFlashlight(true)

end

function GM:PlayerLoadout( Player )

	player_manager.RunClass( Player, "Spawn" )

	for k, v in ipairs(Player:GetClassTable().Weapons) do
		Player:Give(v)
	end

	//Player:SelectWeapon(table.Random())

	Player.Weapons = Player:GetWeapons()
end
