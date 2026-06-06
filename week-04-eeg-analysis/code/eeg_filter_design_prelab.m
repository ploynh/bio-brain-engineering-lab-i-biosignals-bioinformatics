clear; clc;
close all;

Fs = 1000; % Sampling frequency
T = 1/Fs; % Sampling period (s)(1/1000 = 0.001)
L = 1000; % Length of signal
t = (0:L-1)*T; % Time vector
signal = cos(100*pi*t) + (5*cos(300*pi*t)) + (10*cos(600*pi*t));

figure
plot(t, signal);
xlabel('time (sec)');
ylabel('Amplitude');
xlim([0 0.1])
title('sinusoidal signal in time domain');
%%
figure
spectrum = fft(signal);
Abs_spectrum = abs(fftshift(spectrum)/L); %fftshif = shift zero frequency to center 
f = (-L/2:L/2-1)*Fs/L;
plot(f, Abs_spectrum);
xlabel('Frequency (Hz)');
ylabel('Magnitude of Absolute spectrum');
title('Spectrum of sinusoidal signal in frequency domain');