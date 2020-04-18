--[[
===== Input =====
N1 : X1 (Rear Bottom)
N2 : Y1 (Rear Bottom)
N3 : Z1 (Rear Bottom)
N4 : X2 (Rear Top)
N5 : Y2 (Rear Top)
N6 : Z2 (Rear Top)
N7 : X3 (Front)
N8 : Y3 (Front)
N9 : Z3 (Front)
N10: Linear Speed Roll
N11: Linear Speed Pitch
N12: Linear Speed Yaw
N13: Angular Speed Roll
N14: Angular Speed Pitch
N15: Angular Speed Yaw
N16: Gimbal Target Pitch
N17: Gimbal Target Yaw
N18: Main Engine RPS
N19: Main Engine Throttle
N20: Main Engine Thrust Spoiler
===== Output =====
N1 : X Up
N2 : Y Up
N3 : Z Up
N4 : X Direction
N5 : Y Direction
N6 : Z Direction
N7 : Linear Speed Roll
N8 : Linear Speed Pitch
N9 : Linear Speed Yaw
N10: Angular Speed Roll
N11: Angular Speed Pitch
N12: Angular Speed Yaw
N13: Gimbal Target Pitch
N14: Gimbal Target Yaw
N15: Main Engine RPS
N16: Main Engine Throttle
N17: Main Engine Thrust Spoiler
===== Properties =====
]]

-- 3DVector Functions
function vec(x,y,z) return {x=x,y=y,z=z} end
function vecp(a,b) return {x=b.x-a.x,y=b.y-a.y,z=b.z-a.z} end
function norm(v) l=len(v) return {x=v.x/l,y=v.y/l,z=v.z/l} end
function v3muls(v,s) return {x=v.x*s,y=v.y*s,z=v.z*s} end
function v3add(a,b) return {x=a.x+b.x,y=a.y+b.y,z=a.z+b.z} end

getN = input.getNumber
setN = output.setNumber

function onTick()
    bottom = vec(getN(1), getN(2), getN(3))
    top = vec(getN(4), getN(5), getN(6))
    front = vec(getN(7), getN(8), getN(9))
    rear = v3muls(v3add(bottom, top), 0.5)

    up = norm(vecp(bottom, top))
    dir = norm(vecp(rear, front))

    setN(1, up.x)
    setN(2, up.y)
    setN(3, up.z)
    setN(4, dir.x)
    setN(5, dir.y)
    setN(6, dir.z)
    setN(7, getN(10))
    setN(8, getN(11))
    setN(9, getN(12))
    setN(10, getN(13))
    setN(11, getN(14))
    setN(12, getN(15))
    setN(13, getN(16))
    setN(14, getN(17))
end
