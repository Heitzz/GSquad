//=============================================================================//
//========= PoorPixel Corporation, All rights reserved. ============//
//
// @Author: Daniel Heitz
// @Email: contact@poorpixel.eu
// @Created: 06.11.2019
// @Modified: 15.05.2020
//
//=============================================================================//


//=============================================================================//
//========= Citizen Networks, All rights reserved. ============//
//
// Name: shared.lua
// Author: DidVaitel
// Created: 06.11.2019
// Modified: 2019-11-29 21:15:45
//
//=============================================================================//

GM.Name 	= "Military RP"
GM.Author 	= "Razor 1911"
GM.Email 	= "teamgarry@garrysmod.com"
GM.Website 	= "citizen-networks.eu"

PlayerMeta = FindMetaTable( "Player" )
EntityMeta = FindMetaTable( "Entity" )
VectorMeta = FindMetaTable( "Vector" )

GM.Config = GM.Config or {}

GM.IncludeServerSide = (SERVER) and include or function() end
GM.IncludeClientSide = (SERVER) and AddCSLuaFile or include

GM.IncludeSharedSide = function( File )

	GM.IncludeServerSide( File )
	GM.IncludeClientSide( File )

end

GM.Include = function( File )

	if ( string.find( File, "sv_" ) ) then
		GM.IncludeServerSide( File )
	elseif ( string.find( File, "cl_" ) ) then
		GM.IncludeClientSide( File )
	elseif ( string.find( File, "sh_" ) ) then
		GM.IncludeSharedSide( File )
	end

end

GM.IncludeFolder = function( Folder, Inside )
	local Direction = Folder .. "/"
	local Files, Folders = file.Find( Direction .. "*", "LUA" )

	for _, FileDir in ipairs( Files ) do
		GM.Include( Direction .. FileDir )
	end

	if ( Inside == true ) then
		for _, FileDir in ipairs( Folders ) do
			GM.IncludeFolder( Direction .. FileDir, true )
		end
	end

end


function GM.IncludeModules()

	local Folder = GM.FolderName .."/gamemode/modules/"
	local _, Folders = file.Find( Folder .. "*", "LUA" )

	local Files, _ = file.Find( Folder .. "/*.lua", "LUA" )
	for _, File in ipairs( Files ) do
		GM.Include( Folder .. File )
	end

	for _, InsideFolders in ipairs( Folders ) do

		local Files, _ = file.Find( Folder .. InsideFolders .. "/*.lua", "LUA" )
		for _, File in ipairs( Files ) do
			GM.Include( Folder .. InsideFolders .. "/" .. File )
		end

		GM.IncludeFolder( Folder .. InsideFolders, true )

	end

end

function GM.IncludeCore()

	local UtilsFolder = GM.FolderName .."/gamemode/utils/"
	local _, UtilsFolders = file.Find( UtilsFolder .. "*", "LUA" )

	local Files, _ = file.Find( UtilsFolder .. "/*.lua", "LUA" )
	for _, File in ipairs( Files ) do
		GM.Include( UtilsFolder .. File )
	end

	for _, InsideFolders in ipairs( UtilsFolders ) do

		local Files, _ = file.Find( UtilsFolder .. InsideFolders .. "/*.lua", "LUA" )
		for _, File in ipairs( Files ) do
			GM.Include( UtilsFolder .. InsideFolders .. "/" .. File )
		end

		GM.IncludeFolder( UtilsFolder .. InsideFolders, true )

	end

	local Folder = GM.FolderName .."/gamemode/core/"
	local _, Folders = file.Find( Folder .. "*", "LUA" )

	local Files, _ = file.Find( Folder .. "/*.lua", "LUA" )
	for _, File in ipairs( Files ) do
		GM.Include( Folder .. File )
	end

	for _, InsideFolders in ipairs( Folders ) do

		local Files, _ = file.Find( Folder .. InsideFolders .. "/*.lua", "LUA" )
		for _, File in ipairs( Files ) do
			GM.Include( Folder .. InsideFolders .. "/" .. File )
		end

		GM.IncludeFolder( Folder .. InsideFolders, true )

	end

	local ConfigFolder = GM.FolderName .."/gamemode/config"
	GM.IncludeFolder( ConfigFolder )

end

GM.IncludeCore()
GM.IncludeModules()

local LoadingMessage = {

	[[=============================================================================]],
	[[===================Citizen Networks, All rights reserved.====================]],
	[[=============================================================================]],
	[[========= ######                                   ######  ######  ==========]],
	[[========= #     # #####  #  ####   ####  #    #    #     # #     # ==========]],
	[[========= #     # #    # # #      #    # ##   #    #     # #     # ==========]],
	[[========= ######  #    # #  ####  #    # # #  #    ######  ######  ==========]],
	[[========= #       #####  #      # #    # #  # #    #   #   #       ==========]],
	[[========= #       #   #  # #    # #    # #   ##    #    #  #       ==========]],
	[[========= #       #    # #  ####   ####  #    #    #     # #       ==========]],
	[[=============================================================================]],
	[[===================Created by DidVaitel aka Razor 1911=======================]],
	[[=============================================================================]],
	[[=============================================================================]]

}

for _, v in ipairs(LoadingMessage) do
	MsgC( Color( 255, 255, 255 ), v .. "\n" )
end
