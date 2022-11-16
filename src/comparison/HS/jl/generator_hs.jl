function problem_generator_hs(
                                nprob::Int64
                                )

    @assert 1 ≤ nprob ≤ 100 "The number of the problem must satisfy 1 ≤ nprob ≤ 100."

    # Defines the objective functions based on Hock-Schittkowski test-set.

    function hs1(x)

        return 100.0 * ( x[2] - x[1] ^ 2.0 ) ^ 2.0 + ( 1.0 - x[1] ) ^ 2.0

    end

    function hs3(x)

        return x[2] + 1.0e-5 * ( x[2] - x[1] ) ^ 2.0

    end

    function hs4(x)

        return ( x[1]  + 1.0 ) ^ 3.0 / 3.0 + x[2]

    end

    function hs5(x)

        return sin( x[1] + x[2] ) + ( x[1] - x[2] ) ^ 2.0 - 1.5 * x[1] + 2.5 * x[2] + 1.0

    end

    function hs25(x)

        s = 0.0

        for i = 1:99

            ui = 25.0 + ( - 50.0 * log( 0.01 * i ) ) ^ ( 2.0 / 3.0)

            s += ( - 0.01 * i + exp( - ( 1.0 / x[1] ) * ( ui - x[2] ) ^ ( x[3] ) ) ) ^ 2.0

        end

        return s

    end

    function hs38(x)

        return 100.0 * ( x[2] - x[1] ^ 2.0 ) ^ 2.0 + ( 1.0 - x[1] ) ^ 2.0 + 90.0 * ( x[4] - x[3] ^ 2.0 ) ^ 2.0 + ( 1.0 - x[3] ) ^ 2.0 + 10.1 * ( ( x[2] - 1.0 ) ^ 2.0 + ( x[4] - 1.0 ) ^ 2.0 ) + 19.8 * ( x[2] - 1.0 ) * ( x[4] - 1.0 )

    end

    function hs45(x)

        return 2.0 - x[1] * x[2] * x[3] * x[4] * x[5] / 120.0

    end

    function hs110(x)

        s1 = 0.0
        s2 = 1.0

        for i = 1:10

            s1 += ( log( x[i] - 2.0 ) ) ^ 2.0 + ( log( 10.0 - x[i] ) ) ^ 2.0
            s2 *= x[i]

        end     

        return s1 - s2 ^ ( 0.2 )

    end

    # Initializes some useful variables and constants
    c_lower = - 1.0e20
    c_upper = 1.0e20

    if nprob == 1

        n = 2
        x = [ -2.0, 1.0 ]
        l = [ c_lower, 0.0 ]
        u = c_upper * ones(Float64, n)
        fmin = [ hs1, hs3 ]

    elseif nprob == 2
        
        n = 2
        x = [ 1.125, 0.125 ]
        l = [ 1.0, 0.0 ]
        u = c_upper * ones(Float64, n)
        fmin = [ hs1, hs4 ]

    elseif nprob == 3

        n = 2
        x = zeros(Float64, n)
        l = [ - 1.5, - 1.5 ]
        u = [ 4.0, 3.0 ]
        fmin = [ hs1, hs5 ]

    elseif nprob == 4
        
        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 0.1, 0.0, 0.0 ]
        u = [ 100.0, 25.6, 5.0 ]
        fmin = [ hs1, hs25 ]

    elseif nprob == 5
        
        n = 4
        x = [ - 3.0, - 1.0, - 3.0, - 1.0 ]
        l = [ - 10.0, - 1.5, - 10.0, - 10.0 ]
        u = 10.0 * ones(Float64, n)
        fmin = [ hs1, hs38 ]

    elseif nprob == 6

        n = 5
        x = 2.0 * ones(Float64, n)        
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs45 ]

    elseif nprob == 7

        n = 10
        x = 9.0 * ones(Float64, n)        
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs1, hs110 ]

    elseif nprob == 8

        n = 2
        x = [ 1.125, 0.125 ]
        l = [ 1.0, 0.0 ]
        u = c_upper * ones(Float64, n)
        fmin = [ hs3, hs4 ]

    elseif nprob == 9

        n = 2
        x = zeros(Float64, n)        
        l = [ - 1.5, 0.0 ]
        u = [ 4.0, 3.0 ]
        fmin = [ hs3, hs5 ]

    elseif nprob == 10

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 0.1, 0.0, 0.0 ]
        u = [ 100.0, 25.6, 5.0 ]
        fmin = [ hs3, hs25 ]

    elseif  nprob == 11

        n = 4
        x = [ - 3.0, - 1.0, - 3.0, - 1.0 ]
        l = [ - 10.0, 0.0, - 10.0, - 10.0 ]
        u = 10.0 * ones(Float64, 4)
        fmin = [ hs3, hs38 ]

    elseif nprob == 12

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs45 ]

    elseif nprob == 13

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs3, hs110 ]

    elseif nprob == 14

        n = 2
        x = [ 1.125, 0.125 ]
        l = [ 1.0, 0.0 ]
        u = [ 4.0, 3.0 ]
        fmin = [ hs4, hs5 ]

    elseif nprob == 15

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 1.0, 0.0, 0.0 ]
        u = [ 100.0, 25.6, 5.0 ]
        fmin = [ hs4, hs25 ]

    elseif nprob == 16

        n = 4
        x = [ 3.0, 1.0, - 3.0, - 1.0 ]
        l = [ 1.0 , 0.0, - 10.0, - 10.0 ]
        u = 10.0 * ones(Float64, n)
        fmin = [ hs4, hs38 ]

    elseif nprob == 17

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs4, hs110 ]

    elseif nprob == 18

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ -1.5, -3.0, -10.0, -10.0 ]
        u = [ 4.0, 3.0, 10.0, 10.0 ]
        fmin = [ hs5, hs38 ]

    elseif nprob == 19

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs5, hs45 ]

    elseif nprob == 20

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 0.1, 0.0, 0.0, -10.0 ]
        u = [ 10.0, 10.0, 5.0, 10.0 ]
        fmin = [ hs25, hs38 ]

    elseif nprob == 21

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs25, hs45 ]

    elseif nprob == 22

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs38, hs45 ]

    elseif nprob == 23

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs38, hs110 ]

    elseif nprob == 24

        n = 2
        x = [10.0, 1.0]
        l = [1.0, 0.0]
        u = c_upper * ones(Float64, n)
        fmin = [ hs1, hs3, hs4 ]

    elseif nprob == 25

        n = 2
        x = [10.0, 1.0]
        l = [- 1.5, 0.0]
        u = [4.0, 3.0]
        fmin = [ hs1, hs3, hs5 ]

    elseif nprob == 26

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 0.1, 0.0, 0.0 ]
        u = [ 100.0, 25.6, 5.0 ]
        fmin = [ hs1, hs3, hs25 ]

    elseif  nprob == 27

        n = 4
        x = [ - 3.0, - 1.0, - 3.0, - 1.0 ]
        l = [ - 10.0, 0.0, - 10.0, - 10.0 ]
        u = 10.0 * ones(Float64, 4)
        fmin = [ hs1, hs3, hs38 ]

    elseif nprob == 28

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs3, hs45 ]

    elseif nprob == 29

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs1, hs3, hs110 ]

    elseif nprob == 30

        n = 2
        x = [ 1.125, 0.125 ]
        l = [ 1.0, 0.0 ]
        u = [ 4.0, 3.0 ]
        fmin = [ hs1, hs4, hs5 ]

    elseif nprob == 31

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 1.0, 0.0, 0.0 ]
        u = [ 100.0, 25.6, 5.0 ]
        fmin = [ hs1, hs4, hs25 ]

    elseif nprob == 32

        n = 4
        x = [ 3.0, 1.0, - 3.0, - 1.0 ]
        l = [ 1.0 , 0.0, - 10.0, - 10.0 ]
        u = 10.0 * ones(Float64, n)
        fmin = [ hs1, hs4, hs38 ]

    elseif nprob == 33

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs1, hs4, hs110 ]

    elseif nprob == 34

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ -1.5, 0.0, -10.0, -10.0 ]
        u = [ 4.0, 3.0, 10.0, 10.0 ]
        fmin = [ hs1, hs5, hs38 ]

    elseif nprob == 35

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs5, hs45 ]

    elseif nprob == 36

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 0.1, 0.0, 0.0, -10.0 ]
        u = [ 10.0, 10.0, 5.0, 10.0 ]
        fmin = [ hs1, hs25, hs38 ]

    elseif nprob == 37

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs25, hs45 ]
    
    elseif nprob == 38

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs38, hs45 ]

    elseif nprob == 39

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs1, hs38, hs110 ]

    elseif nprob == 40

        n = 2
        x = [ 1.125, 0.125 ]
        l = [ 1.0, 0.0 ]
        u = [ 4.0, 3.0 ]
        fmin = [ hs3, hs4, hs5 ]

    elseif nprob == 41

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 1.0, 0.0, 0.0 ]
        u = [ 100.0, 25.6, 5.0 ]
        fmin = [ hs3, hs4, hs25 ]

    elseif nprob == 42

        n = 4
        x = [ 3.0, 1.0, - 3.0, - 1.0 ]
        l = [ 1.0 , 0.0, - 10.0, - 10.0 ]
        u = 10.0 * ones(Float64, n)
        fmin = [ hs3, hs4, hs38 ]

    elseif nprob == 43

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs3, hs4, hs110 ]

    elseif nprob == 44

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ -1.5, 0.0, -10.0, -10.0 ]
        u = [ 4.0, 3.0, 10.0, 10.0 ]
        fmin = [ hs3, hs5, hs38 ]

    elseif nprob == 45

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs5, hs45 ]

    elseif nprob == 46

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 0.1, 0.0, 0.0, -10.0 ]
        u = [ 10.0, 10.0, 5.0, 10.0 ]
        fmin = [ hs3, hs25, hs38 ]

    elseif nprob == 47

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs25, hs45 ]

    elseif nprob == 48

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs38, hs45 ]

    elseif nprob == 49

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs3, hs38, hs110 ]

    elseif nprob == 50

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 1.0, 0.0, 0.0 ]
        u = [ 4.0, 3.0, 5.0 ]
        fmin = [ hs4, hs5, hs25 ]

    elseif nprob == 51

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 1.0, 0.0, -10.0, -10.0 ]
        u = [ 4.0, 3.0, 10.0, 10.0 ]
        fmin = [ hs4, hs5, hs38 ]

    elseif nprob == 52

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs4, hs5, hs45 ]

    elseif nprob == 53

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 1.0, 0.0, 0.0, -10.0 ]
        u = [ 10.0, 10.0, 5.0, 10.0 ]
        fmin = [ hs4, hs25, hs38 ]

    elseif nprob == 54

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs4, hs25, hs45 ]

    elseif nprob == 55

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs4, hs38, hs110 ]

    elseif nprob == 56

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 0.1, 0.0, 0.0, -10.0 ]
        u = [ 4.0, 3.0, 5.0, 10.0 ]
        fmin = [ hs5, hs25, hs38 ]

    elseif nprob == 57

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs5, hs25, hs45 ]

    elseif nprob == 58

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs5, hs38, hs45 ]

    elseif nprob == 59

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs25, hs38, hs45 ]

    elseif nprob == 60

        n = 2
        x = [ 1.125, 0.125 ]
        l = [ 1.0, 0.0 ]
        u = [ 4.0, 3.0 ]
        fmin = [ hs1, hs3, hs4, hs5 ]

    elseif nprob == 61

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 1.0, 0.0, 0.0 ]
        u = [ 100.0, 25.6, 5.0 ]
        fmin = [ hs1, hs3, hs4, hs25 ]

    elseif nprob == 62

        n = 4
        x = [ 3.0, 1.0, - 3.0, - 1.0 ]
        l = [ 1.0 , 0.0, - 10.0, - 10.0 ]
        u = 10.0 * ones(Float64, n)
        fmin = [ hs1, hs3, hs4, hs38 ]

    elseif nprob == 63

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs1, hs3, hs4, hs110 ]

    elseif nprob == 64

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 0.1, 0.0, 0.0 ]
        u = [ 4.0, 3.0, 5.0 ]
        fmin = [ hs1, hs3, hs5, hs25 ]

    elseif nprob == 65

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ -1.5, 0.0, -10.0, -10.0 ]
        u = [ 4.0, 3.0, 10.0, 10.0 ]
        fmin = [ hs1, hs3, hs5, hs38 ]

    elseif nprob == 66

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs3, hs5, hs45 ]

    elseif nprob == 67

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 0.1, 0.0, 0.0, -10.0 ]
        u = [ 10.0, 10.0, 5.0, 10.0 ]
        fmin = [ hs1, hs3, hs25, hs38 ]

    elseif nprob == 68

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs3, hs25, hs45 ]

    elseif nprob == 69

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs3, hs38, hs45 ]

    elseif nprob == 70

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs1, hs3, hs38, hs110 ]

    elseif nprob == 71

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 1.0, 0.0, 0.0 ]
        u = [ 4.0, 3.0, 5.0 ]
        fmin = [ hs1, hs4, hs5, hs25 ]

    elseif nprob == 72

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 1.0, 0.0, -10.0, -10.0 ]
        u = [ 4.0, 3.0, 10.0, 10.0 ]
        fmin = [ hs1, hs4, hs5, hs38 ]

    elseif nprob == 73

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 1.0, 0.0, 0.0, -10.0 ]
        u = [ 10.0, 10.0, 5.0, 10.0 ]
        fmin = [ hs1, hs4, hs25, hs38 ]

    elseif nprob == 74

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs1, hs4, hs38, hs110 ]

    elseif nprob == 75

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 0.1, 0.0, 0.0, -10.0 ]
        u = [ 4.0, 3.0, 5.0, 10.0 ]
        fmin = [ hs1, hs5, hs25, hs38 ]

    elseif nprob == 76

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs5, hs25, hs45 ]

    elseif nprob == 77

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs5, hs38, hs45 ]

    elseif nprob == 78

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs25, hs38, hs45 ]

    elseif nprob == 79

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 1.0, 0.0, 0.0 ]
        u = [ 4.0, 3.0, 5.0 ]
        fmin = [ hs3, hs4, hs5, hs25 ]

    elseif nprob == 80

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 1.0, 0.0, -10.0, -10.0 ]
        u = [ 4.0, 3.0, 10.0, 10.0 ]
        fmin = [ hs3, hs4, hs5, hs38 ]
   
    elseif nprob == 81

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 1.0, 0.0, 0.0, -10.0 ]
        u = [ 10.0, 10.0, 5.0, 10.0 ]
        fmin = [ hs3, hs4, hs25, hs38 ]

    elseif nprob == 82

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 0.1, 0.0, 0.0, -10.0 ]
        u = [ 4.0, 3.0, 5.0, 10.0 ]
        fmin = [ hs3, hs5, hs25, hs38 ]

    elseif nprob == 83

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs5, hs25, hs45 ]

    elseif nprob == 84

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs5, hs38, hs45 ]

    elseif nprob == 85

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs25, hs38, hs45 ]

    elseif nprob == 86

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 1.0, 0.0, 0.0, -10.0 ]
        u = [ 4.0, 3.0, 5.0, 10.0 ]
        fmin = [ hs4, hs5, hs25, hs38 ]

    elseif nprob == 87

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs5, hs25, hs38, hs45 ]

    end

    return x, l, u, fmin

end