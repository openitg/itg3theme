-- Override these in other themes.
function SongModifiers()
	if OPENITG then 
		if GAMESTATE:GetPlayMode() == PLAY_MODE_REGULAR and not GAMESTATE:PlayerUsingBothSides() then
			return "1,2,3,4,7,5,18,17,9,22,23,10,11,12,13,14,15,19,25,20,27,24,16" --normal gameplay, no doubles7
			
		elseif  GAMESTATE:GetPlayMode() == PLAY_MODE_REGULAR and GAMESTATE:PlayerUsingBothSides() then
			return "1,2,3,4,7,5,18,17,9,23,10,11,12,13,14,15,19,25,20,27,24,16" --normal play, doubles
		
		elseif GAMESTATE:GetPlayMode() == PLAY_MODE_NONSTOP then
			return "1,2,3,4,7,5,18,17,9,22,23,12,13,14,15,19,21,27,24,16"	--course
		else
			return "1,2,3,4,7,5,18,17,9,10,11,12,13,14,15,16" end --"survival/fallback"
			
	
	else return "1,2,3,4,7,5,18,17,9,10,11,12,13,14,15,16" end --not running oitg
	
	
end

function oitgACoptions()
	if OPENITG then return "1,2,3,50,4,5,6,120,7,8,113,46,13" end
	return "1,2,3,4,5,6,7,8,114,113,46,47,13"
end

function Platform() return "arcade" end

function IsPIUIO() return GetInputType() == "PIUIO`" end
function IsITGIO() return GetInputType() == "ITGIO" end

function IsArcadeIO() return IsPIUIO() or IsITGIO() end

function SelectButtonAvailable()
	return not IsITGIO()
end

function ShowForITGIO( actor )
	
	if GetInputType() == "ITGIO" then actor:hidden(0) 
	elseif GetInputType() == "Home" then actor:hidden(1)
	end
end


function HideForITGIO( actor )
	if GetInputType() == "ITGIO" then actor:hidden(1) end
end


function IOBridge( actor )
if GetInputType() == "ITGIO" or GetInputType() == "PIUIO" then
		actor:stoptweening()
		actor:linear(.03)
		actor:diffusealpha(1)
	end
end

function PIUIODisable( actor )
if GetInputType() == "PIUIO" then
		actor:hidden(1)
	end
end


function GetWorkoutMenuCommand()
	GAMESTATE:SetTemporaryEventMode(true)
	return "difficulty," .. GetInitialDifficulty() .. ";screen,ScreenWorkoutMenu;PlayMode,regular;SetEnv,Workout,1"
end

function ScreenEndingGetDisplayName( pn )
	if PROFILEMAN:IsPersistentProfile(pn) then return GAMESTATE:GetPlayerDisplayName(pn) end
	return "No Card"
end


function RandomStartSong()
	local t = {
		"In The Groove 3/Bagpipe",
		"In The Groove 3/All That Matters",
		"In The Groove 3/Art City",
		"In The Groove 3/Dance Vibrations",
		"In The Groove 3/Coming Out",
	};
	
	local s = SONGMAN:FindSong( t[ math.random(1,table.getn(t)) ] )
	GAMESTATE:SetPreferredSong( s )
end
	
function ScreenOpenITG()
	if OPENITG then return true end
	return false
end

function AdBx()
	if OPENITG then return "zoom,.6;x,SCREEN_RIGHT-SCREEN_WIDTH/3.3;y,SCREEN_BOTTOM-150" end
	return "zoom,.9;x,SCREEN_RIGHT-SCREEN_WIDTH/2;y,SCREEN_BOTTOM-190"
end


function AdITG3()
	if OPENITG then return "zoom,.7;x,SCREEN_RIGHT-SCREEN_WIDTH/3;y,SCREEN_TOP+100" end
	return "zoom,.8;x,SCREEN_RIGHT-SCREEN_WIDTH/2;y,SCREEN_TOP+120"
end

function oitg9()
	if OPENITG then return "mod,6x;name,6x" end
	return "mod,5.5x;name,5.5x"
end
function oitg10()
	if OPENITG then return "mod,c450;name,c450" end
	return "mod,6x;name,6x"
end
function oitg11()
	if OPENITG then return "mod,m550;name,m550" end
	return "mod,C450;name,c450"
end



function lightstest()
	if OPENITG then return "Screen,ScreenTestLights;name,Test Lights" end
	return "Screen,ScreenTestLightsLegacy;name,Test Lights"
end

function WhyDontYouWork()
	local song = GAMESTATE:GetCurrentSong()
	local dir = song:GetSongDir()
	if not song then return "" end
	local banner = song:GetBannerPath()
	
	if string.find(dir,"/@mc1/") or string.find(dir,"/@mc2/") then return song:GetDisplayFullTitle()  end
	
	if not banner then return song:GetDisplayFullTitle()  end
	return ""
end




function QuadAward( pn )
	return PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade(STEPS_TYPE_DANCE_SINGLE,DIFFICULTY_CHALLENGE,GRADE_TIER01)
