close all;clear;clc;
load('vejecelle_data.mat');

x = vejecelle_data;
N = length(vejecelle_data);

%x(500:503) = 2000; %Korrupt data - hvis indsat - ses de tydeligt i plot(x).

figure
plot(x);    %Ubelastet (1:1000) og Belastet (1050:end)
title('Tidsdomænet'); xlabel('Antal samples'); ylabel('Vægt');
Ubelastet = (1:1000); Belastet = (1051:2500);

%% OPGAVE 1 Find middelværdi, spredning og varians af ubelastet og belastet (med lod på) tilstand.
middel_ubelastet = mean(x(Ubelastet));
spredning_ubelastet = std(x(Ubelastet));
varians_ubelastet = var(x(Ubelastet));

middel_belastet = mean(x(Belastet));
spredning_belastet = std(x(Belastet));
varians_belastet = var(x(Belastet));

%% Plot histogrammer af værdierne for de to tilstande - ser data (tilnærmelsesvist) normalfordelt ud? 
%  Check at den målte spredning passer nogenlunde med histogrammet.

figure
subplot(211);
histogram(x(Ubelastet));
title('Ubelastet');xlabel('Vægt (kg)');ylabel('Målinger (antal)');
subplot(212);
histogram(x(Belastet));
title('Belastet');xlabel('Vægt (kg)');ylabel('Målinger (antal)');

%% Plot effektspektre for de to tilstande - ligner det hvid støj ?

% Effekten beregnes som signal-værdien i anden delt med længden af signalet.
% Det ligner hvid støj.

figure
subplot(211);
plot((x(Ubelastet).^2)/length(Ubelastet));
title('Ubelastet');xlabel('Antal samples');ylabel('Effekt');
subplot(212);
plot((x(Belastet).^2)/length(Belastet));
title('Belastet');xlabel('Antal samples');ylabel('Effekt');

%% Hvad er afstand imellem bit-niveauer i gram ? (dvs. værdi af LSB)

% Antal gram pr. step ændring på 1000g

LSB = 1000/(middel_belastet - middel_ubelastet);


%% OPGAVE 2 Prøv også med et eksponentielt midlingsfilter. Eksperimenter med ?-værdien
% – prøv f.eks. at sætte den meget lavt / højt. Hvad er betydningen af ?-værdien ?

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
title('Belastet Før')
axis([0 inf 1250 1550])
subplot(212)
plot(x_filtreret(Belastet));
title('Belastet Efter')
axis([0 inf 1250 1550])

figure
subplot(211)
plot(x(Ubelastet));
title('Ubelastet Før')
axis([0 inf 950 1250])
xlabel('Antal samples');ylabel('Vægt');
subplot(212)
plot(x_filtreret(Ubelastet));
title('Ubelastet Efter')
axis([0 inf 950 1250])
xlabel('Antal samples');ylabel('Vægt');

% Vi er nødt til at vente 2*n samples før vi beregner pga indsvingning.
middel_belastet_filtreret = mean(x_filtreret(1051+2*n:2500));
spredning_belastet_filtreret = std(x_filtreret(1051+2*n:2500));
varians_belastet_filtreret = var(x_filtreret(1051+2*n:2500));

% Vi er nødt til at vente 3*n samples før vi beregner pga indsvingning.
middel_ubelastet_filtreret = mean(x_filtreret(3*n:1000));
spredning_ubelastet_filtreret = std(x_filtreret(3*n:1000));
varians_ubelastet_filtreret = var(x_filtreret(3*n:1000));


%% Prøv at sætte ?-værdien, således at I får samme støj-reduktion, som for jeres 100. ordens FIR midlingsfilter
%  – Kommentér på indsvingnings-tiderne (dvs. tiden fra ”belastning” til ”ingen belastning”).

% Histogrammer for de filtrerede målinger. Der ses en tydelig forbedring
% fra de oprindelige histogrammer i figure(2).

figure
subplot(211);
histogram(x_filtreret(Ubelastet));
title('Ubelastet Efter');xlabel('Vægt (kg)');ylabel('Målinger (antal)');
subplot(212);
histogram(x_filtreret(Belastet));
title('Belastet Efter');xlabel('Vægt (kg)');ylabel('Målinger (antal)');


%% Hvor mange betydende cifre kan I medtage i et display, hvis det skal vise vægt i kg (op til fx. 5 kg) 
%  og hvis støjens spredning (=kvadrat af varians) skal ligge på under 1/10 af værdien af det mindst betydende
%  ciffer i displayet ?

spredning_stoej = (spredning_belastet_filtreret+spredning_ubelastet_filtreret)/2;

% Kravet er at spredning skal være 1/10 af LSB på displayet, derfor
% bestemmes værdien med følgende udregning:
display = 10*spredning_stoej*LSB;


%% Median-filteret sørger for at fjerne ekstreme værdier, f.eks. ved korrupt data,
%  fordi det tager anvender medianen af en række samples.
y = medfilt1(x,15);

figure
plot(y)
title('Tidsdomænet efter median-filteret');xlabel('Antal samples');ylabel('Vægt');


%% Til rapport

figure
plot(x_filtreret);axis([0 2500 900 1500]);title('Signal efter exp midlingsfilter');
xlabel('Tid (samples)');ylabel('Amplitude');

