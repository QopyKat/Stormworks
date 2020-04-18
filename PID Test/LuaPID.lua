--[[
===== Input =====
B1: Enabled
B2: Reset
N1: Setpoint
N2: Process Variable
N3: P
N4: I
N5: D
===== Output =====
N1: Controll Output
===== Properties =====
]]

getN = input.getNumber
setN = output.setNumber
getB = input.getBool

function pid(p,i,d) return {p=p,i=i,d=d,e=0,s=0} end
function pid_tick(c,x,t)
    e=t-x
    c.s=c.s+e
    v=e*c.p+c.s*c.i+(e-c.e)*c.d
    c.e=e
    return v
end

controller = nil

function onTick()
    if getB(1) then
        if controller == nil or getB(2) then
            controller = pid(getN(3), getN(4), getN(5))
        end
        v = pid_tick(controller, getN(2), getN(1))
        setN(1, v)
    else
        setN(1, 0)
    end
end
