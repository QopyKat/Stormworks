--[[
===== Input =====
B1 : Initialize
==> IF B1
N1 : Flight Controller P
N2 : Flight Controller I
N3 : Flight Controller D
==> ELSE
B2 : Enabled
N1 : X1 (Rear Bottom)
N2 : Y1 (Rear Bottom)
N3 : Z1 (Rear Bottom)
N4 : X2 (Rear Top)
N5 : Y2 (Rear Top)
N6 : Z2 (Rear Top)
N7 : X3 (Front)
N8 : Y3 (Front)
N9 : Z3 (Front)
N10: Main Engine RPS
N11: Main Engine Thrust Spoiler
===== Output =====
N1: Gimbal Target Pitch
N2: Gimbal Target Yaw
===== Properties =====
]]

getN = input.getNumber
setN = output.setNumber
getB = input.getBool
setB = output.setBool
getPB = property.getBool
getPN = property.getNumber
getPS = property.getText

-- 3DVector Functions
function vec(x,y,z) return {x=x,y=y,z=z} end
function vecp(a,b) return {x=b.x-a.x,y=b.y-a.y,z=b.z-a.z} end
function norm(v) l=len(v) return {x=v.x/l,y=v.y/l,z=v.z/l} end
function v3muls(v,s) return {x=v.x*s,y=v.y*s,z=v.z*s} end
function v3add(a,b) return {x=a.x+b.x,y=a.y+b.y,z=a.z+b.z} end

-- PID Functions
function pid(p,i,d) return {p=p,i=i,d=d,e=0,s=0} end
function pid_tick(c,x,t)
    e=t-x
    c.s=c.s+e
    v=e*c.p+c.s*c.i+(e-c.e)*c.d
    c.e=e
    return v
end

pid_pitch = nil
pid_yaw = nil

function onTick()
    if getB(1) then
        pid_pitch = pid(getN(1), getN(2), getN(3))
        pid_yaw = pid(getN(1), getN(2), getN(3))
        setN(1, 0)
        setN(2, 0)

    elseif getB(2) then
        if pid_pitch == nil or pid_yaw == nil then
            return
        end

        bottom = vec(getN(1), getN(2), getN(3))
        top = vec(getN(4), getN(5), getN(6))
        front = vec(getN(7), getN(8), getN(9))
        rear = v3muls(v3add(bottom, top), 0.5)
    
        -- up = norm(vecp(bottom, top))
        dir = norm(vecp(rear, front))

        yaw = pid_tick(pid_yaw, dir.x, 0)
        pitch = pid_tick(pid_pitch, dir.y, 0)

        setN(1, pitch)
        setN(2, yaw)

    else
        setN(1, 0)
        setN(2, 0)
    end
end
