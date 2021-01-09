# generate sample timeseries data
# a port of https://github.com/LeeDoYup/RobustSTL/blob/master/sample_generator.py
using StatsBase, Distributions

function getRandomChoice(total_length::Int, num_choice::Int; 
                         replace = false)
    @assert !(replace == false && num_choice > total_length) "Draws without replacement must not exceed population size"
    sample(1:total_length, num_choice; replace = replace)
end

function getChange(change_type::String, change_level::Number)
    @assert change_type in ["random", "spike", "increase", "dip", "decrease"] "Not a valid change type"

    if change_type in ["random"]
        rand([-1, 1]) * change_level
    elseif change_type in ["dip", "decrease"]
        -1.0 * change_level
    else
        change_level
    end
end

function getSeason(season_n::Int, season_type::String, season_level::Number)
    @assert season_type in ["random", "stair"] "Not a valid season type"

    season = zeros(season_n)
    if season_type == "random"
        season = 2.0 * (rand(season_n) .- 0.5) * season_level
    else
        centre = season_n ÷ 2
        season[1:centre] .+= season_level
        season[centre + 1: end] .-= season_level
    end
    season
end

function genSeasons(total_n, season_n, season_num, season_type, season_level)
    season = getSeason(season_n, season_type, season_level)
    repeat(season, season_num)[1:total_n]
end

function genRemainder(total_n, noise_mean, noise_std)
    rand(Normal(noise_mean, noise_std), total_n)
end

function genAnomalies(total_n, anomaly_num, anomaly_type, anomaly_level)
    anomalyLocs = getRandomChoice(total_n, anomaly_num)
    anomalies = zeros(total_n)
    map(x -> anomalies[x] += getChange(anomaly_type, anomaly_level), anomalyLocs)
    anomalies
end

function genTrends(total_n, trend_change_num, trend_type, trend_level)
    trends = zeros(total_n)
    change_points = getRandomChoice(total_n, trend_change_num)
    map(x -> trends[x:end] .+= getChange(trend_type, trend_level), change_points)
    trends
end

function gen_ts(total_n::Number, season_n::Number;
    season_type = "stair",
    season_level = 1,
    trend_type = "random",
    trend_level = 3,
    trend_change_num = 10,
    anomaly_num = 6,
    anomaly_type = "random",
    anomaly_level = 4,
    noise_mean = 0,
    noise_std = 0.316)

    @assert total_n >= season_n "Dataset length must be equal or greater to seasonality"

    season_num = (total_n ÷ season_n) + 1

    trends = genTrends(total_n, trend_change_num, trend_type, trend_level)
    seasons = genSeasons(total_n, season_n, season_num, season_type, season_level)
    remainders = genRemainder(total_n, noise_mean, noise_std)
    anomalies = genAnomalies(total_n, anomaly_num, anomaly_type, anomaly_level)
    sample = trends + seasons + remainders + anomalies

    DataFrame(sample = sample,
            trends = trends,
            seasonality = seasons,
            remainder = remainders + anomalies)
end

"""
    gen_ts()

Generates a basic timeseries with trend, seasonality, noise and some anomalies.
Returns a dataframe with individual components as well as the composite `sample`.
"""
function gen_ts()
    gen_ts(365, 30)
end