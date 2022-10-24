function sol = runGRANSOmw()

    % Adds the path to the GRANSO solver.
    addpath("GRANSO/");

    % Saves the paths to the directories containing the files 
    % 'problem_global.jl' and 'comparison_mw.jl'.
    current_directory = pwd();
    file_directory_1 = strcat(current_directory, '/problem_global.jl');
    file_directory_2 = strcat(current_directory, '/comparison_mw.jl');

    % Creates the file that will receive the execution data of GRANSO in
    % MW testset.
    directory = fileparts(fileparts(current_directory));
    file_directory_3 = strcat(directory, ...
        '/data_files/MW/GRANSO.dat');
    fileID = fopen(file_directory_3, 'w');

    % Selects problem 'np'.
    for np = 1:53

        % Creates a file for each problem with log data.
        file_directory_4 = strcat(directory, ...
            '/data_files/MW/GRANSO/', int2str(np), '.dat');
        fileID_2 = fopen(file_directory_4, 'w');

        try

            % Sets the problem number 'np' in the global scope of the Julia 
            % session. Also restart Julia server environment.
            jlcall('problem', {np}, 'setup', file_directory_1, ...
                'restart', true);

            % Calculates the starting point, dimension of the problem, and 
            % number of functions that make up fmin.
            [x0, nvar, ~] = jlcall('problem_init_dim', {}, 'setup', ...
                file_directory_2);

            % Converts the problem start point and dimension to the 
            % 'double' type.
            nvar = double(nvar);
            opts.x0 = double(x0);
  
            % Sets the equality constraint set to empty.
            eq_constraints = [];

            % Sets tolerance for stationarity and for step length, maximum 
            % number of iterations, and print level.
            opts.opt_tol = 0;
            opts.step_tol = 1e-20;
            opts.maxit = 1300;
            opts.print_level = 0;

            % Sets halt and log functions.
            [halt_log_fn, get_log_fn] = makeHaltLogFunctions(opts.maxit);
            opts.halt_log_fn = halt_log_fn;
  
            % Calls the solver.
            sol = granso(nvar, @objective_func, @ineq_constraints, ...
                eq_constraints, opts);

            % Gets the log.
            log = get_log_fn();

            % Computes the number of fi evaluations.
            %fi_evals = sol.fn_evals * nfi;

            % Saves info about solution.
            %text = [nvar; sol.iters; sol.fn_evals; fi_evals; 
            %    sol.most_feasible.f; sol.stat_value; sol.most_feasible.tvi; 
            %    sol.termination_code];
            %fprintf(fileID,'%d %d %d %d %.4e %.4e %.4e %d\n', text);

            % Saves info about log.
            log_info = [log.fn_evals; log.f];
            fprintf(fileID_2, '%d %.7e\n', log_info);

            % Saves info about execution.
            fprintf(fileID, '%d success\n', np);

            % Saves info about log.
            %log_info = [log.f; log.tv; log.fn_evals];
            %fprintf(fileID_2, '%.7e %.7e %d\n', log_info);

            % Display info.
            text_display = strcat("Running problem ", string(np), ...
                " ... success!");
            disp(text_display);

        catch

            % Saves info about execution.
            %fprintf(fileID, '%s\n', 'NaN NaN NaN NaN NaN NaN NaN NaN');
            fprintf(fileID, '%d failure\n', np);
            
            % Display info.
            text_display = strcat("Running problem ", string(np), ...
                " ... fail!");
            disp(text_display);

        end

        % Close file.
        fclose(fileID_2);

    end

    % Close file.
    fclose(fileID);

    disp("Testset complete.")

end

function [f, fgrad] = objective_func(x)

    % Saves the path to the directory containing the file 
    % 'comparison_mw.jl'.
    current_directory = pwd();
    file_directory = strcat(current_directory, '/comparison_mw.jl');

    % Calculates the objective function and its gradient.
    [f, fgrad] = jlcall('granso_obj', {x}, 'setup' , file_directory);

end

function [c, cgrad] = ineq_constraints(x)

    % Saves the path to the directory containing the file 
    % 'comparison_mw.jl'.
    current_directory = pwd();
    file_directory = strcat(current_directory, '/comparison_mw.jl');

    % Computes the inequality constraints and its gradient.
    [c, cgrad] = jlcall('granso_cons', {x}, 'setup', file_directory);

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

    function halt = haltLog(    iter, x, penaltyfn_parts, d,        ...
                                get_BFGS_state_fn, H_regularized,   ...
                                ls_evals, alpha,                    ...
                                n_gradients, stat_vec, stat_val,    ...
                                fallback_level                      )
          
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