--[[ HorizontalSpeedPID
===== Input =====
B32: Enabled
N1: Horizontal Speed
N2: Horizontal Speed Delta
===== Properties =====
N: Horizontal Speed Max
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

	-- Input
	hSpeed = getIN(1)
    hSpeedDelta = getIN(2)

    -- Output
    if hSpeedDelta == 0 then
        setON(1, 0)
        setON(2, hSpeed)
    else
        setpoint = hSpeed + hSpeedDelta
        if setpoint > getPN("Horizontal Speed Max") then
            setpoint = getPN("Horizontal Speed Max")
        elseif setpoint < -getPN("Horizontal Speed Max") then
            setpoint = -getPN("Horizontal Speed Max")
        end
        setON(1, setpoint)
        setON(2, hSpeed)
    end
end
