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

engines = { 
  { x =  1.00 , y =  0.00 },
  { x =  0.75 , y =  0.75 },
  { x =  0.00 , y =  1.00 },
  { x = -0.75 , y =  0.75 },
  { x = -1.00 , y =  0.00 },
  { x = -0.75 , y = -0.75 },
  { x =  0.00 , y = -1.00 },
  { x =  0.75 , y = -0.75 }
}

function onTick()
  if not getIB(32) then -- NOT Enabled
    return
  end

  -- Input
  bot1 = vec(getIN(1), getIN(2), getIN(3))
  bot2 = vec(getIN(4), getIN(5), getIN(6))
  top = vec(getIN(7), getIN(8), getIN(9))
  spoiler = getIN(10)
  
  -- TODO correct pos
  bot = vec((bot1.x + bot2.x) / 2, (bot1.y + bot2.y) / 2, (bot1.z + bot2.z) / 2)
  -- pos = { x = bot.x , y = bot.y , z = bot.z - 2.5 } -- 2.5 correct ? #
  Vz = norm(vec((top.x - bot.x) / 30.50, (top.y - bot.y) / 30.50, (top.z - bot.z) / 30.00))
  Vx = vecp(bot1, bot2) -- normed by default
  Vy = cross(Vz, Vx)

  -- xTarget = getIN(10) -- use init X for now
  -- yTarget = getIN(11) -- use init Y for now
  -- delta = { x = xTarget - pos.x , y = yTarget - pos.y }

  -- targetDir = vec(0.1, 0.1, 1) -- calculated by ALG, normalize
  targetDir = vec(0, 0, 1) -- calculated by ALG, normalize
  projection = vec2(dot(targetDir, Vx), dot(targetDir, Vy))
  projectionLengthPV = len2(projection) -- put into PID
  setON(11, projection.x)
  setON(12, projection.y)
  -- setON(1, 0)
  -- setON(2, projectionLengthPV)
  -- targetDir = { x = getIN(12) , y = getIN(13) , z = getIN(14) }
  projectionLength = projectionLengthPV

  -- next script here
  projectionLength = getIN(11)
  if projectionLength ~= 0 then
    projection = scale2(projection, projectionLength)
    setON(10, projectionLength)

    if (1 - spoiler) < projectionLength then
      offset = spoiler + projectionLength - 1
    else
      offset = 0
    end

    for i = 1,8 do
      d2 = dot2(engines[i], projection)
      if d2 > 0 then
        s = spoiler + d2 - offset
      else
        s = spoiler
      end
      setON(i, s)
    end
    setON(9, spoiler)
	else
		for i = 1,9 do
			setON(i, spoiler)
		end
  end
end
