//=============================================================================//
//========= Citizen Networks, All rights reserved. ============//
//
// Name: sh_vars.lua
// Author: DidVaitel
// Created: 2019-11-27 21:12:30
// Modified: 2019-11-28 01:34:03
//
//=============================================================================//

nw.Register( "Name" )
	:Write( net.WriteString )
	:Read( net.ReadString )
	:SetPlayer()

nw.Register( "Rank" )
	:Write( net.WriteString )
	:Read( net.ReadString )
	:SetLocalPlayer()

nw.Register( "Faction" )
	:Write( net.WriteUInt, 6 )
	:Read( net.ReadUInt, 6 )
	:SetLocalPlayer()

nw.Register( "Class" )
	:Write( net.WriteUInt, 10 )
	:Read( net.ReadUInt, 10 )
	:SetLocalPlayer()

nw.Register( "Team" )
	:Write( net.WriteUInt, 10 )
	:Read( net.ReadUInt, 10 )
	:SetLocalPlayer()