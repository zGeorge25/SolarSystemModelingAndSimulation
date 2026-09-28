% ex3_distante.m
% Cerinta 3: Grafic distante fata de Soare

if ~exist('out', 'var'), error('Ruleaza simularea!'); end
sim_pos = out.sim_pos;
if size(sim_pos,1) == 3, sim_pos = permute(sim_pos, [3 2 1]); end

if isprop(out, 'tout'), tout = out.tout; else, tout = linspace(0, 88*24*3600, size(sim_pos,1)); end
time_days = tout / (24*3600);

figure('Name', 'Cerinta 3: Distante', 'Color', 'w');
set(gca, 'YScale', 'log'); hold on; grid on;

% Calculam norma euclidiana pentru fiecare planeta (fata de originea 0,0,0 - Soare)
for i = 2:9 
    pos_body = squeeze(sim_pos(:, i, :)); 
    dist = sqrt(sum(pos_body.^2, 2));
    semilogy(time_days, dist, 'LineWidth', 1.5, 'DisplayName', names{i});
end

xlabel('Timp (Zile)'); ylabel('Distanta (m) [Log]');
title('Distanta fata de Soare');
legend('Location', 'bestoutside');
