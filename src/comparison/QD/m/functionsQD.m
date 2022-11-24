function fvec = functionsQD(num_fi, data, x)
    
    n = 10;
    nn = length(data);

    fvec = zeros(1, num_fi);
    u = 10 * ones(1, n);

    K = 5;

    for i=1:(num_fi-1)

        d_init = 2 * (i - 1) * n + 1;
        d_last = d_init + n - 1;
        x_init = d_last + 1;
        x_last = x_init + n - 1;

        k = K ^ i;
        d = 1000 * data(d_init:d_last);
        x0 = data(x_init:x_last) .* u;

        tmp = 0;
        for j=1:n
            tmp = tmp + d(j) * (x(j) - x0(j)) ^ 2;
        end

        fvec(i) = k + 0.5 * tmp;

    end

    c = data((nn - n + 1):end);
    c = c / norm(c);
    c(1) = ( K ^ (num_fi + 1) - dot(c(2:end), u(2:end))) / u(1);

    fvec(num_fi) = dot(c, x);

end