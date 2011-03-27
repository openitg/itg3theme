function Actor:SetPaneLevel( t )
	local level = self.PaneLevel;

	self:stopeffect();
	self:linear(0.05);
	self:draworder(250);
	self:vertalign("bottom");
	self:y(9)
	if level > t[4] then
		self:zoomy(0.675);
	else
		self:zoomy(level/t[4]*1*0.675);
	end
	
	if level < t[1] then
		self:diffuse( color("#FFFFFF") )
	elseif level < t[2] then
		self:diffuse( color("#00FF00") )
	elseif level < t[3] then
		self:diffuse( color("#FFDD23") )
	elseif level < t[4] then
		self:diffuse( color("#FF2525") )
	else
		self:diffuseshift()
		self:effectcolor1( color("#D50020") )
		self:effectcolor2( color("#FFFFFF") )
	end

end

function Actor:setpanehighscore()
	local level = self.PaneLevel;

	self:stopeffect();
	if level < 0.01 then
		self:diffuse( color("#FFFFFF") )
	elseif level < 0.50 then
		self:diffuse( color("#27CAF1") )
	elseif level < 0.80 then
		self:diffuse( color("#00FF00") )
	elseif level < 0.90 then
		self:diffuse( color("#40E0EE") )
	elseif level < 0.95 then
		self:diffuse( color("#FFDD00") )
	elseif level < 0.99 then
		self:diffuseshift();
		self:effectcolor1( color("#40E0EE") )
		self:effectcolor2( color("#FFFFFF") )
	else
		self:diffuseshift();
		self:effectcolor1( color("#FFDD00") )
		self:effectcolor2( color("#FFFFFF") )
	end
end

function Actor:setpanehighscorename()
	local level = self.PaneLevel;

	self:stopeffect();
	if level < .9999 then
		self:diffuse( color("#FFFFFF") )
	else
		self:diffuse( color("#FFFFFF") )
		self:effectclock("bgm")
		self:pulse()
		self:effectperiod( 1 )
		self:effectoffset( 0.2 )
		self:effectmagnitude( 1.2, 1, 0 );
	end
end

function Actor:panecolumn1textoncommand()
	self:horizalign("left")
	self:shadowlength(0)
end
function Actor:panecolumn1labeloncommand()
	self:horizalign("left")
	
	self:zoom(0.5)
	self:shadowlength(0)
end
function Actor:panecolumn2textoncommand()
	self:horizalign("left")
	self:shadowlength(0)
end
function Actor:panecolumn2labeloncommand()
	self:horizalign("left")
	self:zoom(0.5)
	self:shadowlength(0)
end
function Actor:panegainfocuscommand()
	self:stoptweening()
	self:sleep(0.15)
	self:linear(0.2)
	self:cropright(0)
end
function Actor:panelosefocuscommand()
	self:stoptweening()
	self:linear(0.2)
	self:cropright(1)
end

function Actor:paneiconcommand()
	self:diffusealpha(0.5);
	self:draworder(50);
	self:horizalign("left")
	self:shadowlength(0)
end

function Actor:setpanenumsteps()

end


function Actor:setpanesongjumps()
	self:SetPaneLevel( { 1, 25, 50, 100 } )
end
function Actor:setpanesongholds()
	self:SetPaneLevel( { 1, 15, 30, 50 } )
end
function Actor:setpanesongmines()
	self:SetPaneLevel( { 1, 25, 50, 100 } )
end
function Actor:setpanesonghands()
	self:SetPaneLevel( { 1, 10, 35, 75 } )
end
function Actor:setpanesongrolls()
	self:SetPaneLevel( { 1, 10, 35, 75 } )
end

function Actor:setpanecoursenumsteps()
	self:SetPaneLevel( { 1, 1000, 1500, 2000 } )
end
function Actor:setpanecoursejumps()
	self:SetPaneLevel( { 1, 50, 100, 200 } )
end
function Actor:setpanecourseholds()
	self:SetPaneLevel( { 1, 50, 100, 200 } )
end
function Actor:setpanecoursemines()
	self:SetPaneLevel( { 1, 55, 100, 200 } )
end
function Actor:setpanecoursehands()
	self:SetPaneLevel( { 1, 10, 35, 75 } )
end
function Actor:setpanecourserolls()
	self:SetPaneLevel( { 1, 10, 35, 75 } )
end

function GetMeterText( pn )
	local steps = GAMESTATE:GetCurrentSteps(pn)
	local trail = GAMESTATE:GetCurrentTrail(pn)
	if steps == nil then 
		return ""
    elseif steps:GetDifficulty() == DIFFICULTY_EDIT then 
		return steps:GetMeter()
else 
		return steps:GetMeter()
	end
end 
function GetMeterTextP2()
	local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
	if steps == nil then 
		return ""
    elseif steps:GetDifficulty() == DIFFICULTY_EDIT then 
		return steps:GetMeter()
else 
		return steps:GetMeter()
	end
end 