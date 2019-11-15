--[[ VerticalSpeedPID
===== Input =====
B1: Hover Enabled
B32: Enabled
N1: Vertical Speed
N2: Vertical Speed Delta
===== Properties =====
N: Vertical Speed Ascending Max
N: Vertical Speed Descending Max
===== Output =====
N1: PID Setpoint
N2: PID Process Variable
--]]

getIN = input.getNumber
getIB = input.getBool
getPN = property.getNumber
setON = output.setNumber

setVSpeed = 0

function onTick()
	-- Enabled
	if not getIB(32) then
		return
    end

	-- Input
	vSpeed = getIN(1)
    vSpeedDelta = getIN(2)

    -- Output
    if vSpeedDelta == 0 then
        if setVSpeed > getPN("Decceleration") then
            setVSpeed = setVSpeed - getPN("Decceleration")
        elseif setVSpeed < -getPN("Decceleration") then
            setVSpeed = setVSpeed + getPN("Decceleration")
        else
            setVSpeed = 0
        end
        setON(1, setVSpeed)
    else
        setpoint = vSpeed + vSpeedDelta
        if setpoint > getPN("Vertical Speed Ascending Max") then
            setpoint = getPN("Vertical Speed Ascending Max")
        elseif setpoint < -getPN("Vertical Speed Descending Max") then
            setpoint = -getPN("Vertical Speed Descending Max")
        end
        setVSpeed = vSpeed
        setON(1, setpoint)
    end
    setON(2, vSpeed)
    -- prevVSpeed = vSpeed
end
