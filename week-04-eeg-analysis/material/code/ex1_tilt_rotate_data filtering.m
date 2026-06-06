clear; clc;
close all;
%%%%%
%% 4.7.1 raw data processing
filename = 'Ex1_tilt_rotate_txt.txt';
raw_data = importdata(filename);

% tilt row [6107 8673]
% rotate row [11278 14196]
time_tilt = raw_data.data(6107:8673, 1);
time_rotate = raw_data.data(11278:14196, 1);

unfiltered_tilt_left = raw_data.data(6107:8673, 2);
unfiltered_tilt_right = raw_data.data(6107:8673, 3);
unfiltered_rotate_left = raw_data.data(11278:14196, 2);
unfiltered_rotate_right = raw_data.data(11278:14196, 3);

sampling_freq = 200; % 0.005 interval -> 200 Hz freq

ACfreq = [59, 61];
EMGfreq = [50, 99];
[B,A] = butter(6, ACfreq/(sampling_freq/2),'stop')
filtered_tilt_left = filter(B, A, unfiltered_tilt_left);
filtered_tilt_right = filter(B, A, unfiltered_tilt_right);
filtered_rotate_left = filter(B, A, unfiltered_rotate_left);
filtered_rotate_right = filter(B, A, unfiltered_rotate_right);
[B,A] = butter(6, EMGfreq/(sampling_freq/2),'stop')
filtered_tilt_left = filter(B, A, unfiltered_tilt_left);
filtered_tilt_right = filter(B, A, unfiltered_tilt_right);
filtered_rotate_left = filter(B, A, unfiltered_rotate_left);
filtered_rotate_right = filter(B, A, unfiltered_rotate_right);

% tilt time (30.525, 43.355)
% rotate time (56.38, 70.97)
%% Part 4.7.2
% raw alpha
unfiltered_tilt_left_alpha = raw_data.data(6107:8673, 4);
unfiltered_tilt_right_alpha = raw_data.data(6107:8673, 8);
unfiltered_rotate_left_alpha = raw_data.data(11278:14196, 4);
unfiltered_rotate_right_alpha = raw_data.data(11278:14196, 8);
% raw beta
unfiltered_tilt_left_beta = raw_data.data(6107:8673, 6);
unfiltered_tilt_right_beta = raw_data.data(6107:8673, 10);
unfiltered_rotate_left_beta = raw_data.data(11278:14196, 6);
unfiltered_rotate_right_beta = raw_data.data(11278:14196, 10);

% filtered alpha
Alphafreq = [8 13];
[C,D] = butter(6, Alphafreq/(sampling_freq/2),'bandpass')
filtered_tilt_left_alpha = filter(C, D, unfiltered_tilt_left);
filtered_tilt_right_alpha = filter(C, D, unfiltered_tilt_right);
filtered_rotate_left_alpha = filter(C, D, unfiltered_rotate_left);
filtered_rotate_right_alpha = filter(C, D, unfiltered_rotate_right);
% filtered beta
Betafreq = [14 30];
[C,D] = butter(6, Betafreq/(sampling_freq/2),'bandpass')
filtered_tilt_left_beta = filter(C, D, unfiltered_tilt_left);
filtered_tilt_right_beta = filter(C, D, unfiltered_tilt_right);
filtered_rotate_left_beta = filter(C, D, unfiltered_rotate_left);
filtered_rotate_right_beta = filter(C, D, unfiltered_rotate_right);
%filtered theta
Thetafreq = [4 7];
[C,D] = butter(6, Thetafreq/(sampling_freq/2),'bandpass')
filtered_tilt_left_theta = filter(C, D, unfiltered_tilt_left);
filtered_tilt_right_theta = filter(C, D, unfiltered_tilt_right);
filtered_rotate_left_theta = filter(C, D, unfiltered_rotate_left);
filtered_rotate_right_theta = filter(C, D, unfiltered_rotate_right);

% Plot 1 raw + filtered signal (tilt_rotate_left) [Alpha]
% Subplot 1 raw_tilt_left_alpha
figure
subplot(2,2,1);
plot(time_tilt, unfiltered_tilt_left_alpha,'Color',[1 0 0]);
xlim([30.525, 43.355])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Raw signal of tilting');
hold on;
% Subplot 2 filtered_tilt_left_alpha
subplot(2,2,3);
plot(time_tilt, filtered_tilt_left_alpha,'Color',[0 0 0]);
xlim([30.525, 43.355])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of tilting');
% Subplot 3 raw_rotate_left_alpha
subplot(2,2,2);
plot(time_rotate, unfiltered_rotate_left_alpha,'Color',[1 0 0]);
xlim([56.38, 70.97])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Raw signal of rotating');
hold on;
% Subplot 4 filtered_rotate_left_alpha
subplot(2,2,4);
plot(time_rotate, filtered_rotate_left_alpha,'Color',[0 0 0]);
xlim([56.38, 70.97])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of rotating');
sgtitle('Alpha band of left Hemisphere');

