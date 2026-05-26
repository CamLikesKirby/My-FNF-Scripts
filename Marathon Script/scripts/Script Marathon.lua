-- Script by CamlikesKirby
-- DISCORD: camthekirby
-- V1.0

luaDebugMode = true -- set this to true if you have found a bug

local Marathoning = false
local inMenu = true
local inSaveMenu = false;

local actualModFolder = '' 
local modFolders = {}
local currentSong = ''
local lap = 1
local currentSongArray = {}
local dataFolder = ''

local currentSaveFile = ''
local saves = {}

local totalSongs = 0
local paused = false

local inDiffMenu = false
local difficulties = {}
local changeDiff = 1

local theEnd = false
local marathonScoreInfo = {}
local marathonScoreRatings = {}

local win = false

local settings = {}

function onCreate()
-- all of the vars and stuff
initSaveData('MarathonScript')
Marathoning = getDataFromSave('MarathonScript', 'Marathoning', false)
currentSong = getDataFromSave('MarathonScript', 'currentSong', 1)
lap = getDataFromSave('MarathonScript', 'lap', 1)
currentSongArray = getDataFromSave('MarathonScript', 'currentSongArray', {})
saves = getDataFromSave('MarathonScript', 'saves', {})
currentSaveFile = getDataFromSave('MarathonScript', 'currentSaveFile', '')
inMenu = not isStoryMode and not Marathoning
marathonScoreInfo = getDataFromSave('MarathonScript', 'marathonScoreInfo', 
{
0,-- Score
0, -- Misses
0, -- Best Acc
'' -- Rating FC
}
)
marathonScoreRatings = getDataFromSave('MarathonScript', 'marathonScoreRatings', 
{
0,-- Sick
0, -- Good
0, -- Bad
0 -- Shit
}
)
settings = {
getModSetting('MarathonM', 'Marathon Script'), -- Marathon Mode
getModSetting('firstSongChoice', 'Marathon Script'), -- First Song Played
getModSetting('endless', 'Marathon Script'), -- Endless Mode
getModSetting('allMods', 'Marathon Script'), -- All Mod Packs
getModSetting('autoOneDiff', 'Marathon Script'), -- Auto Select
getModSetting('IBG', 'Marathon Script'), -- (All Mod Packs) Include Base Game
getModSetting('mSAST', 'Marathon Script'), -- Marathon Score Above Score Text
getModSetting('hST', 'Marathon Script') -- Hide Original Score Text
}
end

function onCreatePost()
-- Run Haxe Functions
runHaxeCode([[
using StringTools;
import sys.FileSystem;

createCallback('replace', function(text:String, wordToReplace:String, replacedWord:String) { return text.replace(wordToReplace, replacedWord); }); 

createCallback('isDir', function(path:String) { 
if (FileSystem.exists(path) && FileSystem.isDirectory(path)) { return true; } else { return false; } 
}); 
]])
    
    -- Gets the song's mod folder
    actualModFolder = replace(replace(chartPath, '\\data\\' ..songPath.. '\\'.. songPath.. '' ..difficultyPath.. '.json', ''), '\\', '/')

    runHaxeCode([[import backend.Mods; setVar('modFolders', Mods.parseList().enabled);]])
    modFolders = getVar('modFolders')

    -- Menu
    makeLuaText('marathontext', '[ Marathon Script ]', 0, screenWidth - 900, 100)
    
    mft = 'PLAYING: Base Game' if not stringStartsWith(chartPath, "assets\\shared") and not settings[4] then mft = 'PLAYING: '..replace(actualModFolder, 'mods/', '') else mft = 'PLAYING: All Mod Packs' end

    makeLuaText('modfoldertext', mft, 0, 540, getProperty('marathontext.y') + 50)

    makeLuaText('Selects', '', 0, 580, getProperty('marathontext.y') + 200)

    makeLuaText('Mcontrols', 'Controls: Enter', 0, 400, getProperty('marathontext.y') + 400)

    for _, text in pairs({'marathontext', 'modfoldertext', 'Selects', 'Mcontrols'}) do
    setTextAlignment(text, 'center')
    setTextSize(text, 50)
    setTextBorder(text, 1, 'black', 'outline')
    setObjectCamera(text,"other")
    addLuaText(text)  
    end
    setTextSize('modfoldertext', 30)

   if inMenu then playMusic('breakfast', 1, true) end

   for _, text in pairs({'boyfriend', 'gf', 'dad', 'camHUD'}) do setProperty(text..'.visible', not inMenu) end

   for _, text in pairs({'marathontext', 'modfoldertext', 'Selects',  'Mcontrols'}) do setProperty(text..'.visible', inMenu) end
  -- Marathon Data Setup
  dataFolder = actualModFolder.. '/data'
  if inMenu then getSongs() end

  totalSongs = #currentSongArray
  theEnd = totalSongs == currentSong - 1 

  makeLuaText('MarathonInfoText', 'Marathon - '.. (currentSong - 1).. '/'.. totalSongs, getTextWidth('scoreTxt'), screenWidth - 715, 0)
  -- Marathon Score Text Setting
  if settings[7] then
  Mx = getProperty('healthBar.x') - 340
  My = getProperty('healthBar.y') - 17
  else if getPropertyFromClass('backend.ClientPrefs', 'data.downScroll') then
  Mx = defaultPlayerStrumX0 - 400
  My = defaultPlayerStrumY0 - 17
  else
  Mx = defaultPlayerStrumX0 - 420
  My = defaultPlayerStrumY0 + 100
  end
  end

  makeLuaText('MarathonScoreText', '', getTextWidth('scoreTxt'), Mx, My)

  for _, text in pairs({'MarathonInfoText', 'MarathonScoreText'}) do
  setObjectCamera(text,"hud")
  setProperty(text..'.visible', Marathoning)
  setTextBorder(text, 1, 'black', 'outline')
  addLuaText(text)
  end
  updateMarathonScoreText()
  -- Save Data
  saves = {{marathonScoreInfo, marathonScoreRatings, currentSong - 1, lap, replace(actualModFolder, 'mods/', ''), settings[4]}}
  debugPrint(saves)
