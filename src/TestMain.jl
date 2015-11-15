#
# Author: Nisha Jagtiani
#

include("FlapController.jl")

using FlapController

const STARTING_POSITION = 1
const MIN_POSITION = 0
const MAX_POSITION = 15
const GOAL_POSITION = 17
const ACTUATOR1_STRENGTH = 10
const ACTUATOR2_STRENGTH = 1

weak_profile_data = Array(ProfileData, 0)
push!(weak_profile_data, ProfileData(-15, -10, 0.02))
push!(weak_profile_data, ProfileData(-10, -5, 0.10))
push!(weak_profile_data, ProfileData(-5, 5, 0.75))
push!(weak_profile_data, ProfileData(5, 10, 0.10))
push!(weak_profile_data, ProfileData(10, 15, 0.02))
weak_profile = WindEffectProfile("weak", weak_profile_data)

strong_profile_data = Array(ProfileData, 0)
push!(strong_profile_data, ProfileData(-15, -10, 0.18))
push!(strong_profile_data, ProfileData(-10, -5, 0.20))
push!(strong_profile_data, ProfileData(-5, 5, 0.30))
push!(strong_profile_data, ProfileData(5, 10, 0.20))
push!(strong_profile_data, ProfileData(10, 15, 0.18))
strong_profile = WindEffectProfile("strong", strong_profile_data)

sim_params = FlapControlParams(STARTING_POSITION, MIN_POSITION, MAX_POSITION, GOAL_POSITION, ACTUATOR1_STRENGTH, ACTUATOR2_STRENGTH, weak_profile, false);
sim = FlapControl(sim_params)
