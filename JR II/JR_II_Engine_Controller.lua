--[[
===== Input =====
B1: Initialize
==> IF B1
N1: Engine Controller P
N2: Engine Controller I
N3: Engine Controller D
N4: Target RPS
==> ELSE
B2: Enabled
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
    -- if getB(1) then
    if activated then
        pid_engine = pid(getN(1), getN(2), getN(3))
        target_rps = getN(4)
        setB(0, false)
        setN(0, 0)

    elseif getB(2) then
        rps = getN(1)
        throttle = pid_tick(pid_engine, rps, target_rps)
        activated = true
        setB(0, rps < 5)
        setN(1, throttle)

    else
        setB(0, false)
        setN(0, 0)
    end
end
