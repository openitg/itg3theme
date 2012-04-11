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
			if GAMESTATE:GetNumPlayersEnabled() == 1 then CustomMods[pn].solo = list[5] end -- Centers the targets
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
			list[4] = CustomMods[pn].bob -- Makes the playing field bob up and down
			list[5] = CustomMods[pn].pulse -- Makes the playing field pulse in and out
			list[6] = CustomMods[pn].wag -- Makes the playing field wag left and right
		end,
		
		SaveSelections = function(self, list, pn)
			CustomMods[pn].vibrate = list[1] -- Makes the plaing field shake
			CustomMods[pn].spin = list[2] -- Makes the playing field spin clockwise
			CustomMods[pn].spinreverse = list[3] -- Makes the playing field spin counter-clockwise
			CustomMods[pn].bob = list[4] -- Makes the playing field bob up and down
			CustomMods[pn].pulse = list[5] -- Makes the playing field pulse in and out
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
		then ret = "-SCREEN_WIDTH/4-16"
		else ret = "SCREEN_WIDTH*2+SCREEN_WIDTH/4+16"
		end end end

	if CustomMods[pn].hidecombo == true then
		ret = "-SCREEN_WIDTH*2" -- This is enough to hide it on either side
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
		then ret = "-SCREEN_WIDTH/4-16"
		else ret = "SCREEN_WIDTH*2+SCREEN_WIDTH/4+16"
		end end end

	return ret
end

function ShowStats(pn)
	local ret = 0
	if CustomMods[pn].showstats == true then ret = 1 end
	return ret
end

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

	-- Player 2 Active Only
	if GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1) then
		if CustomMods[PLAYER_2].left == true or CustomMods[PLAYER_2].right == true then
			if GAMESTATE:PlayerIsUsingModifier(PLAYER_2, 'hallway') then rend = SCREEN_WIDTH+100
			else rend = SCREEN_WIDTH+20 end end end

	-- Player 1 AND Player 2 Active
	if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		if CustomMods[PLAYER_1].left == true or CustomMods[PLAYER_1].right == true or CustomMods[PLAYER_2].left == true or CustomMods[PLAYER_2].right == true then
			rend = SCREEN_WIDTH*0.4 end end

	return rend
end

function CheckCustomMods(pn)
local s = "y,SCREEN_TOP+240;"
	local left = "rotationz,270;"
	local right = "rotationz,90;"
	local upsidedown = "rotationz,180;addy,20;"
	local solo = "x,SCREEN_CENTER_X;"
	local vibrate = "vibrate;effectmagnitude,20,20,20;"
	local spin = "spin;EffectClock,beat;effectmagnitude,0,0,45;"
	local bob = "bob;EffectClock,beat;effectmagnitude,0,-30,0"
	local pulse = "pulse;EffectClock,beat;"
	local wag = "wag;EffectClock,beat;"
	local spinreverse = "spin;EffectClock,beat;effectmagnitude,0,0,-45;"
	local leftsideoffset = "x,SCREEN_LEFT+190+" .. GetLifebarAdjustment() ..";"
	local rightsideoffset = "x,SCREEN_RIGHT-190-" .. GetLifebarAdjustment() ..";"
	local player1centeroffset = "x,SCREEN_CENTER_X-160-".. GetLifebarAdjustment() .. ";"
	local player2centeroffset = "x,SCREEN_CENTER_X+160+" .. GetLifebarAdjustment() ..";"
	local right1poffset = "addx,SCREEN_WIDTH/2;"
	local left1poffset = "addx,-SCREEN_WIDTH/2;"

	if CustomMods[pn].left == true then 
		s = left
			if pn == PLAYER_1 then
				s = s .. leftsideoffset
			else
				s = s .. player2centeroffset
			end		
		if GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1) then
			s = s .. left1poffset end
	elseif CustomMods[pn].right == true then 
		s = right
			if pn == PLAYER_2 then
				s = s .. rightsideoffset
			else
				s = s .. player1centeroffset
			end	
		if GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2) then
			s = s .. right1poffset end
	elseif CustomMods[pn].upsidedown == true then
		s = upsidedown
	elseif CustomMods[pn].solo == true then
		s = solo
	else
		s = s
	end
	
	if CustomMods[pn].spin == true then
		s = s .. spin end
		
	if CustomMods[pn].spinreverse == true then
		s = s .. spinreverse end
	
	if CustomMods[pn].vibrate == true then
		s = s .. vibrate end
		
	if CustomMods[pn].bob == true then
		s = s .. bob end
		
	if CustomMods[pn].pulse == true then
		s = s .. pulse end
		
	if CustomMods[pn].wag == true then
		s = s .. wag end

	return s
end

-- WinDEU Hates You / Loves You, SRT, and My Little Spooty Stuff --

-- [LifeP1OnCommand] --
function GetLifeBarEffectsP1()
	s = 'rotationz,-90;addx,-100;sleep,0.5;decelerate,0.8;addx,100;DrawOrder,-1';
	
	-- Hide Lifebar --
	if IsLifeHidden(PLAYER_1) == 1
		then s = 'hidden,1'; return s end

	-- Only Activate Effects ONLY in Marathon Mode --
	if GAMESTATE:IsCourseMode() then

	-- WinDEU Hates You The Movie --

	-- Watercube --
	if (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Watercube'))
		then s = 'draworder,-1;rotationz,-90;addx,-100;sleep,0.5;decelerate,0.8;addx,100;sleep,65.5;accelerate,2;addy,-500;addx,150;rotationz,-300;sleep,6;linear,7;addy,800;rotationz,0;sleep,36;decelerate,2.5;addy,-125;accelerate,0.5;rotationz,-5;decelerate,0.5;rotationz,-10;accelerate,1;rotationz,0;decelerate,1;rotationz,10;accelerate,1;rotationz,0;decelerate,1;rotationz,-10;accelerate,1;rotationz,0;decelerate,1;rotationz,10';

	-- Secret Area --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Secret Area'))
		then s = 'draworder,-1;rotationz,-90;addx,-100;sleep,0.5;decelerate,0.8;addx,100;sleep,83.8;accelerate,0.65;addy,-500;sleep,0.05;addy,1000;accelerate,0.45;addy,-1000;sleep,0.05;addy,1000;accelerate,0.25;addy,-1000;sleep,0.05;addy,1000;accelerate,0.2;addy,-1000;sleep,0.05;addy,1000;accelerate,0.15;addy,-800';

	-- Little Fragments of Silence --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Little Fragments of Silence'))
		then s = 'diffusealpha,1;draworder,-1;rotationz,-90;addx,-100;sleep,0.5;decelerate,0.8;addx,100;sleep,9.969;linear,0.068;zoomtowidth,0.5;addx,148;linear,0.137;zoomtowidth,1;addx,-148;linear,0.068;zoomtowidth,0.5;addx,148;linear,0.137;zoomtowidth,1;addx,-148;linear,0.068;zoomtowidth,0.5;addx,148;linear,0.137;zoomtowidth,1;addx,-148;linear,0.068;zoomtowidth,0.5;addx,148;linear,0.137;zoomtowidth,1;addx,-148;linear,0.068;zoomtowidth,0.5;addx,148;linear,0.137;zoomtowidth,1;addx,-148;sleep,1.159;linear,0.068;zoomtoheight,0.5;addy,-15;linear,0.137;zoomtoheight,1;addy,15;linear,0.068;zoomtoheight,0.5;addy,-15;linear,0.137;zoomtoheight,1;addy,15;linear,0.068;zoomtoheight,0.5;addy,-15;linear,0.137;zoomtoheight,1;addy,15;linear,0.068;zoomtoheight,0.5;addy,-15;linear,0.137;zoomtoheight,1;addy,15;linear,0.068;zoomtoheight,0.5;addy,-15;linear,0.137;zoomtoheight,1;addy,15;sleep,108.136;accelerate,2.2;zoomtowidth,0.25;addx,222;sleep,0.5;zoomtowidth,1;addx,-222;zoom,0;sleep,32.250;zoom,1';

	-- Necrofantasia --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Necrofantasia'))
		then s = 'rotationz,-90;addx,-100;sleep,61;decelerate,0.8;addx,100;DrawOrder,-1'; 

	-- WinDEU Hates You Forever --

	-- Floating Darkness --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/Floating Darkness'))
		then s = 'draworder,-1;rotationz,-90;addx,-100;sleep,0.5;decelerate,0.8;addx,100';

	-- The Detonator --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/The Detonator'))
		then s = 'draworder,-1;rotationz,-90;addx,-100;sleep,0.5;decelerate,0.8;addx,100;sleep,135.203;linear,5;ZoomToHeight,10;addy,1250';
		
	-- Lawn Wake XI --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/Lawn Wake XI'))
		then s = 'draworder,-1;rotationz,-90;zoomy,0;sleep,2.45;zoomy,1;sleep,54.015;accelerate,1.2;addx,192;addy,-20;zoom,0.35;linear,1.3;addx,130;addy,-65;linear,0.75;addx,-75;addy,-38;linear,1.82;addx,-182;addy,91;linear,2;addx,230;addy,115;linear,0.28;addx,28;addy,-14;linear,2.6;addx,-260;addy,-130;linear,1.24;addx,124;addy,-62;linear,1.36;addx,136;addy,68;linear,2.6;addx,-260;addy,130;linear,0.12;addx,16;addy,8;linear,2.44;addx,244;addy,-122;linear,1.68;addx,-168;addy,-84;linear,0.92;addx,-92;addy,46;linear,2.6;addx,260;addy,130;linear,0.6;addx,-60;addy,30;linear,2;addx,-200;addy,-100;linear,2.1;addx,210;addy,-105;linear,0.5;addx,50;addy,25;linear,2.6;addx,-260;addy,130;linear,1;addx,100;addy,50;linear,1.6;addx,160;addy,-80;linear,2.5;addx,-250;addy,-125;linear,0.1;addx,-10;addy,5;linear,2.6;addx,260;addy,130;linear,1.44;addx,-142;addy,71;linear,1.18;addx,-118;addy,-59;linear,2.6;addx,260;addy,-130;linear,0.36;addx,-36;addy,-18;linear,2.24;addx,-224;addy,112;linear,0.44;addx,44;addy,22;decelerate,1.2;zoom,1;x,SCREEN_CENTER_X-296;y,SCREEN_CENTER_Y+30;sleep,10.8;linear,1.8;ZoomY,0';

	-- My Little Spooty 2 --
	
	-- Catastrophe UVB-76 --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('My Little Spooty 2/Catastrophe UVB-76'))
		then s = 'draworder,-1;rotationz,-90;addx,-100;sleep,48.5;decelerate,0.8;addx,100;sleep,242.0;queuecommand,VibSpooty;sleep,4;decelerate,5.0;zoom,0.0001;rotationz,70;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y';

	-- No Hide Lifebar and No Song Matches. Return the Default Value --
	else return s end

	-- End Marathon Condition --
	end

	-- Return Song Match --
	return s
