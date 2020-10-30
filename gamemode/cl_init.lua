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
// Name: cl_init.lua (CLIENT)
// Author: DidVaitel
// Created: 06.11.2019
// Modified: 06.11.2019
//
//=============================================================================//

include('shared.lua')

function GM:InitPostEntity()

	LocalPlayer():ConCommand( "stopsound; cl_updaterate 16; cl_cmdrate 16;" )

end

local GUIToggled = false
local MouseX, MouseY = ScrW() / 2, ScrH() / 2

function GM:ShowSpare1()

	GUIToggled = !GUIToggled

	if GUIToggled then
		gui.SetMousePos( MouseX, MouseY )
	else
		MouseX, MouseY = gui.MousePos()
	end

	gui.EnableScreenClicker(GUIToggled)

end
