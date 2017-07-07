function GetCustomSongCancelText()
	Debug( "GetCustomSongCancelText" )

	-- Set up two initial line spaces.
	local ret = "\n\n"

	if SelectButtonAvailable() then
		ret = ret .. "Pressing &SELECT; will cancel this selection."
		return ret
	else
		ret = ret .. "Pressing &MENULEFT; + &MENURIGHT; will cancel this selection."
		return ret
	end

	return "???"
end

function CreditTypeRow()
	local Names = { "Coins", "Tokens", "Swipe Card" }

	local type = PROFILEMAN:GetMachineProfile():GetSaved().CreditType

	-- called on construction, must set exactly one list member true
	local function Load(self, list, pn)
		-- short-circuit to 'coin' if no option is set
		if not type then list[1] = true return end

		-- do any of the options match the given type?
		for i=1,3 do
			if type == string.lower(Names[i]) then list[i] = true return end
		end

		-- none of the above worked. fallback on coin
		list[1] = true
	end

	-- called as the screen destructs, to save the selected option in list
	local function Save(self, list, pn)
		for i=1,3 do
			if list[i] then
				PROFILEMAN:GetMachineProfile():GetSaved().CreditType = string.lower(Names[i])
				PROFILEMAN:SaveMachineProfile()
				return
			end
		end
	end

	
	local Params = { Name = "CreditType" }

	return CreateOptionRow( Params, Names, Load, Save )
end

