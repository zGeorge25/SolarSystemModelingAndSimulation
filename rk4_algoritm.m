% ex5_rk4_algoritm.m
% Cerinta 5: Implementare RK4 cu pas fix

if ~exist('r0', 'var'), ex1_setup; end % Incarcam datele daca lipsesc

h = 600; % Pas integrare
t_end_rk = 7 * 24 * 3600; % Orizont 1 saptamana
nSteps = floor(t_end_rk / h);

% Initializare matrici rezultate
pos_rk4 = zeros(nSteps, 9, 3);
r_curr = r0; % Folosim r0 din setup
v_curr = v0; % Folosim v0 din setup

disp(['>> Rulare RK4 (Pas h=' num2str(h) 's)...']);

for k = 1:nSteps
    % Salvare pas curent
    pos_rk4(k, :, :) = r_curr';
    
    % Calcul RK4
    k1_v = calc_grav(r_curr, m, G);
    k1_r = v_curr;
    
    r2 = r_curr + 0.5*h*k1_r;
    v2 = v_curr + 0.5*h*k1_v;
    k2_v = calc_grav(r2, m, G);
    k2_r = v2;
    
    r3 = r_curr + 0.5*h*k2_r;
    v3 = v_curr + 0.5*h*k2_v;
    k3_v = calc_grav(r3, m, G);
    k3_r = v3;
    
    r4 = r_curr + h*k3_r;
    v4 = v_curr + h*k3_v;
    k4_v = calc_grav(r4, m, G);
    k4_r = v4;
    
    % Update
    r_curr = r_curr + (h/6)*(k1_r + 2*k2_r + 2*k3_r + k4_r);
    v_curr = v_curr + (h/6)*(k1_v + 2*k2_v + 2*k3_v + k4_v);
end
disp('   RK4 Finalizat.');

% Functia de acceleratie gravitationala
function a = calc_grav(r, m, G)
    N = size(r, 2);
    a = zeros(3, N);
    for i = 1:N
        for j = 1:N
            if i ~= j
                rij = r(:, j) - r(:, i);
                dist = norm(rij);
                a(:, i) = a(:, i) + (G * m(j) * rij) / (dist^3);
            end
        end
    end
end