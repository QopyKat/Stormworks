--[[ PositionController
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
N1: Setpoint ForBack
N2: Setpoint RightLeft
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
	
	FX = getIN(1)
	FY = getIN(2)
	BX = getIN(3)
	BY = getIN(4)
	TX = getIN(5)
	TY = getIN(6)

	dirX = FX - BX
	dirY = FY - BY
	rdirX = dirY
	rdirY = -rdirX
	tarX = TX - (FX + BX) / 2
	tarY = TY - (FY + BY) / 2

	dot = dirX * tarX + dirY * tarY
	rdot = rdirX * tarX + rdirY * tarY

	setON(1, dot)
	setON(2, rdot)
	-- Process Variable is 0
end
