filename = 'Ex2_open_close_txt.txt';
delimiterIn = '\t';
headerlinesIn = 1;
[raw_data] = importdata(filename, delimiterIn, headerlinesIn);
Time=raw_data.data(:, 1);
rawLeftEEG=raw_data.data(:, 2);
rawRightEEG=raw_data.data(:, 3);
rawLeftAlpha=raw_data.data(:, 4);

%%
blinkTime = 28.635;
blinkMark = find(Time==blinkTime);
SampleF = 200;
Fs = SampleF;
SampleItv = 0.005;
ACFreq = [59 61];
EMGFreq = [60 99];

[B, A] = butter(6, ACFreq/(SampleF/2), 'stop');
LeftEEG = filter(B, A, rawLeftEEG);
RightEEG = filter(B, A, rawRightEEG);
[B, A] = butter(6, EMGFreq/(SampleF/2), 'stop');
LeftEEG = filter(B, A, LeftEEG);
RightEEG = filter(B, A, RightEEG);

%%
AlphaFreq = [8 13];
BetaFreq = [14 30];
ThetaFreq = [4 7];
[B, A] = butter(6, AlphaFreq/(SampleF/2), 'bandpass');
LeftAlpha = filter(B, A, LeftEEG);
RightAlpha = filter(B, A, RightEEG);
[B, A] = butter(6, BetaFreq/(SampleF/2), 'bandpass');
LeftBeta = filter(B, A, LeftEEG);
RightBeta = filter(B, A, RightEEG);
[B, A] = butter(6, ThetaFreq/(SampleF/2), 'bandpass');
LeftTheta = filter(B, A, LeftEEG);
RightTheta = filter(B, A, RightEEG);

open1 = 20.285;
open2 = 60.57;
open3 = 101.05;
close1 = 40.155;
close2 = 80.19;
close3 = 120.06;

open1Mark = find(Time==open1);
open2Mark = find(Time==open2);
open3Mark = find(Time==open3);
close1Mark = find(Time==close1);
close2Mark = find(Time==close2);
close3Mark = find(Time==close3);

%%
figure;
subplot(2, 1, 1);
hold on;
sgtitle("raw data vs 50-99Hz notch filter Left result");
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
figure, hold on;
plot(Time, LeftEEG, 'red');
blinkMarkLine = [220; -200];
plot([Time(open1Mark), Time(open1Mark)], blinkMarkLine, 'black');
plot([Time(open2Mark), Time(open2Mark)], blinkMarkLine, 'black');
plot([Time(open3Mark), Time(open3Mark)], blinkMarkLine, 'black');
plot([Time(close1Mark), Time(close1Mark)], blinkMarkLine, 'black');
plot([Time(close2Mark), Time(close2Mark)], blinkMarkLine, 'black');
plot([Time(close3Mark), Time(close3Mark)], blinkMarkLine, 'black');
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

