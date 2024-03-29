function [n, x, l, u] = infoHS(np)

    % Initializes some useful variables constants
    c_lower = - 1.0e20;
    c_upper = 1.0e20;

    switch np

        case 1
    
            n = 2;
            x = [ -2.0, 1.0 ];
            l = [ c_lower, 0.0 ];
            u = c_upper * ones(1, n);
    
        case 2
    
            n = 2;
            x = [ 1.125, 0.125 ];
            l = [ 1.0, 0.0 ];
            u = c_upper * ones(1, n);
    
        case 3
    
            n = 2;
            x = zeros(1, n);
            l = [ - 1.5, - 1.5 ];
            u = [ 4.0, 3.0 ];
    
        case 4
    
            n = 3;
            x = [ 100.0, 12.5, 3.0];
            l = [ 0.1, 0.0, 0.0 ];
            u = [ 100.0, 25.6, 5.0 ];
    
        case 5
    
            n = 4;
            x = [ - 3.0, - 1.0, - 3.0, - 1.0 ];
            l = [ - 10.0, - 1.5, - 10.0, - 10.0 ];
            u = 10.0 * ones(1, n);
    
        case 6
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 7
    
            n = 10;
            x = 9.0 * ones(1, n);
            l = 2.001 * ones(1, n);
            u = 9.999 * ones(1, n);
    
        case 8
    
            n = 2;
            x = [ 1.125, 0.125 ];
            l = [ 1.0, 0.0 ];
            u = c_upper * ones(1, n);
    
        case 9
    
            n = 2;
            x = zeros(1, n);
            l = [ - 1.5, 0.0 ];
            u = [ 4.0, 3.0 ];
    
        case 10
    
            n = 3;
            x = [ 100.0, 12.5, 3.0];
            l = [ 0.1, 0.0, 0.0 ];
            u = [ 100.0, 25.6, 5.0 ];
    
        case 11
    
            n = 4;
            x = [ - 3.0, - 1.0, - 3.0, - 1.0 ];
            l = [ - 10.0, 0.0, - 10.0, - 10.0 ];
            u = 10.0 * ones(1, 4);
    
        case 12
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 13
    
            n = 10;
            x = 9.0 * ones(1, n);
            l = 2.001 * ones(1, n);
            u = 9.999 * ones(1, n);
    
        case 14
    
            n = 2;
            x = [ 1.125, 0.125 ];
            l = [ 1.0, 0.0 ];
            u = [ 4.0, 3.0 ];
    
        case 15
    
            n = 3;
            x = [ 100.0, 12.5, 3.0];
            l = [ 1.0, 0.0, 0.0 ];
            u = [ 100.0, 25.6, 5.0 ];
    
        case 16
    
            n = 4;
            x = [ 3.0, 1.0, - 3.0, - 1.0 ];
            l = [ 1.0 , 0.0, - 10.0, - 10.0 ];
            u = 10.0 * ones(1, n);
    
        case 17
    
            n = 10;
            x = 9.0 * ones(1, n);
            l = 2.001 * ones(1, n);
            u = 9.999 * ones(1, n);
    
        case 18
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ -1.5, -3.0, -10.0, -10.0 ];
            u = [ 4.0, 3.0, 10.0, 10.0 ];
    
        case 19
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 20
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ 0.1, 0.0, 0.0, -10.0 ];
            u = [ 10.0, 10.0, 5.0, 10.0 ];
        
        case 21
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            l(1) = 0.1;
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 22
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 23
    
            n = 10;
            x = 9.0 * ones(1, n);
            l = 2.001 * ones(1, n);
            u = 9.999 * ones(1, n);
    
        case 24
    
            n = 2;
            x = [10.0, 1.0];
            l = [1.0, 0.0];
            u = c_upper * ones(1, n);
    
        case 25
    
            n = 2;
            x = [10.0, 1.0];
            l = [- 1.5, 0.0];
            u = [4.0, 3.0];
    
        case 26
    
            n = 3;
            x = [ 100.0, 12.5, 3.0];
            l = [ 0.1, 0.0, 0.0 ];
            u = [ 100.0, 25.6, 5.0 ];
    
        case 27
    
            n = 4;
            x = [ - 3.0, - 1.0, - 3.0, - 1.0 ];
            l = [ - 10.0, 0.0, - 10.0, - 10.0 ];
            u = 10.0 * ones(1, 4);
    
        case 28
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 29
    
            n = 10;
            x = 9.0 * ones(1, n);
            l = 2.001 * ones(1, n);
            u = 9.999 * ones(1, n);
    
        case 30
    
            n = 2;
            x = [ 1.125, 0.125 ];
            l = [ 1.0, 0.0 ];
            u = [ 4.0, 3.0 ];
    
        case 31
    
            n = 3;
            x = [ 100.0, 12.5, 3.0];
            l = [ 1.0, 0.0, 0.0 ];
            u = [ 100.0, 25.6, 5.0 ];
    
        case 32
    
            n = 4;
            x = [ 3.0, 1.0, - 3.0, - 1.0 ];
            l = [ 1.0 , 0.0, - 10.0, - 10.0 ];
            u = 10.0 * ones(1, n);
    
        case 33
    
            n = 10;
            x = 9.0 * ones(1, n);
            l = 2.001 * ones(1, n);
            u = 9.999 * ones(1, n);
    
        case 34
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ -1.5, 0.0, -10.0, -10.0 ];
            u = [ 4.0, 3.0, 10.0, 10.0 ];
    
        case 35
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 36
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ 0.1, 0.0, 0.0, -10.0 ];
            u = [ 10.0, 10.0, 5.0, 10.0 ];
    
        case 37
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            l(1) = 0.1;
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 38
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 39
    
            n = 10;
            x = 9.0 * ones(1, n);
            l = 2.001 * ones(1, n);
            u = 9.999 * ones(1, n);
    
        case 40
    
            n = 2;
            x = [ 1.125, 0.125 ];
            l = [ 1.0, 0.0 ];
            u = [ 4.0, 3.0 ];
    
        case 41
    
            n = 3;
            x = [ 100.0, 12.5, 3.0];
            l = [ 1.0, 0.0, 0.0 ];
            u = [ 100.0, 25.6, 5.0 ];
    
        case 42
    
            n = 4;
            x = [ 3.0, 1.0, - 3.0, - 1.0 ];
            l = [ 1.0 , 0.0, - 10.0, - 10.0 ];
            u = 10.0 * ones(1, n);
    
        case 43
    
            n = 10;
            x = 9.0 * ones(1, n);
            l = 2.001 * ones(1, n);
            u = 9.999 * ones(1, n);
    
        case 44
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ -1.5, 0.0, -10.0, -10.0 ];
            u = [ 4.0, 3.0, 10.0, 10.0 ];
    
        case 45
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 46
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ 0.1, 0.0, 0.0, -10.0 ];
            u = [ 10.0, 10.0, 5.0, 10.0 ];
    
        case 47
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            l(1) = 0.1;
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 48
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 49
    
            n = 10;
            x = 9.0 * ones(1, n);
            l = 2.001 * ones(1, n);
            u = 9.999 * ones(1, n);
    
        case 50
    
            n = 3;
            x = [ 100.0, 12.5, 3.0];
            l = [ 1.0, 0.0, 0.0 ];
            u = [ 4.0, 3.0, 5.0 ];
    
        case 51
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ 1.0, 0.0, -10.0, -10.0 ];
            u = [ 4.0, 3.0, 10.0, 10.0 ];
    
        case 52
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 53
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ 1.0, 0.0, 0.0, -10.0 ];
            u = [ 10.0, 10.0, 5.0, 10.0 ];
    
        case 54
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            l(1) = 0.1;
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 55
    
            n = 10;
            x = 9.0 * ones(1, n);
            l = 2.001 * ones(1, n);
            u = 9.999 * ones(1, n);
    
        case 56
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ 0.1, 0.0, 0.0, -10.0 ];
            u = [ 4.0, 3.0, 5.0, 10.0 ];
    
        case 57
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            l(1) = 0.1;
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 58
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 59
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            l(1) = 0.1;
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 60
    
            n = 2;
            x = [ 1.125, 0.125 ];
            l = [ 1.0, 0.0 ];
            u = [ 4.0, 3.0 ];
    
        case 61
    
            n = 3;
            x = [ 100.0, 12.5, 3.0];
            l = [ 1.0, 0.0, 0.0 ];
            u = [ 100.0, 25.6, 5.0 ];
    
        case 62
    
            n = 4;
            x = [ 3.0, 1.0, - 3.0, - 1.0 ];
            l = [ 1.0 , 0.0, - 10.0, - 10.0 ];
            u = 10.0 * ones(1, n);
    
        case 63
    
            n = 10;
            x = 9.0 * ones(1, n);
            l = 2.001 * ones(1, n);
            u = 9.999 * ones(1, n);
    
        case 64
    
            n = 3;
            x = [ 100.0, 12.5, 3.0];
            l = [ 0.1, 0.0, 0.0 ];
            u = [ 4.0, 3.0, 5.0 ];
    
        case 65
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ -1.5, 0.0, -10.0, -10.0 ];
            u = [ 4.0, 3.0, 10.0, 10.0 ];
    
        case 66
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 67
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ 0.1, 0.0, 0.0, -10.0 ];
            u = [ 10.0, 10.0, 5.0, 10.0 ];
    
        case 68
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            l(1) = 0.1;
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 69
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 70
    
            n = 10;
            x = 9.0 * ones(1, n);
            l = 2.001 * ones(1, n);
            u = 9.999 * ones(1, n);
    
        case 71
    
            n = 3;
            x = [ 100.0, 12.5, 3.0];
            l = [ 1.0, 0.0, 0.0 ];
            u = [ 4.0, 3.0, 5.0 ];
    
        case 72
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ 1.0, 0.0, -10.0, -10.0 ];
            u = [ 4.0, 3.0, 10.0, 10.0 ];
    
        case 73
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ 1.0, 0.0, 0.0, -10.0 ];
            u = [ 10.0, 10.0, 5.0, 10.0 ];
    
        case 74
    
            n = 10;
            x = 9.0 * ones(1, n);
            l = 2.001 * ones(1, n);
            u = 9.999 * ones(1, n);
    
        case 75
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ 0.1, 0.0, 0.0, -10.0 ];
            u = [ 4.0, 3.0, 5.0, 10.0 ];
    
        case 76
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            l(1) = 0.1;
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 77
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 78
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            l(1) = 0.1;
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 79
    
            n = 3;
            x = [ 100.0, 12.5, 3.0];
            l = [ 1.0, 0.0, 0.0 ];
            u = [ 4.0, 3.0, 5.0 ];
    
        case 80
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ 1.0, 0.0, -10.0, -10.0 ];
            u = [ 4.0, 3.0, 10.0, 10.0 ];
    
        case 81
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ 1.0, 0.0, 0.0, -10.0 ];
            u = [ 10.0, 10.0, 5.0, 10.0 ];
    
        case 82
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ 0.1, 0.0, 0.0, -10.0 ];
            u = [ 4.0, 3.0, 5.0, 10.0 ];
    
        case 83
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            l(1) = 0.1;
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 84
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 85
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            l(1) = 0.1;
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];
    
        case 86
    
            n = 4;
            x = [ -3.0, -1.0, -3.0, -1.0 ];
            l = [ 1.0, 0.0, 0.0, -10.0 ];
            u = [ 4.0, 3.0, 5.0, 10.0 ];
    
        case 87
    
            n = 5;
            x = 2.0 * ones(1, n);
            l = zeros(1, n);
            l(1) = 0.1;
            u = [ 1.0, 2.0, 3.0, 4.0, 5.0 ];

        otherwise

            error('Invalid option.')

    end

end