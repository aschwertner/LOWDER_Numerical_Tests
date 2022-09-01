function sol = runExemplo()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    addpath("GRANSO/");

    current_directory = pwd();
    file_directory = strcat(current_directory, '/problem_global.jl');

    np = 1;
    jlcall('problem', {np}, 'setup', file_directory);

    file_directory = strcat(current_directory, '/comparison.jl');

    [x0, nvar] = jlcall('problem_init_dim', {}, 'setup', file_directory);

    nvar = double(nvar);

    %disp(class(nvar));
    %disp(x0);
   
    %nvar    = 9;    % número de variáveis do problema
    eq_fn   = [];   % não há restrições de igualdade
    soln    = granso(nvar, @objetivo1, @restricoes1, eq_fn);

end

function [f, fgrad] = objetivo1(x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    current_directory = pwd();
    file_directory = strcat(current_directory, '/comparison.jl');

    % Calcula as restrições de desigualdade e seu gradiente
    [f, fgrad] = jlcall('f_obj', {x}, 'setup', file_directory);

end

function [c, cgrad] = restricoes1(x)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    current_directory = pwd();
    file_directory = strcat(current_directory, '/test_comparison.jl');

    % Calcula as restrições de desigualdade e seu gradiente
    [c, cgrad] = jlcall('c_obj', {x}, 'setup', file_directory);

end