end


function StarAward( pn )
	return PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade(STEPS_TYPE_DANCE_SINGLE,DIFFICULTY_CHALLENGE,GRADE_TIER01)*4
				+PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade(STEPS_TYPE_DANCE_SINGLE,DIFFICULTY_CHALLENGE,GRADE_TIER02)*3
				+PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade(STEPS_TYPE_DANCE_SINGLE,DIFFICULTY_CHALLENGE,GRADE_TIER03)*2
				+PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade(STEPS_TYPE_DANCE_SINGLE,DIFFICULTY_CHALLENGE,GRADE_TIER04)
end


function CalorieAward( pn )
	return PROFILEMAN:GetProfile(pn):GetCaloriesBurnedToday()
end


function PercentAward( pn )

	return (PROFILEMAN:GetProfile(pn):GetSongsActual(STEPS_TYPE_DANCE_SINGLE,DIFFICULTY_CHALLENGE))*100
end




function StarIcon( Actor,pn )
local stars = StarAward( pn ); 
Trace("stars: " .. stars);
        if stars < 10 then Actor:hidden(1) end 
        if stars >= 10 then Actor:setstate(4) end 
        if stars >= 25 then Actor:setstate(5) end 
        if stars >= 50 then Actor:setstate(6) end 
        if stars >= 100 then Actor:setstate(7) end 
end


function QuadIcon( Actor,pn ) 
local quads = QuadAward( pn ); 
Trace("quads: " .. quads);
        if quads < 10 then Actor:hidden(1) end 
        if quads >= 10 then Actor:setstate(8) end 
        if quads >= 25 then Actor:setstate(9) end 
        if quads >= 50 then Actor:setstate(10) end 
        if quads >= 100 then Actor:setstate(11) end 
end




function PercentIcon( Actor,pn ) 
local perc = PercentAward( pn ); 
Trace("perc: " .. perc);
        if perc < 500 then Actor:hidden(1) end 
        if perc >= 500 then Actor:setstate(0) end 
        if perc >= 2500 then Actor:setstate(1) end 
        if perc >= 7500 then Actor:setstate(2) end 
        if perc >= 15000 then Actor:setstate(3) end 
end



function CalorieIcon( Actor,pn ) 
local cals = CalorieAward( pn ); 
Trace("cals: " .. cals);
        if cals < 250 then Actor:hidden(1) end 
        if cals >= 250 then Actor:setstate(12) end 
        if cals >= 750 then Actor:setstate(13) end 
        if cals >= 1500 then Actor:setstate(14) end 
        if cals >= 3000 then Actor:setstate(15) end 
end


function profilesongs( pn )
return "Played Songs:\n" .. PROFILEMAN:GetProfile(pn):GetTotalNumSongsPlayed()

end











function GetCreditsText()
	local song = GAMESTATE:GetCurrentSong()
	if not song then return "" end

	return 
		song:GetDisplayFullTitle().."\n"..
		song:GetDisplayArtist().."\n"..
		GetStepsDescriptionTextP1().."\n"..
		GetStepsDescriptionTextP2()
end




function vertexcolor()
	if GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove/VerTex') then return "diffusecolor,0,1,0,1" end
	if GAMESTATE:GetCurrentSong() and  GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove 2/VerTex²') then return "diffusecolor,1,0,0,1" end
	if GAMESTATE:GetCurrentSong() and  GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove 3/VerTex^3') then return "diffusecolor,1,0,1,1" end

	return ""
end

function songfail()
	if GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove/VerTex') then return false end
	if GAMESTATE:GetCurrentSong() and  GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove 2/VerTex²') then return false end
	if GAMESTATE:GetCurrentSong() and  GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove 3/VerTex^3') then return false end

	return true
end


function songfail2()
	if GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove/VerTex') then return true end
	if GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove 2/VerTex²') then return true end
	if GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove 3/VerTex^3') then return true end

	return false
end






function StopCourseEarly()
	-- Stop gameplay between songs in Fitess: Random Endless if all players have 
	-- completed their goals.
	if not GAMESTATE:GetEnv("Workout") then return "0" end
	if GAMESTATE:GetPlayMode() ~= PLAY_MODE_ENDLESS then return "0" end
	for pn = PLAYER_1,NUM_PLAYERS-1 do
		if GAMESTATE:IsPlayerEnabled(pn) and not GAMESTATE:IsGoalComplete(pn) then return "0" end
	end
	return "1"
end

--
-- Workout
--
function WorkoutResetStageStats()
	STATSMAN:Reset()
end

function WorkoutGetProfileGoalType( pn )
	return PROFILEMAN:GetProfile(pn):GetGoalType()
end

function WorkoutGetStageCalories( pn )
	return STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetCaloriesBurned()
end

function WorkoutGetTotalCalories( pn )
	return STATSMAN:GetAccumStageStats():GetPlayerStageStats(pn):GetCaloriesBurned()
end

