//=============================================================================//
//========= Citizen Networks, All rights reserved. ============//
//
// Name: cl_hud.lua
// Author: DidVaitel
// Created: 2019-11-26 19:19:57
// Modified: 2019-11-28 01:17:50
//
//=============================================================================//
local CompassX, CompassY = ScrW()*0.5, ScrH()*0.95
local CompassWidth, CompasHeight = ScrW()*0.4, ScrH()*0.03
local CompassWidthMath = CompassWidth/2
local CompassColor = color_white
local CompassMultiplayer = 2.5
local CompassRatio = 1.8
local CompassOffset = 180
local CompassSpacing = ( CompassWidth * CompassMultiplayer ) / 360
local CompassLines = CompassWidth / CompassSpacing

local CompassSides = {
	[0] = "N",
	[45] = "NE",
	[90] = "E",
	[135] = "SE",
	[180] = "S",
	[225] = "SW",
	[270] = "W",
	[315] = "NW",
	[360] = "N"
}

local color_white 		= Color(255,255,255)
local color_bg 			= Color(0,0,0)
local color_outline 	= Color(20,20,20)
local color_vis_outline	= Color(200,200,200)
local color_vis_bg 		= Color(40,40,40)

surface.CreateFont( "MilitaryRP.CompassFont_Numbers", {
	font = "Roboto Regular",
	size = ScrH() * 0.018,
	//weight = 300,
	antialias = true
} )

surface.CreateFont( "MilitaryRP.CompassFont_Letters", {
	font = "Roboto Regular",
	size = ScrH() * 0.018,
	//weight = 300,
	antialias = true
} )

local function DrawLine( Mask, Mask2, Line, Colors )

	render.ClearStencil()
	render.SetStencilEnable( true )

		render.SetStencilFailOperation( STENCILOPERATION_KEEP )
		render.SetStencilZFailOperation( STENCILOPERATION_KEEP )
		render.SetStencilPassOperation( STENCILOPERATION_REPLACE)
		render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_ALWAYS )

		render.SetStencilWriteMask( 1 )
		render.SetStencilReferenceValue( 1 )

		surface.SetDrawColor( Color( 0, 0, 0, 1 ) )
		surface.DrawRect( Mask[1], Mask[2], Mask[3], Mask[4] ) -- left
		surface.DrawRect( Mask2[1], Mask2[2], Mask2[3], Mask2[4] ) -- right

		render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
		render.SetStencilTestMask( 1 )

		surface.SetDrawColor( Colors )
		surface.DrawLine( Line[1], Line[2], Line[3], Line[4] )

	render.SetStencilEnable( false )

end

local DisableDefault = {
	CHudHealth 		= true,
	CHudBattery 	= true,
	CHudSuitPower	= true,
}

function GM:HUDShouldDraw( Name )
	
	if DisableDefault[Name] then
		return false
	end

	return true

end

