-- vyhd wrote this, lightning broke it and made it less optimized

local function GetTapScore(pn, category)
	local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
	return pss:GetTapNoteScores(category)
end

local function GetHoldScore(pn, category)
	local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
	return pss:GetHoldNoteScores(category)
end

local function SetValueForChild( self, name, value )
	local child = self:GetChild(name)
	if not child then return end

	child:settext( tostring(value) )
end

-- This maps from a TapNoteScore to a child in the ActorFrame.
local TapNoteMap =
{
	[TNS_MARVELOUS]	= "Fantastic",
	[TNS_PERFECT]	= "Excellent",
	[TNS_GREAT]	= "Great",
	[TNS_GOOD]		= "Decent",
	[TNS_BOO]		= "Way Off",
	[TNS_MISS]		= "Miss",
	[TNS_HITMINE]	= "Mine",
	LowRated		= "LowRated",
	HitNotes		= "HitNotes",
};

local HoldNoteMap =
{
	[HNS_OK]	= "HoldOK",
	[HNS_NG]	= "HoldMiss"
};

-- 103 is a sentinel for beta 2. There should be a better way to do this...
-- local function IsSupported() return OPENITG and OPENITG_VERSION >= 103 end
-- Forcing the function to return 1. This is causing MANY builds to crash when Player 1 tries to use In-Game Stats alone. Removing until new builds are distributed to the public, or a better of way of checking builds is found.
local function IsSupported() return 1 end

function SetJudgmentFrameForPlayer( self, pn )
	if not IsSupported() then return nil end

	for tns,name in pairs(TapNoteMap) do
		
		if tns == "LowRated" then SetValueForChild( self, name, GetTapScore(pn, TNS_GREAT) + GetTapScore(pn, TNS_GOOD) + GetTapScore(pn, TNS_BOO) ) 
		elseif tns == "HitNotes" then SetValueForChild( self, name, GetTapScore(pn, TNS_MARVELOUS) + GetTapScore(pn, TNS_PERFECT) + GetTapScore(pn, TNS_GREAT) + GetTapScore(pn, TNS_GOOD)) 
		else SetValueForChild( self, name, GetTapScore(pn, tns) ) end
	end

	for hns,name in pairs(HoldNoteMap) do
		SetValueForChild( self, name, GetHoldScore(pn, hns) )
	end
end

function GetNotesHit( self, pn )
	return GetTapScore(pn, TNS_MARVELOUS) + GetTapScore(pn, TNS_PERFECT) + GetTapScore(pn, TNS_GREAT)
end	

function GetNotesFantasticHit( self, pn )
	return GetTapScore(pn, TNS_MARVELOUS)
end	

function GetNotesExcellentHit( self, pn )
	return GetTapScore(pn, TNS_PERFECT)
end	
function GetNotesGreatHit( self, pn )
	return GetTapScore(pn, TNS_GREAT)
end	

function GetNotesExcellentComboHit( self, pn )
	if GetTapScore(pn, TNS_PERFECT) >=1 then 
		return GetTapScore(pn, TNS_PERFECT) + GetTapScore(pn, TNS_MARVELOUS) end
	return 0
end	

function GetNotesGreatComboHit( self, pn )
	if GetTapScore(pn, TNS_GREAT) >=1 then 
		return GetTapScore(pn, TNS_PERFECT) + GetTapScore(pn, TNS_MARVELOUS) + GetTapScore(pn, TNS_GREAT) end
	return 0
end	

function GetNotesOtherHit( self, pn )
	return GetTapScore(pn, TNS_GREAT) + GetTapScore(pn, TNS_GOOD) + GetTapScore(pn, TNS_BOO)
end

function GetPlayerPercentage( pn )


if GAMESTATE:IsPlayerEnabled(pn) then

	local NotesHitScore = 0;
	local NotesPossibleScore = 0;
	local PlayerPercentage = 0;
	local Selection = GAMESTATE:GetCurrentSteps(pn);
	local TotalSteps = tonumber( Radar( Selection:GetRadarValues(),6 ) );
	local TotalHolds = tonumber( Radar( Selection:GetRadarValues(),2) );
	local TotalRolls = tonumber( Radar( Selection:GetRadarValues(),5 ) );
	
	NotesPossibleScore = (TotalSteps * 5 ) + ((TotalHolds + TotalRolls) * 5 );
	NotesHitScore = 	(GetTapScore(pn, TNS_MARVELOUS) * 5 ) + 
				(GetTapScore(pn, TNS_PERFECT) * 4 ) +
				(GetTapScore(pn, TNS_GREAT) * 2 ) +
				(GetTapScore(pn, TNS_BOO) * -6 ) +
				(GetTapScore(pn, TNS_MISS) * -12 ) +
				(GetHoldScore(pn, HNS_OK) * 5 ) +
				(GetTapScore(pn, TNS_HITMINE) * -6 )
				

				
	PlayerPercentage = NotesHitScore/NotesPossibleScore *100

	--return "Song Completion Percentage: " .. string.sub(string.format("%.5f", PlayerPercentage),1,5) .. "%"
	return PlayerPercentage end	
end

function CompareScoresRange( difference, range )
	local Player1Score=GetPlayerPercentage( PLAYER_1 )
	local Player2Score=GetPlayerPercentage( PLAYER_2 )
	local ScoreDifference = GetPlayerPercentage( PLAYER_1 ) - GetPlayerPercentage( PLAYER_2 )
	local ReturnValue = scale(ScoreDifference, -difference, difference, range, -range)

if ReturnValue <= -range then return -range
elseif ReturnValue >= range then return range
else return ReturnValue end

end


function PlayerFullComboed(pn)

	if GAMESTATE:IsPlayerEnabled(pn) then
		local Selection = GAMESTATE:GetCurrentSteps(pn);
		local TotalSteps = tonumber( Radar( Selection:GetRadarValues(),6 ) );
		local TotalHolds = tonumber( Radar( Selection:GetRadarValues(),2) );
		local TotalRolls = tonumber( Radar( Selection:GetRadarValues(),5 ) );
		
		if GetNotesHit( self, pn ) == TotalSteps and GetHoldScore(pn, HNS_OK) == (TotalHolds + TotalRolls) then
			return true end
	end	
return false

end


function AnyPlayerFullComboed(self)

	if PlayerFullComboed(PLAYER_1) or PlayerFullComboed(PLAYER_2) then 
	return true end

end

function GetHoldsHeldTotal(pn)
return GetHoldScore(pn, HNS_OK) end


function PlayComboSound()
local Path = THEME:GetPath( EC_SOUNDS, '', "FullComboSplash" )
	SOUND:PlayOnce( Path )
end