function WorkoutGetTotalSeconds( pn )
	return STATSMAN:GetAccumStageStats():GetGameplaySeconds()
end

function WorkoutGetGoalCalories( pn )
	return PROFILEMAN:GetProfile(pn):GetGoalCalories()
end

function WorkoutGetGoalSeconds( pn )
	return PROFILEMAN:GetProfile(pn):GetGoalSeconds()
end

function WorkoutGetPercentCompleteCalories( pn )
	return WorkoutGetTotalCalories(pn) / WorkoutGetGoalCalories(pn)
end

function WorkoutGetPercentCompleteSeconds( pn )
	return WorkoutGetTotalSeconds(pn) / WorkoutGetGoalSeconds(pn)
end

--
-- Options
--
function RestoreDefaults( pn )
	if pn == PLAYER_2 then
		Trace( "skip RestoreDefaults" )
		return
	end

	Trace( "RestoreDefaults" )
	
	PREFSMAN:SetPreference( "ControllerMode", 0 )
	PREFSMAN:SetPreference( "TwoControllerDoubles", false )
	PREFSMAN:SetPreference( "SongsPerPlay", 3 )
	PREFSMAN:SetPreference( "EventMode", false )
	PREFSMAN:SetPreference( "LifeDifficultyScale", 1 )

	local Table = PROFILEMAN:GetMachineProfile():GetSaved()
	Table["DefaultSort"] = GetDefaultSort()
	Table["DefaultDifficulty"] = GetDefaultDifficulty()

	PREFSMAN:SetPreference( "BGBrightness", .4 )
	PREFSMAN:SetPreference( "GlobalOffsetSeconds", 0 )
	PREFSMAN:SetPreference( "Autosave", true )
end

-- Home unlock (stubs):
function GetUnlockCommand() return "playcommand,NoUnlock" end
function FinalizeUnlock() end

function GoodEnding()
local Path = THEME:GetPath( EC_SOUNDS, '', "ScreenTitleMenu ForceGoodEnding" )
	SOUND:PlayOnce( Path )
		GAMESTATE:SetEnv("ForceGoodEnding",1)
		MESSAGEMAN:Broadcast( "GoodEnding" )
end



function OkayEnding()
local Path = THEME:GetPath( EC_SOUNDS, '', "ScreenTitleMenu ForceGoodEnding" )
	SOUND:PlayOnce( Path )
		GAMESTATE:SetEnv("ForceOkayEnding",1)
		MESSAGEMAN:Broadcast( "GoodEnding" )
end








-- Arcade unlocks:
function Unlock( Title )
	local Code = UNLOCKMAN:FindCode( Title )
	if Code then
		UNLOCKMAN:UnlockCode( Code )
	end

	-- Set the song as preferred, even if it's no longer an unlock.
	NewHelpText = {}
	local s = SONGMAN:FindSong( Title )
	if not s then return "" end
	if s then
		GAMESTATE:SetPreferredSong( s )
		NewHelpText[1] = "Unlocked " .. s:GetDisplayFullTitle() .. "!"
	end

	-- Get a list of steps (not songs) we just unlocked, and send a message to display
	-- them in HelpText.
	if Code then
		local Songs, Steps = UNLOCKMAN:GetStepsUnlockedByCode( Code )
		for x in Songs do
			NewHelpText[x+1] = "Unlocked " .. Songs[x]:GetDisplayFullTitle() .. " " .. DifficultyToThemedString(Steps[x]) .. "!"
		end
	end

	-- Only set the HelpText if this is actually a locked song for this game.  Don't do
	-- it if it's an old unlock code from a previous game.  (Do show it if it was already
	-- unlocked, though, so people can re-enter a code to see which steps were unlocked.)
	if Code then
		if not s then GAMESTATE:SetEnv("UnlockName","Unknown Song") end
		GAMESTATE:SetEnv("UnlockName",s:GetDisplayFullTitle())
		MESSAGEMAN:Broadcast( "UnlockEntered" )
		
		
		
	end
	NewHelpText = nil

	-- The ITG2 menu music is much stronger than ITG1's, drowning out the unlock
	-- sounds.  Dim the music to 20% for 3 seconds while we play the unlock sound.
	-- This will stay dimmed briefly after the unlock sound plays.  That's OK; it
	-- helps emphasize the sound and prevents the music changes from being too busy.
	SOUND:DimMusic( 0.2, 5 )

	local Path = THEME:GetPath( EC_SOUNDS, '', "Unlocked " .. Title )
	local Bleep = THEME:GetPath( EC_SOUNDS, '', "bleep" )
	SOUND:PlayOnce( Bleep )
	SOUND:PlayOnce( Path )
	
	return s
	
end


function FullComboSplashSound( pn )
	local Path = THEME:GetPath( EC_SOUNDS, '', "FullCombo " .. pn )
	SOUND:PlayOnce( Path )
end



function SetDifficultyFrameFromSteps( Actor, pn )
	Trace( "SetDifficultyFrameFromSteps" )
	local steps = GAMESTATE:GetCurrentSteps( pn );
	if steps then 
		Actor:setstate(steps:GetDifficulty()) 
	end
