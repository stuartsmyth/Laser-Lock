%findpeaks test
%[PKS,LOCS] = findpeaks(Y,X) specifies X as the location vector of data
%vector Y. X must be a strictly increasing vector of the same length as
%Y. LOCS returns the corresponding value of X for each peak detected.
%If X is omitted, then X will correspond to the indices of Y.
%'MinPeakDistance'
[pks,tim] = findpeaks(yy,t,'MinPeakDistance',0.001);

%Ploting
figure(2)
plot(t,yy);
hold on
title('Absorbtion spectra of Rb');
xlabel('time')
ylabel('y')
plot (tim,pks,'o m');
hold off