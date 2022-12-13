holdTimer = -1.0;
singDuration = 5;
specialAnim = false;

characterAnimationsList = {};

characterAnimationsList[0] = 'wait' -- idle
characterAnimationsList[1] = 'out' -- left
characterAnimationsList[2] = 'intro' -- down

playerchanger2 = 'whitehand'
directions = {'left', 'down', 'up', 'right'}

function onCreate() -- change this part for your character image (and the animation prefixes too) (you're also gonna need to make your own offset values)
	--- Caching the character into the memory ---
	makeAnimatedLuaSprite(playerchanger2, 'characters/white-hand',330, 80);


	--- Setting up Character Animations ---
	addAnimationByPrefix(playerchanger2, 'intro', 'intro', 12, false);
	addOffset(playerchanger2, 'intro', 0, 0)
	
	addAnimationByPrefix(playerchanger2, 'out', 'trans', 20, false);
	addOffset(playerchanger2, 'out', 13, 15)
	
	addAnimationByPrefix(playerchanger2, 'wait', 'hand-idle', 20, true);
	addOffset(playerchanger2, 'wait', -5, -53)

end

function onCreatePost()
	setProperty(playerchanger2..'.flipX', false) -- remove this for other characters, this flips their x position
	addLuaSprite(playerchanger2, false);
	setProperty(playerchanger2..'.alpha',0)
	scaleObject(playerchanger2,1,1)
	setProperty(playerchanger2..'.antialiasing',false)

end
local allowbop = false
function onBeatHit()
	if curBeat % 2 == 0 and holdTimer < 0 and not (getProperty(playerchanger2..".animation.curAnim.name"):sub(1,4) == 'sing') then
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
	playAnim(playerchanger2, animName, forced); -- this part is easily broke if you use objectPlayAnim (I have no idea why its like this)

	if animId > 0 then 
		specialAnim = true ;
		holdTimer = 0;
	end
end
function onUpdate(elapsed)
	holdCap = stepCrochet * 0.0011 * singDuration;
	if holdTimer >= 0 then
		holdTimer = holdTimer + elapsed;
		if holdTimer >= holdCap and getProperty(playerchanger2..".animation.curAnim.name"):sub(1,4) == 'sing' then
			characterPlayAnimation(0, false)
			holdTimer = -1;
		end
	end
    if getProperty('whitehand.animation.curAnim.name') == 'out' then
       if getProperty('whitehand.animation.curAnim.finished') then
		setProperty('whitehand.visible',false)
	   end
	end
	if getProperty('whitehand.animation.curAnim.name') == 'intro' then
       if getProperty('whitehand.animation.curAnim.finished') then
		characterPlayAnimation(0, true)
	   end
	end
	if getProperty('whitehand.animation.curAnim.name') == 'aightimaheadout' then
		if getProperty('whitehand.animation.curAnim.finished') then
		 setProperty('whitehand.visible',false)
		end
	 end
	if getProperty(playerchanger2..".animation.curAnim.finished") and specialAnim then
		specialAnim = false;
	end
end

function onStepHit()
	if curStep == 3360 then --1591
	    setProperty('whitehand.alpha',1)
	    characterPlayAnimation(2, true)
		
	end
	if curStep == 3454 then --1591
	 setProperty('whitehand.alpha',1)
		characterPlayAnimation(1, true)
	end
	if curStep == 3488 then --1591
		setProperty('whitehand.visible',false)
	end
end