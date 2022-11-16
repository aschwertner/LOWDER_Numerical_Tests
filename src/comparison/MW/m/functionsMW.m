function fvec = functionsMW(k, n, m, x)

    fvec = zeros(1, m);

    switch k

        case 1 % Linear function - full rank
            
            tmp = - (2 / m) * sum(x) - 1;

            for i=1:n
                fvec(i) = x(i) + tmp;
            end

            for i=(n+1):m
                fvec(i) = tmp;
            end

        case 2 % Linear function - rank 1

            tmp = 0;

            for j = 1:n
                tmp = tmp + j * x(j);
            end

            for i = 1:m
                fvec(i) = i * tmp - 1;
            end

        case 3 % Linear function - Rank 1 with zero columns and rows

            tmp = 0;

            for j = 2:n - 1
                tmp = tmp + j * x(j);
            end

            for i = 2:(m - 1)
                fvec(i) = (i - 1) * tmp - 1;
            end

            fvec(1) = -1;
            fvec(m) = -1;

        case 4 % Rosenbrock function

            fvec(1) = 10 * (x(2) - x(1)^2);
            fvec(2) = 1 - x(1);

        case 5 % Helical Valley function

            if x(1) > 0
                tmp = atan(x(2) / x(1)) / (2 * pi);
            elseif x(1) < 0
                tmp = atan(x(2) / x(1)) / (2 * pi) + 0.5;
            else
                tmp = 0.25;
            end

            fvec(1) = 10 * (x(3) - 10 * tmp);
            fvec(2) = 10 * (sqrt(x(1)^2 + x(2)^2) - 1);
            fvec(3) = x(3);

        case 6 % Powell Singular function

            fvec(1) = x(1) + 10 * x(2);
            fvec(2) = sqrt(5) * (x(3) - x(4));
            fvec(3) = (x(2) - 2 * x(3))^2;
            fvec(4) = sqrt(10) * (x(1) - x(4))^2;

        case 7 % Freudenstein and Roth function

            fvec(1) = - 13 + x(1) + ((5 - x(2)) * x(2) - 2) * x(2);
            fvec(2) = - 29 + x(1) + ((1 + x(2)) * x(2) - 14) * x(2);

        case 8 % Bard function

            y = [0.14, 0.18, 0.22, 0.25, 0.29, 0.32, 0.35, 0.39, 0.37, 0.58, 0.73, 0.96, 1.34, 2.10, 4.39];

            for i = 1:m
                tmp1 = 16 - i;
                tmp2 = min(i, tmp1);
                fvec(i) = y(i) - (x(1) + ( i / (x(2) * tmp1 + x(3) * tmp2)));
            end

        case 9 % Kowalik and Osborne function

            y1 = [0.1957, 0.1947, 0.1735, 0.16, 0.0844, 0.0627, 0.0456, 0.0342, 0.0323, 0.0235, 0.0246];
            y2 = [4, 2, 1, 0.5, 0.25, 0.167, 0.125, 0.1, 0.0833, 0.0714, 0.0625];

            for i = 1:m
                tmp1 = y2(i) * (y2(i) + x(2));
                tmp2 = y2(i) * (y2(i) + x(3)) + x(4);
                fvec(i) = y1(i) - x(1) * tmp1 / tmp2;
            end

        case 10 % Meyer function

            y3 = [34780, 28610, 23650, 19630, 16370, 13720, 11540, 9744, 8261, 7030, 6005, 5147, 4427, 3820, 3307, 2872];

            for i = 1:m
                tmp = exp(x(2) / (5 * i + 45 + x(3)));
                fvec(i) = x(1) * tmp - y3(i);
            end

        case 11 % Watson function

            for i=1:29

                ti = i / 29;
                tmp1 = 0;
                tmp2 = 0;

                for j=2:n
                    tmp1 = tmp1 + (j - 1) * x(j) * ti^(j - 2);
                end

                for j=1:n
                    tmp2 = tmp2 + x(j) * ti^(j - 1);
                end

                fvec(i) = tmp1 - tmp2^2 - 1;

            end

            fvec(30) = x(1);
            fvec(31) = x(2) - x(1)^2 - 1;

        case 12 % Box three-dimensional function

            for i=1:m
                ti = i / 10;
                fvec(i) = exp(-ti * x(1)) - exp(-ti * x(2)) - x(3) * (exp(-ti) - exp(-i));
            end

        case 13 % Jennrich and Sampson function

            for i=1:m
                fvec(i) = 2 + 2 * i - (exp(i * x(1)) + exp(i * x(2)));
            end

        case 14 % Brown and Dennis function

            for i=1:m
                ti = i/5;
                fvec(i) = (x(1) + ti * x(2) - exp(ti))^2 + (x(3) + x(4) * sin(ti) - cos(ti))^2;
            end

        case 15 % Chebyquad function

            for i=1:m
                fvec(i) = cheb2(x, i);
            end

        case 16 % Brown almost-linear function

            tmp = sum(x);

            for i=1:(m-1)
                fvec(i) = x(i) + tmp - (n + 1);
            end

            fvec(m) = prod(x) - 1;

        case 17 % Osborne 1 function

            y4 = [0.844, 0.908, 0.932, 0.936, 0.925, 0.908, 0.881, ...
                0.850, 0.818, 0.784, 0.751, 0.718, 0.685, 0.658, 0.628, ...
                0.603, 0.580, 0.558, 0.538, 0.522, 0.506, 0.490, 0.478, ...
                0.467, 0.457, 0.448, 0.438, 0.431, 0.424, 0.420, 0.414, ...
                0.411, 0.406];

            for i=1:m
                tmp = 10 * (i - 1);
                fvec(i) = y4(i) - ( x(1) + x(2) * exp(- tmp * x(4)) + x(3) * exp(- tmp * x(5)));
            end

        case 18 % Osborne 2 function

            y5 = [1.366, 1.191, 1.112, 1.013, 0.991, 0.885, 0.831, ...
                0.847, 0.786, 0.725, 0.746, 0.679, 0.608, 0.655, 0.616, ...
                0.606, 0.602, 0.626, 0.651, 0.724, 0.649, 0.649, 0.694, ...
                0.644, 0.624, 0.661, 0.612, 0.558, 0.533, 0.495, 0.500, ...
                0.423, 0.395, 0.375, 0.372, 0.391, 0.396, 0.405, 0.428, ...
                0.429, 0.523, 0.562, 0.607, 0.653, 0.672, 0.708, 0.633, ...
                0.668, 0.645, 0.632, 0.591, 0.559, 0.597, 0.625, 0.739, ...
                0.710, 0.729, 0.720, 0.636, 0.581, 0.428, 0.292, 0.162, ...
                0.098, 0.054];

            for i=1:m
                tmp = (i - 1) / 10;
                tmp1 = exp(- tmp * x(5));
                tmp2 = exp(- (tmp - x(9)) ^ 2 * x(6));
                tmp3 = exp(- (tmp - x(10)) ^ 2 * x(7));
                tmp4 = exp(- (tmp - x(11)) ^ 2 * x(8));
                fvec(i) = y5(i) - ( x(1) * tmp1 + x(2) * tmp2 + ...
                    x(3) * tmp3 + x(4) * tmp4 );
            end

        case 19 % BDQRTIC function

            for i=1:(n - 4)
                fvec(i) = - 4 * x(i) + 3;
                fvec(n - 4 + i) = x(i) ^ 2 + 2 * x(i + 1) ^ 2 + 3.0 * x(i + 2) ^ 2 + 4 * x(i + 3) ^ 2 + 5 * x(n) ^ 2;
            end

        case 20 % Cube function

            fvec(1) = x(1) - 1;

            for i=2:m
                fvec(i) = 10 * ( x(i) - x(i-1) ^ 3 );
            end

        case 21 % Mancino function

            for i = 1:n
                ss = 0;
                for j = 1:n
                    v2 = sqrt(x(i)^2 + i / j);
                    ss = ss + v2 * ((sin(log(v2)))^5 + (cos(log(v2)))^5);
                end
                fvec(i) = 1400 * x(i) + (i - 50)^3 + ss;
            end

        case 22 % HEART8LS function

            tmp1 = x(5) ^ 2 - x(7) ^ 2;
            tmp2 = x(6) ^ 2 - x(8) ^ 2;
            tmp3 = x(5) * (x(5) ^ 2 - 3 * x(7) ^ 2);
            tmp4 = x(7) * (x(7) ^ 2 - 3 * x(5) ^ 2);
            tmp5 = x(6) * (x(6) ^ 2 - 3 * x(8) ^ 2);
            tmp6 = x(8) * (x(8) ^ 2 - 3 * x(6) ^ 2);
            fvec(1) = x(1) + x(2) + 0.69;
            fvec(2) = x(3) + x(4) + 0.044;
            fvec(3) = x(5) * x(1) + x(6) * x(2) - x(7) * x(3) - x(8) * x(4) + 1.57;
            fvec(4) = x(7) * x(1) + x(8) * x(2) + x(5) * x(3) + x(6) * x(4) + 1.31;
            fvec(5) = x(1) * tmp1 - 2 * x(3) * x(5) * x(7) + x(2) * tmp2 - 2 * x(4) * x(6) * x(8) + 2.65;
            fvec(6) = x(3) * tmp1 + 2 * x(1) * x(5) * x(7) + x(4) * tmp2 + 2 * x(2) * x(6) * x(8) - 2.0;
            fvec(7) = x(1) * tmp3 + x(3) * tmp4 + x(2) * tmp5 + x(4) * tmp6 + 12.6;
            fvec(8) = x(3) * tmp3 - x(1) * tmp4 + x(4) * tmp5 - x(2) * tmp6 - 9.48;

        otherwise

            error('Invalid option.');

    end

    fvec = fvec .^ 2;

end

function val = cheb1(x, index)

    y = 2 * x - 1;

    if ( y > 1 )
        val = cosh(index * acosh(y));
    elseif ( y < - 1 )
        val = ( -1 )^ index * cosh(index * acosh(-y));
    else
        val = cos(index * acos(y));
    end

end

function val = cheb2(x, index)

    n = length(x);
    val = 0;

    for j=1:n
        a = cheb1(x(j), index);
        val = val + a;
    end

    val = val / n;

    if rem(index, 2) == 0
        val = val + 1 / (index ^ 2 - 1);
    end

end