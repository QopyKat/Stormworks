--[[ LandingLegs
===== Input =====
N1: X Bottom Right
N2: Y Bottom Right
N3: Z Bottom Right
N4: X Bottom Left
N5: Y Bottom Left
N6: Z Bottom Left
N7: X Top
N8: Y Top
N9: Z Top
N10: Thrust
N11: Projection Length
B32: Enabled
===== Properties =====
===== Output =====
N1: Projection Length PV
N1-9: Thrust Spoilers
--]]

getIB = input.getBool
getIN = input.getNumber
getPN = property.getNumber
setOB = output.setBool
setON = output.setNumber
drawT = screen.drawText

function vec(x,y,z) return {x=x,y=y,z=z} end
function vec2(x,y) return {x=x,y=y} end
function vecp(a,b) return {x=b.x-a.x,y=b.y-a.y,z=b.z-a.z} end
function len(v) return math.sqrt(v.x*v.x+v.y*v.y+v.z*v.z) end
function len2(v) return math.sqrt(v.x*v.x+v.y*v.y) end
function scale(v,l) c=len(v) return {x=v.x*l/c,y=v.y*l/c,z=v.z*l/c} end
function scale2(v,l) c=len2(v) return {x=v.x*l/c,y=v.y*l/c} end
function norm(v) l=len(v) return {x=v.x/l,y=v.y/l,z=v.z/l} end
function cross(a,b) return {x=a.y*b.z-a.z*b.y,y=b.x*a.z-a.x*b.z,z=a.x*b.y-a.y*b.x} end
function dot(a,b) return a.x*b.x+a.y*b.y+a.z*b.z end
function dot2(a,b) return a.x*b.x+a.y*b.y end

function floor(a,n) f=1 for i=1,n do f=f*10 end return math.floor(a*f)/f end

engines = {
  { x = -1.00 , y =  0.00 },
  { x = -0.75 , y =  0.75 },
  { x =  0.00 , y =  1.00 },
  { x =  0.75 , y =  0.75 },
  { x =  1.00 , y =  0.00 },
  { x =  0.75 , y = -0.75 },
  { x =  0.00 , y = -1.00 },
  { x = -0.75 , y = -0.75 }
}

sp = {}
Vx = nil
Vy = nil
Vz = nil
function onDraw()
  if not enabled then return end
  for i = 1,9 do
    drawT(0,i*6-2,floor(sp[i],3))
  end

  drawT(72,4,"x=")
  drawT(72,10,"y=")
  drawT(72,16,"z=")
  drawT(72,22,"x=")
  drawT(72,28,"y=")
  drawT(72,34,"z=")
  drawT(72,40,"x=")
  drawT(72,46,"y=")
  drawT(72,52,"z=")
  drawT(72,58,"x=")
  drawT(72,64,"y=")

  drawT(80,4,floor(Vx.x,3))
  drawT(80,10,floor(Vx.y,3))
  drawT(80,16,floor(Vx.z,3))
  drawT(80,22,floor(Vy.x,3))
  drawT(80,28,floor(Vy.y,3))
  drawT(80,34,floor(Vy.z,3))
  drawT(80,40,floor(Vz.x,3))
  drawT(80,46,floor(Vz.y,3))
  drawT(80,52,floor(Vz.z,3))
  drawT(80,58,floor(projection.x,3))
  drawT(80,64,floor(projection.y,3))
end

function onTick()
  enabled = getIB(32)
  if not getIB(32) then -- NOT Enabled
    for i = 1,9 do
      setON(i, 0)
    end
    return
  end

  -- Input
  bot1 = vec(getIN(1), getIN(2), getIN(3))
  bot2 = vec(getIN(4), getIN(5), getIN(6))
  top = vec(getIN(7), getIN(8), getIN(9))
  spoiler = getIN(10)
  tarPos = vec2(getIN(11), getIN(12))
  
  -- TODO correct pos
  bot = vec((bot1.x + bot2.x) / 2, (bot1.y + bot2.y) / 2, (bot1.z + bot2.z) / 2)
  -- pos = { x = bot.x , y = bot.y , z = bot.z - 2.5 } -- 2.5 correct ? #
  Vz = norm(vec((top.x - bot.x) / 30.50, (top.y - bot.y) / 30.50, (top.z - bot.z) / 30.00))

  Vx = vecp(bot1, bot2) -- normed by default
  Vx = vec(bot2.x - bot1.x, bot2.y - bot1.y, bot2.z - bot1.z)
  Vy = cross(Vz, Vx)

  targetDir = vec(0, 0, 1) -- calculated by ALG, normalize
  projection = vec2(-dot(targetDir, Vx), dot(targetDir, Vy))

  -- next script here
  projectionLength = -getIN(11)

  if projectionLength < getPN("threshold") then
    projectionLength = 0
  end

  if projectionLength ~= 0 then
    projection = scale2(projection, projectionLength)

    -- if spoiler + projectionLength > 1 then
    --   offset = spoiler + projectionLength - 1
    -- else
    --   offset = 0
    -- end

    for i = 1,8 do
      d2 = dot2(engines[i], projection)
      if d2 > 0 then
        s = spoiler + d2 -- offset
      elseif d2 < 0 then
        s = spoiler + d2 -- offset
      else
        s = spoiler -- offset
      end
      setON(i, s)
      sp[i] = s
    end
    setON(9, spoiler) -- offset)
    sp[9] = spoiler
  else
    for i = 1,9 do
      setON(i, spoiler)
      sp[i] = spoiler
    end
  end
end