end

function onUpdatePost() 
-- Keyboard Shit
if keyboardJustPressed('ONE') and luaDebugMode then endSong() end

if keyJustPressed('back') and (inMenu or inDiffMenu) then
refreshMarathon() exitSong() 
elseif keyJustPressed('back') and inSaveMenu then
playSound('scrollMenu')
inMenu = true
inSaveMenu = false
mainMenuRefresh()
end

if keyboardJustPressed('ENTER') and win and not settings[3] then exitSong() end

if keyboardJustPressed('ENTER') and win and settings[3] then 
setDataFromSave('MarathonScript', 'lap', lap + 1)
setDataFromSave('MarathonScript', 'currentSong', 1)
currentSong = getDataFromSave('MarathonScript', 'currentSong', 1)
getSongs()
totalSongs = #currentSongArray

diffSelect(getCurrentSongArray(currentSong, 1))
playSound('scrollMenu')
end

if inMenu then
if keyJustPressed('reset') and luaDebugMode then restartSong() end
if keyboardJustPressed('ENTER') and not inDiffMenu then diffSelect(getCurrentSongArray(currentSong, 1)) playSound('scrollMenu') end
end

if keyboardJustPressed('SPACE') and inDiffMenu then nextMarathonSong() end

if keyJustPressed('ui_left') and inDiffMenu then
playSound('scrollMenu')
if changeDiff == 1 then changeDiff = #difficulties else changeDiff = changeDiff - 1 end
setProperty('Selects.text', 'Select Difficulty:'.. difficulties[changeDiff])
end

if keyJustPressed('ui_right') and inDiffMenu then
playSound('scrollMenu')
if changeDiff == #difficulties then changeDiff = 1 else changeDiff = changeDiff + 1 end
setProperty('Selects.text', 'Select Difficulty:'.. difficulties[changeDiff])
end

if keyboardJustPressed('S') and not inSaveMenu and not inDiffMenu then saveMenu() end

end

function goodNoteHit(i)
-- Marathon Score
-- Can't find a better better way to do this. Maybe in another update. Atleast its easily customizable now.
Scores = {350, 200, 100, 50}
addedScore = 0
for e, rating in pairs({'sick', 'good', 'bad', 'shit'}) do if getPropertyFromGroup('notes', i, 'rating') == rating then 
marathonScoreRatings[e] = marathonScoreRatings[e] + 1  
addedScore = Scores[e] 
end end
marathonScoreInfo[1] = marathonScoreInfo[1] + addedScore 
updateMarathonScoreText()
end

function noteMiss() marathonScoreInfo[2] = marathonScoreInfo[2] + 1 
marathonScoreInfo[1] = marathonScoreInfo[1] - 10 updateMarathonScoreText() end

