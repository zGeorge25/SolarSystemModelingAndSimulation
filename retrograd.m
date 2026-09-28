% ex4_retrograd.m
% Cerinta 4: Miscarea retrograda aparenta a lui Mercur

if ~exist('out', 'var'), error('Ruleaza simularea!'); end
sim_pos = out.sim_pos;
if size(sim_pos,1) == 3, sim_pos = permute(sim_pos, [3 2 1]); end

% Indici: Mercur=2, Pamant=4
r_mercury = squeeze(sim_pos(:, 2, :)); 
r_earth   = squeeze(sim_pos(:, 4, :)); 

% 1. Pozitie Relativa
r_rel = r_mercury - r_earth;
x = r_rel(:, 1); y = r_rel(:, 2); z = r_rel(:, 3);
r_norm = sqrt(x.^2 + y.^2 + z.^2);

% 2. Coordonate Ecliptice
lambda = rad2deg(atan2(y, x)); % Longitudine
beta = rad2deg(asin(z ./ r_norm)); % Latitudine

figure('Name', 'Cerinta 4: Miscare Retrograda', 'Color', 'w');
plot(lambda, beta, 'b.-', 'LineWidth', 1);
grid on;
xlabel('Longitudine Ecliptica \lambda (grade)');
ylabel('Latitudine Ecliptica \beta (grade)');
title('Traiectoria aparenta a lui Mercur (vazut de pe Pamant)');
text(lambda(1), beta(1), 'START', 'Color', 'g', 'FontWeight', 'bold');
text(lambda(end), beta(end), 'STOP', 'Color', 'r', 'FontWeight', 'bold');