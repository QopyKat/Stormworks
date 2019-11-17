--[[ BFR I: Crawler Mover
===== Input =====
B1: Enabled
N1: X
N2: Y
N3: Distance
===== Properties =====
===== Output =====
B1: Move
B2: Finished
--]]

getIN = input.getNumber
getIB = input.getBool
setOB = output.setBool
setON = output.setNumber

prevX = nil
prevY = nil
dist = 0

function onTick()
    if not getIB(1) then
        setOB(1, false)
        setOB(2, false)
        return
    end
    
    if prevX == nil then
        prevX = getIN(1)
        prevY = getIN(2)
        dist = 0
        setOB(1, false)
        setOB(2, false)
    else
        x = getIN(1)
        y = getIN(2)

        dx = x - prevX
        dy = y - prevY
        dist = dist + math.sqrt(dx * dx + dy * dy)
        setON(1, dist)

        if dist < getIN(3) then
            prevX = x
            prevY = y
            setOB(1, true)
            setOB(2, false)
        else
            setOB(1, false)
            setOB(2, true)
            prevX = nil
            prevY = nil
            dist = 0
        end
    end
end
