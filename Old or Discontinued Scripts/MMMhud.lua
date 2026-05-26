-- MMM Hud by Cam the Kirby 

-- NOTE: If you don't like this code click the little X on the top right


local colorsForSongBar = {'FF0000', '0000FF', '00FF00', 'FFFF00', 'FFFFFF', '00FFFF', 'FFA500', 'FFC0CB', '800080', '808080'} -- you can add more colors if you want
local Names = {'Player 1', '[Bot]', 'Player 2', 'CamtheKirby', 'Cam', 'You', 'Sub'} -- Currently Scrapped (Maybe in a V2 Update?)
local ratingColors = {'800080',  '00FF00', 'FFFF00', 'FF0000'} -- You Can Change the colors | 1 = Sick 2 = Good 3 = Ok 4 = Bad
-- I Love Tables

local noEnd = false

---------------------OPTIONS-----------------------
local Jud = true -- if you want the Judgements Thing
----------------------------------------------------

function onCreatePost(char)
  getPropertyFromClass('ClientPrefs', 'comboOffset') 
    makeLuaText('TheSongNameC', songName.. ' (' ..difficultyName.. ')', 0, getProperty('timeTxt.x') + 130, getProperty('timeTxt.y') - 20)
    setObjectCamera('TheSongNameC', 'hud')
    setTextSize('TheSongNameC', 20)
    setProperty('TheSongNameC.color', getColorFromHex(colorsForSongBar[getRandomInt('1', '10')]))
    addLuaText('TheSongNameC', true)

    makeLuaText("VersionTextC", 'v'..version    ,0, 1198, 690) 
       setTextSize('VersionTextC', 23)
       setObjectCamera('VersionTextC','hud');
       setTextAlignment("VersionTextC", "left")
       addLuaText("VersionTextC")
    setProperty('timeBarBG.visible', false)
    setProperty('timeBar.visible', false)
   -- setPropertyFromClass('ClientPrefs', 'comboOffset', 0)

   cmoffset = -4
   cmy = 20
   tnhx = -10
 if Jud == true then
   makeLuaText("jud", 'Judgemnts:', 0, 1150 + cmoffset, 209 + cmy + 30);
   makeLuaText("what", '-------------', 0, 1120 + cmoffset, 229 + cmy + 30);
   makeLuaText("sick", 'Sick: 0', 0, 1170 + cmoffset, 259 + cmy + 30);
   makeLuaText("good", 'Good: 0', 0, 1170 + cmoffset, getProperty('sick.y') + 30);
   makeLuaText("bad", 'Ok: 0', 0, 1170 + cmoffset, getProperty('good.y') + 30);
   makeLuaText("shit", 'Bad: 0', 0, 1170 + cmoffset, getProperty('bad.y') + 30);
 end

 setObjectCamera("jud", 'other');
 setTextSize('jud', 20);
 addLuaText("jud");

   setObjectCamera("what", 'other');
   setTextSize('what', 20);
   addLuaText("what");
  
   setObjectCamera("sick", 'other');
   setTextSize('sick', 20);
   addLuaText("sick");
  
   setTextAlignment('sick', 'left')
   setObjectCamera("good", 'other');
   setTextSize('good', 20);
   addLuaText("good");
   
   setTextAlignment('good', 'left')
   setObjectCamera("bad", 'other');
   setTextSize('bad', 20);
   addLuaText("bad");

   setTextAlignment('bad', 'left')
   setObjectCamera("shit", 'other');
   setTextSize('shit', 20);
   addLuaText("shit");

  
end


function onUpdatePost(elapsed)
    setProperty('Player1C.x', getProperty('boyfriend.x'))
    setTextString('timeTxt', '[' ..getProperty('timeTxt.text').. ']') -- I didn't expect this to work lol
    if hits > 0 or misses > 0 then
        setTextString('scoreTxt', 'Score: ' ..score.. ' | Misses: ' ..misses.. ' | Accuracy: '..(math.floor(getProperty('ratingPercent') * 10000)/100)..'% | Combo: ' ..getProperty('combo'))
        setTextColor('sick', ratingColors[1]);
        setTextColor('good', ratingColors[2]);
        setTextColor('bad', ratingColors[3]);
        setTextColor('shit', ratingColors[4]);
    else
            setTextString('scoreTxt', 'Score: - | Misses: - | Accuracy: - | Combo: -')
            setTextString('sick', 'Sick: 0' )
            setTextString('good', 'Good: 0')
            setTextString('bad', 'Ok: 0')
            setTextString('shit', 'Bad: 0')
            
end
if botPlay then 
setTextString('botplayTxt', 'PE Autoplayer')
setTextString('scoreTxt', ''..getProperty('botplayTxt.text'))
end
if getPropertyFromClass('ClientPrefs', 'timeBarType') == 'Song Name' then
    debugPrint('GO TO THE OPTIONS AND CHANGE THE BAR TYPE TO TIME LEFT OR TIME ELAPSED!')
end



function onUpdate(elapsed)
    setTextString('sick', 'Sick: ' .. getProperty('sicks'))
    setTextString('good', 'Good: ' .. getProperty('goods'))
    setTextString('bad', 'Ok: ' .. getProperty('bads'))
    setTextString('shit', 'Bad: ' .. getProperty('shits'))

    setProperty('showComboNum', false)
    setProperty('showCombo', false)
    if keyboardPressed('ONE') then
    playAnim('boyfriend', 'hey', true)
    elseif keyboardPressed('TWO') then
        playAnim('boyfriend', 'hurt', true)
    elseif keyboardPressed('THREE') then
        playAnim('boyfriend', 'scared', true)
    elseif keyboardPressed('FOUR') then
        playAnim('boyfriend', 'dodge', true)
    elseif keyboardPressed('FIVE') then
        playAnim('boyfriend', 'attack', true)
    elseif keyboardPressed('SIX') then
        playAnim('boyfriend', 'pre-attack', true)
    elseif keyboardPressed('NINE') then
        playAnim('boyfriend', 'singLEFTmiss', true)
    end
   

end
end



function onSongStart()
    debugPrint('[Stage] Selected Song: ', songName, ' (' ..difficultyName.. ')')
end
