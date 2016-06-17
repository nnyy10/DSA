clear; clc;

%%%% Opgave 1 og 2 %%%%%

% specs
fstart = 500; % transmission band frequency start
fend = 3000; % transmission band frequency end
Tsymbol = 0.5; % symbol duration in seconds
fs = 10000; % sampling frequenc y

x = FSKgenerator('easy', fstart, fend, Tsymbol, fs);

% [x, fs] = audioread('easy_recording_Tsymbol_0.5.wav');
% 
% FSKdecode(fstart, fend, Tsymbol, fs, x)
% 
% y = fft(x);
% 
% figure(1)
% plot(abs(y));

% making sound 

%soundsc(x,fs);




%%%%% Opgave 3 %%%%%



% Opgave 4 

% % specs
% fstart = 500; % transmission band frequency start
% fend = 3000; % transmission band frequency end
% Tsymbol = 1; % symbol duration in seconds
% %fs = 10000; % sampling frequenc y

%[x, fs] = audioread('easy_recording_Tsymbol_0.01.wav');

% FSKdecode(fstart, fend, Tsymbol, fs, x)
% 
% y = fft(x);
% 
% deltaF = fs/length(x);
% faxis = (0:deltaF:fs-deltaF);
% 
% 
% figure(1)
% plot(faxis,abs(y));
% title('')
% xlabel('Frequency bins')
% ylabel('Amplitude')

% figure
% 
% plot(abs(fft(x)));

y = [x];

Nsamples = Tsymbol*fs;
N = length(y);
deltaF = fs/N;
faxis = (0:deltaF:fs-deltaF);

% figure
% plot(y);
% 
% figure
% plot(faxis,abs(fft(y)));    

figure
spectrogram(y, rectwin(500), 0, 10000, 100000000000000);








