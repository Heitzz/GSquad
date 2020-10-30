//=============================================================================//
//========= Citizen Networks, All rights reserved. ============//
//
// Name: cl_factionmenu.lua
// Author: DidVaitel
// Created: 2019-11-28 02:29:06
// Modified: 2019-11-29 22:13:14
//
//=============================================================================//

local PANEL = {}
local surface_CreateFont, surface_SetFont, surface_SetDrawColor, surface_SetMaterial, surface_GetTextSize, surface_DrawRect, surface_DrawTexturedRect, surface_DrawPoly, surface_DrawLine = surface.CreateFont, surface.SetFont, surface.SetDrawColor, surface.SetMaterial, surface.GetTextSize, surface.DrawRect, surface.DrawTexturedRect, surface.DrawPoly, surface.DrawLine
local draw_NoTexture, draw_SimpleText = draw.NoTexture, draw.SimpleText
local Blur = Material( "pp/blurscreen" )

function PANEL:Paint( w, h )

    local BackgroundMaterial = Material(GAMEMODE.Config.FactionMenuBackground)

    local BackgroundMaterialWidth, BackgroundMaterialHeight = 1920, 1080

    local Ratio = h / BackgroundMaterialHeight
    BackgroundMaterialWidth  = BackgroundMaterialWidth  * Ratio
    BackgroundMaterialHeight = h

    surface_SetDrawColor( color_black )
    surface_DrawRect( 0, 0, w, h )

    surface_SetDrawColor( color_white )
    surface_SetMaterial( BackgroundMaterial )
    surface_DrawTexturedRect( w * 0.5 - BackgroundMaterialWidth * 0.5, 0, BackgroundMaterialWidth, BackgroundMaterialHeight )

    surface_SetDrawColor( color_white )
    surface_SetMaterial( Blur )

    for i = 1, 3 do

        Blur:SetFloat( '$blur', ( i / 3 ) * ( 6 ) )
        Blur:Recompute()

        render.UpdateScreenEffectTexture()
        surface_DrawTexturedRect( 0, 0, w, h )

    end

end

function PANEL:Close()

	self:AlphaTo( 0, 0.25, 0, function()
	    if ( IsValid( self.Parent ) ) then self.Parent:Remove() end
	end )

end

