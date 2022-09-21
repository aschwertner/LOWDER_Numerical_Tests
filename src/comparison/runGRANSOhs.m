function sol = runGRANSOhs()

    % Adds the path to the GRANSO solver.
    addpath("GRANSO/");

    % Saves the paths to the directories containing the files 
    % 'problem_global.jl' and 'comparison_hs.jl'.
    current_directory = pwd();
    file_directory_1 = strcat(current_directory, '/problem_global.jl');
    file_directory_2 = strcat(current_directory, '/comparison_hs.jl');

    % Creates the file that will receive the execution data.
    file_directory_3 = strcat(fileparts(fileparts(current_directory)), ...
        '/data_files/hs_GRANSO.dat');
    fileID = fopen(file_directory_3, 'w');

    % Selects problem 'np'.
    for np = 1:87

        try

            % Sets the problem number 'np' in the global scope of the Julia 
            % session. Also restart Julia server environment.
            jlcall('problem', {np}, 'setup', file_directory_1, ...
                'restart', true);

            % Calculates the starting point, dimension of the problem, and 
            % number of functions that make up fmin.
            [x0, nvar, nfi] = jlcall('problem_init_dim', {}, 'setup', ...
                file_directory_2);

            % Converts the problem start point and dimension to the 
            % 'double' type.
            nvar = double(nvar);
            opts.x0 = double(x0);
  
            % Sets the equality constraint set to empty.
            eq_constraints = [];

            % Sets tolerance for stationarity, maximum number of 
            % iterations, and maximum clock time.
            opts.opt_tol = 1e-4;
            opts.maxit = 100 * nvar;
            opts.maxclocktime = 1800;

            % Calls the solver.
            sol = granso(nvar, @objective_func, @ineq_constraints, ...
                eq_constraints, opts);

            % Computes the number of fi evaluations.
            fi_evals = sol.fn_evals * nfi;

            % Saves info about solution.
            text = [nvar; sol.iters; sol.fn_evals; fi_evals; 
                sol.most_feasible.f; sol.stat_value; sol.most_feasible.tvi; 
                sol.termination_code];
            fprintf(fileID,'%d %d %d %d %.4e %.4e %.4e %d\n', text);

            % Display info.
            text_display = strcat("Running problem ", string(np), ...
                " ... success!");
            disp(text_display);

        catch

            % Saves info about solution.
            fprintf(fileID, '%s\n', 'NaN NaN NaN NaN NaN NaN NaN NaN');
            
            % Display info.
            text_display = strcat("Running problem ", string(np), ...
                " ... fail!");
            disp(text_display);

        end

    end

    % Close file.
    fclose(fileID);

    disp("Testset complete.")

end

function [f, fgrad] = objective_func(x)

    % Saves the path to the directory containing the file 
    % 'comparison_hs.jl'.
    current_directory = pwd();
    file_directory = strcat(current_directory, '/comparison_hs.jl');

    % Calculates the objective function and its gradient.
    [f, fgrad] = jlcall('f_obj', {x}, 'setup' , file_directory);

end

function [c, cgrad] = ineq_constraints(x)

    % Saves the path to the directory containing the file 
    % 'comparison_hs.jl'.
    current_directory = pwd();
    file_directory = strcat(current_directory, '/comparison_hs.jl');

    % Computes the inequality constraints and its gradient.
    [c, cgrad] = jlcall('c_obj', {x}, 'setup', file_directory);

end