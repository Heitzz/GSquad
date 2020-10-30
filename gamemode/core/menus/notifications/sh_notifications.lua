//=============================================================================//
//========= Citizen Networks, All rights reserved. ============//
//
// Name: sh_notifications.lua
// Author: DidVaitel
// Created: 2019-11-27 18:55:42
// Modified: 2019-11-27 22:09:30
//
//=============================================================================//
GM.Terms = {}


function GM:AddTerm( Name, Text )

	self.Terms[Name] = Text

end

function GM:GetTerm( Name, ... )

	Message = self.Terms[Name]

	for k,v in pairs( {...} ) do
		Message = string.gsub( Message, "#", v, 1 )
	end

	return Message

end
