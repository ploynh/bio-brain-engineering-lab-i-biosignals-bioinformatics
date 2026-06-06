filename = 'Ex1_tilt_rotate_txt.txt';
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

LtiltTime = 31.035;
rest1Time = 45.79;
RtiltTime = 60.540;
rest2Time = 80.38;
ClkRtTime = 96.03;
rest3Time = 111.61;
CClkRtTime = 128.635;
rest4Time = 141.21;

LtiltMark = find(Time==LtiltTime);
rest1Mark = find(Time==rest1Time);
RtiltMark = find(Time==RtiltTime);
rest2Mark = find(Time==rest2Time);
ClkRtMark = find(Time==ClkRtTime);
rest3Mark = find(Time==rest3Time);
CClkRtMark = find(Time==CClkRtTime);
rest4Mark = find(Time==rest4Time);

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
subplot(2, 1, 1);
hold on;
sgtitle("EEG in initial state");
title("Left EEG");
plot(Time(1:LtiltMark), LeftEEG(1:LtiltMark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(2, 1, 2);
title("Right EEG");
plot(Time(1:LtiltMark), RightEEG(1:LtiltMark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');
%%
figure, hold on;
subplot(2, 1, 1);
hold on;
sgtitle("EEG in left tilt");
title("Left EEG");
plot(Time(LtiltMark:rest1Mark), LeftEEG(LtiltMark:rest1Mark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(2, 1, 2);
title("Right EEG");
plot(Time(LtiltMark:rest1Mark), RightEEG(LtiltMark:rest1Mark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');
%%
figure, hold on;
subplot(2, 1, 1);
hold on;
sgtitle("EEG in 1st rest");
title("Left EEG");
plot(Time(rest1Mark:RtiltMark), LeftEEG(rest1Mark:RtiltMark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(2, 1, 2);
title("Right EEG");
plot(Time(rest1Mark:RtiltMark), RightEEG(rest1Mark:RtiltMark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');
%%
figure, hold on;
subplot(2, 1, 1);
hold on;
sgtitle("EEG in right tilt");
title("Left EEG");
plot(Time(RtiltMark:rest2Mark), LeftEEG(RtiltMark:rest2Mark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(2, 1, 2);
title("Right EEG");
plot(Time(RtiltMark:rest2Mark), RightEEG(RtiltMark:rest2Mark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');
%%
figure, hold on;
subplot(2, 1, 1);
hold on;
sgtitle("EEG in 2nd rest");
title("Left EEG");
plot(Time(rest2Mark:ClkRtMark), LeftEEG(rest2Mark:ClkRtMark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(2, 1, 2);
title("Right EEG");
plot(Time(rest2Mark:ClkRtMark), RightEEG(rest2Mark:ClkRtMark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');
%%
figure, hold on;
subplot(2, 1, 1);
hold on;
sgtitle("EEG in clockwise rotate");
title("Left EEG");
plot(Time(ClkRtMark:rest3Mark), LeftEEG(ClkRtMark:rest3Mark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(2, 1, 2);
title("Right EEG");
plot(Time(ClkRtMark:rest3Mark), RightEEG(ClkRtMark:rest3Mark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');
%%
figure, hold on;
subplot(2, 1, 1);
hold on;
sgtitle("EEG in 3rd rest");
title("Left EEG");
plot(Time(rest3Mark:CClkRtMark), LeftEEG(rest3Mark:CClkRtMark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(2, 1, 2);
title("Right EEG");
plot(Time(rest3Mark:CClkRtMark), RightEEG(rest3Mark:CClkRtMark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');
%%
figure, hold on;
subplot(2, 1, 1);
hold on;
sgtitle("EEG in counterclockwise rotate");
title("Left EEG");
plot(Time(CClkRtMark:rest4Mark), LeftEEG(CClkRtMark:rest4Mark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(2, 1, 2);
title("Right EEG");
plot(Time(CClkRtMark:rest4Mark), RightEEG(CClkRtMark:rest4Mark));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');
%%
figure, hold on;
subplot(2, 1, 1);
hold on;
sgtitle("EEG in 4th rest");
title("Left EEG");
plot(Time(rest4Mark:end), LeftEEG(rest4Mark:end));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');

subplot(2, 1, 2);
title("Right EEG");
plot(Time(rest4Mark:end), RightEEG(rest4Mark:end));
xlabel('Time (unit : s)');
ylabel('Amplitude (unit : uV)');


