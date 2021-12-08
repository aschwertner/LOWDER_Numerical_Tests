function problem_generator_mw(
                            nprob::Int64,
                            n::Int64,
                            m::Int64,
                            rsp::Bool;
                            unconstrained::Bool=false,
                            x::Vector{Float64}=( NaN * ones(Float64, n) )
                            )

    @assert 0 ≤ nprob ≤ 22 "The number of the problem must satisfy 0 ≤ nprob ≤ 22."
    @assert length(x) == n "The dimension of vetor x must be n."

    # Initializes some useful variables and constants
    c_lower = - 1.0e20
    c_upper = 1.0e20

    if isnan( x[1] )

        usual_init_point = true

    end

    if nprob == 1

        # Linear function - Full Rank.

        @assert m ≥ n "The dimensions of the problem must satisfy m ≥ n."

        if usual_init_point

            @. x = 1.0

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = 0.75 * ones(Float64, n)
            u = 15.0 * ones(Float64, n)

        end

        fmin = Array{Function}(undef, m)
        c = 2.0 / m

        for i = 1:n

            fmin[i] = x -> ( x[i] - c * sum(x) - 1.0 ) ^ 2.0 

        end

        for i = (n+1):m

            fmin[i] = x -> ( - c * sum(x) - 1.0 ) ^ 2.0

        end

    elseif nprob == 2

        # Linear function - Rank 1.

        @assert m ≥ n "The dimensions of the problem must satisfy m ≥ n."

        if usual_init_point

            @. x = 1.0

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = - ones(Float64, n)
            u = 10.0 * ones(Float64, n)

        end

        fmin = Array{Function}(undef, m)

        function f2(x)

            s = 0.0

            for i=1:length(x)

                s += i * x[i]

            end

            return s

        end

        for i=1:m

            fmin[i] = x -> ( i * f2(x) - 1.0 ) ^ 2.0

        end

    elseif nprob == 3

        # Linear function - Rank 1 with zero columns and rows.

        @assert m ≥ n "The dimensions of the problem must satisfy m ≥ n."

        if usual_init_point

            @. x = 1.0

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = 2.0 * ones(Float64, n)
            u = 7.0 * ones(Float64, n)

        end

        fmin = Array{Function}(undef, m)

        function f3(x)

            s = 0.0

            for i=2:(length(x)-1)

                s += i * x[i]

            end

            return s

        end

        fmin[1] = x -> 1.0
        fmin[m] = x -> 1.0
        for i = 2:(m-1)

            fmin[i] = x -> ( ( i - 1.0 ) * f3(x) - 1.0 ) ^ 2.0

        end

    elseif nprob == 4 

        # Rosenbrock function.

        @assert ( n == 2 ) && ( m == 2 ) "The dimensions of the problem must satisfy n = m = 2."

        if usual_init_point

            @. x = [-1.2, 1.0]

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = - 5.0 * ones(Float64, n)
            u = zeros(Float64, n)

        end

        fmin = Array{Function}(undef, m)
        fmin[1] = x -> ( 10.0 * ( x[2] - x[1] ^ 2.0 ) ) ^ 2.0
        fmin[2] = x -> ( 1.0 - x[1] ) ^ 2.0

    elseif nprob == 5

        # Helical Valley function

        @assert ( n == 3 ) && ( m == 3 ) "The dimensions of the problem must satisfy n = m = 3."

        if usual_init_point

            @. x = [-1.0, 0.0, 0.0]

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = - 10.0 * ones(Float64, n)
            u = - ones(Float64, n)

        end

        fmin = Array{Function}(undef, m)
        
        function f5(x)

            if x[1] > 0.0

                return atan( x[2] / x[1] ) / ( 2.0 * pi )

            elseif x[1] < 0.0

                return atan( x[2] / x[1] ) / ( 2.0 * pi ) + 0.5

            else

                return 0.25

            end

        end

        fmin[1] = x -> ( 10.0 * ( x[3] - 10.0 * f5(x) ) ) ^ 2.0
        fmin[2] = x -> ( 10.0 * ( sqrt( x[1] ^ 2.0 + x[2] ^ 2.0 ) - 1.0 ) ) ^ 2.0
        fmin[3] = x -> ( x[3] ) ^ 2.0

    elseif nprob == 6

        # Powell Singular function

        @assert ( n == 4 ) && ( m == 4 ) "The dimensions of the problem must satisfy n = m = 4."

        if usual_init_point

            @. x = [3.0, -1.0, 0.0, 1.0]

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = - ones(Float64, n)
            u = 10.0 * ones(Float64, n)

        end

        fmin = Array{Function}(undef, m)
        fmin[1] = x -> ( x[1] + 10.0 * x[2] ) ^ 2.0
        fmin[2] = x -> 5.0 * ( x[3] - x[4] ) ^ 2.0
        fmin[3] = x -> ( x[2] - 2.0 * x[3] ) ^ 4.0
        fmin[4] = x -> 10.0 * ( x[1] - x[4] ) ^ 4.0

    elseif nprob == 7

        # Freudenstein and Roth function

        @assert ( n == 2 ) && ( m == 2 ) "The dimensions of the problem must satisfy n = m = 2."

        if usual_init_point

            @. x = [0.5, -2.0]

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = - 3.0 * ones(Float64, n)
            u = 3.0 * ones(Float64, n)

        end

        fmin = Array{Function}(undef, m)
        fmin[1] = x -> ( - 13.0 + x[1] + ( ( 5.0 - x[2] ) * x[2] - 2.0 ) * x[2] ) ^ 2.0
        fmin[2] = x -> ( - 29.0 + x[1] + ( ( x[2] + 1.0 ) * x[2] - 14.0 ) * x[2] ) ^ 2.0

    elseif nprob == 8

        # Bard function

        @assert ( n == 3 ) && ( m == 15 ) "The dimensions of the problem must satisfy n = 3 e m = 15."

        if usual_init_point

            @. x = 1.0

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = 0.5 * ones(Float64, n)
            u = 10.0 * ones(Float64, n)

        end

        fmin = Array{Function}(undef, m)

        y = [
                0.14, 0.18, 0.22, 0.25, 0.29, 
                0.32, 0.35, 0.39, 0.37, 0.58, 
                0.73, 0.96, 1.34, 2.10, 4.39
                ]

        for i=1:m

            v = 16.0 - i
            w = min( i, v )

            fmin[i] = x -> ( y[i] - ( x[1] + ( i ) / ( v * x[2] + w * x[3] ) ) ) ^ 2.0

        end

    elseif nprob == 9

        # Kowalik and Osborne function

        @assert ( n == 4 ) && ( m == 11 ) "The dimensions of the problem must satisfy n = 4 e m = 11."

        if usual_init_point

            @. x = [0.25, 0.39, 0.415, 0.39]

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = [0.0, 0.0, 0.415, 0.0]
            u = [0.275, 0.4, 1.0, 0.4]

        end

        fmin = Array{Function}(undef, m)
        y1 = [ 0.1957, 0.1947, 0.1735, 0.16, 0.0844, 0.0627, 0.0456, 0.0342, 0.0323, 0.0235, 0.0246 ]
        y2 = [ 4.0, 2.0, 1.0, 0.5, 0.25, 0.167, 0.125, 0.1, 0.0833, 0.0714, 0.0625 ]

        for i=1:m

            fmin[i] = x -> ( y1[i] - ( x[1] * ( y2[i] ^ 2.0 + y2[i] * x[2] ) ) / ( y2[i] ^ 2.0 + y2[i] * x[3] + x[4] ) ) ^ 2.0

        end

    elseif nprob == 10

        # Meyer function

        @assert ( n == 3 ) && ( m == 16 ) "The dimensions of the problem must satisfy n = 3 e m = 16."

        if usual_init_point

            @. x = [0.02, 4000.0, 250.0]

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = - 100.0 * ones(Float64, n)
            u = [100.0, 4000.0, 1000.0]

        end

        fmin = Array{Function}(undef, m)
        y = [
                34780.0, 28610.0, 23650.0, 19630.0, 16370.0, 13720.0, 11540.0, 9744.0,
                8261.0, 7030.0, 6005.0, 5147.0, 4427.0, 3820.0, 3307.0, 2872.0 ]

        for i=1:m

            fmin[i] = x -> ( x[1] * exp( x[2] / ( 45.0 + 5.0 * i + x[3] ) ) - y[i] ) ^ 2.0

        end

    elseif nprob == 11
        
        # Watson function

        @assert ( 2 ≤ n ≤ 31 ) && ( m == 31 ) "The dimensions of the problem must satisfy 2 ≤ n ≤ 31 e m = 31."

        if usual_init_point

            @. x = 0.0

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = ones(Float64, n)
            u = 10.0 * ones(Float64, n)

        end

        fmin = Array{Function}(undef, m)

        function f11a(x, ti)

            s = 0.0

            for j = 2:length(x)

                s += ( j - 1.0 ) * x[j] * ti ^ ( j - 2.0 )

            end

            return s

        end

        function f11b(x, ti)

            s = 0.0

            for j = 1:length(x)

                s += x[j] * ti ^ ( j - 1.0 )

            end

            return s

        end

        for i = 1:29

            ti = i / 29.0

            fmin[i] = x -> ( f11a(x, ti) - ( f11b(x, ti) ) ^ 2.0 - 1.0 ) ^ 2.0

        end

        fmin[30] = x -> ( x[1] ) ^ 2.0
        fmin[31] = x -> ( x[2] - x[1] ^ 2.0 - 1.0 ) ^ 2.0

    elseif nprob == 12

        # Box three-dimensional function

        @assert ( n == 3 ) && ( m ≥ n ) "The dimensions of the problem must satisfy n = 3 e m ≥ n."

        if usual_init_point

            @. x = [0.0, 10.0, 20.0]

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = [-1.0, -50.0, 15.0]
            u = [50.0, 10.0, 50.0]

        end

        fmin = Array{Function}(undef, m)

        for i=1:m

            ti = 0.1 * i

            fmin[i] = x -> ( exp( - ti * x[1] ) - exp( - ti * x[2] ) - x[3] * ( exp( - ti ) - exp( - 10.0 * ti ) ) ) ^ 2.0

        end

    elseif nprob == 13

        # Jennrich and Sampson function

        @assert ( n == 2 ) && ( m ≥ n ) "The dimensions of the problem must satisfy n = 2 e m ≥ n."

        if usual_init_point

            @. x = [0.3, 0.4]

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = [-5.0, 0.0]
            u = [0.3, 10.0]

        end

        fmin = Array{Function}(undef, m)

        for i=1:m

            fmin[i] = x -> ( 2.0 + 2.0 * i - ( exp( i * x[1] ) + exp( i * x[2] ) ) ) ^ 2.0

        end

    elseif nprob == 14

        # Brown and Dennis function

        @assert ( n == 4 ) && ( m ≥ n ) "The dimensions of the problem must satisfy n = 4 e m ≥ n."

        if usual_init_point

            @. x = [25.0, 5.0, - 5.0, - 1.0]

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = [0.0, 0.0, -10.0, -10.0]
            u = [35.0, 10.0, 10.0, 0.0]

        end

        fmin = Array{Function}(undef, m)

        for i = 1:m

            ti = i / 5.0

            fmin[i] = x -> ( ( x[1] + ti * x[2] - exp( ti ) ) ^ 2.0 + ( x[3] + x[4] * sin( ti ) - cos( ti ) ) ^ 2.0 ) ^ 2.0

        end

    elseif nprob == 15

        # Chebyquad function

        @assert ( n ≥ 1 ) && ( m ≥ n ) "The dimensions of the problem must satisfy n ≥ 1 e m ≥ n."

        if usual_init_point

            c = n + 1.0

            for i=1:n

                x[i] = i / c

            end

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = zeros(Float64, n)
            l[n] = 0.75 
            u = ones(Float64, n)

        end

        fmin = Array{Function}(undef, m)

        function f15a(x, i)

            y = 2.0 * x - 1.0
        
            if y > 1.0
        
                return cosh( i * acosh( y ) )
        
            elseif y < - 1.0
        
                return ( - 1.0 ) ^ i * cosh( i * acosh( - y ) )
        
            else
        
                return cos( i * acos( y ) )
        
            end
        
        end

        function f15b(x, i)

            n = length(x)
        
            s = 0.0
        
            for j=1:n
        
                a = f15a( x[j], i )
                s += a
        
            end
        
            s *= ( 1.0 / n )
        
            if iseven( i )
        
                s += 1.0 / ( i ^ 2.0 - 1.0 )
        
            end
        
            return s
           
        end

        for i=1:m

            fmin[i] = x -> ( f15b(x, i) ) ^ 2.0

        end

    elseif nprob == 16

        # Brown almost-linear function

        @assert ( n ≥ 1 ) && ( m == n ) "The dimensions of the problem must satisfy n ≥ 1 e m = n."

        if usual_init_point

            @. x = 0.5

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = - ones(Float64, n)
            u = 0.75 * ones(Float64, n)

        end

        fmin = Array{Function}(undef, m)

        for i = 1:(n-1)

            fmin[i] = x -> ( x[i] + sum(x) - ( n + 1.0 ) ) ^ 2.0

        end

        fmin[n] = x -> ( prod(x) - 1.0 ) ^ 2.0

    elseif nprob == 17

        # Osborne 1 function

        @assert ( n == 5 ) && ( m == 33 ) "The dimensions of the problem must satisfy n = 5 e m = 33."

        if usual_init_point

            @. x = [0.5, 1.5, -1.0, 0.01, 0.02]

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = - ones(Float64, n)
            u = 2.0 * ones(Float64, n)

        end

        fmin = Array{Function}(undef, m)
        y = [
                0.844, 0.908, 0.932, 0.936, 0.925, 0.908, 0.881, 0.850, 0.818, 0.784, 0.751,
                0.718, 0.685, 0.658, 0.628, 0.603, 0.580, 0.558, 0.538, 0.522, 0.506, 0.490,
                0.478, 0.467, 0.457, 0.448, 0.438, 0.431, 0.424, 0.420, 0.414, 0.411, 0.406
                ]

        for i = 1:m

            ti = 10.0 * (i - 1.0)
            fmin[i] = x -> ( y[i] - ( x[1] + x[2] * exp( - ti * x[4] ) + x[3] * exp( - ti * x[5] ) ) ) ^ 2.0

        end

    elseif nprob == 18

        # Osborne 2 function

        @assert ( n == 11 ) && ( m == 65 ) "The dimensions of the problem must satisfy n = 11 e m = 65."

        if usual_init_point

            @. x = [1.3, 0.65, 0.65, 0.7, 0.6, 3.0, 5.0, 7.0, 2.0, 4.5, 5.5]

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = zeros(Float64, n)
            l[n] = 4.0
            u = 50.0 * ones(Float64, n)
            u[1] = 14.0, u[2] = 5.0, u[3] = 5.0, u[4] = 5.0

        end

        fmin = Array{Function}(undef, m)
        y = [
                1.366, 1.191, 1.112, 1.013, 0.991, 0.885, 0.831, 0.847, 0.786, 0.725, 0.746, 0.679, 0.608,
                0.655, 0.616, 0.606, 0.602, 0.626, 0.651, 0.724, 0.649, 0.649, 0.694, 0.644, 0.624, 0.661,
                0.612, 0.558, 0.533, 0.495, 0.500, 0.423, 0.395, 0.375, 0.372, 0.391, 0.396, 0.405, 0.428,
                0.429, 0.523, 0.562, 0.607, 0.653, 0.672, 0.708, 0.633, 0.668, 0.645, 0.632, 0.591, 0.559,
                0.597, 0.625, 0.739, 0.710, 0.729, 0.720, 0.636, 0.581, 0.428, 0.292, 0.162, 0.098, 0.054
                ]

        for i=1:m

            ti = (i - 1.0) / 10.0
            fmin[i] = x -> ( y[i] - ( x[1] * exp( - ti * x[5] ) + x[2] * exp( - ( ti - x[9] ) ^ 2.0 * x[6] ) + x[3] * exp( - ( ti - x[10] ) ^ 2.0 * x[7] ) + x[4] * exp( - ( ti - x[11] ) ^ 2.0 * x[8] ) ) ) ^ 2.0

        end
        
    elseif nprob == 19

        # BDQRTIC function

        @assert ( n ≥ 5 ) && ( m == 2 * ( n - 4 ) ) "The dimensions of the problem must satisfy n ≥ 5 e m = 2 * ( n - 4 )."

        if usual_init_point

            @. x = 1.0

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = - 5.0 * ones(Float64, n)
            l[1] = 0.8
            u = 10.0 * ones(Float64, n)

        end

        fmin = Array{Function}(undef, m)

        for i=1:(n - 4)

            fmin[i] = x -> ( - 4.0 * x[i] + 3.0 ) ^ 2.0
            fmin[n - 4 + i] = x -> ( x[i] ^ 2.0 + 2.0 * x[i + 1] ^ 2.0 + 3.0 * x[i + 2] ^ 2.0 + 4.0 * x[i + 3] ^ 2.0 + 5.0 * x[n] ^ 2.0 ) ^ 2.0

        end

    elseif nprob == 20

        # Cube function

        @assert ( n ≥ 2 ) && ( m == n ) "The dimensions of the problem must satisfy n ≥ 2 e m = n."

        if usual_init_point

            @. x = 0.5

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = - 5.0 * ones(Float64, n)
            u = 10.0 * ones(Float64, n)
            u[1] = 0.8

        end

        fmin = Array{Function}(undef, m)

        fmin[1] = x -> ( x[1] - 1.0 ) ^ 2.0
        
        for i=2:m

            fmin[i] = x -> ( 10.0 * ( x[i] - x[i - 1] ^ 3.0 ) ) ^ 2.0

        end

    elseif nprob == 21

        # Mancino function

        @assert ( n ≥ 2 ) && ( m == n ) "The dimensions of the problem must satisfy n ≥ 2 e m = n."

        if usual_init_point

            for i = 1:n

                s = 0.0
            
                for j = 1:n
            
                    ti = i / j
            
                    s += sqrt( ti ) * ( ( sin( log( sqrt( ti ) ) ) ) ^ 5.0 + ( cos( log( sqrt( ti ) ) ) ) ^ 5.0  ) 
            
                end
            
                x[i] = - 8.710996 - 4.0 * ( ( i - 50.0 ) ^ 3.0 + s )
            
            end

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = 2.0e5 * ones(Float64, n)
            l[n-1] = 2.5e5
            u = 1.0e7 * ones(Float64, n)
            u[n] = 3.0e5

        end

        fmin = Array{Function}(undef, m)

        function f21(x, i)

            s = 0.0

            for j = 1:length(x)

                v = sqrt( x[i] ^ 2.0 + i / j )
                s += v * ( ( sin( log( v ) ) ) ^ 5.0 + ( cos( log( v ) ) ) ^ 5.0 )

            end

            return s

        end

        for i = 1:m

            fmin[i] = x -> ( 1400.0 * x[i] + ( i - 50.0 ) ^ 3.0 + f21(x, i) ) ^ 2.0

        end

    elseif nprob == 22

        # HEART8LS function

        @assert ( n == 8 ) && ( m == 8 ) "The dimensions of the problem must satisfy n = m = 8."

        if usual_init_point

            @. x = [ - 0.3, - 0.39, 0.3, - 0.344, - 1.2, 2.69, 1.59, - 1.5 ]

        end

        if unconstrained

            l = c_lower * ones(Float64, n)
            u = c_upper * ones(Float64, n)

        else

            l = - 30.0 * ones(Float64, n) 
            u = 30.0 * ones(Float64, n)
            u[3] = 3.5, u[n] = -1.0

        end

        fmin = Array{Function}(undef, m)
        fmin[1] = x -> ( x[1] + x[2] + 0.69 ) ^ 2.0
        fmin[2] = x -> ( x[3] + x[4] + 0.044 ) ^ 2.0
        fmin[3] = x -> ( x[5] * x[1] + x[6] * x[2] - x[7] * x[3] - x[8] * x[4] + 1.57 ) ^ 2.0
        fmin[4] = x -> ( x[7] * x[1] + x[8] * x[2] + x[5] * x[3] + x[6] * x[4] + 1.31 ) ^ 2.0
        fmin[5] = x -> ( x[1] * ( x[5] ^ 2.0 - x[7] ^ 2.0 ) - 2.0 * x[3] * x[5] * x[7] + x[2] * ( x[6] ^ 2.0 - x[8] ^ 2.0 ) - 2.0 * x[4] * x[6] * x[8] + 2.65 ) ^ 2.0
        fmin[6] = x -> ( x[3] * ( x[5] ^ 2.0 - x[7] ^ 2.0 ) + 2.0 * x[1] * x[5] * x[7] + x[4] * ( x[6] ^ 2.0 - x[8] ^ 2.0 ) + 2.0 * x[2] * x[6] * x[8] - 2.0 ) ^ 2.0
        fmin[7] = x -> ( x[1] * x[5] * ( x[5] ^ 2.0 - 3.0 * x[7] ^ 2.0 ) + x[3] * x[7] * ( x[7] ^ 2.0 - 3.0 * x[5] ^ 2.0 ) + x[2] * x[6] * ( x[6] ^ 2.0 - 3.0 * x[8] ^ 2.0 ) + x[4] * x[8] * ( x[8] ^ 2.0 - 3.0 * x[6] ^ 2.0 ) + 12.6 ) ^ 2.0
        fmin[8] = x -> ( x[3] * x[5] * ( x[5] ^ 2.0 - 3.0 * x[7] ^ 2.0 ) - x[1] * x[7] * ( x[7] ^ 2.0 - 3.0 * x[5] ^ 2.0 ) + x[4] * x[6] * ( x[6] ^ 2.0 - 3.0 * x[8] ^ 2.0 ) - x[2] * x[8] * ( x[8] ^ 2.0 - 3.0 * x[6] ^ 2.0 ) - 9.48 ) ^ 2.0

    end

    if rsp

        @. x *= 10.0

    end

    return x, l, u, fmin

