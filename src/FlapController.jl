#
# Author: Nisha Jagtiani
#

module FlapController

export FlapControl, FlapControlParams, ProfileData, WindEffectProfile, initialize, step, isterminal, randProfile

type ProfileData
  min::Int64
  max::Int64
  probability::Float64
end

# used for storing wind effect profiles
type WindEffectProfile
  ptype::AbstractString
  data::Array{ProfileData}
end

type FlapControlParams
  starting_flap_position::Int64
  min_position::Int64
  max_position::Int64
  goal_position::Int64
  actuator1_strength::Int64
  actuator2_strength::Int64
  profile::WindEffectProfile
  logging::Bool
end

# controller
type FlapControl
  params::FlapControlParams
  flap_position::Int64
  t::Int64 #num steps
  #log::Vector{Float64}
  #initialize::Function #initialize(sim)
  #step::Function #step(sim)
  #isterminal::Function #isterminal(sim)

  function FlapControl(params::FlapControlParams)
    fc = new()
    fc.params = params
    fc.flap_position = params.starting_flap_position
    #fc.initialize = initialize_fn
    #fc.step = step_fn
    #fc.isterminal = isterminal_fn
    return fc
  end

end

function randProfile(profile::WindEffectProfile)
  randprof = profile.data[rand(1:end)]
  return rand(randprof.min:randprof.max) , randprof.probability
end


#perform actuation step and safety check
function actuate(sim::FlapControl, strength::Int64)
  
  actuator_effect = strength
  rand_wind_effect , rand_prob = randProfile(sim.params.profile)

  if sim.params.goal_position > sim.flap_position
    actuator_effect = strength
  else
    actuator_effect = -1 * strength
  end
  
  if sim.params.goal_position - sim.flap_position > strength || sim.params.goal_position < -1*strength
    sim.flap_position = sim.flap_position + actuator_effect + rand_wind_effect;
  end
end

#initialize
function initialize(sim::FlapControl)
  #sim.flap_position = sim.params.starting_flap_position
  sim.t = 0
  #empty!(sim.log)
  #if sim.params.logging
  #  push!(sim.log, sim.flap_position)
  #end
end


#isterminal
function isterminal(sim::FlapControl)
  sim.t >= sim.params.endtime
  #sim.flap_position > sim.params.max_position || sim.flap_position <= sim.params.min_position
end

#step
function step(sim::FlapControl)
  #sim.flap_position = sim.flap_position + 1
  sim.t += 1
  #actuate(sim , sim.params.actuator1_strength)
  #actuate(sim , sim.params.actuator2_strength)
end

end #module
