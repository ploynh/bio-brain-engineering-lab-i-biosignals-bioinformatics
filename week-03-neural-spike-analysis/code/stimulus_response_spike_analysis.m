% Mainlab 3 Part 4.1
% Mainlab 3 Part 4.2
%%
clear; clc;
close all;
%% Part 4.2.2
filename = 'stim_13.5uA.txt';
raw_data = importdata(filename);

time = raw_data.data(:, 3);
unfiltered_signal = raw_data.data(:, (4:end));
filtered_signal = zeros(size(unfiltered_signal));

sampling_interval = time(2) - time(1); % ms
sampling_freq = 1 / (sampling_interval * 1e-3);
[B,A] = butter(2,200/(sampling_freq/2),'high');

for i = 1:3
    filtered_signal(:, i) = filter(B, A, unfiltered_signal(:, i));
end

% identify the locations of stimulation and trial
trial = [1];
stim = [];
i = 2;
j = 1;
for k = 2:size(time, 1)
    if raw_data.data(k, 1) ~= raw_data.data(k-1, 1)
       trial(i) = k;
       i = i+1;
    end
    
    if raw_data.data(k, 2) == raw_data.data(k, 3)
       stim(j) = k;
       j = j+1;
    end
end

% Plot 1 overlay graph of Ch 48 trial 1
figure
plot(time(1:trial(2)-1), unfiltered_signal(1:trial(2)-1, 2),'Color',[0 0.4470 0.7410]);
hold on
plot(time(1:trial(2)-1), filtered_signal(1:trial(2)-1, 2), 'Color', [1,0,0]);
legend('raw data', 'filtered data');
title('Trial 1 of Ch 48 at 13.5 uA stim level');
xlim([800 1000]);
xlabel('Time (ms)');
ylabel('Amplitude (\muV)');
hold on;
%% Part 4.2.3
channel = [36 48 56];

% Plot 2-4 evoked responses of channels 36, 48, and 56
for ch = 1:3 % three channels
    figure
    for i = 1:size(stim, 2)
        plot([-20:0.04:100], i-1+normalize(filtered_signal(stim(i)-500:stim(i)+2500, ch), 'range'), 'Color', [0,0,0]);
        hold on;
    end
    yticks([1:60]);
    ytickformat('Trial %d');
    ax = gca; 
    ax.FontSize = 4; 
    ylim([0.5 60.5]);
    set(gca,'Ydir','reverse')
    xlabel('Time (ms)', FontSize = 10);
    ylabel('Trial', FontSize = 10);
    title('Evoked response for each trial at 13.5 uA stim level for Ch', channel(ch), FontSize = 10);
end
%% Part 4.2.4

% Plot 5-7 spike point detection for channels 36, 48, and 56
for ch = 1:3 % three channels
    figure
    threshold = mean(filtered_signal(stim(:)+125:stim(:)+2500, ch))-5*std(filtered_signal(stim(:)+125:stim(:)+2500, ch));
    for i = 1:size(stim, 2)
        normalized_data = normalize(filtered_signal(stim(i)-500:stim(i)+2500, ch), 'range');
        plot([-20:0.04:100], i-1+normalized_data, 'Color', [0,0,0]);
        hold on;
        [peak_value,peak_timing] = findpeaks(-1*filtered_signal(stim(i)+125:stim(i)+2500, ch), 'MinPeakHeight', -1*threshold, 'MinPeakDistance', 70);
        plot(5 + (0.04*(peak_timing-1)),i-1+normalized_data(peak_timing+625),'ro');
        hold on;
    end
    yticks([1:60]);
    ytickformat('Trial %d');
    ax = gca; 
    ax.FontSize = 4; 
    ylim([-0.5 60.5]);
    set(gca,'Ydir','reverse')
    xlabel('Time (ms)', FontSize = 10);
    ylabel('Trial', FontSize = 10);
    title('Spike points for each trial at 13.5 uA stim level for Ch', channel(ch), FontSize = 10);
end
%% Part 4.2.5
var = 1;

% Plot 8 raster plot for channel 48 for all stim levels
figure
for fname = 10.5:0.5:14
    subplot(4, 2, var);
    fpath = sprintf('stim_%.1fuA.txt', fname);
    ffile = importdata(fpath);
    ftime = ffile.data(:, 3);
    funfiltered_signal = ffile.data(:, 5); % channel 48
    [B, A] = butter(2, 200/(25000/2), 'high'); % sampling interval is 0.04 msec -> sampling frequency = 1/0.00004 = 25000 Hz
    ffiltered_signal = filter(B, A, funfiltered_signal);
    
    % identify the locations of stimulation and trail
    ftrial = [1];
    fstim = [];
    a = 2;
    b = 1;
    for i = 2:size(ftime, 1)
        if ffile.data(i, 1) ~= ffile.data(i-1, 1)
            ftrial(i) = i;
            i = i+1;
        end

        if ffile.data(i, 2) == ffile.data(i, 3)
            fstim(b) = i;
            b = b+1;
        end
    end

    % spike detection for plot
    peaktime = [];
    spike = 0;
    c = 1;
    threshold = mean(ffiltered_signal(fstim(:)+125:fstim(:)+2500))-5*std(ffiltered_signal(fstim(:)+125:fstim(:)+2500));
    for i = 1:size(fstim, 2)
        [peak_value,peak_timing] = findpeaks(-1*ffiltered_signal(fstim(i)+125:fstim(i)+2500), 'MinPeakHeight', -1*threshold, 'MinPeakDistance', 70);
        if ~isempty(peak_timing)
            for asd = 1:size(peak_timing)
                plot([5 + (0.04*(peak_timing(asd)-1)) 5 + (0.04*(peak_timing(asd)-1))], [i-0.5 i+0.5], 'Color', [0,0,0]);
                hold on;
                peaktime(c) = peak_timing(asd);
                c = c+1;
                spike = spike + 1;
            end
        end
    end
    yticks([1:60]);
    ytickformat('Trial %d');
    set(gca,'Ydir','reverse')
    ax = gca; 
    ax.FontSize = 1; 
    ylim([0.5 60.5]);
    xlim([-20 100]);
    xlabel('Time (ms)', FontSize = 7);
    ylabel('Trial', FontSize = 7);
    title(fname, FontSize = 8)
    var = var+1;
