function sol = runMSPhs()

    % Adds the path to the MSP (Manifold Sampling Primal) solver.
    addpath("MSP/manifold_sampling/m/");
    addpath("MSP/manifold_sampling/m/h_examples");
    addpath("MSP/pounders/matlab");

    subprob_switch = 'linprog';

    % Saves the paths to the directories containing the files 
    % 'problem_global.jl' and 'comparison_hs.jl'.
    current_directory = pwd();
    file_directory_1 = strcat(current_directory, '/problem_global.jl');
    file_directory_2 = strcat(current_directory, '/comparison_hs.jl');

    % Creates the file that will receive the execution data of MSP in
    % MW testset.
    directory = fileparts(fileparts(current_directory));
    file_directory_3 = strcat(directory, ...
        '/data_files/HS/MSP.dat');
    fileID = fopen(file_directory_3, 'w');
    
    % Selects problem 'np'.
    for np = 1:2

        try

            % Creates a file for each problem with log data.
            file_directory_4 = strcat(directory, ...
                '/data_files/HS/MSP/', int2str(np), '.dat');
            fileID_2 = fopen(file_directory_4, 'w');
    
            % Sets the problem number 'np' in the global scope of the Julia 
            % session. Also restart Julia server environment.
            jlcall('problem', {np}, 'setup', file_directory_1, ...
                'restart', true);
        
            % Calculates the starting point, dimension of the problem, and 
            % number of functions that make up fmin.
            [x0, ~, ~, l, u] = jlcall('problem_init_dim_bounds', {}, ...
                'setup', file_directory_2);
        
            % Calls the solver.
            [~, ~, h, ~, ~] = manifold_sampling_primal(@pw_minimum, ...
                @objective_func, x0, l, u, 1100, subprob_switch);
           
            % Saves info about log.
            [nRows, ~] = size(h);
            nf_eval = linspace(1,nRows, nRows).';
            log_info = [nf_eval, h];
            fprintf(fileID_2, '%d %.7e\n', log_info.');

            % Saves info about execution.
            fprintf(fileID, '%d success\n', np);

            % Display info.
            text_display = strcat("Running problem ", string(np), ...
                " ... success!");
            disp(text_display);

        catch

            % Saves info about execution.
            fprintf(fileID, '%d failure\n', np);
            
            % Display info.
            text_display = strcat("Running problem ", string(np), ...
                " ... failure!");
            disp(text_display);

        end

        % Close file.
        fclose(fileID_2);

    end

    % Close file.
    fclose(fileID);

    disp("Testset complete.")

end

function fvec = objective_func(x)

    % Saves the path to the directory containing the file 
    % 'comparison_hs.jl'.
    current_directory = pwd();
    file_directory = strcat(current_directory, '/comparison_hs.jl');

    % Calculates the objective function and its gradient.
    fvec = jlcall('msp_obj', {x}, 'setup' , file_directory);

end