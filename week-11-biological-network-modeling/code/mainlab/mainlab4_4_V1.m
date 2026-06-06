lab_dir = fileparts(fileparts(fileparts(mfilename('fullpath'))));
filename = fullfile(lab_dir, 'Mainlab_materials', 'MAPK_model', 'parameters.txt');
file = fopen(filename, 'r');
paramsData = textscan(file, '%s = %f;');
params = paramsData{2};
params = params(params <= 15);
fclose(file);

tspan = [0 5000];
y0 = [0 0 0 0 0];
v1 = -10:0.1:10;
log_v1 = 2.^v1;

MAPK_PP_max = [];
MAPK_PP_min = [];

for i = log_v1
    params(1) = i;
    ode = @(t,y) MAPK_model(t,y,params);
    [t,y] = ode45(ode, tspan, y0)
    t_find = find(t > 2000);
    MAPK_PP_max = [MAPK_PP_max max(y(t_find, 5))];
    MAPK_PP_min = [MAPK_PP_min min(y(t_find, 5))];
end

figure
semilogx(log_v1, MAPK_PP_max, log_v1, MAPK_PP_min)
xlabel('parameter V1 (log scale)')
ylabel('steady-state concentration')
set(gca,'Xticklabel',[])
legend('Max', 'Min');
title('MAPK pathway simulation 3')
