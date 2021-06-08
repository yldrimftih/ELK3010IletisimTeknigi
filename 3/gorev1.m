clear;
close all;
N=20;% Bir semboldeki örnek sayisi
p(1:N)=1;%kare darbe seklinde birim vurus tepkesi olan darbe sekillendirme filtresi
bit=10;%iletilmek istenen bit sayisi
sembol=bit/2;%BPSK için sembol sayisi
veri=randsrc(2,sembol,[0 1]);%d kanali 
dk=veri(1,:);
dk(dk==0)=-1;%0 bitleri -1 degeri ile temsil ediliyor
dk(dk==1)=1; %1 bitleri 1 degeri ile temsil ediliyor
dkt(1:sembol*N)=0;%N semboldeki örnek sayisi kadar içinde sifir olan dizi
hold on;
for k=1:sembol
dkt((k-1)*N+1)=dk(k);% d kanalindaki sembollere karsilik olusturulan birim vuruslar
subplot(2,1,1);
plot(0:length(dkt)-1,dkt);
xlabel('örnek numarasi');
ylabel('birim vurus degeri');
title('dk\delta(t-kT)');
grid on;
end;
dkt2=conv(dkt,p);
subplot(2,1,2);
plot(0:length(dkt2)-1,dkt2);
xlabel('örnek numarasi');
ylabel('sembol');
title('Xdk(t)');
grid on;
hold off;
figure(2);

Xd = 2*fft(dkt2);
plot(fftshift(abs(Xd)/length(Xd)));
title('xdk(t) nin Genlik Spektrumu');