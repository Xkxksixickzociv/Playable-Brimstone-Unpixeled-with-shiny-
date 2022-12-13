local random = 0
local shiny = false;
holdTimer = -1.0;
singDuration = 5;
specialAnim = false;

characterAnimationsList = {};

characterAnimationsList[0] = 'idle' -- idle
characterAnimationsList[1] = 'singLEFT' -- left
characterAnimationsList[2] = 'singDOWN' -- down
characterAnimationsList[3] = 'singUP' -- up
characterAnimationsList[4] = 'singRIGHT' -- right

player3 = 'gengar'
directions = {'left', 'down', 'up', 'right'}

function onCreate() -- change this part for your character image (and the animation prefixes too) (you're also gonna need to make your own offset values)
	--- Caching the character into the memory ---
	random = getRandomInt((1), (100), true);
		if random <= 8 then
		shiny = true;
	    makeAnimatedLuaSprite(player3, 'characters/gengar-shiny', 450, 225);
		makeAnimatedLuaSprite("gengarintro", 'characters/gengar-shiny', 450-281, 225-316);
		makeAnimatedLuaSprite("shiny", 'shiny_effect', 450, 205);
		addAnimationByPrefix("shiny", 'intro', 'shiny', 24, false);
		setProperty('shiny.alpha',0)
		else
		makeAnimatedLuaSprite(player3, 'characters/gengar', 450, 225);
		makeAnimatedLuaSprite("gengarintro", 'characters/gengar', 450-281, 225-316);
		end
	addAnimationByPrefix("gengarintro", 'appare', 'appare', 24, false);
	addAnimationByPrefix("gengarintro", 'nani', 'appare', 24, false);
	
	setProperty('gengarintro.antialiasing',false)
	addLuaSprite('gengarintro', true)

	--- Setting up Character Animations ---
	addAnimationByPrefix(player3, 'idle', 'idle', 24, false);
	addOffset(player3, 'idle', 5, 50)

	addAnimationByPrefix(player3, 'singLEFT', 'left', 24, false);
	addOffset(player3, 'singLEFT', 50, 30)

	addAnimationByPrefix(player3, 'singDOWN', 'down', 24, false);
	addOffset(player3, 'singDOWN', 35, 48)

	addAnimationByPrefix(player3, 'singUP', 'up', 24, false);
	addOffset(player3, 'singUP', -17, 91)

	addAnimationByPrefix(player3, 'singRIGHT', 'right', 24, false);
	addOffset(player3, 'singRIGHT', -30, 70)
    playAnim('gengarintro','nani',true)
	setProperty('gengarintro.alpha',0)
	if shiny == true then
	addLuaSprite('shiny', true)
	end

end

function onCreatePost()
	setProperty(player3..'.flipX', false) -- remove this for other characters, this flips their x position
	addLuaSprite(player3, true);
	setProperty(player3..'.alpha',0)
	scaleObject(player3,1,1)
	setProperty(player3..'.antialiasing',false)

end
local allowbop = false
function onBeatHit()
	if curBeat % 2 == 0 and holdTimer < 0 and not (getProperty(player3..".animation.curAnim.name"):sub(1,4) == 'sing') then
		characterPlayAnimation(0, true)
	end
end

function onCountdownTick(count)
	if count % 2 == 0 then
		characterPlayAnimation(0, false)
	end
end
function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'gengar' then
		characterPlayAnimation(noteData + 1, true)
	end
end
function characterPlayAnimation(animId, forced) -- thank you shadowmario :imp:
	-- 0 = idle
	-- 1 = left
	-- 2 = down
	-- 3 = up
	-- 4 = right

	specialAnim = false;

	local animName = characterAnimationsList[animId]
	playAnim(player3, animName, forced); -- this part is easily broke if you use objectPlayAnim (I have no idea why its like this)

	if animId > 0 then 
		specialAnim = true ;
		holdTimer = 0;
	end
end
function onUpdate(elapsed)
	holdCap = stepCrochet * 0.0011 * singDuration;
	if holdTimer >= 0 then
		holdTimer = holdTimer + elapsed;
		if holdTimer >= holdCap and getProperty(player3..".animation.curAnim.name"):sub(1,4) == 'sing' then
			characterPlayAnimation(0, false)
			holdTimer = -1;
		end
	end
    if getProperty('gengarintro.animation.curAnim.name') == 'appare' then
       if getProperty('gengarintro.animation.curAnim.finished') then
		setProperty('gengarintro.visible',false)
		playAnim('gengarintro','nani',true)
		setProperty('gengar.alpha',1)
		if shiny == true then
		    setProperty('shiny.alpha',1)
		    playSound('shiny', 1);
			objectPlayAnimation('shiny','intro', true);
		end
		
	   end
	end
end

function onStepHit()
	if curStep == 941 then
		playAnim('gengarintro','appare',true)
		setProperty('gengarintro.alpha',1)
	end
	if curStep == 2368 then
		doTweenAlpha('imgoingbye', player3, 0, 2, 'linear');
	end
	if curStep == 2400 then
	setProperty('gengar.alpha',0)
	end
end