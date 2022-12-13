holdTimer = -1.0;
singDuration = 5;
specialAnim = false;

characterAnimationsList = {};

characterAnimationsList[0] = 'idle' -- idle
characterAnimationsList[1] = 'singLEFT' -- left
characterAnimationsList[2] = 'singDOWN' -- down
characterAnimationsList[3] = 'singUP' -- up
characterAnimationsList[4] = 'singRIGHT' -- right

player6 = 'whiteGF'
directions = {'left', 'down', 'up', 'right'}

function onCreate() -- change this part for your character image (and the animation prefixes too) (you're also gonna need to make your own offset values)
	--- Caching the character into the memory ---
	makeAnimatedLuaSprite(player6, 'characters/whiteGF', 300, 150);

	--- Setting up Character Animations ---
	addAnimationByPrefix(player6, 'idle', 'idle', 20, true);
	addOffset(player6, 'idle', -15, 80)

	addAnimationByPrefix(player6, 'singLEFT', 'left', 24, false);
	addOffset(player6, 'singLEFT', 150, 80)

	addAnimationByPrefix(player6, 'singDOWN', 'down', 24, false);
	addOffset(player6, 'singDOWN', -7, -9)

	addAnimationByPrefix(player6, 'singUP', 'up', 24, false);
	addOffset(player6, 'singUP', -34, 211)

	addAnimationByPrefix(player6, 'singRIGHT', 'right', 24, false);
	addOffset(player6, 'singRIGHT', -102, 87)

end

function onCreatePost()
	setProperty(player6..'.flipX', false) -- remove this for other characters, this flips their x position
	addLuaSprite(player6, true);
	setProperty(player6..'.alpha',0)
	scaleObject(player6,1,1)
	setProperty(player6..'.antialiasing',false)

end
local allowbop = false
function onBeatHit()
	if curBeat % 6 == 0 and holdTimer < 0 and not (getProperty(player6..".animation.curAnim.name"):sub(1,4) == 'sing') then
		characterPlayAnimation(0, true)
	end
end

function onCountdownTick(count)
	if count % 6 == 0 then
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
	playAnim(player6, animName, forced); -- this part is easily broke if you use objectPlayAnim (I have no idea why its like this)

	if animId > 0 then 
		specialAnim = true ;
		holdTimer = 0;
	end
end
function onUpdate(elapsed)
	holdCap = stepCrochet * 0.0011 * singDuration;
	if holdTimer >= 0 then
		holdTimer = holdTimer + elapsed;
		if holdTimer >= holdCap and getProperty(player6..".animation.curAnim.name"):sub(1,4) == 'sing' then
			characterPlayAnimation(0, false)
			holdTimer = -1;
		end
	end
    if getProperty('whiteGFintro.animation.curAnim.name') == 'intro' then
       if getProperty('whiteGFintro.animation.curAnim.finished') then
		setProperty('whiteGFintro.visible',false)
		playAnim('whiteGFintro','nani',true)
		setProperty('whiteGF.alpha',1)
	   end
	end
end

function onStepHit()
	if curStep == 3488 then
		setProperty('whiteGF.alpha',1)
	end
end