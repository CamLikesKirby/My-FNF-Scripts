local wegas = {}
local Pauses = 0
local wega = false
local wegaVol = getModSetting('wegaVol', 'Wega')

function onCreate()
    idk = 1
    for i = 1,getModSetting('wegaCount', 'Wega'),1 do
    table.insert(wegas, idk)
    idk = idk + 1
    end

    for i in pairs(wegas) do
    if checkFileExists('mods/Wega/images/'..getModSetting('wegaPack', 'Wega')..'/'..i..'.png', true) then
    makeLuaSprite('W'..i, ''..getModSetting('wegaPack', 'Wega')..'/'..i, 0, 0)
    setObjectCamera('W'..i, 'other')
    scaleObject('W'..i, 2.0, 2.0)
    setProperty('W'..i..'.visible', false)
	addLuaSprite('W'..i, true)
  end
 end
end

function onCreatePost()

    precacheSound(getModSetting('wegaScream', 'Wega'))
    end

function onPause()

    runTimer('Wega',  getModSetting('wegaTime', 'Wega'))

    if Pauses > 9 then
    wega = true
    Wega()
    end
  end

function onResume()

    Pauses = Pauses + 1 
    Hide()
    stopSound("wegaSound")
    end



function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'Wega' then
        thing = getSoundTime("wegaSound")
        if wega == true then
            Wega()
            runTimer('wegaSoundthing', thing) -- Can't get it from the sound tag for some reason
        end
        Pauses = 0 
        wega = false
    end

    if tag == 'wegaSoundthing' then
    Hide()
    end
end

function Hide()
    for i in pairs(wegas) do
    setProperty('W'..i..'.visible', false)
    end
end

function Wega()
    playSound(getModSetting('wegaScream', 'Wega'), wegaVol, 'wegaSound')
    setProperty('W'..wegas[getRandomInt('1', #wegas)]..'.visible', true)
end