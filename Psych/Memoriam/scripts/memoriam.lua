-- Script made by camlikeskirby

deathCounter = getPropertyFromClass('states.PlayState', 'deathCounter')
inMemoriam = false
birthDate = os.date('%m-%d-%Y %H:%M:%S') 
deathDate = ''
isMobile = buildTarget == 'android' or buildTarget == 'ios' or buildTarget == 'unknown'

function onCreate()
if getModSetting('mus', 'Memoriam') then precacheSound('sadDeathSong') end
initLuaShader("desaturate"); -- thanks for https://gamebanana.com/tools/13333 for the shader
end

function onGameOver()
inMemoriam = true; 
deathDate = os.date('%m-%d-%Y %H:%M:%S') 
setHealth(0.1)
setProperty('cameraSpeed', 999.99) 
setProperty('boyfriend.y', -99999)
cameraSetTarget("boyfriend")

setPropertyFromClass('states.PlayState', 'deathCounter', deathCounter + 1)

makeLuaSprite('grayScale') 
setSpriteShader('grayScale', 'desaturate')

if not luaSoundExists('Music') and getModSetting('mus', 'Memoriam') then playSound('sadDeathSong', 1, 'Music') end 

-- borrowed some code from playstate
runHaxeCode([[ 
try { boyfriend.animation.curAnim.finish(); } catch (e:Dynamic) {}
boyfriend.animation.frameName = boyfriend.animation.frameName;
boyfriend.stunned = true;
boyfriend.shader = null;
FlxG.camera.setFilters([]);
for (cam in [game.camGame]) cam.filters = [new ShaderFilter(game.getLuaObject("grayScale").shader)];

FlxG.camera.followLerp = 0; 
persistentUpdate = false; 
persistentDraw = true;

	if(FlxG.sound.music != null) {
		FlxG.sound.music.pause();
		vocals.pause();
		opponentVocals.pause();
	} 
]])

setProperty('camHUD.visible',false) 

setProperty('dad.alpha',0)
setProperty('gf.alpha',0)
setProperty('boyfriend.alpha',0)

makeLuaSprite('bg')
makeGraphic('bg', 1, 100000, '000000')
scaleObject('bg', screenWidth*10, screenHeight*10)
screenCenter('bg')
addLuaSprite('bg')

makeLuaText('deathText', 'In Loving Memory,\n'..boyfriendName..'\n'..birthDate..' - '..deathDate, 0, 150, 200) 
setObjectCamera('deathText', 'other')
setProperty('deathText.alpha',0)
setTextSize('deathText', 40)
addLuaText('deathText')

runTimer('rip')
   return Function_Stop 
end

function onUpdatePost()
  if inMemoriam and not stringStartsWith(version, '1.0') then runHaxeCode([[ 
  boyfriend.animation.pause();
	if(FlxG.sound.music != null) {
		FlxG.sound.music.pause();
		vocals.pause();
		opponentVocals.pause();
	} 
]])
end
end

function onPause()
 if inMemoriam then
    if keyJustPressed('back') then  
    -- so the score doesn't save
    setPropertyFromClass('states.PlayState', 'chartingMode', true) 
    exitSong(true)
  else
    restartSong(true) 
   end
   return Function_Stop
 end
end

function onTimerCompleted(tag)
    if tag == 'rip' then
        doTweenAlpha('bf', 'boyfriend', 1, 5.5, 'circOut')
        doTweenAlpha('text', 'deathText', 1, 5, 'circIn')
    end
end

function onTweenCompleted(tag)
if tag == 'bf' and (getModSetting('autoRestart', 'Memoriam') or isMobile) then restartSong(true) end
end