end








function SetDifficultyFrameFromGameState( Actor, pn )
	Trace( "SetDifficultyFrameFromGameState" )
	local trail = GAMESTATE:GetCurrentTrail( pn );
	if trail then 
		Actor:setstate(trail:GetDifficulty()) 
	else
		SetDifficultyFrameFromSteps( Actor, pn )
	end
end

function SetFromSongTitleAndCourseTitle( actor )
	Trace( "SetFromSongTitleAndCourseTitle" )
	local song = GAMESTATE:GetCurrentSong();
	local course = GAMESTATE:GetCurrentCourse();
	local text = ""
	if song then
		text = song:GetDisplayFullTitle()
	end
	if course then
		text = course:GetDisplayFullTitle() .. " - " .. text;
	end

	actor:settext( text )
end

function SetRemovedText(self, port)
	local CurrentSong = GAMESTATE:GetCurrentSong()
	if CurrentSong and string.find( CurrentSong:GetDisplayFullTitle(), "Disconnected" ) then
		self:settext( "The controller in controller port " .. port .. " has been disconnected." )
		return
	end

	self:settext( "The controller in controller port " .. port .. " has been removed." )
end


function GetActual( stepsType )
	return 
		PROFILEMAN:GetMachineProfile():GetSongsActual(stepsType,DIFFICULTY_EASY)+
		PROFILEMAN:GetMachineProfile():GetSongsActual(stepsType,DIFFICULTY_MEDIUM)+
		PROFILEMAN:GetMachineProfile():GetSongsActual(stepsType,DIFFICULTY_HARD)+
		PROFILEMAN:GetMachineProfile():GetSongsActual(stepsType,DIFFICULTY_CHALLENGE)+
		PROFILEMAN:GetMachineProfile():GetCoursesActual(stepsType,COURSE_DIFFICULTY_REGULAR)+
		PROFILEMAN:GetMachineProfile():GetCoursesActual(stepsType,COURSE_DIFFICULTY_DIFFICULT)
end

function GetPossible( stepsType )
	return 
		PROFILEMAN:GetMachineProfile():GetSongsPossible(stepsType,DIFFICULTY_EASY)+
		PROFILEMAN:GetMachineProfile():GetSongsPossible(stepsType,DIFFICULTY_MEDIUM)+
		PROFILEMAN:GetMachineProfile():GetSongsPossible(stepsType,DIFFICULTY_HARD)+
		PROFILEMAN:GetMachineProfile():GetSongsPossible(stepsType,DIFFICULTY_CHALLENGE)+
		PROFILEMAN:GetMachineProfile():GetCoursesPossible(stepsType,COURSE_DIFFICULTY_REGULAR)+
		PROFILEMAN:GetMachineProfile():GetCoursesPossible(stepsType,COURSE_DIFFICULTY_DIFFICULT)
end

function GetTotalPercentComplete( stepsType )
	return GetActual(stepsType) / (0.96*GetPossible(stepsType))
end

function GetSongsPercentComplete( stepsType, difficulty )
	return PROFILEMAN:GetMachineProfile():GetSongsPercentComplete(stepsType,difficulty)/0.96
end

function GetCoursesPercentComplete( stepsType, difficulty )
	return PROFILEMAN:GetMachineProfile():GetCoursesPercentComplete(stepsType,difficulty)/0.96
end

function GetExtraCredit( stepsType )
	return GetActual(stepsType) - (0.96*GetPossible(stepsType))
end

function GetMaxPercentCompelte( stepsType )
	return 1/0.96;
end

-- This is overridden in the PS2 theme to set the options difficulty.
function GetInitialDifficulty()
	return "beginner"
end

function DifficultyChangingIsAvailable()
	return GAMESTATE:GetPlayMode() ~= PLAY_MODE_ENDLESS and GAMESTATE:GetPlayMode() ~= PLAY_MODE_ONI and GAMESTATE:GetSortOrder() ~= SORT_MODE_MENU
end

function ModeMenuAvailable()
	if GAMESTATE:IsCourseMode() then return false end
	--Trace( "here1" )
	if GAMESTATE:GetSortOrder() == SORT_MODE_MENU then return false end
	--Trace( "here2" )
	return true
end

function GetEditStepsText()
	local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
	if steps == nil then 
		return ""
	elseif steps:GetDifficulty() == DIFFICULTY_EDIT then 
		return steps:GetDescription()
	else 
		return DifficultyToThemedString(steps:GetDifficulty())
	end
end

function GetScreenSelectStyleDefaultChoice()
	if GAMESTATE:GetNumPlayersEnabled() == 1 then return "1" else return "2" end
end

-- Wag for ScreenSelectPlayMode scroll choice3.  This should use
-- EffectMagnitude, and not a hardcoded "5".
function TweenedWag(self)
	local time = self:GetSecsIntoEffect()
	local percent = time / 4
	local rx, ry, rz
	rx,ry,rz = self:getrotation()
	rz = rz + 5 * math.sin( percent * 2 * 3.141 ) * self:getaux()
	self:rotationz( rz )
