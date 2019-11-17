-- ===== Input =====
-- Number:1  Input
-- Bool  :1  Set
-- ===== Properties =====
-- Bool    Use Set as Reset
-- Bool    Reset on Idle
-- Number  Default Value
-- Number  Counter Increment
-- ===== Output =====
-- Number:1  Output
-- Bool  :1  Idle

counter = 0

getPB = property.getBool
getPN = property.getNumber

function onTick()
	value = input.getNumber(1)
	idle = false
	
	if input.getBool(1) then
		idle = value > -0.5 and value < 0.5
		if getPB("Use Set as Reset") then
			counter = getPN("Default Value")
		else
			counter = value
		end
	elseif value < -0.5 then
    counter = counter - getPN("Counter Increment")
    if counter < getPN("Min Value") then
      counter = getPN("Min Value")
    end
	elseif value > 0.5 then
		counter = counter + getPN("Counter Increment")
    if counter > getPN("Max Value") then
      counter = getPN("Max Value")
    end
	else
		idle = true
		if getPB("Reset on Idle") then
			counter = getPN("Default Value")
		end
	end
	
	output.setNumber(1, counter)
	output.setBool(1, idle)
end
