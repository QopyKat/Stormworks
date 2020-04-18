--[[
===== Input =====
B1: Enabled
N1: Value
===== Output =====
===== Properties =====
Monitor
Value Offset
Value Range
]]

getN = input.getNumber
getB = input.getBool
getPN = property.getNumber

MONITOR_SIZES={{w=32,h=32},{w=64,h=64},{w=96,h=96},{w=160,h=96},{w=288,h=160}}
COLORS={{r=255,g=0,b=0},{r=0,g=255,b=0},{r=0,g=0,b=255}}

width = MONITOR_SIZES[getPN("Monitor")].w
height = MONITOR_SIZES[getPN("Monitor")].h
offset = getPN("Value Offset")
range = getPN("Value Range")
color = COLORS[getPN("Color")]

index = 1
values = {}
for i=1,width do
    values[i] = 0
end

ready = false

function onTick()
    if getB(1) then
        ready = true

        values[index] = -(getN(1) - offset) / range * height + height / 2
        if index == width then
            index = 1
        else
            index = index + 1
        end
    end
end

function onDraw()
    if ready then
        screen.setColor(255, 255, 255)
        screen.drawLine(0, height/2, width, height/2)
        screen.drawLine(index, 0, index, height)
        screen.setColor(color.r, color.g, color.b)
        for i=2,width do
            screen.drawLine(i-1, values[i-1], i, values[i])
        end
    end
end
