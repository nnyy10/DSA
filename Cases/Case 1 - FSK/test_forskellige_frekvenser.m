clear;

Symbolrate = 0.01;
Tsymbol = 1/Symbolrate;
fs= 10000;
N = Tsymbol*fs;

n = (0:N-1);

s1 = sin(60*n*2*pi/fs);
s2 = sin(61*n*2*pi/fs);

y = s1+s2;


figure

Y = fft(y);

deltaF = fs/N;
faxis = 0:deltaF:fs-deltaF;

plot(faxis,abs(Y));