function PANEL:Init()

    self.FactionLeftImage = Material( GAMEMODE.Factions[1].Flag )
    self.FactionRightImage = Material( GAMEMODE.Factions[2].Flag )

    self.FactionLeftIcon = Material( GAMEMODE.Factions[1].Icon )
    self.FactionRightIcon = Material( GAMEMODE.Factions[2].Icon )

    self.MapIMG = Material( GAMEMODE.Config.MapImage )

    self.Parent = self:GetParent()

	self:SetFocusTopLevel( true )

	self.FactionLeft = vgui.Create( "DPanel", self );
    self.FactionLeft:SetSize( ScreenScale( 180 ), ScreenScale( 290 ) );
    self.FactionLeft:DockMargin( ScreenScale( 35 ), ScreenScale( 35 ), 0, ScreenScale( 35 ) );
    self.FactionLeft:Dock( LEFT )
    self.FactionLeft.Paint = function( self, w, h )

    	draw.Blur( self, 25 )

	    surface_SetDrawColor( Color( 255, 255, 255, 50 ) )
	    surface_SetMaterial( self:GetParent().FactionLeftImage )
	    surface_DrawTexturedRect( 0, 0, w, h )

    	draw.OutlinedBox( 0, 0, w, h, Color(0,0,0,0), color_black, 1)

        //draw.OutlinedBox( ScreenScale( 5 ), ScreenScale( 205 ), w - ScreenScale( 10 ), ScreenScale( 50 ), Color( 0, 0, 0, 0 ), color_black, 1)

    end

   	self.FactionRight = vgui.Create( "DPanel", self );
    self.FactionRight:SetSize( ScreenScale( 180 ), ScreenScale( 290 ) );
    self.FactionRight:DockMargin( 0, ScreenScale( 35 ), ScreenScale( 35 ), ScreenScale( 35 ) );
    self.FactionRight:Dock( RIGHT )
    self.FactionRight.Paint = function( self, w, h )

    	draw.Blur( self, 25 )

	    surface_SetDrawColor( Color( 255, 255, 255, 50 ) )
	    surface_SetMaterial( self:GetParent().FactionRightImage )
	    surface_DrawTexturedRect( 0, 0, w, h )

    	draw.OutlinedBox( 0, 0, w, h, Color(0,0,0,0), color_black, 1)

       // draw.OutlinedBox( ScreenScale( 5 ), ScreenScale( 220 ), w - ScreenScale( 10 ), ScreenScale( 35 ), Color( 0, 0, 0, 0 ), color_black, 1)

    end

 	self.Map = vgui.Create( "DPanel", self );
    self.Map:SetSize( ScreenScale( 20 ), ScreenScale( 200 ) );
    self.Map:DockMargin( ScreenScale( 10 ), ScreenScale( 35 ), ScreenScale( 10 ), ScreenScale( 0 ) );
    self.Map:Dock( TOP )
    self.Map.Paint = function( self, w, h )

    	draw.Blur( self, 25 )

   	    surface_SetDrawColor( Color( 255, 255, 255, 255 ) )
	    surface_SetMaterial( self:GetParent().MapIMG )
	    surface_DrawTexturedRect( ScreenScale( 8 ), ScreenScale( 8 ), w - ScreenScale( 16 ), h - ScreenScale( 16 ) )

    	draw.OutlinedBox( 0, 0, w, h, Color(0,0,0,0), color_black, 1)

    end

 	self.Description = vgui.Create( "DPanel", self );
    self.Description:SetSize( ScreenScale( 20 ), ScreenScale( 80 ) );
    self.Description:DockMargin( ScreenScale( 10 ), ScreenScale( 10 ), ScreenScale( 10 ), ScreenScale( 0 ) );
    self.Description:Dock( TOP )
    self.Description.Paint = function( self, w, h )

    	draw.Blur( self, 25 )
    	draw.OutlinedBox( 0, 0, w, h, Color(0,0,0,0), color_black, 1)

    end

	self.FactionRight.BtnContunue = vgui.Create( 'DButton', self.FactionRight )
	self.FactionRight.BtnContunue:SetText( '' )
	self.FactionRight.BtnContunue:SetPos( ScreenScale( 5 ), ScreenScale( 260 ) )
	self.FactionRight.BtnContunue:SetSize( ScreenScale( 170 ), ScreenScale( 20 ) )
	self.FactionRight.BtnContunue.DoClick = function ( button ) 

		surface.PlaySound('ui/beep-21.mp3') 
		net.Start("MilitaryRP.JoinFaction")
			net.WriteUInt( 2, 2 )
		net.SendToServer()

		self:Close()

	end
	self.FactionRight.BtnContunue.Paint = function( self, w, h )
		
		draw.Box( 0, 0, w, h, color_red )
		draw_SimpleText( string.upper( GAMEMODE:GetTerm( "Continue" ) ), "MilitaryRP.BigBold", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    	draw.OutlinedBox( 0, 0, w, h, Color(0,0,0,0), color_black, 1)

	end

	self.FactionLeft.BtnContunue = vgui.Create( 'DButton', self.FactionLeft )
	self.FactionLeft.BtnContunue:SetText( '' )
	self.FactionLeft.BtnContunue:SetPos( ScreenScale( 5 ), ScreenScale( 260 ) )
	self.FactionLeft.BtnContunue:SetSize( ScreenScale( 170 ), ScreenScale( 20 ) )
	self.FactionLeft.BtnContunue.DoClick = function ( button ) 

		surface.PlaySound('ui/beep-21.mp3') 
		net.Start("MilitaryRP.JoinFaction")
			net.WriteUInt( 1, 2 )
		net.SendToServer()
		self:Close()

	end
	self.FactionLeft.BtnContunue.Paint = function( self, w, h )
		
		draw.Box( 0, 0, w, h, Color( 0, 185, 50 ) )
		draw_SimpleText( string.upper( GAMEMODE:GetTerm( "Continue" ) ), "MilitaryRP.BigBold", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    	draw.OutlinedBox( 0, 0, w, h, Color(0,0,0,0), color_black, 1)

	end

    self.FactionLeft.Description = vgui.Create( "DLabel", self.FactionLeft )
    self.FactionLeft.Description:SetContentAlignment(5)
    self.FactionLeft.Description:Dock( TOP )
    self.FactionLeft.Description:DockMargin( ScreenScale( 6 ), ScreenScale( 205 ), ScreenScale( 10 ), ScreenScale( 0 ) )
    self.FactionLeft.Description:SetWrap( true )
    self.FactionLeft.Description:SetAutoStretchVertical( true )
    self.FactionLeft.Description:SetFont( "MilitaryRP.Small" )
    self.FactionLeft.Description:SetTextColor( color_white )
    self.FactionLeft.Description:SetText( GAMEMODE.Factions[1].Description )

    self.FactionRight.Description = vgui.Create( "DLabel", self.FactionRight )
    self.FactionRight.Description:SetContentAlignment( 5 )
    self.FactionRight.Description:Dock( TOP )
    self.FactionRight.Description:DockMargin( ScreenScale( 6 ), ScreenScale( 220 ), ScreenScale( 10 ), ScreenScale( 0 ) )
    self.FactionRight.Description:SetWrap( true )
    self.FactionRight.Description:SetAutoStretchVertical( true )
    self.FactionRight.Description:SetFont( "MilitaryRP.Small" )
    self.FactionRight.Description:SetTextColor( color_white )
    self.FactionRight.Description:SetText( GAMEMODE.Factions[2].Description )

    self.FactionLeft.Icon = vgui.Create( "DPanel", self.FactionLeft );
    self.FactionLeft.Icon:SetSize( ScreenScale( 48 ), ScreenScale( 48 ) );
    self.FactionLeft.Icon:DockMargin( ScreenScale( 5 ), ScreenScale( 0 ), ScreenScale( 127 ), ScreenScale( 90 ) );
    self.FactionLeft.Icon:Dock( BOTTOM )
    self.FactionLeft.Icon.Paint = function( self, w, h )

        surface_SetDrawColor( color_white )
        surface_SetMaterial( self:GetParent():GetParent().FactionLeftIcon )
        surface_DrawTexturedRect( 0, 0, w, h )

        draw.OutlinedBox( 0, 0, w, h, Color(0,0,0,0), color_black, 1)

        //draw.OutlinedBox( ScreenScale( 5 ), ScreenScale( 205 ), w - ScreenScale( 10 ), ScreenScale( 50 ), Color( 0, 0, 0, 0 ), color_black, 1)

    end

    self.FactionRight.Icon = vgui.Create( "DPanel", self.FactionRight );
    self.FactionRight.Icon:SetSize( ScreenScale( 48 ), ScreenScale( 48 ) );
    self.FactionRight.Icon:DockMargin( ScreenScale( 5 ), ScreenScale( 0 ), ScreenScale( 127 ), ScreenScale( 75 ) );
    self.FactionRight.Icon:Dock( BOTTOM )
    self.FactionRight.Icon.Paint = function( self, w, h )

        surface_SetDrawColor( color_white )
        surface_SetMaterial( self:GetParent():GetParent().FactionRightIcon )
        surface_DrawTexturedRect( 0, 0, w, h )

        draw.OutlinedBox( 0, 0, w, h, Color(0,0,0,0), color_black, 1)

       // draw.OutlinedBox( ScreenScale( 5 ), ScreenScale( 220 ), w - ScreenScale( 10 ), ScreenScale( 35 ), Color( 0, 0, 0, 0 ), color_black, 1)

    end
end

vgui.Register( "MilitaryRP.FactionMenu", PANEL, "Panel" )
