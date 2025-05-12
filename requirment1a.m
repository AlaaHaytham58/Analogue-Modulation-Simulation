%Generate m(t)Ramp function
% Time vector
t = 0:1e-5:1e-3; % 0 to 2 ms, step of 10 us

% Generate ramp (sawtooth) with period 0.5 ms, going from 1 to -1
m = -sawtooth(2*pi*(1/0.5e-3)*t);

% Plot
figure;

plot(t*1e3, m, 'LineWidth', 2);
xlabel('Time (msec)');
ylabel('m(t)');
title('Ramp Function m(t)');
grid on;

%--------------------------------------------------------------------------
% Generate AM DSB-LC signal (Ka = 0.5)
% Carrier parameters
Ac = 1; 
fc = 10000; % 10 kHz
Ka = 0.5;

% Carrier signal
c = Ac * cos(2*pi*fc*t);

% AM signal with Ka = 0.5
s_am = Ac * (1 + Ka * m) .* cos(2*pi*fc*t);

% Plot
figure;
plot(t*1e3, s_am);
xlabel('Time (msec)');
ylabel('AM Signal');
title('AM DSB-LC Signal (Ka = 0.5)');
grid on;
%--------------------------------------------------------------------------
%Repeat for Ka = 1 and Ka = 2
Ka = 1;
s_am1 = Ac * (1 + Ka * m) .* cos(2*pi*fc*t);

Ka = 2;
s_am2 = Ac * (1 + Ka * m) .* cos(2*pi*fc*t);

% Plot both
%ka=1
figure;
subplot(2,1,1);
plot(t*1e3, s_am1);
title('AM DSB-LC Signal (Ka = 1)');
xlabel('Time (msec)');
ylabel('Amplitude');
%ka=2
subplot(2,1,2);
plot(t*1e3, s_am2);
title('AM DSB-LC Signal (Ka = 2)');
xlabel('Time (msec)');
ylabel('Amplitude');
%Comment
%Ka = 1: full modulation
%Ka = 2: over-modulation ? envelope distortion ? poor demodulation.

