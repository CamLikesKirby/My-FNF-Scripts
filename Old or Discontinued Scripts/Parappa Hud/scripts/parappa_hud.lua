-- WARNING: This code might suck
-- WARNING: This code might suck
-- WARNING: This code might suck
-- WARNING: This code might suck
-- WARNING: This code might suck
-- WARNING: This code might suck
-- WARNING: This code might suck
-- WARNING: This code might suck

-- SETTINGS

local FunnyColors = { -- Changes the colors
    '00FFFF', -- Cool
    '00FF00', -- Good
    'FF0000', -- Bad
    '00008B', -- Awful
}

local squeakNoises = getModSetting('sN', 'Parappa Hud') -- bad and awful noises
local parappaScoreHidden = getModSetting('pSH', 'Parappa Hud') -- self explanatory
local scoreHidden = getModSetting('sH', 'Parappa Hud') -- self explanatory
local iconsHidden = getModSetting('iH', 'Parappa Hud') -- self explanatory
local ratingEffects = getModSetting('rE', 'Parappa Hud') -- if you want the rating effects 


-- SETTINGS

-- the funnys

local memoryLeaks = false -- funny (This does nothing)

-- the funnys

-- DON'T TOUCH

local Mode = '?'
local soundsForModes = true
local camOnBoy = false
local thumby = true

-- DON'T TOUCH
function onCreate()
-- the rating stuffs
makeLuaText("text1",'Cool !', 299, 1020, 330)
setTextSize('text1', 30)
setTextColor('text1', FunnyColors[1])
setTextFont("text1", "TektonPro-Bold.ttf")
addLuaText("text1")

makeLuaText("text2",'Good !', 299, 1027, 360)
setTextSize('text2', 30)
setTextColor('text2', FunnyColors[2])
setTextFont("text2", "TektonPro-Bold.ttf")
addLuaText("text2")

makeLuaText("text3",'Bad', 299, 1015, 390)
setTextSize('text3', 30)
setTextColor('text3', FunnyColors[3])
setTextFont("text3", "TektonPro-Bold.ttf")
addLuaText("text3")
 
makeLuaText("text4",'Awful', 299, 1025, 420)
setTextSize('text4', 30)
setTextColor('text4', FunnyColors[4])
setTextFont("text4", "TektonPro-Bold.ttf")
addLuaText("text4")

makeLuaText("text?",'?', 299, 1017, 450)
setTextSize('text?', 30)
setTextFont("text?", "TektonPro-Bold.ttf")
addLuaText("text?")

makeLuaSprite('TU', 'Parappa 1/Thumbsup', 90, 480)
setScrollFactor('TU', '0', '0')
setObjectCamera('TU', 'hud')
scaleObject('TU', 4, 4)
setProperty('TU.visible', false)
addLuaSprite('TU', true);

makeLuaSprite('TD', 'Parappa 1/Thumbsdown', 90, 495)
setScrollFactor('TD', '0', '0')
setObjectCamera('TD', 'hud')
scaleObject('TD', 4, 4)
setProperty('TD.visible', false)
addLuaSprite('TD', true);


makeLuaText("UR",'U rappin', 299, 830, 360)
setTextSize('UR', 30)
setTextFont("UR", "TektonPro-Bold.ttf")
addLuaText("UR")

if parappaScoreHidden == false then
makeLuaText("textS"," Score: 0" , 300, 0, 600)
setTextSize('textS', 30)
setTextFont("textS", "TektonPro-Bold.ttf")
addLuaText("textS")
end
end

function onCreatePost()
    if squeakNoises == true then
    precacheSound("UJL-PTR2_Bad_squeak_pattern_v2")
    precacheSound("UJL-PTR2_Awful_squeak_pattern_v2")
    end
end

function onUpdate(elapsed)
 if iconsHidden == true then
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
 end

   if scoreHidden == true then
   setProperty('scoreTxt.visible', false)
   end

-- the code
setTextString("textS", " Score: "..score)
    
end 

