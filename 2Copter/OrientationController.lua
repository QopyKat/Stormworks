--[[ OrientationController
===== Input =====
B1: Enabled
N1: Front X
N2: Front Y
N3: Back X
N4: Back Y
N5: Target X
N6: Target Y
===== Properties =====
===== Output =====
N1: Setpoint Angle
--]]

getIN = input.getNumber
getIB = input.getBool
setON = output.setNumber

function onTick()
	-- Enabled
	if not getIB(32) then
		return
    end

	FX = getIN(1)
	FY = getIN(2)
	BX = getIN(3)
	BY = getIN(4)
	TX = getIN(5)
	TY = getIN(6)

	dirX = FX - BX
	dirY = FY - BY
	tarX = TX - (FX + BX) / 2
	tarY = TY - (FY + BY) / 2

	dirLen = math.sqrt(dirX * dirX + dirY * dirY)
	tarLen = math.sqrt(tarX * tarX + tarY * tarY)
	dot = dirX * tarX + dirY * tarY
	setON(1, math.acos(dot / (dirLen * tarLen)))
	-- Process Variable is 0
end
