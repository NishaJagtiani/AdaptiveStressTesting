#
# Author: Nisha Jagtiani
#

module FlapController

export FlapControl, FlapControlParams, initialize, isterminal, step

type FlapControlParams
  starting_flap_position::Int64
  min_position::Int64
  max_position::Int64
  goal_position::Int64
  wind_effect::Int64
  actuator1_strength::Int64
  actuator2_strength::Int64
end

# controller
type FlapControl
  params::FlapControlParams
  sim
  flap_position
  initialize::Function #initialize(sim)
  step::Function #step(sim)
  isterminal::Function #isterminal(sim)

  function FlapControl(params::FlapControlParams, sim, initialize_fn::Function, step_fn::Function, isterminal_fn::Function)
    fc = new()
    fc.params = params
    fc.sim = sim
    fc.flap_position = params.starting_flap_position
    fc.initialize = initialize_fn
    fc.step = step_fn
    fc.isterminal = isterminal_fn
    fc.actuator1 = FlapActuator(fc, params.actuator1_strength)
    fc.actuator2 = FlapActuator(fc, params.actuator2_strength)
    return fc
  end

end

# actuator type
type FlapActuator
  controller::FlapControl
  strength::Int64
  function FlapActuator(fc::FlapControl, str::Int64)
    fa = new()
    fa.controller = fc
    fa.strength = str
    return fa
  end
end

#perfrom actuation step and safety check
function actuate(actuator::FlapActuator)
  
  actuator_effect = actuator.strength
  if actuator.controller.params.goal_position > actuator.controller.flap_position
    actuator_effect = actuator.strength
  else
    actuator_effect = -1 * actuator.strength
  end
  
  if actuator.controller.params.goal_position - actuator.controller.flap_position > actuator.strength || actuator.controller.params.goal_position < -1*actuator.strength
    actuator.controller.flap_position = actuator.controller.flap_position + actuator_effect + actuator.controller.params.wind_effect;
  end
end

#initialize
function initialize(sim::FlapControl)
  sim.flap_position = sim.params.starting_flap_position
end


#isterminal
function isterminal(sim::FlapControl)
  sim.flap_position > sim.params.max_position || sim.flap_position <= sim.params.min_position
end

#step
function step(sim::FlapControl)
  #does each step move one actuator or both?
  #assuming it moves both
  actuate(sim.actuator1);
  actuate(sim.actuator2);
end



end #module
