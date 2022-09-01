function c = restricoes(x)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

current_directory = pwd();
file_directory = strcat(current_directory, '/test_comparison.jl');

% Calcula as restrições de desigualdade e seu gradiente
c = jlcall('c_obj', {x}, 'setup', file_directory);

end