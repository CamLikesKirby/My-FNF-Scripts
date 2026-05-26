------------ SETTINGS ------------------------------
local funnyFont = 'COMIC.tff' -- the font
local realScore = getModSetting('realScore', 'Raldi Hud') -- if you want the real score
local realAcc = getModSetting('realAcc', 'Raldi Hud')  -- if you want the real accuracy
------------ SETTINGS ------------------------------

local fakeScore = 0
local fakeAccuracy = '100% (A+)%'

function onCreatePost()
    if getModSetting('rmgOn', 'Raldi Hud') then
    runHaxeCode("game.scoreTxt.y -= 15;")

    makeLuaSprite('RaldiBar', 'RaldiBar')
	setObjectCamera('RaldiBar', 'hud')
	setProperty('RaldiBar.alpha', getPropertyFromClass('backend.ClientPrefs', 'data.healthBarAlpha'))
    scaleObject('RaldiBar', 1.5, 1.5)
	screenCenter('RaldiBar', 'x')
	setProperty('RaldiBar.y', getProperty('healthBar.y') + -10)
	addLuaSprite('RaldiBar', true)
    end
end

function onUpdate(elapsed)
    if getModSetting('rmgOn', 'Raldi Hud') then
    setHealthBarColors('ff0000') 
    end
end

function onUpdatePost(elapsed)
    if getModSetting('rmgOn', 'Raldi Hud') then
    if realScore then
     fakeScore = score
    end
    
    if realAcc then
        fakeAccuracy = ''..(math.floor(getProperty('ratingPercent') * 10000)/100)..'%'
    end

    if hits > 0 or misses > 0 then
        setTextString('scoreTxt', 'Score: ' ..fakeScore.. ' | Misses: ' ..misses.. ' | Accuracy: '..fakeAccuracy)
    elseif not botPlay then
     setTextString('scoreTxt', 'Score: 0 | Misses: 0 | Accuracy: 100% (A+)%')   
    else
    fakeAccuracy = '100% (AUTO)%'
    setTextString('scoreTxt', 'Score: ' ..fakeScore.. ' | Accuracy: '..fakeAccuracy)
end

setTextFont('scoreTxt', funnyFont)
setTextSize('scoreTxt', 30)
setTextColor('scoreTxt', 'FFFFFF')
setTextBorder("scoreTxt", 0.7, '000000')
end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if not realScore then
    if not isSustainNote then
    fakeScore = fakeScore + 1
      end
   end 
end


function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    if not realAcc then
    fakeAccuracy = '0% (D)%'
    end
end

function onGameOver()
	playSound('Snd_ral_fail')
	return Function_Continue;
end