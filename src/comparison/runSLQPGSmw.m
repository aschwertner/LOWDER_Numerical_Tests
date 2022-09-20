function sol = runSLQPGSmw(cc)


end

function value = problem_functions(x,j,o)

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