function [] = runMSPmw()

    % Adds the path to the MSP (Manifold Sampling Primal) solver.
    addpath('solvers/MSP/manifold_sampling/m/');
    addpath('solvers/MSP/manifold_sampling/m/h_examples');
    addpath('solvers/MSP/pounders/matlab');
    subprob_switch = 'linprog';

    % Adds the path to HS testset problems.
    addpath('MW');
    addpath('MW/m/');

    % Reads the file with the dimensions of the problems.
    mw_selected = readmatrix("CUTEr_selected_problems.dat");

    % Creates the file that will receive the execution data of MSP in
    % MW testset.
    current_directory = pwd();
    directory = fileparts(fileparts(current_directory));
    file_directory_3 = strcat(directory, '/data_files/MW/MSP.dat');
    fileID = fopen(file_directory_3, 'w');
    
    % Selects problem 'np'.
    for np = 1:53

        % Creates a file for each problem with log data.
        file_directory_4 = strcat(directory, '/data_files/MW/MSP/', ...
            int2str(np), '.dat');
        fileID_2 = fopen(file_directory_4, 'w');

        % Display info.
        fprintf('Running problem %d ... \n', np);

        %Problem info
        k = mw_selected(np, 1);
        n = mw_selected(np, 2);
        m = mw_selected(np, 3);
        s = mw_selected(np, 4);

        try
    
            % Calculates the starting point, and the upper and lower 
            % bounds.
            [x0, l, u] = infoMW(k, n, s);

            % Sets objective funtion.
            objective_func = @(x) new_obj(x, k, n, m, fileID_2);
        
            % Calls the solver.
            [X, ~, h, ~, ~] = manifold_sampling_primal(@pw_minimum, ...
                objective_func, x0, l, u, 1300, subprob_switch);
           
            % Saves info about execution.
            fprintf(fileID, '%d success %.7e [ ', np, h(end));
            fprintf(fileID, '%.3e ', X(end, :));
            fprintf(fileID, ']\n');

            % Display info.
            fprintf('succes!\n');

        catch

            % Saves info about solution.
            fprintf(fileID, '%d failure NaN NaN\n', np);
           
            % Display info.
            fprintf('failure!\n');

        end

        % Close file.
        fclose(fileID_2);

    end

    % Close file.
    fclose(fileID);

    fprintf('Testset complete.\n');

end

function obj = new_obj(x, k, n, m, fileID)

    obj = functionsMW(k, n, m, x);
    fprintf(fileID, '%.7e\n', min(obj));

end