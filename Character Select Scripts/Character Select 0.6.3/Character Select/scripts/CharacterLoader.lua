-- V2.5.5
-- For Version 0.6.3
-- script made by camlikeskirby (Username on a lot of sites)
-- Loads in the characters chosen in AutoCharSelect.lua while doing some other stuff

-- Settings
local bfChange = true
local gfChange = true
local removeChangeCharacterEvent = true
local removeChangeCharacterEventGF = true

-- Also don't touch unless you know what your doing
local savebf = ''
local savegf = ''
local ce = false
local pixelStage = false 

function onCreatePost()
initSaveData('autoCharacterSelect')

savebf = getDataFromSave('autoCharacterSelect', 'bf', 'bf') 
savegf = getDataFromSave('autoCharacterSelect', 'gf', 'gf')
pixelStage = getPropertyFromClass('PlayState', 'isPixelStage')

if not pixelStage then
if bfChange then triggerEvent("Change Character", "0", savebf) end
if gfChange then gfCheck() end
end
ce = true
end

function onEvent(event, value1, value2, strumTime)
    if event == 'Change Character' and ce and not pixelStage then
    ce = false
    val = string.lower(value1)
    if (val == '1' or val == 'dad' or val == 'opponent') and (stringStartsWith(dadName, 'gf-') or dadName == 'gf') and gfChange and removeChangeCharacterEventGF then triggerEvent("Change Character", "1", savegf) 
    else if (val == '2' or val == 'gf' or val == 'girlfriend') and gfChange and removeChangeCharacterEventGF then triggerEvent("Change Character", "2", savegf) 
    else if bfChange and removeChangeCharacterEvent then triggerEvent("Change Character", "0", savebf) end
    end
    end
    ce = true
   end
end

function onUpdate()
if keyboardJustPressed('SHIFT') and keyboardJustPressed('ONE') then loadSong('Character Select', 1) end
end

function gfCheck() 
if stringStartsWith(dadName, 'gf-') or dadName == 'gf' then triggerEvent("Change Character", "1", savegf) 
else triggerEvent("Change Character", "2", savegf)
end end