function onUpdatePost(elapsed)
 

    -- ratings
    if rating >= 1 or rating>= 0.95 then -- COOL
        thumbthingbad = true
    
        setProperty('UR.y', 330)
     Mode = 'Cool'
     setTimeBarColors(FunnyColors[1], '000000')
     stopSound('badsound')
     stopSound('awfulsound')

           if thumby == true and thumbthingbad == true then -- WHY DID THIS TAKE SO LONG TO WORK!!
            setProperty('TU.visible', true) 
            thumbthingbad = false
            thumby = false
        end

        if thumbthingbad == false then
        --    runTimer('Ithinkicancodethisbetterbutimlazy', 0.4) -- this is prob can be not needed but im lazy
        end

    elseif rating >= 0.85 then -- GOOD
        wasongood = true
        thumbthingbad = true
        if thumby == false and thumbthingbad == true then
            thumby = true
        end

        setProperty('UR.y', 360)
        Mode = 'Good'
        setTimeBarColors(FunnyColors[2], '000000')
        stopSound('badsound')
        stopSound('awfulsound')
        
        if thumby == true then -- WHY DID THIS TAKE SO LONG TO WORK!!
            if wasOnCoolMode == true then
            setProperty('TD.visible', true) 
            else
            setProperty('TU.visible', true) 
            end
            thumbthingbad = false
        end
        --
        if thumbthingbad == false then
            --runTimer('Ithinkicancodethisbetterbutimlazy', 0.4) -- this is prob can be not needed but im lazy
        end

    elseif rating >= 0.50 then --BAD
        wasonbad = true
        -- This code is prob not optimized but it works
        thumbthingbad = true
        if soundsForModes == false and wasonawful == true then
            soundsForModes = true
            wasonawful = false
            end
        --  
        stopSound('awfulsound')
        setProperty('UR.y', 390)
        Mode = 'Bad'
        setTimeBarColors(FunnyColors[3], '000000')
        if soundsForModes == true and squeakNoises == true then
        playSound("UJL-PTR2_Bad_squeak_pattern_v2",2, 'badsound')
        runTimer('badsound', 5)
        soundsForModes = false
        end
       -- This code is prob not optimized but it works

        if thumby == true then -- WHY DID THIS TAKE SO LONG TO WORK!!
            if wasongood == true then
            setProperty('TD.visible', true) 
            else
            setProperty('TU.visible', true) 
            end
            thumbthingbad = false
        end
        --
        if thumbthingbad == false then
            --runTimer('Ithinkicancodethisbetterbutimlazy', 0.4) -- this is prob can be not needed but im lazy
        end

    elseif rating >= 0.21 then -- AWFUL
        wasonawful = true
        thumbthingbad = true

        if soundsForModes == false and wasonbad == true then
        soundsForModes = true
        wasonbad = false
        end
        setProperty('UR.y', 420)  
        Mode = 'Awful'
        setTimeBarColors(FunnyColors[4], '000000')
        stopSound('badsound')
        if soundsForModes == true and squeakNoises == true then
            playSound("UJL-PTR2_Awful_squeak_pattern_v2",2, 'awfulsound')
            runTimer('awfulsound', 5)
            soundsForModes = false
            end

            if thumby == true then -- WHY DID THIS TAKE SO LONG TO WORK!!
                setProperty('TD.visible', true) 
                thumbthingbad = false
            end
            --
            if thumbthingbad == false then
                --runTimer('Ithinkicancodethisbetterbutimlazy', 0.4) -- this is prob can be not needed but im lazy
            end

    elseif rating >= 0.00 and hits > 0 or misses > 0 then -- So it won't land on the ?
     setProperty('UR.y', 450)  
        Mode = '?'
        setTimeBarColors(FunnyColors[4], '000000')
end
-- ratings code
if Mode == 'Cool' then
    wasOnCoolMode = true
noteTweenX('Stttt5', '0', -1000, '0.5')
noteTweenX('Stttt6', '1', -1000, '0.5')
noteTweenX('Stttt7', '2', -1000, '0.5')
noteTweenX('Stttt8', '3', -1000, '0.5')
elseif Mode == 'Good' or Mode == 'Bad' or Mode == 'Awful' then
    if wasOnCoolMode == true then
noteTweenX('Stttt5', '0', defaultOpponentStrumX0, '0.5') 
noteTweenX('Stttt6', '1', defaultOpponentStrumX1, '0.5')
noteTweenX('Stttt7', '2', defaultOpponentStrumX2, '0.5')
noteTweenX('Stttt8', '3', defaultOpponentStrumX3, '0.5')
    end
    wasOnCoolMode = false
elseif Mode == 'Awful' then
    playAnim('gf', 'sad')
    
end

function onBeatHit()
    if Mode == 'Cool' and curBeat % 4 == 0 then
        playAnim('gf', 'cheer')
    end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if Mode == 'Cool' then
        downorup('TU', down)
    elseif Mode == 'Good' then
        
    elseif Mode == 'Bad' and camOnBoy == false then
      playAnim('boyfriend', 'scared', false)
    elseif Mode == 'Awful' and camOnBoy == false then
            playAnim('boyfriend', 'scared', false)
    end
  end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if botPlay == true then
      botplayMode = getRandomInt(1,10)
      if botplayMode > 5 then
        Mode = 'Cool'
      else
        Mode = 'Good'
      end
    end
end

function onMoveCamera(focus)
    if focus == 'dad' or focus == 'gf' then
 camOnBoy = false
    else
        camOnBoy = true
    end
end
function onTimerCompleted(tag)
    if tag == 'badsound' or tag == 'awfulsound' then
        soundsForModes = true
    end
    if tag == 'Ithinkicancodethisbetterbutimlazy' then
        setProperty('TU.visible', false)   
        setProperty('TD.visible', false)
    end
end

--function thumbs(funnydir)
  --  if funnydir == 'up' then
   -- setProperty('TU.visible', true)
    --else   
    --setProperty('TD.visible', true)
    --end
    --runTimer('Ithinkicancodethisbetterbutimlazy', 0.7) -- this is prob can be not needed but im lazy
--end