end

-- For DifficultyMeterSurvival:
function SetColorFromMeterString( self )
	local meter = self:GetText()
	if meter == "?"  then return end

	local i = (meter+0);
	local cmd;
	if i <= 1 then cmd = "Beginner"
	elseif i <= 3 then cmd = "Easy"
	elseif i <= 6 then cmd = "Regular"
	elseif i <= 9 then cmd = "Difficult"
	else cmd = "Challenge"
	end
	
	self:playcommand( "Set" .. cmd .. "Course" )
end

function GetPaneX( player )
	if GAMESTATE:PlayerUsingBothSides() then
		return SCREEN_CENTER_X
	end
	
	if player == PLAYER_1 then
		return SCREEN_CENTER_X-152
	else
		return SCREEN_CENTER_X+152
	end
end

function EvalX()
	if not GAMESTATE:PlayerUsingBothSides() then return 0 end

	local Offset = 147
	if GAMESTATE:GetMasterPlayerNumber() == PLAYER_2 then Offset = Offset * -1 end
	return Offset;
end

function EvalTweenDistance()
	local Distance = SCREEN_WIDTH/2
	if GAMESTATE:PlayerUsingBothSides() then Distance = Distance * 2 end
	return Distance
end

-- used by BGA/ScreenEvaluation overlay
-- XXX: don't lowercase commands on parse
function ActorFrame:difficultyoffset()
	if not GAMESTATE:PlayerUsingBothSides() then return end

	local XOffset = 85
	if GAMESTATE:GetMasterPlayerNumber() == PLAYER_2 then XOffset = XOffset * -1 end
	self:addx( XOffset )
	self:addy( 0 )
end

function GameState:PlayerDifficulty( pn )
	if GAMESTATE:IsCourseMode() then
		local trail = GAMESTATE:GetCurrentTrail(pn)
		return trail:GetDifficulty()
	else
		local steps = GAMESTATE:GetCurrentSteps(pn)
		return steps:GetDifficulty()
	end
end



function GetRandomSongNames( num )
	local s = "";
	for i = 1,num do
		local song = SONGMAN:GetRandomSong();
		if song then s = s .. song:GetDisplayFullTitle() .. "\n" end
	end
	return s
end

function GetStepChartFacts()
	local s = "";
	s = s .. "In The Groove:\n"
	s = s .. "  142 easy\n"
	s = s .. "  142 medium\n"
	s = s .. "  142 hard\n"
	s = s .. "  111 expert\n"
	s = s .. "In The Groove 2:\n"
	s = s .. "  66 novice\n"
	s = s .. "  122 easy\n"
	s = s .. "  122 medium\n"
	s = s .. "  122 hard\n"
	s = s .. "  101 expert\n"
	s = s .. "In The Groove 3:\n"
	s = s .. "  84 novice\n"
	s = s .. "  168 easy\n"
	s = s .. "  168 medium\n"
	s = s .. "  168 hard\n"
	s = s .. "  168 expert\n"
	return s
end

function GetRandomCourseNames( num )
	local s = "";
	for i = 1,num do
		local course = SONGMAN:GetRandomCourse();
		if course then s = s .. course:GetDisplayFullTitle() .. "\n" end
	end
	return s
end

function GetModifierNames( num )
	local mods = {
		"x1","x1.5","x2","x2.5","x3","3.5x","x4","x5","x6","x8","c300","c450",
		"Incoming","Overhead","Space","Hallway","Distant",
		"Standard","Reverse","Split","Alternate","Cross","Centered",
		"Accel","Decel","Wave","Expand","Boomerang","Bumpy",
		"Dizzy","Drift","Mini","Flip","Invert","Tornado","Float","Beat",
		"Fade&nbsp;In","Fade&nbsp;Out","Blink","Invisible","Beat","Bumpy",
		"Mirror","Left","Right","Random","Blender",
		"No&nbsp;Jumps","No&nbsp;Holds","No&nbsp;Rolls","No&nbsp;Hands","No&nbsp;Quads","No&nbsp;Mines",
		"Simple","Stream","Wide","Quick","Skippy","Echo","Stomp",
		"Planted","Floored","Twister","Add&nbsp;Mines","No&nbsp;Stretch&nbsp;Jumps",
		"Hide&nbsp;Targets","Hide&nbsp;Judgment","Hide&nbsp;Background",
		"Metal","Cel","Flat","Robot","Vivid"
	}
	mods = tableshuffle( mods )
	local s = "";
	for i = 1,math.min(num,table.getn(mods)) do
		s = s .. mods[i] .. "\n"
	end
	return s
end

function OkX()
	if not GAMESTATE:PlayerUsingBothSides() then return 0 end

	local Offset = 200
	if GAMESTATE:GetMasterPlayerNumber() == PLAYER_2 then Offset = Offset * -1 end
	return Offset;
end


