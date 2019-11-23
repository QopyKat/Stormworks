pos = 2
timer = 0
timer2 = 0
timer3 = 0
pos2 = 0
pos3 = 1
UP = false
DOWN = false

function onTick()
	dist = input.getNumber(1)
	dist2 = input.getNumber(2)
	height = input.getNumber(3)
	left = input.getBool(1)
	right = input.getBool(2)
	up = input.getBool(3)
	down = input.getBool(4)
	hoch = input.getBool(5)
	runter = input.getBool(6)
	
	if up and timer2 <0 then
		pos2 = pos2 -1
		timer2 = 30
	end
	if down and timer2<0 then
		pos2 = pos2 +1
		timer2=30
	end
	if pos2 >4 then
		pos2 = 4
	end
	if pos2<0 then
		pos2 = 0
	end
	
	if hoch and timer3<0 then
		pos3 = pos3 +1
		timer3 = 30
	end
	if runter and timer3<0 then
		pos3 = pos3 -1
		timer3 = 30
	end
	
	if pos3 >3 then
		pos3 = 3
	end
	if pos3 <1then
		pos3 = 1
	end
	
	if pos3 ==1 then
		if height>3 then
			speedH = -0.4
		else
			speedH = 0
		end
	end
	
	if pos3 ==2 then
		if height>5.7 then
			speedH = -0.4
		elseif height<5.4 then
			speedH = 0.4
		else
			speedH = 0
		end
	end
	
	if pos3 ==3 then
		if height>8.2 then
			speedH = -0.4
		elseif height<7.9 then
			speedH = 0.4
		else
			speedH = 0
		end
	end
			
	if pos2==0 then
		if dist2 <= 0 then
			UP = false
			DOWN = false
		else
			UP = false
			DOWN = true
		end
	end
	
	if pos2==1 then
		if dist2<4.15 then
			UP = true
			Down = false
		elseif dist2 >4.35 then
			UP = false
			DOWN = true
		else
			UP = false
			DOWN = false
		end
	end
	if pos2==2 then
		if dist2<10.65 then
			UP = true
			Down = false
		elseif dist2 >10.85 then
			UP = false
			DOWN = true
		else
			UP = false
			DOWN = false
		end
	end
	if pos2==3 then
		if dist2<17.15 then
			UP = true
			Down = false
		elseif dist2 >17.35 then
			UP = false
			DOWN = true
		else
			UP = false
			DOWN = false
		end
	end
	if pos2==4 then
		if dist2==23.75 then
			UP = false
			Down = false
		else
			UP = true
			DOWN = false
		end
	end
			
	if left and timer <0 then
		pos = pos -1
		timer = 30
	end
	if right and timer<0 then
		pos = pos +1
		timer = 30
	end
	
	if pos > 3 then
		pos = 3
	end
	if pos < 1 then
		pos = 1
	end
	
	if pos == 1 then
		if dist>1.05 then
			speed = -0.6
		else
			speed = 0
		end
	elseif pos ==2 then
		if dist>=3.58 and dist<=3.8 then
			speed = 0
		elseif dist>3.8 then
			speed = -0.6
		else 
			speed = 0.6
		end
	elseif pos ==3 then
		if dist<6.35 then
			speed = 0.6
		else
			speed = 0
		end
	end
	
	timer = timer - 1
	timer2 = timer2-1
	timer3 = timer3-1
	output.setNumber(1,speed)
	output.setNumber(2,speedH)
	output.setBool(1,UP)
	output.setBool(2,DOWN)
	
end

