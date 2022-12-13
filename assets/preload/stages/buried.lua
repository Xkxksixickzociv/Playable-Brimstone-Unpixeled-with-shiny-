local xx = 400;
local yy = 300;
local xx2 = 400;
local yy2 = 300;
local ofs = 10;
local followchars = true;
local del = 0;
local del2 = 0;
local beating = false;
local beat_skip = 0;

function onCreatePost()--this thing happens once the characters are spawned

    setProperty("gf.visible", false);

end

function onCreate()
	--background boi
	
	setProperty('camHUD.visible', false);
	
	
	makeLuaSprite('flashwhite','flashwhite', 0, 0)
	makeLuaSprite('flash','Flash', 0, 0)
	makeLuaSprite('darkscreen','Flash', 0, 0)
	makeLuaSprite('scenema','cutscene', 0, 0)
	makeLuaSprite('red','redscene', 0, 0)
    
    makeLuaSprite('bg','BG', -1400, -1000)
	makeLuaSprite('bg-dark','BG-dark', -1400, -1000)
	makeLuaSprite('bg2','beemboi', -1200, -1000)
	makeLuaSprite('bg3','beemboi-B', -1200, -1000)
	makeLuaSprite('bg4','beemboi-A', -1200, -1000)
	makeLuaSprite('sky','SKY', -1000, -1600)
	setScrollFactor('sky', 0.25, 0.25);
	
    addLuaSprite('sky')
    addLuaSprite('bg')
	addLuaSprite('bg-dark')
	addLuaSprite('bg3')
	addLuaSprite('bg4', true)
	addLuaSprite('bg2', true)
	
	addLuaSprite('flash')
	addLuaSprite('darkscreen')
	addLuaSprite('flashwhite')
	addLuaSprite('scenema')


	setProperty('sky.alpha', 0);
	setProperty('flash.alpha', 0);
	setObjectCamera('flash', 'hud');
	setObjectCamera('darkscreen', 'other');
	setProperty('flashwhite.alpha', 0);
	setObjectCamera('red', 'other');
	setProperty('red.alpha', 0);
	setObjectCamera('flashwhite', 'other');
	setProperty('scenema.alpha', 1);
	setObjectCamera('scenema', 'other');
	setProperty('bg2.alpha', 0);
	setProperty('bg3.alpha', 0);
	setProperty('bg4.alpha', 0);
	setProperty('bg-dark.alpha', 0);

	
end

function onBeatHit()
    if beat_skip == 0 then
	    beat_skip = 1
        if beating == true then
	        triggerEvent('Add Camera Zoom', 0.06, 0.04)
		end
	else
	    beat_skip = 0
	    
end
end

function cut()
setProperty('scenema.alpha', 1);
setProperty('camHUD.visible', false);
end

function cut_end()
setProperty('scenema.alpha', 0);
setProperty('camHUD.visible', true);
end

function flash()
    setProperty('flashwhite.alpha', 0.75);
	doTweenAlpha('flashdown', 'flashwhite', 0, 0.5, 'linear');
end
function flashdark()
    setProperty('flash.alpha', 1);
	doTweenAlpha('flashdown2', 'flash', 0, 2, 'linear');
end

function change_gameboi()
    setProperty('bg2.alpha', 1);
	setProperty('bg3.alpha', 1);
	setProperty('bg4.alpha', 1);
	setProperty('bg.alpha', 0);
	triggerEvent('Change Character', 1, 'BA-G')
	triggerEvent('Change Character', 0, 'BA-BF-G')
	setCharacterX('dad', 250);
    setCharacterY('dad', -450);
	setCharacterX('bf', -100);
    setCharacterY('bf', -250);
end

function backto_normal()
    setProperty('bg2.alpha', 0);
	setProperty('bg3.alpha', 0);
	setProperty('bg4.alpha', 0);
	setProperty('bg.alpha', 1);
	triggerEvent('Change Character', 1, 'BA')
	triggerEvent('Change Character', 0, 'BA-BF')
	setCharacterX('dad', 600);
    setCharacterY('dad', -200);
	setCharacterX('bf', -500.6);
    setCharacterY('bf', 175);
end

function onStepHit()
        if curStep == 28 or curStep == 30 then
		setProperty('darkscreen.alpha', 0);
		end
		if curStep == 29 or curStep == 31 then
		setProperty('darkscreen.alpha', 1);
		end
		if curStep == 32 or curStep == 160 then
		setProperty('darkscreen.alpha', 0);
		flash()
		end
        if curStep == 1 then
		for i = 0,7 do
			xValue = getPropertyFromGroup('strumLineNotes', i, 'x')
			if i < 3.5 then
				setPropertyFromGroup('strumLineNotes', i, 'x', xValue+640)
			else
				setPropertyFromGroup('strumLineNotes', i, 'x', xValue-640)
			end
		end
		end
		if curStep == 160 then
		cut_end()
		end
	    if curStep == 138 or curStep == 3488 or curStep == 960 or curStep == 1102 or curStep == 1728 or curStep == 2112 or curStep == 2720 or curStep == 3232 or curStep == 3615 or curStep == 4128 or curStep == 4255 or curStep == 4735 or curStep == 4744 or curStep == 4751 or curStep == 4760 or curStep == 4767 then
		-- flash only
		flash()
		end
		if curStep == 3488 or curStep == 4135 or curStep == 4799 then
		cut()
		end
		if curStep == 3615 or curStep == 4255 then
		cut_end()
		end
		if curStep == 2368 then
		doTweenAlpha('hahadarkscreen', 'flash', 1, 2, 'linear');
		end
		if curStep == 2400 then
		change_gameboi()
		doTweenAlpha('hahagameboi', 'flash', 0, 2, 'linear');
		end
		if curStep == 2656 then
		doTweenAlpha('HAHAGOBACK', 'flash', 1, 1, 'linear');
		end
		if curStep == 2684 then
		backto_normal()
		doTweenAlpha('nooo', 'flash', 0, 2, 'linear');
		end
		if curStep == 3488 then
		doTweenAlpha('startred', 'red', 0.75, 2, 'linear');
	    end
		if curStep == 3454 then
	    doTweenAlpha('shadowbg', 'bg-dark', 1, 2, 'linear');
	    end
		if curStep == 4895 then
		doTweenAlpha('ending', 'darkscreen', 1, 10, 'linear');
		end
end

function onTweenCompleted(tag)
    if tag == 'red' or tag == 'startred' then
    doTweenAlpha('red2', 'red', 0.25, 2, 'linear');
    end
	if tag == 'red2' then
    doTweenAlpha('red', 'red', 0.75, 2, 'linear');
    end
end


function onUpdate(elapsed)

    if followchars == true then
        if mustHitSection == false then

            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else


            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
end


function opponentNoteHit()
	
    health = getProperty('health')
        if getProperty('health') > 0.4 then
            setProperty('health', health- 0.02);
		end
    end