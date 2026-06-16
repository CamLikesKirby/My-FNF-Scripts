local hideRatings = getModSetting('hideRatings', 'Raldi Hud')  -- self explanatory
local hideTimeBar = getModSetting('hideTimeBar', 'Raldi Hud')  -- self explanatory
local startFlash = getModSetting('startFlash', 'Raldi Hud') -- Will have a flash at the start

function onStartCountdown()
    if startFlash then
    cameraFlash('game', 'ffffff', 3);
    cameraFlash('hud', 'ffffff', 3);
    cameraFlash('other', 'ffffff', 3);
    end
end

function onUpdate(elapsed)
    if keyboardJustPressed('V') and keyboardJustPressed('F') and keyboardJustPressed('B') then
        trollTime()
    end
    
    if hideTimeBar then
    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', false)
    end
    
    if hideRatings then
    setProperty('showComboNum', false)
    setProperty('showCombo', false)
    setProperty('showRating', false)
    end
end

function onPause()

end 

function onResume()

end

function trollTime()
    triggerEvent("Change Character", 'dad', 'pico')
    triggerEvent("Change Character", 'gf', 'pico')
    triggerEvent("Change Character", 'boyfriend', 'pico-player')
    triggerEvent("Change Scroll Speed", '10', '0.1')
end