function GetStepsDescriptionTextP1()
	local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
	if steps == nil then
		return ""
	elseif steps:GetDifficulty() == DIFFICULTY_EDIT then
		return steps:GetDescription()
	else
		return steps:GetDescription()
	end
end


function GetStepsDescriptionTextP2()
	local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
	if steps == nil then
		return ""
	elseif steps:GetDifficulty() == DIFFICULTY_EDIT then
		return steps:GetDescription()
	else
		return steps:GetDescription()
	end
end


function GetSongTitle()
	local song = GAMESTATE:GetCurrentSong()
	if not song then return "" end

	return
		song:GetDisplayFullTitle()
end


function GetSongArtist()
	local song = GAMESTATE:GetCurrentSong()
	if not song then return "" end

	return
		song:GetDisplayArtist()
end


function GetCourseTitle()
	local course = GAMESTATE:GetCurrentCourse()
	if not course then return "" end

	return
		course:GetDisplayFullTitle()
end

function GetCourseDifficulty(pn)
	local trail = GAMESTATE:GetCurrentTrail(pn)
      
	if trail:GetDifficulty() == 2 then
		return "Normal"

	elseif trail:GetDifficulty() == 3 then
		return "Intense"

	else
		return "" end

end

function GetSongLength()
	local song = GAMESTATE:GetCurrentSong()
	if not song then return "" end
	return "Song Length: " .. SecondsToMMSS(song:MusicLengthSeconds())
	
end

function SHUTUPSERIOUSLY()
	Debug( "Screen width: " .. tostring(SCREEN_WIDTH) )
	Debug( "Screen height: " .. tostring(SCREEN_HEIGHT) )
	Debug( "Screen right: " .. tostring(SCREEN_RIGHT) )
	Debug( "Screen left: " .. tostring(SCREEN_LEFT) )
	Debug( "Screen top: " .. tostring(SCREEN_TOP) )
	Debug( "Screen bottom: " .. tostring(SCREEN_BOTTOM) )
	SOUND:DimMusic(0, 6)
end




function LifeDifficultylevel1()
	local val = PREFSMAN:GetPreference( "LifeDifficultyScale" )
	if val <= 1.7 then return true end
	return false 
end

function LifeDifficultylevel2()
	local val = PREFSMAN:GetPreference( "LifeDifficultyScale" )
	if val <= 1.5 then return true end
	return false 
end

function LifeDifficultylevel3()
	local val = PREFSMAN:GetPreference( "LifeDifficultyScale" )
	if val <= 1.3 then return true end
	return false 
end

function LifeDifficultylevel4()
	local val = PREFSMAN:GetPreference( "LifeDifficultyScale" )
	if val <= 1 then return true end
	return false 
end

function LifeDifficultylevel5()
	local val = PREFSMAN:GetPreference( "LifeDifficultyScale" )
	if val <= 0.9 then return true end
	return false 
end

function LifeDifficultylevel6()
	local val = PREFSMAN:GetPreference( "LifeDifficultyScale" )
	if val <= 0.7 then return true end
	return false 
end

function LifeDifficultylevel7()
	local val = PREFSMAN:GetPreference( "LifeDifficultyScale" )
	if val <= 0.5 then return true end
	return false 
end


function GameplayOverlay()
	local CurrentSong = GAMESTATE:GetCurrentSong()
	
	local dir = CurrentSong:GetSongDir()
	
	if string.find(dir,"/Dance Dance Revolution Extreme/") or string.find(dir,"8th Mix") then 
		return "_extreme"  end
	if  string.find( CurrentSong:GetDisplayFullTitle(), "VerTex" ) then
		return "_vertex" end
	if string.find( CurrentSong:GetDisplayFullTitle(), "Dream to Nightmare" ) then
		return "_nightmare" end
	if string.find( CurrentSong:GetDisplayFullTitle(), "Summer ~Speedy Mix~" ) then
		return "_smiley" end
	if string.find( CurrentSong:GetDisplayFullTitle(), "Pandemonium" ) then
		return "_pandy" end
	if string.find( CurrentSong:GetDisplayFullTitle(), "Pink Fuzzy Bunnies" ) then
		return "_bunnies" end
	if string.find( CurrentSong:GetDisplayFullTitle(), "Virtual Emotion" ) then
		return "_virtual" end
	if string.find( CurrentSong:GetDisplayFullTitle(), "Hasse Mich" ) then
		return "_hasse" end
	if string.find( CurrentSong:GetDisplayFullTitle(), "Energizer" ) then
		return "_energy" end
	if string.find( CurrentSong:GetDisplayFullTitle(), "Love Eternal" ) then
		return "_love" end
	if string.find( CurrentSong:GetDisplayFullTitle(), "Disconnected Hardkore" ) then
		return "_disconnect" end
	return "_normal"
end



function StepartistHiddenPress( actor )
local song = GAMESTATE:GetCurrentSong();
	if song then
	actor:stoptweening()
	actor:decelerate(.3)
	actor:y(SCREEN_BOTTOM-127)
	end

end


