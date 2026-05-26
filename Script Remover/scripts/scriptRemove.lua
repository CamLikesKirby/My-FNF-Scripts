-- script made by camlikeskirby (Username on a lot of sites)
-- DISCORD: camthekirby
luaDebugMode = true
local songFolder = ''
local scriptFolders = {'scripts'}
local actualModFolder = ''
local usingBaseGame = false
local BlockedScripts = {'scriptRemove.lua'}

function onCreatePost()
runHaxeCode([[
     using StringTools;
        createCallback('replace', function(text:String, wordToReplace:String, replacedWord:String) {
         var og = text;
         return og.replace(wordToReplace, replacedWord);
        });
]])

-- Gets the song's mod folder
if stringStartsWith(chartPath, "assets\\shared") then
usingBaseGame = true;
pathName = '\\data\\' ..songPath.. '\\'.. songPath.. '' ..difficultyPath.. '.json'
actualModFolder = replace(replace(chartPath, pathName, ''), '\\', '/')
else
pathName = '\\data\\' ..songPath.. '\\'.. songPath.. '' ..difficultyPath.. '.json'
actualModFolder = replace(replace(chartPath, pathName, ''), '\\', '/')
end

-- Removes Events
if getModSetting('removeEvents', 'Script Remover') then
for i = getProperty('eventNotes.length'), 0, -1 do
    removeFromGroup('eventNotes',i,nil,false)
end
end

songFolder = actualModFolder.. '/data/' ..songPath
songScripts = directoryFileList(songFolder)

-- Removes Scripts
if getModSetting('removeScripts', 'Script Remover') then
for i = 1, #scriptFolders,1 do
if usingBaseGame then
scripts = directoryFileList('mods/' ..scriptFolders[i])
else
scripts = directoryFileList(actualModFolder.. '/' ..scriptFolders[i])
end

normScripts(scriptFolders[i])
end
end

-- Removes Song Scripts
if getModSetting('removeSongScripts', 'Script Remover') then
sScripts()
end

end

function normScripts(scriptsFolder)
    for i = 1, #scripts,1 do
        if contains(BlockedScripts, songScripts[i]) then
            return
        end

        if usingBaseGame then

        if stringEndsWith(scripts[i], ".lua") then
        removeLuaScript('mods/' ..scriptsFolder..'/' ..scripts[i])
        end
        
        if stringEndsWith(scripts[i], ".hx") then
        removeHScript('mods/' ..scriptsFolder..'/' ..scripts[i])
        end

        else

        if stringEndsWith(scripts[i], ".lua") then
        removeLuaScript(actualModFolder.. '/' ..scriptsFolder..'/' ..scripts[i])
        end
        
        if stringEndsWith(scripts[i], ".hx") then
        removeHScript(actualModFolder.. '/' ..scriptsFolder..'/' ..scripts[i])
        end

        end
        end
end


function sScripts()
    for i = 1, #songScripts,1 do
        if contains(BlockedScripts, songScripts[i]) then
            return
        end

        if stringEndsWith(songScripts[i], ".lua") then
        removeLuaScript(songFolder.. '/' ..songScripts[i])
        end
        
        if stringEndsWith(scripts[i], ".hx") then
        removeHScript(songFolder.. '/' ..songScripts[i])
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