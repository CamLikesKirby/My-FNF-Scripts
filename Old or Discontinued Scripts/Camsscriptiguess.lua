-- NOTE: If you don't like this code click the little X on the top right

-- locals

--local GOFUNKYOURSELF = true
local tableSoThePsychEngineSeverDoesntYellAtMe = {'noteeeeeeeeee', 'noteeeeeeeeee2', 'noteeeeeeeeee3', 'Heal', 'notHeal', 'Opp', 'bro', 'dodge1'} -- easier to edit
local heal = false
local notHeal = false
local Oppdostuff = false
local dodge1 = false
local didDodge = false
-- Words, Functions and Preload Sounds
function onCreatePost()
  precacheSound("flashbang_sound_effect")
  precacheSound("my_name_is_craig_tucker")

  luaDebugMode = true
  FunnyTimer()

makeLuaText('thethingthething', 'You\'re not supposed to see this', '0', '200', '540') 
setTextSize('thethingthething', 50)
setProperty('thethingthething.color', getColorFromHex ("FFFF00"))
addLuaText('thethingthething', true)
setProperty('thethingthething.visible', false)
end
-- Timer

function FunnyTimer()
--  debugPrint('On FunnyTimer')
  runTimer('evetTimer', getRandomInt('7', '9')) -- happy now?
end

-- Events

function theEvents()
  -- No Loops? Yeah I know shut it
  --debugPrint('On Events')
  theFunky = getRandomInt('1', '10') -- doesn't work if I only use getRandomInt
  -- the Things
  if theFunky == 1 then
    -- Opp
    noteTweenAngle('noteAng1', '4', '180', '1')
    noteTweenAngle('noteAng2', '5', '180', '1')
    noteTweenAngle('noteAng3', '6', '-180', '1')
    noteTweenAngle('noteAng4', '7', '-180', '1')
-- Play
    noteTweenAngle('noteAng7', '8', '-180', '1')
    noteTweenAngle('noteAng5', '1', '180', '1')
    noteTweenAngle('noteAng6', '2', '180', '1')
    noteTweenAngle('noteAng8', '3', '-180', '1')
    runTimer(tableSoThePsychEngineSeverDoesntYellAtMe[1], '10')
  elseif theFunky == 2 then

 -- Opp
 noteTweenAlpha('noteAlp1', '4', 1 / 2 , '1')
 noteTweenAlpha('noteAlp2', '5', 1 / 2, '1')
 noteTweenAlpha('noteAlp3', '6', 1 / 2, '1')
 noteTweenAlpha('noteAlp4', '7', 1 / 2, '1')
-- Play
noteTweenAlpha('noteAlp7', '8', 1 / 2, '1')
noteTweenAlpha('noteAlp5', '1', 1 / 2, '1')
noteTweenAlpha('noteAlp6', '2', 1 / 2, '1')
noteTweenAlpha('noteAlp8', '3', 1 / 2, '1')
runTimer(tableSoThePsychEngineSeverDoesntYellAtMe[2], '10')
elseif theFunky == 3 then
noteTweenX('note7', '7', defaultPlayerStrumX0, '0.5')
noteTweenX('note7ll', '4', defaultPlayerStrumX3, '0.5')

noteTweenX('note8', '3', defaultOpponentStrumX0, '0.5')
noteTweenX('note8ll', '0', defaultOpponentStrumX3, '0.5')

runTimer(tableSoThePsychEngineSeverDoesntYellAtMe[3], '10')
elseif theFunky == 4 then
  heal = true
  setProperty('thethingthething.visible', true)
  setTextString('thethingthething', 'Press Space to heal!')
  runTimer(tableSoThePsychEngineSeverDoesntYellAtMe[4], '5')
elseif theFunky == 5 then
  notHeal = true
  setProperty('thethingthething.visible', true)
  setTextString('thethingthething', 'Press Space to heal?')
  runTimer(tableSoThePsychEngineSeverDoesntYellAtMe[5], '5')
elseif theFunky == 6 then
  Oppdostuff = true
  runTimer(tableSoThePsychEngineSeverDoesntYellAtMe[6], '10')
elseif theFunky == 7 then
  cameraFlash('camGame', 'ffffff', 5);
  playSound("flashbang_sound_effect",2)
  
elseif theFunky == 8 then
  playSound("my_name_is_craig_tucker",6)
  FunnyTimer()
elseif theFunky == 9 then
noteTweenX('Stttt1', '4', defaultOpponentStrumX0, '0.5')
noteTweenX('Stttt2', '5', defaultOpponentStrumX1, '0.5')
noteTweenX('Stttt3', '6', defaultOpponentStrumX2, '0.5')
noteTweenX('Stttt4', '7', defaultOpponentStrumX3, '0.5')