function StepartistHiddenSort( actor )
local song = GAMESTATE:GetCurrentSong();
	if not song then
	actor:stoptweening()
	actor:decelerate(.3)
	actor:y(SCREEN_BOTTOM-109)
	end

end





function P1Stepartist( actor )
	local song = GAMESTATE:GetCurrentSong();
	local course = GAMESTATE:GetCurrentCourse();
	local artist = GetStepsDescriptionTextP1();
	local result = ""
	if song then
		if artist == "" then
			result = "Stepartist: Unknown"
		else
			result = "Stepartist: " .. artist
		end
	else
	actor:playcommand("SelectMenuOffMessageCommand")
	
	end
	
	if course then
		result = ""
	end
	if string.find(artist, "C. Foy") or string.find(artist, "Foy") then
			actor:diffuseshift();
			actor:effectclock("bgm");
			actor:effectcolor1(1,.9,.9,1);
			actor:effectcolor2(1,.75,.75,1);
	else
	actor:stopeffect()
	end
	
	actor:settext( result )
end


function P2Stepartist( actor )
	local song = GAMESTATE:GetCurrentSong();
	local course = GAMESTATE:GetCurrentCourse();
	local artist = GetStepsDescriptionTextP2();
	local result = ""
	if song then
	actor:hidden(0)
		if artist == "" then
			result = "Stepartist: Unknown"
		else
			result = "Stepartist: "..artist
		end
		
	else
	actor:hidden(1)
	end
	if course then
		result = ""
	end
	if string.find(artist, "C. Foy") or string.find(artist, "Foy") then
			actor:diffuseshift();
			actor:effectclock("bgm");
			actor:effectcolor1(1,.9,.9,1);
			actor:effectcolor2(1,.75,.75,1);
	else
	actor:stopeffect()
	end
	
	actor:settext( result )
end

--
--str = str .. Values:GetValue( RADAR_CATEGORY_TAPS ) .. "\n"
--str = str .. Values:GetValue( RADAR_CATEGORY_HOLDS ) .. "\n"
--str = str ..  Values:GetValue( RADAR_CATEGORY_JUMPS ) .. "\n"
--str = str .. Values:GetValue( RADAR_CATEGORY_MINES ) .. "\n"
--str = str ..  Values:GetValue( RADAR_CATEGORY_HANDS ) .. "\n"
--str = str ..  Values:GetValue( RADAR_CATEGORY_ROLLS ) .. "\n"
--


function Radar( Values, Cat )
if not Values then return "" end
local str = ""

local CategoryDef = {
RADAR_CATEGORY_JUMPS,
RADAR_CATEGORY_HOLDS,
RADAR_CATEGORY_MINES,
RADAR_CATEGORY_HANDS,
RADAR_CATEGORY_ROLLS,
RADAR_CATEGORY_TAPS,
}

str = string.format("%03d", Values:GetValue( CategoryDef[Cat] ) )

return str

end





function ColorRadar( player, Cat )
if not player then return "" end

local val = ""

local CategoryDef = {
RADAR_CATEGORY_JUMPS,
RADAR_CATEGORY_HOLDS,
RADAR_CATEGORY_MINES,
RADAR_CATEGORY_HANDS,
RADAR_CATEGORY_ROLLS,
RADAR_CATEGORY_TAPS
}

local Selection = GAMESTATE:GetCurrentSteps( player ) or GAMESTATE:GetCurrentTrail( player )

val = Selection:GetRadarValues():GetValue( CategoryDef[1] )

if val <= 20 then return "diffuse,#FF0000" end
if val < 20 then return "diffuse,#FFFF00" end
return "diffuse,#FFFF00"
end

function DemoName()
	local song = GAMESTATE:GetCurrentSong()
	if not song then return "" end

	return 
		"Now playing:\n" ..song:GetDisplayFullTitle().."\nby "..
		song:GetDisplayArtist()
end

function HideOnDoubles()
if GAMESTATE:PlayerUsingBothSides() then return "hidden,1;" end
return ""
end

function DoublesScoreCenterP1()
if GAMESTATE:PlayerUsingBothSides() or CustomMods[PLAYER_1].solo == true then return "addx,SCREEN_WIDTH/4;" end
return ""
end

function DoublesScoreCenterP2()
if GAMESTATE:PlayerUsingBothSides() or CustomMods[PLAYER_2].solo == true then return "addx,-SCREEN_WIDTH/4-8;" end
return ""
end


function PlayerFullCombo(pn, combotype)	
if pn == PLAYER_1 then MESSAGEMAN:Broadcast( "Player1FullCombo" .. combotype ) end
if pn == PLAYER_2 then MESSAGEMAN:Broadcast( "Player2FullCombo" .. combotype ) end
end
	
function GetRateModHelper( rate )
   return GAMESTATE:PlayerIsUsingModifier(0, rate) or GAMESTATE:PlayerIsUsingModifier(1, rate)
end

