function sol = runSLQPGSmw()

    % Adds the path to the GRANSO solver.
    addpath("SLQPGS/SLQPGS/src");

    % Saves the paths to the directories containing the files 
    % 'problem_global.jl' and 'comparison_mw.jl'.
    current_directory = pwd();
    file_directory_1 = strcat(current_directory, '/problem_global.jl');
    file_directory_2 = strcat(current_directory, '/comparison_mw.jl');

    % Creates the file that will receive the execution data.
    %file_directory_3 = strcat(fileparts(fileparts(current_directory)), ...
    %    '/data_files/mw_SLQPGS.dat');
    %fileID = fopen(file_directory_3, 'w');

    np = 1;

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
    n = double(nvar);
    x = double(x0);
    %n = nvar;
    %x = x0;

    %param = slqpgs_inputs(x, n);
    %S = SLQPGS(param);
    S = SLQPGS(slqpgs_inputs(x, n));
    S.optimize;

    [sol, log] = S.getSolution();

    disp(nfi);
    disp(sol);
    disp(log);

end

function value = problem_functions(x,d,j,o)

    % Saves the path to the directory containing the file 
    % 'comparison.jl'.
    current_directory = pwd();
    file_directory = strcat(current_directory, '/comparison_mw.jl');

    % Switch on evaluation option
    switch o
  
        case 0 % Objective function value

            value = jlcall('obj_f', {x}, 'setup' , file_directory);

        case 1 % Objective gradient value

            value = jlcall('obj_f_grad', {x}, 'setup' , file_directory);

        case 2 % j-th equality constraint value
    
        case 3 % j-th equality constraint gradient value (as row vector)
    
        case 4 % j-th inequality constraint value
    
            value = jlcall('cons_f', {x, j}, 'setup' , file_directory);
    
        case 5 % j-th inequality constraint gradient value (as row vector)
    
            value = jlcall('cons_function_grad', {x, j}, 'setup' , ...
                file_directory);

        otherwise
    
            % This error is not supposed to happen!
            error('SLQP-GS: Option not given to problem function evaluator.');

    end

end

function params = slqpgs_inputs(x0, nvar)

    % Set inner algorithm to SQP-GS
    params.algorithm = 0;

    % Set tolerances
    params.stat_tol = 1e-04;
    params.ineq_tol = 1e-06;
    params.iter_max = 100 * nvar;

    % Set problem size
    params.nV = nvar;
    params.nE = 0;
    params.nI = nvar;

    % Set sample sizes
    params.pO = 2 * params.nV;
    params.pE = 0;
    params.pI = zeros(1, params.nV);

    % Set initial point
    params.x = x0;

    % Set function handle
    params.f = @problem_functions;

end