filename = 'Ex3_mathquestion_txt.txt';
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

restTime = 0.35;
P1Time = 37.53;
A1Time = 55.165;
P2Time = 61.05;
A2Time = 67.805;

restMark = find(Time == restTime);
P1Mark = find(Time == P1Time);
A1Mark = find(Time == A1Time);
P2Mark = find(Time == P2Time);
A2Mark = find(Time == A2Time);

SampleF = 200;
Fs = SampleF;
SampleItv = 0.005;
ACFreq = [59 61];
EMGFreq = [50 99];
AlphaFreq = [8 13];
BetaFreq = [14 30];
ThetaFreq = [4 7];

[B, A] = butter(6, ACFreq/(SampleF/2), 'stop');
LeftEEG = filter(B, A, rawLeftEEG);
RightEEG = filter(B, A, rawRightEEG);
[B, A] = butter(6, EMGFreq/(SampleF/2), 'stop');
LeftEEG = filter(B, A, LeftEEG);
RightEEG = filter(B, A, RightEEG);

[B, A] = butter(6, AlphaFreq/(SampleF/2), 'bandpass');
LeftAlpha = filter(B, A, LeftEEG);
RightAlpha = filter(B, A, RightEEG);
[B, A] = butter(6, BetaFreq/(SampleF/2), 'bandpass');
LeftBeta = filter(B, A, LeftEEG);
RightBeta = filter(B, A, RightEEG);
[B, A] = butter(6, ThetaFreq/(SampleF/2), 'bandpass');
LeftTheta = filter(B, A, LeftEEG);
RightTheta = filter(B, A, RightEEG);

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
figure;
subplot(4, 2, 1);
hold on;
sgtitle("Exercise 2 result for initial rest state");
title("Left EEG signal");
first_open_period = [restMark:P1Mark];
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
sgtitle("Exercise 2 result for solving problem 1");
title("Left EEG signal");
first_open_period = [P1Mark:A1Mark];
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
sgtitle("Exercise 2 result for solving problem 2");
title("Left EEG signal");
first_open_period = [P2Mark:A2Mark];
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