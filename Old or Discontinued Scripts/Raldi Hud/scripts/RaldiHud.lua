local funnyFont = 'COMIC.tff'
local numberOfNotes = 0
local hitsforbotplay = 0
local Done = false
local money = 0.00
local moneyGiven = {0.01, 0.10, 0.11, 0.15, 0.25, 0.20}
function onCreatePost()
    if getModSetting('rhOn', 'Raldi Hud') then
    makeLuaSprite('RHud', 'Raldi Hud/HUD_Mono', 345, 510)
    setObjectCamera('RHud', 'hud')
    scaleObject('RHud', 1.19, 1.0)
	addLuaSprite('RHud', false)

    makeLuaSprite('RHudTimerBackground', 'Raldi Hud/HUD_Mono', -140, getProperty('timeTxt.y') - 19)
    setObjectCamera('RHudTimerBackground', 'hud')
    scaleObject('RHudTimerBackground', 0.7, 0.3)
    if not downscroll then setProperty('RHudTimerBackground.angle', 180) end
	addLuaSprite('RHudTimerBackground', false)
    
    makeLuaSprite('RHudRedandwhite', 'Raldi Hud/Redandwhite', getProperty('healthBar.x') + 165,getProperty('healthBar.y') -655)
    setObjectCamera('RHudRedandwhite', 'hud')
    scaleObject('RHudRedandwhite', 1.3, 1.3)
	addLuaSprite('RHudRedandwhite', true)

    makeLuaSprite('RHudItemSlots', 'Raldi Hud/ItemSlots_Mono', getProperty('healthBar.x') + 165, getProperty('healthBar.y') -655)
    setObjectCamera('RHudItemSlots', 'hud')
    scaleObject('RHudItemSlots', 1.3, 1.3)
	addLuaSprite('RHudItemSlots', true) 

    makeLuaText('charText', boyfriendName, getTextWidth('scoreTxt'), getProperty('scoreTxt.x'), getProperty('iconP1.y') - 25)
    setTextFont('charText', funnyFont) 
    setTextSize('charText', (getTextSize('scoreTxt'))) 
    setTextColor('charText', 'FFFFFF')
    setTextBorder("charText", 0, '000000')  
    addLuaText('charText')
 
    makeLuaText('HealthRaldiHud', '50%', getTextWidth('scoreTxt'), -130, 570)
    setTextFont('HealthRaldiHud', funnyFont) 
    setTextSize('HealthRaldiHud', 60)
    setTextColor('HealthRaldiHud', 'FFFFFF')
    setTextBorder("HealthRaldiHud", 0, '000000')  
    addLuaText('HealthRaldiHud') 
 
    makeLuaText('MoneyRaldiHud', '$0.00',  getTextWidth('scoreTxt'), screenWidth - 1280, -10)
    setTextFont('MoneyRaldiHud', funnyFont) 
    setTextSize('MoneyRaldiHud', 60)
    setTextColor('MoneyRaldiHud', '32CE72')
    setTextBorder("MoneyRaldiHud", 0, '000000')  
    setTextAlignment("MoneyRaldiHud", "right")
    addLuaText('MoneyRaldiHud')

    makeLuaText('UnderTextRaldiHud', 'Stamina                                    Notebooks', getTextWidth('scoreTxt'), 10, 685)
    setTextFont('UnderTextRaldiHud', funnyFont) 
    setTextSize('UnderTextRaldiHud', 20)
    setTextColor('UnderTextRaldiHud', 'FFFFFF')
    setTextBorder("UnderTextRaldiHud", 0, '000000')  
    addLuaText('UnderTextRaldiHud')

    makeLuaText('NotebooksRaldiHud',   '?/?', getTextWidth('scoreTxt'), 155, 575)
    setTextFont('NotebooksRaldiHud', funnyFont) 
    setTextSize('NotebooksRaldiHud', 50)
    setTextBorder("NotebooksRaldiHud", 0, '000000')  
    setTextAlignment("NotebooksRaldiHud", "center")
    addLuaText('NotebooksRaldiHud')
    end
end 

function onCountdownStarted()
    if getModSetting('rhOn', 'Raldi Hud') then
    for i = 0, getProperty('unspawnNotes.length')-1 do
         if getPropertyFromGroup('unspawnNotes', i, 'mustPress') and not getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') and not getPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss') then
                numberOfNotes = numberOfNotes + 1
         end
        end
    end
  end

function onUpdate(elapsed)
    if getModSetting('rhOn', 'Raldi Hud') then
    setProperty('iconP2.visible', false)
    setProperty('healthBar.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('RHud.color', getIconColor('boyfriend'))
    setProperty('RHudItemSlots.color', getIconColor('boyfriend'))
    setProperty('RHudTimerBackground.color', getIconColor('boyfriend'))
    end
end


function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
if getModSetting('rhOn', 'Raldi Hud') then

    if not isSustainNote then
    hitsforbotplay = hitsforbotplay + 1
    money = money + moneyGiven[getRandomInt(1, 6)] * 1
    end

if hitsforbotplay == numberOfNotes then Done = true else Done = false end
   end
end

function onUpdatePost(elapsed)
if getModSetting('rhOn', 'Raldi Hud') then
   setProperty('iconP1.y', 600)
   setProperty('iconP1.x', 565) 
   --setProperty('iconP1.scale.x', 0.85) 
  -- setProperty('iconP1.scale.y', 0.85) 
   setProperty('timeTxt.x', -110) 
   setProperty('timeTxt.y', -10) 
   setProperty('botplayTxt.y', 500) 
   setProperty('botplayTxt.x', 408) 
   setTextColor('timeTxt', 'FFFFFF')
   setTextBorder("timeTxt", 0, '000000')  
   setTextFont('timeTxt', funnyFont) 
   setTextSize('timeTxt', 50)
   setTextColor('botplayTxt', 'FFFFFF')
   setTextBorder("botplayTxt", 0, '000000') 
   setTextString('botplayTxt', 'DEBUG MODE')
   setTextFont('botplayTxt', funnyFont) 

   setTextString('charText', boyfriendName)
   setTextString('HealthRaldiHud', ''..math.floor(getProperty("health") * 50)..'%')
   setTextString('MoneyRaldiHud', '$'..money)
   setTextString('NotebooksRaldiHud', hitsforbotplay.. '/' ..numberOfNotes)
   if not Done == true then setTextColor('NotebooksRaldiHud', 'FFFFFF') else setTextColor('NotebooksRaldiHud', 'FFD700') end
    end
end

function getIconColor(chr)
	return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray")))
end

function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end

--[[function onBeatHit()
    setProperty('iconP1.scale.x', 0.60) 
    setProperty('iconP1.scale.y', 0.60) 
    startTween("iconThing", "iconP1.scale.x", 0.78, 0.5)
    startTween("iconThing2", "iconP1.scale.y", 0.78, 0.5)
    setProperty('iconP1.scale.x', 0.60) 
    setProperty('iconP1.scale.y', 0.60) 
    debugPrint('finshed')
end --]]