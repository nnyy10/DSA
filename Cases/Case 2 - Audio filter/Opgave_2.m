clc;clear;

% info
[x, fs] = audioread('tale_tone_48000.wav');
N = length(x);
deltaF = fs/N;
faxis = [0:deltaF:fs-deltaF];

% nul-punkter og poler
z0 = 1*exp(1j*0.103)
p0 = 0.9*exp(1j*0.103)

% definere omega fra 0 til pi (svarende til 0 Hz til fs/2)
w = [0:0.001:pi];
z = exp(1j*w);

% transfer function
H = ((z-z0).*(z-(conj(z0))))./((z-p0).*(z-(conj(p0))))

figure
plot(w, abs(H))

% a- og b-koeffienter

k = 2^13;

   

%a = [1.79046 -0.809999];       % flere decimaler giver meget mere 
%b = [1 -1.9894003 1];          % præcist filter

% load signalet ind i x-variable
[x, fs] = audioread('tale_tone_48000.wav');

% a- og b-koeffienter
a = [1.79 -0.81];
b = [1 -1.99 1]; 

%filtrere signal x
y = filter(b,a,x);

%test af filtreret signal y
soundsc(y,fs)

% fft og frekvens plot af filtreret signal
figure
Y = fft(y); 
semilogx(faxis(1:0.5*end),20*log((1/N)*abs(Y(1:0.5*end))));
title('Frekvensdomænet af det filtreret signal')
xlabel('Frequency (Hz)')
ylabel('Amplitude')


% fft og frekvens-plot af u-filtreret singal
figure
X = fft(x);  
semilogx(faxis(1:0.5*end),20*log((1/N)*abs(X(1:0.5*end))));










