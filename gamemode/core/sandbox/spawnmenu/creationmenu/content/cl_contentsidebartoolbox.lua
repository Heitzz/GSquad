//=============================================================================//
//========= Citizen Networks, All rights reserved. ============//
//
// Name: cl_contentsidebartoolbox.lua
// Author: DidVaitel
// Created: 2019-11-27 04:54:37
// Modified: 2019-11-27 05:17:11
//
//=============================================================================//
local PANEL = {}

--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetOpenSize( 200 )
	self:DockPadding( 5, 5, 5, 5 )
		
	local panel = vgui.Create( "DPanel", self )
	panel:Dock( TOP )
	panel:SetSize( 24, 24 )
	panel:DockPadding( 2, 2, 2, 2 )
	
	local Button = vgui.Create( "DImageButton", panel )
	Button:SetImage( "icon16/text_heading_1.png" )
	Button:Dock( LEFT )
	Button:SetStretchToFit( false )
	Button:SetSize( 20, 20 )
	local slot = Button:Droppable( "SandboxContentPanel" );

	Button.OnDrop =	function( self, target )

		local label = vgui.Create( "ContentHeader", target )
		return label
		
	end
	
	local panel = vgui.Create( "DPanel", self )
	panel:Dock( FILL )
	panel:DockPadding( 5, 5, 5, 5 )
	
	local label = vgui.Create( "DTextEntry", panel )
	label:Dock( TOP )
	
	local icons = vgui.Create( "DIconBrowser", panel )
	icons:Dock( FILL )
	
	--
	-- If we select a node from the sidebar, update the text/icon/actions in the toolbox (at the bottom)
	--
	hook.Add( "ContentSidebarSelection", "SidebarToolboxSelection", function( pnlContent, node )
		
		if ( !IsValid( node ) || !IsValid( label ) || !IsValid( icons ) ) then return end
		
		label:SetText( node:GetText() )
		icons:SelectIcon( node:GetIcon() )
		icons:ScrollToSelected()
		
		label.OnChange = function()
			node:SetText( label:GetText() )
			hook.Run( "SpawnlistContentChanged" )
		end
		
		icons.OnChange = function()
			node:SetIcon( icons:GetSelectedIcon() )
			hook.Run( "SpawnlistContentChanged" )
		end
	
	end )
	
end

vgui.Register( "ContentSidebarToolbox", PANEL, "DDrawer" )
