--[[ HeightController
===== Input =====
B1: Height Controll (Enabled)
B2: Hover
N1: Height
N2: Target Height
N3: Distance
N4: Hover Height
===== Properties =====
===== Output =====
N1: Setpoint Height Difference
--]]

getIN = input.getNumber
getIB = input.getBool
setON = output.setNumber
setOB = output.setBool

function onTick()
	-- Enabled
	if not getIB(1) then
		return
    end

	if getIB(2) then
		setON(1, getIN(4) - getIN(3))
	else
		setON(1, getIN(2) - getIN(1))
	end
end