function onEndSong()
-- Ending/Loop
if round(rating * 100, 2) > marathonScoreInfo[3] then marathonScoreInfo[3] = round(rating * 100, 2) end 
if Marathoning and not theEnd then diffSelect(getCurrentSongArray(currentSong, 1)) 
else
Marathoning = not settings[3] 
win = true
youWin(settings[3])
end
return Function_Stop
end

function getSongs()
-- Complex Song Stuff
if settings[4] then
    currentSongArray = {}
 -- this surpisingly works well
  if settings[6] then table.insert(modFolders,'assets/shared/data') end

  for m = 1,#modFolders,1 do
  if modFolders[m] == 'assets/shared/data' then d = modFolders[m] else d = 'mods/'.. modFolders[m].. '/data' end
  c = directoryFileList(d)
  nonFolders = {} 
  
  for i = 1,#c,1 do
      if not isDir(d ..'/'.. c[i]) then
      table.insert(nonFolders, i)
      end
      if modFolders[m] == 'assets/shared/data' then c[i] = {c[i], ''} else c[i] = {c[i], modFolders[m]} end
  end

  for i = 1,#nonFolders,1 do table.remove(c, nonFolders[i] - (i - 1)) end

  for i = 1,#c,1 do table.insert(currentSongArray, c[i]) end
  end
 else
  currentSongArray = directoryFileList(dataFolder)
  nonFolders = {} 
  for i = 1,#currentSongArray,1 do
      if not isDir(dataFolder ..'/'.. currentSongArray[i]) then
      table.insert(nonFolders, i)
      end
    end

