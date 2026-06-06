filename = 'Ex1_blink_txt.txt';
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

blinkTime = 30.650;
blinkMark = find(Time==blinkTime);
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
title("Left hemisphere before blink");
plot(Time(1:blinkMark), LeftEEG(1:blinkMark));

subplot(2, 1, 2);
hold on;
title("Left hemisphere after blink");
plot(Time(blinkMark:end), LeftEEG(blinkMark:end));

%%
figure;
subplot(2, 1, 1);
hold on;
title("Right hemisphere before blink");
plot(Time(1:blinkMark), RightEEG(1:blinkMark));

subplot(2, 1, 2);
hold on;
title("Right hemisphere after blink");
plot(Time(blinkMark:end), RightEEG(blinkMark:end));