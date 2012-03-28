-- Global table in which to store custom mods
CustomMods = {}

-- Reset mods.  This should be called at the start of each game
-- Since tables can only be assigned by reference in Lua, we must explicitly
-- define defaults for each player.
function ResetCustomMods()
	CustomMods[PLAYER_1] = { hidescore = false, hidecombo = false, hidelife = false, showstats = false, showmods = false, normal = true, left = false, right = false, upsidedown = false, solo = false, vibrate = false, spin = false, spinreverse = false, bob = false, pulse = false, wag = false, dark = 0 }
	CustomMods[PLAYER_2] = { hidescore = false, hidecombo = false, hidelife = false, showstats = false, showmods = false, normal = true, left = false, right = false, upsidedown = false, solo = false, vibrate = false, spin = false, spinreverse = false, bob = false, pulse = false, wag = false, dark = 0 }
end

-- Do initial reset
ResetCustomMods()


function OptionTournamentOptions()
	local t = {
		Name = "TournamentOptions",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Hide Score", "Hide Combo", "Hide Lifebar" },
		
		LoadSelections = function(self, list, pn)
			--if GAMESTATE:StageIndex() == 0 then ResetCustomMods() end -- Reset if we're on the first stage
			list[1] = CustomMods[pn].hidescore -- Hide score mod
			list[2] = CustomMods[pn].hidecombo -- Hide combo mod
			list[3] = CustomMods[pn].hidelife  -- Hide life mod
		end,
		
		SaveSelections = function(self, list, pn)
			CustomMods[pn].hidescore = list[1] -- Hide score mod
			CustomMods[pn].hidecombo = list[2] -- Hide combo mod
			CustomMods[pn].hidelife = list[3]  -- Hide life mod
		end
		
	}
	setmetatable(t, t)
	return t
end


function OptionShowStats()
	local t = {
		Name = "IngameStats",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Show Ingame Statistics" },
		
		LoadSelections = function(self, list, pn)
			--if GAMESTATE:StageIndex() == 0 then ResetCustomMods() end -- Reset if we're on the first stage
			list[1] = CustomMods[pn].showstats -- Resets the option to be off  ingame bargraph
		end,
		
		SaveSelections = function(self, list, pn)
			CustomMods[pn].showstats = list[1] -- ingame bargraph
		end
		
	}
	setmetatable(t, t)
	return t
end


function OptionShowModifiers()
	local t = {
		Name = "ShowModifiers",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Show Active Modifiers" },
		
		LoadSelections = function(self, list, pn)
			--if GAMESTATE:StageIndex() == 0 then ResetCustomMods() end -- Reset if we're on the first stage
			list[1] = CustomMods[pn].showmods -- Resets the option to be off  ingame bargraph
		end,
		
		SaveSelections = function(self, list, pn)
			CustomMods[pn].showmods = list[1] -- show active attack list
		end
		
	}
	setmetatable(t, t)
	return t
end


function AvailableArrowDirections()

if GAMESTATE:GetNumPlayersEnabled() == 1 then return "Normal", "Left", "Right", "Upside-Down", "Solo-Centered"
else return "Normal", "Left", "Right", "Upside-Down" end
end

function OptionOrientation()
	local t = {
		Name = "Orientation",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { AvailableArrowDirections() },		
		LoadSelections = function(self, list, pn)
			--if GAMESTATE:StageIndex() == 0 then ResetCustomMods() end -- Reset if we're on the first stage
			list[1] = CustomMods[pn].normal -- Default scrolling
			list[2] = CustomMods[pn].left -- Turns field left
			list[3] = CustomMods[pn].right -- Turns field right
			list[4] = CustomMods[pn].upsidedown  -- Flips field upside down
			if GAMESTATE:GetNumPlayersEnabled() == 1 then list[5] = CustomMods[pn].solo end -- Centers the targets
		end,
		
		SaveSelections = function(self, list, pn)
			CustomMods[pn].normal = list[1] -- Default scrolling
			CustomMods[pn].left = list[2] -- Turns field left
			CustomMods[pn].right = list[3] -- Turns field right
			CustomMods[pn].upsidedown = list[4]  -- Flips field upside down
			if GAMESTATE:GetNumPlayersEnabled() == 1 then CustomMods[pn].solo = list[5] end-- Centers the targets
		end
		
	}
	setmetatable(t, t)
	return t
end


