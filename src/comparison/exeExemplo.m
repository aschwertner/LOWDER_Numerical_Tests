function sol = exeExemplo()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    addpath("GRANSO/");
    
    nvar    = 9;    % número de variáveis do problema
    eq_fn   = [];   % não há restrições de igualdade
    soln    = granso(nvar, @objetivo, @restricoes, eq_fn);

end