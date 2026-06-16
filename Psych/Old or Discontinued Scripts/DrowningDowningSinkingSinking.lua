local theWaterIThink = 0
-- Made by Cam the Kirby 
function onCreate()  
    makeLuaSprite('DrowningSinkinglolollol', 'Water2D', -90, 300)
    setScrollFactor('DrowningSinkinglolollol', '0', '0')
    setObjectCamera('DrowningSinkinglolollol', 'hud')
    setProperty('DrowningSinkinglolollol.color', getColorFromHex ("007FFF")) -- you can change this
    scaleObject('DrowningSinkinglolollol', 4, 4)
    addLuaSprite('DrowningSinkinglolollol', true);
-- Hitboxs lolololol
    makeGraphic('Hitbox1', '1000', '1000', '000000')
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
 --if not isSustainNote then
    theWaterIThink = theWaterIThink - 1
    if theWaterIThink < 0 then
        theWaterIThink = 0
    end
    debugPrint('The Water Level:', theWaterIThink)
 end
--end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    if not isSustainNote then
        theWaterIThink = theWaterIThink + 1
       
        if theWaterIThink > 10 then
            theWaterIThink = 10
        end
        if theWaterIThink == 1 then
            doTweenY('TheWaterpeter1', 'DrowningSinkinglolollol', -80, '0.1', 'linear')
        end
        if theWaterIThink == 2 then
            doTweenY('TheWaterpeter1', 'DrowningSinkinglolollol', -160, '0.1', 'linear')
        end
        if theWaterIThink == 3 then
            doTweenY('TheWaterpeter1', 'DrowningSinkinglolollol', -240, '0.1', 'linear')
        end
        if theWaterIThink == 4 then
            doTweenY('TheWaterpeter1', 'DrowningSinkinglolollol', -320, '0.1', 'linear')
        end
        if theWaterIThink == 5 then
            doTweenY('TheWaterpeter1', 'DrowningSinkinglolollol', -400, '0.1', 'linear')
        end
        if theWaterIThink == 6 then
            doTweenY('TheWaterpeter1', 'DrowningSinkinglolollol', -480, '0.1', 'linear')
        end
        if theWaterIThink == 7 then
            doTweenY('TheWaterpeter1', 'DrowningSinkinglolollol', -560, '0.1', 'linear')
        end
        if theWaterIThink == 8 then
            doTweenY('TheWaterpeter1', 'DrowningSinkinglolollol', -640, '0.1', 'linear')
        end
        if theWaterIThink == 9 then
            doTweenY('TheWaterpeter1', 'DrowningSinkinglolollol', -720, '0.1', 'linear')
        end
        if theWaterIThink == 10 then
            doTweenY('TheWaterpeter1', 'DrowningSinkinglolollol', -800, '0.1', 'linear')
            setHealth(0)
        end
        debugPrint('The Water Level:', theWaterIThink)
        
     end
end

function onUpdate(elapsed)

 end