end

function problem_generator_hs(
                                nprob::Int64
                                )

    @assert 1 ≤ nprob ≤ 100

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

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 1.0
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs4, hs45 ]

    elseif nprob == 18

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs4, hs110 ]

    elseif nprob == 19

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ -1.5, -3.0, -10.0, -10.0 ]
        u = [ 4.0, 3.0, 10.0, 10.0 ]
        fmin = [ hs5, hs38 ]

    elseif nprob == 20

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs5, hs45 ]

    elseif nprob == 21

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 0.1, 0.0, 0.0, -10.0 ]
        u = [ 10.0, 10.0, 5.0, 10.0 ]
        fmin = [ hs25, hs38 ]

    elseif nprob == 22

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs25, hs45 ]

    elseif nprob == 23

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs38, hs45 ]

    elseif nprob == 24

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs38, hs110 ]

    elseif nprob == 25

        n = 2
        x = [10.0, 1.0]
        l = [1.0, 0.0]
        u = c_upper * ones(Float64, n)
        fmin = [ hs1, hs3, hs4 ]

    elseif nprob == 26

        n = 2
        x = [10.0, 1.0]
        l = [- 1.5, 0.0]
        u = [4.0. 3.0]
        fmin = [ hs1, hs3, hs5 ]

    elseif nprob == 27

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 0.1, 0.0, 0.0 ]
        u = [ 100.0, 25.6, 5.0 ]
        fmin = [ hs1, hs3, hs25 ]

    elseif  nprob == 28

        n = 4
        x = [ - 3.0, - 1.0, - 3.0, - 1.0 ]
        l = [ - 10.0, 0.0, - 10.0, - 10.0 ]
        u = 10.0 * ones(Float64, 4)
        fmin = [ hs1, hs3, hs38 ]

    elseif nprob == 29

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs3, hs45 ]

    elseif nprob == 30

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs1, hs3, hs110 ]

    elseif nprob == 31

        n = 2
        x = [ 1.125, 0.125 ]
        l = [ 1.0, 0.0 ]
        u = [ 4.0, 3.0 ]
        fmin = [ hs1, hs4, hs5 ]

    elseif nprob == 32

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 1.0, 0.0, 0.0 ]
        u = [ 100.0, 25.6, 5.0 ]
        fmin = [ hs1, hs4, hs25 ]

    elseif nprob == 33

        n = 4
        x = [ 3.0, 1.0, - 3.0, - 1.0 ]
        l = [ 1.0 , 0.0, - 10.0, - 10.0 ]
        u = 10.0 * ones(Float64, n)
        fmin = [ hs1, hs4, hs38 ]

    elseif nprob == 34

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 1.0
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs4, hs45 ]

    elseif nprob == 35

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs1, hs4, hs110 ]

    elseif nprob == 36

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ -1.5, 0.0, -10.0, -10.0 ]
        u = [ 4.0, 3.0, 10.0, 10.0 ]
        fmin = [ hs1, hs5, hs38 ]

    elseif nprob == 37

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs5, hs45 ]

    elseif nprob == 38

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 0.1, 0.0, 0.0, -10.0 ]
        u = [ 10.0, 10.0, 5.0, 10.0 ]
        fmin = [ hs1, hs25, hs38 ]

    elseif nprob == 39

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs25, hs45 ]
    
    elseif nprob == 40

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs38, hs45 ]

    elseif nprob == 41

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs1, hs38, hs110 ]

    elseif nprob == 42

        n = 2
        x = [ 1.125, 0.125 ]
        l = [ 1.0, 0.0 ]
        u = [ 4.0, 3.0 ]
        fmin = [ hs3, hs4, hs5 ]

    elseif nprob == 43

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 1.0, 0.0, 0.0 ]
        u = [ 100.0, 25.6, 5.0 ]
        fmin = [ hs3, hs4, hs25 ]

    elseif nprob == 44

        n = 4
        x = [ 3.0, 1.0, - 3.0, - 1.0 ]
        l = [ 1.0 , 0.0, - 10.0, - 10.0 ]
        u = 10.0 * ones(Float64, n)
        fmin = [ hs3, hs4, hs38 ]

    elseif nprob == 45

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 1.0
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs4, hs45 ]

    elseif nprob == 46

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs3, hs4, hs110 ]

    elseif nprob == 47

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ -1.5, 0.0, -10.0, -10.0 ]
        u = [ 4.0, 3.0, 10.0, 10.0 ]
        fmin = [ hs3, hs5, hs38 ]

    elseif nprob == 48

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs5, hs45 ]

    elseif nprob == 49

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 0.1, 0.0, 0.0, -10.0 ]
        u = [ 10.0, 10.0, 5.0, 10.0 ]
        fmin = [ hs3, hs25, hs38 ]

    elseif nprob == 50

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs25, hs45 ]

    elseif nprob == 51

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs38, hs45 ]

    elseif nprob == 52

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs3, hs38, hs110 ]

    elseif nprob == 53

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 1.0, 0.0, 0.0 ]
        u = [ 4.0, 3.0, 5.0 ]
        fmin = [ hs4, hs5, hs25 ]

    elseif nprob == 54

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 1.0, 0.0, -10.0, -10.0 ]
        u = [ 4.0, 3.0, 10.0, 10.0 ]
        fmin = [ hs4, hs5, hs38 ]

    elseif nprob == 55

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs4, hs5, hs45 ]

    elseif nprob == 56

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 1.0, 0.0, 0.0, -10.0 ]
        u = [ 10.0, 10.0, 5.0, 10.0 ]
        fmin = [ hs4, hs25, hs38 ]

    elseif nprob == 57

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs4, hs25, hs45 ]

    elseif nprob == 58

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 1.0
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs4, hs38, hs45 ]

    elseif nprob == 59

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs4, hs38, hs110 ]

    elseif nprob == 60

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 0.1, 0.0, 0.0, -10.0 ]
        u = [ 4.0, 3.0, 5.0, 10.0 ]
        fmin = [ hs5, hs25, hs38 ]

    elseif nprob == 61

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs5, hs25, hs45 ]

    elseif nprob == 62

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs5, hs38, hs45 ]

    elseif nprob == 63

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs25, hs38, hs45 ]

    elseif nprob == 64

        n = 2
        x = [ 1.125, 0.125 ]
        l = [ 1.0, 0.0 ]
        u = [ 4.0, 3.0 ]
        fmin = [ hs1, hs3, hs4, hs5 ]

    elseif nprob == 65

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 1.0, 0.0, 0.0 ]
        u = [ 100.0, 25.6, 5.0 ]
        fmin = [ hs1, hs3, hs4, hs25 ]

    elseif nprob == 66

        n = 4
        x = [ 3.0, 1.0, - 3.0, - 1.0 ]
        l = [ 1.0 , 0.0, - 10.0, - 10.0 ]
        u = 10.0 * ones(Float64, n)
        fmin = [ hs1, hs3, hs4, hs38 ]

    elseif nprob == 67

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 1.0
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs3, hs4, hs45 ]

    elseif nprob == 68

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs1, hs3, hs4, hs110 ]

    elseif nprob == 69

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 0.1, 0.0, 0.0 ]
        u = [ 4.0, 3.0, 5.0 ]
        fmin = [ hs1, hs3, hs5, hs25 ]

    elseif nprob == 70

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ -1.5, 0.0, -10.0, -10.0 ]
        u = [ 4.0, 3.0, 10.0, 10.0 ]
        fmin = [ hs1, hs3, hs5, hs38 ]

    elseif nprob == 71

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs3, hs5, hs45 ]

    elseif nprob == 72

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 0.1, 0.0, 0.0, -10.0 ]
        u = [ 10.0, 10.0, 5.0, 10.0 ]
        fmin = [ hs1, hs3, hs25, hs38 ]

    elseif nprob == 73

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs3, hs25, hs45 ]

    elseif nprob == 74

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs3, hs38, hs45 ]

    elseif nprob == 75

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs1, hs3, hs38, hs110 ]

    elseif nprob == 76

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 1.0, 0.0, 0.0 ]
        u = [ 4.0, 3.0, 5.0 ]
        fmin = [ hs1, hs4, hs5, hs25 ]

    elseif nprob == 77

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 1.0, 0.0, -10.0, -10.0 ]
        u = [ 4.0, 3.0, 10.0, 10.0 ]
        fmin = [ hs1, hs4, hs5, hs38 ]

    elseif nprob == 78

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 1.0
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs4, hs5, hs45 ]

    elseif nprob == 79

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 1.0, 0.0, 0.0, -10.0 ]
        u = [ 10.0, 10.0, 5.0, 10.0 ]
        fmin = [ hs1, hs4, hs25, hs38 ]

    elseif nprob == 80

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 1.0
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs4, hs25, hs45 ]

    elseif nprob == 81

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 1.0
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs4, hs38, hs45 ]

    elseif nprob == 82

        n = 10
        x = 9.0 * ones(Float64, n)
        l = 2.001 * ones(Float64, n)
        u = 9.999 * ones(Float64, n)
        fmin = [ hs1, hs4, hs38, hs110 ]

    elseif nprob == 83

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 0.1, 0.0, 0.0, -10.0 ]
        u = [ 4.0, 3.0, 5.0, 10.0 ]
        fmin = [ hs1, hs5, hs25, hs38 ]

    elseif nprob == 84

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs5, hs25, hs45 ]

    elseif nprob == 85

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs5, hs38, hs45 ]

    elseif nprob == 86

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs1, hs25, hs38, hs45 ]

    elseif nprob == 87

        n = 3
        x = [ 100.0, 12.5, 3.0]
        l = [ 1.0, 0.0, 0.0 ]
        u = [ 4.0, 3.0, 5.0 ]
        fmin = [ hs3, hs4, hs5, hs25 ]

    elseif nprob == 88

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 1.0, 0.0, -10.0, -10.0 ]
        u = [ 4.0, 3.0, 10.0, 10.0 ]
        fmin = [ hs3, hs4, hs5, hs38 ]

    elseif nprob == 89

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 1.0
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs4, hs5, hs45 ]
    
    elseif nprob == 90

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 1.0, 0.0, 0.0, -10.0 ]
        u = [ 10.0, 10.0, 5.0, 10.0 ]
        fmin = [ hs3, hs4, hs25, hs38 ]

    elseif nprob == 91

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 1.0
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs4, hs25, hs45 ]

    elseif nprob == 92

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 0.1, 0.0, 0.0, -10.0 ]
        u = [ 4.0, 3.0, 5.0, 10.0 ]
        fmin = [ hs3, hs5, hs25, hs38 ]

    elseif nprob == 93

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs5, hs25, hs45 ]

    elseif nprob == 94

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs5, hs38, hs45 ]

    elseif nprob == 95

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs3, hs25, hs38, hs45 ]

    elseif nprob == 96

        n = 4
        x = [ -3.0, -1.0, -3.0, -1.0 ]
        l = [ 1.0, 0.0, 0.0, -10.0 ]
        u = [ 4.0, 3.0, 5.0, 10.0 ]
        fmin = [ hs4, hs5, hs25, hs38 ]

    elseif nprob == 97

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 1.0
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs4, hs5, hs25, hs45 ]

    elseif nprob == 98

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 1.0
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs4, hs5, hs38, hs45 ]

    elseif nprob == 99

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 1.0
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs4, hs25, hs38, hs45 ]

    elseif nprob == 100

        n = 5
        x = 2.0 * ones(Float64, n)
        l = zeros(Float64, n)
        l[1] = 0.1
        u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
        fmin = [ hs5, hs25, hs38, hs45 ]

    end

    return x, l, u, fmin

end