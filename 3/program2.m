clear all;
close all;
T=1/8e2;%örnekleme periyodu
fs=1/T;
bit=16;%iletilmek istenen bit say?s?
sembol=bit/2;%QPSK için sembol say?s?
N=fs/10;% Bir semboldeki örnek say?s?
t=0:1:(N*sembol)+N-2;%zaman indeksleri
t=t*T;
p(1:N)=1;%kare darbe ?eklinde birim vuru? tepkesi olan darbe ?ekillendirme filtresi
veri=randsrc(2,sembol,[0 1]);% ilk sat?r d kanal? ikinci sat?r q kanal?
dk = veri(1,:);
qk = veri(2,:);
dk(dk==0)=-1/sqrt(2);%0 bitleri -1/sqrt(2) degeri ile temsil ediliyor
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
xlabel('örnek numarasi');
ylabel('birim vurus degeri');
title('dk\delta(t-kT)');
grid on;
subplot(4,1,2);
plot(0:length(qkt)-1,qkt);
xlabel('örnek numarasi');
ylabel('birim vurus degeri');
title('qk\delta(t-kT)');
grid on;
end;
dkt2=conv(dkt,p);
qkt2=conv(qkt,p);
subplot(4,1,3);
plot(0:length(dkt2)-1,dkt2);
xlabel('örnek numarasi');
ylabel('sembol');
title('Xdk(t)');
grid on;
subplot(4,1,4);
plot(0:length(qkt2)-1,qkt2);
xlabel('örnek numarasi');
ylabel('sembol');
title('Xqk(t)');
grid on;
hold off;
xck=cos(2*pi*1e2*t).*dkt2+sin(2*pi*1e2*t).*qkt2;%modülasyonlu i?aret
figure(2);
subplot(3,1,1)
plot(t,dkt2)
xlabel('zaman');
ylabel('yatay (gerçel) bilesen');
grid on;
subplot(3,1,2)
plot(t,qkt2)
xlabel('zaman');
ylabel('dikey (sanal) bilesen');
grid on;
subplot(3,1,3)
plot(t,xck)
xlabel('zaman');
ylabel('iletilen sinyal');
grid on;
eyediagram(xck,N);
figure(5);
xckf=fft(xck(1:sembol*N));
k=-sembol*N/2:1:sembol*N/2-1;
f=k*fs/(sembol*N);
plot(f,fftshift(2*abs(xckf))/(sembol*N));
title('Modüle Edilmis Sinyalin Genlik Spektrumu');
xlabel('Frekans (Hz)');