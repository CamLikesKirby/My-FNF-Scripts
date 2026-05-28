-- script made by camlikeskirby (Username on a lot of sites)
-- DISCORD: camthekirby

-- vars

local Chars = {}
local CharsGF = {}
local thing = false
local num = 1
local numGF = 1
local folders = ''
local modNames = {'Character Select'}
local blockedCharacters = {}
local blockedCharactersGF = {}
local savebf = ''
local savegf = ''
local ogbf = boyfriendName
local oggf = gfName
local onCharacter = 'bf'
local saving = 'true'
local CharFolder = {  
"bf",
"dad",
"spooky",
"pico",
"mom",
"mom-car",
"bf-car",
"parents-christmas",
"monster-christmas",
"bf-christmas",
"monster",
"bf-pixel",
"senpai",
"senpai-angry",
"spirit",
"bf-pixel-opponent",
"tankman",
"bf-holding-gf",
"pico-player",
"tankman-player"}

-- for 0.6.3
local BaseCharacters = false
local BaseCharactersGF = false
local ModCharacters = true
local LoadCharacterswithC = false
local PreloadCharacters = false
local PreloadCharactersGF = false
local AnyGF = false
local SavedCharacterFirst = false

function onCreatePost()
 -- stuff
    folders = directoryFileList('mods')
    cameraSetTarget("boyfriend")
    setProperty('gf.alpha', 0.3)
    
    makeLuaText("charName", "", 0, 770, 450)
    setTextSize("charName", 30)
    setObjectCamera("charName","other")
    addLuaText("charName")

    makeLuaText("controlsTxt", 'Use G and B to switch between BF and GF. Use S to save your characters or not.',0, -1, 700)
    setProperty('controlsTxt.borderSize', 1.25)
    setObjectCamera('controlsTxt','other');
    setTextAlignment("controlsTxt", "left")
    addLuaText("controlsTxt")

    initSaveData('autoCharacterSelect')

    savebf = getDataFromSave('autoCharacterSelect', 'bf', 'bf') -- I did NOT know that you could set the default var
    savegf = getDataFromSave('autoCharacterSelect', 'gf', 'gf')
    saving = getDataFromSave('autoCharacterSelect', 'save', 'true')

if not stringStartsWith(version, '0.6.3') then 
   runHaxeCode([[
    createCallback('checkAnimation', function(text:String, character:String) {
        if (character == 'b') {
            return boyfriend.animation.getByName(text) != null;
        } else if (character == 'd') {
            return dad.animation.getByName(text) != null;
        } else if (character == 'g') {
            return gf.animation.getByName(text) != null;
        } else {
            return boyfriend.animation.getByName(text) != null;
        }
    });
]])
end

if gfName == nil then
    gfNamelol = 'gf'
else
    gfNamelol = gfName
end

if boyfriendName == nil then
    boyfriendNamelol = 'bf'
else
    boyfriendNamelol = boyfriendName
end

  if getModSettingCamVer('sCF', 'Character Select', SavedCharacterFirst) then
    table.insert(Chars, savebf)
    table.insert(Chars, boyfriendNamelol)
    table.insert(CharsGF, savegf)
    table.insert(CharsGF,gfNamelol)
  else 
   table.insert(Chars, boyfriendNamelol)
   table.insert(Chars, savebf)
   table.insert(CharsGF,gfNamelol)
   table.insert(CharsGF, savegf)
  end

-- doing this so there isn't messy code everywhere
-- Gets all the characters messy code but gets the job done

   addTheCharacters()


   if getModSettingCamVer('sCF', 'Character Select', SavedCharacterFirst) then
   triggerEvent("Change Character", "0", Chars[num])
   triggerEvent("Change Character", "2", CharsGF[numGF])
   cameraSetTarget('boyfriend')
   end
end

function onStartCountdown()
   -- the dance 
    gfdance = 1
    runTimer('Dance', 0.7, 0)
    if not allowCountdown and not inCutscene then
        allowCountdown = true;
  return Function_Stop;
  end
  cancelTimer("Dance")
 return Function_Continue;
 
end 


