// OG SCRIPT BY: BFDI 26 DEVS MODIFIED BY: camlikeskirby
// This is some messy code and can prob be shortend but it works.

import states.PlayState;

using StringTools;

var inGFSection:Bool = false;
var ghostCount:Int = 0;

var settings = {
// The settings
ghostLimit: 20,
animated: false,
ghostMoves: true,
ghostSustains: false,
coloredGhosts: true,
howFarItMoves: 80,
howFarLongItTakesToMove: 8,
typeOfEase: FlxEase.circOut // https://api.haxeflixel.com/flixel/tweens/FlxEase.html
}

var bfStuffs = {
lastNote: null,
lastNoteDir: "",
lastNoteData: 0,
lastSwagNote: false,
lastTailLength: 0
}

var opStuffs = {
lastNote: null,
lastNoteDir: "",
lastNoteData: 0,
lastSwagNote: false,
lastTailLength: 0
}

function goodNoteHit(n) {
    if (n.isSustainNote) return;
    calcalateInfo(n, boyfriend);
}

function opponentNoteHit(n) {
    if (n.isSustainNote) return;
    calcalateInfo(n, dad);
}

function calcalateInfo(n:Note, character:Dynamic) {
var stuffs:Dynamic = null;
var isGF:Bool = (n.gfNote) || inGFSection;
var theCharNeeded:Dynamic = isGF ? gf : character;

if (character == dad) stuffs = opStuffs; 
else stuffs = bfStuffs;

if (stuffs.lastNote == n.strumTime) {
    var tailLength:Bool = n.sustainLength >= 150;
    var length:Int = stuffs.lastTailLength;

    if (length == 0 || length == null) length = .55;
    makeGhost(theCharNeeded, stuffs.lastNoteDir, stuffs.lastNoteData, stuffs.lastSwagNote, length);
    } else {
    stuffs.lastNote = n.strumTime;
    stuffs.lastNoteDir = theCharNeeded.getAnimationName();
    stuffs.lastNoteData = n.noteData;
    if (n.tail.length > 0 && settings.ghostSustains) stuffs.lastSwagNote = true;
    else stuffs.lastSwagNote = false;
    stuffs.lastTailLength = n.tail.length;
    }
}


function makeGhost(char:Character, animToPlay:String, noteData:Int, swagNote:Bool, noteLength:Int){
    if (ghostCount >= settings.ghostLimit || !char.visible || char.alpha == 0) return; // To prevent lag

    ghostCount = ghostCount + 1;
    var trail = new Character(char.x, char.y, char.curCharacter, (char == boyfriend) ? true : false);
   if (!settings.coloredGhosts) trail.color = char.color; else trail.color = getIconColor(char);
    trail.scale.set(char.scale.x, char.scale.y);
    trail.holdTimer = 0;
    trail.alpha = char.alpha;
    if (char == boyfriend) addBehindBF(trail);
    else if (char == dad) addBehindDad(trail);
    else addBehindGF(trail);
    trail.playAnim(animToPlay);
 
    if (settings.ghostMoves) switch(noteData) // noteData works better because you don't have to rely on the animations for the effect
	{
	case 0:
        FlxTween.tween(trail, {x: trail.x - settings.howFarItMoves}, settings.howFarLongItTakesToMove, {ease: settings.typeOfEase});
	case 1:
        FlxTween.tween(trail, {y: trail.y + settings.howFarItMoves}, settings.howFarLongItTakesToMove, {ease: settings.typeOfEase});
	case 2:
        FlxTween.tween(trail, {y: trail.y - settings.howFarItMoves}, settings.howFarLongItTakesToMove, {ease: settings.typeOfEase});
	case 3:
        FlxTween.tween(trail, {x: trail.x + settings.howFarItMoves}, settings.howFarLongItTakesToMove, {ease: settings.typeOfEase});
    }
    
    if (!swagNote) {
    FlxTween.tween(trail, {alpha: 0}, .55).onComplete = function() {
    trail.kill();
    remove(trail, true);
    ghostCount = ghostCount - 1;
    if (ghostCount < 0) ghostCount = 0;
    };
    } else {
    if (noteLength != .55) noteLength = noteLength / 4.2;
    FlxTween.tween(trail, {alpha: 0}, noteLength).onComplete = function() {
    trail.kill();
    remove(trail, true);
    ghostCount = ghostCount - 1;
    if (ghostCount < 0) ghostCount = 0;
    };
}
  
    if (settings.animated) {
    trail.animation.finishCallback = (animationName:String)->{
    trail.animation.frameName = trail.animation.frameName;
    };
    } else trail.animation.frameName = trail.animation.frameName;  // somehow this stops it from going into idle.
}

function onSectionHit() {
try { // to prevent annoying error pop ups at the end of songs.
if (PlayState.SONG.notes[curSection].gfSection) inGFSection = true;
else inGFSection = false;
} catch (e:Dynamic) inGFSection = false;
}

function getIconColor(chr:Character) {
    return switch(chr) {
    case dad: FlxColor.fromString('#' + rgbToHex(game.dad.healthColorArray));
    case boyfriend: FlxColor.fromString('#' + rgbToHex(game.boyfriend.healthColorArray));
    case gf: FlxColor.fromString('#' + rgbToHex(game.gf.healthColorArray));
    default: FlxColor.fromString('#' + rgbToHex(game.dad.healthColorArray));
    }
}

function rgbToHex(array:Array<Int>):String {
    return StringTools.hex((array[0] << 16) | (array[1] << 8) | array[2], 6);
}