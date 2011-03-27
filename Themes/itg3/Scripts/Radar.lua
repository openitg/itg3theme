--[[
Radar Values for In The Groove 3, v0.5
Licensed under Creative Commons Attribution-Share Alike 3.0 Unported
(http://creativecommons.org/licenses/by-sa/3.0/)

Written by Mark Cannon ("Vyhd") for ITG3/OpenITG (boxorroxors.net)
All I ask is that you keep this notice intact and don't redistribute in bytecode.
--]]


local Tiers =
{
--	["Song"] =
--	{
		[RADAR_CATEGORY_HOLDS]	= { 25, 50, 100, 150 },
		[RADAR_CATEGORY_JUMPS]	= { 25, 50, 100, 200 },
		[RADAR_CATEGORY_MINES]	= { 25, 50, 90, 140 },
		[RADAR_CATEGORY_HANDS]	= { 15, 30, 40, 50 },
		[RADAR_CATEGORY_ROLLS]	= { 10, 20, 30, 40 }
--	},

--[[
	["Course"] =
	{
		[RADAR_CATEGORY_HOLDS]	= { 50, 100, 100, 150 },
		[RADAR_CATEGORY_JUMPS]	= { 50, 100, 150, 200 },
		[RADAR_CATEGORY_MINES]	= { 25, 50, 90, 140 },
		[RADAR_CATEGORY_HANDS]	= { 15, 30, 40, 50 },
		[RADAR_CATEGORY_ROLLS]	= { 10, 20, 30, 40 }
	}
--]]
}

local Colors =
{
	{0.40, 0.40, 0.40},	-- tier 0 (grey)
	{0.00, 1.00, 0.00},	-- tier 1 (green)
	{1.00, 1.00, 0.00}, 	-- tier 2 (yellow)
	{1.00, 0.55, 0.00},	-- tier 3 (orange)
	{1.00, 0.00, 0.00},	-- tier 4 (red)
	{0.00, 0.75, 1.00},	-- tier 5 (aqua)
}

local function SetColor( actor, table )
	actor:stoptweening() actor:linear(0.12)
	actor:diffusecolor( table[1], table[2], table[3], 1.0 )
end

function BitmapText:SetFromRadarValue( pn, category )
	if not OPENITG or not OPENITG_VERSION then return end

	-- only set if we have steps for this player
	local steps = GAMESTATE:GetCurrentSteps(pn)
	if not steps then return end

	local radar = steps:GetRadarValues()
	local value = radar:GetValue( category )

	-- blank the numbers for Edit charts
	if value < 0 then self:settext('') return end

	self:settext( string.format("%03d", value) )

	-- set tier 0 color if the value is zero or negative
	if value == 0 then SetColor( self, Colors[1] ) return end

	-- Colors is offset by one because it contains tier 0
	for i=1,table.getn(Tiers[category]) do
		if value < Tiers[category][i] then
			SetColor( self, Colors[i+1] )
			return
		end
	end

	-- value is above any tier: set tier 5
	SetColor( self, Colors[6] )
end
