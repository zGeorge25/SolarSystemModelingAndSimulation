%% MAIN  - TEMA BONUS (MODELARE SI SIMULARE)

clear; clc; close all;
disp('================================================');
disp('      PROIECT SIMULARE SISTEM SOLAR');
disp('================================================');

%% Cerinta 1: Initializare si Simulare
% "Simulati sistemul solar... Alegeti pozitiile planetelor... JPL Horizons"
disp('>> Rulare: ex1_setup.m (Date JPL Horizons)');
setup; 

disp('>> Rulare: Simulare Simulink (88 zile)...');
% Verificam modelul
if exist('SolarSystemModel.slx', 'file')
    load_system('SolarSystemModel');
    set_param('SolarSystemModel', 'StopTime', num2str(t_stop));
    
    try
        out = sim('SolarSystemModel');
        disp('   Simulare finalizata cu succes.');
    catch ME
        error(['Eroare Simulink: ' ME.message]);
    end
else
    error('Fisierul SolarSystemModel.slx lipseste!');
end
plotare;

%% Cerinta 2: Animatie si Orbite
% "Animati miscarea planetelor si reprezentati grafic traiectoriile"
disp('>> Rulare: animatie.m');
animatie;
pause(1);

%% Cerinta 3: Grafice Distante
% "Ilustrati grafic distanta fiecarui corp ceresc pana la Soare"
disp('>> Rulare: distante.m');
distante;

%% Cerinta 4: Miscare Retrograda Mercur
% "Evidentiati fenomenul de miscare retrograda aparenta a planetei Mercur"
disp('>> Rulare: retrograd.m');
retrograd;

%% Cerinta 5: Algoritm RK4 si Comparatie
% "Implementare RK4... Analiza comparativa"
disp('>> Rulare: rk4_algoritm.m (Solver Propriu)');
rk4_algoritm;

disp('>> Rulare: comparatie.m (RK4 vs Simulink)');
comparatie;

%% Cerinta 6: Validare Erori
% "Calculati eroarea de integrare... folosind datele JPL"
disp('>> Rulare: validare.m');
validare;

disp('================================================');
disp('      FINAL                    ');
disp('================================================');