-- FINALLY IT WORKS 
for i = 1,#nonFolders,1 do table.remove(currentSongArray, nonFolders[i] - (i - 1)) end
end
    
    if settings[1] == 'Randomized' then
     random = {}
     for i = 1, #currentSongArray,1 do 
      number = getRandomInt(1, #currentSongArray)
      table.insert(random, currentSongArray[number])
      table.remove(currentSongArray, number)
     end
     currentSongArray = random
    end
    -- Had to change how this works because getCurrentSongArray was not acting right
    r = false
    tableV = 1
    for i = 1, #currentSongArray,1 do if getCurrentSongArray(i, 1) == songPath then r = true tableV = i end end

    if settings[2] and inMenu and r then table.remove(currentSongArray, tableV)
    if settings[4] then table.insert(currentSongArray, 1, {songPath, getCurrentSongArray(tableV, 2)}) else table.insert(currentSongArray, 1, songPath) end
    end
  setDataFromSave('MarathonScript', 'currentSongArray', currentSongArray) 
end

function mainMenuRefresh()
setTextString('marathontext', '[ Marathon Script ]')
mft = 'PLAYING: Base Game' if not stringStartsWith(chartPath, "assets\\shared") then mft = 'PLAYING: '..replace(actualModFolder, 'mods/', '') end
setTextString('modfoldertext', mft)
setTextString('Selects', '')
setTextString('Mcontrols', 'Controls: Enter')
for _, text in pairs({'marathontext', 'modfoldertext', 'Selects', 'Mcontrols'}) do setProperty(text..'.visible', true) end
end

function saveMenu()
playSound('scrollMenu')
inSaveMenu = true
inMenu = false
setTextString('marathontext', '[ Saves ]')
setProperty('modfoldertext.visible', false)
end

function diffSelect(song)
  inDiffMenu = true
  if not inMenu then playMusic('breakfast', 1, true) end

  for _, text in pairs({'marathontext', 'modfoldertext', 'Selects', 'Mcontrols'}) do setProperty(text..'.visible', true) end
  setProperty('camHUD.visible', false)
  
  setProperty('Selects.x', getProperty('Selects.x') - 230)
  mft = getProperty('modfoldertext.text') if settings[4] then mft = getCurrentSongArray(currentSong,2) end
  setProperty('modfoldertext.text', mft.. '\n'.. currentSong.. '/'.. totalSongs)
  setProperty('marathontext.text', 'Next Song: '..song)
  setProperty('Mcontrols.text', 'Controls: Left, Right, Space')

  if settings[4] and getCurrentSongArray(currentSong, 2) ~= "" then 
  songFiles = directoryFileList('mods/'..getCurrentSongArray(currentSong, 2).. '/data/' ..song) 
  else if settings[6] and getCurrentSongArray(currentSong, 2) == '' then 
  songFiles = directoryFileList('assets/shared/data/'..song) 
  else songFiles = directoryFileList(dataFolder.. '/'.. song) end end

  for i = 1,#songFiles,1 do
     if stringStartsWith(songFiles[i], song) and stringEndsWith(songFiles[i], '.json') then
      diff = replace(replace(songFiles[i], song.. '-', ''), '.json', '') 
      normalDiffCheck = replace(songFiles[i], '.json', '') -- incase a difficulty is named after its song (rare but still needed)
      if not stringStartsWith(normalDiffCheck, song.. '-') then
      table.insert(difficulties, 'normal')
      else
      table.insert(difficulties, diff)
      end
     end
    end

  if #difficulties == 1 and settings[5] then nextMarathonSong() end

setProperty('Selects.text', 'Select Difficulty:'.. difficulties[1])
end

function youWin(endless)
playMusic('tea-time', 1, true)

setObjectCamera('MarathonScoreText',"other")
for _, text in pairs({'marathontext','modfoldertext', 'Mcontrols'}) do setProperty(text..'.visible', true) end
setProperty('camHUD.visible', false)

setProperty('marathontext.x', getProperty('marathontext.x') + 150)
setProperty('modfoldertext.x', getProperty('modfoldertext.x') + 50)

if endless then 
setProperty('marathontext.text', 'LAP '.. lap.. ' DONE!') 
setProperty('Mcontrols.text', 'CONTINUE?\nControls: ENTER')
else 
refreshMarathon() 
setProperty('Mcontrols.text', 'Controls: ENTER')
setProperty('marathontext.text', 'YOU WIN!!') 
end
setProperty('modfoldertext.text', getProperty('modfoldertext.text').. '\n'.. (currentSong - 1).. '/'.. totalSongs)
end

function nextMarathonSong()
playSound('confirmMenu')
setDataFromSave('MarathonScript', 'Marathoning', true) 
setPropertyFromClass('backend.Difficulty', 'list', {difficulties[changeDiff]})
setDataFromSave('MarathonScript', 'marathonScoreInfo', marathonScoreInfo) 
if settings[4] then changeModTo(getCurrentSongArray(currentSong, 2)) end
loadSong(getCurrentSongArray(currentSong, 1),0)
setDataFromSave('MarathonScript', 'currentSong', currentSong + 1)
setDataFromSave('MarathonScript', 'marathonScoreRatings', marathonScoreRatings)
end

function refreshMarathon()
setDataFromSave('MarathonScript', 'Marathoning', false)
setDataFromSave('MarathonScript', 'currentSong', 1)
setDataFromSave('MarathonScript', 'lap', 1)
setDataFromSave('MarathonScript', 'marathonScoreInfo', {0,0,0,''})
setDataFromSave('MarathonScript', 'marathonScoreRatings', {0,0,0,0})
end

function changeModTo(mod) runHaxeCode([[import backend.Mods; Mods.currentModDirectory = m; ]], {m = mod}) end

function updateMarathonScoreText()
  mratingFC = ''
  acc = marathonScoreInfo[3]
  if acc == 0 then acc = '?' else acc = acc..'%' end

  -- unoptimized code GO!
  if marathonScoreInfo[2] == 0 then
    if marathonScoreRatings[3] > 0 or marathonScoreRatings[4] > 0 then mratingFC = ' - FC'
    elseif marathonScoreRatings[2] > 0 then mratingFC = ' - GFC'
    elseif marathonScoreRatings[1] > 0 then mratingFC = ' - SFC'
  end
  else 
  if marathonScoreInfo[2] < 10 then mratingFC = ' - SDCB' else mratingFC = ' - Clear' end
  end
setProperty('scoreTxt.visible', not settings[8])
setTextString('MarathonScoreText', 'Marathon Score: '.. marathonScoreInfo[1].. ' | Marathon Misses: '..marathonScoreInfo[2].. ' | Best Accuracy: '..acc..mratingFC)
end

function getCurrentSongArray(i, n)
  if settings[4] then return currentSongArray[i][n]
  else return currentSongArray[i] end
end

function round(x, n)
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end

function onStartCountdown() if inMenu then setProperty('inCutscene', false) return Function_Stop end end

function onPause() paused = true end function onResume() paused = false end -- only way I could figure a way out to do this because im dumb

function onDestroy() 
if paused then refreshMarathon() end 
flushSaveData('MarathonScript') 
end

function onGameOver() refreshMarathon() end