function OptionPlayfield()
	local t = {
		Name = "PlayfieldMods",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Vibrate", "Spin Right", "Spin Left", "Bob", "Pulse", "Wag" },
		
		LoadSelections = function(self, list, pn)
			--if GAMESTATE:StageIndex() == 0 then ResetCustomMods() end -- Reset if we're on the first stage
			list[1] = CustomMods[pn].vibrate -- Makes the plaing field shake
			list[2] = CustomMods[pn].spin -- Makes the playing field spin clockwise
			list[3] = CustomMods[pn].spinreverse -- Makes the playing field spin counter-clockwise
			list[4] = CustomMods[pn].bob -- Makes the playing field bob back and forth
			list[5] = CustomMods[pn].pulse -- Makes the playing field pulse
			list[6] = CustomMods[pn].wag -- Makes the playing field wag left and right
		end,
		
		SaveSelections = function(self, list, pn)
			CustomMods[pn].vibrate = list[1] -- Makes the plaing field shake
			CustomMods[pn].spin = list[2] -- Makes the playing field spin clockwise
			CustomMods[pn].spinreverse = list[3] -- Makes the playing field spin counter-clockwise
			CustomMods[pn].bob = list[4] -- Makes the playing field bob back and forth
			CustomMods[pn].pulse = list[5] -- Makes the playing field pulse
			CustomMods[pn].wag = list[6] -- Makes the playing field wag left and right
		end
		
	}
	setmetatable(t, t)
	return t
end


function OptionsScreenFilter()
	local t = {
		Name = "ScreenFilter",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Disabled", "Dark", "Darker", "Darkest"},
		LoadSelections = function(self, list, pn)
			--if GAMESTATE:StageIndex() == 0 then ResetCustomMods() end -- Reset if we're on the first stage
			if CustomMods[pn].dark == 0 then list[1] = true 
			elseif CustomMods[pn].dark == 0.5 then list[2] = true 
			elseif CustomMods[pn].dark == 0.65 then list[3] = true 
			elseif CustomMods[pn].dark == 0.85 then list[4] = true 
			else list[1] = true end
		end,
		SaveSelections = function(self, list, pn)
				if list [1] then CustomMods[pn].dark = 0 
				elseif list [2] then CustomMods[pn].dark = 0.5 
				elseif list [3] then CustomMods[pn].dark = 0.65
				elseif list [4] then CustomMods[pn].dark = 0.85 
				else CustomMods[pn].dark = 0 end
		end
	}
	setmetatable(t, t)
	return t
end

-- Returns the screen darken mod
function DarkenPercent(pn)
	return CustomMods[pn].dark
end

-- Returns 1 if score is hidden, 0 otherwise; for use in metrics.ini.
function IsScoreHidden(pn)
	local ret = 0
	
	if CustomMods[pn].hidescore == true then ret = 1 end
	return ret
end

-- Returns 1 if life is hidden, 0 otherwise; for use in metrics.ini.
function IsLifeHidden(pn)
	local ret = 0
	
	if CustomMods[pn].hidelife == true then ret = 1 end
	return ret
end

-- We can't use the 'hidden' command on a per-player basis for combo, so
-- instead take advantage of the X combo offset.  See the [Player] section
-- in metrics.ini.
function GetComboXOffset(pn)
	local ret = 0

	-- Offset Combo for 2 Players on a 1 Player Song in Marathon Mode Only --
	-- Necrofantasia -- -- Floating Darkness -- -- Model DD398 -- -- Perfect Cherry Storm -- -- Anger of YuYu -- -- Psy-Kaliber 2097 --
	if (GAMESTATE:IsCourseMode() and (GetCourseTitle() == 'Extra Stage (Movie)' or GetCourseTitle() == 'Extra Stage (Forever)' or GetCourseTitle() == 'Extra Stage (Infinity)' or GetCourseTitle() == 'Extra Stage (Redemption)' or GetCourseTitle() == 'Extra Stage (SRT X)' or GetCourseTitle() == 'Extra Stage (SRT 9)')) then
	if (GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2)) then
	if pn == PLAYER_1 
		then ret = "-SCREEN_WIDTH/4-8"
		else ret = "-SCREEN_WIDTH*2+SCREEN_WIDTH/4+8"
		end end end

	if CustomMods[pn].hidecombo == true then
		ret = "SCREEN_WIDTH*2" -- This is enough to hide it on either side
	end

	return ret
end

