% ex1_plotare
% Script pentru vizualizarea rezultatelor 

% 1.
if exist('out', 'var')
    try
        % Incercam acces direct la proprietate
        sim_pos = out.sim_pos; 
        if isprop(out, 'tout')
            tout = out.tout;
        else
            % Uneori timpul e salvat altfel sau deloc in structura
            tout = 1:size(sim_pos, 3); 
        end
        disp('Date extrase din out.sim_pos.');
    catch
        % Daca out e structura simpla, nu SimulationOutput
         if isfield(out, 'sim_pos')
            sim_pos = out.sim_pos;
         else
             try
                 sim_pos = out.get('sim_pos');
             catch
                 error('Nu pot gasi sim_pos in out. Verifica numele variabilei in Simulink (To Workspace).');
             end
         end
    end
elseif exist('sim_pos', 'var')
    disp('Folosesc variabila sim_pos din Workspace.');
else
    error('Nu gasesc variabila out sau sim_pos.');
end

% 2. Procesare Dimensiuni
dims = size(sim_pos);
disp(['Dimensiuni raw: ' num2str(dims)]);

if length(dims) == 3 && dims(1) == 3 && dims(2) == 9
    disp('Format detectat: [3 x 9 x Time]');
    % X_raw va fi [9 x Time] -> Transpus [Time x 9]
    X = squeeze(sim_pos(1, :, :))'; 
    Y = squeeze(sim_pos(2, :, :))';
    Z = squeeze(sim_pos(3, :, :))';
    
elseif length(dims) == 3 && dims(2) == 3 && dims(3) == 9
    % Format: [Time x 3 x 9]
    disp('Format detectat: [Time x 3 x 9]');
    X = squeeze(sim_pos(:, 1, :));
    Y = squeeze(sim_pos(:, 2, :));
    Z = squeeze(sim_pos(:, 3, :));
    
elseif length(dims) == 2
    if dims(2) == 27
        disp('Format detectat: [Time x 27]');
        X = sim_pos(:, 1:3:end);
        Y = sim_pos(:, 2:3:end);
        Z = sim_pos(:, 3:3:end);
    else
        %[27 x Time]
        if dims(1) == 27
             disp('Format detectat: [27 x Time]');
             sim_pos = sim_pos';
             X = sim_pos(:, 1:3:end);
             Y = sim_pos(:, 2:3:end);
             Z = sim_pos(:, 3:3:end);
        else
             error('Format nerecunoscut. Verifica dimensiunile.');
        end
    end
else
    error('Format ciudat al datelor.');
end

% 3. Plotare
figure('Name', 'Rezultate Simulare', 'Color', 'k');
hold on; axis equal; grid on; view(3);
set(gca, 'Color', 'k', 'XColor', 'w', 'YColor', 'w', 'ZColor', 'w');
xlabel('X (m)'); ylabel('Y (m)'); zlabel('Z (m)');

colors = [
    1 1 0;       % Soare
    0.7 0.7 0.7; % Mercur
    0.9 0.8 0.2; % Venus
    0 0 1;       % Pamant
    1 0 0;       % Marte
    0.8 0.5 0.2; % Jupiter
    0.9 0.8 0.5; % Saturn
    0 0.8 0.8;   % Uranus
    0 0 0.5;     % Neptun
];
names = {'Soare', 'Mercur', 'Venus', 'Pamant', 'Marte', 'Jupiter', 'Saturn', 'Uranus', 'Neptun'};

for i = 1:9
    plot3(X(:,i), Y(:,i), Z(:,i), '-', 'Color', colors(i,:), 'LineWidth', 1.5);
    plot3(X(end,i), Y(end,i), Z(end,i), 'o', 'Color', colors(i,:), 'MarkerFaceColor', colors(i,:), 'MarkerSize', 6);
    % Folosim time din sim_pos ultima dimensiune
    text(X(end,i), Y(end,i), Z(end,i), ['  ' names{i}], 'Color', 'w');
end

title('Sistem Solar (88 Zile)', 'Color', 'w');
disp('Done.');
