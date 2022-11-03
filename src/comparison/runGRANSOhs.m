function [] = runGRANSOhs()

    % Adds the path to the GRANSO solver.
    addpath('solvers/GRANSO/');

    % Adds the path to HS testset problems.
    addpath('HS/m/');

    % Creates the file that will receive the execution data of GRANSO in
    % HS testset.
    current_directory = pwd();
    directory = fileparts(fileparts(current_directory));
    file_directory_1 = strcat(directory, '/data_files/HS/GRANSO.dat');
    fileID = fopen(file_directory_1, 'w');

    % Selects problem 'np'.
    for np = 1:87
        
        % Creates a file for each problem with log data.
        file_directory_2 = strcat(directory, ...
            '/data_files/HS/GRANSO/', int2str(np), '.dat');
        fileID_2 = fopen(file_directory_2, 'w');

        % Display info.
        fprintf('Running problem %d ... ', np);

        try

            % Calculates the starting point, dimension of the problem.
            [nvar, x, l, u] = infoHS(np);

            % Projects the initial guess in the box.
            x0 = projection_lowder_like(x, l, u);

            % Sets the starting point.
            opts.x0 = x0.';
  
            % Sets the equality constraint set to empty.
            eq_constraints = [];

            % Sets tolerance for stationarity and for step length, maximum 
            % number of iterations, and print level.
            opts.opt_tol = 0;
            opts.step_tol = 1e-20;
            opts.maxit = 1100;
            opts.print_level = 0;

            % Sets halt and log functions.
            [halt_log_fn, get_log_fn] = makeHaltLogFunctions(opts.maxit);
            opts.halt_log_fn = halt_log_fn;

            % Sets objective funtion and inequality constraints function.
            f_objective = @(x) objective_func(np, x);
            iq_constraints = @(x) constraintsHS(np, x);

            % Calls the solver.
            sol = granso(nvar, f_objective, iq_constraints, ...
                eq_constraints, opts);

            % Gets the log.
            log = get_log_fn();

            % Saves info about log.
            log_info = [log.fn_evals; log.f];
            fprintf(fileID_2, '%d %.7e\n', log_info);

            % Saves info about execution.
            fprintf(fileID, '%d success %.7e [ ', np, sol.most_feasible.f);
            fprintf(fileID, '%.3e ', sol.most_feasible.x);
            fprintf(fileID, ']\n');

            % Display info.
            fprintf('succes!\n');

        catch

            % Saves info about solution.
            fprintf(fileID, '%d failure NaN NaN\n', np);
           
            % Display info.
            fprintf('failure!\n')

        end

        % Close file.
        fclose(fileID_2);

    end

    % Close file.
    fclose(fileID);

    fprintf('Testset complete.\n')

end

function [f, fgrad] = objective_func(np, x)

    [f, index] = min(functionsHS(np, x));
    fgrad = derivativesHS(np, x, index);

    %persistent counter   % WARNING: I recommend to avoid this!
    %if isempty(counter)
    %    counter = 0;
    %end
    %counter = counter + 1;
    %fprintf("%d %d %.7f ", counter, index, f);
    %fprintf("%.4f ", x);
    %fprintf("\n");
    %pause(5);

end

function x0 = projection_lowder_like(x, l, u)

    d = u - l;
    delta = min(min(d)/2, 1);
    n = length(x);
    x0 = x;
    
    for i=1:n
        lo = l(i) - x(i);
        uo = u(i) - x(i);
        if ( lo >= - delta )
            if ( lo >= 0 )
                x0(i) = l(i);
            else
                x0(i) = l(i) + delta;
            end
        elseif ( uo <= delta )
            if ( uo <= 0 )
                x0(i) = u(i);
            else
                x0(i) = u(i) - delta;
            end
        end
    end
end

function [halt_log_fn, get_log_fn] = makeHaltLogFunctions(maxit)

    % Function handles.
    halt_log_fn     = @haltLog;
    get_log_fn      = @getLog;

    % Stores GRANSO history of function values.
    index = 0;
    sum_fn_evals = 0;
    f = zeros(1,maxit+1);
    %tv = zeros(1,maxit+1);
    fn_evals = zeros(1,maxit+1);

    function halt = haltLog(iter, x, penaltyfn_parts, d, ...
                            get_BFGS_state_fn, H_regularized, ls_evals, ...
                            alpha, n_gradients, stat_vec, stat_val, ...
                            fallback_level)
          
        % Increment the index/count. 
        index = index + 1;
        sum_fn_evals = sum_fn_evals + ls_evals;
        
        % Stores history data.
        f(index) = penaltyfn_parts.f;
        %tv(index) = penaltyfn_parts.tv;
        fn_evals(index) = sum_fn_evals;
        
        % keep this false unless you want to implement a custom termination
        % condition
        if sum_fn_evals >= maxit
            halt = true;
        else
            halt = false;
        end

    end

    function log = getLog()
        log.f   = f(1:index);
        %log.tv  = tv(1:index);
        log.fn_evals = fn_evals(1:index);
    end

end