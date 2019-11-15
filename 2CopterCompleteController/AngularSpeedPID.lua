--[[ AngularSpeedPID
===== Input =====
B32: Enabled
N1: Angular Speed
N2: Angular Speed Delta
===== Properties =====
N: Angular Speed Max
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
	aSpeed = getIN(1)
    aSpeedDelta = getIN(2)

    -- Output
    if aSpeedDelta == 0 then
        setON(1, 0)
        setON(2, aSpeed)
    else
        setpoint = aSpeed + aSpeedDelta
        if setpoint > getPN("Angular Speed Max") then
            setpoint = getPN("Angular Speed Max")
        elseif setpoint < -getPN("Angular Speed Max") then
            setpoint = -getPN("Angular Speed Max")
        end
        setON(1, setpoint)
        setON(2, aSpeed)
    end
end
