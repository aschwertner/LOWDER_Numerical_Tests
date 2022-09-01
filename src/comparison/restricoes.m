function [c, cgrad] = restricoes(x)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% Calcula as restrições de desigualdade e seu gradiente
[c, cgrad] = jlcall('c_obj', {x}, 'setup', '/src/teste_comparacao.jl');

end