function GetRateMod()
   if GetRateModHelper('1.0xmusic') then return ''
   elseif GetRateModHelper('1.1xmusic') then return '1.1x Rate' 
   elseif GetRateModHelper('1.2xmusic') then return '1.2x Rate' 
   elseif GetRateModHelper('1.3xmusic') then return '1.3x Rate' 
   elseif GetRateModHelper('1.4xmusic') then return '1.4x Rate' 
   elseif GetRateModHelper('1.5xmusic') then return '1.5x Rate' 
   elseif GetRateModHelper('1.6xmusic') then return '1.6x Rate' 
   elseif GetRateModHelper('1.7xmusic') then return '1.7x Rate' 
   elseif GetRateModHelper('1.8xmusic') then return '1.8x Rate' 
   elseif GetRateModHelper('1.9xmusic') then return '1.9x Rate' 
   elseif GetRateModHelper('2.0xmusic') then return '2.0x Rate' 
   else return '(Unknown rate mod)' end
end	
	
	
function DisplayCustomModifiersFrame(pn)

end	
	
function DisplayCustomModifiersText(pn)	--gives me text of all custom modifiers that are applied (and rate mods)
local t = ""

if CustomMods[pn].left then if t == "" then t = "Rotated Left" else t = t .. ", Rotated Left" end end
if CustomMods[pn].right then if t == "" then t = "Rotated Right" else t = t .. ", Rotated Right" end end
if CustomMods[pn].downward then if t == "" then t = "Rotated Downward" else t = t .. ", Rotated Downward" end end
if CustomMods[pn].solo then if t == "" then t = "Centered" else t = t .. ", Centered" end end

if CustomMods[pn].wag then if t == "" then t = "Wag" else t = t .. ", Wag" end 
elseif CustomMods[pn].pulse then if t == "" then t = "Pulse" else t = t .. ", Pulse" end 
elseif CustomMods[pn].bounce then if t == "" then t = "Bounce" else t = t .. ", Bounce" end 
elseif CustomMods[pn].spinreverse then if t == "" then t = "Spin Left" else t = t .. ", Spin Right" end 
elseif CustomMods[pn].spin then if t == "" then t = "Spin Right" else t = t .. ", Spin Right" end 
elseif CustomMods[pn].vibrate then if t == "" then t = "Vibrate" else t = t .. ", Vibrate" end end

if CustomMods[pn].dark == 0.5 then if t == "" then t = "Dark Filter" else t = t .. ", Dark Filter" end end
if CustomMods[pn].dark == 0.65 then if t == "" then t = "Darker Filter" else t = t .. ", Darker Filter" end end
if CustomMods[pn].dark == 0.85 then if t == "" then t = "Darkest Filter" else t = t .. ", Darkest Filter" end end

if GetRateMod() ~= '' then if t == "" then t = GetRateMod() else t = t .. ", " .. GetRateMod() end end

return t

end

 function OffsetDoublesModifiers(pn)
	if GAMESTATE:PlayerUsingBothSides() then
		if pn == PLAYER_1 then return "addx,-70"
		else return "addx,70" end	
	else return "" end
end


function OffsetLifebarHeight(pn)
	if CustomMods[pn].left or CustomMods[pn].right then return "SCREEN_CENTER_Y"
	else return "SCREEN_CENTER_Y+30" end
end
	

function PercentageTween(self, wait, tweentype, size, startvalue, endvalue, animation, duration)
--wait is sleep applied before animating, 
--tweentype is either zoom or cropping with direction
--size is the largest possible number that can fit in the area (ie, max value is 100, so a value of 100 would be 'full'),
--start and end are the current values to tween between placed in the container size (if 65 and 70, with a size of 100, it would start by showing 65% and tween to 70%)
--animation is the type of tweening,
--duration is time to complete the animation.	
--usage: PercentageTween(1, right, 100, 30, 60, decelerate, 5)

local startpercent=startvalue/size
local endpercent=endvalue/size

--cropping gets start and end switched since the less you crop, the more you see
	if string.find(tweentype,"crop") then

		if tweentype == 'cropright' then
			self:cropright(1-startpercent) 
			self:sleep(wait)
			self:decelerate(duration)
			self:cropright(1-endpercent)
		end
	
	
	end

end
	
function PercentageTween2(self, wait, tweentype, size, startvalue, endvalue, animation, duration)
--wait is sleep applied before animating, 
--tweentype is either zoom or cropping with direction
--size is the largest possible number that can fit in the area (ie, max value is 100, so a value of 100 would be 'full'),
--start and end are the current values to tween between placed in the container size (if 65 and 70, with a size of 100, it would start by showing 65% and tween to 70%)
--animation is the type of tweening,
--duration is time to complete the animation.	
--usage: PercentageTween(1, right, 100, 30, 60, decelerate, 5)

local startpercent=startvalue/size
local endpercent=endvalue/size

--cropping gets start and end switched since the less you crop, the more you see
	if string.find(tweentype,"crop") then

		if tweentype == 'cropright' then
			self:cropright(1-startpercent) 
			self:sleep(wait)
			self:decelerate(duration)
			self:cropright(1-endpercent)
		end
	
	
	end

end
	

