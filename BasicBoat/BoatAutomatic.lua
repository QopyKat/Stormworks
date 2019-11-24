
getIN = input.getNumber

current_gear = 1
prev_rps = 0
regulated_throttle = 0
shift_timer = 100

function onTick()
	throttle = getIN(1)
  rps_in   = getIN(2)
  clutch   = getIN(3)
	
    
		
  if throttle < 0 then
    clutch_on = current_gear == 0
		current_gear = 0
    throttle = -throttle
    
  elseif current_gear == 0 and throttle > 0 then
    current_gear = 1
    clutch_on = false
    shift_timer = 100

  elseif math.abs(throttle) < 0.01 then
		current_gear = 1
		clutch_on = false
    shift_timer = 100
		
  elseif shift_timer > 0 then
    if clutch == 1 then
      shift_timer = shift_timer - 1
    end
    clutch_on = true
		
	elseif rps_in > 16 and current_gear < 4 then
		current_gear = current_gear + 1
		clutch_on = false
		shift_timer = 100
		
	elseif rps_in < 6 and current_gear > 1 then
		current_gear = current_gear - 1
		clutch_on = false
    shift_timer = 100
    
  else
    clutch_on = true
	end
	
	gb_1 = current_gear == 0
	gb_2 = current_gear == 3 or current_gear == 4
	gb_3 = current_gear == 2 or current_gear == 4
	
	output.setNumber(1, math.abs(throttle))
	output.setNumber(2, current_gear)
	output.setBool(3, gb_1)
	output.setBool(4, gb_2)
	output.setBool(5, gb_3)
	output.setBool(6, clutch_on)
end

