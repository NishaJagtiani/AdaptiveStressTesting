#
# Author: Nisha Jagtiani
#

module FlapController

# used for storing wind effect profiles
type WindEffectProfile
  min::Int64
  max::Int64
  probability::Float64
  profile_type::AbstractString
end

# controller
type FlapControl
  obj::FlapControl
  flap_position::Int64
  min_position::Int64
  max_position::Int64
  goal_position::Int64
  wind_effect::Int64

  # parameterized constructor
  FlapControl(goal_position, wind_effect) =
    (x = new();
     x.flap_position = 0; #starting flap_position
     x.min_position = 0;
     x.max_position = 15;
     x.goal_position = goal_position;
     x.wind_effect = wind_effect;
     x.obj = x)
end

# actuator type
type FlapActuator
  strength::Int64
  controller::FlapControl
end


# returns an array with sample profile data
function createprofiles()
  profiles = Array(WindEffectProfile,0)
  push!(profiles, WindEffectProfile(-15, -10, 0.02, "weak"))
  push!(profiles, WindEffectProfile(-15, -10, 0.18, "strong"))
  push!(profiles, WindEffectProfile(-10, -5, 0.10, "weak"))
  push!(profiles, WindEffectProfile(-10, -5, 0.20, "strong"))
  push!(profiles, WindEffectProfile(-5, 5, 0.75, "weak"))
  push!(profiles, WindEffectProfile(-5, 5, 0.30, "strong"))
  push!(profiles, WindEffectProfile(5, 10, 0.10, "weak"))
  push!(profiles, WindEffectProfile(5, 10, 0.20, "strong"))
  push!(profiles, WindEffectProfile(10, 15, 0.02, "weak"))
  push!(profiles, WindEffectProfile(10, 15, 0.18, "strong"))
  return profiles
end

# returns a random profile
function getrandomprofile(profiles::Array{WindEffectProfile})
  r = rand(1:length(profiles))
  return profiles[r]
end

#returns a random value for wind effect within min and max range
function getrandomwindeffect(profile::WindEffectProfile)
  return rand(profile.min:profile.max)
end

#perfrom actuation step and safety check
function actuate(actuator::FlapActuator)
  actuator_effect = actuator.strength
  while actuator.controller.goal_position - actuator.controller.flap_position > actuator.strength || actuator.controller.goal_position < -1*actuator.strength
    if actuator.controller.goal_position > actuator.controller.flap_position
      actuator_effect = actuator.strength
    else
      actuator_effect = -1 * actuator.strength
    end

    actuator.controller.flap_position = actuator.controller.flap_position + actuator_effect + actuator.controller.wind_effect;
    println("flap_position : ", actuator.controller.flap_position);
    if(actuator.controller.flap_position > actuator.controller.max_position || actuator.controller.flap_position <= actuator.controller.min_position)
      println("stop : ", actuator.controller.flap_position);
      break;
    end
  end
end

#initialize
function initialize()
end

#isterminal
function isterminal()
end

#step
function step()
end



end #module
