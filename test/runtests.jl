using Test

tests = [
    "tsr",
]


@testset "DataGen" begin
    @info("Running tests:")

    for test ∈ tests
        @info("\t* $test ...")
        include("$test.jl")
    end
end