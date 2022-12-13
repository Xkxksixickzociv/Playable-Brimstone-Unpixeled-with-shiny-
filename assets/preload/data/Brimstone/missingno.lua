holdTimer = -1.0;
singDuration = 5;
specialAnim = false;

characterAnimationsList = {};

characterAnimationsList[0] = 'idle' -- idle
characterAnimationsList[1] = 'singLEFT' -- left
characterAnimationsList[2] = 'singDOWN' -- down
characterAnimationsList[3] = 'singUP' -- up
characterAnimationsList[4] = 'singRIGHT' -- right

player4 = 'Missingno'
directions = {'left', 'down', 'up', 'right'}

function onCreate() -- change this part for your character image (and the animation prefixes too) (you're also gonna need to make your own offset values)
	--- Caching the character into the memory ---
	makeAnimatedLuaSprite(player4, 'characters/Missingno', 250, 655);


	--- Setting up Character Animations ---
	addAnimationByPrefix(player4, 'idle', 'idle', 24, false);
	addOffset(player4, 'idle', 145, 120)

	addAnimationByPrefix(player4, 'singLEFT', 'left', 24, false);
	addOffset(player4, 'singLEFT', 330, 140)

	addAnimationByPrefix(player4, 'singDOWN', 'down', 24, false);
	addOffset(player4, 'singDOWN', 315, 68)

	addAnimationByPrefix(player4, 'singUP', 'up', 24, false);
	addOffset(player4, 'singUP', 213, 451)

	addAnimationByPrefix(player4, 'singRIGHT', 'right', 24, false);
	addOffset(player4, 'singRIGHT', -20, 120)

end

function onCreatePost()
	setProperty(player4..'.flipX', false) -- remove this for other characters, this flips their x position
	addLuaSprite(player4, true);
	setProperty(player4..'.alpha',0)
	scaleObject(player4,1.3,1.3)
	setProperty(player4..'.antialiasing',false)

end

local allowbop = false

function onBeatHit()
	if curBeat % 2 == 0 and holdTimer < 0 and not (getProperty(player4..".animation.curAnim.name"):sub(1,4) == 'sing') then
		characterPlayAnimation(0, true)
	end
end

function onCountdownTick(count)
	if count % 2 == 0 then
		characterPlayAnimation(0, false)
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'mino' then
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
	playAnim(player4, animName, forced); -- this part is easily broke if you use objectPlayAnim (I have no idea why its like this)

	if animId > 0 then 
		specialAnim = true ;
		holdTimer = 0;
	end
end
function onUpdate(elapsed)
	holdCap = stepCrochet * 0.0011 * singDuration;
	if holdTimer >= 0 then
		holdTimer = holdTimer + elapsed;
		if holdTimer >= holdCap and getProperty(player4..".animation.curAnim.name"):sub(1,4) == 'sing' then
			characterPlayAnimation(0, false)
			holdTimer = -1;
		end
	end
	end

function onStepHit()
	if curStep == 1728 then --1591
		setProperty('Missingno.alpha',1)
	end
	if curStep == 2368 then
	setProperty('Missingno.alpha',1)
		doTweenY('goodbyeeeee', 'Missingno', 2000, 4, CircInOut);
	end
	if curStep == 2500 then
		setProperty('Missingno.alpha',0)
	end
end