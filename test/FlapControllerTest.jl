#
# Author: Nisha Jagtiani
#

module FlapControllerTest

# used for storing wind effect profiles
type WindEffectProfile
  min::Int64
  max::Int64
  probability::Float64
  profile_type::AbstractString
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

end #module
