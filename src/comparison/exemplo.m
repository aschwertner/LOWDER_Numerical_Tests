% Exemplo simples para instalar o MATDaemon, e verificar a instalação.
% O resultado da chamada da função deve ser 55.

jlcall('x -> sum(abs2, x)', {1:5}, 'server', false, ...
    'runtime', '/usr/bin/julia')