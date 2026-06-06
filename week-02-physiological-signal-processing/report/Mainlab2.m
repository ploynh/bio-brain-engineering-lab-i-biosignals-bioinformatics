% ECG analysis section
% EMG analysis section

filename1 = 'Exp2.xlsx';
file1 = readtable(filename1);

filename2 = 'Exp4.1.xlsx';
file2 = readtable(filename2);

ECG_time = file1{:,2};
ECG_value = file1{:,3};

EMG_time = file2{:,2};
EMG_value = file2{:,3};
Force_value =file2{:,4};
%%
%Plot ECG vs Time (Plot1)
figure;
plot(ECG_time,ECG_value)
title('ECG vs. Time');
xlabel('Time(sec)');
ylabel('Voltage(V)');
xlim([0,60])
%%
%Plot EMG vs Time (Plot2)
figure;
plot(EMG_time,EMG_value)
title('EMG vs. Time');
xlabel('Time(sec)');
ylabel('Voltage(V)');
%%
%Plot Force vs Time (Plot3)
figure;
plot(EMG_time,Force_value)
title('Force vs. Time');
xlabel('Time(sec)');
ylabel('Force');
%%
%Sub plot force and EMG (Plot4)
figure;
subplot(2,1,1);
plot(EMG_time,EMG_value)
title('EMG vs. Time');
xlabel('Time(sec)');
ylabel('Voltage(V)');

subplot (2,1,2);
plot(EMG_time,Force_value)
title('Force vs. Time');
xlabel('Time(sec)');
ylabel('Force');
%%
% Force and EMG Overlay (Plot5)
figure;
plotyy(EMG_time, EMG_value, EMG_time, Force_value)
title('EMG & Force Plotyy');
xlabel('Time(sec)');
%%
figure;
Force_plot = normalize(Force_value);
EMG_plot = normalize(EMG_value);
plot(EMG_time, EMG_plot)
hold on
plot(EMG_time, Force_plot)
hold off
legend('EMG','Force')
title('EMG & Force normalization');
xlabel('Time(sec)');
%%
%Find R Peak (Plot6)
figure;
plot(ECG_time,ECG_value);
title('Find datapoint >= treshold');
xlabel('Time (s)');
ylabel('ECG (V)');
xlim([60, 120]);
 
[peaks_value, peaks_timing] = findpeaks(ECG_value, ECG_time,'MinPeakHeight', 0.2, 'MinPeakDistance', 0.5);

hold on;
plot(peaks_timing, peaks_value, 'o');
hold on;
plot(ECG_time, 0.2 * ones(size(ECG_time)));

%%
%find QRS complex (Plot7)
index = [];
for i = 1:size(peaks_value)
    peaks_index = find(ECG_value == peaks_value(i));
    index = [index;peaks_index];
end
sum_QRS_value = zeros(1, 31);

figure
for i = 80:166 % Hint: How many QRS complexes you might get?
    QRS_timing = [index(i)-10:index(i)+20];
    % Hint: QRS complex lies in R peak-50ms ~ R peak+100ms
   % Beware of the difference between timing and index
    QRS_value = ECG_value(QRS_timing);
    % sum of QRS
    sum_QRS_value = sum_QRS_value + QRS_value;
    % If you specify the timing of QRS complex, it is easy to find QRS values.
    plot([-50:5:100],QRS_value,'g');
    hold on
end

sum_QRS_value = sum_QRS_value / 87; %87 Peaks in 80:166 interval
plot( [-50:5:100], sum_QRS_value, 'b');
xlabel('Time (msec)');
ylabel('Voltage (V)');
title('QRS complex waveform');
grid on 

%%
%Find Heart Rate (Plot8)

RRinterval = diff(peaks_timing);

heartrate_value = repmat(60, size(RRinterval))./RRinterval;

heartrate_time = 1:size(RRinterval);
heartrate_time = heartrate_time';

figure ;
plot(heartrate_time,heartrate_value)
title('Heart Rate vs. Time');
ylabel('Heart beat (bpm)');
xlabel('Time (sec.)');
xlim([80, 140]);
%%
% Heart Rate histogram (Plot9)
figure ;
histogram(heartrate_value(80:140))
title('Heart Rate');
ylabel('Count');
xlabel('Rate (bpm)');
%%
%EMG Analysis

rms_value = sqrt(movmean(EMG_value .^ 2, 10)); % 10ms window
rms_value = sqrt(movmean(EMG_value .^ 2, 100)); % 100ms window
rms_value = sqrt(movmean(EMG_value .^ 2, 1000)); % 1s window
%%
%Plot EMG Envelope (Plot10)

figure ;
plot(EMG_time,rms_value)
title('EMG Envelope (Window Size 10 ms) '); %Change title according to rms value
xlabel('Time (sec)');
ylabel('Voltage (V)');
%%
figure ;
plot(EMG_time,EMG_value)
hold on;
plot(EMG_time,rms_value,'r')
title('EMG Envelope (Window Size 10 ms) '); %Change title according to rms value
xlabel('Time (sec)');
ylabel('Voltage (V)');
hold off;
%Plot Force and EMG Envelope (Plot11)
figure;
Force_plot = normalize(Force_value);
rms_value = normalize(rms_value);
plot(EMG_time,Force_plot)
hold on;
plot(EMG_time,rms_value,'r')
title('Force and EMG Envelope (Window Size 10 ms) '); %Change title according to rms value
legend('Force','EMG')
xlabel('Time (sec)');
