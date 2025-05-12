%FM generated signal
Kf = 1000;  % initial modulation index
int_m = cumtrapz(t, m);  % numerical integration of m(t)

s_fm = Ac * cos(2*pi*fc*t + 2*pi*Kf*int_m);

% Plot
figure;
plot(t*1e3, s_fm);
xlabel('Time (msec)');
ylabel('FM Signal');
title('FM Signal (Kf = 1000)');
grid on;
%Comment:
%Higher Kf increases frequency deviation.
%Wider bandwidth required.
%FM becomes more robust to noise but occupies more spectrum.
%--------------------------------------------------------------------------
%Repeat  for Kf= 3000 and Kf= 5000.
for i = 1:length(Kf_vals)
    Kf = Kf_vals(i);
    s_fm = Ac * cos(2*pi*fc*t + 2*pi*Kf*int_m);
    
    figure;
    plot(t*1e3, s_fm);
    xlabel('Time (msec)');
    ylabel('FM Signal');
    title(['FM Signal (Kf = ', num2str(Kf), ')']);
    grid on;
end