end
sgtitle('Raster plot of Ch 48 for all stim levels', FontSize = 10)
%% Part 4.2.6
var = 1;

% Plot 9 PSTH of channel 48 for all stem levels
figure
for fname = 10.5:0.5:14
    subplot(4, 2, var);
    fpath = sprintf('stim_%.1fuA.txt', fname);
    ffile = importdata(fpath);
    ftime = ffile.data(:, 3);
    funfiltered_signal = ffile.data(:, 5); % channel 48
    [B, A] = butter(2, 200/(25000/2), 'high');
    ffiltered_signal = filter(B, A, funfiltered_signal);
    
    % identify the locations of stimulation and trail
    ftrial = [1];
    fstim = [];
    d = 2;
    e = 1;
    for i = 2:size(ftime, 1)
        if ffile.data(i, 1) ~= ffile.data(i-1, 1)
            ftrial(d) = i;
            d = d+1;
        end

        if ffile.data(i, 2) == ffile.data(i, 3)
            fstim(e) = i;
            e = e+1;
        end
    end
    
    % spike detection for plot
    peaktime = [];
    spike = 0;
    f = 1;
    threshold = mean(ffiltered_signal(fstim(:)+125:fstim(:)+2500))-5*std(ffiltered_signal(fstim(:)+125:fstim(:)+2500));
    for i = 1:size(fstim, 2)
        [peak_value,peak_timing] = findpeaks(-1*ffiltered_signal(fstim(i)+125:fstim(i)+2500), 'MinPeakHeight', -1*threshold, 'MinPeakDistance', 70);
        if ~isempty(peak_timing)
            for asd = 1:size(peak_timing)
                peaktime(f) = peak_timing(asd);
                f = f+1;
                spike = spike + 1;
            end
        end
    end
    
    % histogram
    histogram(5 + (0.04*(peaktime-1)), 'BinWidth', 5);
    xlim([0 100]);
    ylim([0 65]);
    xlabel('Time (ms)');
    title(fname, FontSize = 8)
    var = var+1;
end
sgtitle('PSTH of Ch 48 for all stim levels', FontSize = 10)
%% Part 4.2.7

% Plot 10 strength-response curve for channel 36, 48, and 56
figure
for ch = 4:6 % three channels
    average_spike_per_trial = [];
    var = 1;
    for fname = 10.5:0.5:14
        fpath = sprintf('stim_%.1fuA.txt', fname);
        ffile = importdata(fpath);
        ftime = ffile.data(:, 3);
        funfiltered_signal = ffile.data(:, ch);
        [B, A] = butter(2, 200/(25000/2), 'high'); % sampling interval is 0.04 msec -> sampling frequency = 1/0.00004 = 25000 Hz
        ffiltered_signal = filter(B, A, funfiltered_signal);

        % identify locations of stimulation and trial
        ftrial = [1];
        fstim = [];
        g = 2;
        h = 1;
        for j = 2:size(ftime, 1)
            if ffile.data(j, 1) ~= ffile.data(j-1, 1)
                ftrial(g) = j;
                g = g+1;
            end

            if ffile.data(j, 2) == ffile.data(j, 3)
                fstim(h) = j;
                h = h+1;
            end
        end

        % spike detection for plot
        spike = 0;
        threshold = mean(ffiltered_signal(fstim(:)+125:fstim(:)+2500))-5*std(ffiltered_signal(fstim(:)+125:fstim(:)+2500));
        for i = 1:size(fstim, 2)
            [peak_value,peak_timing] = findpeaks(-1*ffiltered_signal(fstim(i)+125:fstim(i)+2500), 'MinPeakHeight', -1*threshold, 'MinPeakDistance', 70);
            if ~isempty(peak_timing)
                for asd = 1:size(peak_timing)
                    spike = spike + 1;
                end
            end
        end
        average_spike_per_trial(var) = spike/60;
        var = var+1;
    end

    % strength response curve
    plot([10.5:0.5:14], normalize(average_spike_per_trial, "range"));
    hold on;
end
xlabel('Stimulus intensity');
ylabel('Spike counts')
title('Strength-response curve')
legend('Ch 36', 'Ch 48', 'Ch 56')
%%
