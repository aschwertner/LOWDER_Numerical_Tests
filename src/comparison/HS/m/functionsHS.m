function fvec = functionsHS(np, x)

    switch np
    
        case 1
    
            fvec = [ hs1(x), hs3(x) ];
    
        case 2
    
            fvec = [ hs1(x), hs4(x) ];
    
        case 3
    
            fvec = [ hs1(x), hs5(x) ];
    
        case 4
    
            fvec = [ hs1(x), hs25(x) ];

        case 5
    
            fvec = [ hs1(x), hs38(x) ];
    
        case 6
    
            fvec = [ hs1(x), hs45(x) ];
    
        case 7
    
            fvec = [ hs1(x), hs110(x) ];
    
        case 8
    
            fvec = [ hs3(x), hs4(x) ];
    
        case 9
    
            fvec = [ hs3(x), hs5(x) ];
    
        case 10
    
            fvec = [ hs3(x), hs25(x) ];
    
        case 11
    
            fvec = [ hs3(x), hs38(x) ];
    
        case 12
    
            fvec = [ hs3(x), hs45(x) ];
    
        case 13
    
            fvec = [ hs3(x), hs110(x) ];
    
        case 14
    
            fvec = [ hs4(x), hs5(x) ];
    
        case 15
    
            fvec = [ hs4(x), hs25(x) ];
    
        case 16
    
            fvec = [ hs4(x), hs38(x) ];
    
        case 17
    
            fvec = [ hs4(x), hs110(x) ];
    
        case 18
    
            fvec = [ hs5(x), hs38(x) ];
    
        case 19
    
            fvec = [ hs5(x), hs45(x) ];
    
        case 20
    
            fvec = [ hs25(x), hs38(x) ];
    
        case 21
    
            fvec = [ hs25(x), hs45(x) ];
    
        case 22
    
            fvec = [ hs38(x), hs45(x) ];
    
        case 23
    
            fvec = [ hs38(x), hs110(x) ];
    
        case 24
    
            fvec = [ hs1(x), hs3(x), hs4(x) ];
    
        case 25
    
            fvec = [ hs1(x), hs3(x), hs5(x) ];
    
        case 26
    
            fvec = [ hs1(x), hs3(x), hs25(x) ];
    
        case 27
    
            fvec = [ hs1(x), hs3(x), hs38(x) ];
    
        case 28
    
            fvec = [ hs1(x), hs3(x), hs45(x) ];
    
        case 29
    
            fvec = [ hs1(x), hs3(x), hs110(x) ];
    
        case 30
    
            fvec = [ hs1(x), hs4(x), hs5(x) ];
    
        case 31
    
            fvec = [ hs1(x), hs4(x), hs25(x) ];
    
        case 32
    
            fvec = [ hs1(x), hs4(x), hs38(x) ];
    
        case 33
    
            fvec = [ hs1(x), hs4(x), hs110(x) ];
    
        case 34
    
            fvec = [ hs1(x), hs5(x), hs38(x) ];
    
        case 35
    
            fvec = [ hs1(x), hs5(x), hs45(x) ];
    
        case 36
    
            fvec = [ hs1(x), hs25(x), hs38(x) ];
    
        case 37
    
            fvec = [ hs1(x), hs25(x), hs45(x) ];
    
        case 38
    
            fvec = [ hs1(x), hs38(x), hs45(x) ];
    
        case 39
    
            fvec = [ hs1(x), hs38(x), hs110(x) ];
    
        case 40
    
            fvec = [ hs3(x), hs4(x), hs5(x) ];
    
        case 41
    
            fvec = [ hs3(x), hs4(x), hs25(x) ];
    
        case 42
    
            fvec = [ hs3(x), hs4(x), hs38(x) ];
    
        case 43
    
            fvec = [ hs3(x), hs4(x), hs110(x) ];
    
        case 44
    
            fvec = [ hs3(x), hs5(x), hs38(x) ];
    
        case 45
    
            fvec = [ hs3(x), hs5(x), hs45(x) ];
    
        case 46
    
            fvec = [ hs3(x), hs25(x), hs38(x) ];
    
        case 47
    
            fvec = [ hs3(x), hs25(x), hs45(x) ];
    
        case 48
    
            fvec = [ hs3(x), hs38(x), hs45(x) ];
    
        case 49
    
            fvec = [ hs3(x), hs38(x), hs110(x) ];
    
        case 50
        
            fvec = [ hs4(x), hs5(x), hs25(x) ];
    
        case 51
    
            fvec = [ hs4(x), hs5(x), hs38(x) ];
    
        case 52
    
            fvec = [ hs4(x), hs5(x), hs45(x) ];
    
        case 53
    
            fvec = [ hs4(x), hs25(x), hs38(x) ];
    
        case 54
    
            fvec = [ hs4(x), hs25(x), hs45(x) ];
    
        case 55
    
            fvec = [ hs4(x), hs38(x), hs110(x) ];
    
        case 56
    
            fvec = [ hs5(x), hs25(x), hs38(x) ];
    
        case 57
    
            fvec = [ hs5(x), hs25(x), hs45(x) ];
    
        case 58
    
            fvec = [ hs5(x), hs38(x), hs45(x) ];
    
        case 59
    
            fvec = [ hs25(x), hs38(x), hs45(x) ];
    
        case 60
    
            fvec = [ hs1(x), hs3(x), hs4(x), hs5(x) ];
    
        case 61
    
            fvec = [ hs1(x), hs3(x), hs4(x), hs25(x) ];
    
        case 62
    
            fvec = [ hs1(x), hs3(x), hs4(x), hs38(x) ];
    
        case 63
    
            fvec = [ hs1(x), hs3(x), hs4(x), hs110(x) ];
    
        case 64
    
            fvec = [ hs1(x), hs3(x), hs5(x), hs25(x) ];
    
        case 65
    
            fvec = [ hs1(x), hs3(x), hs5(x), hs38(x) ];
    
        case 66
    
            fvec = [ hs1(x), hs3(x), hs5(x), hs45(x) ];
    
        case 67
    
            fvec = [ hs1(x), hs3(x), hs25(x), hs38(x) ];
    
        case 68
    
            fvec = [ hs1(x), hs3(x), hs25(x), hs45(x) ];
    
        case 69
    
            fvec = [ hs1(x), hs3(x), hs38(x), hs45(x) ];
    
        case 70
    
            fvec = [ hs1(x), hs3(x), hs38(x), hs110(x) ];
    
        case 71
    
            fvec = [ hs1(x), hs4(x), hs5(x), hs25(x) ];
    
        case 72
    
            fvec = [ hs1(x), hs4(x), hs5(x), hs38(x) ];
    
        case 73
    
            fvec = [ hs1(x), hs4(x), hs25(x), hs38(x) ];
    
        case 74
    
            fvec = [ hs1(x), hs4(x), hs38(x), hs110(x) ];
    
        case 75
    
            fvec = [ hs1(x), hs5(x), hs25(x), hs38(x) ];
    
        case 76
    
            fvec = [ hs1(x), hs5(x), hs25(x), hs45(x) ];
    
        case 77
    
            fvec = [ hs1(x), hs5(x), hs38(x), hs45(x) ];
    
        case 78
    
            fvec = [ hs1(x), hs25(x), hs38(x), hs45(x) ];
    
        case 79
    
            fvec = [ hs3(x), hs4(x), hs5(x), hs25(x) ];
    
        case 80
    
            fvec = [ hs3(x), hs4(x), hs5(x), hs38(x) ];
    
        case 81
    
            fvec = [ hs3(x), hs4(x), hs25(x), hs38(x) ];
    
        case 82
    
            fvec = [ hs3(x), hs5(x), hs25(x), hs38(x) ];
    
        case 83
    
            fvec = [ hs3(x), hs5(x), hs25(x), hs45(x) ];
    
        case 84
    
            fvec = [ hs3(x), hs5(x), hs38(x), hs45(x) ];
    
        case 85
    
            fvec = [ hs3(x), hs25(x), hs38(x), hs45(x) ];
    
        case 86
    
            fvec = [ hs4(x), hs5(x), hs25(x), hs38(x) ];
    
        case 87
        
            fvec = [ hs5(x), hs25(x), hs38(x), hs45(x) ];

        otherwise

            error('Invalid option.')

    end

