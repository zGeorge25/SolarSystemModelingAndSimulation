% ex2_animatie.m
% Cerinta 2: Animatie 3D si Traiectorii (Orbite)
% Configureaza vizualizarea pentru a corespunde modelului de referinta

% 1. Recuperare si Pregatire Date
if exist('out', 'var') && isfield(out, 'sim_pos')
    sim_data = out.sim_pos;
    if isprop(out, 'tout'), time_vec = out.tout; else, time_vec = linspace(0, 88*24*3600, size(sim_data, 3)); end
elseif exist('sim_pos', 'var')
    sim_data = sim_pos;
    if exist('tout', 'var'), time_vec = tout; else, time_vec = linspace(0, 88*24*3600, size(sim_data, 3)); end
else
    error('Nu gasesc variabila "sim_pos" sau "out". Ruleaza simularea mai intai!');
end

% Asiguram formatul [Timp x Coordonate x Corpuri]
if size(sim_data, 1) == 3 && size(sim_data, 2) == 9
    sim_pos_final = permute(sim_data, [3 1 2]); 
else
    sim_pos_final = sim_data; 
end

[nSteps, ~, nBodies] = size(sim_pos_final);

% 2. Configurare Vizuala
fig = figure('Name', 'Cerinta 2: Animatie Sistem Solar', 'Color', 'k', 'Units', 'normalized', 'Position', [0.1 0.1 0.8 0.8]);
ax = axes('Parent', fig, 'Color', 'k', 'XColor', 'w', 'YColor', 'w', 'ZColor', 'w');
grid(ax, 'on'); hold(ax, 'on'); axis(ax, 'equal');
view(ax, 45, 30); % Unghi 3D similar cu imaginea

xlabel(ax, 'X (m)', 'Color', 'w'); 
ylabel(ax, 'Y (m)', 'Color', 'w'); 
zlabel(ax, 'Z (m)', 'Color', 'w');
title(ax, 'Simularea Sistemului Solar - 88 Zile', 'Color', 'w', 'FontSize', 14);

% Culori specifice pentru planete
colors = [
    1.0 0.9 0.0; % Soare (Galben stralucitor)
    0.6 0.6 0.6; % Mercur (Gri)
    1.0 0.7 0.2; % Venus (Portocaliu)
    0.0 0.5 1.0; % Pamant (Albastru)
    1.0 0.2 0.0; % Marte (Rosu)
    0.8 0.6 0.4; % Jupiter (Maro deschis)
    0.9 0.8 0.5; % Saturn (Auriu)
    0.5 0.9 1.0; % Uranus (Cyan)
    0.2 0.2 0.8  % Neptun (Albastru inchis)
];
names = {'Soare', 'Mercur', 'Venus', 'Pamant', 'Marte', 'Jupiter', 'Saturn', 'Uranus', 'Neptun'};

% 3. Initializare Obiecte Grafice
head_markers = gobjects(1, nBodies);
tails = gobjects(1, nBodies);

for i = 1:nBodies
    % Orbitele (Liniile)
    tails(i) = plot3(ax, NaN, NaN, NaN, '-', 'Color', colors(i,:), 'LineWidth', 1.2, 'DisplayName', names{i});
    
    % Corpul ceresc (Marker-ul)
    mSize = 8;
    if i == 1, mSize = 25; end % Soarele este mult mai mare
    
    head_markers(i) = plot3(ax, NaN, NaN, NaN, 'o', 'Color', colors(i,:), ...
                            'MarkerFaceColor', colors(i,:), 'MarkerSize', mSize, 'HandleVisibility', 'off');
end

% Adaugare Legenda
lgd = legend(ax, tails, 'TextColor', 'w', 'Color', 'none', 'Location', 'northeastoutside');

% 4. Bucla de Animatie
target_frames = 150; 
step_skip = max(1, floor(nSteps / target_frames));

for k = 1:step_skip:nSteps
    if ~ishandle(fig), break; end
    
    for i = 1:nBodies
        % Update Traiectorie
        set(tails(i), 'XData', sim_pos_final(1:k, 1, i), ...
                      'YData', sim_pos_final(1:k, 2, i), ...
                      'ZData', sim_pos_final(1:k, 3, i));
        
        % Update Pozitie Planeta
        set(head_markers(i), 'XData', sim_pos_final(k, 1, i), ...
                             'YData', sim_pos_final(k, 2, i), ...
                             'ZData', sim_pos_final(k, 3, i));
    end
    
    % Update zi in titlu
    day = time_vec(k) / (24*3600);
    title(ax, sprintf('Simularea Sistemului Solar - Ziua: %.1f', day), 'Color', 'w');
    
    drawnow limitrate;
end