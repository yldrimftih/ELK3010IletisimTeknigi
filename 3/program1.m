clear;
close all;
N=20;% Bir semboldeki örnek say?s?
p(1:N)=1;%kare darbe ?eklinde birim vuru? tepkesi olan darbe ?ekillendirme filtresi
bit=10;%iletilmek istenen bit say?s?
sembol=bit/2;%QPSK için sembol say?s?
veri=randsrc(2,sembol,[0 1]);% ilk sat?r d kanal? ikinci sat?r q kanal?
dk=veri(1,:);
qk=veri(2,:);
dk(dk==0)=-1/sqrt(2);%0 bitleri -1/sqrt(2) de?eri ile temsil ediliyor
dk(dk==1)=1/sqrt(2);%1 bitleri 1/sqrt(2) de?eri ile temsil ediliyor
qk(qk==0)=-1/sqrt(2);%0 bitleri -1/sqrt(2) de?eri ile temsil ediliyor
qk(qk==1)=1/sqrt(2);%1 bitleri 1/sqrt(2) de?eri ile temsil ediliyor
dkt(1:sembol*N)=0;%N semboldeki örnek say?s? kadar içinde s?f?r olan dizi
qkt(1:sembol*N)=0;%N semboldeki örnek say?s? kadar içinde s?f?r olan dizi
hold on;
for k=1:sembol
dkt((k-1)*N+1)=dk(k);% d kanal?ndaki sembollere kar??l?k olu?turulan birim vuru?lar
qkt((k-1)*N+1)=qk(k);%q kanal?ndaki sembollere kar??l?k olu?turulan birim vuru?lar
subplot(4,1,1);
plot(0:length(dkt)-1,dkt);
xlabel('örnek numaras?');
ylabel('birim vuru? de?eri');
title('dk\delta(t-kT)');
grid on;
subplot(4,1,2);
plot(0:length(qkt)-1,qkt);
xlabel('örnek numaras?');
ylabel('birim vuru? de?eri');
title('qk\delta(t-kT)');
grid on;
end;
dkt2=conv(dkt,p);
qkt2=conv(qkt,p);
subplot(4,1,3);
plot(0:length(dkt2)-1,dkt2);
xlabel('örnek numaras?');
ylabel('sembol');
title('Xdk(t)');
grid on;
subplot(4,1,4);
plot(0:length(qkt2)-1,qkt2);
xlabel('örnek numaras?');
ylabel('sembol');
title('Xqk(t)');
grid on;
hold off;

figure(2);
Xd = fft(dkt2);
plot(fftshift(abs(Xd)/length(Xd)));
title('xdk(t) nin Genlik Spektrumu');