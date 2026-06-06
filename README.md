# Lab I: Biosignals and Bioinformatics

This repository contains cleaned coursework from an undergraduate Bio and Brain Engineering laboratory course block. It is organized as a readable lab portfolio rather than a production software package.

The work starts with physiological and neural signal measurement, then moves into bioinformatics, sequence alignment, protein structure analysis, biomedical text mining, microarray analysis, and biological network modeling. Public files keep the useful code, small non-sensitive inputs, selected non-identifying results, and a README summary for every week. Raw human physiology/EEG recordings, submitted reports, copied course materials, and private identifiers are intentionally excluded.

Each week uses the same public-facing convention:

- `README.md` explains the lab focus, included artifacts, excluded artifacts, and rerun notes.
- `code/` is included only when reusable scripts or notebooks are safe to publish.
- `data/` is included only for small non-sensitive inputs.
- `results/` is included only for non-identifying figures, tables, or model artifacts.
- `report/` is intentionally not published because original reports can contain names, student IDs, partner information, private measurements, and copied course text.

## Repository Structure

| Folder | Contents |
| --- | --- |
| `week-01-physiological-measurements/` | Blood pressure, ECG, EMG, and PPG measurement concepts. Only a public-safe summary is included because the original files contained personal measurements. |
| `week-02-physiological-signal-processing/` | MATLAB ECG/EMG/PPG-style signal processing code for sampling, filtering, and basic signal analysis. |
| `week-03-neural-spike-analysis/` | MATLAB spike detection and stimulation-response analysis using filtering, thresholding, and multi-channel neural recordings. |
| `week-04-eeg-analysis/` | MATLAB EEG processing scripts for task-related analysis, filtering, and band-power interpretation. Raw EEG recordings and personal plots are excluded. |
| `week-05-linux-computing-environment/` | Linux command-line and bioinformatics computing exercises summarized without report-only files. |
| `week-06-dna-sequence-alignment/` | Python dynamic-programming implementation for pairwise DNA sequence alignment. |
| `week-07-protein-structure-analysis/` | Python protein sequence alignment, FASTA search examples, BLAST/SWISS-MODEL/AlphaFold comparison artifacts, and selected structure figures. |
| `week-08-biomedical-literature-mining/` | Python/Colab notebook for co-occurrence-based disease-gene text mining. Copied abstract datasets are excluded. |
| `week-09-microarray-deg-analysis/` | MATLAB microarray preprocessing, quantile normalization, train/validation splitting, t-tests, and top DEG extraction. |
| `week-10-microarray-classification/` | Python notebooks for disease classification from differential gene-expression data. |
| `week-11-biological-network-modeling/` | MATLAB simulations for Michaelis-Menten-style phosphorylation and a self-contained MAPK cascade model. |

```text
bio-brain-engineering-lab-i-biosignals-bioinformatics/
|-- README.md
|-- week-01-physiological-measurements/
|   `-- README.md
|-- week-02-physiological-signal-processing/
|   `-- code/
|       `-- ecg_emg_signal_analysis.m
|-- week-03-neural-spike-analysis/
|   `-- code/
|       |-- multichannel_spike_detection.m
|       `-- stimulus_response_spike_analysis.m
|-- week-04-eeg-analysis/
|   `-- code/
|       |-- eeg_blink_filter_analysis.m
|       |-- eeg_eye_open_close_bandpower.m
|       |-- eeg_filter_design_prelab.m
|       |-- eeg_frown_filter_analysis.m
|       |-- eeg_head_tilt_rotation_analysis.m
|       |-- eeg_math_task_bandpower.m
|       |-- eeg_smile_filter_analysis.m
|       `-- eeg_tilt_rotation_segment_filtering.m
|-- week-05-linux-computing-environment/
|   `-- README.md
|-- week-06-dna-sequence-alignment/
|   `-- code/
|       |-- dna_sequence_alignment.py
|       |-- dp_matrix.py
|       `-- scoring_params.py
|-- week-07-protein-structure-analysis/
|   |-- code/
|   |-- data/
|   `-- results/
|-- week-08-biomedical-literature-mining/
|   `-- code/
|       `-- lab8.ipynb
|-- week-09-microarray-deg-analysis/
|   |-- code/
|   `-- results/
|-- week-10-microarray-classification/
|   |-- code/
|   `-- data/
`-- week-11-biological-network-modeling/
    |-- code/
    `-- results/
```

## Topics Covered

- Physiological measurement concepts for ECG, EMG, PPG, and blood pressure
- Biosignal filtering, sampling, and frequency-domain interpretation
- Neural spike detection and stimulus-response analysis
- EEG task analysis and band-power comparison
- Dynamic-programming sequence alignment
- Protein sequence search and structure-model comparison
- Disease-gene text mining from biomedical literature
- Microarray normalization, differential expression, and classification
- ODE-based biological pathway and enzyme-kinetics simulation

## Included Artifacts

- MATLAB scripts for biosignal processing, EEG analysis, microarray analysis, and biological network modeling
- Python scripts and notebooks for DNA/protein alignment, biomedical text mining, and microarray classification
- Small non-sensitive FASTA and gene-expression style datasets where publication is reasonable
- Selected non-identifying figures, tables, and PDB structure artifacts that help show results
- README summaries for weeks where the original files should not be public

## Privacy and Course-Policy Notes

This public version intentionally excludes raw human physiology and EEG recordings, derived personal waveform plots, submitted reports, names, student IDs, partner identifiers, course manuals, copied instruction notebooks, and large or duplicated raw files. Summaries are rewritten in a compact form instead of publishing full report text.

Some scripts may require local course datasets or environment paths that are not included here. Those files are omitted because they are private, too large, or not clearly redistributable.

## Tools and Languages Used

- MATLAB
- Python
- Jupyter/Colab notebooks
- NumPy, pandas, matplotlib-style analysis workflows
- Bioinformatics concepts such as FASTA, sequence alignment, BLAST, SWISS-MODEL, AlphaFold, and PDB structure review

## What I Practiced

- Organizing lab data and code into reproducible analysis steps
- Filtering and interpreting physiological and EEG signals
- Implementing alignment algorithms with scoring matrices and dynamic programming
- Comparing sequence-search and protein-structure outputs
- Extracting microarray features for statistical analysis and classification
- Simulating biological network behavior from model parameters

## Limitations

- This is a cleaned coursework archive, not a reusable biomedical software package.
- Human-subject data, submitted reports, and course-provided materials are not included.
- Some notebooks and scripts may need local paths or omitted datasets before rerunning.
- Result figures are included only when they are non-identifying and useful for browsing the work.

## Repository Status

This repository is prepared for public GitHub presentation as undergraduate lab coursework. The goal is to make the work easy to browse while keeping the original assignments recognizable and publication-safe.
