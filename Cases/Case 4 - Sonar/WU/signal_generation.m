clear;
clc;
import myacc.m.*
import myccconv.m.*

%% Declaration
t=0.005;

fs=48000;

N=fs*t;

taxis=[0:N]/fs;

x=[0:1:N];
%% sin wave
f=10000;

x_sin=sin(2*pi*taxis*f);

figure(3)
plot(taxis,x_sin)

X_sin=fft(x_sin);

delta_f=fs/N;

faxis=[0:delta_f:fs];

plot(faxis,abs(X_sin))

%% chirp
x_chirp=chirp(taxis,3000,0.005,5000);


plot(x_chirp)

X_chirp=fft(x_chirp);

plot(faxis,abs(X_chirp))

%% white noise
x_rand=randn([1,N+1]);
plot(x_rand)

X_rand=fft(x_rand);

plot(faxis,abs(X_rand))


%% test
y=xcorr((x_chirp),x_chirp);

y1=xcorr(x_sin+x_rand,x_sin);

figure(1)
plot(y1)

figure(2)
plot(y)

%% saving
signal = x_chirp;
signalhex = mydec2hex(x_chirp*0.999);
fid=fopen('minFil.dat', 'w');
for i=1:length(signalhex)-1,
    fprintf(fid, '%s,\n', signalhex{i});
end
fprintf(fid, '%s\n', signalhex{end});   % Uden ","-tegn
fclose(fid)

%% loading recorded
close all;
recorded=load('recorded_280.dat');

figure
plot(recorded')

figure
semilogx(abs(fft(recorded')))

y=myccconv(recorded',x_chirp);
figure
plot(y)
