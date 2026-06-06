lab_dir = fileparts(fileparts(fileparts(mfilename('fullpath'))));
filename = fullfile(lab_dir, 'Mainlab_materials', 'MAPK_model', 'parameters.txt');
file = fopen(filename, 'r');
paramsData = textscan(file, '%s = %f;');
params = paramsData{2};
params = params(params <= 15);
fclose(file);

tspan = [0 5000];
y0 = [0 0 0 0 0];
ode = @(t,y) MAPK_model(t,y,params);
[t,y] = ode45(ode, tspan, y0)

figure
plot(t, y(:,5),t,y(:,3),t,y(:,1))
xlabel('Time')
ylabel('Concentration')
title('MAPK pathway simulation 1')
ylim([0 300])
legend('MAPK-PP', 'MKK-PP', 'MKKK-P');
