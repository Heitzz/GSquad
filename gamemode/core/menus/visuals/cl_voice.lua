//=============================================================================//
//========= Citizen Networks, All rights reserved. ============//
//
// Name: cl_voice.lua
// Author: DidVaitel
// Created: 2019-11-26 23:43:38
// Modified: 2019-11-27 20:14:09
//
//=============================================================================//

-- Inspired by IJWTB
local math 				= math
local table 			= table
local draw 				= draw
local team 				= team
local IsValid 			= IsValid
local CurTime 			= CurTime

local PANEL 			= {}
local PlayerVoicePanels = {}

local color_white 		= Color(255,255,255)
local color_bg 			= Color(0,0,0)
local color_outline 	= Color(20,20,20)
local color_vis_outline	= Color(200,200,200)
local color_vis_bg 		= Color(40,40,40)
local SoundMat          = Material( "vgui/speaker.png" )

function PANEL:Init()
	self.LabelName = vgui.Create('DLabel', self)
	self.LabelName:SetFont('Default')
	self.LabelName:Dock(FILL)
	self.LabelName:DockMargin(8, 0, 0, 0)
	self.LabelName:SetTextColor(color_white)

	self.Avatar = vgui.Create('AvatarImage', self)
	self.Avatar:Dock(LEFT)
	self.Avatar:SetSize(40, 40)

	self.Color = color_white
	self.LastThink = CurTime()

	self:SetSize(300, 45)
	self:DockPadding(4, 4, 4, 4)
	self:DockMargin(2, 2, 2, 2)
	self:Dock(BOTTOM)
end

function PANEL:Setup(pl)
	self.pl = pl
	self.LabelName:SetText(pl:Nick())
	self.Avatar:SetPlayer(pl)
	
	self.Color = color_white

	self:InvalidateLayout()
end


function PANEL:Paint(w, h)
	if not IsValid(self.pl) then return end
	
	local pl 		= self.pl
	local volume   	= pl:VoiceVolume()

	pl.VoiceBars 	= pl.VoiceBars or {}

	self.Color 		 = color_white

	if (pl.VoiceBars[40] ~= nil) and (self.LastThink < CurTime() - 0.033) then
		table.remove(pl.VoiceBars, 1)
		pl.VoiceBars[40] = (((volume == 0) and (pl == LocalPlayer())) and math.Rand(0, 1) or math.Clamp(volume, 0.05, 1))
		self.LastThink = CurTime()
	end

	draw.Outline(0, 0, w, h, color_outline)
	draw.Outline(1, 1, w - 2, h - 2, self.Color, 3)

	draw.Box(3, 3, w - 6, h - 6, color_bg)
	
	//draw.OutlinedBox(w - 86, 6, 80, h - 12, color_vis_bg, color_vis_outline)

	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( SoundMat )
	surface.DrawTexturedRect( w - 50, ScreenScale(-0.5), 48, 48 )
	//for i = 1, 40 do
	//	if (pl.VoiceBars[i] == nil) then
	//		pl.VoiceBars[i] = (((volume == 0) and (pl == LocalPlayer())) and math.Rand(0, 0.8) or math.Clamp(volume, 0.025, 1))
	//	end
	//	local barH = pl.VoiceBars[i] * 26
	//	draw.Box((w - 74) + (2 * (i - 1)) - 12, (h - barH) * .5, 1, barH, color_white)
	//end
end

function PANEL:Think()
	if IsValid(self.pl) then
		self.LabelName:SetText(self.pl:Name())
	end
	if self.fadeAnim then
		self.fadeAnim:Run()
	end
end

function PANEL:FadeOut(anim, delta, data)
	if anim.Finished then
		if IsValid(PlayerVoicePanels[self.pl]) then
			PlayerVoicePanels[self.pl]:Remove()
			PlayerVoicePanels[self.pl] = nil
			return 
		end
		return 
	end
	self:SetAlpha(255 - (255 * delta))
end

derma.DefineControl('VoiceNotify', '', PANEL, 'DPanel')

function GM:PlayerStartVoice( Player )

	if not IsValid(g_VoicePanelList) then return end

	self:PlayerEndVoice( Player )

	if IsValid(PlayerVoicePanels[Player]) then
		if PlayerVoicePanels[Player].fadeAnim then
			PlayerVoicePanels[Player].fadeAnim:Stop()
			PlayerVoicePanels[Player].fadeAnim = nil
		end
		PlayerVoicePanels[Player]:SetAlpha(255)
		return
	end

	if ( !IsValid( Player ) ) then return end

	local pnl = g_VoicePanelList:Add('VoiceNotify')
	pnl:Setup( Player )

	PlayerVoicePanels[Player] = pnl

end

function GM:PlayerEndVoice( Player )

	if IsValid(PlayerVoicePanels[Player]) then
		if (PlayerVoicePanels[Player].fadeAnim) then return end

		PlayerVoicePanels[Player].fadeAnim = Derma_Anim('FadeOut', PlayerVoicePanels[Player], PlayerVoicePanels[Player].FadeOut)
		PlayerVoicePanels[Player].fadeAnim:Start(1)
	end
	
end

timer.Create('VoiceClean', 10, 0, function()
	for k, v in pairs(PlayerVoicePanels) do
		if not IsValid(k) then
			GM:PlayerEndVoice(k)
		end
	end
end)

timer.Simple(0, function()
	if IsValid(g_VoicePanelList) then g_VoicePanelList:Remove() end
	g_VoicePanelList = vgui.Create('DPanel')
	g_VoicePanelList:ParentToHUD()
	g_VoicePanelList:SetPos(ScrW() * 0.02, ScrH() * 0.13)
	g_VoicePanelList:SetSize(ScrW() * 0.2, ScrH() * 0.85)
	g_VoicePanelList.Paint = function() end
end)
