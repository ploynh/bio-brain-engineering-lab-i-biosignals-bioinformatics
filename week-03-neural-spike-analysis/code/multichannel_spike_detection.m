% Mainlab 3 Part 4.1
% Mainlab 3 Part 4.2
%% Unfiltered + Filtered
clear; clc;
close all;
% Write your code
%%%%%
lab_dir = fileparts(fileparts(mfilename('fullpath')));
raw_data = readmatrix(fullfile(lab_dir, 'main data', 'Experiment_4.txt'));
time = raw_data(:,1);
unfiltered_signal = [];
for i = 2:11
    unfiltered_signal =  [unfiltered_signal,raw_data(:,i)] ;
end
sampling_interval = time(2) - time(1); % (ms)
sampling_freq = 1 / (sampling_interval * 1e-3); % (Hz)
[B, A] = butter(2, 200/(sampling_freq/2), 'high');
filtered_signal = filter (B,A, unfiltered_signal);
%%%%%
figure
for i = 1:10
    subplot (5,2,i);
    plot(time, unfiltered_signal(:,i), 'Color', [0 0.4470 0.7410]);
    hold on
    plot(time, filtered_signal(:,i), 'Color', [1 0 0]);
    xlabel('Time (ms)');
    ylabel('Amplitude (\muV)');
    title('Ch', int2str(i));
end
sgtitle("Filtered and Unfiltered", fontsize=15)
%% Threshold
threshold_all =[];
for i = 1:10
    threshold = mean(filtered_signal(:,i)) - 5 * std(filtered_signal(:,i));
    threshold_all = [threshold_all, threshold];
end
%%%%%
figure, hold on;
for i = 1:10
    subplot (5,2,i);
    plot(time, filtered_signal(:,i), 'Color', [1 0 0]);
    hold on
    plot(time, repmat(threshold_all(i), length(time), 1), 'Color', [0 0 0]);
    xlabel('Time (ms)');
    ylabel('Amplitude (\muV)');
    title('Ch', int2str(i));
end
sgtitle("Filtered and Threshold mark", fontsize=15)
%% Spike Train
%%%%%
figure, hold on;
for i = 1:10
    [peak_value,peak_time] = findpeaks(-filtered_signal(:,i), time,'MinPeakHeight', - threshold_all (1,i));
    plot([peak_time,peak_time], [i-0.4 i+0.4] , 'Color', [0 0 0]);
    hold on
end
yticks([0:1:11]);
ylim ([0.5 10.5]);
ytickformat('Ch.%d');
xlabel('Time (ms)');
ylabel('Channel');
set ( gca, 'ydir', 'reverse' );
title('Raster Plot');
%%%%%
%% Histogram
peak_time_all = [];
for i = 1:10
    [peak_value,peak_time] = findpeaks(-filtered_signal(:,i), time,'MinPeakHeight', - threshold_all (1,i));
    s = size(peak_time_all); z = size(peak_time);% (find size of both)
    if z(1) > s(1)
        peak_time_all=[peak_time_all ;zeros(z(1)-s(1),s(2))]; % concatenate the smaller with zeros
    end
    if z(1) < s(1)
        peak_time=[peak_time ;zeros(s(1)-z(1), 1)];
    end
    peak_time_all = [peak_time_all,peak_time];
end
% Spike rate = # of spike / time 
peak_time_all(peak_time_all == 0) = NaN;
%%
disp('Mean Spike Rate')
for i = 1:10
    [peak_value,peak_time] = findpeaks(-filtered_signal(:,i), time,'MinPeakHeight', - threshold_all (1,i));
    spike_rate = 1000* size(peak_value)/(time(end)-time(1));
    SR = ['Channel ',num2str(i) ,': ', num2str(spike_rate(1)), ' times/s'];
    disp(SR)
end
%%
figure
for i = 1:10
    subplot (5,2,i);
    histogram(peak_time_all(:,i), 'BinWidth', 100);
    title('Ch',i);
    xlabel('Time (ms)');
    hold on
end
sgtitle("Spike rate histogram with 0.1 s bin size", fontsize=15)
figure
for i = 1:10
    subplot (5,2,i);
    histogram(peak_time_all(:,i), 'BinWidth', 1000);
    title('Ch',i);
    xlabel('Time (ms)');
    hold on
end
sgtitle("Spike rate histogram with 1 s bin size", fontsize=15)
figure
for i = 1:10
    subplot (5,2,i);
    histogram(peak_time_all(:,i), 'BinWidth', 10000);
    title('Ch',i);
    xlabel('Time (ms)');
    hold on
end
sgtitle("Spike rate histogram with 10 s bin size", fontsize=15)
%%
peak_time__diff = diff(peak_time_all);
peak_time__diff(peak_time__diff == 0) = NaN;
figure
for i = 1:10
    subplot (5,2,i);
    histogram(peak_time__diff(:,i), 'BinWidth', 1);
    xlim([-10 1000]);
    title('Ch',i);
    xlabel('Time (ms)');
    hold on
end
sgtitle("ISI histogram with 1 ms bin size", fontsize=15)
figure
for i = 1:10
    subplot (5,2,i);
    histogram(peak_time__diff(:,i), 'BinWidth', 10);
    title('Ch',i);
    xlim([-10 1000]);
    xlabel('Time (ms)');
    hold on
end
sgtitle("ISI histogram with 10 ms bin size", fontsize=15)
figure
for i = 1:10
    subplot (5,2,i);
    histogram(peak_time__diff(:,i), 'BinWidth', 50);
    title('Ch',i);
    xlim([-10 1000]);
    xlabel('Time (ms)');
    hold on
end
sgtitle("ISI histogram with 50 ms bin size", fontsize=15)
figure
for i = 1:10
    subplot (5,2,i);
    histogram(peak_time__diff(:,i), 'BinWidth', 100);
    title('Ch',i);
    xlim([-10 1000]);
    xlabel('Time (ms)');
    hold on
end
sgtitle("ISI histogram with 100 ms bin size", fontsize=15)