%%
figure;
subplot(4, 2, 1);
hold on;
sgtitle("Exercise 2 result for first open period");
title("Left EEG signal");
first_open_period = [open1Mark:close1Mark];
plot(Time(first_open_period), LeftEEG(first_open_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 2);
hold on;
title("EEG fft");
[L, m] = size(Time(first_open_period));
target_signal_fft = fft(LeftEEG(first_open_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 3);
hold on;
title("Left Theta wave");
plot(Time(first_open_period), LeftTheta(first_open_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 4);
hold on;
title("Theta fft");
[L, m] = size(Time(first_open_period));
target_signal_fft = fft(LeftTheta(first_open_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 5);
hold on;
title("Left Alpha wave");
plot(Time(first_open_period), LeftAlpha(first_open_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 6);
hold on;
title("Alpha fft");
[L, m] = size(Time(first_open_period));
target_signal_fft = fft(LeftAlpha(first_open_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 7);
hold on;
title("Left Beta wave");
plot(Time(first_open_period), LeftBeta(first_open_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 8);
hold on;
title("Beta fft");
[L, m] = size(Time(first_open_period));
target_signal_fft = fft(LeftBeta(first_open_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

%%
figure;
subplot(4, 2, 1);
hold on;
sgtitle("Exercise 2 result for first close period");
title("Left EEG signal");
first_close_period = [close1Mark:open2Mark];
plot(Time(first_close_period), LeftEEG(first_close_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 2);
hold on;
title("EEG fft");
[L, m] = size(Time(first_close_period));
target_signal_fft = fft(LeftEEG(first_close_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 3);
hold on;
title("Left Theta wave");
plot(Time(first_close_period), LeftTheta(first_close_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 4);
hold on;
title("Theta fft");
[L, m] = size(Time(first_close_period));
target_signal_fft = fft(LeftTheta(first_close_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");


subplot(4, 2, 5);
hold on;
title("Left Alpha wave");
plot(Time(first_close_period), LeftAlpha(first_close_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 6);
hold on;
title("Alpha fft");
title("Alpha fft");
[L, m] = size(Time(first_close_period));
target_signal_fft = fft(LeftAlpha(first_close_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 7);
hold on;
title("Left Beta wave");
plot(Time(first_close_period), LeftBeta(first_close_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 8);
hold on;
title("Beta fft");
title("Beta fft");
[L, m] = size(Time(first_close_period));
target_signal_fft = fft(LeftBeta(first_close_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

%%
figure;
subplot(4, 2, 1);
hold on;
sgtitle("Exercise 2 result for second open period");
title("Left EEG signal");
second_open_period = [open2Mark:close2Mark];
plot(Time(second_open_period), LeftEEG(second_open_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 2);
hold on;
title("EEG signal fft");
[L, m] = size(Time(second_open_period));
target_signal_fft = fft(LeftEEG(second_open_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 3);
hold on;
title("Left Theta wave");
plot(Time(second_open_period), LeftTheta(second_open_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 4);
hold on;
title("Theta fft");
[L, m] = size(Time(second_open_period));
target_signal_fft = fft(LeftTheta(second_open_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 5);
hold on;
title("Left Alpha wave");
plot(Time(second_open_period), LeftAlpha(second_open_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 6);
title("Alpha fft");
hold on;
[L, m] = size(Time(second_open_period));
target_signal_fft = fft(LeftAlpha(second_open_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 7);
hold on;
title("Left Beta wave");
plot(Time(second_open_period), LeftBeta(second_open_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 8);
hold on;
title("Beta fft");
[L, m] = size(Time(second_open_period));
target_signal_fft = fft(LeftBeta(second_open_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

%%
figure;
subplot(4, 2, 1);
hold on;
sgtitle("Exercise 2 result for second closed period");
title("Left EEG signal");
second_close_period = [close2Mark:open3Mark];
plot(Time(second_close_period), LeftEEG(second_close_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 2);
hold on;
title("EEG signal fft");
[L, m] = size(Time(second_close_period));
target_signal_fft = fft(LeftEEG(second_close_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual = fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 3);
hold on;
title("Left Theta wave");
plot(Time(second_close_period), LeftTheta(second_close_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 4);
hold on;
title("Theta wave fft");
[L, m] = size(Time(second_close_period));
target_signal_fft = fft(LeftTheta(second_close_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 5);
hold on;
title("Left Alpha wave");
plot(Time(second_close_period), LeftAlpha(second_close_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 6);
hold on;
title("Alpha wave fft");
[L, m] = size(Time(second_close_period));
target_signal_fft = fft(LeftAlpha(second_close_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 7);
hold on;
title("Left Beta wave");
plot(Time(second_close_period), LeftBeta(second_close_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 8);
hold on;
title("Beta wave fft");
[L, m] = size(Time(second_close_period));
target_signal_fft = fft(LeftBeta(second_close_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

%%
figure;
subplot(4, 2, 1);
hold on;
sgtitle("Exercise 2 result for third open period");
title("Left EEG signal");
third_open_period = [open3Mark:close3Mark];
plot(Time(third_open_period), LeftEEG(third_open_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 2);
hold on;
title("EEG fft");
[L, m] = size(Time(third_open_period));
target_signal_fft = fft(LeftEEG(third_open_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 3);
hold on;
title("Left Theta wave");
plot(Time(third_open_period), LeftTheta(third_open_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 4);
hold on;
title("Theta fft");
[L, m] = size(Time(third_open_period));
target_signal_fft = fft(LeftTheta(third_open_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 5);
hold on;
title("Left Alpha wave");
plot(Time(third_open_period), LeftAlpha(third_open_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 6);
hold on;
title("Alpha fft");
[L, m] = size(Time(third_open_period));
target_signal_fft = fft(LeftAlpha(third_open_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 7);
hold on;
title("Left Beta wave");
plot(Time(third_open_period), LeftBeta(third_open_period));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 8);
hold on;
title("Beta fft");
[L, m] = size(Time(third_open_period));
target_signal_fft = fft(LeftBeta(third_open_period));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

%%
figure;
subplot(4, 2, 1);
hold on;
sgtitle("Exercise 2 result for third closed period");
title("Left EEG signal");
plot(Time(close3Mark:end), LeftEEG(close3Mark:end));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 2);
hold on;
title("EEG fft");
[L, m] = size(Time(close3Mark:end));
target_signal_fft = fft(LeftEEG(close3Mark:end));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual = fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 3);
hold on;
title("Left Theta wave");
plot(Time(close3Mark:end), LeftTheta(close3Mark:end));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 4);
hold on;
title("Theta fft");
[L, m] = size(Time(close3Mark:end));
target_signal_fft = fft(LeftTheta(close3Mark:end));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 5);
hold on;
title("Left Alpha wave");
plot(Time(close3Mark:end), LeftAlpha(close3Mark:end));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 6);
hold on;
title("Alpha fft");
[L, m] = size(Time(close3Mark:end));
target_signal_fft = fft(LeftAlpha(close3Mark:end));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");

subplot(4, 2, 7);
hold on;
title("Left Beta wave");
plot(Time(close3Mark:end), LeftBeta(close3Mark:end));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(4, 2, 8);
hold on;
title("Beta fft");
[L, m] = size(Time(close3Mark:end));
target_signal_fft = fft(LeftBeta(close3Mark:end));
target_signal_spectrum_dual = abs(target_signal_fft/L);
f = Fs*(-L/2:L/2-1)/L;
target_signal_spectrum_dual= fftshift(target_signal_spectrum_dual);
plot(f, target_signal_spectrum_dual);
xlabel("frequency (unit : Hz)");
ylabel("amplitude (unit : uV)");