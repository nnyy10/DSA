close all;clear;clc;
load('vejecelle_data.mat');

x = vejecelle_data;
N = length(vejecelle_data);

%x(500:503) = 2000; %Korrupt data - hvis indsat - ses de tydeligt i plot(x).

figure
plot(x);    %Ubelastet (1:1000) og Belastet (1050:end)
title('Tidsdom�net'); xlabel('Antal samples'); ylabel('V�gt');
Ubelastet = (1:1000); Belastet = (1051:2500);

%% OPGAVE 1 Find middelv�rdi, spredning og varians af ubelastet og belastet (med lod p�) tilstand.
middel_ubelastet = mean(x(Ubelastet));
spredning_ubelastet = std(x(Ubelastet));
varians_ubelastet = var(x(Ubelastet));

middel_belastet = mean(x(Belastet));
spredning_belastet = std(x(Belastet));
varians_belastet = var(x(Belastet));

%% Plot histogrammer af v�rdierne for de to tilstande - ser data (tiln�rmelsesvist) normalfordelt ud? 
%  Check at den m�lte spredning passer nogenlunde med histogrammet.

figure
subplot(211);
histogram(x(Ubelastet));
title('Ubelastet');xlabel('V�gt (kg)');ylabel('M�linger (antal)');
subplot(212);
histogram(x(Belastet));
title('Belastet');xlabel('V�gt (kg)');ylabel('M�linger (antal)');

%% Plot effektspektre for de to tilstande - ligner det hvid st�j ?

% Effekten beregnes som signal-v�rdien i anden delt med l�ngden af signalet.
% Det ligner hvid st�j.

figure
subplot(211);
plot((x(Ubelastet).^2)/length(Ubelastet));
title('Ubelastet');xlabel('Antal samples');ylabel('Effekt');
subplot(212);
plot((x(Belastet).^2)/length(Belastet));
title('Belastet');xlabel('Antal samples');ylabel('Effekt');

%% Hvad er afstand imellem bit-niveauer i gram ? (dvs. v�rdi af LSB)

% Antal gram pr. step �ndring p� 1000g

LSB = 1000/(middel_belastet - middel_ubelastet);


%% OPGAVE 2 Pr�v ogs� med et eksponentielt midlingsfilter. Eksperimenter med ?-v�rdien
% � pr�v f.eks. at s�tte den meget lavt / h�jt. Hvad er betydningen af ?-v�rdien ?

%alpha bestemmer hvor godt filteret er. Kravet er: 0 < alpha < 1.

n = 100;  %Filter orden

alpha = 2 / (n+1);  %alpha

b = alpha;
a = [1 -(1-alpha)];

% Inputtet filtreres. 
x_filtreret = filter(b,a,x);

% Resultatet af filtreringen plottes, for at se virkningen visuelt.
figure
subplot(211)
plot(x(Belastet));
title('Belastet F�r')
axis([0 inf 1250 1550])
subplot(212)
plot(x_filtreret(Belastet));
title('Belastet Efter')
axis([0 inf 1250 1550])

figure
subplot(211)
plot(x(Ubelastet));
title('Ubelastet F�r')
axis([0 inf 950 1250])
xlabel('Antal samples');ylabel('V�gt');
subplot(212)
plot(x_filtreret(Ubelastet));
title('Ubelastet Efter')
axis([0 inf 950 1250])
xlabel('Antal samples');ylabel('V�gt');

% Vi er n�dt til at vente 2*n samples f�r vi beregner pga indsvingning.
middel_belastet_filtreret = mean(x_filtreret(1051+2*n:2500));
spredning_belastet_filtreret = std(x_filtreret(1051+2*n:2500));
varians_belastet_filtreret = var(x_filtreret(1051+2*n:2500));

% Vi er n�dt til at vente 3*n samples f�r vi beregner pga indsvingning.
middel_ubelastet_filtreret = mean(x_filtreret(3*n:1000));
spredning_ubelastet_filtreret = std(x_filtreret(3*n:1000));
varians_ubelastet_filtreret = var(x_filtreret(3*n:1000));


%% Pr�v at s�tte ?-v�rdien, s�ledes at I f�r samme st�j-reduktion, som for jeres 100. ordens FIR midlingsfilter
%  � Komment�r p� indsvingnings-tiderne (dvs. tiden fra �belastning� til �ingen belastning�).

% Histogrammer for de filtrerede m�linger. Der ses en tydelig forbedring
% fra de oprindelige histogrammer i figure(2).

figure
subplot(211);
histogram(x_filtreret(Ubelastet));
title('Ubelastet Efter');xlabel('V�gt (kg)');ylabel('M�linger (antal)');
subplot(212);
histogram(x_filtreret(Belastet));
title('Belastet Efter');xlabel('V�gt (kg)');ylabel('M�linger (antal)');


%% Hvor mange betydende cifre kan I medtage i et display, hvis det skal vise v�gt i kg (op til fx. 5 kg) 
%  og hvis st�jens spredning (=kvadrat af varians) skal ligge p� under 1/10 af v�rdien af det mindst betydende
%  ciffer i displayet ?

spredning_stoej = (spredning_belastet_filtreret+spredning_ubelastet_filtreret)/2;

% Kravet er at spredning skal v�re 1/10 af LSB p� displayet, derfor
% bestemmes v�rdien med f�lgende udregning:
display = 10*spredning_stoej*LSB;


%% Median-filteret s�rger for at fjerne ekstreme v�rdier, f.eks. ved korrupt data,
%  fordi det tager anvender medianen af en r�kke samples.
y = medfilt1(x,15);

figure
plot(y)
title('Tidsdom�net efter median-filteret');xlabel('Antal samples');ylabel('V�gt');


%% Til rapport

figure
plot(x_filtreret);axis([0 2500 900 1500]);title('Signal efter exp midlingsfilter');
xlabel('Tid (samples)');ylabel('Amplitude');

