% xcorr Example

% Load data
load relatedsig.mat

[P1,Q1] = rat(Fs/Fs1);          % Rational fraction approximation
[P2,Q2] = rat(Fs/Fs2);          % Rational fraction approximation
T1 = resample(T1,P1,Q1);        % Change sampling rate by rational factor
T2 = resample(T2,P2,Q2);        % Change sampling rate by rational factor

[C1,lag1] = xcorr(T1,S);        
[C2,lag2] = xcorr(T2,S);  

[~,I] = max(abs(C2));
SampleDiff = lag2(I)

figure(1)
ax(1) = subplot(2,1,1); 
plot(lag1/Fs,C1,'k')
ylabel('Amplitude')
grid on
title('Cross-correlation between Template 1 and Signal')
ax(2) = subplot(2,1,2); 
plot(lag2/Fs,C2,'r')
ylabel('Amplitude') 
grid on
title('Cross-correlation between Template 2 and Signal')
xlabel('Time(secs)') 
axis(ax(1:2),[-1.5 1.5 -700 700 ])