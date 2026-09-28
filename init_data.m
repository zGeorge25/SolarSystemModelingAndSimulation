% setup_solar_system.m
clear; clc;

%% 1. Constante Fizice
G = 6.6743e-11; % m^3 kg^-1 s^-2

%% 2. Masele Corpurilor (kg)
m = [1.989e30, ...    % Soare
     3.302e23, ...    % Mercur
     4.867e24, ...    % Venus
     5.972e24, ...    % Pamant
     6.417e23, ...    % Marte
     1.898e27, ...    % Jupiter
     5.685e26, ...    % Saturn
     8.681e25, ...    % Uranus
     1.024e26];       % Neptun

%% 3. Conditii Initiale (Pozitii si Viteze) - Reale JPL
% Data de Referinta: 2026-Jan-07
% Matricea r0 (3x9) si v0 (3x9): Fiecare coloana este un corp ceresc

% Matricea Pozitiilor Initiale (r0) [x; y; z] pentru fiecare corp
r0 = [ ...
    [-4.524295E+08; -8.275899E+08;  1.957758E+07], ... % Soare
    [-1.399258E+10; -6.917560E+10; -4.324082E+09], ... % Mercur
    [ 3.047414E+10; -1.051669E+11; -3.198333E+09], ... % Venus
    [-4.179286E+10;  1.403492E+11;  1.132058E+07], ... % Pamant
    [ 6.306977E+10; -2.038669E+11; -5.792928E+09], ... % Marte
    [-2.603521E+11;  7.346088E+11;  2.779451E+09], ... % Jupiter
    [ 1.421402E+12;  4.272380E+10; -5.733675E+10], ... % Saturn
    [ 1.474545E+12;  2.514042E+12; -9.765992E+09], ... % Uranus
    [ 4.468279E+12;  7.963839E+10; -1.046161E+11]  ... % Neptun
];

% Matricea Vitezelor Initiale (v0) [vx; vy; vz] pentru fiecare corp
v0 = [ ...
    [ 1.239958E+01;  4.032822E-01; -2.357851E-01], ... % Soare
    [ 3.802200E+04; -7.005380E+03; -4.058968E+03], ... % Mercur
    [ 3.335289E+04;  9.833343E+03; -1.788882E+03], ... % Venus
    [-2.905326E+04; -8.472796E+03;  1.527282E+00], ... % Pamant
    [ 2.405342E+04;  9.317734E+03; -3.945035E+02], ... % Marte
    [-1.247011E+04; -3.744430E+03;  2.946121E+02], ... % Jupiter
    [-8.221690E+02;  9.634787E+03; -1.351169E+02], ... % Saturn
    [-5.924240E+03;  3.127885E+03;  8.837064E+01], ... % Uranus
    [-1.330061E+02;  5.465890E+03; -1.099032E+02]  ... % Neptun
];

%% 4. Parametri Simulare si Metadata
names = {'Soare', 'Mercur', 'Venus', 'Pamant', 'Marte', 'Jupiter', 'Saturn', 'Uranus', 'Neptun'};
t_stop_days = 88;          
t_stop = t_stop_days * 24 * 3600; 

%% 5. Afisare Status
disp('SETUP SIMULINK COMPLET (VECTORIZAT):');
disp('------------------------------------');
fprintf('Numar corpuri initializate: %d\n', length(m));
disp('Datele (r0, v0, m) sunt incarcate in workspace.');
disp('Masa Soarelui domina sistemul (99.8% din masa totala).');
