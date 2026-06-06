clear; clc;
close all;

filename = 'Ex1_smile_txt.txt';
delimiterIn = '\t';
headerlinesIn = 1;
[raw_data] = importdata(filename, delimiterIn, headerlinesIn);
Time=raw_data.data(:, 1);
rawLeftEEG=raw_data.data(:, 2);
rawRightEEG=raw_data.data(:, 3);
rawLeftAlpha=raw_data.data(:, 4);
rawLeftAlphaF=raw_data.data(:, 5);
rawLeftBeta=raw_data.data(:, 6);
rawLeftBetaF=raw_data.data(:, 7);
rawRightAlpha=raw_data.data(:, 8);
rawRightAlphaF=raw_data.data(:, 9);
rawRightBeta=raw_data.data(:, 10);
rawRightBetaF=raw_data.data(:, 11);

smileTime = 30.695;
smileMark = find(Time == smileTime);
SampleF = 200;
SampleItv = 0.005;
ACFreq = [59 61];
EMGFreq = [50 99];

[B, A] = butter(6, ACFreq/(SampleF/2), 'stop');
LeftEEG = filter(B, A, rawLeftEEG);
RightEEG = filter(B, A, rawRightEEG);
[B, A] = butter(6, EMGFreq/(SampleF/2), 'stop');
LeftEEG = filter(B, A, LeftEEG);
RightEEG = filter(B, A, RightEEG);

%%
figure;
subplot(2, 1, 1);
hold on;
sgtitle("raw data vs 50-99Hz notch filter Left EEG result");
title('raw data');
plot(Time, rawLeftEEG, 'blue');
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(2, 1, 2);
hold on;
title('50-99Hz notch filtered data');
plot(Time, LeftEEG, 'red');
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');
%%
figure;
subplot(2, 1, 1);
hold on;
sgtitle("raw data vs 50-99Hz notch filter Right EEG result");
title('raw data');
plot(Time, rawRightEEG, 'blue');
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(2, 1, 2);
hold on;
title('50-99Hz notch filtered data');
plot(Time, RightEEG, 'red');
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');
%%
figure;
subplot(2, 1, 1);
hold on;
sgtitle("Left hemisphere");
title('Left hemisphere before smile');
plot(Time(1:smileMark), LeftEEG(1:smileMark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(2, 1, 2);
hold on;
title('Left hemisphere after smile');
plot(Time(smileMark:end), LeftEEG(smileMark:end));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');


%%
figure;
subplot(2, 1, 1);
hold on;
sgtitle('Right hemisphere');
title('Right hemisphere before smile');
plot(Time(1:smileMark), RightEEG(1:smileMark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(2, 1, 2);
hold on;
title('Right hemisphere after smile');
plot(Time(smileMark:end), RightEEG(smileMark:end));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

%% Digital filtering
% filtered alpha
Alphafreq = [8 13];
[C,D] = butter(6, Alphafreq/(SampleF/2),'bandpass')
filtered_smile_left_alpha = filter(C, D, rawLeftEEG);
filtered_smile_right_alpha = filter(C, D, rawRightEEG);
% filtered beta
Betafreq = [14 30];
[C,D] = butter(6, Betafreq/(SampleF/2),'bandpass')
filtered_smile_left_beta = filter(C, D, rawLeftEEG);
filtered_smile_right_beta = filter(C, D, rawRightEEG);
%filtered theta
Thetafreq = [4 7];
[C,D] = butter(6, Thetafreq/(SampleF/2),'bandpass')
filtered_smile_left_theta = filter(C, D, rawLeftEEG);
filtered_smile_right_theta = filter(C, D, rawRightEEG);

% Plot 5 raw + filtered signal (smile_left_right) [Alpha]
% Subplot 1 raw_smile_left_alpha
figure
subplot(2,2,1);
plot(Time, rawLeftAlpha,'Color',[1 0 0]);
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Raw signal of smiling');
hold on;
% Subplot 2 filtered_smile_left_alpha
subplot(2,2,3);
plot(Time, filtered_smile_left_alpha,'Color',[0 0 0]);
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of smiling');
% Subplot 3 raw_smile_right_alpha
subplot(2,2,2);
plot(Time, rawRightAlpha,'Color',[1 0 0]);
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Raw signal of smiling');
hold on;
% Subplot 4 filtered_smile_right_alpha
subplot(2,2,4);
plot(Time, filtered_smile_right_alpha,'Color',[0 0 0]);
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of smiling');
sgtitle('Alpha band of left (left) and right (right) Hemispheres');

% Plot 6 raw + filtered signal (smile_left_right) [beta]
% Subplot 1 raw_smile_left_beta
figure
subplot(2,2,1);
plot(Time, rawLeftBeta,'Color',[1 0 0]);
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Raw signal of smiling');
hold on;
% Subplot 2 filtered_smile_left_beta
subplot(2,2,3);
plot(Time, filtered_smile_left_beta,'Color',[0 0 0]);
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of smiling');
% Subplot 3 raw_smile_right_beta
subplot(2,2,2);
plot(Time, rawRightBeta,'Color',[1 0 0]);
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Raw signal of smiling');
hold on;
% Subplot 4 filtered_smile_right_beta
subplot(2,2,4);
plot(Time, filtered_smile_right_beta,'Color',[0 0 0]);
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Filtered signal of smiling');
sgtitle('Beta band of left (left) and right (right) Hemispheres');

% Plot 7 filtered signal (smile_left_right) [Theta]
% Subplot 1 filtered signal (smile_left) [Theta]
figure
subplot(2,1,1);
plot(Time, filtered_smile_left_theta,'Color',[0 0 0]);
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Left hemisphere');
hold on;
% Subplot 2 filtered signal (smile_right) [Theta]
subplot(2,1,2);
plot(Time, filtered_smile_right_theta,'Color',[0 0 0]);
xlabel('Time (s)');
ylabel('Amplitude (\muV)');
title('Right hemisphere');
sgtitle('Theta band of smiling');







