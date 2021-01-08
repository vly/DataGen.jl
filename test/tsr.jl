using Test

using DataGen

@testset "tsr" begin

@testset "gen_ts" begin
    x = gen_ts()
    @test size(x)  == (365, 4)
    @test names(x) == ["sample", "trends", "seasonality", "remainder"]
    @test isapprox(x.sample, x.trends + x.seasonality + x.remainder)
end

end # testset tsr
