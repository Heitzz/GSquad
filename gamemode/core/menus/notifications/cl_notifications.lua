//=============================================================================//
//========= Citizen Networks, All rights reserved. ============//
//
// Name: cl_notifications.lua
// Author: DidVaitel
// Created: 2019-11-27 20:06:47
// Modified: 2019-11-27 20:08:46
//
//=============================================================================//

net.Receive( "MilitaryRP.Notify", function()

	notification.AddLegacy( net.ReadString(), net.ReadUInt(2), 4 )

end)

function GM:Notify( Reciver, NotifyType, Message )

	notification.AddLegacy( Message, NotifyType, 4 )

end