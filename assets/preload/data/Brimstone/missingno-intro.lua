holdTimer = -1.0;
singDuration = 5;
specialAnim = false;

characterAnimationsList = {};

characterAnimationsList[0] = 'wait' -- idle
characterAnimationsList[1] = 'out' -- left
characterAnimationsList[2] = 'intro' -- down

player3 = 'intmissing'
directions = {'left', 'down', 'up', 'right'}

function onCreate() -- change this part for your character image (and the animation prefixes too) (you're also gonna need to make your own offset values)
	--- Caching the character into the memory ---
	makeAnimatedLuaSprite(player3, 'characters/missing poke',-400, 625);


	--- Setting up Character Animations ---
	addAnimationByPrefix(player3, 'intro', 'intro', 24, false);
	addOffset(player3, 'intro', 3, 51)
	
	addAnimationByPrefix(player3, 'out', 'out', 24, false);
	addOffset(player3, 'out', 223, 413)
	
	addAnimationByPrefix(player3, 'wait', 'wait', 24, true);
	addOffset(player3, 'wait', -300, 65)

end

function onCreatePost()
	setProperty(player3..'.flipX', false) -- remove this for other characters, this flips their x position
	addLuaSprite(player3, false);
	setProperty(player3..'.alpha',0)
	scaleObject(player3,1.3,1.3)
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
	if noteType == 'missingno' then
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
    if getProperty('intmissing.animation.curAnim.name') == 'out' then
       if getProperty('intmissing.animation.curAnim.finished') then
		setProperty('intmissing.visible',false)
	   end
	end
	if getProperty('intmissing.animation.curAnim.name') == 'intro' then
       if getProperty('intmissing.animation.curAnim.finished') then
		characterPlayAnimation(0, true)
	   end
	end
	if getProperty('intmissing.animation.curAnim.name') == 'aightimaheadout' then
		if getProperty('intmissing.animation.curAnim.finished') then
		 setProperty('intmissing.visible',false)
		end
	 end
	if getProperty(player3..".animation.curAnim.finished") and specialAnim then
		specialAnim = false;
	end
end

function onStepHit()
	if curStep == 1591 then --1591
	    setProperty('intmissing.alpha',1)
	    characterPlayAnimation(2, true)
		
	end
	if curStep == 1716 then --1591
		characterPlayAnimation(1, true)
	end
	if curStep == 1728 then --1591
		setProperty('intmissing.visible',false)
	end
end