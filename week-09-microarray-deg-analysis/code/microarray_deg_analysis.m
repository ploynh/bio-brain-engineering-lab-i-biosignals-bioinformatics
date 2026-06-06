data_dir = fullfile(fileparts(mfilename('fullpath')), 'text');
[data,headers,probes] = tblread(fullfile(data_dir, 'GSE18842_series_matrix_mdf.txt'), '\t');
quantile_norm_data = quantilenorm(data);

% Modify each header by adding corresponding row number, so the headers are non-repetitive
samples = strings(size(headers, 1), 1); 
for i = 1:size(headers, 1)
    samples(i) = convertCharsToStrings(append(headers(i,:), string(i)));
end
%% Create a boxplot
figure; 
boxplot(quantile_norm_data);
%% Split dataset
% Calculate total number of control and tumor samples
control_id = strmatch('control', headers); %store indices of control
tumor_id = strmatch('tumor', headers); %store indices of tumor
total_control_samples = numel(control_id);
total_tumor_samples = numel(tumor_id);
num_discovery_samples = 35;
% Generate random permutations of indices for control and tumor samples
control_per = randperm(total_control_samples);
tumor_per = randperm(total_tumor_samples);

% Indices for discovery set
discovery_control_id = control_id(control_per(1:num_discovery_samples));
discovery_tumor_id = tumor_id(tumor_per(1:num_discovery_samples));
% Indices for validation set
validation_control_id = control_id(control_per(num_discovery_samples+1:end));
validation_tumor_id = tumor_id(tumor_per(num_discovery_samples+1:end));
% Concentrate the indices
discovery_id = [discovery_control_id; discovery_tumor_id];
validation_id = [validation_control_id; validation_tumor_id];
% Extract the columns corresponding to indices
discovery_data = quantile_norm_data(:, discovery_id);
validation_data = quantile_norm_data(:, validation_id);

% Generate discovery and validation tables
discovery_table = [table(probes) array2table(discovery_data, 'VariableNames', cellstr(samples(discovery_id, :)))];
validation_table = [table(probes) array2table(validation_data, 'VariableNames', cellstr(samples(validation_id, :)))];
% Write discovery and validation dataset files
writetable(discovery_table, 'Discovery dataset.txt', 'Delimiter', '\t', 'WriteVariableNames', true);
writetable(validation_table, 'Validation dataset.txt', 'Delimiter', '\t', 'WriteVariableNames', true);
%% Get differentially expressed genes
% Discovery dataset
[discovery_pval, discovery_idx] = mattest(discovery_data(:, 1:35), discovery_data(:, 36:end), 'Showhist', true, 'Showplot', true);
[discovery_sorted_pval, discovery_sorted_idx] = sort(discovery_pval);
discovery_top100_id = discovery_sorted_idx(1:100);
% Extract DEG names and p-values
discovery_probe = probes(discovery_top100_id, :);
discovery_pvalue = discovery_sorted_pval(1:100);
% Write DEG names and p-values to file
discovery_pval_table = table(discovery_probe, discovery_pvalue);
writetable(discovery_pval_table, 'P-value.txt', 'Delimiter', '\t');
% Write expression data of top 100 DEGs to file
discovery_top100_data = discovery_data(discovery_top100_id, :);
discovery_top100_table = [table(discovery_probe) array2table(discovery_top100_data, 'VariableNames', cellstr(samples(discovery_id, :)))];
writetable(discovery_top100_table, 'Expression data of Top 100 DEGs_Discovery.txt', 'Delimiter', '\t');

% Validation dataset
[validation_pval, validation_idx] = mattest(validation_data(:, 1:10), validation_data(:, 11:end));
[validation_sorted_pval, validation_sorted_idx] = sort(validation_pval);
validation_top100_id = validation_sorted_idx(1:100);
% Extract DEG names and p-values
validation_probe = probes(validation_top100_id, :);
validation_pvalue = validation_sorted_pval(1:100);
% Write expression data of top 100 DEGs to file
validation_top100_data = validation_data(validation_top100_id, :);
validation_top100_table = [table(validation_probe) array2table(validation_top100_data, 'VariableNames', cellstr(samples(validation_id, :)))];
writetable(validation_top100_table, 'Expression data of Top 100 DEGs_Validation.txt', 'Delimiter', '\t');
