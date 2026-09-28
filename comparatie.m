% ex5_comparatie.m
% Cerinta 5: Analiza comparativa RK4 vs Simulink

if ~exist('pos_rk4', 'var'), error('Ruleaza ex5_rk4_algoritm!'); end
if ~exist('out', 'var'), error('Ruleaza simularea Simulink!'); end

sim_data = out.sim_pos;
if size(sim_data,1)==3, sim_data = permute(sim_data, [3 2 1]); end
sim_t = out.tout;
rk_t = (0:(size(pos_rk4,1)-1)) * 600;

% Selectam Pamantu
idx = 4; 

% Interpolare Simulink pe grila de timp RK4
pos_sim_int_x = interp1(sim_t, sim_data(:, idx, 1), rk_t);
pos_sim_int_y = interp1(sim_t, sim_data(:, idx, 2), rk_t);
pos_sim_int_z = interp1(sim_t, sim_data(:, idx, 3), rk_t);

diff_x = pos_sim_int_x' - pos_rk4(:, idx, 1);
diff_y = pos_sim_int_y' - pos_rk4(:, idx, 2);
diff_z = pos_sim_int_z' - pos_rk4(:, idx, 3);
err_total = sqrt(diff_x.^2 + diff_y.^2 + diff_z.^2);

figure('Name', 'Cerinta 5: Comparatie', 'Color', 'w');
plot(rk_t/(24*3600), err_total, 'r', 'LineWidth', 1.5);
xlabel('Timp (Zile)'); ylabel('Eroare Pozitie (m)');
title('Diferenta Solver Propriu (RK4) vs Simulink (ode45) - Pamant');
grid on;