%QPSK signal generation
close all;
clear all;
clc;
msg=round(rand(1,20));
data=[];
fs=10000;
%t=0:.01:.99;
t=0:1/fs:0.01;
fc=1000;
c=cos(2*pi*fc*t);%carrier signal & it's a matrix of length 1X100(bcoz for each t, there's ac)
% .let fc=10hz
% chan=ricianchan(1/fs,100,1)
% chan=rayleighchan(1/fs,100);
for i=1:20
if msg(i)==0
d=-1*ones(1,10);
else
d=ones(1,10);
end;

data=[data d]; %data is created only for plotting.it has no application in the following for loop
end;
disp('length of t,c,data');
a=[length(t);length(c);length(data);];disp(a);
qpsk=[];
for i=1:2:20
if msg(i)==1 && msg(i+1)== 0
qpsk=[qpsk cos(2*pi*fc*t+(pi/4))];
else if msg(i)==0 && msg(i+1)==0
qpsk=[qpsk cos(2*pi*fc*t+(3*pi/4))];
else if msg(i)==0 && msg(i+1)==1
qpsk=[qpsk cos(2*pi*fc*t+(5*pi/4))];
else if msg(i)==1 && msg(i+1)==1
qpsk=[qpsk cos(2*pi*fc*t+(7*pi/4))];
end;
end;
end;
end;
end;
% plot(qpsk);
modsig=[];
for i=1:100:1000
for j=1:10
p=qpsk(i+j);
modsig=[modsig p];
end;
end;
%fadedsig=filter(chan,qpsk);
% fadedsig=filter(chan,qpsk);
subplot(321);
plot(data);axis([0 100 -1.5 1.5])
title('Digital Message signal');
%plot('fadesig');
subplot(323);
plot(modsig);axis([0 100 -1.5 1.5])
title('qpsk signal');
subplot(322)
plot(c);axis([0 100 -1.5 1.5])
title('Unmodulated carrier');
%l1 norm minimization
N=100;
% number of spikes in the signal
% T = 20;
T=3;
% number of observations to make
% K = 120;
K=30;
x=modsig;
x=x';
x1=x;
% stem(x1);
% x = zeros(N,1);
q = randperm(N);
x(q(1:T)) = sign(randn(T,1));
x=modsig;
% A = randn(K,N);%additive white gaussian noise
A = randn(K,N)+j*randn(K,N); % rayleigh fading
A = orth(A')';
y = A*x1;
xp = A'*y;
subplot(324);
plot(xp);
axis([0 100 -1.5 1.5])
title('reconstructed signal');
D=abs(x1-xp).^2;
MSE1=sum(D(:))/numel(x);
% MSE1 = mse(x1, xp);
% MSE1 = mean((x1 -xp).^2);
display([' Mean Squared Error: ' num2str(MSE1)]);
SNR1 = snr(x1,xp);display([' SNR1: ' num2str(SNR1)]);
% SNR1 = (abs(x.^2))./(abs(MSE1.^2));
% SNRdB= 10 * log10( SNR1 );
% display([' SNR1: ' num2str(SNR1)]);





