--[[
===== Input =====
B32: Enabled
N1: Horizontal Speed
N3: Pitch Tilt
===== Properties =====
N: Horizontal Speed Pitch Factor
N: Horizontal Speed Pitch Max
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
    
    hSpeed = getIN(1)
    pitchTilt = getIN(3) * 4
    
    hSpeedPitch = getPN("Horizontal Speed Pitch Factor") * hSpeed
    if hSpeedPitch > getPN("Horizontal Speed Pitch Max") then
        pitch = -getPN("Horizontal Speed Pitch Max")
    elseif hSpeedPitch < -getPN("Horizontal Speed Pitch Max") then
        pitch = getPN("Horizontal Speed Pitch Max")
    else
        pitch = -hSpeedPitch
    end

    setON(1, pitch)
    setON(2, pitchTilt)
end
