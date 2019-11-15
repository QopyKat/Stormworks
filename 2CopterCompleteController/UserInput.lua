--[[ UserInput
===== Input =====
B32: Enabled
N1: Forward/Backward
N2: Right/Left
N3: Up/Down
N4: Turn
===== Properties =====
N: Horizontal Speed Increment
N: Horizontal Speed Increment Max
N: Vertical Speed Increment
N: Vertical Speed Increment Max
N: Angular Speed Increment
N: Angular Speed Increment Max
N: Roll Increment
N: Roll Increment Max
===== Output =====
N1: Speed Increase Horizontal
N2: Speed Increase Vertical
N3: Speed Increase Angular
N4: deltaRoll Increase
--]]

getIN = input.getNumber
getIB = input.getBool
getPN = property.getNumber
setON = output.setNumber

function up(v) return v > 0.5 end
function down(v) return v < -0.5 end

function incr(c, i, m)
	c = c + i
	if c > m then return m end
	return c
end

function decr(c, d, m)
	c = c - d
	if c < m then return m end
	return c
end

deltaRoll = 0
deltaHSpeed = 0
deltaVSpeed = 0
deltaASpeed = 0

function onTick()
	-- Enabled
	if not getIB(32) then
		return
	end

	-- Input
	forback = getIN(1)
	rightleft = getIN(2)
	updown = getIN(3)
	turn = getIN(4)

	-- Roll
	if up(rightleft) then
		deltaRoll = incr(deltaRoll, getPN("Roll Increment"), getPN("Roll Increment Max"))
	elseif down(rightleft) then
		deltaRoll = decr(deltaRoll, getPN("Roll Increment"), -getPN("Roll Increment Max"))
	else
		deltaRoll = 0
	end

	-- Horizontal Speed
	if up(forback) then
		deltaHSpeed = incr(deltaHSpeed, getPN("Horizontal Speed Increment"), getPN("Horizontal Speed Increment Max"))
	elseif down(forback) then
		deltaHSpeed = decr(deltaHSpeed, getPN("Horizontal Speed Increment"), -getPN("Horizontal Speed Increment Max"))
	else
		deltaHSpeed = 0
	end
	
	-- Vertical Speed
	if up(updown) then
		deltaVSpeed = incr(deltaVSpeed, getPN("Vertical Speed Increment"), getPN("Vertical Speed Increment Max"))
	elseif down(updown) then
		deltaVSpeed = decr(deltaVSpeed, getPN("Vertical Speed Increment"), -getPN("Vertical Speed Increment Max"))
	else
		deltaVSpeed = 0
	end
	
	-- Angular Speed
	if up(turn) then
		deltaASpeed = incr(deltaASpeed, getPN("Angular Speed Increment"), getPN("Angular Speed Increment Max"))
	elseif down(turn) then
		deltaASpeed = decr(deltaASpeed, getPN("Angular Speed Increment"), -getPN("Angular Speed Increment Max"))
	else
		deltaASpeed = 0
	end
	
	-- Output
	setON(1, deltaRoll)
	setON(2, deltaHSpeed)
	setON(3, deltaVSpeed)
	setON(4, deltaASpeed)
end
