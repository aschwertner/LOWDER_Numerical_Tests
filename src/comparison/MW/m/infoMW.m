function [x, l, u] = infoMW(k, n, s)

    % Initializes some useful variables constants
    c_lower = - 1.0e20;
    c_upper = 1.0e20;

    % Lower and upper bounds
    l = c_lower * ones(1, n);
    u = c_upper * ones(1, n);

    switch k

        case 1

            x = ones(1, n);

        case 2

            x = ones(1, n);

        case 3

            x = ones(1, n);

        case 4

            x = [-1.2, 1];

        case 5

            x = [-1, 0, 0];

        case 6

            x = [3, -1, 0, 1];

        case 7

            x = [0.5, -2];

        case 8

            x = ones(1, n);

        case 9

            x = [0.25, 0.39, 0.415, 0.39];

        case 10

            x = [0.02, 4000, 250];

        case 11

            x = zeros(1, n);

        case 12

            x = [0, 10, 20];

        case 13

            x = [0.3, 0.4];

        case 14

            x = [25, 5, - 5, - 1];

        case 15

            tmp = n + 1;
            x = zeros(1, n);

            for i=1:n
                x(i) = i / tmp;
            end

        case 16

            x = 0.5 * ones(1, n);

        case 17

            x = [0.5, 1.5, -1, 0.01, 0.02];

        case 18

            x = [1.3, 0.65, 0.65, 0.7, 0.6, 3, 5, 7, 2, 4.5, 5.5];

        case 19

            x = ones(1, n);

        case 20

            x = 0.5 * ones(1, n);

        case 21

            x = zeros(1, n);

            for i=1:n
                s = 0;
                for j=1:n
                    tmp = i / j;
                    tmp1 = sqrt(tmp);
                    tmp2 = log(tmp1);
                    s = s + tmp1 * (sin(tmp2) ^ 5 + cos(tmp2) ^ 5); 
                end
                x(i) = - 8.710996 - 4 * ((i - 50) ^ 3 + s);
            end

        case 22

            x = [- 0.3, - 0.39, 0.3, - 0.344, - 1.2, 2.69, 1.59, - 1.5];

        otherwise

            error('Invalid option.');

    end

    if s == 1
        x = 10 * x;
    end

end