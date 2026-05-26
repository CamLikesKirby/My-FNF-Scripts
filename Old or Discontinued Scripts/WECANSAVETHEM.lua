--This script is too long for a joke

local Yeah = 0
local freezed = true -- if you want them to be freezed
local TweenThing = true -- the doTween on 52
function onCreatePost()

  precacheSound("cartoon-slurp-37066")
  setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)
  
makeLuaText('TexttheTestsoThesososoThetextext', 'Licks: ' ..Yeah, '0', '40', '600')
setTextSize('TexttheTestsoThesososoThetextext', 30)
addLuaText('TexttheTestsoThesososoThetextext', true)
if freezed == true then
makeLuaText('lliiccckkk', 'EVERYONE START LICKING WE CAN SAVE THEM!!!!!!', '0', '30', '100')
setTextSize('lliiccckkk', 50)
setProperty('lliiccckkk.color', getColorFromHex ("FF7800"))
addLuaText('lliiccckkk', true)
else
  makeLuaText('lliiccckkk', ' START LICKING THEM!!!!!!', '0', '30', '100')
setTextSize('lliiccckkk', 50)
setProperty('lliiccckkk.color', getColorFromHex ("FF7800"))
addLuaText('lliiccckkk', true)
end

end


 -- The Thing 
 function onUpdate(elapsed, focus)
  if not opponentNoteHit then
    debugPrint('wrok')
    playAnim('dad', 'idle', true, false, 100)
  end
  if freezed == true then
    setProperty('dad.color', getColorFromHex ("007FFF"))
    setProperty('iconP2.color', getColorFromHex ("007FFF"))
    setHealthBarColors('007FFF', '66FF33');
   end
    if keyboardJustPressed('SPACE') or mouseReleased('left') and funny == 1 then
      --  debugPrint('Licked')
      playAnim('boyfriend', 'singLEFT', true)
        playSound("cartoon-slurp-37066",2)
        Yeah = Yeah + 1 
        setTextString('TexttheTestsoThesososoThetextext', 'Licks: ' ..Yeah)
        -- from Vs Whitty Psych Engine
        makeLuaSprite('lastRating', 'Licked', '400', '250');
		setObjectCamera('lastRating','hud');

		setProperty('lastRating.velocity.y', math.random(-140, -175));
		setProperty('lastRating.velocity.x', math.random(-10));
		setProperty('lastRating.acceleration.y', 550);
		runTimer('lastRatingTimer', crochet / 1000);

		setScrollFactor('lastRating', 1, 1);
		scaleObject('lastRating', 0.7, 0.7);
		updateHitbox('lastRating');

		addLuaSprite('lastRating', true);
       
        
      end
 end
function onMoveCamera(focus)
if focus == 'dad' then
	--	debugPrint('Lick Them')

        if TweenThing == true then
          doTweenX('LICK', 'boyfriend', defaultOpponentX, '0.5')
        else
          doTweenX('LICK', 'boyfriend', '250', '0.5')
        end

       -- runTimer('idk', '1')
        setProperty('TexttheTestsoThesososoThetextext.visible', true)
        setProperty('lliiccckkk.visible', true)
 funny = 1
elseif focus == 'boyfriend' and funny == 1 then
    --debugPrint('noLICK')
    -- idk how to move the camera
            doTweenX('noLICK', 'boyfriend', defaultBoyfriendX, '0.5')
            --runTimer('idk2', '1')
            setProperty('TexttheTestsoThesososoThetextext.visible', false)
            setProperty('lliiccckkk.visible', false)
            funny = 0
        end
	end
  function opponentNoteHit(id, direction, noteType, isSustainNote)
 if freezed then
    --debugPrint('savehimNOW')
    if direction == 0 then 
      playAnim('dad', 'singLEFT', true, false, 100)
    end
      if direction == 1 then 
        playAnim('dad', 'singDOWN', true, false, 100)
      end
        if direction == 2 then 
          playAnim('dad', 'singUP', true, false, 100)
        end
          if direction == 3 then 
            playAnim('dad', 'singRIGHT', true, false, 100)    
          end
  
    end
  end