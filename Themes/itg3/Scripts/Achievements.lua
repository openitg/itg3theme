local function GetStarsForGrade( pn, grade )
	return PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade(STEPS_TYPE_DANCE_SINGLE,DIFFICULTY_CHALLENGE,grade)
end

function QuadAward( pn )
	return GetStarsForGrade( pn, GRADE_TIER01 )
end

function StarAward( pn )
	return GetStarsForGrade(pn, GRADE_TIER01)*4
		+GetStarsForGrade(pn, GRADE_TIER02)*3
		+GetStarsForGrade(pn, GRADE_TIER03)*2
		+GetStarsForGrade(pn, GRADE_TIER04)
end

function CalorieAward( pn )
	return PROFILEMAN:GetProfile(pn):GetCaloriesBurnedToday()
end

function PercentAward( pn )
	return (PROFILEMAN:GetProfile(pn):GetSongsActual(STEPS_TYPE_DANCE_SINGLE,DIFFICULTY_CHALLENGE))*100
end

local function SetFromTiers( actor, tiers, value, offset )
	-- if below any tier values, hide the actor.
	if value < tiers[1] then actor:hidden(1) return end

	-- offset i by one so we can set predictable offsets.
	-- e.g. row 1 in the image is 0, row 2 is 4, etc.
	for i=1,table.getn(tiers) do
		if value <= tiers[i] then actor:setstate(offset+(i-1)) end
	end
end

function PercentIcon( actor, pn )
	local tiers = { 500, 2500, 7500, 15000 }
	local percent = PercentAward( pn )
	Trace("percent: " .. percent);

	SetFromTiers( actor, tiers, percent, 0 )
end

function StarIcon( actor, pn )
	local tiers = { 10, 25, 50, 100 }
	local stars = StarAward( pn )
	Trace("stars: " .. stars);

	SetFromTiers( actor, tiers, stars, 4 )
end


function QuadIcon( actor, pn ) 
	local tiers = { 10, 25, 50, 100 }
	local quads = QuadAward( pn )
	Trace("quads: " .. quads)

	SetFromTiers( actor, tiers, quads, 8 )
end

function CalorieIcon( Actor,pn ) 
	local cals = CalorieAward( pn )
	local tiers = { 250, 750, 1500, 3000 }
	Trace("cals: " .. cals) 

	SetFromTiers( actor, tiers, cals, 12 )
end