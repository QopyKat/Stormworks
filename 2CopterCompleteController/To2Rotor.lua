--[[ To2Rotor
===== Input =====
B32: Enabled
N1: Current Height
N2: Current Roll Tilt
N3: Current Pitch Tilt
N4: Current Horizontal Speed
N5: Current Vertical Speed
N6: Current Angular Speed
N7: Roll
N8: Pitch
N9: User Roll
N10: Horizontal Speed
N11: Vertical Speed
N12: Angular Speed
===== Properties =====
N: Power Limit
N: Horizontal Speed Pitch Factor
N: Horizontal Speed Pitch Max
N: Roll Factor
N: Roll Max
===== Output =====
N1: Front Collective
N2: Front Roll
N3: Front Pitch
N4: Back Collective
N5: Back Roll
N6: Back Pitch
--]]

getIN = input.getNumber
getIB = input.getBool
getPN = property.getNumber
setON = output.setNumber
setOB = output.setBool

function onTick()
	-- Enabled
	if not getIB(32) then
		return
	end

    -- Input
    currentPitch = getIN(3)
	roll = getIN(7)
    pitch = getIN(8) * getPN("Collective Pitch Factor")
    userRoll = getIN(9) * getPN("Roll Factor")
	hSpeed = getIN(10)
	vSpeed = getIN(11) * getPN("Collective Vertical Speed Factor")
	aSpeed = getIN(12)

    -- Warning Flags
    warningPower = false
    warningBalance = false

    -- Collective
    if math.abs(pitch) > getPN("Power Limit") then
        fcol = pitch
        bcol = -pitch
        -- warningBalance = true
    elseif math.abs(vSpeed) + math.abs(pitch) > getPN("Power Limit") then
        absVSpeed = getPN("Power Limit") - math.abs(pitch)
        if vSpeed < 0 then
            absVSpeed = -absVSpeed
        end
        fcol = absVSpeed + pitch
        bcol = absVSpeed - pitch
        -- warningPower = true
    else
        fcol = vSpeed + pitch
        bcol = vSpeed - pitch
    end

    -- Roll
    maxYaw = getPN("Power Limit") - math.abs(roll)
    if aSpeed > maxYaw then
        aSpeed = maxYaw
    end
    froll = -roll - aSpeed
    broll = roll - aSpeed

    -- Pitch
    fpitch = -pitch
    bpitch = pitch

    -- Output
    setOB(1, warningPower)
    setOB(2, warningBalance)

    setON(1, fcol)
    setON(2, froll)
    setON(3, fpitch)
    setON(4, bcol)
    setON(5, broll)
    setON(6, bpitch)
end