% Plot 2 raw + filtered signal (tilt_rotate_right) [Alpha]
% Subplot 1 raw_tilt_rigth_alpha
figure
subplot(2,2,1);
plot(time_tilt, unfiltered_tilt_right_alpha,'Color',[1 0 0]);
xlim([30.525, 43.355])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Raw signal of tilting');
hold on;
% Subplot 2 filtered_tilt_right_alpha
subplot(2,2,3);
plot(time_tilt, filtered_tilt_right_alpha,'Color',[0 0 0]);
xlim([30.525, 43.355])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of tilting');
% Subplot 3 raw_rotate_rigth_alpha
subplot(2,2,2);
plot(time_rotate, unfiltered_rotate_right_alpha,'Color',[1 0 0]);
xlim([56.38, 70.97])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Raw signal of rotating');
hold on;
% Subplot 4 filtered_rotate_right_alpha
subplot(2,2,4);
plot(time_rotate, filtered_rotate_right_alpha,'Color',[0 0 0]);
xlim([56.38, 70.97])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of rotating');
sgtitle('Alpha band of right Hemisphere');

% Plot 3 raw + filtered signal (tilt_rotate_left) [beta]
% Subplot 1 raw_tilt_left_beta
figure
subplot(2,2,1);
plot(time_tilt, unfiltered_tilt_left_beta,'Color',[1 0 0]);
xlim([30.525, 43.355])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Raw signal of tilting');
hold on;
% Subplot 2 filtered_tilt_left_beta
subplot(2,2,3);
plot(time_tilt, filtered_tilt_left_beta,'Color',[0 0 0]);
xlim([30.525, 43.355])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of tilting');
% Subplot 3 raw_rotate_left_beta
subplot(2,2,2);
plot(time_rotate, unfiltered_rotate_left_beta,'Color',[1 0 0]);
xlim([56.38, 70.97])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Raw signal of rotating');
hold on;
% Subplot 4 filtered_rotate_left_beta
subplot(2,2,4);
plot(time_rotate, filtered_rotate_left_beta,'Color',[0 0 0]);
xlim([56.38, 70.97])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of rotating');
sgtitle('Beta band of left Hemisphere');

% Plot 4 raw + filtered signal (tilt_rotate_right) [beta]
% Subplot 1 raw_tilt_rigth_beta
figure
subplot(2,2,1);
plot(time_tilt, unfiltered_tilt_right_beta,'Color',[1 0 0]);
xlim([30.525, 43.355])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Raw signal of tilting');
hold on;
% Subplot 2 filtered_tilt_right_beta
subplot(2,2,3);
plot(time_tilt, filtered_tilt_right_beta,'Color',[0 0 0]);
xlim([30.525, 43.355])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of tilting');
% Subplot 3 raw_rotate_rigth_beta
subplot(2,2,2);
plot(time_rotate, unfiltered_rotate_right_beta,'Color',[1 0 0]);
xlim([56.38, 70.97])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Raw signal of rotating');
hold on;
% Subplot 4 filtered_rotate_right_beta
subplot(2,2,4);
plot(time_rotate, filtered_rotate_right_beta,'Color',[0 0 0]);
xlim([56.38, 70.97])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of rotating');
sgtitle('Beta band of right Hemisphere');

% Plot 5 filtered signal (tilt_rotate_left) [Theta]
% Subplot 1 filtered signal (tilt_left) [Theta]
figure
subplot(2,2,1);
plot(time_tilt, filtered_tilt_left_theta,'Color',[0 0 0]);
xlim([30.525, 43.355])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of tilting');
hold on;
% Subplot 2 filtered signal (rotate_left) [Theta]
subplot(2,2,3);
plot(time_rotate, filtered_rotate_left_theta,'Color',[0 0 0]);
xlim([56.38, 70.975])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of rotating');
sgtitle('Theta band of left (left) and right (right) Hemispheres');
% Subplot 3 filtered signal (tilt_right) [Theta]
subplot(2,2,2);
plot(time_tilt, filtered_tilt_right_theta,'Color',[0 0 0]);
xlim([30.525, 43.355])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of tilting');
hold on;
% Subplot 4 filtered signal (rotate_right) [Theta]
subplot(2,2,4);
plot(time_rotate, filtered_rotate_right_theta,'Color',[0 0 0]);
xlim([56.38, 70.975])
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of rotating');