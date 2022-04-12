using Test

@testset "getsymbols!" begin

    ex = :(a)

    s = Set{Symbol}()

    @test(getsymbols!(ex, s) == ex)
    @test(isempty(s))

    ex = :(tunninginput(a))

    s = Set{Symbol}()

    @test(getsymbols!(ex, s) == :(a))
    @test(ex == :(tunninginput(a)))
    @test(s == Set([:a]))
    
    ex = :(f(tunninginput(a), b))

    s = Set{Symbol}()

    @test(getsymbols!(ex, s) == :(f(a, b)))
    @test(ex == :(f(tunninginput(a), b)))
    @test(s == Set([:a]))
    
    ex = :(f(cos(sin(tunninginput(a))), [tunninginput(b), tunninginput(c), 5]))

    s = Set{Symbol}()

    @test(getsymbols!(ex, s) == :(f(cos(sin(a)), [b, c, 5])))
    @test(ex == :(f(cos(sin(tunninginput(a))), [tunninginput(b), tunninginput(c), 5])))
    @test(s == Set([:a, :b, :c]))
    
end
