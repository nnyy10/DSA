clc;clear;close all;

% Opgave 1

load('vejecelle_data');
x = vejecelle_data;
x_uden = vejecelle_data([1:1000]); % definere interval
x_tryk = vejecelle_data([1050:end]); % % definere interval
N = length(vejecelle_data);

diff = fs/N;
faxis = [0:diff:fs-diff];

X = fft(vejecelle_data);

figure
semilogx(faxis(1:end*0.5), (2/N)*20*log(abs(X(1:end*0.5))));
xlabel('Frekvens (Hz)');
ylabel('Amplitude');
title('signal i frekvensdomæne')


% middelværdi uden filter
ave_uden = mean(x_uden);
ave_tryk = mean(x_tryk);

%spredning uden filter
spread_uden = std(x_uden);
spread_tryk = std(x_tryk);

%varians uden filter
var_uden = var(x_uden);
var_tryk = var(x_tryk);


% power spektrum (taget fra internettet)
N = length(x_tryk);
xdft = fft(x_uden);
xdft = xdft(1:N/2+1);
psdx = (1/(fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:fs/N:fs/2;
plot(freq,10*log10(psdx))
grid on
title('Power Spectrum med Belastning')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')


% Opgave 2
orden = 100;
b = [ones(1, orden)];

xFiltered = (1/orden)*filter(b,1,x);
xFiltered_tryk = (1/orden)*filter(b,1,x_tryk);
xFiltered_uden = (1/orden)*filter(b,1,x_uden);


% Hele signalet i tidsdomæne filtret og ikke-filtreret
figure
subplot(2,1,1);
plot(xFiltered);
xlabel('tid (samples)');
ylabel('Amplitude');
title('Signal efter FIR filter');
axis([0 2500 900 1500]);
hold on
subplot(2,1,2);
plot(x);
xlabel('tid (samples)');
ylabel('Amplitude');
title('ikke-Filtreret signal i tidsdomæne');
axis([0 inf 900 1500]);
hold off

% Signalet med tryk i tidsdomæne filtret og ikke-filtreret
figure
subplot(2,1,1);
plot(xFiltered_tryk);
xlabel('tid (samples)');
ylabel('Amplitude');
title('Filtreret signal_tryk i tidsdomæne');
hold on
subplot(2,1,2);
plot(x_tryk);
xlabel('tid (samples)');
ylabel('Amplitude');
title('ikke-Filtreret signal_tryk i tidsdomæne');
hold off

% Signalet uden tryk i tidsdomæne filtret og ikke-filtreret
figure
subplot(2,1,1);
plot(xFiltered_uden);
xlabel('tid (samples)');
ylabel('Amplitude');
title('Filtreret signal_uden i tidsdomæne');
hold on
subplot(2,1,2);
plot(x_uden);
xlabel('tid (samples)');
ylabel('Amplitude');
title('ikke-Filtreret signal_uden i tidsdomæne');
hold off


% Histogrammer
figure
subplot(2,1,1);
histogram(x,200);
title('Ufiltreret signal');
xlabel('Forskellige y-værdier');
ylabel('Antal af samme værdi');
axis([900 1600 0 inf]);
subplot(2,1,2);
histogram(xFiltered,200);
title('Filtreret signal');
xlabel('Forskellige y-værdier');
ylabel('Antal af samme værdi');
axis([900 1600 0 inf]);

figure
histogram(x_tryk);
hold on
histogram(xFiltered_tryk);
legend('ufiltreret','filtreret');
title('Histogram for med belastning');
xlabel('Forskellige y-værdier)');
ylabel('Antal af samme værdi');

figure
histogram(x_uden);
hold on
histogram(xFiltered_uden);
legend('ufiltreret','filtreret');
title('Histogram for uden belastning');
xlabel('Forskellige y-værdier)');
ylabel('Antal af samme værdi');



% filtreret varians
var_uden_filt = var(xFiltered_uden([orden:end]));
var_tryk_filt = var(xFiltered_tryk([orden:end]));

% filtreret spredning
spread_uden_filt = std(xFiltered_uden([orden:end]));
spread_tryk_filt = std(xFiltered_tryk([orden:end]));

%krav til system om indsvinging på 100 ms
Tsample = 1/fs;
max_filter_order = 0.1/Tsample;






