--[[
===== Input =====
B1: Initialize
==> IF B1
N4: Engine Controller P
N5: Engine Controller I
N6: Engine Controller D
N7: Target RPS
==> ELSE
B2: Enabled
B3: Launch
N1: RPS
===== Output =====
B1: Compressor
N1: Throttle
===== Properties =====
]]

getN = input.getNumber
setN = output.setNumber
getB = input.getBool
setB = output.setBool

-- PID Functions
function pid(p,i,d) return {p=p,i=i,d=d,e=0,s=0} end
function pid_tick(c,x,t)
    e=t-x
    c.s=c.s+e
    v=e*c.p+c.s*c.i+(e-c.e)*c.d
    c.e=e
    return v
end

pid_engine = nil
target_rps = nil
activated = false

function onTick()
    if getB(1) then
        if getB(3) and not activated then
            pid_engine = pid(getN(4), getN(5), getN(6))
            target_rps = getN(7)
            activated = true
        end
        setB(0, false)
        setN(0, 0)

    elseif activated then
        rps = getN(1)
        throttle = pid_tick(pid_engine, rps, target_rps)
        setB(1, rps < 5)
        setN(1, throttle)

    else
        setB(0, false)
        setN(0, 0)
    end
end