function GetJudgeXOffset(pn)
	local ret = 0

	-- Offset Judgements for 2 Players on a 1 Player Song in Marathon Mode Only -- 
	-- Necrofantasia -- -- Floating Darkness -- -- Model DD398 -- -- Perfect Cherry Storm -- -- Anger of YuYu -- -- Psy-Kaliber 2097 --
	if (GAMESTATE:IsCourseMode() and (GetCourseTitle() == 'Extra Stage (Movie)' or GetCourseTitle() == 'Extra Stage (Forever)' or GetCourseTitle() == 'Extra Stage (Infinity)' or GetCourseTitle() == 'Extra Stage (Redemption)' or GetCourseTitle() == 'Extra Stage (SRT X)' or GetCourseTitle() == 'Extra Stage (SRT 9)')) then
	if (GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2)) then
	if pn == PLAYER_1 
		then ret = "-SCREEN_WIDTH/4-8"
		else ret = "-SCREEN_WIDTH*2+SCREEN_WIDTH/4+8"
		end end end

	return ret
end

-- Returns 1 if ingame stats are shown, 0 otherwise
function ShowStats(pn)
	local ret = 0
	if CustomMods[pn].showstats == true then ret = 1 end
	return ret
end

-- Returns 1 if ingame modifiers in courses are shown, 0 otherwise
function ShowCourseModifiers(pn)
	local ret = 1		--return hidden 1 if not shown
	if CustomMods[pn].showmods == true then ret = 0 end
	return ret
end

function ResetBeginnerDisplay()
	if GAMESTATE:GetPlayMode() == PLAY_MODE_REGULAR  then
		if GAMESTATE:IsPlayerEnabled(PLAYER_1) then 
			if GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()==DIFFICULTY_BEGINNER then 
				CustomMods[PLAYER_1] = { hidescore = false, hidecombo = false, hidelife = false, showstats = false, showmods = false, normal = true, left = false, right = false, upsidedown = false, solo = false, vibrate = false, spin = false, spinreverse = false, bob = false, pulse = false, wag = false, dark = 0 } end end
		if GAMESTATE:IsPlayerEnabled(PLAYER_2) then 
			if GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty()==DIFFICULTY_BEGINNER then 
				CustomMods[PLAYER_2] = { hidescore = false, hidecombo = false, hidelife = false, showstats = false, showmods = false, normal = true, left = false, right = false, upsidedown = false, solo = false, vibrate = false, spin = false, spinreverse = false, bob = false, pulse = false, wag = false, dark = 0 } end end
	end
			
end


function BPMDisplayOffsets()

local SoloOffset = 0

	if GAMESTATE:PlayerUsingBothSides() then return "hidden,1" end

	if GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2) and ShowStats(PLAYER_1) == 1 then 
		if CustomMods[PLAYER_1].solo then SoloOffset = 46 end
	return "HorizAlign,Center;x,SCREEN_CENTER_X+SCREEN_WIDTH/4+100;addx,SCREEN_WIDTH/2+" .. SoloOffset .. ";decelerate,1;addx,-SCREEN_WIDTH/2" end
	if GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1) and ShowStats(PLAYER_2) == 1 then
		if CustomMods[PLAYER_2].solo then SoloOffset = 80 end
	return "HorizAlign,Center;x,SCREEN_CENTER_X-SCREEN_WIDTH/4+100;addx,-SCREEN_WIDTH/2-" .. SoloOffset .. ";decelerate,1;addx,SCREEN_WIDTH/2" end
	
	return "hidden,1"
end

function DrawDistances()
	-- Use Full Screen If There is Only 1 Player, and Cut the Render Positions if 1 or Both use Left/Right.
	local rend = "448"
	
	-- Player 1 Active Only
	if GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		if CustomMods[PLAYER_1].left == true or CustomMods[PLAYER_1].right == true then
			if GAMESTATE:PlayerIsUsingModifier(PLAYER_1, 'hallway') then rend = SCREEN_WIDTH+100
			else rend = SCREEN_WIDTH+20 end end end

	-- Player 2 ONLY Conditions
	if GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1) then
		if CustomMods[PLAYER_2].left == true or CustomMods[PLAYER_2].right == true then
			if GAMESTATE:PlayerIsUsingModifier(PLAYER_2, 'hallway') then rend = SCREEN_WIDTH+100
			else rend = SCREEN_WIDTH+20 end end end

	-- Player 1 AND Player 2 Conditions
	if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		if CustomMods[PLAYER_1].left == true or CustomMods[PLAYER_1].right == true or CustomMods[PLAYER_2].left == true or CustomMods[PLAYER_2].right == true then
			rend = SCREEN_WIDTH*0.4 end end

	return rend
end