--[[ RollPID
===== Input =====
B32: Enabled
N1: User Roll
N2: Roll Tilt
===== Properties =====
N: Roll Max
N: Roll Factor
===== Output =====
N1: PID Setpoint
N2: PID Process Variable
--]]

getIN = input.getNumber
getIB = input.getBool
getPN = property.getNumber
setON = output.setNumber

function onTick()
	-- Enabled
	if not getIB(32) then
		return
    end
    
    roll = getIN(1) * getPN("Roll Factor")
    rollTilt = getIN(2) * 4
    
    if roll > getPN("Roll Max") then
        roll = getPN("Roll Max")
    elseif roll < -getPN("Roll Max") then
        roll = -getPN("Roll Max")
    end

    setON(1, roll)
    setON(2, rollTilt)
end
