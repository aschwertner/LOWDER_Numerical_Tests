function [] = runMSPqd()

    % Adds the path to the MSP (Manifold Sampling Primal) solver.
    addpath('solvers/MSP/manifold_sampling/m/');
    addpath('solvers/MSP/manifold_sampling/m/h_examples');
    addpath('solvers/MSP/pounders/matlab');
    subprob_switch = 'linprog';

    % Adds the path to QD testset problems.
    addpath('QD/problems/');
    addpath('QD/m/');

    % Number of fi functions in each testset.
    fi_dims = [10, 25, 50, 75, 100];

    % Dimension of the problems.
    n = 10;

    for ts = 1:length(fi_dims)

        % Number of fi functions.
        num_fi = fi_dims(ts);

        % Reads the file with the dimensions of the problems.
        qd_data = readmatrix(strcat('testset_', int2str(num_fi), '.dat'));
    
        % Calculates the number of problems
        num_prob = size(qd_data, 1);
    
        % Creates the file that will receive the execution data of MSP in
        % QD testset.
        current_directory = pwd();
        directory = fileparts(fileparts(current_directory));
        file_directory_3 = strcat(directory, '/data_files/QD/', ...
            int2str(num_fi), '/MSP.dat');
        fileID = fopen(file_directory_3, 'w');
        
        % Selects problem 'np'.
        for np = 1:num_prob
    
            % Creates a file for each problem with log data.
            file_directory_4 = strcat(directory, '/data_files/QD/', ...
                int2str(num_fi), '/MSP/', int2str(np), '.dat');
            fileID_2 = fopen(file_directory_4, 'w');
    
            % Display info.
            fprintf('Testset QD %d - Running problem %d ... \n', num_fi, np);
    
            try
          
                % Calculates the starting point, and the upper and lower 
                % bounds. 
                [x, l, u] = infoQD(n);
    
                % Projects the original starting point (LOWDER like).
                x0 = projection_lowder_like(x, l, u);
                
                % Sets objective funtion.
                objective_func = @(x) new_obj(x, num_fi, qd_data(np, :), ...
                    fileID_2);
                        
                % Calls the solver.
                [X, ~, h, ~, ~] = manifold_sampling_primal(@pw_minimum, ...
                    objective_func, x0, l, u, 1100, subprob_switch);
               
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

    end

    % Close file.
    fclose(fileID);

    fprintf('Testset complete.\n');

end

function obj = new_obj(x, num_fi, data, fileID)

    obj = functionsQD(num_fi, data, x);
    fprintf(fileID, '%.7e\n', min(obj));

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