noteTweenX('Stttt5', '0', defaultPlayerStrumX0, '0.5')
noteTweenX('Stttt6', '1', defaultPlayerStrumX1, '0.5')
noteTweenX('Stttt7', '2', defaultPlayerStrumX2, '0.5')
noteTweenX('Stttt8', '3', defaultPlayerStrumX3, '0.5')

runTimer(tableSoThePsychEngineSeverDoesntYellAtMe[7], '10')
elseif theFunky == 10 then
  dodge1 = true
  setProperty('thethingthething.visible', true)
  setTextString('thethingthething', 'PRESS SPACE TO DODGE!!!')
  runTimer(tableSoThePsychEngineSeverDoesntYellAtMe[8], '1.5')
end
end
-- Code
function onUpdate()
if heal == true and keyboardPressed('SPACE') then
  --  debugPrint('yeah')
    addHealth(0.5)
    heal = false
    setProperty('thethingthething.visible', false)
   -- cancelTimer('Heal')
  elseif notHeal == true and keyboardPressed('SPACE') then
  --  debugPrint('yeah')
      addHealth(-0.5)
      notHeal = false
      setProperty('thethingthething.visible', false)
     -- cancelTimer('Heal')
    elseif dodge1 == true and keyboardPressed('SPACE') then
      --  debugPrint('yeah')
      addHaxeLibrary('Boyfriend')

      playAnim('boyfriend', 'dodge', true)
      
      dodge1 = false
      didDodge = true
          setProperty('thethingthething.visible', false)
         -- cancelTimer('Heal')
end
end
-- More Code
function opponentNoteHit()
  if Oppdostuff == true then
  health = getProperty('health')
  if getProperty('health') > 0.05 then
      setProperty('health', health- 0.03);
  end
  end
end
-- When the Event is finished
function onTimerCompleted(tag)
  if tag == 'evetTimer' then
 theEvents()
 -- FunnyTimer()

elseif tag == 'noteeeeeeeeee' then
    -- Opp
    noteTweenAngle('noteAng1', '4', '0', '1')
    noteTweenAngle('noteAng2', '5', '0', '1')
    noteTweenAngle('noteAng3', '6', '0', '1')
    noteTweenAngle('noteAng4', '7', '0', '1')
    -- Play
    noteTweenAngle('noteAng7', '8', '0', '1')
    noteTweenAngle('noteAng5', '1', '0', '1')
    noteTweenAngle('noteAng6', '2', '0', '1')
    noteTweenAngle('noteAng8', '3', '0', '1')
   
     
elseif tag == 'noteeeeeeeeee2' then
     -- Opp
 noteTweenAlpha('noteAlp1', '4', '1', '-6')
 noteTweenAlpha('noteAlp2', '5', '1', '-6')
 noteTweenAlpha('noteAlp3', '6', '1', '-6')
 noteTweenAlpha('noteAlp4', '7', '1', '-6')
-- Play
noteTweenAlpha('noteAlp7', '8', '1', '-6')
noteTweenAlpha('noteAlp5', '1', '1', '-6')
noteTweenAlpha('noteAlp6', '2', '1', '-6')
noteTweenAlpha('noteAlp8', '3', '1', '-6')
elseif tag == 'noteeeeeeeeee3' then
  noteTweenX('noteF7', '7', defaultPlayerStrumX3, '0.5')
  noteTweenX('noteFA7', '4', defaultPlayerStrumX0, '0.5')

  noteTweenX('noteFF8', '0', defaultOpponentStrumX0, '0.5')
noteTweenX('noteFFAA8', '3', defaultOpponentStrumX3, '0.5')
elseif tag == 'Heal' then
 -- debugPrint('yeah')
 heal = false
 setProperty('thethingthething.visible', false)
elseif tag == 'notHeal' then
  -- debugPrint('yeah')
  notHeal = false
  setProperty('thethingthething.visible', false)
elseif tag == 'Opp' then
 -- debugPrint('yeah')
  Oppdostuff = false
elseif tag == 'bro' then
  noteTweenX('Stttt1', '4', defaultPlayerStrumX0, '0.5')
noteTweenX('Stttt2', '5', defaultPlayerStrumX1, '0.5')
noteTweenX('Stttt3', '6', defaultPlayerStrumX2, '0.5')
noteTweenX('Stttt4', '7', defaultPlayerStrumX3, '0.5')

noteTweenX('Stttt5', '0', defaultOpponentStrumX0, '0.5')
noteTweenX('Stttt6', '1', defaultOpponentStrumX1, '0.5')
noteTweenX('Stttt7', '2', defaultOpponentStrumX2, '0.5')
noteTweenX('Stttt8', '3', defaultOpponentStrumX3, '0.5')
elseif tag == 'dodge1' then
  setProperty('thethingthething.visible', false)
  dodge1 = false
  if didDodge == false then
    addHealth(-0.5)
    playAnim('boyfriend', 'hurt', true)
  else
    didDodge = false
  end
end
--debugPrint('end on events lol ', theFunky)
FunnyTimer()
end