end


-- [ScoreP1OnCommand] --
function GetScoreEffectsP1()
	s = 'shadowlength,0;addy,-100;' .. DoublesScoreCenterP1() .. 'sleep,0.5;decelerate,0.8;addy,100';
	
	-- Hide Score --
	if IsScoreHidden(PLAYER_1) == 1
		then s = 'hidden,1'; return s end

	-- Only Activate Effects ONLY in Marathon Mode --
	if GAMESTATE:IsCourseMode() then

	-- WinDEU Hates You The Movie --

	-- Watercube --
	if (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Watercube'))
		then s = 'addy,-100;sleep,0.5;decelerate,0.8;addy,100;sleep,66.5;accelerate,1;addy,-300;rotationz,-300;sleep,8;linear,8;addy,900;rotationz,0;sleep,34;decelerate,2.5;addy,-212;accelerate,0.5;rotationz,-5;decelerate,0.5;rotationz,-10;accelerate,1;rotationz,0;decelerate,1;rotationz,10;accelerate,1;rotationz,0;decelerate,1;rotationz,-10;accelerate,1;rotationz,0;decelerate,1;rotationz,10';

	-- Secret Area --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Secret Area'))
		then s = 'addy,-100;sleep,0.5;decelerate,0.8;addy,100;sleep,83.3;accelerate,0.65;addy,-500;sleep,0.05;addy,1000;accelerate,0.45;addy,-1000;sleep,0.05;addy,1000;accelerate,0.25;addy,-1000;sleep,0.05;addy,1000;accelerate,0.2;addy,-1000;sleep,0.05;addy,1000;accelerate,0.15;addy,-800';

	-- Little Fragments of Silence --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Little Fragments of Silence'))
		then s = 'diffusealpha,1;addy,-100;sleep,0.5;decelerate,0.8;addy,100;sleep,9.969;linear,0.068;zoomtowidth,0.5;addx,90;linear,0.137;zoomtowidth,1;addx,-90;linear,0.068;zoomtowidth,0.5;addx,90;linear,0.137;zoomtowidth,1;addx,-90;linear,0.068;zoomtowidth,0.5;addx,90;linear,0.137;zoomtowidth,1;addx,-90;linear,0.068;zoomtowidth,0.5;addx,90;linear,0.137;zoomtowidth,1;addx,-90;linear,0.068;zoomtowidth,0.5;addx,90;linear,0.137;zoomtowidth,1;addx,-90;sleep,1.159;linear,0.068;zoomtoheight,0.5;addy,100;linear,0.137;zoomtoheight,1;addy,-100;linear,0.068;zoomtoheight,0.5;addy,100;linear,0.137;zoomtoheight,1;addy,-100;linear,0.068;zoomtoheight,0.5;addy,100;linear,0.137;zoomtoheight,1;addy,-100;linear,0.068;zoomtoheight,0.5;addy,100;linear,0.137;zoomtoheight,1;addy,-100;linear,0.068;zoomtoheight,0.5;addy,100;linear,0.137;zoomtoheight,1;addy,-100;sleep,108.136;accelerate,2.2;zoomtowidth,0.25;addx,135;sleep,0.5;zoomtowidth,1;addx,-135;zoom,0;sleep,32.250;zoom,1';

	-- Necrofantasia --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Necrofantasia'))
		then s = 'hidden,1';

	-- WinDEU Hates You Forever --

	-- Floating Darkness --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/Floating Darkness'))
		then s = 'hidden,1';

	-- The Detonator --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/The Detonator'))
		then s = 'addy,-100;sleep,0.5;decelerate,0.8;addy,100;sleep,135.203;linear,5;ZoomToHeight,10;addy,100';
		
	-- Lawn Wake XI --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/Lawn Wake XI'))
		then s = 'zoomy,0;sleep,4.85;zoomy,1;sleep,51.615;accelerate,1.2;addx,117;addy,120;zoom,0.35;linear,1.3;addx,130;addy,-65;linear,0.75;addx,-75;addy,-38;linear,1.82;addx,-182;addy,91;linear,2;addx,230;addy,115;linear,0.28;addx,28;addy,-14;linear,2.6;addx,-260;addy,-130;linear,1.24;addx,124;addy,-62;linear,1.36;addx,136;addy,68;linear,2.6;addx,-260;addy,130;linear,0.12;addx,16;addy,8;linear,2.44;addx,244;addy,-122;linear,1.68;addx,-168;addy,-84;linear,0.92;addx,-92;addy,46;linear,2.6;addx,260;addy,130;linear,0.6;addx,-60;addy,30;linear,2;addx,-200;addy,-100;linear,2.1;addx,210;addy,-105;linear,0.5;addx,50;addy,25;linear,2.6;addx,-260;addy,130;linear,1;addx,100;addy,50;linear,1.6;addx,160;addy,-80;linear,2.5;addx,-250;addy,-125;linear,0.1;addx,-10;addy,5;linear,2.6;addx,260;addy,130;linear,1.44;addx,-142;addy,71;linear,1.18;addx,-118;addy,-59;linear,2.6;addx,260;addy,-130;linear,0.36;addx,-36;addy,-18;linear,2.24;addx,-224;addy,112;linear,0.44;addx,44;addy,22;decelerate,1.2;zoom,1;x,SCREEN_CENTER_X-180;y,SCREEN_TOP+56;sleep,10.8;linear,1.8;ZoomX,0';

	-- SRT 8 --

	-- Weave Detonator --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT 8/Weave Detonator'))
		then s = 'hidden,1';

	-- WinDEU Hates You Infinity +1 --

	-- Model DD398 --	
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Infinity +1/Model DD398'))
		then s = 'hidden,1';

	-- Hard Weak Hard Magic --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Infinity +1/Hard Weak Hard Magic'))
		then s = 'hidden,1';

	-- WinDEU Loves You The Redemption --

	-- Perfect Cherry Storm --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Loves You The Redemption/Perfect Cherry Storm'))
		then s = 'hidden,1';

	-- SRT 9 --

	-- Psy-Kaliber 2097 --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT 9/Psy-Kaliber 2097'))
		then s = 'hidden,1';

	-- SRT X --

	-- Anger of YuYu --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT X/Anger of YuYu'))
		then s = 'hidden,1';

	-- The End --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT X/The End'))
		then s = 'shadowlength,0;addy,-100;' .. DoublesScoreCenterP1() .. 'sleep,300;decelerate,0.8;addy,100';

	-- No Hide Lifebar and No Song Matches. Return the Default Value --
	else return s end

	-- End Marathon Condition --
	end
	
	-- Return Song Match
	return s
end


-- [PlayerP1OnCommand] --
function GetPlayerEffectsP1(pn)
	
	-- Check for Any Enabled Custom Mods --
	s = CheckCustomMods(PLAYER_1)

	-- Only Activate Effects ONLY in Marathon Mode --
	if GAMESTATE:IsCourseMode() then

	-- WinDEU Hates You The Musical --

	-- Nuclear Fusion --
	-- See the Entire Playing Field with only 1 Player Active --
	if (GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2)) and (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Musical/Nuclear Fusion'))
		then s = 'sleep,128.19;linear,1;x,SCREEN_CENTER_X;zoomx,0.5;sleep,44;linear,1;zoomx,1';

	-- WinDEU Hates You The Movie --

	-- Printer Jam --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Printer Jam'))
		then s = 'sleep,13.300;linear,0.69;addx,50;linear,0.69;addx,-100;linear,0.69;addx,100;linear,0.69;addx,-100;linear,0.258;addx,100;linear,0.258;addx,-100;linear,0.173;addx,100;linear,0.518;addx,-100;linear,0.862;addx,100;linear,0.69;addx,-100;linear,0.69;addx,100;linear,0.69;addx,-100;linear,0.69;addx,100;linear,0.69;addx,-100;linear,0.258;addx,100;linear,0.258;addx,-100;linear,0.173;addx,100;linear,0.518;addx,-100;linear,0.862;addx,100;linear,0.69;addx,-100;linear,0.69;addx,100;linear,0.69;addx,-100;linear,0.69;addx,100;linear,0.69;addx,-100;linear,0.258;addx,100;linear,0.258;addx,-100;linear,0.173;addx,100;linear,0.518;addx,-100;linear,0.862;addx,100;linear,0.345;addx,-50';

	-- Secret Area--
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Secret Area'))
		then s = 'sleep,55.6;linear,0.2;rotationz,360;sleep,0.143;linear,0.3;rotationz,-360;sleep,1.714;queuecommand,Vibrate1;sleep,0.514;queuecommand,Stop;sleep,7.029;decelerate,0.65;rotationy,1080;sleep,19.357;accelerate,0.65;addy,-500;sleep,0.05;addy,1000;accelerate,0.45;addy,-1000;sleep,0.05;addy,1000;accelerate,0.25;addy,-1000;sleep,0.05;addy,1000;accelerate,0.2;addy,-1000;sleep,0.05;addy,1000;accelerate,0.15;addy,-800';

	-- Little Fragments of Silence --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Little Fragments of Silence'))
		then s = 'sleep,11.269;linear,0.068;zoomtowidth,0.5;addx,80;linear,0.137;zoomtowidth,1;addx,-80;linear,0.068;zoomtowidth,0.5;addx,80;linear,0.137;zoomtowidth,1;addx,-80;linear,0.068;zoomtowidth,0.5;addx,80;linear,0.137;zoomtowidth,1;addx,-80;linear,0.068;zoomtowidth,0.5;addx,80;linear,0.137;zoomtowidth,1;addx,-80;linear,0.068;zoomtowidth,0.5;addx,80;linear,0.137;zoomtowidth,1;addx,-80;sleep,1.159;linear,0.068;zoomtoheight,0.5;linear,0.137;zoomtoheight,1;linear,0.068;zoomtoheight,0.5;linear,0.137;zoomtoheight,1;linear,0.068;zoomtoheight,0.5;linear,0.137;zoomtoheight,1;linear,0.068;zoomtoheight,0.5;linear,0.137;zoomtoheight,1;linear,0.068;zoomtoheight,0.5;linear,0.137;zoomtoheight,1;sleep,108.136;accelerate,2.2;zoomtowidth,0.25;addx,120;sleep,0.5;zoomtowidth,1;addx,-120;sleep,51.572;queuecommand,Vibrate1;sleep,17.455;queuecommand,Stop;sleep,6.545;queuecommand,WagMovie;sleep,34.909;queuecommand,Stop';

	-- Necrofantasia --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Necrofantasia'))
		then s = 'queuecommand,NecrofantasiaPart1';
	
	-- WinDEU Hates You Forever --

	-- Floating Darkness --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/Floating Darkness'))
		then s = 'x,SCREEN_CENTER_X;sleep,35.891;decelerate,0.659;addx,-180;sleep,1.978;decelerate,0.659;addx,360;sleep,1.319;decelerate,0.659;x,SCREEN_CENTER_X;sleep,17.143;decelerate,0.66;addx,-180;sleep,1.318;accelerate,1.319;addx,180;decelerate,1.319;addx,180;accelerate,1.319;addx,-180;decelerate,1.319;addx,-180;accelerate,1.319;addx,180;decelerate,1.319;addx,180;accelerate,1.319;addx,-180;decelerate,1.319;addx,-180;accelerate,1.319;addx,180;decelerate,1.319;addx,180;accelerate,1.319;addx,-180;decelerate,1.319;addx,-180;accelerate,0.659;addx,90;decelerate,0.659;addx,90;sleep,1.319;accelerate,3.956;rotationx,5400;decelerate,3.956;rotationx,10800';

	-- The Detonator --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/The Detonator'))
		then s = 'sleep,25.3;queuecommand,Bounce;sleep,20.809;queuecommand,Stop;sleep,1.388;queuecommand,Bounce;sleep,9.711;queuecommand,Stop;sleep,2.774;queuecommand,Bounce;sleep,8.324;queuecommand,Stop;sleep,1.387;queuecommand,Bounce;sleep,9.711;queuecommand,Stop;sleep,34.682;queuecommand,Bounce;sleep,19.422;queuecommand,Stop;sleep,3.122;linear,5;ZoomToHeight,10;addy,1000';

	-- Lawn Wake XI --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/Lawn Wake XI'))
		then s = 'sleep,56.45;accelerate,1.2;addx,104;zoom,0.35;linear,1.3;addx,130;addy,-65;linear,0.75;addx,-75;addy,-38;linear,1.82;addx,-182;addy,91;linear,2;addx,230;addy,115;linear,0.28;addx,28;addy,-14;linear,2.6;addx,-260;addy,-130;linear,1.24;addx,124;addy,-62;linear,1.36;addx,136;addy,68;linear,2.6;addx,-260;addy,130;linear,0.12;addx,16;addy,8;linear,2.44;addx,244;addy,-122;linear,1.68;addx,-168;addy,-84;linear,0.92;addx,-92;addy,46;linear,2.6;addx,260;addy,130;linear,0.6;addx,-60;addy,30;linear,2;addx,-200;addy,-100;linear,2.1;addx,210;addy,-105;linear,0.5;addx,50;addy,25;linear,2.6;addx,-260;addy,130;linear,1;addx,100;addy,50;linear,1.6;addx,160;addy,-80;linear,2.5;addx,-250;addy,-125;linear,0.1;addx,-10;addy,5;linear,2.6;addx,260;addy,130;linear,1.44;addx,-142;addy,71;linear,1.18;addx,-118;addy,-59;linear,2.6;addx,260;addy,-130;linear,0.36;addx,-36;addy,-18;linear,2.24;addx,-224;addy,112;linear,0.44;addx,44;addy,22;decelerate,1.2;zoom,1;x,SCREEN_CENTER_X-160;y,SCREEN_CENTER_Y;rotationy,1440;sleep,1.2;linear,9.6;rotationz,12960';

	-- WinDEU Hates You Infinity + 1 --
	
	-- Scarlet Heaven of Delays --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Infinity +1/Scarlet Heaven Of Delays'))
		then s = 'sleep,13.617;queuecommand,WagInfinity';
		
	-- Model DD398 --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Infinity +1/Model DD398'))
		then s = 'x,SCREEN_CENTER_X;sleep,45.4;accelerate,0.4;addx,240;addy,-45;rotationy,70;sleep,12;decelerate,0.8;rotationx,75;spring,2.4;rotationx,0;sleep,6.4;accelerate,1.6;addx,-120;addy,22;rotationy,35;decelerate,1.6;addx,-120;addy,23;rotationy,0;sleep,0.4;accelerate,0.4;addx,-240;addy,-45;rotationy,-70;sleep,5.6;decelerate,0.8;rotationx,75;spring,2.4;rotationx,0;accelerate,1.6;addx,120;addy,22;rotationy,-35;decelerate,1.6;addx,120;addy,23;rotationy,0;sleep,101;linear,1.59;zoom,0.85;addy,-20;sleep,0.01;addx,215;sleep,3.2;addx,-430;sleep,3.2;addx,215;sleep,3.2;addx,215;sleep,3.2;addx,-430;sleep,3.2;addx,215;sleep,3.2;addx,215;sleep,3.2;addx,-430;sleep,1.6;accelerate,0.8;zoom,0.925;addx,108;addy,10;decelerate,0.8;zoom,1;addx,107;addy,10';

	-- WinDEU Loves You The Redemption --

	-- Return --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Loves You The Redemption/Return'))
		then s = 'sleep,47.300;accelerate,0.320;addx,400;rotationy,720;decelerate,0.321;addx,-400;rotationy,1440;sleep,26.709;decelerate,0.641;rotationz,360;rotationy,0;rotationx,720;sleep,14.786;decelerate,0.300;rotationy,360;addx,128';
		
	-- Perfect Cherry Storm --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Loves You The Redemption/Perfect Cherry Storm'))
		then s = 'x,SCREEN_CENTER_X;sleep,21.6;queuecommand,Vib1;sleep,60;queuecommand,Stop;sleep,67.2;linear,9.6;addx,-180;rotationz,-20;queuecommand,Rapidwag;linear,7.2;rotationz,-70;queuecommand,Stop;accelerate,1.2;addx,90;rotationz,-35;decelerate,1.2;addx,90;rotationz,0;sleep,40.8;queuecommand,Rapidwag2;sleep,14.4;queuecommand,Stop;sleep,4.9;decelerate,1.2;addx,160;rotationy,1440;sleep,1.2;decelerate,1.2;addx,-320;rotationy,0;sleep,1.2;decelerate,1.2;addx,320;rotationy,1440;sleep,1.2;decelerate,1.2;addx,-320;rotationy,0;sleep,1.2;decelerate,1.2;addx,320;rotationy,1440;sleep,1.2;decelerate,1.2;addx,-320;rotationy,0;sleep,1.2;decelerate,1.2;addx,320;rotationy,1440;sleep,1.2;decelerate,1.2;addx,-160;rotationy,0';
	
	-- SRT 9 --

	-- Psy-Kaliber 2097 --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT 9/Psy-Kaliber 2097'))
		then s = 'x,SCREEN_CENTER_X;queuecommand,ExtraQueue';
	
	-- SRT X --

	-- The End --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT X/The End'))
		then s = 'sleep,350.594;queuecommand,PhantasmPartOneA';

	-- Anger of YuYu --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT X/Anger of YuYu'))
		then s = 'x,SCREEN_CENTER_X;sleep,56.152;queuecommand,LowVibrate;sleep,2.286;queuecommand,MidVibrate;sleep,9.142;queuecommand,HighVibrate;sleep,9.143;queuecommand,Stop;sleep,34.286;queuecommand,MidVibrate;decelerate,0.572;addx,-160;queuecommand,Stop;sleep,5.714-0.572;linear,1.143;addx,160;sleep,2.286;queuecommand,MidVibrate;decelerate,0.572;addx,160;queuecommand,Stop;sleep,5.714-0.572;linear,1.143;addx,-160';

	-- No Marathon Song Match --
	else end

	-- End Marathon Condition --
	end

	-- SRT 9 --

	-- No. 6 --
	if (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT 9/No 6'))
		then s = 'queuecommand,StageThreePartOne';

	-- SRT X --

	-- Hell Scaper --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT X/Hell Scaper (Last Escape Mix)'))
		then s = 'sleep,74.900;queuecommand,MidVibrate;linear,0.25;addy,640;queuecommand,Stop;sleep,5.083;linear,22.667;addy,-640';

	-- No Non-Marathon Song Matches. Return Marathon Song Match or Default if None --
	else return s end
	
	-- Return Song Match --	
	return s
end


-- [LifeP2OnCommand] --
function GetLifeBarEffectsP2()
	s = 'draworder,-1;rotationz,-90;addx,100;sleep,0.5;decelerate,0.8;addx,-100';

	-- Hide Lifebar --
	if IsLifeHidden(PLAYER_2) == 1
		then s = 'hidden,1' return s end
	
	-- Only Activate Effects ONLY in Marathon Mode --
	if GAMESTATE:IsCourseMode() then

	-- WinDEU Hates You The Movie --
	
	-- Watercube --
	if (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Watercube'))
		then s = 'draworder,-1;rotationz,-90;addx,100;sleep,0.5;decelerate,0.8;addx,-100;sleep,65.5;accelerate,2;addy,-500;addx,-150;rotationz,-300;sleep,6;linear,7;addy,800;rotationz,0;sleep,36;decelerate,2.5;addy,-125;accelerate,0.5;rotationz,5;decelerate,0.5;rotationz,10;accelerate,1;rotationz,0;decelerate,1;rotationz,-10;accelerate,1;rotationz,0;decelerate,1;rotationz,10;accelerate,1;rotationz,0;decelerate,1;rotationz,-10';

	-- Secret Area --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Secret Area'))
		then s = 'draworder,-1;rotationz,-90;addx,100;sleep,0.5;decelerate,0.8;addx,-100;sleep,83.8;accelerate,0.65;addy,-500;sleep,0.05;addy,1000;accelerate,0.45;addy,-1000;sleep,0.05;addy,1000;accelerate,0.25;addy,-1000;sleep,0.05;addy,1000;accelerate,0.2;addy,-1000;sleep,0.05;addy,1000;accelerate,0.15;addy,-800';

	-- Little Fragments of Silence --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Little Fragments of Silence'))
		then s = 'diffusealpha,1;draworder,-1;rotationz,-90;addx,100;sleep,0.5;decelerate,0.8;addx,-100;sleep,9.969;linear,0.068;zoomtowidth,0.5;addx,-148;linear,0.137;zoomtowidth,1;addx,148;linear,0.068;zoomtowidth,0.5;addx,-148;linear,0.137;zoomtowidth,1;addx,148;linear,0.068;zoomtowidth,0.5;addx,-148;linear,0.137;zoomtowidth,1;addx,148;linear,0.068;zoomtowidth,0.5;addx,-148;linear,0.137;zoomtowidth,1;addx,148;linear,0.068;zoomtowidth,0.5;addx,-148;linear,0.137;zoomtowidth,1;addx,148;sleep,1.159;linear,0.068;zoomtoheight,0.5;addy,15;linear,0.137;zoomtoheight,1;addy,-15;linear,0.068;zoomtoheight,0.5;addy,15;linear,0.137;zoomtoheight,1;addy,-15;linear,0.068;zoomtoheight,0.5;addy,15;linear,0.137;zoomtoheight,1;addy,-15;linear,0.068;zoomtoheight,0.5;addy,15;linear,0.137;zoomtoheight,1;addy,-15;linear,0.068;zoomtoheight,0.5;addy,15;linear,0.137;zoomtoheight,1;addy,-15;sleep,108.136;accelerate,2.2;zoomtowidth,0.25;addx,-222;sleep,0.5;zoomtowidth,1;addx,222;zoom,0;sleep,32.250;zoom,1';

	-- Necrofantasia --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Necrofantasia'))
		then s = 'draworder,-1;rotationz,-90;addx,100;sleep,61;decelerate,0.8;addx,-100'; 

	-- WinDEU Hates You Forever --

	-- Floating Darkness --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/Floating Darkness'))
		then s = 'draworder,-1;rotationz,-90;addx,100;sleep,0.5;decelerate,0.8;addx,-100';

	-- The Detonator --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/The Detonator'))
		then s = 'draworder,-1;rotationz,-90;addx,100;sleep,0.5;decelerate,0.8;addx,-100;sleep,135.203;linear,5;ZoomToHeight,10;addy,1250';
		
	-- Lawn Wake XI --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/Lawn Wake XI'))
		then s = 'draworder,-1;rotationz,-90;zoomy,0;sleep,2.45;zoomy,1;sleep,54.015;accelerate,1.2;addx,-192;addy,-20;zoom,0.35;linear,1.3;addx,130;addy,-65;linear,0.75;addx,-75;addy,-38;linear,1.82;addx,-182;addy,91;linear,2;addx,230;addy,115;linear,0.28;addx,28;addy,-14;linear,2.6;addx,-260;addy,-130;linear,1.24;addx,124;addy,-62;linear,1.36;addx,136;addy,68;linear,2.6;addx,-260;addy,130;linear,0.12;addx,16;addy,8;linear,2.44;addx,244;addy,-122;linear,1.68;addx,-168;addy,-84;linear,0.92;addx,-92;addy,46;linear,2.6;addx,260;addy,130;linear,0.6;addx,-60;addy,30;linear,2;addx,-200;addy,-100;linear,2.1;addx,210;addy,-105;linear,0.5;addx,50;addy,25;linear,2.6;addx,-260;addy,130;linear,1;addx,100;addy,50;linear,1.6;addx,160;addy,-80;linear,2.5;addx,-250;addy,-125;linear,0.1;addx,-10;addy,5;linear,2.6;addx,260;addy,130;linear,1.44;addx,-142;addy,71;linear,1.18;addx,-118;addy,-59;linear,2.6;addx,260;addy,-130;linear,0.36;addx,-36;addy,-18;linear,2.24;addx,-224;addy,112;linear,0.44;addx,44;addy,22;decelerate,1.2;zoom,1;x,SCREEN_CENTER_X+296;y,SCREEN_CENTER_Y+30;sleep,10.8;linear,1.8;ZoomY,0';

	-- My Little Spooty 2 --
	
	-- Catastrophe UVB-76 --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('My Little Spooty 2/Catastrophe UVB-76'))
		then s = 'draworder,-1;rotationz,-90;addx,100;sleep,48.5;decelerate,0.8;addx,-100;sleep,242.0;queuecommand,VibSpooty;sleep,4;decelerate,5.0;zoom,0.0001;rotationz,70;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y';

	-- No Hide Lifebar and No Song Matches. Return the Default Value --
	else return s end

	-- End Marathon Condition --
	end

	-- Return Match --
	return s
end


-- [ScoreP2OnCommand] --
function GetScoreEffectsP2()
	s = 'shadowlength,0;addy,-100;' .. DoublesScoreCenterP2() ..'sleep,0.5;decelerate,0.8;addy,100';

	-- Hide Score --
	if IsScoreHidden(PLAYER_2) == 1
		then s = 'hidden,1' return s end	

	-- Only Activate Effects ONLY in Marathon Mode --
	if GAMESTATE:IsCourseMode() then

	-- WinDEU Hates You The Movie --

	-- Watercube--
	if (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Watercube'))
		then s = 'addy,-100;sleep,0.5;decelerate,0.8;addy,100;sleep,66.5;accelerate,1;addy,-300;rotationz,-300;sleep,8;linear,8;addy,900;rotationz,0;sleep,34;decelerate,2.5;addy,-212;accelerate,0.5;rotationz,-5;decelerate,0.5;rotationz,-10;accelerate,1;rotationz,0;decelerate,1;rotationz,10;accelerate,1;rotationz,0;decelerate,1;rotationz,-10;accelerate,1;rotationz,0;decelerate,1;rotationz,10';

	--Secret Area--
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Secret Area'))
		then s = 'addy,-100;sleep,0.5;decelerate,0.8;addy,100;sleep,83.3;accelerate,0.65;addy,-500;sleep,0.05;addy,1000;accelerate,0.45;addy,-1000;sleep,0.05;addy,1000;accelerate,0.25;addy,-1000;sleep,0.05;addy,1000;accelerate,0.2;addy,-1000;sleep,0.05;addy,1000;accelerate,0.15;addy,-800';

	-- Little Fragments of Silence --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Little Fragments of Silence'))
		then s = 'diffusealpha,1;addy,-100;sleep,0.5;decelerate,0.8;addy,100;sleep,9.969;linear,0.068;zoomtowidth,0.5;addx,-90;linear,0.137;zoomtowidth,1;addx,90;linear,0.068;zoomtowidth,0.5;addx,-90;linear,0.137;zoomtowidth,1;addx,90;linear,0.068;zoomtowidth,0.5;addx,-90;linear,0.137;zoomtowidth,1;addx,90;linear,0.068;zoomtowidth,0.5;addx,-90;linear,0.137;zoomtowidth,1;addx,90;linear,0.068;zoomtowidth,0.5;addx,-90;linear,0.137;zoomtowidth,1;addx,90;sleep,1.159;linear,0.068;zoomtoheight,0.5;addy,100;linear,0.137;zoomtoheight,1;addy,-100;linear,0.068;zoomtoheight,0.5;addy,100;linear,0.137;zoomtoheight,1;addy,-100;linear,0.068;zoomtoheight,0.5;addy,100;linear,0.137;zoomtoheight,1;addy,-100;linear,0.068;zoomtoheight,0.5;addy,100;linear,0.137;zoomtoheight,1;addy,-100;linear,0.068;zoomtoheight,0.5;addy,100;linear,0.137;zoomtoheight,1;addy,-100;sleep,108.136;accelerate,2.2;zoomtowidth,0.25;addx,-135;sleep,0.5;zoomtowidth,1;addx,135;zoom,0;sleep,32.250;zoom,1';

	-- Necrofantasia --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Necrofantasia'))
		then s = 'hidden,1';

	-- WinDEU Hates You Forever --

	-- Floating Darkness --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/Floating Darkness'))
		then s = 'hidden,1';

	-- The Detonator --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/The Detonator'))
		then s = 'addy,-100;sleep,0.5;decelerate,0.8;addy,100;sleep,135.203;linear,5;ZoomToHeight,10;addy,100';
		
	-- Lawn Wake XI --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/Lawn Wake XI'))
		then s = 'zoomy,0;sleep,4.85;zoomy,1;sleep,51.615;accelerate,1.2;addx,-117;addy,120;zoom,0.35;linear,1.3;addx,130;addy,-65;linear,0.75;addx,-75;addy,-38;linear,1.82;addx,-182;addy,91;linear,2;addx,230;addy,115;linear,0.28;addx,28;addy,-14;linear,2.6;addx,-260;addy,-130;linear,1.24;addx,124;addy,-62;linear,1.36;addx,136;addy,68;linear,2.6;addx,-260;addy,130;linear,0.12;addx,16;addy,8;linear,2.44;addx,244;addy,-122;linear,1.68;addx,-168;addy,-84;linear,0.92;addx,-92;addy,46;linear,2.6;addx,260;addy,130;linear,0.6;addx,-60;addy,30;linear,2;addx,-200;addy,-100;linear,2.1;addx,210;addy,-105;linear,0.5;addx,50;addy,25;linear,2.6;addx,-260;addy,130;linear,1;addx,100;addy,50;linear,1.6;addx,160;addy,-80;linear,2.5;addx,-250;addy,-125;linear,0.1;addx,-10;addy,5;linear,2.6;addx,260;addy,130;linear,1.44;addx,-142;addy,71;linear,1.18;addx,-118;addy,-59;linear,2.6;addx,260;addy,-130;linear,0.36;addx,-36;addy,-18;linear,2.24;addx,-224;addy,112;linear,0.44;addx,44;addy,22;decelerate,1.2;zoom,1;x,SCREEN_CENTER_X+180;y,SCREEN_TOP+56;sleep,10.8;linear,1.8;ZoomX,0';

	-- SRT 8 --

	-- Weave Detonator --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT 8/Weave Detonator'))
		then s = 'hidden,1';

	-- WinDEU Hates You Infinity +1 --

	-- Model DD398 --	
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Infinity +1/Model DD398'))
		then s = 'hidden,1';

	-- Hard Weak Hard Magic --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Infinity +1/Hard Weak Hard Magic'))
		then s = 'hidden,1';

	-- WinDEU Loves You The Redemption --

	-- Perfect Cherry Storm --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Loves You The Redemption/Perfect Cherry Storm'))
		then s = 'hidden,1';

	-- SRT 9 --

	-- Psy-Kaliber 2097 --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT 9/Psy-Kaliber 2097'))
		then s = 'hidden,1';

	-- SRT X --

	-- Anger of YuYu --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT X/Anger of YuYu'))
		then s = 'hidden,1';

	-- The End --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT X/The End'))
		then s = 'shadowlength,0;addy,-100;' .. DoublesScoreCenterP2() ..'sleep,300;decelerate,0.8;addy,100';

	-- No Hide Lifebar and No Song Matches. Return the Default Value --
	else return s end

	-- End Marathon Condition --
	end
	
	-- Return Song Match --
	return s
end


-- [PlayerP2OnCommand] --
function GetPlayerEffectsP2(pn)

	-- Check for Any Enabled Custom Mods --
	s = CheckCustomMods(PLAYER_2)

	-- Only Activate Effects ONLY in Marathon Mode --
	if GAMESTATE:IsCourseMode() then

	-- WinDEU Hates You The Musical --

	-- Nuclear Fusion -- See the Entire Playing Field with only 1 Player Active --
	if (GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1)) and (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Musical/Nuclear Fusion'))
		then s = 'sleep,128.19;linear,1;x,SCREEN_CENTER_X;zoomx,0.5;sleep,44;linear,1;zoomx,1';

	-- WinDEU Hates You The Movie --

	-- Secret Area--
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Secret Area'))
		then s = 'sleep,55.6;linear,0.2;rotationz,360;sleep,0.143;linear,0.3;rotationz,-360;sleep,1.714;queuecommand,Vibrate1;sleep,0.514;queuecommand,Stop;sleep,7.029;decelerate,0.65;rotationy,1080;sleep,19.357;accelerate,0.65;addy,-500;sleep,0.05;addy,1000;accelerate,0.45;addy,-1000;sleep,0.05;addy,1000;accelerate,0.25;addy,-1000;sleep,0.05;addy,1000;accelerate,0.2;addy,-1000;sleep,0.05;addy,1000;accelerate,0.15;addy,-800';

	-- Printer Jam --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Printer Jam'))
		then s = 'sleep,13.300;linear,0.69;addx,50;linear,0.69;addx,-100;linear,0.69;addx,100;linear,0.69;addx,-100;linear,0.258;addx,100;linear,0.258;addx,-100;linear,0.173;addx,100;linear,0.518;addx,-100;linear,0.862;addx,100;linear,0.69;addx,-100;linear,0.69;addx,100;linear,0.69;addx,-100;linear,0.69;addx,100;linear,0.69;addx,-100;linear,0.258;addx,100;linear,0.258;addx,-100;linear,0.173;addx,100;linear,0.518;addx,-100;linear,0.862;addx,100;linear,0.69;addx,-100;linear,0.69;addx,100;linear,0.69;addx,-100;linear,0.69;addx,100;linear,0.69;addx,-100;linear,0.258;addx,100;linear,0.258;addx,-100;linear,0.173;addx,100;linear,0.518;addx,-100;linear,0.862;addx,100;linear,0.345;addx,-50';

	-- Little Fragments of Silence --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Little Fragments of Silence'))
		then s = 'sleep,11.269;linear,0.068;zoomtowidth,0.5;addx,-80;linear,0.137;zoomtowidth,1;addx,80;linear,0.068;zoomtowidth,0.5;addx,-80;linear,0.137;zoomtowidth,1;addx,80;linear,0.068;zoomtowidth,0.5;addx,-80;linear,0.137;zoomtowidth,1;addx,80;linear,0.068;zoomtowidth,0.5;addx,-80;linear,0.137;zoomtowidth,1;addx,80;linear,0.068;zoomtowidth,0.5;addx,-80;linear,0.137;zoomtowidth,1;addx,80;sleep,1.159;linear,0.068;zoomtoheight,0.5;linear,0.137;zoomtoheight,1;linear,0.068;zoomtoheight,0.5;linear,0.137;zoomtoheight,1;linear,0.068;zoomtoheight,0.5;linear,0.137;zoomtoheight,1;linear,0.068;zoomtoheight,0.5;linear,0.137;zoomtoheight,1;linear,0.068;zoomtoheight,0.5;linear,0.137;zoomtoheight,1;sleep,108.136;accelerate,2.2;zoomtowidth,0.25;addx,-120;sleep,0.5;zoomtowidth,1;addx,120;sleep,51.572;queuecommand,Vibrate1;sleep,17.455;queuecommand,Stop;sleep,6.545;queuecommand,WagMovie;sleep,34.909;queuecommand,Stop';

	-- Necrofantasia -- Push Off Screen if BOTH Players are Active --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You The Movie/Necrofantasia'))
		then if GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsPlayerEnabled(PLAYER_1)
		then s = 'queuecommand,NecrofantasiaPart1Offset';
		else s = 'queuecommand,NecrofantasiaPart1'; end

	-- WinDEU Hates You Forever --

	-- Floating Darkness -- Push Off Screen if BOTH Players are Active --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/Floating Darkness'))
		then if GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsPlayerEnabled(PLAYER_1)
		then s = 'x,SCREEN_CENTER_X-SCREEN_WIDTH*2;sleep,35.891;decelerate,0.659;addx,-180;sleep,1.978;decelerate,0.659;addx,360;sleep,1.319;decelerate,0.659;x,SCREEN_CENTER_X-SCREEN_WIDTH*2;sleep,17.143;decelerate,0.66;addx,-180;sleep,1.318;accelerate,1.319;addx,180;decelerate,1.319;addx,180;accelerate,1.319;addx,-180;decelerate,1.319;addx,-180;accelerate,1.319;addx,180;decelerate,1.319;addx,180;accelerate,1.319;addx,-180;decelerate,1.319;addx,-180;accelerate,1.319;addx,180;decelerate,1.319;addx,180;accelerate,1.319;addx,-180;decelerate,1.319;addx,-180;accelerate,0.659;addx,90;decelerate,0.659;addx,90;sleep,1.319;accelerate,3.956;rotationx,5400;decelerate,3.956;rotationx,10800';
		else s = 'x,SCREEN_CENTER_X;sleep,35.891;decelerate,0.659;addx,-180;sleep,1.978;decelerate,0.659;addx,360;sleep,1.319;decelerate,0.659;x,SCREEN_CENTER_X;sleep,17.143;decelerate,0.66;addx,-180;sleep,1.318;accelerate,1.319;addx,180;decelerate,1.319;addx,180;accelerate,1.319;addx,-180;decelerate,1.319;addx,-180;accelerate,1.319;addx,180;decelerate,1.319;addx,180;accelerate,1.319;addx,-180;decelerate,1.319;addx,-180;accelerate,1.319;addx,180;decelerate,1.319;addx,180;accelerate,1.319;addx,-180;decelerate,1.319;addx,-180;accelerate,0.659;addx,90;decelerate,0.659;addx,90;sleep,1.319;accelerate,3.956;rotationx,5400;decelerate,3.956;rotationx,10800'; end
		
	-- Lawn Wake XI --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/Lawn Wake XI'))
		then s = 'sleep,56.45;accelerate,1.2;addx,-104;zoom,0.35;linear,1.3;addx,130;addy,-65;linear,0.75;addx,-75;addy,-38;linear,1.82;addx,-182;addy,91;linear,2;addx,230;addy,115;linear,0.28;addx,28;addy,-14;linear,2.6;addx,-260;addy,-130;linear,1.24;addx,124;addy,-62;linear,1.36;addx,136;addy,68;linear,2.6;addx,-260;addy,130;linear,0.12;addx,16;addy,8;linear,2.44;addx,244;addy,-122;linear,1.68;addx,-168;addy,-84;linear,0.92;addx,-92;addy,46;linear,2.6;addx,260;addy,130;linear,0.6;addx,-60;addy,30;linear,2;addx,-200;addy,-100;linear,2.1;addx,210;addy,-105;linear,0.5;addx,50;addy,25;linear,2.6;addx,-260;addy,130;linear,1;addx,100;addy,50;linear,1.6;addx,160;addy,-80;linear,2.5;addx,-250;addy,-125;linear,0.1;addx,-10;addy,5;linear,2.6;addx,260;addy,130;linear,1.44;addx,-142;addy,71;linear,1.18;addx,-118;addy,-59;linear,2.6;addx,260;addy,-130;linear,0.36;addx,-36;addy,-18;linear,2.24;addx,-224;addy,112;linear,0.44;addx,44;addy,22;decelerate,1.2;zoom,1;x,SCREEN_CENTER_X+160;y,SCREEN_CENTER_Y;rotationy,1440;sleep,1.2;linear,9.6;rotationz,12960';

	-- The Detonator --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Forever/The Detonator'))
		then s = 'sleep,25.3;queuecommand,Bounce;sleep,20.809;queuecommand,Stop;sleep,1.388;queuecommand,Bounce;sleep,9.711;queuecommand,Stop;sleep,2.774;queuecommand,Bounce;sleep,8.324;queuecommand,Stop;sleep,1.387;queuecommand,Bounce;sleep,9.711;queuecommand,Stop;sleep,34.682;queuecommand,Bounce;sleep,19.422;queuecommand,Stop;sleep,3.122;linear,5;ZoomToHeight,10;addy,1000';

	-- WinDEU Hates You Infinity + 1 --
		
	-- Scarlet Heaven of Delays --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Infinity +1/Scarlet Heaven Of Delays'))
		then s = 'sleep,13.617;queuecommand,WagInfinity';
		
	-- Model DD398 -- Push Off Screen if BOTH Players are Active --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Hates You Infinity +1/Model DD398'))
		then if GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsPlayerEnabled(PLAYER_1)
		then s = 'x,SCREEN_CENTER_X-SCREEN_WIDTH*2;sleep,45.4;accelerate,0.4;addx,240;addy,-45;rotationy,70;sleep,12;decelerate,0.8;rotationx,75;spring,2.4;rotationx,0;sleep,6.4;accelerate,1.6;addx,-120;addy,22;rotationy,35;decelerate,1.6;addx,-120;addy,23;rotationy,0;sleep,0.4;accelerate,0.4;addx,-240;addy,-45;rotationy,-70;sleep,5.6;decelerate,0.8;rotationx,75;spring,2.4;rotationx,0;accelerate,1.6;addx,120;addy,22;rotationy,-35;decelerate,1.6;addx,120;addy,23;rotationy,0;sleep,101;linear,1.59;zoom,0.85;addy,-20;sleep,0.01;addx,215;sleep,3.2;addx,-430;sleep,3.2;addx,215;sleep,3.2;addx,215;sleep,3.2;addx,-430;sleep,3.2;addx,215;sleep,3.2;addx,215;sleep,3.2;addx,-430;sleep,1.6;accelerate,0.8;zoom,0.925;addx,108;addy,10;decelerate,0.8;zoom,1;addx,107;addy,10';
		else s = 'x,SCREEN_CENTER_X;sleep,45.4;accelerate,0.4;addx,240;addy,-45;rotationy,70;sleep,12;decelerate,0.8;rotationx,75;spring,2.4;rotationx,0;sleep,6.4;accelerate,1.6;addx,-120;addy,22;rotationy,35;decelerate,1.6;addx,-120;addy,23;rotationy,0;sleep,0.4;accelerate,0.4;addx,-240;addy,-45;rotationy,-70;sleep,5.6;decelerate,0.8;rotationx,75;spring,2.4;rotationx,0;accelerate,1.6;addx,120;addy,22;rotationy,-35;decelerate,1.6;addx,120;addy,23;rotationy,0;sleep,101;linear,1.59;zoom,0.85;addy,-20;sleep,0.01;addx,215;sleep,3.2;addx,-430;sleep,3.2;addx,215;sleep,3.2;addx,215;sleep,3.2;addx,-430;sleep,3.2;addx,215;sleep,3.2;addx,215;sleep,3.2;addx,-430;sleep,1.6;accelerate,0.8;zoom,0.925;addx,108;addy,10;decelerate,0.8;zoom,1;addx,107;addy,10'; end

	-- WinDEU Loves You The Redemption --

	-- Return --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Loves You The Redemption/Return'))
		then s = 'sleep,47.300;accelerate,0.320;addx,-400;rotationy,720;decelerate,0.321;addx,400;rotationy,1440;sleep,26.709;decelerate,0.641;rotationz,360;rotationy,0;rotationx,720;sleep,14.786;decelerate,0.300;rotationy,360;addx,-128';
		
	-- Perfect Cherry Storm -- Push Off Screen if BOTH Players are Active --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('WinDEU Loves You The Redemption/Perfect Cherry Storm'))
		then if GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsPlayerEnabled(PLAYER_1)
		then s = 'x,SCREEN_CENTER_X-SCREEN_WIDTH*2;sleep,21.6;queuecommand,Vib1;sleep,60;queuecommand,Stop;sleep,67.2;linear,9.6;addx,-180;rotationz,-20;queuecommand,Rapidwag;linear,7.2;rotationz,-70;queuecommand,Stop;accelerate,1.2;addx,90;rotationz,-35;decelerate,1.2;addx,90;rotationz,0;sleep,40.8;queuecommand,Rapidwag2;sleep,14.4;queuecommand,Stop;sleep,4.9;decelerate,1.2;addx,160;rotationy,1440;sleep,1.2;decelerate,1.2;addx,-320;rotationy,0;sleep,1.2;decelerate,1.2;addx,320;rotationy,1440;sleep,1.2;decelerate,1.2;addx,-320;rotationy,0;sleep,1.2;decelerate,1.2;addx,320;rotationy,1440;sleep,1.2;decelerate,1.2;addx,-320;rotationy,0;sleep,1.2;decelerate,1.2;addx,320;rotationy,1440;sleep,1.2;decelerate,1.2;addx,-160;rotationy,0';
		else s = 'x,SCREEN_CENTER_X;sleep,21.6;queuecommand,Vib1;sleep,60;queuecommand,Stop;sleep,67.2;linear,9.6;addx,-180;rotationz,-20;queuecommand,Rapidwag;linear,7.2;rotationz,-70;queuecommand,Stop;accelerate,1.2;addx,90;rotationz,-35;decelerate,1.2;addx,90;rotationz,0;sleep,40.8;queuecommand,Rapidwag2;sleep,14.4;queuecommand,Stop;sleep,4.9;decelerate,1.2;addx,160;rotationy,1440;sleep,1.2;decelerate,1.2;addx,-320;rotationy,0;sleep,1.2;decelerate,1.2;addx,320;rotationy,1440;sleep,1.2;decelerate,1.2;addx,-320;rotationy,0;sleep,1.2;decelerate,1.2;addx,320;rotationy,1440;sleep,1.2;decelerate,1.2;addx,-320;rotationy,0;sleep,1.2;decelerate,1.2;addx,320;rotationy,1440;sleep,1.2;decelerate,1.2;addx,-160;rotationy,0'; end

	-- SRT 9 --

	-- Psy-Kaliber 2097 --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT 9/Psy-Kaliber 2097'))
		then if GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsPlayerEnabled(PLAYER_1)
		then s = 'x,SCREEN_CENTER_X-SCREEN_WIDTH*2;queuecommand,ExtraQueueOffset';
		else s = 'x,SCREEN_CENTER_X;queuecommand,ExtraQueue'; end

	-- SRT X --			

	-- The End --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT X/The End'))
		then s = 'sleep,350.594;queuecommand,PhantasmPartOneA';

	-- Anger of YuYu --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT X/Anger of YuYu'))
		then if GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsPlayerEnabled(PLAYER_1)
		then s = 'x,SCREEN_CENTER_X-SCREEN_WIDTH*2;sleep,56.152;queuecommand,LowVibrate;sleep,2.286;queuecommand,MidVibrate;sleep,9.142;queuecommand,HighVibrate;sleep,9.143;queuecommand,Stop;sleep,34.286;queuecommand,MidVibrate;decelerate,0.572;addx,-160;queuecommand,Stop;sleep,5.714-0.572;linear,1.143;addx,160;sleep,2.286;queuecommand,MidVibrate;decelerate,0.572;addx,160;queuecommand,Stop;sleep,5.714-0.572;linear,1.143;addx,-160';
		else s = 'x,SCREEN_CENTER_X;sleep,56.152;queuecommand,LowVibrate;sleep,2.286;queuecommand,MidVibrate;sleep,9.142;queuecommand,HighVibrate;sleep,9.143;queuecommand,Stop;sleep,34.286;queuecommand,MidVibrate;decelerate,0.572;addx,-160;queuecommand,Stop;sleep,5.714-0.572;linear,1.143;addx,160;sleep,2.286;queuecommand,MidVibrate;decelerate,0.572;addx,160;queuecommand,Stop;sleep,5.714-0.572;linear,1.143;addx,-160'; end

	-- No Marathon Song Match --
	else end

	-- End Marathon Condition --
	end

	-- SRT 9 --

	-- No. 6 --
	if (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT 9/No 6'))
		then s = 'queuecommand,StageThreePartOne';
		
	-- SRT X --

	-- Hell Scaper --
	elseif (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('SRT X/Hell Scaper (Last Escape Mix)'))
		then s = 'sleep,74.900;queuecommand,MidVibrate;linear,0.25;addy,640;queuecommand,Stop;sleep,5.083;linear,22.667;addy,-640';
	
	-- No Non-Marathon Song Match. Return Marathon Song Match or Default if None --
	else return s end

	-- Return Song Match --
	return s
end

-- [This function will hide the Frame at the top of the screen for certain songs. It only gets called in Marathon Mode.] --
function HideFrame()
	s = ''

	-- WinDEU Hates You The Movie --

	-- Necrofantasia --
	if GetCourseTitle() == 'Extra Stage (Movie)'
		then s = 'hidden,1';

	-- WinDEU Hates You Forever --

	-- Floating Darkness --
	elseif GetCourseTitle() == 'Extra Stage (Forever)'
		then s = 'hidden,1';

	-- WinDEU Hates You Infinity + 1 --

	-- Model DD398 --
	elseif GetCourseTitle() == 'Extra Stage (Infinity)'
		then s = 'hidden,1';

	-- Hard Weak Hard Magic --
	elseif GetCourseTitle() == 'Stage 5 (Infinity)'
		then s = 'hidden,1';

	-- WinDEU Loves You The Redemption --

	-- Perfect Cherry Storm --
	elseif GetCourseTitle() == 'Extra Stage (Redemption)'
		then s = 'hidden,1';

	-- SRT 8 --

	-- Weave Detonator --
	elseif GetCourseTitle() == 'Phantasm'
		then s = 'hidden,1';

	-- SRT 9 --

	-- Psy-Kaliber 2097 --
	elseif GetCourseTitle() == 'Extra Stage (SRT 9)'
		then s = 'hidden,1';

	-- SRT X --
	
	-- The End --
	elseif GetCourseTitle() == 'The End'
		then s = 'addy,-300;sleep,300;decelerate,0.8;addy,300';

	-- No Match. Return Default --
	else return s end
		
	-- Return Match --
	return s
end


-- [These functions provide support for effects.] --

function Vibrate1()
	s = 'vibrate;effectmagnitude,20,20,20';
	return s
end

function Vibrate2()
	s = 'vibrate;effectmagnitude,150,0,0';
	return s
end

function VibSpooty()
	s = 'vibrate;effectmagnitude,10,10,10';
	return s
end

function WagInfinity()
	s = 'wag;effectmagnitude,0,80,0;effectclock,bgm;effectperiod,4';
	return s
end

function WagMovie()
	s = 'wag;effectmagnitude,0,0,25;effectclock,bgm;effectperiod,2';
	return s
end

function Bounce()
	s = 'bounce;effectmagnitude,0,-100,0;effectclock,bgm;effectperiod,1';
	return s
end

function Stop()
	s = 'stopeffect';
	return s
end

function Vib1()
	s = 'vibrate;effectmagnitude,10,10,0';
	return s
end

function Rapidwag()
	s = 'wag;effectmagnitude,0,0,10;effectperiod,0.05';
	return s
end

function Rapidwag2()
	s = 'wag;effectmagnitude,0,35,0;effectclock,bgm;effectperiod,0.125';
	return s
end

function NecrofantasiaPart1()
	s = 'x,SCREEN_CENTER_X;sleep,81.850;decelerate,0.5;skewx,-2.5;spring,2.095;skewx,0;decelerate,0.5;skewx,2.5;spring,2.095;skewx,0;decelerate,0.5;skewx,-2.5;spring,2.095;skewx,0;decelerate,0.5;skewx,2.5;spring,2.095;skewx,0;decelerate,0.5;skewx,-2.5;spring,2.095;skewx,0;decelerate,0.5;skewx,2.5;spring,2.095;skewx,0;decelerate,0.5;skewx,-2.5;spring,2.095;skewx,0;decelerate,0.5;skewx,2.5;spring,2.095;skewx,0;sleep,41.450;linear,0.648;ZoomX,0;linear,0.648;ZoomX,2.5;linear,0.648;ZoomY,0;linear,0.648;ZoomY,1;linear,0.648;ZoomX,0;linear,0.648;ZoomX,2.5;linear,0.648;ZoomY,0;linear,0.648;ZoomY,1;linear,0.648;ZoomX,0;linear,0.648;ZoomX,2.5;linear,0.648;ZoomY,0;linear,0.648;ZoomY,1;linear,0.648;ZoomX,0;linear,0.648;ZoomX,2.5;linear,0.648;ZoomY,0;linear,0.648;ZoomY,1;linear,0.648;ZoomX,0;linear,0.648;ZoomX,2.5;linear,0.648;ZoomY,0;linear,0.648;ZoomY,1;linear,0.648;ZoomX,0;linear,0.648;ZoomX,2.5;linear,0.648;ZoomY,0;linear,0.648;ZoomY,1;ZoomX,1;sleep,5.189;queuecommand,NecrofantasiaPart2';
	return s
end

function NecrofantasiaPart1Offset()
	s = 'x,SCREEN_CENTER_X-SCREEN_WIDTH*2;sleep,81.850;decelerate,0.5;skewx,-2.5;spring,2.095;skewx,0;decelerate,0.5;skewx,2.5;spring,2.095;skewx,0;decelerate,0.5;skewx,-2.5;spring,2.095;skewx,0;decelerate,0.5;skewx,2.5;spring,2.095;skewx,0;decelerate,0.5;skewx,-2.5;spring,2.095;skewx,0;decelerate,0.5;skewx,2.5;spring,2.095;skewx,0;decelerate,0.5;skewx,-2.5;spring,2.095;skewx,0;decelerate,0.5;skewx,2.5;spring,2.095;skewx,0;sleep,41.450;linear,0.648;ZoomX,0;linear,0.648;ZoomX,2.5;linear,0.648;ZoomY,0;linear,0.648;ZoomY,1;linear,0.648;ZoomX,0;linear,0.648;ZoomX,2.5;linear,0.648;ZoomY,0;linear,0.648;ZoomY,1;linear,0.648;ZoomX,0;linear,0.648;ZoomX,2.5;linear,0.648;ZoomY,0;linear,0.648;ZoomY,1;linear,0.648;ZoomX,0;linear,0.648;ZoomX,2.5;linear,0.648;ZoomY,0;linear,0.648;ZoomY,1;linear,0.648;ZoomX,0;linear,0.648;ZoomX,2.5;linear,0.648;ZoomY,0;linear,0.648;ZoomY,1;linear,0.648;ZoomX,0;linear,0.648;ZoomX,2.5;linear,0.648;ZoomY,0;linear,0.648;ZoomY,1;ZoomX,1;sleep,5.189;queuecommand,NecrofantasiaPart2';
	return s
end

function NecrofantasiaPart2()
	s = 'accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,360;accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,0;accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,360;accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,0;accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,360;accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,0;accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,360;accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,0;accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,360;accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,0;accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,360;accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,0;accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,360;accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,0;accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,360;accelerate,0.649;rotationz,180;decelerate,0.649;rotationz,0;linear,18.162;rotationz,2520;queuecommand,NecrofantasiaPart3';
	return s
end

function NecrofantasiaPart3()
	s = 'sleep,44.108;queuecommand,Vibrate2;sleep,20.757;queuecommand,Stop';
	return s
end
 
function PhantasmPartOneA()
        s = 'decelerate,0.16216;rotationz,90;linear,0.05405;rotationz,-80;linear,0.05405;rotationz,70;linear,0.05405;rotationz,-60;linear,0.05405;rotationz,50;linear,0.05405;rotationz,-40;linear,0.05405;rotationz,30;linear,0.05405;rotationz,-20;linear,0.05405;rotationz,10;linear,0.05405;rotationz,0;sleep,9.081;decelerate,0.10811;zoomx,0.25;zoomy,4;accelerate,0.10811;zoomx,4;zoomy,0.25;decelerate,0.10811;zoomx,1;zoomy,1;sleep,31.46-10.378;decelerate,0.16216;rotationz,-90;linear,0.05405;rotationz,80;linear,0.05405;rotationz,-70;linear,0.05405;rotationz,60;linear,0.05405;rotationz,-50;linear,0.05405;rotationz,40;linear,0.05405;rotationz,-30;linear,0.05405;rotationz,20;linear,0.05405;rotationz,-10;linear,0.05405;rotationz,0;sleep,1.297;queuecommand,MidVibrate;decelerate,0.5;rotationy,25;queuecommand,Stop;sleep,0.798;sleep,0;queuecommand,PhantasmPartOneB';
        return s
end

function PhantasmPartOneB()
        s = 'decelerate,0.10811;zoomx,0.25;zoomy,4;accelerate,0.10811;zoomx,4;zoomy,0.25;decelerate,0.10811;zoomx,1;zoomy,1;sleep,4.865;decelerate,0.10811;zoomx,0.25;zoomy,4;accelerate,0.10811;zoomx,4;zoomy,0.25;decelerate,0.10811;zoomx,1;zoomy,1;sleep,4.865;decelerate,0.10811;zoomx,0.25;zoomy,4;accelerate,0.10811;zoomx,4;zoomy,0.25;decelerate,0.10811;zoomx,1;zoomy,1;sleep,4.865;decelerate,0.10811;zoomx,0.25;zoomy,4;accelerate,0.10811;zoomx,4;zoomy,0.25;decelerate,0.10811;zoomx,1;zoomy,1;sleep,2.271;queuecommand,PhantasmPartTwo';
        return s
end
 
function PhantasmPartTwo()
        s = 'accelerate,0.16216;zoomx,0;addx,-300;rotationy,0;decelerate,0.81081;zoomx,1;addx,300;accelerate,0.16216;zoomx,0;addx,300;decelerate,0.81081;zoomx,1;addx,-300;accelerate,0.16216;zoomx,0;addx,-300;decelerate,0.81081;zoomx,1;addx,300;accelerate,0.16216;zoomx,0;addx,300;decelerate,0.81081;zoomx,1;addx,-300;accelerate,0.16216;zoomx,0;addx,-300;decelerate,0.81081;zoomx,1;addx,300;accelerate,0.16216;zoomx,0;addx,300;decelerate,0.81081;zoomx,1;addx,-300;accelerate,0.16216;zoomx,0;addx,-300;decelerate,0.81081;zoomx,1;addx,300;accelerate,0.16216;zoomx,0;addx,300;decelerate,0.81081;zoomx,1;addx,-300;accelerate,0.16216;zoomx,0;addx,-300;decelerate,0.81081;zoomx,1;addx,300;accelerate,0.16216;zoomx,0;addx,300;decelerate,0.81081;zoomx,1;addx,-300;accelerate,0.16216;zoomx,0;addx,-300;decelerate,0.81081;zoomx,1;addx,300;accelerate,0.16216;zoomx,0;addx,300;decelerate,0.81081;zoomx,1;addx,-300;accelerate,0.16216;zoomx,0;addx,-300;decelerate,0.81081;zoomx,1;addx,300;accelerate,0.16216;zoomx,0;addx,300;decelerate,0.81081;zoomx,1;addx,-300;accelerate,0.16216;zoomx,0;addx,-300;decelerate,0.81081;zoomx,1;addx,300;accelerate,0.16216;zoomx,0;addx,300;decelerate,0.81081;zoomx,1;addx,-300;sleep,0.487;rotationz,18000;decelerate,19.621;rotationz,0;sleep,24;queuecommand,PhantasmPartThreeA';
 
        return s
end
 
function PhantasmPartThreeA()
        s = 'accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600;accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600;accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600;accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600;accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600;accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600;queuecommand,PhantasmPartThreeB';
        return s
end
 
function PhantasmPartThreeB()
        s = 'accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600;accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600;accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600;accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600;accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600;accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600;queuecommand,PhantasmPartThreeC';
        return s
end
 
function PhantasmPartThreeC()
        s = 'accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600;accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600;accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600;accelerate,0.31933;addx,600;sleep,0.01;addx,-1200;decelerate,0.31932;addx,600;accelerate,0.31932;addx,-600;sleep,0.01;addx,1200;decelerate,0.31932;addx,-600';
        return s
end