function onUpdate(elapsed) 
    -- the character select stuff
    if thing == false then
        setProperty('camHUD.alpha', 0)
        setProperty('dad.alpha', 0)
        
        if onCharacter == 'bf' then
        setTextString("charName", '< '..Chars[num]..' >\nD, F, J, K\n'.. num.. '/'.. #Chars.. '\nSaving: '.. saving)
        else
        setTextString("charName", '< '..CharsGF[numGF]..' >\nD, F, J, K\n'.. numGF.. '/'.. #CharsGF.. '\nSaving: '.. saving)
        end
        
        if keyboardJustPressed("RIGHT") then
            if onCharacter == 'bf' then
            if num + 1 >= #Chars + 1 then
                num = 1
            else
                num = num + 1
            end
            if not getModSettingCamVer('lcwC', 'Character Select', LoadCharacterswithC) then
            triggerEvent("Change Character", "0", Chars[num])
            cameraSetTarget("boyfriend")
            end
        else
            if numGF + 1 >= #CharsGF + 1 then
                numGF = 1
            else
                numGF = numGF + 1
            end
            if not getModSettingCamVer('lcwC', 'Character Select', LoadCharacterswithC) then
            triggerEvent("Change Character", "2", CharsGF[numGF])
            triggerEvent('Camera Follow Pos',getMidpointX('gf')+getProperty('gf.cameraPosition[0]'),getMidpointY('gf')+getProperty('gf.cameraPosition[1]'));
            end
        end
    end
    
        if keyboardJustPressed("LEFT") then
            if onCharacter == 'bf' then
            if num + 1 >= #Chars + 1 then
                num = num - 1
            else
                num = num - 1
            end
            if num == 0 then
                num = #Chars
            end
            if not getModSettingCamVer('lcwC', 'Character Select', LoadCharacterswithC) then
            triggerEvent("Change Character", "0", Chars[num])
            cameraSetTarget("boyfriend")
            end
        else
            if numGF + 1 >= #CharsGF + 1 then
                numGF = numGF - 1
            else
                numGF = numGF - 1
            end
            if numGF == 0 then
                numGF = #CharsGF
            end
            if not getModSettingCamVer('lcwC', 'Character Select', LoadCharacterswithC) then
            triggerEvent("Change Character", "2", CharsGF[numGF])
            triggerEvent('Camera Follow Pos',getMidpointX('gf')+getProperty('gf.cameraPosition[0]'),getMidpointY('gf')+getProperty('gf.cameraPosition[1]'));
            end
        end
    end
    
    if onCharacter == 'bf' then
        if keyboardJustPressed('D') then
        playAnim("boyfriend", "singLEFT", true, false, 0) 
        end

        if keyboardJustPressed('F') then
        playAnim("boyfriend", "singDOWN", true, false, 0) 
        end

        if keyboardJustPressed('J') then
        playAnim("boyfriend", "singUP", true, false, 0) 
        end
    
        if keyboardJustPressed('K') then
        playAnim("boyfriend", "singRIGHT", true, false, 0) 
        end
    end

    if keyboardJustPressed('S') then
    if saving == 'true' then
        saving = 'false'
        setDataFromSave('autoCharacterSelect', 'save', 'false')
    else
        saving = 'true'
         setDataFromSave('autoCharacterSelect', 'save', 'true')
    end
        end

        if keyboardJustPressed('C') then
            if getModSettingCamVer('lcwC', 'Character Select', LoadCharacterswithC) then
           if onCharacter == 'bf' then
            triggerEvent("Change Character", "0", Chars[num])
            cameraSetTarget("boyfriend")
           else
            triggerEvent("Change Character", "2", CharsGF[numGF])
            triggerEvent('Camera Follow Pos',getMidpointX('gf')+getProperty('gf.cameraPosition[0]'),getMidpointY('gf')+getProperty('gf.cameraPosition[1]'));
           end
        end
            end
            
-- debug stuff 
            if keyboardJustPressed('E') and keyboardJustPressed('A')then
                eraseSaveData('autoCharacterSelect')
                exitSong(true)
                end

        if keyboardJustPressed('B') then
            onCharacter = 'bf'
            triggerEvent('Camera Follow Pos',nil,nil);
            cameraSetTarget("boyfriend")
            setProperty('gf.alpha', 0.3)
            setProperty('boyfriend.alpha', 1)
            end

            
        if keyboardJustPressed('G') then
            onCharacter = 'gf'
            triggerEvent('Camera Follow Pos',getMidpointX('gf')+getProperty('gf.cameraPosition[0]'),getMidpointY('gf')+getProperty('gf.cameraPosition[1]'));
            setProperty('boyfriend.alpha', 0.3)
            setProperty('gf.alpha', 1)
            end
    end
    
if keyJustPressed('accept') and not inCutscene then
    if not thing then
    thing = true;

    triggerEvent('Camera Follow Pos',nil,nil);

    if getModSettingCamVer('lcwC', 'Character Select', LoadCharacterswithC) then
        triggerEvent("Change Character", "0", Chars[num])
        triggerEvent("Change Character", "2", CharsGF[numGF])
    end

    if saving == 'true' then

    if getModSettingCamVer('sCF', 'Character Select', SavedCharacterFirst) then
        thinS = not (num == 2)
        thinSGF = not (numGF == 2)
    else
    thinS = num > 1
    thinSGF = numGF > 1
    end

    if thinS then
        debugPrint()
    setDataFromSave('autoCharacterSelect', 'bf', Chars[num])
    end

    if thinSGF then
    setDataFromSave('autoCharacterSelect', 'gf', CharsGF[numGF])
    end
end
    if not stringStartsWith(version, '0.6.3') then 
    if checkAnimation('hey', 'b') then
    playAnim("boyfriend", "hey", true, false, 0)
    else
    playAnim("boyfriend", "singUP", true, false, 0)  
    end

    if checkAnimation('cheer', 'g') then
    playAnim("gf", "cheer", true, false, 0) 
    elseif checkAnimation('hey', 'g') then 
    playAnim("gf", "hey", true, false, 0)  
    else
    playAnim("gf", "singUP", true, false, 0) 
    end
else
    playAnim("boyfriend", "hey", true, false, 0)
    playAnim("gf", "cheer", true, false, 0) 
end
        startCountdown()

        doTweenAlpha('dad.alpha', 'dad', 1, 1.5, 'sineInOut')
        doTweenAlpha('camHUD.alpha', 'camHUD', 1, 1.5, 'sineInOut')
        doTweenAlpha('charName.alpha', 'charName', 0, 1.5, 'sineInOut')
        doTweenAlpha('controlsTxt.alpha', 'controlsTxt', 0, 1.5, 'sineInOut')
        doTweenAlpha('gf.alpha', 'gf', 1, 1, 'sineInOut')
        doTweenAlpha('bf.alpha', 'boyfriend', 1, 1, 'sineInOut')
        end
    end
end

function onSongStart()
    removeLuaText("charName", true)
    removeLuaText("controlsTxt", true)
    end

function onDestroy()
    flushSaveData('autoCharacterSelect')
end


function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'Dance' then
        playAnim("boyfriend", "idle", false, false, 0)
     
        if gfdance == 1 then
            gfdance = 0
        else
            gfdance = gfdance + 1
    end

        if gfdance == 0 then
        playAnim("gf", "danceLeft", false, false, 0) 
        else
        playAnim("gf", "danceRight", false, false, 0) 
        end
    end
end

function addTheCharacters()
    
    if stringStartsWith(version, '1.0') then
    table.insert(CharFolder, 'darnell')
    end

    if getModSettingCamVer('baCh', 'Character Select', BaseCharacters) then
        for i = 1,#CharFolder,1 do
            if not contains(blockedCharacters,CharFolder[i]) then
       table.insert(Chars, CharFolder[i])
            end
        end
    end

    if getModSettingCamVer('baChgf', 'Character Select', BaseCharactersGF) then
        CharFolder = {'gf', 'gf-car', 'gf-christmas', 'gf-pixel', 'gf-tankmen', 'pico-speaker'}
        for i = 1,#CharFolder,1 do
            if not contains(blockedCharactersGF,CharFolder[i]) then
       table.insert(CharsGF, CharFolder[i])
            end
        end
    end  
    
for i = 1,#folders,1 do
    
   theMod = 'mods/' ..folders[i]

   if contains(modNames,folders[i]) then
   
   CharFolder = directoryFileList('mods/' ..folders[i].. '/characters')

   for i = 1,#CharFolder,1 do
    
    if stringEndsWith(CharFolder[i], ".json") then
        wJ = string.gsub(CharFolder[i], "%.json$", "")
        if getModSettingCamVer('pload', 'Character Select', PreloadCharacters) then
        addCharacterToList(wJ, 'boyfriend')
        end
        
        if not stringStartsWith(CharFolder[i], "gf-") and not contains(blockedCharacters,wJ) then
table.insert(Chars, wJ)
        end
        
        if getModSettingCamVer('gfunlocked', 'Character Select', AnyGF) and not contains(blockedCharactersGF,wJ) then
            table.insert(CharsGF, wJ)
        end

if stringEndsWith(CharFolder[i], ".json") and stringStartsWith(CharFolder[i], "gf-") then
wJ = string.gsub(CharFolder[i], "%.json$", "")
if getModSettingCamVer('ploadgf', 'Character Select', PreloadCharactersGF) then
addCharacterToList(wJ, 'gf')
end
if not contains(blockedCharactersGF,wJ) then
table.insert(CharsGF, wJ)
end
    end
end
end
   end
        end
        if getModSettingCamVer('moCh', 'Character Select', ModCharacters) then
        CharFolder = directoryFileList('mods/characters')
        for i = 1,#CharFolder,1 do
            if stringEndsWith(CharFolder[i], ".json") then
                wJ = string.gsub(CharFolder[i], "%.json$", "")
                if getModSettingCamVer('pload', 'Character Select', PreloadCharacters) then
                addCharacterToList(wJ, 'boyfriend')
                end
         if not stringStartsWith(CharFolder[i], "gf-") and not contains(blockedCharacters,wJ) then
table.insert(Chars, wJ)
        end
       if getModSettingCamVer('gfunlocked', 'Character Select', AnyGF) and not contains(blockedCharactersGF,wJ) then
        table.insert(CharsGF, wJ)
    end

       if stringEndsWith(CharFolder[i], ".json") and stringStartsWith(CharFolder[i], "gf-") then
        wJ = string.gsub(CharFolder[i], "%.json$", "")
        if getModSettingCamVer('ploadgf', 'Character Select', PreloadCharactersGF) then
        addCharacterToList(wJ, 'gf')
        end
        if not contains(blockedCharactersGF,CharFolder[i]) then
        table.insert(CharsGF, wJ)
        end
    end
            end
        end
    end
end

function contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end


function getModSettingCamVer(name, modFolder, vaule)
    if not stringStartsWith(version, '0.6.3') then 
      return getModSetting(name, modFolder)
    else
        return vaule
    end
end