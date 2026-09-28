% setup_solar_system.m
% Initializeaza constantele, masele si conditiile initiale pentru simulare

clear; clc;

%% 1. Constante Fizice
G = 6.6743e-11; % m^3 kg^-1 s^-2

%% 2. Masele Corpurilor (kg)
M_sun     = 1.989e30;
M_mercury = 3.302e23;
M_venus   = 4.867e24;
M_earth   = 5.972e24;
M_mars    = 6.417e23;
M_jupiter = 1.898e27;
M_saturn  = 5.685e26;
M_uranus  = 8.681e25;
M_neptune = 1.024e26;

m = [M_sun, M_mercury, M_venus, M_earth, M_mars, M_jupiter, M_saturn, M_uranus, M_neptune];

%% 3. Conditii Initiale (Pozitii si Viteze) - Reale JPL
% Unitati: Metri si Metri/s
% Data de Referinta: 2026-Jan-07

% Sun
pos_sun = [-4.524295E+08; -8.275899E+08; 1.957758E+07];
vel_sun = [1.239958E+01; 4.032822E-01; -2.357851E-01];

% Mercury
pos_mercury = [-1.399258E+10; -6.917560E+10; -4.324082E+09];
vel_mercury = [3.802200E+04; -7.005380E+03; -4.058968E+03];

% Venus
pos_venus = [3.047414E+10; -1.051669E+11; -3.198333E+09];
vel_venus = [3.335289E+04; 9.833343E+03; -1.788882E+03];

% Earth
pos_earth = [-4.179286E+10; 1.403492E+11; 1.132058E+07];
vel_earth = [-2.905326E+04; -8.472796E+03; 1.527282E+00];

% Mars
pos_mars = [6.306977E+10; -2.038669E+11; -5.792928E+09];
vel_mars = [2.405342E+04; 9.317734E+03; -3.945035E+02];

% Jupiter
pos_jupiter = [-2.603521E+11; 7.346088E+11; 2.779451E+09];
vel_jupiter = [-1.247011E+04; -3.744430E+03; 2.946121E+02];

% Saturn
pos_saturn = [1.421402E+12; 4.272380E+10; -5.733675E+10];
vel_saturn = [-8.221690E+02; 9.634787E+03; -1.351169E+02];

% Uranus
pos_uranus = [1.474545E+12; 2.514042E+12; -9.765992E+09];
vel_uranus = [-5.924240E+03; 3.127885E+03; 8.837064E+01];

% Neptune
pos_neptune = [4.468279E+12; 7.963839E+10; -1.046161E+11];
vel_neptune = [-1.330061E+02; 5.465890E+03; -1.099032E+02];

% Matricea Pozitiilor Initiale (r0)
r0 = [pos_sun, pos_mercury, pos_venus, pos_earth, pos_mars, pos_jupiter, pos_saturn, pos_uranus, pos_neptune];

% Matricea Vitezelor Initiale (v0)
v0 = [vel_sun, vel_mercury, vel_venus, vel_earth, vel_mars, vel_jupiter, vel_saturn, vel_uranus, vel_neptune];

%% 4. Parametri Simulare
t_stop_days = 88;          
t_stop = t_stop_days * 24 * 3600; 

disp('SETUP SIMULINK COMPLET: Datele au fost actualizate.');
disp(' ');
disp('Analiza Initiala:');
disp(' - Sistemul contine 9 corpuri (Soare + 8 planete).');
disp(' - Datele sunt preluate din efemeridele exacte JPL Horizons.');
disp(' - Masa Soarelui domina sistemul (99.8% din masa totala), asigurand stabilitatea gravitationala.');
disp(' - Vitezele initiale sunt critice pentru mentinerea orbitelor eliptice stabile.');
