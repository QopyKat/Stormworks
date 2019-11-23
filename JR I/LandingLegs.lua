--[[ LandingLegs
===== Input =====
B1: Enabled
B2: Deploy
B3: Holder Connected
B4: Deployed Holder Connected
N1: Deployed Leg Distance
N2: Leg Distance
===== Properties =====
N: Holder Pivot Angle
N: Leg Pivot Speed
N: Deployed Holder Snap Distance
N: Holder Snap Distance
===== Output =====
B1: Leg Pivot Power
B2: Connectors
B3: Deployed Connectors
N1: Holder Pivot Angle
N2: Leg Pivot Speed
--]]

getIB = input.getBool
getIN = input.getNumber
getPN = property.getNumber
setOB = output.setBool
setON = output.setNumber

function onTick()
    if not getIB(1) then -- NOT Enabled
        setON(1, 0)
        setON(2, 0)
        setOB(1, false)
        setOB(2, false)
        setOB(3, false)
		return
    end

    if getIB(2) then -- Deploy
        if getIB(4) then
            setON(2, 0)
            setOB(1, false)
        else
            setON(2, getPN("Leg Pivot Speed"))
            setOB(1, true)
        end
        setON(1, getPN("Holder Pivot Angle"))
        setOB(2, false)
        setOB(3, getIN(1) < getPN("Deployed Holder Snap Distance"))

    else -- Retract
        if getIB(3) then
            setON(2, 0)
            setOB(1, false)
        else
            setON(2, -getPN("Leg Pivot Speed"))
            setOB(1, true)
        end
        setON(1, 0)
        setOB(2, getIN(2) < getPN("Holder Snap Distance"))
        setOB(3, false)

    end
end
