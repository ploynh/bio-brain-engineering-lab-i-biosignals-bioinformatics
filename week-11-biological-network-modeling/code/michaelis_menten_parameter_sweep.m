% plot graph of X-P using ODE solver
% prelab 3.3.3
tspan=[0 20];
y0=[0];
figure;
ode = @(t,y) michaelis_menten_model(t,y,1,1);
[t,y]=ode45(ode, tspan, y0)
plot(t,y)
xlabel('Time')
ylabel('Concentration (X-P)')
title('Michaelis-Menten (Prelab 3.3.3)')

% prelab 3.3.4
% change I0
tspan = [0 20];
y0 = [0];
I0_values = 1:5
legend_labels_I = cell(1, length(I0_values));
figure;
for i = 1:length(I0_values)
    ii = I0_values(i);
    ode = @(t,y) michaelis_menten_model(t,y,ii,1);
    [t,y] = ode45(ode, tspan, y0)
    hold on;
    plot(t,y)
    legend_labels_I{i} = sprintf('I0 = %d', ii)
end
xlabel('Time')
ylabel('Concentration (X-P)')
title('Michaelis-Menten (Prelab 3.3.4)')
legend(legend_labels_I)

% change Y0
tspan = [0 20];
y0 = [0];
Y0_values = 1:5
legend_labels_Y = cell(1, length(Y0_values));
figure;
for i = 1:length(Y0_values)
    ii = Y0_values(i);
    ode = @(t,y) michaelis_menten_model(t,y,1,ii);
    [t,y] = ode45(ode, tspan, y0)
    hold on;
    plot(t,y)
    legend_labels_Y{i} = sprintf('Y0 = %d', ii)
end
xlabel('Time')
ylabel('Concentration (X-P)')
title('Michaelis-Menten (Prelab 3.3.4)')
legend(legend_labels_Y)

% change I0 and Y0
tspan = [0 20];
y0 = [0];
I0_values_13 = 2:3
Y0_values_13 = 1:3
for i = 1:length(I0_values_13)
    ii = I0_values_13(i);
    legend_labels_Y_13 = cell(1, length(Y0_values_13));
    figure;
    for j = 1:length(Y0_values_13)
        jj = Y0_values_13(j);
        ode = @(t,y) michaelis_menten_model(t,y,ii,jj);
        [t,y] = ode45(ode, tspan, y0)
        hold on;
        plot(t,y)
        legend_labels_Y_13{j} = sprintf('Y0 = %d', jj)
    end
    xlabel('Time')
    ylabel('Concentration (X-P)')
    title('Michaelis-Menten (Prelab 3.3.4), I0 = ' + string(ii))
    legend(legend_labels_Y_13)
end
