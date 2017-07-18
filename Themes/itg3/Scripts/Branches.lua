function GetArcadeStartScreen()
	-- If we havn't loaded the input driver, do that first; until this finishes, we have
	-- no input or lights.
	if GetInputType() == "" then return "ScreenArcadeStart" end

	if not PROFILEMAN:GetMachineProfile():GetSaved().TimeIsSet then
		return "ScreenSetTime"
	end

	return "ScreenCompany"
end
function ScreenTitleBranch()
	ScreenSelectMusicTimer = GetMusicSelectTime();
	ScreenPlayerOptionsTimer = GetOptionsSelectTime();
	if GAMESTATE:GetCoinMode() == COIN_MODE_HOME then return "ScreenTitleMenu" end
	if GAMESTATE:IsEventMode() then return "ScreenEventMenu" end
	return TitleScreen();
end

function GetDiagnosticsScreen()
	return "ScreenArcadeDiagnostics"
end

function GetUpdateScreen()
	return "ScreenArcadePatch"
end

function EvaluationNextScreen()
	Trace( "GetGameplayNextScreen: " )
	Trace( " AllFailed = "..tostring(AllFailed()) )
	Trace( " IsEventMode = "..tostring(GAMESTATE:IsEventMode()) )
	Trace( " IsFinalStage = "..tostring(IsFinalStage()) )
	if GAMESTATE:IsEventMode() then return NewSongScreen() end
	if AllFailed() then return "ScreenNameEntryTraditional" end
	return NewSongScreen();
end

function ScreenCleaning()
	if GetCleanScreen() == true then
		if Hour() >= GetCleanStartTime() and Hour() < GetCleanEndTime() then
		return "ScreenNoise" end
	end
	return "ScreenCompany"
end

function GetGameplayNextScreen()
	Trace( "GetGameplayNextScreen: " )
	Trace( " AllFailed = "..tostring(AllFailed()) )
	Trace( " IsEventMode = "..tostring(GAMESTATE:IsEventMode()) )
	Trace( " IsSyncDataChanged = "..tostring(GAMESTATE:IsSyncDataChanged()) )

	if GAMESTATE:IsSyncDataChanged() then 
		return "ScreenSaveSync"
	end
		
	-- Never show evaluation for training.
	if GAMESTATE:GetCurrentSong():GetSongDir() == "Songs/In The Groove/Training1/" then 
		if GAMESTATE:IsEventMode() then 
			return NewSongScreen()
		else
			return EvaluationNextScreen()
		end
	elseif AllFailed() and not GAMESTATE:IsCourseMode() then 
		if GAMESTATE:IsEventMode() then 
			return SelectEvaluationScreen()
		else
			return SelectEvaluationScreen()
		end
	else 
		return SelectEvaluationScreen() 
	end
	
	return "GetGameplayNextScreen: YOU SHOULD NEVER GET HERE"
end

function SelectEndingScreen()
	if GAMESTATE:GetEnv("ForcePerfectEnding") == "1" or GetBestFinalGrade() <= GRADE_TIER01 then
	return "ScreenEndingPerfect"
	elseif GAMESTATE:GetEnv("ForceGoodEnding") == "1" or GetBestFinalGrade() <= GRADE_TIER04 then
	return "ScreenEndingGood"
	elseif GAMESTATE:GetEnv("ForceOkayEnding") == "1" or GetBestFinalGrade() <= GRADE_TIER07 then
	return "ScreenEndingOkay"
	else
	return "ScreenEndingNormal"
	end
end

function ScreenAfterGameplayWorkout()
	if GAMESTATE:GetPlayMode() == PLAY_MODE_NONSTOP then return "ScreenEvaluationNonstopWorkout" end
	if GAMESTATE:GetPlayMode() == PLAY_MODE_ENDLESS then return "ScreenEvaluationNonstopWorkout" end
	return "ScreenEvaluationStageWorkout"
end

function GetScreenEvaluationNonstopWorkoutNextScreen()
	if GAMESTATE:GetPlayMode() == PLAY_MODE_ENDLESS then return "ScreenWorkoutMenu" end
	return "ScreenSelectMusicCourse"
end

function GetGameplayScreen()
	local Song = GAMESTATE:GetCurrentSong();
	if Song and Song:GetSongDir() == "Songs/In The Groove/Training1/" then
		return "ScreenGameplayTraining"
	end

	return "ScreenGameplay"
end

function SongSelectionScreen()
	local s = "ScreenSelectMusic";
	if GAMESTATE:IsCourseMode() then s = s.."Course" end
	if IsNetSMOnline() then return SMOnlineScreen() end
	if IsNetConnected() then return "ScreenNetSelectMusic" end
	return s
end

function SMOnlineScreen()
	if not IsSMOnlineLoggedIn(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_1) then return "ScreenSMOnlineLogin" end
	if not IsSMOnlineLoggedIn(PLAYER_2) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then return "ScreenSMOnlineLogin" end
	return "ScreenNetRoom"
end	



function NewSongScreen()
	local s = "ScreenSelectMusic2";
	if GAMESTATE:IsCourseMode() then s = s.."Course" end
	return s
end


function ScreenSelectMusicPrevScreen()
	if GAMESTATE:GetEnv("Workout") then return "ScreenWorkoutMenu" end
	return ScreenTitleBranch()
end

function TitleScreen()
	if DayOfMonth() == 1 and MonthOfYear() == 4 then return "ScreenTitleAlt" end
return "ScreenTitleJoin"
end

function OptionsMenuAvailable()
	if GAMESTATE:GetPlayMode()==PLAY_MODE_ONI then return false end
	return true
end

function GetSetTimeNextScreen()
	-- This is called only when we move to the next screen, so we only mark the time set
	-- when the screen is cleared.  That way, if the game is started by the operator and
	-- powered down before setting the screen, we still go to ScreenSetTime on the next boot.
	PROFILEMAN:GetMachineProfile():GetSaved().TimeIsSet = true
	PROFILEMAN:SaveMachineProfile()

	return "ScreenOptionsMenu"
end

function GetDiagnosticsScreen()
	return "ScreenArcadeDiagnostics"
end

function GetUpdateScreen()
	return "ScreenArcadePatch"
end

function GetRevision()
	return "ITG3:RL1.1"
end

function GetLoadingDevice()
	return "Loading Device Info ..."
end

function GetInputDeviceNamePad()
	return "PIU I/O Control Device Manager [Input Control]"
end

function GetInputDeviceNameLights()
	return "PIU I/O Control Device Manager [Lights Control]"
end

function GetManufacturerCompany()
	return "Andamiro Corporation Inc."
end

function GetFirewireNumber()
	return "Firmware Version #0368V785H547"
end

function GetPluggedPort()
	return "Plugged In On USB Port <-- 1.4.4 -->"
end

function GetCheckingText()
	return "Checking For Errors ..."
end

function GetCkeckTextDone()
	return "No Errors!"
end

function GetWorkingText()
	return "Status: Working at +2.8V ~ +5V OUT [Normal Parameter]"
end