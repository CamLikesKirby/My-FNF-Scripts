local noteHit = false
local fakeScore = 0

local sectionHits = 0
local sectionMisses = 0
local sectionRatings = {
0, -- Sick
0, -- Good
0, -- Bad
0  -- Shit
}
local lastRating = 0
local result = true
local inEndSong = false
local wasOnDad = true
local noteAmount = 0

local scoreText = ''

local settings = {
getModSetting('System', 'Parappa Hud v2'), -- The Systems
getModSetting('isSus', 'Parappa Hud v2'), -- Sustain
}

function onCreate() setTextString('scoreTxt', 'Score: '..fakeScore) end

function goodNoteHit(i, d, n, s)
    for e, rating in pairs({'sick', 'good', 'bad', 'shit'}) do if getPropertyFromGroup('notes', i, 'rating') == rating then sectionRatings[e] = sectionRatings[e] + 1 end end
    noteHit = true
    if s and settings[2] or not s then sectionHits = sectionHits + 1 end
end

function noteMiss(i, d, n, s) noteHit = true  if s and settings[2] or not s then sectionMisses = sectionMisses + 1 end end

function noteMissPress() noteHit = true  sectionMisses = sectionMisses + 1 end

function onMoveCamera(character)  
if character == 'dad' and noteHit and not wasOnDad then 
rateTime()    
wasOnDad = true
end
if character == 'boyfriend' or character == 'gf' then wasOnDad = false end
end

function onUpdatePost()
if keyJustPressed('accept') and inEndSong then result = false endSong() end 
scoreText = 'Score: '..fakeScore.. ' | Misses: '.. sectionMisses ..' | Accuracy: '.. roundAcc(getProperty('ratingPercent')).. '% | Note Hits/Holds: '.. noteAmount
if not inEndSong then setTextString('scoreTxt', scoreText) end
end

function onEndSong()
inEndSong = true 
if noteHit and (sectionHits + sectionMisses) ~= 0 then rateTime() end
setProperty('camHUD.visible', true)
scoreText = 'Score: '..fakeScore.. ' | Misses: '.. sectionMisses ..' | Accuracy: '.. roundAcc(getProperty('ratingPercent')).. '% | Note Hits/Holds: '.. noteAmount
setTextString('scoreTxt', 'FINAL RESULTS: '.. scoreText.. ' | Press Enter to Continue')
if not result then return Function_Continue; end
return Function_Stop;
end

function rateTime() 
ratingper = 0
hit = 0
ratescore = 0

noteHit = false
totalHits = sectionHits + sectionMisses
if settings[1] == 'Rating Based' or settings[1] == 'Complex' then badNotes = sectionMisses + sectionRatings[3] + sectionRatings[4] else badNotes = sectionMisses end
noteAmount = sectionHits.. '/'.. totalHits
hit = sectionHits - (sectionMisses * 2)
s = {5, 3, -10, -30}
for i = 1,#sectionRatings,1 do
    for e = 1,sectionRatings[i],1 do ratescore = ratescore + s[i] end
end

if lastRating ~= 0 then ratingper = (roundAcc(getProperty('ratingPercent')) - roundAcc(lastRating)) / 10
elseif lastRating  > 94 and (roundAcc(getProperty('ratingPercent')) - roundAcc(lastRating)) / 10 < 10 then ratingper = 10 end


if settings[1] == 'Simple' then finalScore = hit
else if settings[1] == 'Accuracy Based' then finalScore = (hit) + (ratingper)
else if settings[1] == 'Rating Based' then finalScore = (hit) + (ratescore)
else finalScore = (hit) + (ratescore) + (ratingper) end end end
if finalScore > 1000 then finalScore = 1000 end
if finalScore < -300 then finalScore = -300 end

fakeScore = round(fakeScore + finalScore, 0)

if roundAcc(badNotes / totalHits) > 65 or roundAcc(sectionHits / totalHits) < 65 or finalScore < 1 then
playSound('did_bad')
else
playSound('did_good')
end

sectionHits = 0
sectionMisses = 0
sectionRatings = {0,0,0,0}
lastRating = getProperty('ratingPercent')
end

function roundAcc(var) return math.floor(var * 10000)/100 end

function round(number, decimals)
    local power = 10^decimals
    return math.floor(number * power) / power
end
