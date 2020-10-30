//=============================================================================//
//========= Citizen Networks, All rights reserved. ============//
//
// Name: sv_notifications.lua
// Author: DidVaitel
// Created: 2019-11-27 19:59:38
// Modified: 2019-11-27 20:08:50
//
//=============================================================================//
util.AddNetworkString( "MilitaryRP.Notify" )

NOTIFY_GENERIC			= 0
NOTIFY_ERROR 			= 1
NOTIFY_RED 				= NOTIFY_ERROR
NOTIFY_GREEN			= 3
NOTIFY_HINT 			= 4

function GM:Notify( Reciver, NotifyType, Message )

	net.Start( "MilitaryRP.Notify" )
		net.WriteString( Message )
		net.WriteUInt( NotifyType, 2 )
	if ( IsEntity(Reciver) ) then
		net.Send(Reciver)
	else
		net.Broadcast()
	end

end