function GM:HUDPaint()
	
	local Angles = LocalPlayer():GetAngles()
	local AnglesRoundY = math.Round( Angles.y )
	local maxMarkerSize, minMarkerSize
	//minMarkerSize, maxMarkerSize = ScrH() * ( compassTBLSelected.minMarkerSize / 45 ), ScrH() * ( compassTBLSelected.maxMarkerSize / 45 )
	local Text = math.Round( 360 - ( Angles.y % 360 ) )
	surface.SetFont( "MilitaryRP.CompassFont_Numbers" )
	local CompassBearingW, CompassBearingH = surface.GetTextSize( Text )

	surface.SetTextColor( CompassColor )
	surface.SetTextPos( CompassX - CompassBearingW/2, CompassY )
	surface.DrawText( Text )

	for i = ( AnglesRoundY - CompassLines/2 ) % 360, ( ( AnglesRoundY - CompassLines/2 ) % 360 ) + CompassLines do

		local x = ( CompassX + ( CompassWidthMath * CompassMultiplayer ) ) - ( ( ( i - Angles.y - CompassOffset ) % 360 ) * CompassSpacing )
		local value = math.abs( x - CompassX )
		local calc = 1 - ( ( value + ( value - CompassWidthMath ) ) / ( CompassWidthMath ) )
		local calculation = 255 * math.Clamp( calc, 0.001, 1 )

		if i % 15 == 0 && i > 0 then

			local Text = CompassSides[360 - (i % 360)] && CompassSides[360 - (i % 360)] || 360 - (i % 360)
			local Font = type( Text ) == "string" && "MilitaryRP.CompassFont_Letters" || "MilitaryRP.CompassFont_Numbers"
			surface.SetFont( Font )
			local w, h = surface.GetTextSize( Text )

			surface.SetDrawColor( Color( CompassColor.r, CompassColor.g, CompassColor.b, calculation ) )
			surface.SetTextColor( Color( CompassColor.r, CompassColor.g, CompassColor.b, calculation ) )

			local mask1 = { CompassX - CompassWidthMath - CompassWidthMath, CompassY, CompassWidthMath + CompassWidthMath - CompassBearingW, CompasHeight * 2 }
			local mask2 = { CompassX, CompassY, CompassWidthMath + CompassWidthMath - CompassBearingW, CompasHeight * 2 }

			local col = Color( CompassColor.r, CompassColor.g, CompassColor.b, calculation )
			local line = { x, CompassY, x, CompassY + CompasHeight * 0.5 }
			DrawLine( mask1, mask2, line, col )
			surface.SetTextPos( x - w/2, CompassY + CompasHeight * 0.55 )
			surface.DrawText( Text )

			local mask1 = { CompassX - CompassWidthMath - CompassWidthMath, CompassY, CompassWidthMath + CompassWidthMath - CompassBearingW, CompasHeight * 2 }
			local mask2 = { CompassX + CompassBearingW, CompassY, CompassWidthMath + CompassWidthMath - CompassBearingW, CompasHeight * 2 }
			local col = Color( CompassColor.r, CompassColor.g, CompassColor.b, calculation )

			local line = { x, CompassY, x, CompassY + CompasHeight * 0.5 }
			DrawLine( mask1, mask2, line, col )

		end

		if i % 5 == 0 && i % 15 != 0 then

			local mask1 = { CompassX - CompassWidthMath - CompassWidthMath, CompassY, CompassWidthMath + CompassWidthMath - CompassBearingW, CompasHeight }
			local mask2 = { CompassX + CompassBearingW, CompassY, CompassWidthMath + CompassWidthMath - CompassBearingW, CompasHeight }
			local col = Color( CompassColor.r, CompassColor.g, CompassColor.b, calculation )

			local line = { x, CompassY, x, CompassY + CompasHeight * 0.35 }
			DrawLine( mask1, mask2, line, col )

		end

	end

	/*for k, v in pairs( cl_mCompass_MarkerTable ) do

		if CurTime() > v[3] || ( v[1] && !IsValid( v[2] ) )  then
			table.remove( cl_mCompass_MarkerTable, k )
			continue
		end

		local spotPos = ( v[1] && v[2]:GetPos() || v[2] )
		local d = ply:GetPos():Distance( spotPos )
		local currentVar = 1 - ( d / ( 300 / 0.01905 ) ) -- Converting 300m to gmod units
		local markerScale = Lerp( currentVar, minMarkerSize, maxMarkerSize  )
		local font = markerScaleFunc( markerScale )

		local yAng = ang.y - ( spotPos - ply:GetPos() ):GetNormalized():Angle().y
		local markerSpot = math.Clamp( ( ( CompassX + ( CompassWidthMath * multiplier ) ) - ( ( ( -yAng - offset ) % 360 ) * spacing ) ), CompassX - CompassWidthMath, CompassX + CompassWidthMath )

		surface.SetMaterial( v[6] )
		surface.SetDrawColor( v[4] )
		surface.DrawTexturedRect( markerSpot - markerScale/2, CompassY - markerScale - markerScale/2, markerScale, markerScale )

		-- Drawing text above markers
		local text = ( v[7] != "" ) && v[7].." - "..custom_compass_GetMetricValue( d ) || custom_compass_GetMetricValue( d )
		local w, h = custom_compass_GetTextSize( font, text )

		surface.SetFont( font )
		surface.SetTextColor( Color( 255, 255, 255 ) )
		surface.SetTextPos( markerSpot - w/2, CompassY - markerScale - markerScale/2 - h )
		surface.DrawText( text )

	end*/

end 

local modify = {
	['$pp_colour_addr'] = 0,
	['$pp_colour_addg'] = 0,
	['$pp_colour_addb'] = 0,
	['$pp_colour_brightness'] = 0,
	['$pp_colour_contrast' ] = 1,
	['$pp_colour_colour'] = 0,
	['$pp_colour_mulr'] = 0.05,
	['$pp_colour_mulg'] = 0.05,
	['$pp_colour_mulb'] = 0.05
}

function GM:RenderScreenspaceEffects()
	if (LocalPlayer():Health() <= 15) then
		DrawColorModify(modify)
	end
end