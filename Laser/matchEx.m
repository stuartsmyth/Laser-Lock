% match example
% Stuart Smyth
% created 8 Jun 18
% importing example sig only y axis
load(fullfile(matlabroot,'examples','signal','Ring.mat'))

% create time axis of signal
Time = 0:1/Fs:(length(y)-1)/Fs; 

% limits of y axis 
m = min(y);
M = max(y);

% converting y axis into double
Full_sig = double(y);

% create the snippet that we want to find 
% set start and end times
% snip is new array of x axis values between time a and time b 
timeA = 7;
timeB = 8;
snip = timeA*Fs:timeB*Fs;
% new array of y axis values that match x values in snip
Fragment = Full_sig(snip);

%plot with fragment highleted
% axis tight plot only goes to limits of data 
figure(1)
subplot (4,1,1)
plot(Time,Full_sig,[timeA timeB;timeA timeB],[m m;M M],'r--')
xlabel('Time (s)')
ylabel('Clean')
axis tight
% plot of just fragment
subplot (4,1,2)
plot(snip/Fs,Fragment)
xlabel('Time (s)')
ylabel('Clean')
title('Fragment')
axis tight

% find and plot the cross-correlation of full signal and fragment
[xCorr,lags] = xcorr(Full_sig,Fragment);

subplot(4,1,3)
plot(lags/Fs,xCorr)
grid
xlabel('Lags (s)')
ylabel('Clean')
axis tight

% replot and overlay fragment
[~,I] = max(abs(xCorr));
maxt = lags(I);

Trial = NaN(size(Full_sig));
Trial(maxt+1:maxt+length(Fragment)) = Fragment;
subplot(4,1,4)
plot(Time,Full_sig,Time,Trial)
xlabel('Time (s)')
ylabel('Clean')
axis tight