--put in some settings that allow you to bump in the lifebars on certain widescreen setups
function LifebarAdjustmentRow()
	local Names = { "0", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50" }

	local type = PROFILEMAN:GetMachineProfile():GetSaved().LifebarAdjustment
	
	local function Load(self, list, pn)
		if not type then list[1] = true return end

		for i=1,11 do
			if type == string.lower(Names[i]) then list[i] = true return end
		end

		list[1] = true
	end

	local function Save(self, list, pn)
		for i=1,11 do
			if list[i] then
				PROFILEMAN:GetMachineProfile():GetSaved().LifebarAdjustment = string.lower(Names[i])
				PROFILEMAN:SaveMachineProfile()
				return
			end
		end
	end

	
	local Params = { Name = "LifebarAdjustment" }

	return CreateOptionRow( Params, Names, Load, Save )
end

-- To be called wherever the LUA needs split
function GetCreditType()
	local type = PROFILEMAN:GetMachineProfile():GetSaved().CreditType
	-- assume "coin" unless otherwise specified
	if not type then return "INSERT COIN" end
	if type == "tokens" then return "INSERT TOKEN"
	elseif type == "swipe card" then return "SWIPE CARD"
	else return "INSERT COIN" end
	return type
end

-- To be called wherever the lifebars are positioned
function GetLifebarAdjustment()
	local type = PROFILEMAN:GetMachineProfile():GetSaved().LifebarAdjustment
	-- assume "0" unless otherwise specified
	if not type then return "0" end
	return type
end


function CleanScreen()
	local Names = { "Disabled", "Enabled" }

	local type = PROFILEMAN:GetMachineProfile():GetSaved().CleanScreen

	-- called on construction, must set exactly one list member true
	local function Load(self, list, pn)
		-- short-circuit to 'disabled' if no option is set
		if not type then list[1] = true return end

		-- do any of the options match the given type?
		for i=1,2 do
			if type == string.lower(Names[i]) then list[i] = true return end
		end

		-- none of the above worked. fallback on disabled
		list[1] = true
	end

	-- called as the screen destructs, to save the selected option in list
	local function Save(self, list, pn)
		for i=1,2 do
			if list[i] then
				PROFILEMAN:GetMachineProfile():GetSaved().CleanScreen = string.lower(Names[i])
				PROFILEMAN:SaveMachineProfile()
				return
			end
		end
	end

	
	local Params = { Name = "CleanScreen" }

	return CreateOptionRow( Params, Names, Load, Save )
end

function GetCleanScreen()
	local type = PROFILEMAN:GetMachineProfile():GetSaved().CleanScreen

	if type == "enabled" then
	return true else 
	return false
	end
end

function CleanStartTime()
	local type = PROFILEMAN:GetMachineProfile():GetSaved().CleanStartTime

	local Values = {}
	for i = 0,46 do Values[i+1] = i/2 end

	local Names = {}
	for i = 1,46 do Names[i] = SecondsToMMSS(Values[i]*60) end

	-- called on construction, must set exactly one list member true
	local function Load(self, list, pn)
		-- short-circuit to '0.00' if no option is set
		if not type then list[1] = true return end

		-- do any of the options match the given type?
		for i=1,46 do
			if type == Values[i] then list[i] = true return end
		end

		-- none of the above worked. fallback on 0:00
		list[1] = true
	end

	local function Save(self, list, pn)
		for i=1,47 do
			if list[i] then
				PROFILEMAN:GetMachineProfile():GetSaved().CleanStartTime = Values[i]
				PROFILEMAN:SaveMachineProfile()
				return
			end
		end
	end

	
	local Params = { Name = "CleanStartTime" }

	return CreateOptionRow( Params, Names, Load, Save )
end

function GetCleanStartTime()
	local type = PROFILEMAN:GetMachineProfile():GetSaved().CleanStartTime
	
	if not type then
	return 0 else
	return tonumber(PROFILEMAN:GetMachineProfile():GetSaved().CleanStartTime)
	end
end

function CleanEndTime()
	local type = PROFILEMAN:GetMachineProfile():GetSaved().CleanEndTime

	local Values = {}
	for i = 1,46 do Values[i] = i/2 + 0.5 end
	Values[47] = 23.99

	local Names = {}
	for i = 1,47 do Names[i] = SecondsToMMSS(Values[i]*60) end
	Names[47] = SecondsToMMSS(24*60)

	-- called on construction, must set exactly one list member true
	local function Load(self, list, pn)
		-- short-circuit to '23:59' if no option is set
		if not type then list[47] = true return end

		-- do any of the options match the given type?
		for i=1,47 do
			if type == Values[i] then list[i] = true return end
		end

		-- none of the above worked. fallback on 23:59
		list[47] = true
	end

	local function Save(self, list, pn)
		for i=1,47 do
			if list[i] then
				PROFILEMAN:GetMachineProfile():GetSaved().CleanEndTime = Values[i]
				PROFILEMAN:SaveMachineProfile()
				return
			end
		end
	end

	local Params = { Name = "CleanEndTime" }

	return CreateOptionRow( Params, Names, Load, Save )
end

function GetCleanEndTime()
	local type = PROFILEMAN:GetMachineProfile():GetSaved().CleanEndTime
	
	if not type then
	return 24 else
	return tonumber(PROFILEMAN:GetMachineProfile():GetSaved().CleanEndTime)
	end
end

function MusicSelectTime()
	-- start with 60, go to 240, increment by 15
	local Values = {}
	for i = 1,13 do Values[i] = (60+(i-1)*15) end

	local Names = {}
	for i = 1,13 do Names[i] = Values[i] end

	local type = PROFILEMAN:GetMachineProfile():GetSaved().MusicSelectTime
	
	local function Load(self, list, pn)
		if not type then list[1] = true return end

		for i=1,13 do
			if type == string.lower(Names[i]) then list[i] = true return end
		end

		list[1] = true
	end

	local function Save(self, list, pn)
		for i=1,13 do
			if list[i] then
				PROFILEMAN:GetMachineProfile():GetSaved().MusicSelectTime = string.lower(Names[i])
				PROFILEMAN:SaveMachineProfile()
				return
			end
		end
	end

	
	local Params = { Name = "MusicSelectTime" }

	return CreateOptionRow( Params, Names, Load, Save )
end

function GetMusicSelectTime()
	local type = PROFILEMAN:GetMachineProfile():GetSaved().MusicSelectTime
	
	if not type then
	return 60 else
	-- return the time with a half-second extra as a buffer while the screen loads
	return tonumber(PROFILEMAN:GetMachineProfile():GetSaved().MusicSelectTime)+0.5
	end
end

function OptionsSelectTime()
	-- start with 40, go to 90, increment by 5
	local Values = {}
	for i = 1,13 do Values[i] = (30+(i-1)*5) end

	local Names = {}
	for i = 1,13 do Names[i] = Values[i] end

	local type = PROFILEMAN:GetMachineProfile():GetSaved().OptionsSelectTime
	
	local function Load(self, list, pn)
		if not type then list[1] = true return end

		for i=1,13 do
			if type == string.lower(Names[i]) then list[i] = true return end
		end

		list[1] = true
	end

	local function Save(self, list, pn)
		for i=1,13 do
			if list[i] then
				PROFILEMAN:GetMachineProfile():GetSaved().OptionsSelectTime = string.lower(Names[i])
				PROFILEMAN:SaveMachineProfile()
				return
			end
		end
	end

	
	local Params = { Name = "OptionsSelectTime" }

	return CreateOptionRow( Params, Names, Load, Save )
end

function GetOptionsSelectTime()
	local type = PROFILEMAN:GetMachineProfile():GetSaved().OptionsSelectTime
	
	if not type then
	return 40 else
	-- return the time with a half-second extra as a buffer while the screen loads
	return tonumber(PROFILEMAN:GetMachineProfile():GetSaved().OptionsSelectTime)+0.5
	end
end


function EvaluationScreenTime()
	-- start with 30, go to 60, increment by 5
	local Values = {}
	for i = 1,13 do Values[i] = (30+(i-1)*5) end

	local Names = {}
	for i = 1,13 do Names[i] = Values[i] end

	local type = PROFILEMAN:GetMachineProfile():GetSaved().EvaluationScreenTime
	
	local function Load(self, list, pn)
		if not type then list[1] = true return end

		for i=1,13 do
			if type == string.lower(Names[i]) then list[i] = true return end
		end

		list[1] = true
	end

	local function Save(self, list, pn)
		for i=1,13 do
			if list[i] then
				PROFILEMAN:GetMachineProfile():GetSaved().EvaluationScreenTime = string.lower(Names[i])
				PROFILEMAN:SaveMachineProfile()
				return
			end
		end
	end

	
	local Params = { Name = "EvaluationScreenTime" }

	return CreateOptionRow( Params, Names, Load, Save )
end

function GetEvaluationScreenTime()
	local type = PROFILEMAN:GetMachineProfile():GetSaved().EvaluationScreenTime
	
	if not type then
	return 30 else
	-- return the time with a half-second extra as a buffer while the screen loads
	return tonumber(PROFILEMAN:GetMachineProfile():GetSaved().EvaluationScreenTime)+0.5
	end
end

function GlobalOffset()
	-- start with -0.030, go to 0.00, increment by 0.001
	local Values = {}
	for i = 1,31 do Values[i] = (-0.030+(i-1)*0.001) end

	local Names = {}
	for i = 1,31 do Names[i] = Values[i] end

	local type = PROFILEMAN:GetMachineProfile():GetSaved().GlobalOffset
	
	local function Load(self, list, pn)
		if not type then list[18] = true return end

		for i=1,31 do
			if type == string.lower(Names[i]) then list[i] = true return end
		end

		list[1] = true
	end

	local function Save(self, list, pn)
		for i=1,31 do
			if list[i] then
				PROFILEMAN:GetMachineProfile():GetSaved().GlobalOffset = string.lower(Names[i])
				PROFILEMAN:SaveMachineProfile()
				return
			end
		end
	end

	
	local Params = { Name = "GlobalOffset" }

	return CreateOptionRow( Params, Names, Load, Save )
end

function GetGlobalOffset()
	local type = PROFILEMAN:GetMachineProfile():GetSaved().GlobalOffset
	
	if not type then
	return -0.012 else
	return tonumber(PROFILEMAN:GetMachineProfile():GetSaved().GlobalOffset)
	end
end

function JudgePaddingToggleRow()
	local Names = { "Disabled", "Enabled" }

	local type = PROFILEMAN:GetMachineProfile():GetSaved().JudgePaddingToggle

	-- called on construction, must set exactly one list member true
	local function Load(self, list, pn)
		-- short-circuit to 'disabled' if no option is set
		if not type then list[1] = true return end

		-- do any of the options match the given type?
		for i=1,2 do
			if type == string.lower(Names[i]) then list[i] = true return end
		end

		-- none of the above worked. fallback on standard
		list[1] = true
	end

	-- called as the screen destructs, to save the selected option in list
	local function Save(self, list, pn)
		for i=1,2 do
			if list[i] then
				PROFILEMAN:GetMachineProfile():GetSaved().JudgePaddingToggle = string.lower(Names[i])
				PROFILEMAN:SaveMachineProfile()
				return
			end
		end
	end

	
	local Params = { Name = "JudgePadding" }

	return CreateOptionRow( Params, Names, Load, Save )
end

function GetJudgePadding()
	local type = PROFILEMAN:GetMachineProfile():GetSaved().JudgePaddingToggle
		
	if type == "enabled" then
	return "0.0015" else
	return "0"
	end
end

function FailTypeOptions()
	local Names = { "End of Song", "Immediately" , "Off" }

	local type = PROFILEMAN:GetMachineProfile():GetSaved().FailType

	-- called on construction, must set exactly one list member true
	local function Load(self, list, pn)
		-- short-circuit to 'End of Song' if no option is set
		if not type then list[1] = true return end

		-- do any of the options match the given type?
		for i=1,3 do
			if type == Names[i] then list[i] = true return end
		end

		-- none of the above worked. fallback on 'End of Song'
		list[1] = true
	end

	-- called as the screen destructs, to save the selected option in list
	local function Save(self, list, pn)
		for i=1,3 do
			if list[i] then
				PROFILEMAN:GetMachineProfile():GetSaved().FailType = Names[i]
				PROFILEMAN:SaveMachineProfile()
				return
			end
		end
	end

	
	local Params = { Name = "FailType" }

	return CreateOptionRow( Params, Names, Load, Save )
end

function GetFailType()
	local type = PROFILEMAN:GetMachineProfile():GetSaved().FailType
	-- assume "End of Song" unless otherwise specified
	if not type then return "FailEndOfSong" end
	-- always turn fail "Off" for the first song regardless of the Fail Type set in the menu.
	if GAMESTATE:StageIndex() == 0 and type ~= "Off" then return "FailOff" end
	if type == "Immediately" then return "FailImmediate"
	elseif type == "Off" then return "FailOff"
	else return "FailEndOfSong" end
end

function Get2PlayerJoinMessage()
	if not GAMESTATE:PlayersCanJoin() then return "" end
	if GAMESTATE:GetCoinMode()==COIN_MODE_FREE then return "2 Player mode available" end
	
	local numSidesNotJoined = NUM_PLAYERS - GAMESTATE:GetNumSidesJoined()
	if GAMESTATE:GetPremium() == PREMIUM_JOINT then numSidesNotJoined = numSidesNotJoined - 1 end	
	local coinsRequiredToJoinRest = numSidesNotJoined * PREFSMAN:GetPreference("CoinsPerCredit")
	local remaining = coinsRequiredToJoinRest - GAMESTATE:GetCoins();
	local type = PROFILEMAN:GetMachineProfile():GetSaved().CreditType
	
	if remaining <= 0 then return "2 Player mode available" end
	
	if type == "tokens" then
	local s = "For 2 Players, insert " .. remaining .. " more token(s)"
	if remaining > 1 then s = s.."s" end		
	return s	
	end
	
	
	if type == "swipe card" then
		local s = "For 2 Players, swipe a card with credits"	
			return s
	end
	
	if type ~= "swipe card" and type ~= "tokens" then
	local s = "For 2 Players, insert " .. remaining .. " more coin(s)"
	if remaining > 1 then s = s.."s" end
		return s
	end
end

function OptionsListToggleRow()
	local Names = { "Disabled", "Enabled" }

	local type = PROFILEMAN:GetMachineProfile():GetSaved().OptionsListToggle

	-- called on construction, must set exactly one list member true
	local function Load(self, list, pn)
		-- short-circuit to 'disabled' if no option is set
		if not type then list[1] = true return end

		-- do any of the options match the given type?
		for i=1,2 do
			if type == string.lower(Names[i]) then list[i] = true return end
		end

		-- none of the above worked. fallback on standard
		list[1] = true
	end

	-- called as the screen destructs, to save the selected option in list
	local function Save(self, list, pn)
		for i=1,2 do
			if list[i] then
				PROFILEMAN:GetMachineProfile():GetSaved().OptionsListToggle = string.lower(Names[i])
				PROFILEMAN:SaveMachineProfile()
				return
			end
		end
	end

	
	local Params = { Name = "OptionsListToggle" }

	return CreateOptionRow( Params, Names, Load, Save )
end

function GetOptionsList()
	local type = PROFILEMAN:GetMachineProfile():GetSaved().OptionsListToggle
		
	if type == "enabled" and GAMESTATE:GetPlayMode() ~= PLAY_MODE_ONI then
	return "1" else
	return "0"
	end
end

function ScoreComparisonToggleRow()
	local Names = { "Off", "On" }

	local type = PROFILEMAN:GetMachineProfile():GetSaved().ScoreComparisonToggle

	-- called on construction, must set exactly one list member true
	local function Load(self, list, pn)
		-- short-circuit to 'off' if no option is set
		if not type then list[2] = true return end

		-- do any of the options match the given type?
		for i=1,2 do
			if type == string.lower(Names[i]) then list[i] = true return end
		end

		-- none of the above worked. fallback on off
		list[1] = true
	end

	-- called as the screen destructs, to save the selected option in list
	local function Save(self, list, pn)
		for i=1,2 do
			if list[i] then
				PROFILEMAN:GetMachineProfile():GetSaved().ScoreComparisonToggle = string.lower(Names[i])
				PROFILEMAN:SaveMachineProfile()
				return
			end
		end
	end

	
	local Params = { Name = "ScoreComparisonToggle" }

	return CreateOptionRow( Params, Names, Load, Save )
end

function CompareScores()
	Debug( "CompareScores" )
	-- This is hardcoded...it's just re-enforced to save time.
        for pn = PLAYER_1,NUM_PLAYERS-1 do
		if not GAMESTATE:IsPlayerEnabled(pn) then return "0" end
	end

	-- Only compare scores if Enabled through the Options Menu and if Both Players have the Same Steps.
	if GetScoreComparison() == "0" then return "0" end

	if GAMESTATE:IsCourseMode() then
		local TrailP1 = GAMESTATE:GetCurrentTrail( PLAYER_1 );
		local TrailP2 = GAMESTATE:GetCurrentTrail( PLAYER_2 );
		if TrailP1 ~= TrailP2 then return "0" end
	else
		local StepsP1 = GAMESTATE:GetCurrentSteps( PLAYER_1 );
		local StepsP2 = GAMESTATE:GetCurrentSteps( PLAYER_2 );
		if StepsP1 ~= StepsP2 then return "0" end
	end

	Debug( "Returning true" )

	return "1"
end

function GetScoreComparison()
	local type = PROFILEMAN:GetMachineProfile():GetSaved().ScoreComparisonToggle
		
	if type == "off" then
	return "0" else
	return "1"
	end
end