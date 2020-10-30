//=============================================================================//
//========= Citizen Networks, All rights reserved. ============//
//
// Name: sh_factions.lua
// Author: DidVaitel
// Created: 06.11.2019
// Modified: 2019-11-29 21:57:53
//
//=============================================================================//


FACTION_US = GM:AddFaction(
	{FactionName = 'US', PrintName = 'US Army', Flag = 'vgui/usa.png', Icon = "vgui/usa-ico.png", 
	Description = [[
	The United States Army is the land branch of the US Armed Forces.
	It is one of the largest military organisations in the world, responsible for the US Military's land based efforts. The US Army has gained much experience as a result of their extensive participation in warfare, they are also one of the most technologically advanced armies in the world.
	]],
	Ranks = {
		["Private"] = {
			PrintName = "Private",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		US_Specialist = {
			PrintName = "Specialist",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		US_Corporal = {
			PrintName = "Corporal",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		US_Sergeant = {
			PrintName = "Sergeant",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		US_Staff_Sergeant = {
			PrintName = "Staff Sergeant",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		US_Sergeant_First_Class = {
			PrintName = "Sergeant First Class",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		US_Master_Sergeant = {
			PrintName = "Master Sergeant",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		US_First_Sergeant = {
			PrintName = "First Sergeant",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		US_Sergeant_Major = {
			PrintName = "Sergeant Major",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		US_Command_Sergeant_Major = {
			PrintName = "Command Sergeant Major",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		US_SecondLieutenant = {
			PrintName = "2nd Lieutenant",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		US_FirstLieutenant = {
			PrintName = "1st Lieutenant",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		US_Captain = {
			PrintName = "Captain",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		US_Major = {
			PrintName = "Major",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		US_Colonel = {
			PrintName = "Colonel",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		}
	}, 
	Categories = {
		["High Command"] = {
			Classes = US_High_Command_Class
		},
		US_Base_Operators = {
			PrintName = "Squad Leader",
		},
		["Army"] = {
			Classes = US_Army
		},
		US_Navy = {
			PrintName = "Combat Engineer",
		},
		US_AFSOC = {
			PrintName = "Medic",
		},
		US_Military_Police = {
			PrintName = "Grenadier",
		},
		US_Marksman = {
			PrintName = "Marksman",
		},
		US_Machine_Gunner = {
			PrintName = "Machine Gunner",
		}
	},
	SpawnPositions = {
		["Default"] = {
			[1] = Vector(-9081.005859, 11827.147461, -743.968750)
		},
		["Private"] = {
			[1] = Vector(-9081.005859, 11827.147461, -743.968750)
		}
	}
})

FACTION_RU = GM:AddFaction(
	{FactionName = 'RU', PrintName = 'Russian Army', Flag = 'vgui/russia.png', Icon = "vgui/rus-ico.png",
	Description = [[
	The land component of the Russian military. 
	Formed after the fall of the Soviet Union from elements of the old Soviet Army, today's Russian army is a highly professional and technologically modern fighting force capable of rapid overseas deployment.
	]],
	Ranks = {
		RU_Private = {
			PrintName = "Private",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		RU_Corporal = {
			PrintName = "Corporal",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		RU_Sergeant = {
			PrintName = "Sergeant",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		RU_Staff_Sergeant = {
			PrintName = "Staff Sergeant",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		RU_Sergeant_First_Class = {
			PrintName = "Sergeant First Class",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		RU_Warrant_Officer = {
			PrintName = "Warrant Officer",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		RU_SecondLieutenant = {
			PrintName = "2nd Lieutenant",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		RU_FirstLieutenant = {
			PrintName = "1st Lieutenant",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		RU_Captain = {
			PrintName = "Captain",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		RU_Major = {
			PrintName = "Major",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		RU_Lieutenant_Colonel = {
			PrintName = "Lieutenant Colonel",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		},
		RU_Colonel = {
			PrintName = "Colonel",
			Color = Color( 255, 255, 255 ),
			Loyalty = 1
		}
	}, 
	Categories = {
		RU_High_Command = {
			PrintName = "Colonel",
		},
		RU_Base_Operators = {
			PrintName = "Squad Leader",
		},
		RU_Army = {
			PrintName = "Rifleman",
		},
		RU_Navy = {
			PrintName = "Combat Engineer",
		},
		RU_AFSOC = {
			PrintName = "Medic",
		},
		RU_Military_Police = {
			PrintName = "Grenadier",
		},
		RU_Marksman = {
			PrintName = "Marksman",
		},
		RU_Machine_Gunner = {
			PrintName = "Machine Gunner",
		}
	}
})

