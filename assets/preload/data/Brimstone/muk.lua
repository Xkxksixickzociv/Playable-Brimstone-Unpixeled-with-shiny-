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

player5 = 'Muk'
directions = {'left', 'down', 'up', 'right'}

function onCreate() -- change this part for your character image (and the animation prefixes too) (you're also gonna need to make your own offset values)
	--- Caching the character into the memory ---
	random = getRandomInt((1), (100), true);
		if random <= 8 then
		shiny = true;
		makeAnimatedLuaSprite(player5, 'characters/Muk-shiny', 570, 250);
	    makeAnimatedLuaSprite("Mukintro", 'characters/Muk-shiny', 570-3, 250-51);
		makeAnimatedLuaSprite("shiny", 'shiny_effect', 570, 250-20);
		addAnimationByPrefix("shiny", 'intro', 'shiny', 24, false);
		setProperty('shiny.alpha',0)
		else
	    makeAnimatedLuaSprite(player5, 'characters/Muk', 570, 250);
	    makeAnimatedLuaSprite("Mukintro", 'characters/Muk', 570-3, 250-51);
		end
		
	addAnimationByPrefix("Mukintro", 'intro', 'intro', 24, false);
	addAnimationByPrefix("Mukintro", 'nani', 'intro', 24, false);
	
	setProperty('Mukintro.antialiasing',false)
	addLuaSprite('Mukintro', true)

	--- Setting up Character Animations ---
	addAnimationByPrefix(player5, 'idle', 'idle', 24, false);
	addOffset(player5, 'idle', 5, 50)

	addAnimationByPrefix(player5, 'singLEFT', 'left', 24, false);
	addOffset(player5, 'singLEFT', 90, 160)

	addAnimationByPrefix(player5, 'singDOWN', 'down', 24, false);
	addOffset(player5, 'singDOWN', -8, 200)

	addAnimationByPrefix(player5, 'singUP', 'up', 24, false);
	addOffset(player5, 'singUP', -27, 281)

	addAnimationByPrefix(player5, 'singRIGHT', 'right', 24, false);
	addOffset(player5, 'singRIGHT', -82, 187)
    playAnim('Mukintro','nani',true)
	setProperty('Mukintro.alpha',0)
	if shiny == true then
	addLuaSprite('shiny', true)
	end

end

function onCreatePost()
	setProperty(player5..'.flipX', false) -- remove this for other characters, this flips their x position
	addLuaSprite(player5, true);
	setProperty(player5..'.alpha',0)
	scaleObject(player5,1,1)
	setProperty(player5..'.antialiasing',false)

end
local allowbop = false
function onBeatHit()
	if curBeat % 2 == 0 and holdTimer < 0 and not (getProperty(player5..".animation.curAnim.name"):sub(1,4) == 'sing') then
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
	playAnim(player5, animName, forced); -- this part is easily broke if you use objectPlayAnim (I have no idea why its like this)

	if animId > 0 then 
		specialAnim = true ;
		holdTimer = 0;
	end
end
function onUpdate(elapsed)
	holdCap = stepCrochet * 0.0011 * singDuration;
	if holdTimer >= 0 then
		holdTimer = holdTimer + elapsed;
		if holdTimer >= holdCap and getProperty(player5..".animation.curAnim.name"):sub(1,4) == 'sing' then
			characterPlayAnimation(0, false)
			holdTimer = -1;
		end
	end
    if getProperty('Mukintro.animation.curAnim.name') == 'intro' then
       if getProperty('Mukintro.animation.curAnim.finished') then
		setProperty('Mukintro.visible',false)
		playAnim('Mukintro','nani',true)
		setProperty('Muk.alpha',1)
		if shiny == true then
		    setProperty('shiny.alpha',1)
		    playSound('shiny', 1);
			objectPlayAnimation('shiny','intro', true);
		end
	   end
	end
end

function onStepHit()
	if curStep == 2704 then
		playAnim('Mukintro','intro',true)
		setProperty('Mukintro.alpha',1)
	end
	if curStep == 3456 then --1591
	doTweenAlpha('imgoingbye', player5, 0, 2, 'linear');
	end
end