function sol = runExemplo()

    % Adds the path to the GRANSO solver
    addpath("GRANSO/");

    % Saves the path to the directory containing the file 
    % 'problem_global.jl'
    current_directory = pwd();
    file_directory = strcat(current_directory, '/problem_global.jl');

    % Selects problem 01
    np = 1;

    % Sets the problem number 'np' in the global scope of the Julia 
    % session.
    jlcall('problem', {np}, 'setup', file_directory);

    % Saves the path to the directory containing the file 
    % 'comparison.jl'
    file_directory = strcat(current_directory, '/comparison.jl');

    % Calculates the starting point, dimension of the problem, and number 
    % of functions that make up fmin.
    [x0, nvar, nfi] = jlcall('problem_init_dim', {}, 'setup', ...
        file_directory);

    % Converts the problem start point and dimension to the 'double' type.
    nvar = double(nvar);
    opts.x0 = double(x0);
  
    % Sets the equality constraint set to empty.
    eq_constraints = [];

    % Calls the solver.
    sol = granso(nvar, @objective_func, @ineq_constraints, ...
        eq_constraints, opts);

    fi_evals = sol.fn_evals * nfi;

    disp(sol.most_feasible.f);
    disp(sol.most_feasible.tvi);
    disp(sol.stat_value);

    % Saves info about solution
    fileID = fopen('mw_testset_GRANSO.txt','w');
    text = [nvar; sol.iters; sol.fn_evals; fi_evals; sol.termination_code; 
        sol.most_feasible.f; sol.most_feasible.tvi; sol.stat_value ];
    fprintf(fileID,'%d %d %d %d %d %.4e %.4e %.4e ', text);
    fprintf(fileID, '[%g, ', sol.most_feasible.x(1));
    fprintf(fileID, '%g, ', sol.most_feasible.x(2:end-1));
    fprintf(fileID, '%g]\n', sol.most_feasible.x(end));
    fclose(fileID);

end

function [f, fgrad] = objective_func(x)

    % Saves the path to the directory containing the file 
    % 'comparison.jl
    current_directory = pwd();
    file_directory = strcat(current_directory, '/comparison.jl');

    % Calculates the objective function and its gradient
    [f, fgrad] = jlcall('f_obj', {x}, 'setup', file_directory);

end

function [c, cgrad] = ineq_constraints(x)

    % Saves the path to the directory containing the file 
    % 'comparison.jl
    current_directory = pwd();
    file_directory = strcat(current_directory, '/comparison.jl');

    % Computes the inequality constraints and its gradient
    [c, cgrad] = jlcall('c_obj', {x}, 'setup', file_directory);

end