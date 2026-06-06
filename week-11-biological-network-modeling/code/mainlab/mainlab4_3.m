lab_dir = fileparts(fileparts(fileparts(mfilename('fullpath'))));
filename = fullfile(lab_dir, 'Mainlab_materials', 'MAPK_model', 'parameters.txt');
file = fopen(filename, 'r');
paramsData = textscan(file, '%s = %f;');
params = paramsData{2};
params = params(params <= 15);
fclose(file);

%% original graph
tspan = [0 5000];
y0 = [0 0 0 0 0];
v1 = 0:0.1:3;

MAPK_PP = [];
MKK_PP = [];
MKKK_P = [];

for i = v1
    params(1) = i;
    ode = @(t,y) MAPK_model(t,y,params);
    [t,y] = ode45(ode, tspan, y0);
    midIndex = floor(size(y, 1) / 2) + 1;
    MAPK_PP = [MAPK_PP max(y(midIndex:end, 5))];
    MKK_PP = [MKK_PP max(y(midIndex:end, 3))];
    MKKK_P = [MKKK_P max(y(midIndex:end, 1))];
end

figure
plot(v1, MAPK_PP, v1, MKK_PP, v1, MKKK_P)
xlabel('input stimulus')
ylabel('steady-state concentration')
legend('MAPK-PP', 'MKK-PP', 'MKKK-P')
title('MAPK pathway simulation 1')

%% normalized graph
tspan = [0 5000];
y0 = [0 0 0 0 0];
v1 = 0:0.1:3;

MAPK_PP = [];
MKK_PP = [];
MKKK_P = [];

for i = v1
    params(1) = i;
    ode = @(t,y) MAPK_model(t,y,params);
    [t,y] = ode45(ode, tspan, y0)
    midIndex = floor(size(y, 1) / 2) + 1;
    MAPK_PP = [MAPK_PP max(y(midIndex:end, 5))];
    MKK_PP = [MKK_PP max(y(midIndex:end, 3))];
    MKKK_P = [MKKK_P max(y(midIndex:end, 1))];
end

figure
plot(v1, MAPK_PP./max(MAPK_PP), v1, MKK_PP./max(MKK_PP), v1, MKKK_P./max(MKKK_P))
xlabel('input stimulus')
ylabel('normalized steady-state concentration')
legend('MAPK-PP', 'MKK-PP', 'MKKK-P')
title('MAPK pathway simulation 1')
