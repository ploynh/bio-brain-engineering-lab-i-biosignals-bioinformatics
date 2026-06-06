tspan = [0 10];
y0 = [0 0 0];

%% kz6 = 1
ode = @(t,y) mapk_cascade_model(t,y,1);
[t,y] = ode45(ode, tspan, y0)

figure;
subplot(1,3,1)
plot(t,y(:,1))
hold on;
plot(t,y(:,2))
hold on;
plot(t,y(:,3))

xlabel('Time')
ylabel('Concentration')
ylim([0 1])
legend('X-P','Y-P','Z-P')

%% kz6 = 10
ode = @(t,y) mapk_cascade_model(t,y,10);
[t,y] = ode45(ode, tspan, y0)

subplot(1,3,2)
plot(t,y(:,1))
hold on;
plot(t,y(:,2))
hold on;
plot(t,y(:,3))

xlabel('Time')
ylabel('Concentration')
ylim([0 1])
legend('X-P','Y-P','Z-P')

%% kz6 = 100
ode = @(t,y) mapk_cascade_model(t,y,100);
[t,y] = ode45(ode, tspan, y0)

subplot(1,3,3)
plot(t,y(:,1))
hold on;
plot(t,y(:,2))
hold on;
plot(t,y(:,3))

xlabel('Time')
ylabel('Concentration')
ylim([0 1])
legend('X-P','Y-P','Z-P')
