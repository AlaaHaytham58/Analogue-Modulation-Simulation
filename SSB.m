%GENERATED SINUSOIDAL SIGNAL m(t)AMPLITUDE=2 ,FREQUENCY=2KHz
% Time vector
fs = 100e3;             % Sampling frequency (100 kHz)
t = 0:1/fs:2e-3;        % Time from 0 to 2 ms

% Message signal m(t)
Am = 2;                 
fm = 2000;              % 2 kHz
m = Am * cos(2*pi*fm*t);

% Plot
figure;
plot(t*1e3, m, 'LineWidth', 2);
xlabel('Time (ms)');
ylabel('m(t)');
title('Sinusoidal Message Signal m(t)');
grid on;
%--------------------------------------------------------------------------
%--------Generate the modulated signal s(t)output of the block-------------
%-------------------------------------------------------------------------
% Carrier parameters
Ac = 1;
fc = 10000;           % 10 kHz carrier

% Hilbert transform of m(t)
mh = imag(hilbert(m));  % This gives the Hilbert transform of m(t)

% Generate USB and LSB
s_usb = Ac * (m .* cos(2*pi*fc*t) - mh .* sin(2*pi*fc*t));  % USB
s_lsb = Ac * (m .* cos(2*pi*fc*t) + mh .* sin(2*pi*fc*t));  % LSB

% Plot
figure;
subplot(2,1,1);
plot(t*1e3, s_usb);
xlabel('Time (ms)');
ylabel('s_{USB}(t)');
title('SSB Modulated Signal - USB');

subplot(2,1,2);
plot(t*1e3, s_lsb);
xlabel('Time (ms)');
ylabel('s_{LSB}(t)');
title('SSB Modulated Signal - LSB');
%--------------------------------------------------------------------------
%------------------- Obtain the Frequency Spectrum-------------------------
%--------------------------------------------------------------------------

% Frequency axis
n = length(t);
f = linspace(-fs/2, fs/2, n);

% Compute and plot spectra
S_USB = abs(fftshift(fft(s_usb)/n));
S_LSB = abs(fftshift(fft(s_lsb)/n));

figure;
subplot(2,1,1);
plot(f/1e3, S_USB);
xlabel('Frequency (kHz)');
ylabel('|S_{USB}(f)|');
title('Spectrum of USB Signal');

subplot(2,1,2);
plot(f/1e3, S_LSB);
xlabel('Frequency (kHz)');
ylabel('|S_{LSB}(f)|');
title('Spectrum of LSB Signal');
%--------------------------------------------------------------------------
%------------------Demodulate the SSB Signal to Recoverm(t)---------------
%--------------------------------------------------------------------------

% Multiply USB signal by cosine carrier (coherent detection)
demod_usb = s_usb .* cos(2*pi*fc*t) * 2;

% Apply low-pass filter to recover message
[b, a] = butter(5, (fm*2)/fs);  % 5th order LPF, cutoff just above 2kHz
recovered_m = filter(b, a, demod_usb);

% Plot
figure;
plot(t*1e3, recovered_m, 'LineWidth', 2);
xlabel('Time (ms)');
ylabel('Recovered m(t)');
title('Demodulated Message Signal');
grid on;
%--------------------------------------------------------------------------
%------------------Imperfect Carrier Synchronization-----------------------
%--------------------------------------------------------------------------

% Introduce frequency and phase error in local oscillator
fc_offset = 50;  % 50 Hz frequency offset
phase_offset = pi/6;  % 30 degree phase shift

% Use offset carrier for demodulation
imperfect_carrier = cos(2*pi*(fc + fc_offset)*t + phase_offset);

% Demodulate with imperfect carrier
demod_imperfect = s_usb .* imperfect_carrier * 2;
recovered_imperfect = filter(b, a, demod_imperfect);

% Plot
figure;
plot(t*1e3, recovered_imperfect, 'r', 'LineWidth', 2);
xlabel('Time (ms)');
ylabel('m_{rec}(t)');
title('Recovered m(t) with Carrier Mismatch');
grid on;
%Comment
%observe distortion, possibly beating or a frequency shift.
%This is due to phase and frequency mismatch between modulator and
%demodulator carriers


