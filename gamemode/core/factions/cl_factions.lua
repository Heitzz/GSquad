//=============================================================================//
//========= Citizen Networks, All rights reserved. ============//
//
// Name: cl_factions.lua
// Author: DidVaitel
// Created: 2019-11-26 19:08:13
// Modified: 2019-11-29 21:13:37
//
//=============================================================================//

net.Receive( "MilitaryRP.JoinFaction", function()

    FactionMenu = vgui.Create( "DPanel", vgui.GetWorldPanel() );
    FactionMenu:SetPaintBackground( false );
    FactionMenu:SetSize( ScrW(), ScrH() );
    FactionMenu:Center();
    FactionMenu:MakePopup();

    FactionMenu.Choose = vgui.Create( "MilitaryRP.FactionMenu", FactionMenu );
    FactionMenu.Choose:Dock( FILL );
    FactionMenu.Choose:InvalidateParent( true );
	
end)

concommand.Add("ka", function()

    FactionMenu = vgui.Create( "DPanel", vgui.GetWorldPanel() );
    FactionMenu:SetPaintBackground( false );
    FactionMenu:SetSize( ScrW(), ScrH() );
    FactionMenu:Center();
    FactionMenu:MakePopup();

    FactionMenu.Choose = vgui.Create( "MilitaryRP.FactionMenu", FactionMenu );
    FactionMenu.Choose:Dock( FILL );
    FactionMenu.Choose:InvalidateParent( true );
end)