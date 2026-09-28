% ex6_validare.m
% Cerinta 6: Calcul eroare fata de JPL Horizons la t_final (88 zile)

% Pozitii de Referinta la t = 88 zile (Target Data)
% (Acestea ar trebui sa fie datele JPL Horizons pentru data 2026-Apr-05 aprox)
P_ref_final = [
    -3.595279E+08, -1.379920E+10, 4.261669E+10, -1.449918E+11, 1.964695E+11, -3.528243E+11, 1.413248E+12, 1.429274E+12, 4.467078E+12;
    -8.189153E+08, -6.918500E+10, 9.814043E+10, -3.918184E+10, -6.374734E+10, 7.003083E+11, 1.158858E+11, 2.537432E+12, 1.211984E+11;
    1.774500E+07, -4.336689E+09, -1.102395E+09, 2.126453E+07, -6.127409E+09, 4.991137E+09, -5.828470E+10, -9.092706E+09, -1.054443E+11
];

if ~exist('out', 'var'), error('Ruleaza simularea!'); end
sim_data = out.sim_pos;
if size(sim_data,1)==3, sim_data = permute(sim_data, [3 2 1]); end

% Ultima pozitie din simulare
P_sim_final = squeeze(sim_data(end, :, :))';

% Calcul Erori
err_abs = sqrt(sum((P_sim_final - P_ref_final).^2, 1));

disp('------------------------------------------------');
disp('   CERINTA 6: VALIDARE REZULTATE (t=88 zile)    ');
disp('------------------------------------------------');
fprintf('%-10s %-15s %-15s\n', 'Corp', 'Eroare (km)', 'Eroare Rel (%)');

for i = 1:9
    dist_ref = norm(P_ref_final(:,i));
    err_rel = (err_abs(i) / dist_ref) * 100;
    fprintf('%-10s %-15.2f %-15.6f\n', names{i}, err_abs(i)/1000, err_rel);
end