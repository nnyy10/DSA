clear;clc;

[x, fs] = audioread('tale_tone_48000.wav');
%soundsc(x,fs)

%x = x.*blackman(length(x)); %Vinduesfunktion.
N = length(x);
X = fft(x);                 %FFT

figure
plot(x)
title('Tidsdomænet')
xlabel('Tid')
ylabel('Amplitude')

figure
deltaF = fs/N;
faxis = [0:deltaF:fs-deltaF];
semilogx(faxis(1:0.5*end),20*log(abs(X(1:0.5*end))));
title('Frekvensdomænet, f_n_o_i_s_e = 5260*f_s/N = 785.0746Hz')
xlabel('Frequency bins')
ylabel('Amplitude')

f_noise = 5260*fs/N  %Bin no. 5260 har frekvensen 785.0746Hz

figure
spectrogram(x, rectwin(2000), 0, 5000, fs) % WINDOW = rectwin(1000), NOVERLAP = 0, NFFT = 5000 (3000 zero-pads)
title('Spektogram, f_n_o_i_s_e = 787.2Hz')