end

% Objective function

function value = hs1(x)

    value = 100.0 * (x(2) - x(1) ^ 2.0) ^ 2.0 + (1.0 - x(1)) ^ 2.0;

end

function value = hs3(x)

    value = x(2) + 1.0e-5 * ( x(2) - x(1) ) ^ 2.0;

end

function value = hs4(x)

    value = (x(1) + 1.0) ^ 3.0 / 3.0 + x(2);

end

function value = hs5(x)

    value = sin( x(1) + x(2) ) + ( x(1) - x(2) ) ^ 2.0 - 1.5 * x(1) + 2.5 * x(2) + 1.0;

end

function value = hs25(x)

    value = 0.0;

    for i=1:99

        ui = 25.0 + (-50.0 * log(0.01 * i)) ^ (2.0/3.0);

        value = value + (-0.01 * i + exp(-(1.0/x(1)) * (ui - x(2))^( x(3))))^2.0;

    end

end

function value = hs38(x)

    value = 100.0 * (x(2) - x(1)^2.0)^2.0 + (1.0 - x(1))^2.0 + 90.0 * (x(4) - x(3)^2.0)^2.0 + (1.0 - x(3))^2.0 + 10.1 * ((x(2) - 1.0)^2.0 + (x(4) - 1.0)^2.0) + 19.8 * (x(2) - 1.0) * (x(4) - 1.0);

end

function value = hs45(x)

    value = 2.0 - x(1) * x(2) * x(3) * x(4) * x(5) / 120.0;

end

function value = hs110(x)

    s1 = 0.0;
    s2 = 1.0;

    for i = 1:10

        s1 = s1 + ( log( x(i) - 2.0 ) ) ^ 2.0 + ( log( 10.0 - x(i) ) ) ^ 2.0;
        s2 = s2 * x(i);

    end     

    value = s1 - s2 ^ ( 0.2 );

end