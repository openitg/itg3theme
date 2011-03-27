function SongsAmountLevel( pn )
	local val = PROFILEMAN:GetProfile( pn ):GetTotalNumSongsPlayed()
	if val < 100 then return 2 end
	if val < 200 then return 3 end
	if val < 300 then return 4 end
	if val < 400 then return 5 end
	if val < 500 then return 6 end
	if val < 600 then return 7 end

	return 1
	end

--addons
--we don't need more than 3 packs, so make 3 functions
--pack 1
function AddonPack1()
	local s = SONGMAN:FindSong("In The Groove 3 Addons/Dummy1")
	if not s then return false end
	return true
end

function GetAddonName1()
	local song = SONGMAN:FindSong("In The Groove 3 Addons/Dummy1")
	if not song then return "" end
	return
		song:GetDisplayArtist()
end

--pack 2
function AddonPack2()
local s = SONGMAN:FindSong("In The Groove 3 Addons/Dummy2")
if not s then return false end
return true
end

function GetAddonName2()
	local song = SONGMAN:FindSong("In The Groove 3 Addons/Dummy2")
	if not song then return "" end
	return
		song:GetDisplayArtist()
end

--pack 3
function AddonPack3()
local s = SONGMAN:FindSong("In The Groove 3 Addons/Dummy3")
if not s then return false end
return true
end

function GetAddonName3()
	local song = SONGMAN:FindSong("In The Groove 3 Addons/Dummy3")
	if not song then return "" end
	return
		song:GetDisplayArtist()
end

-- end of packs



